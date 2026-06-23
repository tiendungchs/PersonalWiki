---
title: "Concepts Index"
type: overview
tags: [index]
created: 2026-06-20
updated: 2026-06-23
sources: []
related: []
---

# Concepts Index — 42 pages

Each entry: `[Title](path) — one-line description`. Updated when a new concept page is created.

---

- [Latent Graph Discovery](wiki/concepts/latent-graph-discovery.md) — **CORE PROBLEM FRAMING** — Unified problem: infer hidden graph structure from observations and navigate it; four sources of hardness; why current architectures fail
- [Structural Generalization](wiki/concepts/structural-generalization.md) — **CORE** — Extract relational structure, transfer to new content; graph formalism; why transformers fail; 5 minimum ingredients
- [Abstract Reasoning](wiki/concepts/abstract-reasoning.md) — **TARGET CAPABILITY** — causal model-building vs. pattern recognition; three required ingredients; diagnostic criteria; open problems
- [Two Learning Timescales](wiki/concepts/two-learning-timescales.md) — Slow W (backprop, shared structure) + fast Hebbian M (episodic); HC bootstraps cortical learning; catastrophic interference as formal necessity
- [Factorized Representations](wiki/concepts/factorized-representations.md) — g (MEC) / x (LEC) / p (HC) split; TEM generative equation; factorized vs. entangled phase; disentanglement ≠ abstraction
- [Predictive Coding / Free Energy Principle](wiki/concepts/predictive-coding.md) — F = −ELBO; generative + recognition model; two-timescale minimization; active inference; biologically plausible backpropagation
- [Meta-Learning](wiki/concepts/meta-learning.md) — slow outer loop trains weights; fast inner loop in activation dynamics; PFC/BG canonical instantiation; PVLV; AIXI as formal ceiling
- [Compositional Generalization](wiki/concepts/compositional-generalization.md) — five facets (Hupkes 2020); chunking failure; localism hardest; MLC episodic meta-training; LRM knowledge-boundedness ceiling
- [Working Memory](wiki/concepts/working-memory.md) — five fast WM mechanisms; attractor vs. transient trajectory; STSP structural robustness; transformer entropy limit; BG gating architectures
- [Cognitive Control](wiki/concepts/cognitive-control.md) — goal maintenance as unified CC mechanism; three CC components; hierarchical PFC (BA-8→9/46→10) as Block 3C template; ACC prediction error
- [Associative Memory](wiki/concepts/associative-memory.md) — content-addressable memory via energy minimization; one-shot Hebbian; Hopfield ↔ attention; context-modular; SDM as unification
- [Hebbian Learning](wiki/concepts/hebbian-learning.md) — local co-activation rule; Hopfield one-shot equivalence; Hebbian → PCA; instability → sparsity; STDP/BTSP temporal refinements
- [Attention (Transformer Self-Attention)](wiki/concepts/attention.md) — Hopfield ↔ attention equivalence; learned recurrent positional encodings = path integration; context length as compression window
- [Engrams](wiki/concepts/engrams.md) — sparse physical memory substrate; excitability competition; memory linkage via overlap; CREB molecular mechanism; assembly consolidation
- [Neuromodulation](wiki/concepts/neuromodulation.md) — DA/5-HT/NA/ACh as RL metaparameters; D1/D2 cellular mechanisms; ACh HC storage-retrieval switch; DA=precision vs. DA=TD error tension
- [Sparse Distributed Representations](wiki/concepts/sparse-distributed-representations.md) — SDR formalism; hypergeometric false positive; joint sparsity+dimensionality; union property; NMDA threshold prediction
- [Pattern Separation](wiki/concepts/pattern-separation.md) — DG orthogonalizes similar inputs; transfer function framing (DG nonlinear/CA3 bidirectional/CA1 linear); five mechanisms; SDM as formal model
- [Credit Assignment](wiki/concepts/credit-assignment.md) — ∂F/∂w_{ij} problem; backprop exact but biologically implausible; bias–variance taxonomy (feedback alignment/PC/dendritic/perturbation/AGREL); eligibility traces
- [Representational Geometry](wiki/concepts/representational-geometry.md) — CCGP/SD/PS framework; abstraction as coding-direction parallelism; CCGP/SD duality; mixed selectivity; HPC vs. PFC temporal dynamics
- [Analogical Reasoning](wiki/concepts/analogical-reasoning.md) — four-component algorithm (retrieval/mapping/inference/schema induction); CWSG formalism; LISA gamma-band synchrony; BA-10 integration bottleneck
- [Binding Problem](wiki/concepts/binding-problem.md) — associating feature streams into unified representations; conjunctive neurons, attention, hub topology; TEM p=f(g,x); convergent evolution evidence
- [Path Integration](wiki/concepts/path-integration.md) — abstract graph navigation via g update RNN; compression argument; CANN/VCO/learned RNN accounts; unification with SR
- [Replay](wiki/concepts/replay.md) — offline state-space construction; GVC binding; adaptive SWR selectivity; traveling wave as memory search; Lévy flight statistics
- [Sequence Memory](wiki/concepts/sequence-memory.md) — asymmetric Hopfield (SeqNet/DenseNet); polynomial/exponential capacity; MixedNet fast/slow synapses; CBGT bipartite executor
- [Temporal Coding](wiki/concepts/temporal-coding.md) — spike timing as information carrier; precision paradox via coherent convergence; delay selection; FILT supervised learning capacity
- [Spike Frequency Adaptation (SFA)](wiki/concepts/spike-frequency-adaptation.md) — adaptive threshold as single-neuron WM trace and auto-sparsifier; ALIF/DEXAT formalism; CREB as opposing mechanism
- [Phase Precession](wiki/concepts/phase-precession.md) — spike timing advances to earlier theta phases; temporal sequence compression; MECII (precessing) vs. MECIII (locked) controlled by neuromod gain G
- [Hierarchical Representations](wiki/concepts/hierarchical-representations.md) — manifold untangling; CLSU canonical mechanism; staged local factorization vs. TEM global; feedforward ≠ model-building
- [Dendritic Computation](wiki/concepts/dendritic-computation.md) — NMDA spike coincidence detection; >100 independent segment detectors per neuron; dual-compartment credit assignment (basal/apical)
- [Continual Learning](wiki/concepts/continual-learning.md) — stability-plasticity tension; catastrophic forgetting; EWC; CLS as two-system solution; SDR sparsity as passive protection; Vector-HaSH scaffold
- [Ring Attractor](wiki/concepts/ring-attractor.md) — recurrent bump on circular topology; four A-CANN modes (static/traveling wave/anticipative/oscillatory); Lévy flights; confirmed in Drosophila EB
- [Latent States](wiki/concepts/latent-states.md) — hidden task-relevant variables inferred from sequences; unifies splitter/lap/evidence cells; CCGP as geometric criterion
- [Successor Representation](wiki/concepts/successor-representation.md) — S = (I−γT)^{−1}; rows = place cells; eigenvectors = grid cells; intuitive planning
- [Information Theory (Entropy, KL Divergence)](wiki/concepts/information-theory.md) — surprisal, entropy, cross-entropy, KL; ELBO derivation; Solomonoff predictor as ceiling; AIXI active extension
- [Neural Manifolds and Intrinsic Dynamics](wiki/concepts/neural-manifolds.md) — architecture defines reachable manifold; hard boundary evidence; CCGP/SD as type 6; trajectory manifolds
- [Small-World Networks](wiki/concepts/small-world-networks.md) — high clustering + short paths; wiring cost optimization; hub nodes; HC as structural hub; implications for architecture
- [Convergent Allocentric Coding](wiki/concepts/convergent-allocentric-coding.md) — **CORE COMPARATIVE** — 5–6 independent evolutionary derivations of expansion→compression; master comparison table; ML design implications
- [Adult Neurogenesis](wiki/concepts/adult-neurogenesis.md) — new DG granule cells add low-overlap coding units; gain/loss/immature/retirement evidence; capacity renewal analog for fast-M store
- [Canonical Microcircuit](wiki/concepts/canonical-microcircuit.md) — universal neocortical L4→L2/3→L5→L6→L4 loop; recurrent amplification of weak afferent input; horizontal WTA selects among competing interpretations; explore (superficial) / exploit (deep) layer split; SLN% hierarchy rule
- [Energy-Based Models (EBM)](wiki/concepts/energy-based-models.md) — scalar compatibility function F(x,y); contrastive vs. non-contrastive training; collapse taxonomy; reasoning as energy minimization; unifies Hopfield/Boltzmann/PC/JEPA
- [World Models](wiki/concepts/world-models.md) — learned internal models enabling prediction, planning, and counterfactual reasoning; generative vs. representation-space prediction; Mode-2 planning via differentiable world model; single configurable world model hypothesis
- [Refinement Loops (Test-Time Compute)](wiki/concepts/refinement-loops.md) — ML taxonomy of iterative generate-verify-refine cycles: test-time training, zero-pretraining DL (TRM/CompressARC), evolutionary program synthesis, application-layer CoT harnesses; verifier availability as the key constraint
