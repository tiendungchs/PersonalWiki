---
title: "Open Problems"
type: overview
tags: [open-problems, architectural-gaps, tensions, priority]
created: 2026-06-22
updated: 2026-06-23
sources: []
related: [wiki/overview.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/entities/arc-agi.md, wiki/entities/gwt-model.md]
---

# Open Problems

Read at the start of every session. Update when new gaps or tensions surface.

---

## Architectural Gaps

Capabilities the target reasoning model needs but that no current page fully addresses.

| # | Gap | Block | Status |
|---|-----|-------|--------|
| 1 | **Transformation inference (Block 3A)** — no current architecture infers latent edge labels from (observation_before, observation_after) pairs; required for ARC-AGI Type 2 tasks | 3A | TIWM proposed but unimplemented |
| 2 | **Multi-level meta-graph** — flat W cannot represent compositional rule chains; Block 3C three-level PFC hierarchy needs formalization as a nested latent graph | 3C | Partially specified anatomically; not formalized computationally |
| 3 | **Vocabulary co-discovery** — the action alphabet must be inferred alongside graph structure; no current model handles both simultaneously without a pre-given symbol set. **Partial solution:** LAPA (VLA survey 2025) learns a discrete action codebook jointly with a visual world model via VQ-VAE on frame differences — demonstrates vocabulary co-discovery is tractable; limitation is domain-specificity (manipulation video only, no cross-environment meta-graph generalization) | 3A | Partial (LAPA) |
| 4 | **Biologically plausible slow W** — PC local updates (`Δw ∝ ε·x`) support within-network learning; cross-environment structural W-generalization via local rules remains open. Two main candidates: **(a) EqProp (Scellier & Bengio 2017)** — theoretically exact (Theorem 1) via two-phase energy minimization; ΔW ∝ (1/β)[ρ(u^β)ρ(u^β) − ρ(u⁰)ρ(u⁰)] computes ∂J/∂W exactly as β→0; but requires symmetric weights W_{ij}=W_{ji} and has not been scaled beyond MNIST. **(b) Targetprop (Bengio et al. 2015)** — high-bias approximation via DAE theorem: gradient ≈ [f(g(h))−h]/σ²; no weight symmetry required (f and g trained independently); frames learning as variational EM (E-step = inference dynamics, M-step = local weight update); demonstrated on MNIST, collapses at ImageNet. **Bartunov et al. 2018 quantify the gap**: FA/DTP/SDTP all >93% top-1 error on ImageNet vs. BP's 71%; EqProp excluded (computationally prohibitive). Target diversity (low-entropy output alphabet) is a concrete TP bottleneck. The exactness-vs-symmetry tradeoff between EqProp and targetprop is the unresolved design choice. See [[wiki/entities/equilibrium-propagation.md]]. | 2A–2D | Open |
| 5 | **Reservoir → structured basis** — **LSM Theorem 1 (Maass et al. 2002) establishes the starting point**: a generic random liquid with SP already achieves universal fading-memory computation. TEM W is the endpoint: a structured basis transferable across environments. The gap is two-fold: (a) how in-liquid plasticity (explicitly proposed by Maass et al. as necessary for developmental SP tuning) adapts SP toward natural stimulus distributions, and (b) how structural W gradually emerges from a random reservoir through learning while preserving the universality guarantee. | 1A | Open |
| 6 | **Active inference** — expected free energy / epistemic foraging (FEP extended) connects to goal-directed reasoning; not yet formalized in the 11-block architecture. LeCun's Mode-2 (MPC via world model) is the non-probabilistic analog; relationship between Mode-2 and FEP active inference needs clarification | 3D | Open |
| 7 | **Workspace release/update mechanism** — Ferrante 2025 shows PFC offset ignition is absent at content transitions; no current architecture specifies how the global broadcasting hub releases one representation and admits the next; GNW-style hub design assumes symmetric onset/offset, but the evidence only supports onset; must design an explicit workspace-update trigger | Hub module | Open |
| 8 | **Abstract hub / perceptual satellite split** — Ferrante 2025 shows PFC encodes category but not identity or orientation; a reasoning model therefore needs two distinct tiers: (a) a hub module operating on discrete/abstract representations + (b) a posterior module maintaining fine-grained perceptual content; the binding interface between these tiers (how the hub selects and queries the satellite) is unspecified | Hub module | Open |

---

## Empirical Tensions

Active contradictions between sources. See the flagged pages for details.

| Tension | Pages | Status |
|---------|-------|--------|
| **DA = precision (Friston 2009) vs. DA = TD error (Doya 2002)** — Friston places DA in the prior-precision tier; Doya places it as the reward prediction error signal; partial reconciliation via incentive salience | [[wiki/concepts/neuromodulation.md]], [[wiki/papers/friston-free-energy-2009.md]], [[wiki/papers/metalearning-neuromodulation-doya-2002.md]] | Partially reconciled; not resolved |
| **GNW offset ignition absent (Ferrante 2025)** — preregistered adversarial collaboration finds no PFC offset ignition at content transitions; GNW prediction fails causal test | [[wiki/entities/gwt-model.md]], [[wiki/papers/ferrante-adversarial-gnwt-iit-2025.md]] | Contradiction flagged in gwt-model.md |
| **CA3 connectivity (Sammons 2023: 9–11% vs. Guzman 2016: <1%)** — 10× discrepancy; Sammons dataset is a single preparation | [[wiki/concepts/associative-memory.md]], [[wiki/papers/ca3-sammons-2023.md]] | Contradiction flagged; needs replication |
| **PFC consciousness role** — iES null result (Raccah 2021) and content-specificity dissociation (Ferrante 2025) both challenge GNW's constitutive claim; constitutive vs. enabling distinction is the working resolution | [[wiki/entities/prefrontal-cortex.md]], [[wiki/entities/gwt-model.md]] | Partially resolved by constitutive/enabling distinction |

---

## Priority Tasks

Concrete tasks from the most recent lint pass (2026-06-23). All quick fixes completed 2026-06-23.

**Resolved 2026-06-22:**
- ~~`wiki/concepts/gwt.md`~~ — `wiki/entities/gwt-model.md` already exists and covers GNW/GWT comprehensively; no separate concept page needed ✓
- ~~`wiki/entities/snn.md`~~ — created; added to index-concepts.md ✓
- ~~COVIS and LISA orphan links~~ — Connection entries added to meta-learning, basal-ganglia, analogical-reasoning, binding-problem ✓
- ~~temporal-coding ↔ sequence-memory~~ — bidirectional Connection entries added ✓
- ~~path-integration → ring-attractor and A-CANN~~ — Connection entries and frontmatter updated ✓
- ~~First-use expansions~~ — MHN (sequence-memory.md), CLSU (hierarchical-representations.md), ITD (temporal-coding.md) ✓
- ~~Stale date on path-integration.md~~ — updated to 2026-06-22 ✓
- ~~28 missing glossary entries~~ — all added to wiki/glossary.md ✓

**Resolved 2026-06-23:**
- ~~Missing backlinks to equilibrium-propagation.md~~ — Connection added to predictive-coding.md ✓
- ~~Missing backlinks to snn.md~~ — Connection entries added to spike-frequency-adaptation.md, hebbian-learning.md, sparse-distributed-representations.md ✓
- ~~14 missing glossary entries~~ — AGI, AMPA, CHL, EqProp, EWC, FILT, GNW, IIT, LIF, NMDA, PSP, RBM, SLN, SNN added; GWT link fixed ✓
- ~~Index count mismatch~~ — index-papers.md updated from 81→83 stubs ✓
- ~~LIF first-use expansion in snn.md~~ — "Standard Leaky Integrate-and-Fire (LIF)" ✓

**Resolved 2026-06-23 (post-lint):**
- ~~**PGM/RAVEN benchmark entity page**~~ — `wiki/entities/pgm-benchmark.md` created; added to index-entities.md; linked from abstract-reasoning.md and pgm-barrett-2018.md ✓
- ~~**LISA glossary entry**~~ — added to wiki/glossary.md ✓

**Open (from ingest 2026-06-23 LeCun 2022):**
- **Configurator subgoal decomposition** — LeCun explicitly leaves the mechanism for decomposing complex tasks into ordered subgoals within the configurator unspecified; this is Gap 2/3C but the gap is now named precisely
- **Vocabulary co-discovery in H-JEPA** — Gap 3 (vocabulary co-discovery) maps directly to H-JEPA's pre-specified intermediate action vocabulary; JEPA cannot currently discover the abstract action alphabet alongside graph structure
- **Mode-2 vs. active inference reconciliation** — Gap 6: LeCun's Mode-2 (MPC + EBM) and Friston's active inference (FEP) are both simulation-based planning; formal comparison of what each adds is needed before selecting for the reasoning model

**Open (from ingest 2026-06-23 Critical Review — Lett 2025):**
- **Learned planning algorithm (true System II)** — Mode-2 (MPC with learned world model + *hard-wired* search algorithm) is System I: the search algorithm is fixed by the designer. True System II requires learning the search/reasoning algorithm itself alongside world model and cost. Design question: what architectural scaffold allows simultaneous plasticity of all three without catastrophic instability? A "meta-management" stabilizer (meta-level control over learning of reasoning) is required but unspecified — this is a deeper version of Gap 3C.
- **JEPA single-input inference gap** — JEPA requires a pair (x, y) to compute z as the x–y relational encoding; it cannot perform online single-observation inference the way PC can. For abstract reasoning tasks (ARC-AGI), the model must infer latent rules from a *single* observed transformation pair — JEPA's operational mode here is unclear. Does this require treating the (grid_before, grid_after) pair as the (x, y) JEPA inputs, making each puzzle a new contrastive pair rather than ongoing online inference?

**Open (from ingest 2026-06-23 VLA survey):**
- **LAPA → abstract vocabulary discovery** — LAPA discovers a motor action codebook from video; the open question is whether the same VQ-VAE-on-frame-differences approach scales to abstract (non-physical) transformation discovery, e.g., inferring ARC-AGI rule tokens from (grid_before, grid_after) pairs. The mechanism is structurally identical — the gap is whether visual frame differences encode anything meaningful for abstract rules.
- **ECoT latent-space analog** — ECoT generates subtask descriptions in token space before action tokens. A latent-space version (analogous to COCONUT) would maintain intermediate reasoning in continuous embedding space, avoiding the discrete bottleneck. Direct follow-on to the latent-space reasoning chain open problem below.

**Open (from ingest 2026-06-23 V-JEPA 2):**
- **Mode-2 planning concrete spec now available** — V-JEPA 2-AC operationalizes Gap 6 (Mode-2 MPC): frozen representation-space encoder + action-conditioned transformer predictor + CEM energy minimization + receding-horizon control. The Mode-2/active-inference comparison (Gap 6) can now be made concrete: V-JEPA 2-AC uses non-probabilistic CEM; FEP active inference uses posterior inference over z. Formal comparison: does the probabilistic posterior add value for abstract reasoning, or is non-probabilistic CEM sufficient?
- **Long-horizon planning via hierarchical world models** — V-JEPA 2-AC explicitly proposes hierarchical predictors at multiple spatial/temporal scales as the solution to long-horizon planning failure (error accumulation + exponential search space). This is the operational form of Gap 2 (multi-level meta-graph): each level of the hierarchy infers abstract sub-goals for the level below. Design question: does the hierarchy need to be pre-specified (as in V-JEPA 2-AC + sub-goal images) or can the levels emerge from training (H-JEPA)?
- **Abstract goal specification for world model planning** — V-JEPA 2-AC requires image goals; pick-and-place required manually specified sub-goal images. For abstract reasoning tasks (ARC-AGI), goal specification must be symbolic/linguistic and the world model must operate in an abstract (non-pixel) state space. The pipeline from V-JEPA 2 (physical world) → abstract goal (language or rule) → planner is the missing link connecting physical world models to abstract reasoning.

**Open (from ingest 2026-06-23 LeJEPA):**
- **N(0,I) optimality for abstract embedding spaces** — Theorem 1 (Balestriero & LeCun 2025) proves isotropic Gaussian uniquely minimizes downstream risk for continuous data manifolds. Gap 3 (vocabulary co-discovery) requires learning an action token codebook — a discrete or graph-structured embedding space. Whether N(0,I) remains the optimal target distribution when the "representation" is an abstract action symbol is unknown. If not, what is the optimal distribution for a discrete action vocabulary?

**Open (from ingest 2026-06-23 VL-JEPA):**
- **Joint visual-language representation learning** — VL-JEPA freezes the V-JEPA 2 encoder; the X-encoder never adapts to linguistic context. An architecture where visual representations are shaped by language prediction targets during training could learn more semantically structured visual features. Open question: does joint training improve structural generalization, or does modality separation improve each component's quality?
- **Latent-space reasoning chain** — VL-JEPA predicts a single embedding per query; it does not chain multiple prediction steps. VL-JEPA + a multi-step predictor (analogous to H-JEPA's hierarchical stacking) could potentially implement chain-of-thought in continuous embedding space — directly relevant to Gap 2 (multi-level meta-graph) and the COCONUT / Large Concept Models trajectory.

**Open (from ingest 2026-06-23 LeWorldModel):**
- **Temporal straightening in abstract spaces** — LeWM shows latent trajectories become approximately linear in physical environments (Push-T, OGBench-Cube) as an emergent property of SIGReg + prediction loss. Does this generalize to abstract transformation spaces (ARC-AGI grids, relational reasoning)? If a JEPA trained on grid transformations produces straight latent trajectories, that would mean rule-application sequences are linearly interpolable — dramatically simplifying planning in abstract rule space.
- **VoE as abstract rule verifier** — LeWM detects physically impossible events (teleportation) via prediction surprise. If a world model trained on ARC-AGI rule-pairs assigns higher surprise to logically impossible transformations, VoE becomes a zero-shot verifier for abstract rule learning — directly relevant to Gap 1 (Transformation inference) and the ARC-AGI-3 goal-discovery problem (which requires a learned verifier signal).
- **SIGReg lower dimensionality failure mode** — LeWM underperforms on TwoRoom (low-intrinsic-dimensionality environment) because forcing N(0,I) in high ambient dimensions creates too loose a prior. For abstract reasoning tasks where the relevant state space is genuinely small (e.g., ARC-AGI grid transformations), N(0,I) may be the wrong target distribution. What distribution is optimal for compact rule-structured representation spaces?

**Open (from ingest 2026-06-23 ARC Prize 2025 Technical Report):**
- **Zero-pretraining vs. warm-start efficiency crossover** — TRM (7M params, no pretraining) achieves 45% ARC-AGI-1; test-time training (NVARC, pretrained + TTT) achieves 24% ARC-AGI-2. At what task complexity or compute budget does warm-start (TTT) definitively outperform zero-pretraining? The current data suggests zero-pretraining competes on ARC-1 but lags on ARC-2; the crossover point is unknown and matters for the two-timescale learning design.
- **Refinement loops + ARC-AGI-3** — current refinement loops require an exact verifier (grid match). ARC-AGI-3 has no in-loop verifier and requires autonomous goal discovery. Does this completely break refinement loops, or can a learned verifier (from environment feedback) substitute? If the latter, the architecture needs a goal-model module that produces a verifier signal from unstructured environment transitions.
- **CompressARC MDL ↔ Solomonoff** — CompressARC uses VAE loss as a differentiable proxy for minimum description length. The AIXI ceiling is the Solomonoff prior (all programs weighted by 2^{-length}). Formal question: how tight is the VAE approximation? Can a better MDL proxy (e.g., neural algorithmic reasoning) close the gap between CompressARC's 20% ARC-1 and the theoretical ceiling?

**Open (from lint-2026-06-23):**
- **Ingest `raw/High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations.md`** — likely adds content to associative-memory.md or creates a new entity page; high priority
- **Ingest `raw/Improving the adaptive and continuous learning capabilities of artificial neural networks...`** — multi-neuromodulatory continual learning; relevant to Gap 4 and neuromodulation.md
- **Ingest `raw/KAN-ODEs...`** — KAN-ODE architecture; may be relevant to latent dynamics / LTC comparison
- **Assess `raw/generalization.md`** — possibly duplicates pgm-barrett-2018 content already ingested; read and decide
- **`raw/Semantic Memory Association...`** — language model; check relevance to reasoning architecture before ingesting
