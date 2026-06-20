---
title: "TEM: Implementation vs Theory — Where Code Diverges from Paper"
type: query
tags: [tem, implementation, path-integration, hebbian-memory, loss-function]
created: 2026-06-10
updated: 2026-06-10 (PyTorch findings added)
sources: [https://github.com/djcrw/generalising-structural-knowledge (tem_tf2), https://github.com/jbakermans/torch_tem (PyTorch, third-party with author guidance)]
related: [wiki/papers/tem-whittington-2020.md, wiki/concepts/path-integration.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/factorized-representations.md]
---

# TEM: Implementation vs Theory

**Question:** How does the TF2 implementation of TEM (`tem_tf2/`) diverge from the theoretical description in Whittington et al. (2020)? What practical compromises or additions were required?

**Source:** `djcrw/generalising-structural-knowledge`, `tem_tf2/` directory (TF2 version; the cleaner, recommended implementation).

---

## Answer

Six substantive divergences were found. They fall into two categories: approximations forced by practical constraints, and additions not present in the paper at all.

---

### 1. Transition matrices via MLP, not ring attractors

**Theory:** The paper inherits continuous attractor dynamics from the grid cell literature — `g` is updated by a transition operator `T_a` that smoothly shifts a bump of activity along a continuous manifold.

**Code:** `t_vec` is a 2-layer MLP mapping action vectors to `g_size²` parameters, reshaped into a linear transition matrix. Each discrete action gets its own learned matrix. Hierarchical masking constrains which elements are non-zero per frequency band.

**Why it matters:** This is a discrete, learned linear map, not a continuous attractor. The ring-attractor picture is entirely absent. The practical reason is that backprop-trained discrete transitions are far more tractable; continuous attractor dynamics require careful tuning of lateral connectivity to maintain stability, which does not interact well with gradient descent. Grid-cell-like structure must emerge as an efficient solution to the transition statistics, not from attractor initialization.

---

### 2. Hebbian matrix via scalar product trick — never materialized

**Theory:** M is an `n×n` Hebbian matrix updated by `M ← M + p_t · p_{t+1}^T` (outer product), where n is the number of place cells. Retrieval: `p_retrieved = M @ x_query`.

**Code:** M is never stored as an explicit matrix. Instead, two vector sequences `a` and `b` are maintained. The attractor update computes `b^T @ p` (inner product), then `a @ result` — equivalent to the full M operation but O(n) in memory rather than O(n²). Memory entries are additionally scaled by `sqrt(eta * h_l)` (justified by the bilinear structure of the update) and clipped to `[-hebb_lim, hebb_lim]`. Forgetting uses `(scaling.forget × λ)^mem_seq_len` with λ = 0.9999.

**Why it matters:** The "Hebbian weights" described in the paper as a synaptic matrix are never stored or computed as such. The scalar product trick is mathematically equivalent for the operations TEM needs but reveals that the memory capacity properties of M (and any analysis of it as a matrix) don't directly transfer to how the model is actually run.

---

### 3. Three reconstruction losses, not one

**Theory:** TEM is described as minimizing prediction error: the model predicts the next sensory observation and updates W on the mismatch.

**Code:** Three separate cross-entropy losses are applied simultaneously:
- `lx_p` — reconstruction of `x` from the **inferred** place cell `p` (inference path: `x_{t+1}` → `M` → `p` → `x̂`)
- `lx_g` — reconstruction of `x` from the **grid-generated** place cell `p_gen` (generative path: `g_{t+1}` * `x` → `p_gen` → `x̂`)
- `lx_gt` — reconstruction of `x` from the **prior** grid `g_prior` (prior path, no sensory input)

All use sparse softmax cross-entropy (implying discrete/one-hot sensory observations, not continuous embeddings). Losses are masked by `s_visited` (first-visit states have no stored memory to retrieve, so their inference loss is masked out).

**Why it matters:** The paper's single "prediction error" actually decomposes into three objectives that train different pathways. `lx_p` trains the memory retrieval path; `lx_g` trains the generative/structural path; `lx_gt` trains the prior (transition structure alone). This decomposition is what forces the model to maintain factorized representations — the prior loss specifically must be predictive using only `g`, preventing collapse.

---

### 4. Sensory temporal filtering — not in paper

**Theory:** Sensory input `x_t` is the observation at node `t`. No temporal smoothing is described.

**Code:** Each frequency band applies frequency-specific exponential smoothing:
```
x_filtered[f] = a[f] * x_prev[f] + x * (1 - a[f])
```
where `a[f] = sigmoid(gamma[f])`, and `gamma` is initialized as `log(freq / (1-freq))` (inverse sigmoid of the frequency parameter). An option `smooth_only_on_movement` applies filtering only when the agent moves.

This is a purely implementation-side addition. The rationale is likely to reduce training instability from sharp observation switches, but it also introduces a form of recency-weighted sensory memory that has no theoretical counterpart.

---

### 5. Grid regularization effectively disabled throughout training

**Theory:** The paper does not discuss regularization schedules in detail.

**Code (parameters.py):** Grid cell L2 regularization has an annealing schedule of **40,000,000 gradient steps**. Total training is **2,000,000 steps**. This means grid regularization is never meaningfully applied — the weight stays near zero for the entire run.

By contrast, place cell L1 sparsity regularization anneals over 4,000,000 steps, so it is active and then slowly fades during the first ~20% of training before becoming negligible.

**Why it matters:** The emergent grid-cell structure in `g` is not pushed toward any geometric regularity by explicit regularization. It arises purely from the need to solve the transition-prediction task. The effective regularizer is task structure, not a regularization penalty.

---

### 6. No KL divergence despite variational framing

**Theory:** TEM is presented with a generative-model / ELBO-like formulation. Inferred distributions over `g` (inference network) should be regularized toward the prior via a KL divergence term.

**Code:** Both inference and prior distributions have learned `mu` and `logsig` parameters. The `combine2` function implements a Gaussian product (precision-weighted combination) during inference. However, no KL divergence term appears in the loss. The variational interpretation is present only in the inference structure; the training objective is purely reconstruction-based with implicit regularization via `lx_gt` (which forces the prior path to be predictive on its own).

---

---

## PyTorch Implementation (jbakermans/torch_tem) — Additional Findings

> **Caveat:** this is a third-party reimplementation (not by the paper's authors), done with guidance from James Whittington. Treat deviations from TF2 as architectural choices by the reimplementor unless explicitly attributed to the author.

Three findings here that add to or clarify the TF2 picture.

---

### A. Difference coding for `g` — author-recommended, not in paper

**Code comment (verbatim):** *"Not in the paper, but recommended by James for stability: use inferred code as difference in abstract location."*

**Mechanism:** Instead of `g_{t+1} = MLP(g_t, a_t)` (direct prediction), the transition computes a delta: `g_{t+1} = g_t + MLP_D_a(g_t, a_t)`. The MLP predicts a *change* in abstract position, not the next position outright.

**Why it matters:** This is a direct communication from Whittington not present in the published paper. Predicting differences rather than absolute states is a standard stabilization technique in RNN training (residual/skip connections share the same intuition: bias toward small updates, preserve existing state). Its absence from the paper means the ring-attractor / continuous dynamics framing is even further from the implementation than the TF2 analysis suggested — not only is there no attractor, the transition isn't even a direct state prediction.

---

### B. Hebbian update formula diverges from paper in both implementations

**Paper:** `M ← λ·M + η · p_t · p_{t+1}^T` (simple outer product of consecutive place codes)

**PyTorch:** `M ← λ·M + η · (p_inf + p_gen) ⊗ (p_inf - p_gen)`

Expanding: `(p_inf + p_gen)(p_inf - p_gen)^T = p_inf p_inf^T − p_inf p_gen^T + p_gen p_inf^T − p_gen p_gen^T`. This is not equivalent to `p_t p_{t+1}^T`; it has a contrastive structure where the self-outer-products (p_inf·p_inf^T and p_gen·p_gen^T) partially cancel. The practical effect is to strengthen associations between inferred and generated codes while suppressing pure auto-associations of either alone.

**TF2:** Uses the scalar product trick (see finding 2 above) — never materializes M at all.

**Why it matters:** The two implementations use *different* update formulas, and neither matches the paper literally. The outer product `p_t p_{t+1}^T` from the paper is an idealization; the actual formula needed for stable training involves the relationship between inferred and generated place codes rather than consecutive timestep codes.

---

### C. Explicit matrix storage confirms TF2 scalar trick is an optimization, not fundamental

PyTorch stores M as a full `(batch_size, Σn_p, Σn_p)` matrix, explicitly. This confirms that the TF2 scalar product trick (storing factored `a`/`b` vectors) was a memory-efficiency optimization specific to the TF2 implementation — not a conceptual model choice. The two are mathematically equivalent for the operations TEM requires.

---

## Summary Table

| Aspect | Paper | Code (tem_tf2) |
|--------|-------|----------------|
| `g` transition | Continuous attractor dynamics | MLP → matrix (TF2); MLP → delta/difference (PyTorch†) |
| Hebbian update formula | `p_t · p_{t+1}^T` outer product | TF2: scalar product trick (factored form); PyTorch: `(p_inf+p_gen)⊗(p_inf−p_gen)` |
| Hebbian M storage | Explicit n×n matrix | TF2: scalar product trick (never materialized); PyTorch: explicit full matrix |
| Training objective | Prediction error | 3 reconstruction losses (TF2); 8 losses incl. squared error on p and g (PyTorch) |
| Sensory input | Instantaneous observation | Exponentially smoothed per frequency band (both implementations) |
| Grid regularization | — | Nominally L2, but annealing = 40M >> 2M steps → effectively off |
| Variational objective | ELBO with KL divergence | Reconstruction only; no explicit KL term (both implementations) |

† Author-recommended but not in paper: PyTorch uses difference/residual coding `g_{t+1} = g_t + Δ`.

---

## Implications

- The ring-attractor picture of grid cells is a **post-hoc biological analogy**, not a computational mechanism in TEM. Structural generalization in the code arises entirely from the learned transition matrices and the three-way loss factorization.
- The scalar product trick means the model's episodic memory capacity scales linearly (in storage) with sequence length, not quadratically with place cell count — important if scaling TEM.
- The three-loss decomposition is arguably the most important implementation insight: it is what actually enforces the factorization. A single prediction error loss would not prevent the model from encoding everything in M.

## Follow-up Questions

- Does the prior reconstruction loss `lx_gt` alone account for the grid-cell emergence, or does the multi-scale transition matrix structure matter more?
- How does the scalar product trick interact with the attractor dynamics — do the `a`/`b` vectors converge to something interpretable?
- What would happen if the grid regularization were actually applied throughout training?
