---
title: "Building Blocks for MEC/HC/PFC Brain-Inspired Model"
type: query
tags: [building-blocks, architecture, MEC, hippocampus, PFC, path-integration, associative-memory, working-memory, hierarchy]
created: 2026-06-14
updated: 2026-06-19 (3)
sources: []
related: [wiki/entities/tem-model.md, wiki/concepts/factorized-representations.md, wiki/concepts/path-integration.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/engrams.md, wiki/concepts/attention.md, wiki/concepts/neuromodulation.md, wiki/concepts/meta-learning.md, wiki/concepts/working-memory.md, wiki/concepts/cognitive-control.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/htm-thousand-brains.md, wiki/concepts/ring-attractor.md, wiki/entities/tiwm-model.md, wiki/concepts/latent-graph-discovery.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/trnn-liu-2025.md, wiki/papers/pfc-cognitive-control-friedman-2021.md, wiki/entities/prefrontal-cortex.md, wiki/papers/pfc-wood-grafman-2003.md]
---

# Building Blocks for MEC/HC/PFC Brain-Inspired Model

**Question:** For a brain-inspired reasoning model focused on MEC/HC and PFC, what are the minimal functional building blocks, what ML tools exist for each, and where are the gaps?

---

## Framework

Decompose biology into independent functional units. For each: what the biology does, what TEM (current reference) implements, what ML has available, and how to bridge the gap.

---

## Region 1: MEC — The Structural Coordinate Engine

### Block 1A: Grid-Code Substrate (the `g` manifold)

| Aspect | Detail |
|---|---|
| **Biology** | Grid cells fire on a hexagonal lattice; periodic, multi-scale, toroidal. The same coordinate system tiles every environment with only a phase shift. Manifold is T² (2-torus). |
| **TEM** | `g` is an unconstrained continuous vector; grid structure *emerges* from training objective — not built in. Requires many training environments to rediscover. |
| **Available in ML** | Toroidal parameterization; plane-wave / Fourier basis initialization; cosine-connectivity CANN; grid-cell induction via place-cell supervision |
| **Gap** | TEM relies on emergence; a model initializing `g` on the right manifold would be data-efficient and provably periodic. |
| **Bridge** | Parameterize `g` as K oscillatory pairs: `g = [(cos θ₁, sin θ₁), ..., (cos θ_K, sin θ_K)]`. Each pair = one grid scale. This is the VCO model as an inductive bias — build in what TEM must discover. |

### Block 1B: Path Integration Update (the `g` dynamics)

| Aspect | Detail |
|---|---|
| **Biology** | P-EN neurons receive a **continuous velocity vector** and shift the grid bump proportionally. Recurrent connectivity is fixed (ring structure); velocity is the only update signal. Action is continuous, not discrete. |
| **TEM** | `g_{t+1} = f(W g_t + B a_t)` where `a_t` is a **discrete action index** selecting a column of W. Hard discretization of continuous velocity; closed vocabulary; no generalization to novel action magnitudes. |
| **Available in ML** | CANN with cosine connectivity; Neural ODE `dg/dt = f(g, v)`; learned RNN with ring constraint; torus RNN; Lie group rotation; KAN-ODE (KAN as gradient-getter — N⁻⁴ parameter scaling vs. N⁻² for MLP-Neural ODE; optional symbolic regression post-processing to recover governing equations) |
| **Gap** | (1) Continuity: discrete label → continuous vector. (2) Ring structure: learned rather than imposed by recurrent connectivity. |
| **Bridge** | Replace `W(a)` lookup with continuous rotation: `g_{t+1} = normalize(g_t + R(v_t) · g_t)` where `R(v_t)` is a learned skew-symmetric (SO(N)) matrix conditioned on action vector `v_t`. Maintains manifold constraint exactly; handles continuous and novel action magnitudes. |

### Block 1C: Landmark Correction / Drift Reset

| Aspect | Detail |
|---|---|
| **Biology** | Ring neurons relay visual landmarks → anchor E-PG bump. When landmarks are available, K ≈ 1 (landmark completely overrides self-motion). Kalman filter: prediction (P-EN) + correction (ring neuron). |
| **TEM** | No explicit landmark correction. W-based path integration accumulates drift without reset. |
| **Available in ML** | Cross-attention from x to stored (g, x) pairs; Kalman filter update; learned correction RNN |
| **Gap** | Implicit correction via M retrieval fails in novel environments with empty M. |
| **Bridge** | Explicit correction step: `g_corrected = g_pred + K · (g_landmark - g_pred)` where `g_landmark` = cross-attention from current `x` to stored (g, x) pairs and `K` is a learned reliability gate. |

---

## Region 2: HC — Fast Binding and Memory

### Block 2A: Conjunctive Code (p = f(g, x))

| Aspect | Detail |
|---|---|
| **Biology** | Place cells = sparse outer product of MEC (g) and LEC (x). Bidirectional: g→x (path integration → recall what's here) and x→g (landmark → recall where I am). |
| **TEM** | `p = flatten(x̃ᵀ g̃)`. Retrieval is g→x only (given current position, predict sensory content). |
| **Gap** | x→g direction missing. No "where am I given what I see?" |
| **Bridge** | Add reverse attention: `g_retrieved = softmax(x_query · X^T) · G` where X, G are stored sensory and structural memories. This enables place recognition and completes the landmark correction loop (Block 1C). |

### Block 2B: Associative Memory Capacity and Pattern Completion (CA3)

**The biggest TEM compromise.** This is what the user means by "attractor network vs. brain's associative memory with much bigger capacity."

| Aspect | Detail |
|---|---|
| **Biology** | CA3 is a recurrent autoassociative network with ~9–11% pyramidal-to-pyramidal connectivity (Sammons 2023: 8.8% functional, 11.2% structural — ~10× above prior estimates). Random connectivity at this rate is sufficient for pattern completion; no special motif enrichment required. Pattern size M and connectivity c satisfy c × M ≈ const, setting the minimum assembly size at any given connectivity. Capacity scales exponentially with feature dimension for sparse codes. Critical property: **pattern completion** — a partial/noisy cue converges to a stored attractor via recurrent dynamics (2-10 steps). CA3 also chains temporal sequences via asymmetric STDP. |
| **TEM (linear Hopfield)** | Capacity O(N/log N). Single linear readout — no iterative completion; a degraded cue returns a degraded response, not a completed one. |
| **TEM-t (modern Hopfield / softmax)** | Capacity O(exp(d)) — biologically realistic. Still single-pass, no iterative convergence within retrieval. |
| **Available in ML** | Modern Hopfield (Ramsauer 2020); sparse Hopfield (capacity scales with sparsity); Kanerva SDM (biological DG→CA3 analog); temporal/asymmetric Hopfield for sequences |
| **Gap** | **(a)** Sparsity not enforced — TEM writes dense p; biology writes 2-6% sparse. **(b)** No iterative completion — TEM reads once; CA3 runs recurrent steps until convergence. **(c)** No temporal chaining — STDP-trained asymmetric connections let CA3 replay next-state transitions. |
| **Bridge** | (a) Top-k sparse write: keep top 5% of p activations, zero rest (straight-through estimator for gradients). (b) Iterative completion: run 2-3 modern Hopfield update steps before final readout. (c) Temporal STDP: asymmetric write `M ← M + η · (p_t ⊗ p_{t+1})` alongside symmetric binding — encodes "what comes next" as well as "what is here." |

### Block 2C: Importance-Based Write Gate (SWR Bookmarking)

**The "importance-based memorization" compromise.**

| Aspect | Detail |
|---|---|
| **Biology** | Awake SWRs occur preferentially after rewards and at decision points — selectively replay and prime the most important recent trajectories. Not every experience is consolidated. Importance ≈ prediction error + reward signal. |
| **TEM** | Writes every (g, x) pair to M at every timestep with equal weight. No selection. |
| **Available in ML** | Prioritized experience replay (TD error); surprise-based memory allocation; NTM/DNC write gate |
| **Gap** | No differentiable approximation of selective SWR bookmarking. |
| **Bridge** | Gated write: `M ← M + η · σ(prediction_error_t) · p_t`. Prediction error = `||x_predicted - x_observed||`. Surprising observations get stronger binding; redundant ones are down-weighted. For offline consolidation: periodic replay phase where stored high-error trajectories are re-replayed for W update (no new M writes during this phase). **Biological grounding (Doya 2002, [[wiki/concepts/neuromodulation.md]]):** ACh = learning rate α; novelty/surprise elevates ACh (basal forebrain) → storage mode; familiarity lowers ACh → retrieval mode. The prediction error gate approximates this ACh signal. |

### Block 2D: Engram Allocation — Sparse Competitive Write

| Aspect | Detail |
|---|---|
| **Biology** | Excitability competition: most excitable neurons win allocation; lateral inhibition enforces homeostatic sparsity (2-6% DG). The same E/I mechanism governs both encoding allocation and replay selection (SWR). |
| **TEM** | No allocation competition; dense uniform write. |
| **Bridge** | Top-k sparse activation before write: `p_write = top_k(p, k = 0.05·N)`. Combined with Block 2C: only surprising experiences write to M, and only the most active units within those experiences get bound. This is the biological softmax made differentiable. |

---

## Region 3: PFC — Inference, Hierarchy, and Goals

### Block 3A: Transformation Inferrer (Inverse Path Integration)

**The critical missing capability — not in TEM at all.**

| Aspect | Detail |
|---|---|
| **Biology** | TBT's L5→L6 efference copy: column compares predicted next state (L6) to actual sensory input (L4) → infers what transformation occurred. Generalized: PFC observes (state_before, state_after) pairs and infers abstract transformation. vmPFC applies structural codes to abstract decision spaces. |
| **TEM** | Cannot infer transformations — `a_t` is always externally given. TEM is forward-only. This blocks all Type 2 tasks (ARC-AGI, analogy, rule induction). |
| **Available in ML** | Neural Processes (posterior over functions from context pairs); set transformers; few-shot learning; in-context learning in LLMs |
| **Gap** | No existing module cleanly computes: given K example pairs (g_in, g_out), return a posterior over the W vocabulary. |
| **Bridge** | Set-attention Transformation Inferrer (TIWM — see [[wiki/entities/tiwm-model.md]]): input = `{Δg_i = g_out_i - g_in_i}` for i=1..K; output = soft posterior `q(a)` via cross-attention from Δg vectors to W columns. W is jointly optimized by forward model (path integration) and this inverse model — shared transformation vocabulary. With K=1: high uncertainty; with K≥3: sharp posterior concentrates on unique consistent transformation. |

### Block 3B: Working Memory / Context Maintenance (DLPFC)

| Aspect | Detail |
|---|---|
| **Biology** | Sustained L3 firing maintains ~3-5 active representations for seconds to minutes. Dopamine D1 stabilizes (maintain), D2 destabilizes (update). PV interneurons gate access. Empirically: majority of PFC delay-period neurons show *transient*, not persistent, activity (Stokes 2013). |
| **TEM** | Context window only (TEM-t's sequential attention). No explicit maintenance or gating. |
| **Available in ML** | LSTM gates; transformer context; SSMs (Mamba, S4); **TRNN** (self-inhibiting sparse hierarchical RNN) |
| **Gap** | Dopamine-like stability/flexibility dial has no ML analog — LSTM gate is learned but fixed per context. |
| **Bridge — Two options (not mutually exclusive):** | |
| *Option A (meta-RL context):* | **Wang et al. 2018 ([[wiki/concepts/meta-learning.md]]):** Full LSTM whose recurrent hidden state implements a within-episode RL algorithm. Weights fixed at meta-training; WM = hidden state. Best for tasks requiring policy/value estimation across trials. Requires meta-RL outer loop. |
| *Option B (high-capacity WM):* | **TRNN ([[wiki/papers/trnn-liu-2025.md]]; [[wiki/entities/trnn-model.md]]; [[wiki/concepts/working-memory.md]]):** Self-inhibition + sparse connections + hierarchical topology. No write step; memory in sequential neuron chain dynamics. Outperforms vanilla LSTM on: multi-item capacity, spatial navigation WM, distractor robustness. Best for maintaining multiple independent items or spatial context. γ hyperparameter = D1/D2 neuromodulation dial. |
| **Recommendation:** | Use TRNN ([[wiki/entities/trnn-model.md]]) for the fast episodic WM layer (Block 3B mechanism); stack meta-RL LSTM above it for policy/context tracking if tasks require within-episode RL. TRNN handles "what is currently in the workspace" (short-term, high-capacity); LSTM handles "what strategy am I running" (slower, lower-capacity). **Biological grounding:** DLPFC transient activity = TRNN; PFC LSTM = meta-level context. |

### Block 3C: Hierarchical Abstraction Stack

| Aspect | Detail |
|---|---|
| **Biology** | PFC rostro-caudal gradient (Friedman & Robbins 2021 — TMS-causal, lesion, fMRI confirmed): **Caudal PFC (BA-8)** = stimulus-response conditional mapping (which action for this cue); **Mid-lateral PFC (BA-9/46)** = contextual rule maintenance + n-back monitoring (maintain task-set context; resist interference); **Frontopolar PFC (BA-10)** = branching rule contingencies operating on rules held in WM (sequential subgoal management). Mid-lateral is the *hub*: integrates caudal (sensory context) and frontopolar (mnemonic rule-of-rules) signals. L5 output of column N → L4 input of column N+1 (TBT). **SEC framework (Wood & Grafman 2003):** PFC stores Structured Event Complexes — goal-oriented, grammatically-structured temporal event sequences encoding rules and abstractions. Anterior-posterior SEC complexity gradient (frontopolar = long multi-event SECs; caudal = short single-event) corroborates rule-nesting gradient: both map the same rostro-caudal axis. Together they argue W_rule-of-rules should encode a *grammar over event sequences* (not just a rule label), with lower W levels sampling episodes from that grammar. |
| **TEM** | Flat: one level of g/x/p. Cannot represent compositional rule chains (apply rule A, get context for rule B). |
| **Available in ML** | Multi-layer transformers (implicit, non-gated); hierarchical RL (options); hierarchical VAE; hierarchical SSMs |
| **Gap** | Standard multi-layer transformers lack the explicit gating where the higher level controls the W context for the lower level. |
| **Bridge** | **Three-level TEM stack** (justified by three distinct PFC levels, not two): W_rule-of-rules (frontopolar, slowest, one update per task-class: what grammar/rule-family?) → W_context (mid-lateral, per-episode: which rule within that family, maintained vs. switched) → W_instance (caudal, per-timestep: which specific stimulus-response mapping?). Mid-lateral W_context is the hub that integrates the other two. This replaces the previous two-level sketch; the biological evidence supports three levels. |

### Block 3D: Goal / Error Generator

| Aspect | Detail |
|---|---|
| **Biology** | vmPFC encodes goal value; ACC monitors goal-current conflict; PFL neurons (CX) implement: heading_error = goal_heading − current_heading → action output. |
| **TEM** | No goal representation or action generation. |
| **Bridge** | In g-space: goal = `g_goal`; action = the W column that minimizes `||f(W g_current, a) - g_goal||`. For the reasoning case: goal = target observation; action = inferred transformation (Block 3A already provides this when given before/after pairs). Goal-conditioned generation unifies with the Transformation Inferrer. |

---

## Consolidated Summary Table

| Block | Biology | TEM Gap | ML Bridge | Difficulty |
|---|---|---|---|---|
| **1A: Grid substrate** | T² toroidal, periodic | Emerges slowly; unconstrained | Parameterize g as oscillatory pairs on torus | Low |
| **1B: Path integration** | Continuous velocity drive on CANN | Discrete W(a); closed action set | Continuous SO(N) rotation conditioned on v_t | Medium |
| **1C: Landmark correction** | Ring neuron Kalman update | No explicit correction | Cross-attention x→(g,x) pairs; learned K gate | Medium |
| **2A: Bidirectional binding** | g→x and x→g retrieval | g→x only | Add reverse attention: x→g retrieval | Low |
| **2B: Pattern completion** | CA3 iterative attractor; exp(d) capacity | Single linear readout; O(N/log N) | Iterative modern Hopfield (2-3 steps) | Low |
| **2C: Importance gate** | SWR post-reward bookmarking | Uniform write | Surprise-gated write: η · σ(prediction_error) | Low-Medium |
| **2D: Sparse allocation** | 2-6% excitability competition | Dense write | Top-k sparse write with straight-through | Low |
| **3A: Transformation inferrer** | TBT efference copy inversion; PFC | **Absent** | Set-attention over Δg → W posterior | High |
| **3B: Working memory gate** | DLPFC dopamine D1/D2 gating; transient delay activity | Context window only | [[wiki/entities/trnn-model.md]] (high-capacity episodic) + meta-RL LSTM (policy context) | Medium |
| **3C: Hierarchical stack** | Rostro-caudal PFC (BA-8/9-46/10); TBT column hierarchy | Flat single-level | **Three-level** W: W_rule-of-rules (BA-10) → W_context (BA-9/46 hub) → W_instance (BA-8) | High |
| **3D: Goal generator** | vmPFC/PFL heading error → action | Absent | Argmin over W vocabulary toward g_goal | Medium |

---

## Priority Order

**Do first (low difficulty, high impact on stated TEM limitations):**
1. **Block 2C + 2D** — importance-gated + sparse write. Directly fixes "importance-based memorization" complaint. One surgical change to the Hebbian write step.
2. **Block 2B** — iterative modern Hopfield. Directly fixes "attractor network vs. bigger-capacity associative memory" complaint. Already started in TEM-t; just add unrolled iterative steps.
3. **Block 1A + 1B** — toroidal g + continuous action update. Directly fixes "W matrix for g transformation by action a" complaint. Replaces the discrete W(a) vocabulary with a continuous SO(N) rotation.

**Do next (medium difficulty, required for robustness):**
4. **Block 1C** — landmark correction. Needed for new-environment robustness (empty M gives no correction feedback).
5. **Block 2A** — bidirectional binding. Needed for place recognition (x→g direction).

**Do last (high difficulty, required for Type 2 tasks):**
6. **Block 3A** — Transformation Inferrer. Architecturally novel; prerequisite for ARC-AGI / rule-induction tasks.
7. **Block 3C** — Hierarchical stack. Required for compositional rule chains.

---

## Follow-Up Questions

- What training objective drives factorization of g and x *without* anatomical separation? (Contrastive invariance? Reconstruction decomposition?)
- Can the Block 1B continuous rotation (SO(N) conditioned on v) be pre-trained on spatial navigation, then transferred to abstract domains by fine-tuning only the v→R(v) map?
- Is the Block 3A Transformation Inferrer's attention over Δg difference vectors sufficient for multi-step transformations (A→B→C), or does it need iterative inference to handle transformation chains?
- What is the minimum number of hierarchical levels (Block 3C) needed to solve ARC-AGI benchmark tasks — are two levels (meta + instance) sufficient, or does the observed complexity require three?
