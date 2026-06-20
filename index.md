---
updated: 2026-06-20 (28)
---

# Wiki Index — Brain-Inspired Models for Abstract Reasoning

Content catalog. Read this first when answering queries.

---

## Overview

- [Overview](wiki/overview.md) — Master synthesis: current understanding, open problems, promising directions
- [Glossary](wiki/glossary.md) — Abbreviations used across the wiki with links to entity/concept pages

---

## Papers

- [TEM — Whittington et al., Cell 2020](wiki/papers/tem-whittington-2020.md) — **FOUNDATIONAL** — Structural generalization via factorized representations; source: TEM.pdf
- [How to build a cognitive map — Whittington et al., arXiv 2022](wiki/papers/whittington-cognitive-map-2022.md) — Perspective unifying SR, CSCG, TEM under three principles; latent states as unified account of non-spatial HC cells; source: cognitivemap.md
- [Gridlike code for conceptual knowledge — Constantinescu, O'Reilly & Behrens, Science 2016](wiki/papers/gridlikecode-constantinescu-2016.md) — fMRI evidence that grid codes organize abstract 2D conceptual spaces in vmPFC and entorhinal cortex; source: gridlikecode.md
- [Transformers and hippocampal formation — Whittington, Warren & Behrens, ICLR 2022](wiki/papers/t-tem-whittington-2022.md) — TEM = transformer with learned recurrent positional encodings; Hopfield ↔ attention; TEM-t outperforms TEM; source: t-TEM.md
- [Engrams: Physical Memory Substrate (transcript)](wiki/papers/engram-transcript.md) — sparse engram allocation via excitability competition; memory linkage via overlap; brain-wide engram complex; source: engram-transcript.txt
- [Cross-Entropy from First Principles (tutorial transcript)](wiki/papers/cross-entropy-first-principles-transcript.md) — tutorial derivation of entropy, cross-entropy, KL divergence; training objective equivalence; source: cross-entropy-first-principles-transcript.txt
- [Free Energy Principle — Conceptual Introduction (transcript)](wiki/papers/free-energy-principle-transcript.md) — FEP as Bayesian brain inference; generative + recognition model; two-timescale minimization; source: free-energy-principle-transcript.txt
- [Brain's Learning Algorithm — Predictive Coding from First Principles (transcript)](wiki/papers/brain-learning-algorithm-transcript.md) — backprop violations; energy function; local activity/weight update rules; two-population architecture; source: brain-learning-algorithm-transcript.txt
- [Brain's Learning Limits — Neural Manifold Constraints (transcript)](wiki/papers/brain-learning-limits-transcript.md) — BCI reversal task; hard manifold constraints; two-projection analysis; feasibility vs. efficiency; source: brain-learning-limits-transcript.txt
- [Memory Gate: Sharp Wave Ripples and Two-Stage Memory Selection (transcript)](wiki/papers/memory-gate-transcript.md) — SWR E/I competition; awake bookmark + sleep consolidate; UMAP HC manifold; temporal compression; source: memory-gate-transcript.txt
- [Thousand Brains Theory — 150,000 Mini-Brains (transcript)](wiki/papers/150000-mini-brain-transcript.md) — universal columnar HC-formation circuit; sensorimotor coupling; consensus voting; hierarchical abstract path integration; source: 150000-mini-brain-transcript.txt
- [Convergence Wiring — Small-World Networks in the Brain (transcript)](wiki/papers/convergence-wiring-transcript.md) — small-world topology; wiring cost as evolutionary constraint; hub nodes with heavy-tailed degree distributions; computational advantages; source: convergence-wiring-transcript.txt
- [Boltzmann Machine — From Hopfield to Generative Models (transcript)](wiki/papers/boltzmann-machine-transcript.md) — Boltzmann distribution derivation; contrastive Hebbian learning; hidden units; RBM variant; partition function intractability; source: bolzman-machine-transcript.txt
- [Reservoir Computing — Temporal Basis and Echo-State Networks (transcript)](wiki/papers/reservoir-computing-transcript.md) — echo-state property; linear readout; Fourier analogy; neocortex as reservoir of cortical columns; theta/gamma as pacemaker; source: reservoir-computing-transcript.txt
- [Jumping Spiders: Tiny Brains, Big Cognitive Abilities](wiki/papers/jumping-spiders-cognition.md) — convergent evolution of place/grid cell analogs in mushroom bodies; neural economy; cross-modal binding; source: jumping-spiders-cognition (popular science, tentative claims)
- [Convergent Brain Structures for Spatial Memory (transcript)](wiki/papers/convergent-brain-structures-transcript.md) — comparative survey of allocentric world-modeling structures; CX, cephalopod VL, crustacean hemiellipsoid bodies, polychaete MBs; brainstorming transcript (tentative except CX)
- [Neural dynamics for landmark orientation and angular path integration — Seelig & Jayaraman, Nature 2015](wiki/papers/seelig-jayaraman-2015.md) — ring attractor confirmed in vivo in Drosophila EB; E-PG bump dynamics; landmark dominance; path integration drift; persistent activity; source: landmark-orientation.md
- [The Neuroanatomical Ultrastructure and Function of a Biological Ring Attractor — Turner-Evans et al., Neuron 2020](wiki/papers/turner-evans-neuron-2020.md) — (tentative, no source) hemibrain EM connectome characterization of CX ring attractor synaptic circuit
- [Metalearning and Neuromodulation — Doya, Neural Networks 2002](wiki/papers/metalearning-neuromodulation-doya-2002.md) — DA=TD error, 5-HT=discount factor, NA=inverse temperature, ACh=learning rate; basal ganglia actor-critic; closed metalearning loop; ACh HC storage/retrieval switch
- [Prefrontal Cortex as a Meta-RL System — Wang et al., Nature Neuroscience 2018](wiki/papers/pfc-meta-rl-wang-2018.md) — DA trains PFC weights (slow); PFC LSTM dynamics implement within-episode RL (fast); model-based behavior emerges from model-free training; dual role of dopamine
- [Making Working Memory Work — O'Reilly & Frank, Neural Computation 2006](wiki/papers/pbwm-oreilly-frank-2006.md) — PBWM model: stripe-selective BG gating; PVLV non-TD DA algorithm; dynamic variable binding; PBWM ≈ LSTM on complex WM tasks
- [Compositionality Decomposed — Hupkes et al., JAIR 2020](wiki/papers/compositionality-decomposed-hupkes-2020.md) — five-facet test suite (systematicity, productivity, substitutivity, localism, overgeneralisation); all architectures fail localism; chunking explains accuracy/systematicity gap
- [Human-like Systematic Generalization — Lake & Baroni, Nature 2023](wiki/papers/mlc-lake-baroni-2023.md) — MLC: episodic meta-training across 100K compositional grammars; 92.9–96.8% vs GPT-4 58% (collapses to 14% with random order); human inductive biases quantified (ME, iconic concatenation, one-to-one); source: SI only
- [RNNs with Transient Trajectory — Liu et al., Communications Biology 2025](wiki/papers/trnn-liu-2025.md) — TRNN: self-inhibition + sparse + hierarchical topology beats attractor RNN on WM capacity, spatial navigation, distractor robustness; dPCA confirms trajectory manifold; neuron-count-limited capacity
- [Robust and brain-like WM through STSP — Kozachkov et al., PLoS Comput Biol 2022](wiki/papers/stsp-kozachkov-2022.md) — STSP as 4th fast WM mechanism; NHP PFC empirical validation of activity-silent WM; PS-hebb most brain-like + 50% ablation tolerance; anti-Hebbian rule critical for stability
- [Self-Attention Limits Transformer WM Capacity — Gong & Zhang, NeurIPS Workshop 2024](wiki/papers/transformer-wm-limit-gong-2024.md) — attention entropy H_N as mechanistic cause of N-back failure; executive attention theory parallel; context length is not the bottleneck
- [PFC in Cognitive Control and Executive Function — Friedman & Robbins, Neuropsychopharmacology 2021](wiki/papers/pfc-cognitive-control-friedman-2021.md) — goal maintenance as unified CC mechanism; hierarchical PFC gradient (BA-8/9/46/10) as Block 3C template; ACC unsigned prediction error; neurochemical CC specificity
- [Human PFC: Processing and Representational Perspectives — Wood & Grafman, Nat Rev Neurosci 2003](wiki/papers/pfc-wood-grafman-2003.md) — SEC framework (PFC stores structured event sequences encoding rules/grammars); WM = activated LTM; vmPFC/dlPFC categorical specificity; anterior-posterior event-complexity gradient
- [ARC-AGI Benchmark Series — Chollet 2019 / arcprize.org 2025](wiki/papers/arc-agi-overview.md) — intelligence = skill-acquisition efficiency; Core Knowledge Priors; o3 solved ARC-AGI-1 via test-time reasoning (not scale); ARC-AGI-2 three capability gaps (symbolic interpretation, compositional reasoning, contextual rule application); ARC-AGI-3 interactive agent requirements
- [ARC-AGI-3 Technical Paper — ARC Prize Foundation, April 2026](wiki/papers/arc-agi-3-paper.md) — four-pillar agentic decomposition (Exploration/Modeling/Goal-Setting/Planning); RHAE action-efficiency scoring; LRM knowledge-boundedness theorem; benchmark contamination mechanism; <1% frontier AI vs. 100% human at launch
- [Hopfield Networks: Neural Memory Machines — Crouse 2022](wiki/papers/hopfield-networks-crouse-2022.md) — energy minimization as associative memory; one-shot Hebbian learning = fast-M write; CA3 pattern completion as biological Hopfield attractor; modern Hopfield = transformer self-attention
- [Structure and function of the hippocampal CA3 module — Sammons et al., PNAS 2023](wiki/papers/ca3-sammons-2023.md) — CA3 connectivity ~9–11% (10× above prior estimate); random connectivity sufficient for pattern completion; c × M ≈ const; log-normal weights confirmed
- [Pattern Completion and Pattern Separation in the Hippocampus — Rolls 2013](wiki/papers/pattern-completion-rolls-2013.md) — p_max ≈ k × C_RC / a capacity formula; five DG separation mechanisms (mossy fiber randomization, expansion recoding, sparseness, neurogenesis); grid→place via DG competitive learning; encoding/recall anatomical separation
- [Complementary Learning Systems — O'Reilly et al. 2011](wiki/papers/cls-oreilly-2011.md) — HC sparse+pattern-separated (episodic) + neocortex distributed+overlapping (semantic); CA1 as sparse invertible mapper; theta-phase error-driven learning at 4-8 Hz; consolidation = transformation not transfer; bidirectional HC-neocortex synergy
- [Why There Are Complementary Learning Systems — McClelland, McNaughton & O'Reilly 1995](wiki/papers/cls-mcclelland-1995.md) — foundational CLS paper; catastrophic interference (McCloskey & Cohen 1989) as formal proof of two-system necessity; interleaved training for structured knowledge; statistical learning theory grounds slow-W; HC-as-teacher; gist/detail dissociation
- [High Capacity and Dynamic Accessibility — Podlaski, Agnes & Vogels, PRX 2025](wiki/papers/podlaski-context-modular-memory-2025.md) — context-modular Hopfield with neuronal/synaptic gating; ~7× capacity with random neuronal gating, ~40× with synaptic refinement; optimal neuronal gating ratio formally predicts 20–30% sparse engram fractions; memories storable in gating mask alone (random weight matrix)
- [Learning, Fast and Slow — Liao & Losonczy, Ann. Rev. Neurosci. 2024](wiki/papers/learning-fast-slow-liao-2024.md) — BTSP as molecular substrate of single-shot place field acquisition (EC-instructed dendritic plateau); STDP as many-shot sequence learning; speed-amplitude trade-off unifies both; adaptive replay selectivity and inhibitory plasticity as structural filtering mechanism
- [Building Machines That Learn and Think Like People — Lake, Ullman, Tenenbaum & Gershman 2016](wiki/papers/building-machine-thinks-like-people-lake-2016.md) — pattern recognition vs. causal model-building as the central axis of human-like intelligence; compositionality+causality as prerequisites for human-level learning-to-learn; Frostbite (924h vs. 15min) and Characters Challenge as diagnostics; BPL as proof-of-concept for causal+compositional representations
- [Analogy and Relational Reasoning — Holyoak 2012](wiki/papers/analogy-holyoak-2012.md) — four-component process (retrieval/mapping/inference/schema induction); multiconstraint theory; CWSG inference algorithm; LISA gamma-band synchrony binding; frontopolar BA-10 as multi-relational integration bottleneck; retrieval gap as diagnostic of abstract-reasoning failure
- [Mathematical Theory of SDRs and Active Dendrites — Ahmad & Hawkins 2016](wiki/papers/ahmad-hawkins-sdr-2016.md) — scaling laws for SDR pattern recognition via active dendrites; joint sparsity+dimensionality requirement; union property (Bloom filter equivalence); NMDA threshold prediction from first principles (9–20 predicted, 8–20 measured)
- [Pattern Separation in the Hippocampus — Yassa & Stark, Trends Neurosci. 2011](wiki/papers/yassa-stark-pattern-separation-2011.md) — transfer function framing (DG nonlinear/CA3 bidirectional/CA1 linear); hilar regulatory control loop; noradrenergic DG specialization; aging as calibration failure; neurogenesis controversy
- [How does the brain solve visual object recognition? — DiCarlo, Zoccolan & Rust, Neuron 2012](wiki/papers/dicarlo-visual-object-recognition-2012.md) — manifold untangling as the crux algorithm; CLSU canonical mechanism (NLN + normalization + temporal contiguity learning); neuronal tolerance vs. invariance; feedforward sufficiency for core recognition; feedforward/feedback as the pattern recognition/model-building boundary
- [Modulation of Striatal Projection Systems by Dopamine — Gerfen & Surmeier, Annu Rev Neurosci 2011](wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md) — D1/D2 opponent plasticity (PKA→LTP vs. EC→CB1→LTD) from single phasic DA event; up-state bistability as convergence gating; structural SPN asymmetry; cholinergic temporal gating of pathway routing; PD as natural experiment confirming opponent credit assignment
- [CCN Review of Basal Ganglia Cognitive and Motor Functions — Helie, Chakravarthy & Moustafa 2013](wiki/papers/helie-ccn-bg-2013.md) — three-pathway algorithmic dissociation (Go/NoGo/Hold); TAN catastrophic interference gate; BG-WM three-architecture debate; COVIS dual-system categorization as meta-learning precursor; SPEED automaticity model (BG trains then withdraws); cognitive-motor integration gap for embodied agents
- [BG and Cortex Implement Optimal Decision Making — Bogacz & Gurney, Neural Computation 2007](wiki/papers/bogacz-gurney-bg-msprt-2007.md) — MSPRT as the algorithmic level of BG action selection; direct pathway = salience, STN+GP = log-softmax normalization; STN exponential + GP log transfer functions biologically validated; Hick's Law from first principles; proficient-vs.-learning-phase dissociation

---

## Concepts

- [Latent Graph Discovery](wiki/concepts/latent-graph-discovery.md) — **CORE PROBLEM FRAMING** — Unified problem: infer hidden graph structure (nodes/edges/topology) from observations and navigate it; taxonomy of what-is-latent; four sources of hardness; why current architectures fail
- [Structural Generalization](wiki/concepts/structural-generalization.md) — **CORE** — Extract relational structure, transfer to new content; graph formalism; why transformers fail; 5 minimum ingredients
- [Attention (Transformer Self-Attention)](wiki/concepts/attention.md) — Hopfield ↔ attention equivalence; learned recurrent positional encodings = path integration; memory neurons = place cells
- [Engrams](wiki/concepts/engrams.md) — sparse physical memory substrate; excitability competition; memory linkage via overlap; co-retrieval as abstract concept formation mechanism
- [Factorized Representations](wiki/concepts/factorized-representations.md) — g (MEC) / x (LEC) / p (HC) split; TEM generative equation; factorized vs. entangled phase
- [Latent States](wiki/concepts/latent-states.md) — Hidden task-relevant variables inferred from sequences; unifies splitter/lap/evidence cells
- [Path Integration](wiki/concepts/path-integration.md) — Abstract graph navigation via g update RNN; compression argument; CANN/VCO/learned RNN accounts; unification with SR
- [Successor Representation](wiki/concepts/successor-representation.md) — S = (I−γT)^{−1}; rows = place cells; eigenvectors = grid cells; intuitive planning
- [Two Learning Timescales](wiki/concepts/two-learning-timescales.md) — Slow W (backprop, shared structure) + fast M (Hebbian, episodic); HC bootstraps cortical learning
- [Replay](wiki/concepts/replay.md) — Offline state-space construction via GVC binding; subsumes credit assignment and consolidation views
- [Information Theory (Entropy, KL Divergence)](wiki/concepts/information-theory.md) — surprisal, entropy, cross-entropy, KL divergence; training objective equivalence; KL asymmetry for reasoning models
- [Predictive Coding / Free Energy Principle](wiki/concepts/predictive-coding.md) — F = −ELBO; generative + recognition model; two-timescale minimization; Bayesian brain interpretation of the cross-entropy/KL training objective
- [Neural Manifolds and Intrinsic Dynamics](wiki/concepts/neural-manifolds.md) — architecture defines the reachable manifold; patterns outside are structurally unlearnable; feasibility argument for factorized representations
- [Small-World Networks](wiki/concepts/small-world-networks.md) — high clustering + short path lengths; wiring cost optimization; hub nodes with heavy-tailed connectivity; HC as structural hub; implications for reasoning model architecture
- [Binding Problem](wiki/concepts/binding-problem.md) — associating parallel feature streams into unified representations; conjunctive neurons, attention, hub topology as mechanisms; TEM p=f(g,x) as explicit binding layer; convergent evolution evidence from jumping spiders
- [Ring Attractor](wiki/concepts/ring-attractor.md) — recurrent network with activity bump on circular topology; Kalman filter interpretation; path integration + landmark correction; all five signatures confirmed in Drosophila EB (Seelig & Jayaraman 2015)
- [Convergent Allocentric Coding](wiki/concepts/convergent-allocentric-coding.md) — **CORE COMPARATIVE** — 5–6 independent evolutionary derivations of the expansion→compression motif; master comparison table across all systems; ML design implications (CX first, HC for generalization)
- [Neuromodulation](wiki/concepts/neuromodulation.md) — DA/5-HT/NA/ACh as RL metaparameters (TD error/discount/inverse temperature/learning rate); ACh HC storage-retrieval switch; closed metalearning loop; dual role of DA; grounding for Blocks 2C, 3B, 3D
- [Meta-Learning](wiki/concepts/meta-learning.md) — slow outer loop trains weights; fast inner loop runs in activation dynamics; PFC/BG canonical instantiation; PVLV biological DA algorithm; model-based behavior emergent from model-free training; Block 3B proper mechanism
- [Compositional Generalization](wiki/concepts/compositional-generalization.md) — five facets (Hupkes 2020); chunking failure mode; localism hardest property; MLC episodic meta-training as solution; human inductive biases (ME, iconic concatenation, one-to-one) as target specification
- [Working Memory](wiki/concepts/working-memory.md) — attractor vs. transient trajectory debate; four fast WM mechanisms; STSP structural robustness; transformer attention entropy limit; WM updating as second CC component; dlPFC maintenance vs. interference resistance
- [Cognitive Control](wiki/concepts/cognitive-control.md) — goal maintenance as unified CC mechanism (Miller & Cohen); three CC components (inhibition/updating/shifting); hierarchical PFC (BA-8→9/46→10) as Block 3C template; ACC proactive+reactive CC via unsigned prediction error
- [Associative Memory](wiki/concepts/associative-memory.md) — content-addressable memory via energy minimization; one-shot Hebbian learning; Hopfield ↔ attention bridge; CA3 pattern completion; spurious attractor capacity limit ~0.14N
- [Pattern Separation](wiki/concepts/pattern-separation.md) — DG orthogonalizes similar inputs before CA3 storage; five mechanisms; capacity formula p_max ≈ k×C_RC/a; mossy fiber/perforant path encoding-recall separation
- [Abstract Reasoning](wiki/concepts/abstract-reasoning.md) — **TARGET CAPABILITY** — causal model-building vs. pattern recognition; three required ingredients (compositionality, causality, learning-to-learn) and their dependency; diagnostic criteria (one-shot learning, goal repurposing, counterfactual inference); open problems
- [Analogical Reasoning](wiki/concepts/analogical-reasoning.md) — four-component algorithm (retrieval/mapping/inference/schema induction); CWSG formalism; multiconstraint theory; LISA gamma-band synchrony; frontopolar BA-10 integration bottleneck; retrieval gap; schema induction as relational meta-learning
- [Sparse Distributed Representations](wiki/concepts/sparse-distributed-representations.md) — SDR formalism; hypergeometric false positive formula; joint sparsity+dimensionality requirement; union property; NMDA threshold prediction; instantiations table; reasoning model implications (fast-M write, DG expansion, k-WTA)
- [Hierarchical Representations](wiki/concepts/hierarchical-representations.md) — manifold untangling perspective; CLSU canonical mechanism; staged local factorization vs. TEM global factorization; reasoning model implications (hierarchy necessary but not sufficient; feedforward ≠ model-building)
- [Dendritic Computation](wiki/concepts/dendritic-computation.md) — NMDA spike coincidence detection; >100 independent segment detectors per neuron; instantiations across neocortex/DG/BG/CA3; SDR scaling laws as prerequisite
- [Adult Neurogenesis](wiki/concepts/adult-neurogenesis.md) — new DG granule cells add low-overlap coding units; evidence table (gain/loss/immature/retirement); contested primate relevance; capacity renewal analog for fast-M store

---

## Entities

### Models
- [MLC](wiki/entities/mlc-model.md) — Episodic meta-learning transformer for compositional generalization; 92.9–96.8% few-shot instruction accuracy; 99%+ novel rule acquisition; GPT-4 fragility diagnostic
- [TIWM](wiki/entities/tiwm-model.md) — **(brainstorm)** Proposed architecture for latent-edge discovery: extends TEM with an Inverse Path Integrator that infers hidden transformation rules from before/after pairs
- [TEM](wiki/entities/tem-model.md) — Factorized world model (g/x/p + W/M); emergent cell types; key results; limitations
- [CSCG](wiki/entities/cscg-model.md) — Clone cells for de-aliasing; Bayesian EM; fast/local; no cross-environment generalization
- [HTM / Thousand Brains Theory](wiki/entities/htm-thousand-brains.md) — ~150,000 cortical columns each miniaturizing the HC formation; sensorimotor coupling; consensus voting; hierarchical abstract path integration
- [Boltzmann Machine](wiki/entities/boltzmann-machine.md) — Hopfield + stochasticity + hidden units; contrastive Hebbian learning; partition function intractability; historical precursor to VAEs and FEP
- [Reservoir Computing](wiki/entities/reservoir-computing.md) — random fixed reservoir + linear readout; echo-state property; Fourier analogy; extreme W/M split; neocortex-as-reservoir interpretation
- [TRNN](wiki/entities/trnn-model.md) — Transient Trajectory RNN; three modifications (self-inhibition, sparse, hierarchical); neuron-count-limited WM capacity; outperforms attractor RNN on all evaluated tasks
- [LISA](wiki/entities/lisa-model.md) — symbolic-connectionist analogy model; gamma-band temporal synchrony for role-filler binding; ≤2–3 proposition WM capacity; schema induction from two analogs
- [COVIS](wiki/entities/covis-model.md) — dual-system categorization (hypothesis-testing + procedural BG RL); precursor meta-learning dual-loop architecture; dissociable by feedback delay and DA depletion

### Benchmarks
- [ARC-AGI](wiki/entities/arc-agi.md) — fluid intelligence benchmark; three versions (static puzzles → reasoning models → interactive agents); Core Knowledge Priors; ARC-AGI-2 three capability gaps mapped to Blocks 3A/3B/3C

### Biological Systems
- [Prefrontal Cortex (PFC)](wiki/entities/prefrontal-cortex.md) — goal maintenance; SEC storage; hierarchical BA-8→9/46→10 gradient; meta-RL substrate; mapping to Blocks 3A–3D
- [Basal Ganglia](wiki/entities/basal-ganglia.md) — direct/indirect pathway opponent system; D1/D2 cellular mechanisms (PKA→LTP, EC→CB1→LTD); up-state bistability; cholinergic temporal gating; BG-PFC stripe gating; PVLV cellular substrate
- [Hippocampal-Entorhinal System](wiki/entities/hippocampal-entorhinal-system.md) — MEC/LEC/HC anatomy; map vs. memory dual role; HC bootstraps cortex
- [Grid Cells](wiki/entities/grid-cells.md) — SR eigenvectors = structural code `g`; periodic, environment-invariant, path integration substrate; emerge in TEM unsupervised
- [Place Cells](wiki/entities/place-cells.md) — SR rows = conjunctive code `p = f(g,x)`; remap non-randomly; latent-state variants (splitter, lap, evidence cells)
- [Insect Central Complex (CX)](wiki/entities/insect-central-complex.md) — ring attractor heading; P-EN path integration; PFL goal vector; full Drosophila connectome known; cleanest ML target for allocentric world model
- [Arthropod Mushroom Bodies](wiki/entities/arthropod-mushroom-bodies.md) — Kenyon cell expansion→MBON compression; olfactory associative learning (established); spatial memory in jumping spiders (tentative); HC-like contextual binding role
- [Cephalopod Vertical Lobe](wiki/entities/cephalopod-vertical-lobe.md) — (tentative) amacrine expansion → large-field-cell compression; DG→CA3 topological analog; lesion-confirmed spatial learning; ~500 Mya independent
- [Crustacean Hemiellipsoid Bodies](wiki/entities/crustacean-hemiellipsoid-bodies.md) — (tentative) Kenyon-like expansion; place-cell-like activity in crabs; mantis shrimp disproportionate size
- [Polychaete Annelid Mushroom Bodies](wiki/entities/polychaete-mushroom-bodies.md) — Kenyon-like motif in Nereis/Platynereis; ~600 Mya; deep homology vs. convergence actively debated

---

## Queries

- [TEM: Implementation vs Theory](wiki/queries/tem-implementation-vs-theory.md) — Six divergences between TF2 code and paper description
- [Direction Evaluation: Allocentric Navigation as the Key to Latent Graph Reasoning](wiki/queries/allocentric-navigation-direction-evaluation.md) — Verdict: HC/MEC formation (not CX alone) is the right core; vmPFC/DMN needed for abstraction; transformation inference is the critical missing module
- [Building Blocks for MEC/HC/PFC Brain-Inspired Model](wiki/queries/building-blocks-mec-hc-pfc.md) — 11-block decomposition: what biology does, what TEM implements, available ML tools, and how to bridge each gap; includes priority order for implementation
- [Lint Report (second pass) — 2026-06-20](wiki/queries/lint-2026-06-20b.md) — Second full lint pass after 13-paper ingest batch; orphaned cognitive-map paper, 2 stale dates, TRNN under-linking, 32 missing glossary entries, missing first-use expansions across 5 pages
