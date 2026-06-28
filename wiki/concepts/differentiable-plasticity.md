---
title: "Differentiable Plasticity"
type: concept
tags: [differentiable-plasticity, meta-learning, synaptic-plasticity, hebbian-learning, in-context-learning, two-timescales]
created: 2026-06-27
updated: 2026-06-27
sources: [brain-inspired-learning-review]
related: [wiki/concepts/meta-learning.md, wiki/concepts/hebbian-learning.md, wiki/concepts/credit-assignment.md, wiki/concepts/neuromodulation.md, wiki/concepts/two-learning-timescales.md, wiki/entities/snn.md, wiki/concepts/continual-learning.md, wiki/papers/brain-inspired-learning-review.md]
---

# Differentiable Plasticity

**Differentiable plasticity is a meta-learning framework where the *parameters governing synaptic update rules* — not the synaptic weights themselves — are optimized by gradient descent through unrolled inner-loop weight dynamics, enabling the network to discover and deploy fast intra-lifetime learning rules.**

---

## Key Equations

**Basic Hebbian inner loop:**
$$\Delta w_{ij} = \eta \cdot x_i \cdot x_j$$

where η is a *meta-learned* plasticity coefficient (one per synapse, or shared across parameter groups).

**Outer loop (meta-optimization via backprop through time):**
$$\eta^* = \arg\min_\eta \; \mathbb{E}_{\text{task}} \left[ \mathcal{L}(\theta(\eta)) \right]$$

where θ(η) are the weights that result from applying the plasticity rule F(η, pre, post) during a task episode. Standard BPTT differentiates through the sequence of weight updates.

**Neuromodulated variants (Miconi et al. 2018):**

| Variant | Update rule | Biological analog |
|---|---|---|
| **Global neuromodulation** | $\Delta w_{ij} = \eta_\text{base} \cdot x_i x_j + \eta_\text{mod} \cdot M(t) \cdot x_i x_j$ | Network-wide signal (arousal, surprise) scales all plastic changes |
| **Retroactive neuromodulation** | $\dot{e}_{ij} = -e_{ij}/\tau + x_i x_j$; $\Delta w_{ij} = \eta_\text{da} \cdot M(t) \cdot e_{ij}$ | Eligibility trace e_ij (synaptic tag) + delayed dopamine-like signal M converts it into a weight change |

The retroactive variant implements three-factor plasticity: pre-activity, post-activity, and a modulatory signal M that arrives asynchronously — the same structure as the biological STDP + dopamine credit assignment solution.

---

## Why This Addresses Gap #4

Gap #4 (biologically plausible slow W) asks for a mechanism that performs cross-environment structural learning with local rules. Differentiable plasticity partially resolves this:

| Phase | Mechanism | Biological plausibility |
|---|---|---|
| **Outer loop (training)** | BPTT through plasticity params η | Not biologically plausible (requires full temporal rollout) |
| **Inner loop (deployment)** | Local Hebbian/neuromodulated update F(η, pre, post) | Fully local; no weight transport; no backward pass |

The outer loop needs BPTT only once (or can be replaced by evolutionary search — ENUs). The deployed system adapts intra-lifetime using *only local synaptic rules* with fixed plasticity coefficients η. This is a viable two-stage pipeline: biologically implausible offline meta-training → biologically plausible online fast adaptation.

**Memory limitation:** BPTT through per-synapse plasticity params costs O(N²T) memory — the primary practical bottleneck. Solutions: parameter sharing across synapse groups (reduces to O(K·T)), or evolutionary search for η (no gradient required).

---

## Instantiations

| System | Plasticity rule | Result |
|---|---|---|
| **Miconi et al. 2018 (ANN)** | Meta-Hebbian with global + retroactive neuromodulation | Sequential associative memory, familiarity detection, robotic noise adaptation after domain shifts |
| **Differentiable STDP in SNNs** | Surrogate-gradient BPTT through spike threshold enables differentiating through spiking plasticity rule | "Learning to learn" on one-shot continual learning and image class recognition |
| **Meta-optimized e-prop** | Third-factor signal optimized via e-prop gradient approximation as the plasticity rule | Meta-form of e-prop with improved biological plausibility |
| **ENUs (Evolvable Neural Units)** | Evolutionary (CMA-ES) search over gating + update rule parameters | Discovers spiking dynamics + RL-type learning rules; solves T-maze; 10× lower memory than differentiable methods |
| **Cartesian genetic programming plasticity** | Evolutionary search over plasticity rule *equations* (not just coefficients) | Automated discovery of task-specific biologically plausible rules |
| **Meta-learned F^bio (Shervani-Tabar & Rosenbaum 2023)** | L1-sparse bilevel meta-optimization over 10 local plasticity terms | Discovers eHebb + Oja; closes FA gap at batch=1; see [[wiki/concepts/credit-assignment.md]] |

---

## Connection to In-Context Learning

Transformers with fixed weights implement a form of intra-lifetime learning via self-attention:

- **Activations-as-weights interpretation:** parameter sharing in meta-learners forces the network to store adapted "weights" inside activation dynamics rather than actual weight matrices. Fixed-W networks with in-context learning converge on computations equivalent to plastic-W networks.
- **Self-attention as gradient descent:** the outer product structure of attention (Q·K^T → softmax → V) mathematically implements learned weight update steps. Mesa-optimization analyses (Akyürek et al. 2022) show transformers implement gradient descent in context.

**Implication:** plastic W and in-context learning are not architecturally distinct — they are two views of the same computation. For reasoning models, this means fast adaptation can be delivered either by explicit Hebbian writes (fast M) or by in-context accumulation in activation dynamics, depending on which is more hardware-efficient.

---

## Self-Referential Meta-Learning

Standard two-level hierarchy:
- Outer loop: meta-learner (fixed after training) optimizes plasticity params η
- Inner loop: plasticity rule F(η, pre, post) adapts weights w

Self-referential extension (Schmidhuber 1993; Irie et al. 2022):
- The meta-learner is itself part of the network and can be modified by the inner loop
- All parameters — weights, plasticity coefficients, even the update rule itself — are subject to self-modification
- In practice: networks discover the optimizer (gradient descent discovers itself) or an evolutionary algorithm optimizes itself
- Implication: arbitrary levels of meta-learning become possible; but generalization degrades when the search space is unconstrained

---

## Generalization Properties

| Learning rule | Generalization vs. backprop | Root cause |
|---|---|---|
| **Full backprop** | Reference (best) | Exact true gradient; finds flattest minima |
| **Backprop-derived local rules** (FA, DFA) | Worse, high variance | Gradient approximation misaligned; step-size scaling does not help; cannot find flat minima |
| **Meta-optimized rules (constrained)** | Comparable to backprop (on training distribution) | Meta-learner finds η that aligns local updates with true gradient for the task distribution |
| **Meta-optimized rules (unconstrained)** | Degrades with search space size | Large plasticity search spaces = underfitting of the meta-learner |

**Key implication:** constrained local plasticity rules (sparse, interpretable η) generalize; unconstrained rules (large search space) overfit the meta-training distribution. This is the same bias-variance tradeoff as in standard ML, applied to learning algorithm discovery.

---

## Open Problems

1. **Memory cost scaling:** per-synapse plasticity coefficients with BPTT through time remains O(N²T); parameter sharing reduces dimensionality but the optimal sharing structure is unknown.
2. **Cross-environment generalization of η:** plasticity coefficients meta-trained on a specific task distribution may not transfer to qualitatively different tasks; analogous to LRM knowledge-boundedness but for the learning algorithm, not the learned content.
3. **Biological timescale mismatch:** retroactive neuromodulation requires the eligibility trace to persist until M arrives; the molecular correlate (synaptic tagging and capture) has a window of ~1–2 hours in biology; computational models typically use τ ≈ 100ms–1s — an order-of-magnitude gap.
4. **Self-referential stability:** recursive self-modification can enter unstable fixed points; the conditions for convergence to a useful self-improvement loop are poorly characterized.

---

## Connections

- **[[wiki/concepts/meta-learning.md]]** — differentiable plasticity is a meta-learning instantiation where the learned object is the *learning algorithm* itself (plasticity rule F + coefficients η), not a task initialization or in-context policy; the outer/inner loop structure is identical but operates in algorithm space rather than weight space.
- **[[wiki/concepts/hebbian-learning.md]]** — differentiable plasticity meta-optimizes the η parameter in Δw ∝ η·x_i·x_j; Oja's rule and eHebb are discovered as components of the optimal meta-learned rule; instability requires parameter sharing or sparsity constraints in the outer loop.
- **[[wiki/concepts/credit-assignment.md]]** — differentiable plasticity provides a new route to biologically plausible credit assignment: the outer-loop BPTT assigns credit to plasticity parameters η, after which the inner loop uses only local updates; this is complementary to EqProp/PC/FA in the taxonomy but occupies a distinct niche (algorithm-discovery rather than gradient approximation).
- **[[wiki/concepts/neuromodulation.md]]** — the retroactive neuromodulation variant is the closest ML analog to the biological three-factor rule (eligibility trace + asynchronous dopamine-like M signal); the global neuromodulation variant maps to non-specific broadcast signals (NA arousal, ACh attention); differentiable plasticity provides a formal derivation of both from a single outer-loop objective.
- **[[wiki/concepts/two-learning-timescales.md]]** — differentiable plasticity implements the two-timescale split at the algorithm level: slow outer loop discovers η (structural, cross-task); fast inner loop applies F(η, pre, post) within an episode; both timescales now operate on the same network rather than requiring separate stores.
- **[[wiki/entities/snn.md]]** — surrogate gradient through the spike threshold extends differentiable plasticity to spiking networks; the resulting differentiable STDP rule achieves one-shot learning in the spiking domain; ENUs discover spiking dynamics from scratch via evolutionary search.
- **[[wiki/concepts/continual-learning.md]]** — differentiable plasticity + retroactive neuromodulation is a partial answer to the metabotropic timescale gap: eligibility traces bridge the fast synaptic event (ms) and delayed reward/modulatory signal (sec), providing an intra-lifetime CL mechanism without explicit task boundary detection.
- **[[wiki/papers/brain-inspired-learning-review.md]]** — primary source for the differentiable plasticity survey, neuromodulation variants, ENUs, self-referential extension, and in-context learning equivalence discussion.
