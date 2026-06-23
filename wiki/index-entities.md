---
title: "Entities Index"
type: overview
tags: [index]
created: 2026-06-20
updated: 2026-06-23
sources: []
related: []
---

# Entities Index

Each entry: `[Title](path) — one-line description`. Updated when a new entity page is created.

---

## Models

- [DNC (Differentiable Neural Computer)](wiki/entities/dnc-model.md) — LSTM controller + external N×W read-write memory; graph traversal 98.8%; emergent planning; engineered HC/PFC analog
- [Vector-HaSH](wiki/entities/vector-hash-model.md) — scaffold/content factorization; exponential fixed-point capacity ⟨K⟩^M; sequence memory via grid-phase shift; memory palace circuit
- [LTC (Liquid Time-Constant Network)](wiki/entities/ltc-model.md) — input-dependent liquid time constant from C. elegans ODE; provably bounded stability; CfC/Liquid-S4/LTC-SE variants
- [MLC](wiki/entities/mlc-model.md) — episodic meta-learning transformer; lexical generalization solved; structural/productivity hits 100% error ceiling
- [JEPA / H-JEPA](wiki/entities/jepa-model.md) — non-generative world model architecture predicting in representation space; hierarchical stacking for multi-timescale planning; non-contrastive VICReg training; proposed by LeCun 2022
- [VL-JEPA](wiki/entities/vl-jepa-model.md) — JEPA extended to vision-language; predicts text embeddings not tokens; SoTA WorldPrediction-WM (65.7%); selective decoding 2.85× reduction; unified gen+retrieval+class
- [DINOv2](wiki/entities/dinov2-model.md) — EMA teacher-student SSL with DINO+iBOT+KoLeo; 1.1B ViT-giant; first SSL model matching CLIP; emergent part-segmentation from patch PCA; direct ancestor of I-JEPA
- [DINOv3](wiki/entities/dinov3-model.md) — DINOv2 scaled to 7B with Gram anchoring (L_Gram preserving patch similarity structure); SoTA dense features with frozen backbone; first SSL matching weakly-supervised on classification
- [TIWM](wiki/entities/tiwm-model.md) — **(brainstorm)** Proposed: extends TEM with Inverse Path Integrator to infer hidden transformation rules from (g_in, g_out) pairs
- [TEM](wiki/entities/tem-model.md) — Tolman-Eichenbaum Machine: factorized world model (g/x/p + W/M); emergent grid/place cells; key results and limitations
- [CSCG](wiki/entities/cscg-model.md) — Clone cells for de-aliasing; Bayesian EM; fast/local; no cross-environment generalization
- [HTM / Thousand Brains Theory](wiki/entities/htm-thousand-brains.md) — ~150,000 cortical columns each miniaturizing HC formation; sensorimotor coupling; consensus voting
- [Boltzmann Machine](wiki/entities/boltzmann-machine.md) — Hopfield + stochasticity + hidden units; contrastive Hebbian learning; historical precursor to VAEs and FEP
- [Reservoir Computing](wiki/entities/reservoir-computing.md) — random fixed reservoir + linear readout; echo-state property; extreme W/M split; neocortex-as-reservoir
- [TRNN](wiki/entities/trnn-model.md) — Transient Trajectory RNN; self-inhibition + sparse + hierarchical; neuron-count-limited WM capacity; outperforms attractor RNN
- [SDM (Sparse Distributed Memory)](wiki/entities/sdm-model.md) — Kanerva's model: fixed random hard-address matrix A + modifiable contents C; τ≈0.1; p_opt=(2MT)^{-1/3}; unifies Hopfield/DG→CA3/cerebellum
- [Global Neuronal Workspace (GNW)](wiki/entities/gwt-model.md) — PFC-parietal hub broadcasting; ignition as conscious access; AMPA/NMDA two-stage; active-vs-silent WM; offset ignition contradiction
- [LISA](wiki/entities/lisa-model.md) — symbolic-connectionist analogy model; gamma-band temporal synchrony for role-filler binding; ≤2–3 proposition WM capacity
- [COVIS](wiki/entities/covis-model.md) — dual-system categorization (hypothesis-testing + procedural BG RL); precursor meta-learning dual-loop architecture
- [Spiking Neural Networks (SNN)](wiki/entities/snn.md) — rate/temporal/synchrony/phase taxonomy; ALIF neuromorphic substrate; FILT supervised learning at 0.2 ms precision; computational hierarchy proves type B SNNs strictly more powerful than sigmoidal nets
- [Equilibrium Propagation](wiki/entities/equilibrium-propagation.md) — two-phase energy-based learning algorithm; identical leaky-integrator dynamics perform inference and credit assignment; contrastive Hebbian rule computes exact gradient; canonical resolution to biologically plausible slow-W learning

---

## Benchmarks

- [ARC-AGI](wiki/entities/arc-agi.md) — fluid intelligence benchmark; three versions (static puzzles → reasoning models → interactive agents); LRM knowledge-boundedness theorem
- [PGM (Procedurally Generated Matrices)](wiki/entities/pgm-benchmark.md) — Raven-style visual abstract reasoning benchmark; 8 generalisation regimes; composition-decomposition asymmetry; WReN best model

---

## Biological Systems

- [Prefrontal Cortex (PFC)](wiki/entities/prefrontal-cortex.md) — goal maintenance; SEC storage; hierarchical BA-8→9/46→10 gradient; meta-RL substrate; mapping to Blocks 3A–3D
- [Basal Ganglia](wiki/entities/basal-ganglia.md) — Go/NoGo/Hold three-pathway dissociation; D1/D2 opponent plasticity; MSPRT optimal selection; PVLV; SPEED automaticity
- [Hippocampal-Entorhinal System](wiki/entities/hippocampal-entorhinal-system.md) — MEC/LEC/HC anatomy; BTSP single-shot encoding; DNC as engineered HC/PFC; map vs. memory dual role
- [Grid Cells](wiki/entities/grid-cells.md) — SR eigenvectors = structural code g; periodic, environment-invariant; path integration substrate; abstract domain generalization (vmPFC)
- [Place Cells](wiki/entities/place-cells.md) — SR rows = conjunctive code p = f(g,x); remap non-randomly; BTSP acquisition; latent-state variants (splitter, lap, evidence cells)
- [Insect Central Complex (CX)](wiki/entities/insect-central-complex.md) — ring attractor heading; P-EN path integration; PFL goal vector; full Drosophila connectome; cleanest ML target
- [Arthropod Mushroom Bodies](wiki/entities/arthropod-mushroom-bodies.md) — Kenyon cell expansion→MBON compression; olfactory associative learning; spatial memory in jumping spiders (tentative)
- [Cerebellum](wiki/entities/cerebellum.md) — biological SDM for motor learning: mossy fiber address → granule cell expansion → Purkinje synapse content; climbing fiber supervised write
- [Cephalopod Vertical Lobe](wiki/entities/cephalopod-vertical-lobe.md) — (tentative) amacrine expansion → large-field-cell compression; DG→CA3 topological analog; ~500 Mya independent
- [Crustacean Hemiellipsoid Bodies](wiki/entities/crustacean-hemiellipsoid-bodies.md) — (tentative) Kenyon-like expansion; place-cell-like activity in crabs; mantis shrimp disproportionate size
- [Polychaete Annelid Mushroom Bodies](wiki/entities/polychaete-mushroom-bodies.md) — Kenyon-like motif in Nereis/Platynereis; ~600 Mya; deep homology vs. convergence actively debated
