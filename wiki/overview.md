---
title: "Overview — Brain-Inspired Models for Abstract Reasoning"
type: overview
tags: [overview, abstract-reasoning, brain-inspired-ai]
created: 2026-06-20
updated: 2026-06-25
sources: [TEM.pdf, cognitivemap.md, gridlikecode.md, t-TEM.md, engram-transcript, cross-entropy-first-principles-transcript, free-energy-principle-transcript, brain-learning-algorithm-transcript, brain-learning-limits-transcript, memory-gate-transcript, 150000-mini-brain-transcript, convergence-wiring-transcript, bolzman-machine-transcript, reservoir-computing-transcript, jumping-spiders-cognition, landmark-orientation.md, convergent-brain-structures-transcript, metalearning-neuromodulation-doya-2002, pfc-meta-rl-wang-2018, pbwm-oreilly-frank-2006, compositionality-decomposed-hupkes-2020, mlc-lake-baroni-2023, trnn-liu-2025, stsp-kozachkov-2022, transformer-wm-limit-gong-2024, pfc-cognitive-control-friedman-2021, pfc-wood-grafman-2003, arc-agi-overview, arc-agi-3-paper, hopfield-networks-crouse-2022, ca3-sammons-2023, pattern-completion-rolls-2013, cls-oreilly-2011, cls-mcclelland-1995, podlaski-context-modular-memory-2025, learning-fast-slow-liao-2024, building-machine-thinks-like-people-lake-2016, analogy-holyoak-2012, ahmad-hawkins-sdr-2016, yassa-stark-pattern-separation-2011, dicarlo-visual-object-recognition-2012, gerfen-surmeier-dopamine-striatum-2011, helie-ccn-bg-2013, bogacz-gurney-bg-msprt-2007, douglas-martin-neocortex-2004, bastos-canonical-microcircuit-2012, Equilibrium Propagation Bridging the Gap, scellier-bengio-eqprop-2017, bartunov-scalability-bio-dl-2018, bengio-bioplausible-dl-2015, theories-backprop-brain-whittington-2019, maass-lsm-2002, maass-snn-third-gen-1997, snn-encoding-auge-2021, tavanaei-deep-snn-2018, gardner-gruning-supervised-snn, gnw-mashour-2020, ferrante-adversarial-gnwt-iit-2025, raccah-pfc-consciousness-2021, spiking-tem-kawahara-2025, lecun-path-towards-autonomous-intelligence-2022, vicreg-bardes-2022, assran-ijepa-2023, vl-jepa-chen-2025, v-jepa-2-assran-2026, leworldmodel-maes-2026, hit-jepa-li-2025, lejepa-balestriero-lecun-2025, lecun-jepa-critical-review-lett-2025, vla-survey-kawaharazuka-2025, vlm-intro-bordes-2024, arc-prize-2025-technical-report, shortcut-learning-geirhos-2020, shortcut-suite-yuan-2024, beger-conceptarc-multimodal-2025, odouard-2022-concept-evaluation, adversarial-nli-nie-2020, choi-intelligence-density-2026, joffe-vsa-arc-2025, glazer-frontiermath-2024, gpqa-rein-2024, mei-multimodulatory-continual-2025, safron-iwmt-expanded-2022, inferential-reasoning-dupret-2020, sun-hippocampal-osm-2025, hami-poursiami-2025, taniguchi-world-models-pc-robotics-2023, kessler-continual-dreamer-2023]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/predictive-coding.md, wiki/concepts/neural-manifolds.md, wiki/concepts/neuromodulation.md, wiki/concepts/meta-learning.md, wiki/concepts/working-memory.md, wiki/concepts/cognitive-control.md, wiki/concepts/compositional-generalization.md, wiki/concepts/convergent-allocentric-coding.md, wiki/entities/equilibrium-propagation.md, wiki/concepts/canonical-microcircuit.md, wiki/entities/snn.md, wiki/entities/tem-model.md, wiki/entities/tiwm-model.md, wiki/entities/arc-agi.md, wiki/entities/basal-ganglia.md, wiki/entities/prefrontal-cortex.md, wiki/entities/gwt-model.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/world-models.md, wiki/concepts/intelligence-density.md, wiki/entities/jepa-model.md, wiki/entities/vsa-model.md, wiki/entities/iwmt.md]
---

# Overview — Brain-Inspired Models for Abstract Reasoning

---

## The Central Thesis

Current deep learning fails at out-of-distribution systematic generalization. Biological brains do not. The hypothesis: the brain treats all reasoning as **latent graph discovery** — infer the hidden relational structure of a domain from observations, then navigate it. The key architectural principle enabling this is **factorization of structural knowledge from sensory content**, extended by a BG (Basal Ganglia)/PFC control layer that gates, modulates, and hierarchically structures the inference process. The hardware is spiking cortical columns running a canonical microcircuit; the learning algorithm is contrastive Hebbian at energy equilibrium. Formal grounding: a system **knows** a domain (Choi 2026) when its intelligence density $\mathcal{I} = \log_2 N / C \to \infty$ as the domain scales — a criterion recurrent/iterative architectures can satisfy but fixed-depth feedforward networks cannot.

---

## Master Problem Framing: Latent Graph Discovery

> **Latent graph discovery = infer the structure (nodes, edges, topology) of a relational graph from observations, then navigate it — where the graph is never given explicitly.**

Every cognitive task reduces to which graph component is hidden:

| Latent component | Observed | Canonical examples |
|---|---|---|
| **Edges** (transformation rules) | Start + end node pairs | ARC-AGI, IQ tests, analogy tasks; FrontierMath (applicable theorems) |
| **Path** (sequence of edges) | Start + end nodes | Navigation, planning; OlymMATH-HARD (partial vocabulary); FrontierMath (vocabulary near-zero) |
| **Node content** (partial state) | Path + partial content | Algebra, physics, constraint satisfaction; **GPQA** (graduate-level causal-chain reasoning, google-proof) |
| **Graph topology + edges** | Observations only | Scientific discovery, causal learning |

Every domain has a **two-level hierarchy**: a slow meta-graph (shared rules across episodes) and a fast instance-graph (task-specific topology). Systems that conflate these levels must relearn rules from scratch for every new problem. The W/M two-timescale split ([[wiki/concepts/two-learning-timescales.md]]) is the direct computational implementation: W = meta-graph, M = instance-graph.

**Primary empirical target:** ARC-AGI — latent edge discovery from sparse (before, after) grid pairs. ARC-AGI-2 resists brute-force (frontier AI <3%). ARC-AGI-3 extends to interactive agents that must also discover the target goal. **VSA/HRR isolates the bottleneck:** 94.5% Sort-of-ARC (pre-given DSL) → 3% ARC-AGI-1-Eval (open DSL) = vocabulary co-discovery is the residual gap once path integration and binding are solved (Joffe & Eliasmith 2025).

**Hardness source 5 — spurious edge covariate shift:** training observations contain false edges that work i.i.d. but fail o.o.d. ANLI (Nie et al. 2020) quantifies this cleanly: NLI hypothesis-only baseline 72% IID → 42–51% when the spurious H→label edge is adversarially blocked, forcing traversal of the true P→H entailment edge. Larger LLMs are *more* susceptible (inverse scaling paradox, Yuan 2024) — capability accumulation amplifies false-edge availability. CoT (Chain of Thought) partially bypasses shortcuts by forcing multi-hop traversal rather than single shortcut edges, but cannot fix incorrect edge vocabularies.

---

## Current Best Understanding

### Six Core Architectural Principles

| # | Principle | Brain substrate | Why needed |
|---|-----------|----------------|------------|
| 1 | **Factorize structural code from sensory code** | g (MEC) vs. x (LEC) | Structure W generalizes; content stays environment-specific. Without factorization, relational generalization lies outside the model's reachable manifold — structurally impossible regardless of training |
| 2 | **Maintain latent states via path integration** | HC / g-update RNN | De-alias observations; compress rule learning to O(relation types) not O(transitions) |
| 3 | **Two-timescale learning** | Slow W (cortex/MEC) + fast Hebbian M (HC) | Slow W builds shared meta-graph; fast M stores episode-specific instance-graph |
| 4 | **Gate and modulate via BG (Basal Ganglia)/neuromodulation** | Basal ganglia + DA/ACh/5-HT/NA | Credit assignment: D1→LTP (Go), D2→LTD (NoGo) from a single phasic Dopamine event; ACh gates storage vs. retrieval |
| 5 | **Hierarchical control** | PFC (Prefrontal Cortex) rostro-caudal gradient (BA-8 → BA-9/46 → BA-10) | Rules about rules: lower levels handle stimulus-response; mid-lateral maintains task-set context; frontopolar manages branching rule chains |
| 6 | **Canonical hardware substrate** | L4→L2/3→L5→L6→L4 microcircuit | Recurrent amplification of weak inputs; horizontal WTA (Winner-Take-All) selects hypotheses; SLN% (proportion of Superficial Layer Neurons) encodes hierarchy; explore (superficial) / exploit (deep) split maps to inference / action |

### Key Unification Results

- **TEM = transformer** — the factorized key/value structure (Q=K=f(g), V=f(x)) follows necessarily from the outer-product memory; Hopfield ↔ attention is grounded in the Boltzmann distribution (softmax IS P ∝ exp(−E/T))
- **Grid cells = SR (Successor Representation) eigenvectors = optimal path-integration bases** — the periodic grid code is optimal for graph matching and multi-step planning via the same mechanism
- **Place cells = SR (Successor Representation) rows = p = f(g, x)** — "anomalous" HC cells (splitter, lap, evidence) are the same model with hidden task dimensions added to the graph
- **FEP grounds TEM's objective** — the two-timescale training objective (slow W, fast M) is the factorized ELBO; all cross-entropy training is Bayesian brain inference
- **EqProp proves local Hebbian is exact backprop** — Theorem 1 (Scellier & Bengio 2017): ΔW ∝ (1/β)[ρ(u^β)ρ(u^β) − ρ(u⁰)ρ(u⁰)] computes ∂J/∂W exactly as β→0; the free phase IS the inference phase; no separate backward circuit required. Resolves the theoretical half of Gap 4.
- **Canonical microcircuit = canonical PC (Predictive Coding) circuit** — Bastos et al. 2012 maps PC's error/prediction split onto L2/3 (error, gamma, feedforward) vs. L5/6 (prediction, beta, feedback); spectral asymmetry is a mathematical consequence of the laminar anatomy
- **D1/D2 opponent plasticity = cellular credit assignment** — a single phasic Dopamine event simultaneously drives PKA→LTP in direct (Go) SPNs and EC→CB1→LTD in indirect (NoGo) SPNs; credit assignment in the brain is structurally opponent, not scalar
- **PVLV implements this biologically** — Dopamine drives slow W update; ACh gates the M write/read switch; NA (Noradrenaline / Norepinephrine) sets exploration breadth; 5-HT sets planning horizon
- **SNN type B > sigmoidal > threshold** — Maass 1997 Theorem: a single type B spiking neuron computes CD_n (coincidence detection) with Ω(n²) fewer sigmoidal units. Synchrony codes are exponentially cheaper than rate codes for binding.
- **Intelligence density formalizes knowing** — Choi 2026: $\mathcal{I}(S) = \log_2 N(S) / C(S)$ unifies Legg-Hutter $\Upsilon$, Chollet's efficiency metric, and Kolmogorov complexity under one criterion; a system *knows* a domain iff $\mathcal{I}(n) \to \infty$ as domain scales; recurrence is the minimal architectural condition; feedforward networks are provably bounded to $\mathcal{I} = \Theta(1)$
- **Mode-2 ≠ System II (Lett 2025)** — LeCun's Mode-2 planning (MPC with learned world model + hard-wired search) is stochastically deterministic: same algorithm, same world model → same plan. True System II requires the *search/planning algorithm itself* to be learned. V-JEPA 2-AC concretizes Mode-2 at scale: CEM in latent space achieves zero-shot pick-and-place (65–80% success) but relies on a fixed CEM algorithm — the planning procedure is not adapted.
- **Representation-space prediction outperforms generative for planning** — V-JEPA 2-AC vs. Cosmos (pixel-space): 65–80% pick-and-place success vs. 0%; 16 sec/action vs. 4 min/action; VL-JEPA (1.6B) outperforms GPT-4o, Claude-3.5, Gemini-2.0 on WorldPrediction-WM (65.7%) without generating a token

### The Learning Algorithm Lineage

```
Hopfield (1982)
  ↓ stochastic → Boltzmann Machine (1985) — learns P(data); intractable Z
      ↓ CHL (Contrastive Hebbian Learning) approximation of BM gradient
Contrastive Hebbian Learning (Movellan 1990)
  ↓ full clamp (β→∞) → mode-mismatch bug (J_CHL can be negative)
Equilibrium Propagation (Scellier & Bengio 2017)
  ↓ weak nudge (β small) → exact gradient via Theorem 1; no backward circuit
      [Parallel track]
Predictive Coding / FEP
  ↓ local error propagation; replaces Z with tractable F = −ELBO
TEM (2020) / TEM-t (2022)
  ↓ factorized ELBO; cross-environment structural transfer; emergent grid/place cells
TIWM (proposed)
  ↓ adds inverse path integrator: infer latent edge labels from (g_in, g_out) pairs
```

**Biologically plausible learning (Gap 4):** Bartunov et al. 2018 ([[wiki/papers/bartunov-scalability-bio-dl-2018.md]]) quantified the scaling gap — FA, DTP, SDTP all reach >93% top-1 error on ImageNet vs. backprop's 71%. EqProp excluded (computationally prohibitive at scale). The exactness-vs-symmetry tradeoff between EqProp (exact, requires W_{ij}=W_{ji}) and TP (biased approximation, no symmetry constraint) is the unresolved practical design choice. Analog hardware that physically relaxes to equilibrium is the expected substrate for EqProp at scale.

### Architecture Determines Feasibility

Neural manifold constraints ([[wiki/concepts/neural-manifolds.md]]) make this an architectural necessity, not an efficiency preference:

- Standard transformer: abstract relational generalization **outside its intrinsic manifold** — unreachable regardless of training or scale
- TEM's g/x factorization: relational generalization **inside its reachable manifold by construction**
- LLMs/LRMs: knowledge-bounded — in-context fast loop cannot generalize beyond pretraining distribution to genuinely novel graph structures (McClelland 1995 theorem instantiation)

**Shortcut reasoning as the measurement problem:** Beger et al. 2025 show that standard accuracy metrics conflate shortcut solutions (correct output, wrong reasoning) with genuine concept acquisition. AI models produce correct-unintended rules ~27–29% of the time on ARC (humans ~5%), exposing that benchmark accuracy inflates apparent abstraction. **Missing objectness prior:** the most systematic ARC failure — models treat grids as pixel matrices, not scenes of discrete bounded entities. Token-prediction training never acquires Spelke's Core Knowledge objectness (persistence, coherent movement, boundaries); this is architectural, not a data-scale problem. See [[wiki/concepts/shortcut-reasoning.md]].

### The W/M Split Spectrum

| Model | Structural basis (W) | Task-specific code (M) | Timescale |
|---|---|---|---|
| Reservoir computing | Random, frozen | Linear readout, one-shot | W never trained; LSM Theorem 1: universal fading-memory with separation property |
| TEM | Slow backprop across environments | Hebbian, per-environment | W: slow; M: fast |
| Standard DNN | Jointly trained (entangled) | None (no factorization) | Single timescale |
| Meta-RL LSTM (Wang 2018) | Outer-loop weights = slow W | Hidden state = fast M policy | W: meta-training; M: within-episode |
| **VSA/HRR (Joffe 2025)** | None — pre-given DSL + circular convolution | SSP path integration per task | No slow W; isolates vocabulary co-discovery as the residual gap |

**Reservoir → TEM gap (Gap 5):** LSM establishes universal fading-memory as the starting condition; TEM W is the endpoint (structured, transferable basis). How in-liquid plasticity adapts toward natural stimulus distributions, and how structural W emerges from a random basis without destroying universality, is open.

### The Extended Architecture: 11 Functional Blocks + GNW (Global Neuronal Workspace) Hub

The full model decomposes into three regions plus a broadcasting hub (see [[wiki/queries/building-blocks-mec-hc-pfc.md]]):

**MEC (structural engine):** 1A Grid substrate (toroidal g) → 1B Path integration (continuous SO(N) rotation) → 1C Landmark correction (Kalman update)

**HC (fast binding):** 2A Bidirectional binding (g↔x) → 2B Pattern completion (iterative modern Hopfield) → 2C Importance gate (SWR/prediction-error write) → 2D Sparse allocation (top-k engram)

**PFC (hierarchy and goals):** 3A Transformation Inferrer — **critical missing block** (inverse path integrator; set-attention over Δg → W posterior) → 3B Working memory (TRNN episodic + meta-RL LSTM policy) → 3C Hierarchical stack (three-level: BA (Brodmann Area)-10 → BA (Brodmann Area)-9/46 hub → BA (Brodmann Area)-8) → 3D Goal generator (g_goal → argmin W)

**GNW Hub (broadcasting):** Long-range L2/3+L5 neurons select one representation from competing processor outputs and ignite global broadcasting via NMDA recurrence (~300ms onset). This provides the workspace-update mechanism between PFC (Prefrontal Cortex) reasoning cycles — but **offset ignition is absent** (Ferrante 2025), meaning the release/replacement mechanism is empirically unspecified. PFC (Prefrontal Cortex) encodes abstract category (not identity/orientation), confirming the abstract-hub/perceptual-satellite architecture: the hub manages relational tokens, not sensory pixels.

**IWMT synthesis:** Safron 2022 proposes that the hub should implement turbo-coding — inter-level loopy belief propagation that iteratively refines predictions across cortical hierarchy levels. SOHMs (Spherical Organizing Hierarchical Maps) broadcast via the rich-club network, achieving integrated spatiotemporal-causal world modeling. This is a theoretical synthesis of IIT, GNWT, and FEP-AI; empirical validation is open. See [[wiki/entities/iwmt.md]].

**Hardware layer:** Each region implements the **canonical microcircuit** — L4 receives afferent input (thalamic or long-range cortical), seeds recurrent amplification via the L4→L2/3→L5→L6→L4 loop, and selects hypotheses via horizontal WTA (Winner-Take-All) inhibition. Feedforward projections (L3→L4, gamma, high SLN%) carry prediction errors; feedback projections (L5/6→L1/5/6, beta, low SLN%) carry predictions. The laminar anatomy enforces the PC (Predictive Coding) message hierarchy structurally.

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

Conclusion: this motif is not just a good design choice — **convergent evolution argues it is near-optimal** for the computational problem of allocentric world modeling. The insect CX (Central Complex) is the cleanest ML implementation target (full Drosophila connectome known; ring attractor confirmed in vivo by Seelig & Jayaraman 2015). HC adds cross-environment W generalization that no other system has demonstrated.

---

## Key Open Problems

1. **Type 2 task gap (transformation inference)** — TEM and all current factorized models require the action vocabulary to be given externally. Discovering latent edge labels from (observation_before, observation_after) pairs — as required by ARC-AGI — is architecturally absent. TIWM proposes the Inverse Path Integrator as a bridge but is unimplemented.
2. **Multi-level meta-graph** — flat W cannot represent compositional rule chains (apply rule A, get context for rule B). Three-level PFC (Prefrontal Cortex) hierarchy (Block 3C) needs formalization as a nested latent graph.
3. **Vocabulary co-discovery** — the action alphabet itself must be inferred alongside graph structure. LAPA (VLA survey 2025) demonstrates vocabulary co-discovery via VQ-VAE on frame differences, but is domain-specific. No model handles vocabulary co-discovery with cross-environment meta-graph generalization simultaneously.
4. **Biologically plausible slow W** — EqProp (Scellier & Bengio 2017) resolves the theoretical problem: local contrastive Hebbian at equilibrium computes exact gradients. The practical problem remains: symmetric weights required; free-phase depth scaling is exponential on digital hardware; no large-scale empirical validation. Targetprop is the alternative (no symmetry required, but high-bias; Bartunov 2018 shows both fail at ImageNet). Analog neuromorphic hardware is the expected resolution path.
5. **Reservoir → structured basis** — LSM Theorem 1 establishes universal fading-memory as the starting condition; TEM W is the endpoint (structured, transferable). The developmental trajectory — how in-liquid plasticity tunes separation property toward natural statistics, and how W emerges without destroying universality — is unspecified.
6. **Active inference** — FEP (Free Energy Principle) extended to minimize expected future free energy (epistemic foraging) connects to goal-directed reasoning; formalism resolved (G(π) = epistemic + pragmatic value; Taniguchi 2023); architectural integration into the 11-block model unresolved. Mode-2 (CEM, non-probabilistic) vs. active inference (probabilistic posterior over z) design choice open.
7. **Workspace release/update mechanism** — Ferrante 2025 shows PFC (Prefrontal Cortex) offset ignition is absent at content transitions; no current architecture specifies how the GNW (Global Neuronal Workspace) hub releases one representation and admits the next. Must design an explicit workspace-update trigger.
8. **Abstract hub / perceptual satellite split** — Ferrante 2025 shows PFC (Prefrontal Cortex) encodes category but not identity or orientation; a reasoning model needs two distinct tiers: (a) a hub module operating on discrete/abstract representations + (b) a posterior module maintaining fine-grained perceptual content. The binding interface between these tiers is unspecified.
9. **Objectness prior** — Beger et al. 2025 show frontier AI systematically lacks Spelke's Core Knowledge objectness prior on ARC (objects persist, move coherently, have boundaries). Token-prediction training does not produce objectness representations; ~27–29% of AI "correct" ARC solutions use pixel/connectivity shortcuts (vs. ~5% humans). The architectural mechanism for acquiring discrete-entity priors without hand-coding maps to Blocks 1A+1B (structural scaffold) and remains open.

---

## Promising Directions

- **TIWM (Block 3A)** — highest-impact addition to TEM; enables Type 2 / ARC-AGI tasks. Architecturally: set-attention over Δg vectors to produce soft posterior over W vocabulary; W jointly trained by forward and inverse path integration
- **EqProp on analog hardware** — the theoretical barrier to biologically plausible slow-W is resolved (Theorem 1); the path forward is analog circuits that physically relax to equilibrium (eliminating the O(L³) digital free-phase cost). Memristor/phase-change crossbar arrays are the candidate substrate.
- **JEPA world models for planning** — V-JEPA 2-AC (Assran et al. 2026) validates representation-space Mode-2 planning at scale: CEM in latent space achieves zero-shot robot pick-and-place; temporally straight latent trajectories ([[wiki/concepts/world-models.md]]) simplify CEM search. Extension to abstract reasoning (ARC-AGI grid transformations) would require a JEPA trained on structured discrete transformations rather than video. Violation-of-expectation (VoE) probing detects whether the world model has internalized rules without labeled data.
- **Canonical microcircuit as architecture template** — the L4→L2/3→L5→L6→L4 loop is a solved recurrent-amplification + soft-WTA + two-output design. A reasoning model block that seeds a recurrent loop with a sparse goal signal and reads out hypothesis selection (L2/3 WTA) and action (L5) separately is more anatomically faithful than flat transformer layers.
- **TEM + CSCG unification** — fast de-novo mapping (CSCG) for novel environments + structural transfer (TEM) for familiar domains; would formalize the HC map → memory transition
- **TRNN for working memory (Block 3B)** — self-inhibition + sparse + hierarchical topology; outperforms attractor RNN on WM capacity, spatial navigation, distractor robustness; γ parameter approximates D1/D2 balance; directly applicable as the fast-M layer
- **Neuromodulation circuit as meta-learning** — DA/ACh/5-HT/NA jointly implement the outer metalearning loop; many-to-one interactions (Mei 2025) allow attractor landscape control and three-factor rules with NA as a surprise signal; D1/D2 cellular mechanisms now grounded at receptor level; connecting PVLV to the Block 3B WM gate is a tractable next step
- **SNN gamma-band binding** — LISA model demonstrates gamma-band temporal synchrony for role-filler binding at WM capacity ≤2–3 propositions; an SNN substrate at the binding stage (Block 2A/2B) would implement this with exponentially fewer units than a rate-coded equivalent (CD_n theorem)
- **Insect CX (Central Complex) as minimal implementation target** — ring attractor heading (1A/1B) + P-EN path integration (1B) + PFL goal vector (3D) fully instantiated in a known connectome; a CX-inspired module could provide the MEC core without requiring emergence
- **Dual-channel ARC evaluation** — Beger et al. 2025's accuracy + rule-quality evaluation exposes the accuracy/abstraction dissociation; implementing this for ARC-Prize scoring would force genuine concept acquisition rather than shortcut exploitation

---

## Major Controversies

- **Type 1 vs. Type 2 boundary** — the wiki assumes TEM handles Type 1 (familiar environments, known transformation vocabulary) and TIWM handles Type 2 (novel transformation rules); whether this is the right decomposition or whether a unified model can handle both is open
- **GNW offset ignition absent (Ferrante 2025)** — preregistered adversarial collaboration (n=256, fMRI+MEG+iEEG) confirms onset ignition but finds no PFC (Prefrontal Cortex) offset ignition at content transitions; GNW's symmetric onset/offset prediction fails the causal test; constitutive vs. enabling PFC (Prefrontal Cortex) role is the active resolution. Both GNW (Global Neuronal Workspace) and IIT (Integrated Information Theory) failed at least one preregistered prediction — no clean winner.
- **PFC constitutive vs. enabling** — iES null result (Raccah 2021, n=100 intracranial) and category/identity dissociation (Ferrante 2025) both challenge GNW's claim that PFC (Prefrontal Cortex) activity *constitutes* conscious experience; the working resolution is that PFC (Prefrontal Cortex) is necessary but not sufficient (enabling), with the posterior cortex as the constitutive locus. Architectural implication: the hub module manages selection, not the phenomenal content.
- **TBT evolutionary claim** — that every cortical column recapitulates the HC formation (MEC/LEC/HC as L6/L4/L2-3) is interpretive; significant circuit differences exist; efference copy driving L6 confirmed only in motor cortex
- **Manifold plasticity** — motor cortex manifold constraints shown hard (BCI reversal failure); HC manifold appears more plastic (UMAP drifts with learning); whether hard structural manifold boundaries exist throughout cortex is empirically open
- **Grid code universality** — abstract grid codes shown in vmPFC during 2D conceptual navigation (Constantinescu 2016); extension to non-2D domains (causal graphs, linguistic structure) is unconfirmed
- **EqProp exactness vs. practical viability** — Theorem 1 is exact in the limit β→0; finite β introduces approximation; symmetric weights required; no result beyond MNIST. The claim that EqProp is the resolved solution to Gap 4 is theoretical only — experimental validation at scale is absent.
- **CA3 connectivity and capacity** — Sammons 2023 found 9–11% pyramidal-to-pyramidal connectivity (10× above prior estimates); this significantly increases estimated biological capacity but is a single dataset
- **Mode-2 as System I** — Lett 2025 argues that LeCun's Mode-2 planning (MPC with hard-wired CEM) is deterministic System I behavior, not flexible System II; genuine System II requires learning the planning algorithm itself. V-JEPA 2-AC's success validates Mode-2 mechanically but leaves the System II gap open. Simultaneous plasticity of world model + cost + control algorithm requires a stabilizing meta-management architecture (currently unspecified).
- **Shortcut rate interpretation** — Beger et al. 2025 report ~27–29% shortcut rate on ConceptARC "correct" solutions; this measures rule quality, not task success. Whether this rate reflects an intrinsic limitation of discriminative training or a fixable data/evaluation issue is contested; the objectness prior analysis suggests it is architectural.

---

## Source Count

Papers: **129** | Concepts: **45** | Entities (models): **25** | Entities (benchmarks): **5** | Entities (biological): **11** | Queries: **3**
