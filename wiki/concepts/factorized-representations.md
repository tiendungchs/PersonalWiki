---
title: "Factorized Representations"
type: concept
tags: [factorized-representations, structural-generalization, architecture, world-models, compositional]
created: 2026-06-09
updated: 2026-07-16
sources: [t-TEM, convergence-wiring-transcript, reservoir-computing-transcript, High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations, kanerva-sdm-1993, barlow_twins]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/path-integration.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/attention.md, wiki/concepts/predictive-coding.md, wiki/concepts/neural-manifolds.md, wiki/concepts/small-world-networks.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/associative-memory.md, wiki/entities/tem-model.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/htm-thousand-brains.md, wiki/entities/reservoir-computing.md, wiki/entities/vector-hash-model.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/150000-mini-brain-transcript.md, wiki/papers/convergence-wiring-transcript.md, wiki/papers/reservoir-computing-transcript.md, wiki/papers/dicarlo-visual-object-recognition-2012.md, wiki/papers/whittington-cognitive-map-2022.md, wiki/papers/vector-hash-chandra-2023.md, wiki/entities/sdm-model.md, wiki/papers/kanerva-sdm-1993.md, wiki/papers/barlow-twins-zbontar-2021.md, wiki/queries/operator-collapse-in-fused-structural-codes.md]
---

# Factorized Representations

**Maintain separate, independently updatable codes for structural/relational knowledge and sensory/content knowledge. This is the architectural principle that enables structural generalization.**

---

## The Three Codes (TEM)

| Code | Variable | Brain | Role |
|------|----------|-------|------|
| Structural | `g` | MEC (grid cells) | Abstract position in relational graph; shared across environments |
| Sensory | `x` | LEC | Current observation; environment-specific |
| Conjunctive | `p` | HC (place cells) | Binds g and x; episodic memory; per-environment |

W (transition weights on g) is **shared** across all environments. M (Hebbian binding of p) is **per-environment**. A new environment with the same relational structure costs only an M update — W transfers wholesale.

---

## Why Factorization Enables Generalization (Car/Color Analogy)

If car-model preference and color preference are independent, sampling N_models + N_colors observations suffices to predict all N×M combinations. Without factorization: need N×M. This combinatorial savings scales with the number of dimensions — exactly the problem the brain faces with high-dimensional cognitive maps.

In relational terms: learn the structural rules once across environments; bind specific content per environment separately.

---

## TEM as a Factorized World Model

TEM's generative model:
```
p(x_{t+1} | x_{1:t}, a_{1:t}) = ∫ p(x_{t+1} | g_{t+1}) · p(g_{t+1} | g_t, a_t; W) dg
```
- `p(g_{t+1} | g_t, a_t; W)` = transition model (path integration, shared weights W)
- `p(x_{t+1} | g_{t+1})` = observation model (via Hebbian M)

Contrast with standard world models (Dreamer, MuZero): monolithic `s_{t+1} = f(s_t, a_t)` — environment-specific, cannot transfer. TEM's W transfers; only M changes per environment.

---

## Compositional Bases

Two levels of factorized representation:
- **Global bases (grid cells):** tile all space uniformly — the coordinate system
- **Local bases (OVCs, BVCs, GVCs):** encode relationships to specific features (objects, borders, goals) *regardless of where those features are* — plug-in components for any map

Cognitive maps are built by composing global and local bases. Adding a barrier updates only BVC components; the grid structure is unchanged.

---

## Factorized vs. Entangled Phase

Grid cells warp toward rewarded locations (Boccara 2019, Butler 2019), apparently contradicting factorization. Resolution: there is a computational trade-off driven by **pressure to generalize**:

- **Frequently switching tasks** → compositional/factorized (generalization pays off)
- **Single repeated configuration** → bespoke warped representation (no generalization needed)

**Prediction:** when rewards and space are presented in all factorized combinations, grid cells and reward-vector cells remain separate. When they always co-occur in a fixed pairing, representations entangle.

---

## Disentanglement ≠ Abstraction: The CCGP (Cross-Condition Generalization Performance)/SD Constraint

Factorized/disentangled representations achieve high cross-condition generalization performance (CCGP) for each encoded variable — but at the cost of severely reduced shattering dimensionality (SD). In a perfectly factorized representation, XOR dichotomies are linearly unseparable, hard-limiting the responses a downstream linear readout can generate.

Bernardi et al. 2020 ([[wiki/papers/geometry-abstraction-bernardi-2020.md]]) show that HPC, DLPFC, and ACC (Anterior Cingulate Cortex) achieve near-maximal SD (Shattering Dimensionality) *simultaneously* with high CCGP (Cross-Condition Generalization Performance) for context, value, and action. The observed geometry is not fully disentangled: a small distortion of the factorized arrangement recovers near-maximal SD (Shattering Dimensionality) without sacrificing CCGP (Cross-Condition Generalization Performance) for the key variables. Mixed selectivity (linear combinations of multiple variable tunings) is the substrate — it corresponds to a rotation of the factorized code that preserves CCGP (Cross-Condition Generalization Performance) under linear readouts.

**Design implication:** the target for a reasoning model is not maximum disentanglement but the CCGP (Cross-Condition Generalization Performance)/SD balance. Full disentanglement limits behavioral flexibility. See [[wiki/concepts/representational-geometry.md]].

---

## Transformer Validation

TEM-t [[wiki/papers/t-tem-whittington-2022.md]] independently confirms the factorized split is architecturally optimal. Restricting transformer keys/queries to structural code `g̃` and values to sensory code `x̃` is not a design choice — it is a *derivation* from the outer-product memory structure `p = flatten(x̃ᵀ g̃)`. Retrieving `x̃` given `g̃_t` reduces to attending over past `g̃` values, leaving sensory values untouched in V. Any mixing of structural and sensory information in keys/queries would corrupt retrieval. The factorization is necessary.

---

## Independent Derivation: Thousand Brains

TBT [[wiki/entities/htm-thousand-brains.md]] arrives at the same g/x/p factorization from cortical anatomy rather than formal modeling. Every cortical column implements:

| Column layer | Role | TEM analog |
|---|---|---|
| L6 | Grid-like path integration ("where") | Structural code g |
| L4 | Sensory input ("what") | Sensory code x |
| L2-3 | Binding + lateral consensus voting | Conjunctive code p |

The L5→L6 efference copy loop is TBT's answer to "where does `a_t` come from?": the column generates its own action signal from motor predictions, feeding it into the path integrator internally. TEM receives `a_t` externally. If ~150,000 cortical columns each run this circuit, factorization is not a design choice for a specialized HC formation — it is the universal cortical algorithm.

---

## Vector-HaSH: A Second Factorization Axis

TEM's factorization separates *structural* (g) from *sensory* (x) codes, enabling cross-environment transfer of transition weights W. Vector-HaSH (Chandra et al. 2023 [[wiki/papers/vector-hash-chandra-2023.md]]) reveals a **second orthogonal factorization axis**: separating *dynamics* (scaffold, fixed) from *content* (heteroassociation, plastic).

| Factorization | Fixed component | Plastic component | What transfers |
|---|---|---|---|
| **TEM** (structural/sensory) | W transition weights | Hebbian M per environment | Structural rules across environments |
| **Vector-HaSH** (dynamics/content) | Scaffold (grid circuit + fixed projections) | Heteroassociative HC-cortex weights | Attractor dynamics across all stored items |

These two factorizations are multiplicatively useful: a full HC-based reasoning model should implement both — W/g for cross-environment structural generalization, scaffold/content for high-capacity episodic memory without interference.

**Scaffold reuse as domain generalization.** A spatial scaffold (grid phases indexed to spatial locations) can be heteroassociated with arbitrary non-spatial content — the memory palace phenomenon. This is factorization in time: the scaffold is learned from spatial experience; any domain content can be attached later. The scaffold provides a stable *representational basis* that any content domain can exploit, analogous to how transfer learning exploits a pretrained feature space.

**ML implication:** the scaffold/content factorization suggests a two-layer memory design for reasoning models — a fixed high-capacity scaffold layer (learned from structural traversal) and a rapidly-updated heteroassociative layer (written per episode). The scaffold layer should be frozen once trained on sufficient structural experience; only the heteroassociative layer should receive fast-M updates.

## SDM: A Third Factorization Axis

Kanerva's SDM (Sparse Distributed Memory) (Kanerva 1993 [[wiki/papers/kanerva-sdm-1993.md]]) establishes a **third factorization axis** — *address scaffold vs. content* — nested within the two axes already in the wiki:

| Factorization | Fixed component | Plastic component | Scope |
|---|---|---|---|
| **TEM** (structural / sensory) | W transition weights (g-code structure) | Hebbian M per environment (x/p bindings) | Cross-environment structural rules |
| **Vector-HaSH** (dynamics / content) | Scaffold (grid circuit + fixed projections) | Heteroassociative HC↔cortex weights | Cross-episode attractor stability |
| **SDM** (address scaffold / content) | Address matrix **A** (random, fixed) | Contents matrix **C** (Hebbian, per episode) | Within a single memory store |

These three axes are **hierarchically nested**: TEM's structural/sensory split determines which information reaches the fast-M store; Vector-HaSH's scaffold ensures the fast-M store has non-interfering fixed points; SDM's A/C split determines how content is addressed and written within those fixed points.

**SDM proves the random scaffold suffices:** A random draw of **A** — no training required — already provides near-orthogonal addressing for uniform random patterns (activation-set overlaps p² × M ≈ 0). This means the "scaffold" factored out by Vector-HaSH and TEM does not need to learn *geometry* — any fixed projection works; random is the simplest choice and the biologically observed one (DG granule cell connectivity is random; cerebellar granule cell connectivity is random). The scaffold's only requirement is fixedness, not trainedness.

---

## Staged Local Factorization: CLSU vs. TEM

DiCarlo et al. 2012's cortically local subspace untangling (CLSU) describes the same factorization principle applied at each hierarchical level rather than globally. At every cortical sub-population:
- **Target of factorization:** identity from identity-preserving transformations (position, scale, pose) in the local input subspace
- **Mechanism:** temporal contiguity learning — same object → proximate retinal images → learn similar responses → identity separated from transformation in local output
- **Scope:** local (~40K neurons); the factorized output becomes the input for the next level

TEM's g/x split is the *global* factorization achieved at the top of this staged hierarchy. CLSU and TEM are the micro and macro views of the same principle: separate invariant structural dimensions from variable content at each scale of processing.

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — factorization is the mechanism that enables structural generalization; the g/x split is precisely why W (transition rules on g) can transfer to new environments while x is discarded.
- **[[wiki/concepts/path-integration.md]]** — path integration is the update mechanism *for g specifically*; `g_{t+1} = f(W g_t + B a_t)` keeps the structural code path-consistent across traversals without touching x or p.
- **[[wiki/concepts/two-learning-timescales.md]]** — W (slow, shared) and M (fast, per-environment) are the respective update rules for the structural and conjunctive codes; the two-timescale split maps directly onto the factorized architecture.
- **[[wiki/concepts/successor-representation.md]]** — SR (Successor Representation) independently derives the same factorized split: SR (Successor Representation) eigenvectors = grid cells (structural code g); SR (Successor Representation) rows = place cells (conjunctive code p); two mathematical routes to the same architecture.
- **[[wiki/entities/grid-cells.md]]** — physically implement the structural code `g`; environment-invariant, multi-scale, path-integrating — the factorized architecture in MEC at the cellular level.
- **[[wiki/entities/place-cells.md]]** — physically implement the conjunctive code `p = f(g, x)`; environment-specific remapping while preserving grid-phase shows factorization working at the HC level.
- **[[wiki/concepts/attention.md]]** — transformer self-attention with Q=K=f(g), V=f(x) is the factorized architecture instantiated; the derivation from TEM memory structure proves factorization is necessary, not a design choice.
- **[[wiki/papers/t-tem-whittington-2022.md]]** — source for the transformer validation of the factorized split; TEM-t's performance confirms the architecture is optimal.
- **[[wiki/concepts/predictive-coding.md]]** — TEM's factorized generative model is an instance of FEP: structural code `g` is the latent cause z; transition weights W define the prior `p(g)`; Hebbian M implements the likelihood `p(o|g)`; factorization ensures the prior transfers across environments while the likelihood adapts per environment.
- **[[wiki/queries/rule-changes-as-meta-graph-rules.md]]** — factorization is the tractability lever for non-stationary topology: lifting rule-state into the node (`s' = (base_state, rule_config)`) restores a stationary graph, but the resulting `|base|×|rule-configs|` blowup is only learnable if the rule-config factorizes into a sparse rule-code.
- **[[wiki/concepts/neural-manifolds.md]]** — the factorized g/x split is a manifold-design choice: by keeping structural and sensory codes in separable submanifolds, zero-shot generalization becomes structurally reachable; without this split the target computation lies outside the model's intrinsic manifold regardless of training.
- **[[wiki/entities/htm-thousand-brains.md]]** — independently derives the g/x/p factorization from cortical layer anatomy (L6/L4/L2-3), converging with TEM's formal derivation from the outer-product memory structure; if every cortical column runs this circuit, factorization is the universal cortical algorithm rather than a model design choice.
- **[[wiki/papers/150000-mini-brain-transcript.md]]** — source for the Thousand Brains account of columnar factorization and the efference copy mechanism that drives the structural code update.
- **[[wiki/concepts/small-world-networks.md]]** — same wiring economy principle operating at the parameter level: factorization achieves maximum structural generalization per parameter, just as small-world wiring achieves maximum integration capacity per axon — both are optimal solutions to the same minimize-cost/maximize-capacity problem.
- **[[wiki/papers/convergence-wiring-transcript.md]]** — source for the wiring economy argument that connects biological small-world topology to architectural parameter efficiency.
- **[[wiki/entities/reservoir-computing.md]]** — the reservoir/readout split is a degenerate factorization (random W fixed; task-specific readout trained); TEM improves on it by replacing the random W with a learned structured W that supports cross-environment transfer rather than merely within-task approximation.
- **[[wiki/papers/reservoir-computing-transcript.md]]** — source for the fixed-W / trained-readout architecture that defines the degenerate factorization.
- **[[wiki/concepts/hierarchical-representations.md]]** — CLSU (cortically local subspace untangling) applies the factorization principle at every hierarchical level locally; TEM's global g/x split is the macro-level outcome of this staged local factorization; the two concepts are micro vs. macro views of the same principle.
- **[[wiki/papers/dicarlo-visual-object-recognition-2012.md]]** — source for CLSU as staged local factorization; temporal contiguity learning as the unsupervised mechanism that factorizes identity from transformation variables at each level without labels.
- **[[wiki/concepts/latent-graph-discovery.md]]** — factorized representations are the architectural solution to two-level entanglement in latent graph discovery: the g/x split allows meta-graph position (g) and node content (x) to be learned at different timescales, which is the core requirement of the two-level hierarchy.
- **[[wiki/papers/whittington-cognitive-map-2022.md]]** — primary source for the factorized vs. entangled representation phase concept; the generalization pressure that drives the g/x/p factorization is operationalized in this paper's CSCG+TEM integration discussion.
- **[[wiki/concepts/representational-geometry.md]]** — disentanglement is a limiting case of the CCGP (Cross-Condition Generalization Performance)/SD trade-off: maximum CCGP (Cross-Condition Generalization Performance) at the cost of minimum SD; the brain achieves the balance via a distorted factorized geometry with mixed selectivity; the reasoning model design target is not maximum disentanglement but this balance.
- **[[wiki/entities/vector-hash-model.md]]** — Vector-HaSH introduces a second factorization axis (dynamics vs. content) orthogonal to TEM's structural/sensory split; scaffold reuse for non-spatial content is the key design implication for domain-general episodic memory.
- **[[wiki/concepts/associative-memory.md]]** — the scaffold/content factorization is what prevents the Hopfield memory cliff; the two factorizations (TEM g/x and Vector-HaSH scaffold/content) together define a full two-axis architecture for the HC fast-M system.
- **[[wiki/papers/vector-hash-chandra-2023.md]]** — source for the second factorization axis, scaffold reuse argument, and the claim that spatial codes are a special case of a domain-general representational structure.
- **[[wiki/entities/sdm-model.md]]** — SDM (Sparse Distributed Memory) introduces a third factorization axis (address scaffold **A** vs. content **C**) nested within the TEM and Vector-HaSH axes; the proof that a random **A** suffices establishes that the scaffold does not require learned geometry — fixedness alone is the requirement, enabling random initialization as the simplest biologically plausible design.
- **[[wiki/papers/kanerva-sdm-1993.md]]** — source for the three-axis factorization hierarchy, the random-scaffold-suffices argument, and biological evidence from cerebellar and DG (Dentate Gyrus) granule cell random connectivity confirming that fixed-random projections are evolutionarily selected over learned address structures.
- **[[wiki/papers/barlow-twins-zbontar-2021.md]]** — Barlow's factorial code (1961) is the formal statement that sensory processing should produce statistically independent component codes; BT operationalizes this in ML as a cross-correlation decorrelation objective, providing empirical evidence that factorized/independent representations are learnable from data without labels and benefit from high dimensionality.
- **[[wiki/queries/operator-collapse-in-fused-structural-codes.md]]** — the measured cost of *skipping* the factorization: a fused x⊕g code must carry the static scene and the position in one vector, the scene wins the norm (‖mean code‖ 4.10 vs action-driven ‖Δg‖ 0.363), and the path integrator answers with a near-identity operator. Empirical support that the g/x split is a derivation rather than a design preference.
