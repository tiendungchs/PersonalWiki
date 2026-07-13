---
title: "MEC's 'Abstract' Codes vs. Declarative Rule Learning: Same System or Two?"
type: query
tags: [MEC, grid-cells, PFC, mPFC, abstract-reasoning, structural-generalization, memory-schemas]
created: 2026-07-01
updated: 2026-07-01
sources: []
related: [wiki/entities/grid-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/prefrontal-cortex.md, wiki/entities/default-mode-network.md, wiki/entities/vector-hash-model.md, wiki/concepts/structural-generalization.md, wiki/concepts/memory-schemas.md, wiki/concepts/successor-representation.md, wiki/papers/gridlikecode-constantinescu-2016.md, wiki/papers/kumaran-maguire-2005-hippocampus.md, wiki/papers/frontal-cortex-abstract-rules-badre2010.md, wiki/papers/garvert-abstract-relational-map-2017.md, wiki/papers/zheng-parallel-cognitive-maps-2024.md, wiki/empirical-tensions.md, wiki/architectural-gaps.md, wiki/queries/building-blocks-declarative-subsystem.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/queries/central-framing-epistemic-audit.md, wiki/queries/mec-abstract-codes-vs-declarative-rules-fr.md]
---

# MEC's "Abstract" Codes vs. Declarative Rule Learning: Same System or Two?

**Question:** Some findings show abstract rules being learned by a region other than MEC. Other findings show MEC-like grid codes encoding concepts that go beyond navigation. Could the "abstract" concepts MEC encodes actually be related to navigation somehow? What is the other region? Full picture and gaps.

---

## Answer

Two genuinely separate systems are being described here, and they resolve the apparent contradiction rather than contradicting each other.

### System 1 — the structural-code scaffold (MEC → HC → vmPFC/DMN)

Handles **continuous, metric, or path-integrable** relational structure.

- Grid cells provide a periodic coordinate system [[wiki/entities/grid-cells.md]]. Periodicity is not incidental: matching relational structure across instances (graph isomorphism) is NP-hard for an arbitrary code; a periodic code lets any new instance be registered by a simple phase shift/rotation instead of a search.
- Constantinescu et al. 2016 found the identical hexagonal signature during navigation of an abstract, non-spatial 2D space (bird neck/leg length) — and it was **strongest in vmPFC** (Z=4.09), not entorhinal cortex, with presence also in OFC, PCC, RSC, LPC, TPJ — i.e., the default mode network [[wiki/papers/gridlikecode-constantinescu-2016.md]], [[wiki/entities/default-mode-network.md]]. The same signature appears for social-hierarchy rank and odor-space representations.
- Vector-HaSH formalizes *why* this generalizes: the grid scaffold is a content-free hash library over any continuous/ordered state space [[wiki/entities/vector-hash-model.md]]. "Spatial" is the special case where the driving input is self-motion velocity; any continuous dimension (neck length, dominance rank, similarity) can drive the same phase-update mechanism.
- **The scaffold also captures *discrete* graphs learned via transitions (Garvert et al. 2017 [[wiki/papers/garvert-abstract-relational-map-2017.md]]).** An implicitly-learned discrete graph with *no continuous dimension* is nonetheless reconstructed in entorhinal cortex — encoded with a **successor-representation / communicability** (weighted-future-state) metric, not a Euclidean one. This pushes the System-1 boundary rightward: the trigger is not "continuous/metric geometry" but **"acquired as a transition operator" (random-walk sampling → SR-encodable)**. Metric continuity is *sufficient* but not *necessary*; experienced transition statistics are the deeper entry condition. Caveat: Garvert's graph was still small and 2D-embeddable, and passive/implicit — the map stayed in HC/EC and did *not* extend to vmPFC (contrast Constantinescu's active task), so this is not yet evidence that the scaffold covers genuinely non-embeddable symbolic structure.

**So — is the abstraction "actually" navigation?** Yes, but the causal arrow runs the opposite way from how the question implies. Navigation isn't special; it's one instance of a more general problem: representing continuous/metric relational position so structure transfers across instances. MEC's code isn't repurposed by abstract cognition — abstract cognition recruits the same solution because it faces the *identical* computational problem (continuous-dimension coordinate assignment + cross-instance graph-matching), not because it is secretly spatial.

### System 2 — declarative/discrete rule learning (PFC rostro-caudal hierarchy + mPFC schema system)

This is "the other region" — and it is not one region but a hierarchy plus a schema-selection system, entirely distinct from grid coding.

- Kumaran & Maguire 2005: a factorial design matched two graph-traversal tasks on difficulty, relational complexity, and topology (same 14 nodes; edges differ — spatial road-distance vs. social acquaintance). HC/MEC activated **only** for the metric (spatial) task. The social-acquaintance graph — same topology, but declarative, non-metric edges — engaged mPFC, STS, TPJ, insula instead, with **zero** medial-temporal-lobe activation even against baseline [[wiki/papers/kumaran-maguire-2005-hippocampus.md]]. Logged as an open tension in [[wiki/empirical-tensions.md]].
- Badre et al. 2010: abstract **rule** discovery (arbitrary stimulus→response policy hierarchies, not spatial/metric structure) is learned via RL along a rostro-caudal PFC gradient — PMd (1st-order rule) → prePMd (2nd-order) → mid-DLPFC/BA-9-46 (3rd-order) → frontopolar BA-10 ("rules of rules") [[wiki/entities/prefrontal-cortex.md]]. This mechanism is reward-gated and hierarchical RL search — no periodicity, no metric embedding, nothing resembling path integration.
- mPFC's schema system is the consolidation-time complement: it reconciles overlapping associations, selects the active schema, and stores Structured Event Complexes — organized rule/grammar sequences — for reuse [[wiki/concepts/memory-schemas.md]].

### The resolution

Both literatures are studying "abstraction," but a different *kind*:

| Type of abstraction | Structure | System | Example |
|---|---|---|---|
| Continuous/metric relational position | Graph with metric or path-integrable structure | MEC → HC → vmPFC/DMN grid-code network | physical space, bird morphology, odor space, social *rank* |
| Discrete declarative/policy rule | Arbitrary graph, no metric embedding | PFC rostro-caudal hierarchy + mPFC schema system | task rules, social *acquaintance* (who-knows-who), grammars |

Both generalize across surface content — that's what makes each "abstract" — but only the first is navigation in any literal computational sense.

**The dividing line is sharper than "metric vs. discrete."** Garvert 2017 shows a *discrete, non-metric* graph lands in **System 1** when it is learned as a transition operator (random walks) — so the row-1 entry condition is better stated as *SR-encodable via experienced transitions* than *metric geometry*. Kumaran & Maguire's social-acquaintance graph fails to recruit System 1 not because it is discrete but because it is known **declaratively without traversal**. Metric/continuous structure remains the clearest System-1 case; transition-sampled discrete structure is the newly-confirmed extension.

**Embeddability — not declarative/explicit character — is the disqualifier (Zheng et al. 2024 [[wiki/papers/zheng-parallel-cognitive-maps-2024.md]]).** Reanalyzing Garvert's dataset, Zheng et al. find that *taxonomic semantic similarity* between the same objects (rabbit–dog both animals; a lifetime-acquired, **explicit** structure) is **also** mapped in the hippocampal formation — a category-structured metric space (MDS recovers animate/inanimate, natural/manmade axes). So a declarative, explicit, lifetime-old structure lands in System 1 as long as it is **metric-embeddable**. This further narrows the K&M negative: social *acquaintance* fails to recruit System 1 specifically because it is **non-metric / non-embeddable**, not because it is declarative or explicit. The System-1 entry condition collapses to **embeddability alone** (metric geometry *or* SR-encodable transition structure *or* taxonomic-similarity space); acquisition mode (recent/lifetime, implicit/explicit, traversed/passive) does not gate it.

**Parallel separable maps within System 1 — not one conjunctive map.** Crucially, when the same objects carry *two* System-1 structures at once (Garvert's transition graph *and* their semantic similarity), the hippocampal formation holds them as **two anatomically separable maps in parallel** — transition → anterior EC, semantic → posterior HC (non-overlapping; anterior–posterior long-axis gradient) — and does **not** fuse them into a conjunctive map. System 1 is therefore not a single metric scaffold but a **bank of parallel maps** indexed by relational structure, requiring a *which-map* selection stage (the System-2/mPFC schema selector, below) to pick the task-relevant one. This is distinct from TEM's `p=f(g,x)`, which fuses *structure×content*: Zheng shows *structure×structure* is kept separable, a design bias toward flexible re-selection over compression.

### A subtlety the wiki hadn't flagged before

Constantinescu's strongest grid site (vmPFC, medial BA-10/11/12) and Badre's top rule-hierarchy node (frontopolar, anterior BA-10) sit in the same gross Brodmann area but appear to be different subregions/circuits — one running a continuous metric code, the other a discrete rule-of-rules abstraction. [[wiki/entities/prefrontal-cortex.md]] already lists these as separate anatomy-table rows (vmPFC vs. frontopolar), but no source has directly tested whether this is a genuine medial/lateral BA-10 double dissociation or two loosely-related literatures that happen to converge on the same macro-anatomical label.

---

## Implications

A reasoning-model architecture needs (at minimum) **two distinct latent-structure subsystems**, not one:

1. A periodic/metric scaffold (MEC/grid-cell-style) for any domain with continuous or path-integrable structure.
2. A discrete hierarchical rule-search system (PFC rostro-caudal-style, RL-driven) for arbitrary declarative structure with no metric embedding.

Using only one architecture for both will fail on whichever domain doesn't match its geometry. This sharpens Gap #2 (multi-level meta-graph) in [[wiki/architectural-gaps.md]]: the "meta-graph" isn't one nested structure but potentially two structurally different representational formats that must be able to gate each other (e.g., "apply rule X only in region A of a continuous space").

The block-level decomposition of System 2 (D1 discrete encoder → D2 schema slow-W → D3 rule-hierarchy search → D4 schema-integration write gate) and the gating interface — carried by two already-named bidirectional channels (ventral-HC→mPFC inbound; vmPFC→MEC→NGF / mPFC→RE→HC outbound), whose residual difficulty is a continuous↔discrete codec — are worked out in [[wiki/queries/building-blocks-declarative-subsystem.md]] (companion to the System 1 decomposition in [[wiki/queries/building-blocks-mec-hc-pfc.md]]).

---

## Follow-up questions

- Is there a task that varies metric-continuity and rule-discreteness independently, to map the transition boundary between the two systems experimentally?
- Does frontopolar/vmPFC BA-10 show functional subdivision (medial grid-code site vs. lateral rule-hierarchy node) within the same subjects/session — has anyone tested this directly?
- Do non-human animals capable of rule abstraction (e.g., primates in Badre-style tasks) show a homologous grid-vs-rule PFC subregion separation?
- No formal criterion currently exists for what makes a relational structure "metric enough" to recruit MEC/HC/vmPFC vs. "declarative enough" to recruit mPFC/social-brain circuitry — it's a post-hoc trichotomy (metric / temporal-sequential / purely declarative) from three studies, not a derived principle. What would such a criterion look like?
