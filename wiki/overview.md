---
title: "Overview — Brain-Inspired Models for Abstract Reasoning"
type: overview
tags: [overview, abstract-reasoning, brain-inspired-ai]
updated: 2026-06-20
sources: [TEM.pdf, cognitivemap.md, gridlikecode.md, t-TEM.md, engram-transcript, cross-entropy-first-principles-transcript, free-energy-principle-transcript, brain-learning-algorithm-transcript, brain-learning-limits-transcript, memory-gate-transcript, 150000-mini-brain-transcript, convergence-wiring-transcript, bolzman-machine-transcript, reservoir-computing-transcript, jumping-spiders-cognition, landmark-orientation.md, convergent-brain-structures-transcript, metalearning-neuromodulation-doya-2002, pfc-meta-rl-wang-2018, pbwm-oreilly-frank-2006, compositionality-decomposed-hupkes-2020, mlc-lake-baroni-2023, trnn-liu-2025, stsp-kozachkov-2022, transformer-wm-limit-gong-2024, pfc-cognitive-control-friedman-2021, pfc-wood-grafman-2003, arc-agi-overview, arc-agi-3-paper, hopfield-networks-crouse-2022, ca3-sammons-2023, pattern-completion-rolls-2013, cls-oreilly-2011, cls-mcclelland-1995, podlaski-context-modular-memory-2025, learning-fast-slow-liao-2024, building-machine-thinks-like-people-lake-2016, analogy-holyoak-2012, ahmad-hawkins-sdr-2016, yassa-stark-pattern-separation-2011, dicarlo-visual-object-recognition-2012, gerfen-surmeier-dopamine-striatum-2011, helie-ccn-bg-2013, bogacz-gurney-bg-msprt-2007]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/predictive-coding.md, wiki/concepts/neural-manifolds.md, wiki/concepts/neuromodulation.md, wiki/concepts/meta-learning.md, wiki/concepts/working-memory.md, wiki/concepts/cognitive-control.md, wiki/concepts/compositional-generalization.md, wiki/concepts/convergent-allocentric-coding.md, wiki/entities/tem-model.md, wiki/entities/tiwm-model.md, wiki/entities/arc-agi.md, wiki/entities/basal-ganglia.md, wiki/entities/prefrontal-cortex.md]
---

# Overview — Brain-Inspired Models for Abstract Reasoning

---

## The Central Thesis

Current deep learning fails at out-of-distribution systematic generalization. Biological brains do not. The hypothesis: the brain treats all reasoning as **latent graph discovery** — infer the hidden relational structure of a domain from observations, then navigate it. The key architectural principle enabling this is **factorization of structural knowledge from sensory content**, extended by a BG/PFC control layer that gates, modulates, and hierarchically structures the inference process.

---

## Master Problem Framing: Latent Graph Discovery

> **Latent graph discovery = infer the structure (nodes, edges, topology) of a relational graph from observations, then navigate it — where the graph is never given explicitly.**

Every cognitive task reduces to which graph component is hidden:

| Latent component | Observed | Canonical examples |
|---|---|---|
| **Edges** (transformation rules) | Start + end node pairs | ARC-AGI, IQ tests, analogy tasks |
| **Path** (sequence of edges) | Start + end nodes | Navigation, planning |
| **Node content** (partial state) | Path + partial content | Algebra, physics, constraint satisfaction |
| **Graph topology + edges** | Observations only | Scientific discovery, causal learning |

Every domain has a **two-level hierarchy**: a slow meta-graph (shared rules across episodes) and a fast instance-graph (task-specific topology). Systems that conflate these levels must relearn rules from scratch for every new problem. The W/M two-timescale split ([[wiki/concepts/two-learning-timescales.md]]) is the direct computational implementation: W = meta-graph, M = instance-graph.

**Primary empirical target:** ARC-AGI — latent edge discovery from sparse (before, after) grid pairs. No current architecture solves it reliably. ARC-AGI-3 extends this to interactive agents that must also discover the target goal.

---

## Current Best Understanding

### Five Core Architectural Principles

| # | Principle | Brain substrate | Why needed |
|---|-----------|----------------|------------|
| 1 | **Factorize structural code from sensory code** | g (MEC) vs. x (LEC) | Structure W generalizes; content stays environment-specific. Without factorization, relational generalization lies outside the model's reachable manifold — structurally impossible regardless of training |
| 2 | **Maintain latent states via path integration** | HC / g-update RNN | De-alias observations; compress rule learning to O(relation types) not O(transitions) |
| 3 | **Two-timescale learning** | Slow W (cortex/MEC) + fast Hebbian M (HC) | Slow W builds shared meta-graph; fast M stores episode-specific instance-graph |
| 4 | **Gate and modulate via BG/neuromodulation** | Basal ganglia + DA/ACh/5-HT/NA | Credit assignment: D1→LTP (Go), D2→LTD (NoGo) from a single phasic DA event; ACh gates storage vs. retrieval |
| 5 | **Hierarchical control** | PFC rostro-caudal gradient (BA-8 → BA-9/46 → BA-10) | Rules about rules: lower levels handle stimulus-response; mid-lateral maintains task-set context; frontopolar manages branching rule chains |

### Key Unification Results

- **TEM = transformer** — the factorized key/value structure (Q=K=f(g), V=f(x)) follows necessarily from the outer-product memory; Hopfield ↔ attention is grounded in the Boltzmann distribution (softmax IS P ∝ exp(−E/T))
- **Grid cells = SR eigenvectors = optimal path-integration bases** — the periodic grid code is optimal for graph matching and multi-step planning via the same mechanism
- **Place cells = SR rows = p = f(g, x)** — "anomalous" HC cells (splitter, lap, evidence) are the same model with hidden task dimensions added to the graph
- **FEP grounds TEM's objective** — the two-timescale training objective (slow W, fast M) is the factorized ELBO; all cross-entropy training is Bayesian brain inference
- **D1/D2 opponent plasticity = cellular credit assignment** — a single phasic DA event simultaneously drives PKA→LTP in direct (Go) SPNs and EC→CB1→LTD in indirect (NoGo) SPNs; credit assignment in the brain is structurally opponent, not scalar. PD as natural experiment confirms this
- **PVLV implements this biologically** — DA drives slow W update; ACh gates the M write/read switch; NA sets exploration breadth; 5-HT sets planning horizon

### The Learning Algorithm Lineage

```
Hopfield (1982)
  ↓ deterministic; memorization only; no generative capacity
Boltzmann Machine (1985)
  ↓ stochastic; learns P(data); intractable Z = Σ exp(−E/T)
Predictive Coding / FEP
  ↓ local error propagation; replaces Z with tractable F = −ELBO
TEM (2020) / TEM-t (2022)
  ↓ factorized ELBO; cross-environment structural transfer; emergent grid/place cells
TIWM (proposed)
  ↓ adds inverse path integrator: infer latent edge labels from (g_in, g_out) pairs
```

### Architecture Determines Feasibility

Neural manifold constraints ([[wiki/concepts/neural-manifolds.md]]) make this an architectural necessity, not an efficiency preference:

- Standard transformer: abstract relational generalization **outside its intrinsic manifold** — unreachable regardless of training or scale
- TEM's g/x factorization: relational generalization **inside its reachable manifold by construction**
- LLMs/LRMs: knowledge-bounded — in-context fast loop cannot generalize beyond pretraining distribution to genuinely novel graph structures (McClelland 1995 theorem instantiation)

### The W/M Split Spectrum

| Model | Structural basis (W) | Task-specific code (M) | Timescale |
|---|---|---|---|
| Reservoir computing | Random, frozen | Linear readout, one-shot | W never trained |
| TEM | Slow backprop across environments | Hebbian, per-environment | W: slow; M: fast |
| Standard DNN | Jointly trained (entangled) | None (no factorization) | Single timescale |
| Meta-RL LSTM (Wang 2018) | Outer-loop weights = slow W | Hidden state = fast M policy | W: meta-training; M: within-episode |

### The Extended Architecture: 11 Functional Blocks

The full model decomposes into three regions (see [[wiki/queries/building-blocks-mec-hc-pfc.md]]):

**MEC (structural engine):** 1A Grid substrate (toroidal g) → 1B Path integration (continuous SO(N) rotation) → 1C Landmark correction (Kalman update)

**HC (fast binding):** 2A Bidirectional binding (g↔x) → 2B Pattern completion (iterative modern Hopfield) → 2C Importance gate (SWR/prediction-error write) → 2D Sparse allocation (top-k engram)

**PFC (hierarchy and goals):** 3A Transformation Inferrer — **critical missing block** (inverse path integrator; set-attention over Δg → W posterior) → 3B Working memory (TRNN episodic + meta-RL LSTM policy) → 3C Hierarchical stack (three-level: BA-10 → BA-9/46 hub → BA-8) → 3D Goal generator (g_goal → argmin W)

### Convergent Evolution: Strongest Empirical Argument

At least 5–6 independent evolutionary lineages ([[wiki/concepts/convergent-allocentric-coding.md]]) derive the same **expansion → compression** circuit for allocentric world modeling:

| System | Expansion | Compression | Est. age |
|---|---|---|---|
| Vertebrate HC | Dentate gyrus | CA3 autoassociation | ~500 Mya |
| Insect Central Complex | Ellipsoid body ring | Fan-shape body | >400 Mya |
| Arthropod mushroom body | Kenyon cells | MBONs | >500 Mya |
| Cephalopod vertical lobe | Amacrine cells | Large-field cells | ~500 Mya |
| Crustacean hemiellipsoid | Kenyon-like | Projection neurons | ~500 Mya |
| Polychaete mushroom body | Kenyon-like | Lobus superior | ~600 Mya |

Conclusion: this motif is not just a good design choice — **convergent evolution argues it is near-optimal** for the computational problem of allocentric world modeling. The insect CX is the cleanest ML implementation target (full Drosophila connectome known; ring attractor confirmed in vivo by Seelig & Jayaraman 2015). HC adds cross-environment W generalization that no other system has demonstrated.

---

## Key Open Problems

1. **Type 2 task gap (transformation inference)** — TEM and all current factorized models require the action vocabulary to be given externally. Discovering latent edge labels from (observation_before, observation_after) pairs — as required by ARC-AGI — is architecturally absent. TIWM proposes the Inverse Path Integrator as a bridge but is unimplemented.
2. **Multi-level meta-graph** — flat W cannot represent compositional rule chains (apply rule A, get context for rule B). Three-level PFC hierarchy (Block 3C) needs formalization as a nested latent graph.
3. **Vocabulary co-discovery** — the action alphabet itself must be inferred alongside graph structure. No current model handles both simultaneously without a pre-given symbol set.
4. **Biologically plausible slow W** — PC local updates (`Δw ∝ ε·x`) support within-network learning; cross-environment structural W-generalization via local rules remains open. Contrastive Hebbian is the best candidate.
5. **Reservoir to structured basis** — no model specifies the developmental trajectory from a random basis (reservoir) to a learned structured basis (TEM); how does W acquire structure through experience?
6. **Active inference** — FEP extended to minimize expected future free energy (epistemic foraging) connects to goal-directed reasoning; not formalized in current architecture.

---

## Promising Directions

- **TIWM (Block 3A)** — highest-impact addition to TEM; enables Type 2 / ARC-AGI tasks. Architecturally: set-attention over Δg vectors to produce soft posterior over W vocabulary; W jointly trained by forward and inverse path integration
- **TEM + CSCG unification** — fast de-novo mapping (CSCG) for novel environments + structural transfer (TEM) for familiar domains; would formalize the HC map → memory transition
- **Contrastive Hebbian → slow W** — positive/negative phase with counterfactual environment generation may support cross-environment structural generalization; connects PC local learning to TEM's global W update
- **TRNN for working memory (Block 3B)** — self-inhibition + sparse + hierarchical topology; outperforms attractor RNN on WM capacity, spatial navigation, distractor robustness; γ parameter approximates D1/D2 balance; directly applicable as the fast-M layer
- **Neuromodulation circuit as meta-learning** — DA/ACh/5-HT/NA jointly implement the outer metalearning loop; D1/D2 cellular mechanisms now grounded at receptor level; connecting PVLV to the Block 3B WM gate is a tractable next step
- **Insect CX as minimal implementation target** — ring attractor heading (1A/1B) + P-EN path integration (1B) + PFL goal vector (3D) fully instantiated in a known connectome; a CX-inspired module could provide the MEC core without requiring emergence

---

## Major Controversies

- **Type 1 vs. Type 2 boundary** — the wiki assumes TEM handles Type 1 (familiar environments, known transformation vocabulary) and TIWM handles Type 2 (novel transformation rules); whether this is the right decomposition or whether a unified model can handle both is open
- **TBT evolutionary claim** — that every cortical column recapitulates the HC formation (MEC/LEC/HC as L6/L4/L2-3) is interpretive; significant circuit differences exist; efference copy driving L6 confirmed only in motor cortex
- **Manifold plasticity** — motor cortex manifold constraints shown hard (BCI reversal failure); HC manifold appears more plastic (UMAP drifts with learning); whether hard structural manifold boundaries exist throughout cortex is empirically open
- **Grid code universality** — abstract grid codes shown in vmPFC during 2D conceptual navigation (Constantinescu 2016); extension to non-2D domains (causal graphs, linguistic structure) is unconfirmed
- **Contrastive Hebbian vs. backprop** — biologically plausible in linear networks; approximation degrades with nonlinear activations and deep hierarchies; degree of degradation in realistic cortical circuits is empirically open
- **CA3 connectivity and capacity** — Sammons 2023 found 9–11% pyramidal-to-pyramidal connectivity (10× above prior estimates); this significantly increases estimated biological capacity but is a single dataset

---

## Source Count

Papers: **43** | Concepts: **27** | Entities (models): **8** | Entities (benchmarks): **1** | Entities (biological): **10** | Queries: **5**
