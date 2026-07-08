---
title: "Building Blocks II: The Declarative-Rule / Schema Subsystem and the Metric↔Declarative Gating Interface"
type: query
tags: [building-blocks, architecture, declarative-rules, memory-schemas, mPFC, grid-cells, gating, structural-generalization, latent-graph-discovery]
created: 2026-07-03
updated: 2026-07-03
sources: []
related: [wiki/queries/building-blocks-mec-hc-pfc.md, wiki/queries/mec-abstract-codes-vs-declarative-rules.md, wiki/concepts/memory-schemas.md, wiki/entities/prefrontal-cortex.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/nucleus-reuniens.md, wiki/entities/default-mode-network.md, wiki/entities/grid-cells.md, wiki/entities/vector-hash-model.md, wiki/entities/vsa-model.md, wiki/concepts/structural-generalization.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/cognitive-control.md, wiki/architectural-gaps.md, wiki/queries/sota-review-brain-inspired-abstract-reasoning.md, wiki/queries/reasoning-as-coupled-navigation-strategizing.md, wiki/queries/proposed-reasoning-model-block-architectures.md]
---

# Building Blocks II: The Declarative-Rule / Schema Subsystem and the Metric↔Declarative Gating Interface

**Question:** [[wiki/queries/building-blocks-mec-hc-pfc.md]] decomposes the model into one metric-scaffold pipeline (MEC grid → HC binding → PFC control). But [[wiki/queries/mec-abstract-codes-vs-declarative-rules.md]] established that the brain runs **two** structurally distinct latent-structure subsystems, not one. What are the building blocks of the *second* (declarative/schema) subsystem, and — the harder question that query left open — what is the **gating interface** that lets the two compose (e.g. "apply rule X only in region A of a continuous space")?

---

## Answer

### 1. Why the original decomposition under-serves System 2

The 11-block decomposition treats the PFC rule hierarchy (Block 3C) as the *top of the metric pipeline* — a stack sitting on grid cells. Two facts break that framing:

- **Kumaran & Maguire 2005**: topology-matched *declarative* (social-acquaintance) graphs recruit mPFC/STS/TPJ with **zero MEC/HC activation** — the declarative system is not "the top of" the grid pipeline; it is a parallel substrate with its own binding and memory ([[wiki/entities/hippocampal-entorhinal-system.md]]).
- **Memory schemas as slow-W** ([[wiki/concepts/memory-schemas.md]]): the mPFC schema store — the declarative meta-graph — has no block at all in the original decomposition, yet it is System 2's structural substrate (the analog of Block 1A's grid manifold).

So System 2 needs its own encoder / memory / search / write-gate blocks, mirroring Regions 1–2 but for **arbitrary, non-metric relational structure**.

### 2. The two subsystems (recap)

| | System 1 — metric scaffold | System 2 — declarative/schema |
|---|---|---|
| Structure | continuous / metric / path-integrable | arbitrary graph, no metric embedding |
| Substrate | MEC → HC → vmPFC/DMN grid code | PFC rostro-caudal hierarchy + mPFC schema store |
| Matching | phase shift (periodic hash) — cheap | search — graph-iso is NP-hard again |
| Driver | self-motion / velocity → path integration | reward-gated RL policy search |
| Blocks | 1A–1C, 2A–2D (+ 3A–3D control) | **D1–D4 (below)** |
| Example | space, bird morphology, odor, social *rank* | task rules, social *acquaintance*, grammars |

The periodicity System 1 buys — turning cross-instance graph-matching into a phase shift ([[wiki/entities/grid-cells.md]], [[wiki/entities/vector-hash-model.md]]) — is *exactly what System 2 lacks*. This is the root of why declarative rule discovery (ARC-AGI edges) is hard: no content-free hash, so matching reverts to search.

### 3. System 2 block decomposition (D-blocks)

| Block | Biology | What it does | ML bridge | Difficulty |
|---|---|---|---|---|
| **D1: Discrete relational encoder** | mPFC/PFC single-neuron sharp-boundary category tuning (Miller 2002); no periodic embedding | Tokenize state into (role, filler) / (node, edge-label) symbols without metric geometry | VSA/HRR circular-convolution binding ([[wiki/entities/vsa-model.md]]); graph tokens; slot attention | Medium |
| **D2: Schema store (slow-W)** | mPFC organized overlapping association networks; schema = latent declarative graph ([[wiki/concepts/memory-schemas.md]]) | Hold the declarative meta-graph; schema *selection* = configurator; assimilation/accommodation = controlled slow-W update | Slow-weight associative store + conflict-gated update (EWC with a conflict-detection *trigger*, not a fixed penalty) | High |
| **D3: Rule-hierarchy search** | PFC rostro-caudal gradient; parallel multi-level RL search, reward-gated depth pruning (Badre 2010) | Discover arbitrary rule-of-rules from reward; all levels active from trial 1 | Hierarchical RL / options with *parallel* level search + reward-gated pruning; step-wise (not gradual) learning as the signature | High |
| **D4: Schema-integration write gate** | vmPFC→MEC→NGF circuit (de Sousa 2026): gates dCA1 ensemble overlap → assimilate vs. accommodate | Decide whether a new episode is co-allocated into an existing schema engram or kept separate | Overlap-gated write: schema-match high → reuse engram cells; low → allocate fresh (the declarative analog of Block 2C importance gate) | Medium |

D2 is the load-bearing novelty: it is System 2's slow-W (the meta-graph) and it updates by **conflict-triggered accommodation**, the biological answer to catastrophic interference without a global regularizer ([[wiki/concepts/two-learning-timescales.md]]).

### 4. The gating interface — the actual contribution

The mec-abstract query left "two formats that must gate each other" unspecified. The key realization: **the interface is not a missing module — the wiki already contains two *named, bidirectional* channels**, and the only open problem is the **representational-format conversion** at each end.

| Direction | Biological channel | Function | Open problem = format conversion |
|---|---|---|---|
| **System 1 → System 2** | ventral/anterior HC → mPFC context pathway ([[wiki/concepts/memory-schemas.md]]) | metric/episodic position selects *which schema* is active | continuous grid phase `g` (or conjunctive `p=f(g,x)`) → discrete schema-selector key |
| **System 2 → System 1** (encode) | vmPFC → MEC → NGF → CA1 (de Sousa 2026) | active schema controls *how* new metric/episodic memories are allocated | discrete schema → inhibitory mask over which HC engram cells are writable |
| **System 2 → System 1** (plan) | mPFC → RE → sHPC ([[wiki/entities/nucleus-reuniens.md]]) | schema/goal reaches the metric store for goal-directed planning | discrete goal-schema → bias over which System-1 edges are traversable |

And the two formats **physically co-locate in vmPFC**: Constantinescu 2016 found the grid-like (System 1) code *strongest in vmPFC*, which is also the schema hub (System 2) — the natural anatomical seam where the conversion happens ([[wiki/entities/default-mode-network.md]]).

This reframes Gap #2's "two formats that must gate each other" from *unspecified* to: **two named channels whose residual difficulty is a continuous↔discrete codec at each end.**

### 5. ML implementation of the gate

- **(brainstorm) System 1 → System 2 (metric position → symbol):** quantize the conjunctive code — VQ or cross-attention from `p=f(g,x)` to a set of schema keys. This *is* the Miller 2002 operation: continuous input → sharp-boundary symbol at the single-unit level. "Am I in region A?" becomes a discrete schema-selector token.
- **(brainstorm) System 2 → System 1 (schema → metric mask):** the active schema emits (a) a mask/bias over the SO(N) edge vocabulary of Block 1B and (b) an inhibitory gate over Block 2C/2D writes. "Apply rule X only in region A" = schema X active ⇒ unmask region-A edges, suppress others. The de Sousa NGF circuit is the biological template for the write-mask arm.
- **The bind at the seam** is a nonlinear conjunction of (metric position, active schema) — i.e. **mixed-selectivity conjunctive tuning** (Miller 2002; Rigotti), the same representational trick that lets one PFC circuit hold "rule × context" without collapsing the factors.

### 6. Consolidated view

The full reasoning core is **two factorized subsystems + two conversion channels**, not one pipeline:

```
System 1 (metric)         ⇄  gate  ⇄        System 2 (declarative)
1A grid → 1B PI → 1C fix       vHC→mPFC       D1 encoder → D2 schema-W
2A bind → 2B complete           ───────►       D3 rule search
2C/2D write ◄─ NGF mask ◄── vmPFC→MEC / mPFC→RE→HC   D4 write-gate
        └─ 3A–3D PFC control shared across both ─┘
```

Blocks 3A (Transformation Inferrer) and 3D (goal) are shared controllers; whether 3C belongs to System 2 or is a shared hierarchy is the one ambiguity (it *is* the rule hierarchy, so it is really D3 re-labeled — the original page's Block 3C and this page's D3 are the same organ seen from the two decompositions).

---

## Implications

- **Sharpens Gap #2** ([[wiki/architectural-gaps.md]]): the meta-graph is two representational formats; the residual work is a continuous↔discrete codec across two already-named channels (vHC→mPFC in; vmPFC→MEC / mPFC→RE→HC out), not a wholly missing gating module.
- **A single-substrate model fails on the other half.** A pure grid/path-integration model (System 1 only) cannot represent amodal declarative rules (Kumaran & Maguire); a pure schema/rule-search model (System 2 only) forfeits the periodic-hash generalization that makes metric structure cheap. The [[wiki/queries/sota-review-brain-inspired-abstract-reasoning.md]] §8.3 metric-vs-declarative fork must be *decided per target task* — and a general reasoner needs both plus the codec.
- **D2 (schema slow-W) is the highest-value System-2 addition**, analogous to how Block 3A is the highest-value System-1 addition: it is where the declarative meta-graph lives and where conflict-triggered accommodation replaces catastrophic overwrite.
- **The gating interface (§4) is the runtime seam of the coupled reasoning loop.** [[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]] uses the §4 System 2→System 1 channel as its *Strategist→Navigator* arm: the active schema/goal biases *which edges* the Navigator traverses/simulates and *which sequences* replay ("schema X unmasks region-A edges"). So the continuous↔discrete codec specified here is not a static interface but the live coupling between the Strategist's goal and the Navigator's path integration — and D3's rule-hierarchy search is driven by the same value error `ε_r` that trains the goal.

## Follow-up questions

- Is VQ over `p=f(g,x)` the right System 1→System 2 discretizer, or does the schema key need to be inferred jointly (co-discovered) with the schema, à la Block 3A vocabulary co-discovery?
- Does the System 2→System 1 mask act on **edges** (which transitions are legal) or on **nodes** (which states are reachable)? de Sousa's NGF gate operates on *engram cells* (nodes); the planning arm (mPFC→RE→HC) seems to bias *edges*.
- Medial vs. lateral BA-10 double dissociation (carried from [[wiki/queries/mec-abstract-codes-vs-declarative-rules.md]]): is the vmPFC grid site (System 1) genuinely a different circuit from the frontopolar rule-of-rules node (System 2), or one circuit doing both — which would mean the codec is *intra*-regional, not inter-regional?
- Is there a formal criterion for "metric-enough to recruit System 1" vs. "declarative-enough to recruit System 2"? Still a post-hoc trichotomy, not a derived principle.
