---
title: "Entities Index"
type: overview
tags: [index]
created: 2026-06-20
updated: 2026-07-02

sources: []
related: []
---

# Entities Index

Each entry: `[Title](path) — one-line description`. Updated when a new entity page is created.

---

## Models

- [Spacetime Attractor (STA)](wiki/entities/spacetime-attractor.md) — PFC planning model: T neural subspaces encode full future trajectory simultaneously; world model in inter-subspace weights; attractor dynamics infer optimal plans; unifies sequence WM and planning; outperforms TD/SR on dynamic tasks
- [HAMI (Hippocampal-Augmented Memory Integration)](wiki/entities/hami-model.md) — episodic control RL framework; event/context disentanglement (LEC/MEC split); symbolic indexing for O(1) CAM (Content-Addressable Memory) retrieval; NVM-CAM hardware-aligned; no structural generalization
- [Transformer](wiki/entities/transformer-model.md) — encoder-decoder self-attention architecture; O(1) max path length; multi-head attention; 28.4 BLEU EN-DE; localism failure; foundational for TEM-t and JEPA
- [DNC (Differentiable Neural Computer)](wiki/entities/dnc-model.md) — LSTM controller + external N×W read-write memory; graph traversal 98.8%; emergent planning; engineered HC/PFC analog
- [Vector-HaSH](wiki/entities/vector-hash-model.md) — scaffold/content factorization; exponential fixed-point capacity ⟨K⟩^M; sequence memory via grid-phase shift; memory palace circuit
- [LTC (Liquid Time-Constant Network)](wiki/entities/ltc-model.md) — input-dependent liquid time constant from C. elegans ODE; provably bounded stability; CfC/Liquid-S4/LTC-SE variants
- [MLC](wiki/entities/mlc-model.md) — episodic meta-learning transformer; lexical generalization solved; structural/productivity hits 100% error ceiling
- [JEPA / H-JEPA](wiki/entities/jepa-model.md) — non-generative world model architecture predicting in representation space; hierarchical stacking for multi-timescale planning; non-contrastive VICReg training; proposed by LeCun 2022
- [VL-JEPA](wiki/entities/vl-jepa-model.md) — JEPA extended to vision-language; predicts text embeddings not tokens; SoTA WorldPrediction-WM (65.7%); selective decoding 2.85× reduction; unified gen+retrieval+class
- [DINOv2](wiki/entities/dinov2-model.md) — EMA (Exponential Moving Average) teacher-student SSL with DINO+iBOT+KoLeo; 1.1B ViT-giant; first SSL model matching CLIP; emergent part-segmentation from patch PCA; direct ancestor of I-JEPA
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
- [COVIS](wiki/entities/covis-model.md) — dual-system categorization (hypothesis-testing + procedural BG (Basal Ganglia) RL); precursor meta-learning dual-loop architecture
- [Spiking Neural Networks (SNN)](wiki/entities/snn.md) — rate/temporal/synchrony/phase taxonomy; ALIF (Adaptive Leaky Integrate-and-Fire) neuromorphic substrate; FILT supervised learning at 0.2 ms precision; computational hierarchy proves type B SNNs strictly more powerful than sigmoidal nets
- [Equilibrium Propagation](wiki/entities/equilibrium-propagation.md) — two-phase energy-based learning algorithm; identical leaky-integrator dynamics perform inference and credit assignment; contrastive Hebbian rule computes exact gradient; canonical resolution to biologically plausible slow-W learning
- [IWMT (Integrated World Modeling Theory)](wiki/entities/iwmt.md) — theoretical synthesis of IIT, GNWT, and FEP-AI; consciousness as integrated spatiotemporal-causal world modeling; proposes turbo-coding (inter-level loopy BP) and SOHMs as implementation mechanisms
- [Vector Symbolic Algebra (VSA / HRR)](wiki/entities/vsa-model.md) — neuro-symbolic framework: circular convolution for invertible role-filler binding, Spatial Semantic Pointers (SSPs) for continuous spatial encoding with emergent grid-cell-like representations; isolates vocabulary co-discovery bottleneck on ARC-AGI (3% Eval vs. 94.5% Sort-of-ARC)
- [fcANN (Functional Connectivity-based Attractor Neural Network)](wiki/entities/fcann.md) — whole-brain attractor model grounded in FEP; coupling weights J = −Σ⁻¹ from resting-state fMRI; brain ≈ Kanter-Sompolinsky projector with orthogonal attractors; validated across 7 datasets
- [C2C (Connectome-to-Connectome) State Transformation Model](wiki/entities/c2c-model.md) — linear generative model (PCA + PLS) predicting task-specific connectomes from resting-state FC; reveals task-general (DMN component 6) vs task-specific subsystems; amplifies individual fingerprint for behavior prediction
- [HNN Framework (Hybrid Neural Networks)](wiki/entities/hnn-framework.md) — ANN+SNN framework via Hybrid Units (HU formalism); HRN for interpretable causal VQA (91.7% CLEVRER descriptive); HMN for meta-continual learning via learned threshold modulation; HSN for neuromorphic sensing (11× speedup)
- [CH-HNN (Corticohippocampal Hybrid Neural Network)](wiki/entities/ch-hnn-model.md) — ANN (mPFC-CA1) + SNN (DG-CA3) hybrid; episode inference via sparse binary masks; task-agnostic continual learning; metaplasticity; bidirectional corticohippocampal loop validated
- [S4 (Structured State Space Sequence Model)](wiki/entities/s4-model.md) — NPLR parameterization of HiPPO matrix enables O(N+L) SSM kernel; dual recurrent/convolutional modes; first to solve LRA Path-X; foundational SSM baseline for Mamba and MS-SSM
- [MS-SSM (Multi-Scale State Space Model)](wiki/entities/ms-ssm-model.md) — multi-resolution SWT decomposition + parallel SSM array with scale-dependent initialization; 2× Mamba on ListOps hierarchical reasoning; ablation confirms multi-scale conv (not selective gating) is the key inductive bias
- [Mamba](wiki/entities/mamba-model.md) — selective SSM (S6 block) with input-dependent gating B_t/C_t/Δ_t = f(x_t); linear inference; strong NLP baseline but collapses on hierarchical reasoning (ListOps 38% vs. S4 60%)

---

## Benchmarks

- [ARC-AGI](wiki/entities/arc-agi.md) — fluid intelligence benchmark; three versions (static puzzles → reasoning models → interactive agents); LRM (Large Reasoning Model) knowledge-boundedness theorem
- [FrontierMath Benchmark](wiki/entities/frontiermath-benchmark.md) — 500+ expert-vetted research math problems; <2% SOTA solve rate; instantiates latent edge + path discovery with near-zero vocabulary coverage; cross-domain confirmation of the ARC-AGI frontier gap
- [PGM (Procedurally Generated Matrices)](wiki/entities/pgm-benchmark.md) — Raven-style visual abstract reasoning benchmark; 8 generalisation regimes; composition-decomposition asymmetry; WReN best model
- [OlymMATH](wiki/entities/olymmath.md) — bilingual olympiad benchmark; HARD/LEAN subsets; Lean 4 process-level verification detects heuristic shortcut guessing; intermediate tier between saturated competition math and open FrontierMath
- [GPQA Benchmark](wiki/entities/gpqa-benchmark.md) — 448-question graduate-level MCQ (biology, physics, chemistry); google-proof gap (experts 65% vs. non-experts+web 34%); node-content-latent tier; scalable oversight motivation
- [Baba Is AI](wiki/entities/baba-is-ai.md) — rules-as-movable-objects benchmark (from *Baba Is You*); the maximally-tractable pole of non-stationary topology (controllable + legible + bounded rewrites); frontier LLMs score ~15–20% on composing rule-manipulations

---

## Biological Systems

- [Default Mode Network (DMN)](wiki/entities/default-mode-network.md) — cortical hub network integrating episodic memory, semantics, and self-reference into "frames of thought"; hosts the strongest abstract grid-code signals (vmPFC); suppressed during working memory tasks
- [Prefrontal Cortex (PFC)](wiki/entities/prefrontal-cortex.md) — goal maintenance; SEC (Structured Event Complex) storage; hierarchical BA (Brodmann Area)-8→9/46→10 gradient; meta-RL substrate; mapping to Blocks 3A–3D
- [Basal Ganglia](wiki/entities/basal-ganglia.md) — Go/NoGo/Hold three-pathway dissociation; D1/D2 opponent plasticity; MSPRT optimal selection; PVLV; SPEED automaticity
- [Hippocampal-Entorhinal System](wiki/entities/hippocampal-entorhinal-system.md) — MEC/LEC/HC anatomy; BTSP single-shot encoding; DNC (Differentiable Neural Computer) as engineered HC/PFC; map vs. memory dual role
- [Grid Cells](wiki/entities/grid-cells.md) — SR (Successor Representation) eigenvectors = structural code g; periodic, environment-invariant; path integration substrate; abstract domain generalization (vmPFC)
- [Place Cells](wiki/entities/place-cells.md) — SR (Successor Representation) rows = conjunctive code p = f(g,x); remap non-randomly; BTSP acquisition; latent-state variants (splitter, lap, evidence cells)
- [Insect Central Complex (CX)](wiki/entities/insect-central-complex.md) — ring attractor heading; P-EN path integration; PFL goal vector; full Drosophila connectome; cleanest ML target
- [Arthropod Mushroom Bodies](wiki/entities/arthropod-mushroom-bodies.md) — Kenyon cell expansion→MBON compression; olfactory associative learning; spatial memory in jumping spiders (tentative)
- [Cerebellum](wiki/entities/cerebellum.md) — biological SDM (Sparse Distributed Memory) for motor learning: mossy fiber address → granule cell expansion → Purkinje synapse content; climbing fiber supervised write
- [Cephalopod Vertical Lobe](wiki/entities/cephalopod-vertical-lobe.md) — (tentative) amacrine expansion → large-field-cell compression; DG→CA3 topological analog; ~500 Mya independent
- [Crustacean Hemiellipsoid Bodies](wiki/entities/crustacean-hemiellipsoid-bodies.md) — (tentative) Kenyon-like expansion; place-cell-like activity in crabs; mantis shrimp disproportionate size
- [Polychaete Annelid Mushroom Bodies](wiki/entities/polychaete-mushroom-bodies.md) — Kenyon-like motif in Nereis/Platynereis; ~600 Mya; deep homology vs. convergence actively debated
- [Nucleus Reuniens (RE)](wiki/entities/nucleus-reuniens.md) — midline thalamic relay; single neurons fan out to both HC and mPFC simultaneously; mPFC→RE→HPC indirect channel for spatial WM and goal-directed future path planning; active plasticity modulator in both targets
