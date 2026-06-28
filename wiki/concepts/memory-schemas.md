---
title: "Memory Schemas"
type: concept
tags: [schemas, memory-consolidation, associative-inference, hippocampus, prefrontal-cortex, transitive-inference, knowledge-organization]
created: 2026-06-27
updated: 2026-06-28
sources: [Interplay of hippocampus and prefrontal cortex in memory, Prefrontal-Hippocampal Interactions in Memory and Emotion, "Prefrontal atrophy, disrupted NREM slow waves, and impaired hippocampal-dependent memory in aging", "The prefrontal cortex controls memory organization in the hippocampus", "The Role of Medial Prefrontal Cortex in Memory and Decision Making"]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/associative-memory.md, wiki/concepts/continual-learning.md, wiki/concepts/prospective-coding.md, wiki/concepts/cognitive-control.md, wiki/concepts/replay.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/engrams.md, wiki/concepts/pattern-separation.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/prefrontal-cortex.md, wiki/entities/nucleus-reuniens.md, wiki/papers/preston-eichenbaum-hpc-pfc-2013.md, wiki/papers/cls-mcclelland-1995.md, wiki/papers/inferential-reasoning-dupret-2020.md, wiki/papers/jin-maren-hpc-pfc-emotion-2015.md, wiki/papers/prefrontal-atrophy-nrem-mander-2013.md, wiki/papers/desousa-pfc-memory-organization-hpc-2026.md, wiki/papers/euston-mpfc-memory-decision-2012.md, wiki/papers/spatial-learning-pfc-martinet-2011.md]
---

# Memory Schemas

**An organized network of overlapping memory associations in which shared elements link distinct episodes, supporting rapid integration of new related information, novel inference about unobserved relationships, and generalization to new situations.**

Schemas are the brain's latent graph: episodes are nodes; shared elements (B connecting A–B and B–C) are edges; the schema is the inferred relational structure. Preston & Eichenbaum (2013).

---

## Key Properties

Three diagnostic properties (Preston & Eichenbaum 2013):
1. New information is **better remembered** when it fits a pre-existing schema
2. New information that **conflicts** with the schema may cause modification of the schema (accommodation) or reinterpretation of the new event (assimilation)
3. Schemas support **novel inferences** between indirectly related events (A→C via shared B) and generalization to new situations

---

## HC and mPFC Division of Labor

| Stage | Hippocampus | mPFC |
|---|---|---|
| **Learning** | Links elements of new associations (A-B, B-C) | Reconciles new associations with existing overlapping ones; detects conflict |
| **Consolidation** | Employs invariant representations to link overlapping elements via shared B | Creates schematic organization; vmPFC-HC coupling grows as overlap accumulates |
| **Expression** | Retrieves specific associations within the PFC-selected schema; enables A-C inference | Selects correct schema for current context; gates context-appropriate retrieval in dorsal HC |

**Associative inference test (rodent):** A-B and B-C pairs trained; A-C inference tested. HC lesion → individual pairs learned but A-C inference fails. mPFC lesion → same pattern, but mechanism differs (integration vs. conflict resolution).

**vmPFC-HC coupling predicts inference (human fMRI):** vmPFC-HC functional coupling increases across repeated presentations of overlapping pairs. Degree of vmPFC engagement during overlapping-pair learning predicts subsequent A-C performance.

**Schema type determines HC dependency:** HC strongly supports schemas with spatial or temporal-sequential structure (place-learning, ordered event sequences, associative chains with temporal context — path traversal over time). Purely declarative associative schemas — social network membership, logical relationships without temporal ordering — engage mPFC and the social brain (STS, TPJ, temporal poles) but show **no HC activation** even when relational complexity is matched ([[wiki/papers/kumaran-maguire-2005-hippocampus.md]]). This constrains the HC role in schema formation: HC is particularly critical when the schema has metric or sequential embedding that parallels spatial navigation; for amodal associative schemas, mPFC is the primary organizer even during learning.

---

## Ventral/Dorsal HC Gradient

| Division | Rodent | Human | Role in schema circuit |
|---|---|---|---|
| **Ventral** | Ventral HC | Anterior HC | Generalizes context across events → sends contextual signal directly to mPFC |
| **Dorsal** | Dorsal HC | Posterior HC | Encodes specific events at specific places → receives mPFC schema-selection input via perirhinal/LEC |

Ventral HC neurons gradually acquire generalized representations of all events within a context, outperforming dorsal HC at context discrimination. When mPFC is inactivated, dorsal HC neurons indiscriminately retrieve both appropriate and inappropriate event representations.

---

## vmPFC→MEC Circuit: Schema-Integration Gate at the Circuit Level

De Sousa et al. 2026 ([[wiki/papers/desousa-pfc-memory-organization-hpc-2026.md]]) identify the specific circuit by which vmPFC schemas control HC memory organization — the missing mechanistic link in the assimilation/accommodation account.

**Circuit:** vmPFC (excitatory, deep layers) → MEC (layers II/III/V) → neurogliaform (NGF/NDNF+) inhibitory cells in CA1 SLM → gate EC and CA3 inputs to CA1 pyramidal neurons → control ensemble overlap.

**Schema-level circuit logic:**

| Condition | vmPFC→MEC activity | NGF in CA1 SLM | dCA1 overlap | Schema operation |
|---|---|---|---|---|
| Similar contexts, 7d apart (overlap with schema) | Low | Less active | High | Assimilation: new event co-allocated to schema engram |
| Different contexts, 7d apart (no schema match) | High | Active | Low | Accommodation: new event kept separate |
| 5h interval (no consolidated schema yet) | Low | (not engaged) | High | Schema-independent integration (temporal proximity mechanism) |

The vmPFC requires ~7 days to consolidate a schema before it can exert this control — implementing the systems-consolidation prerequisite for schema-guided encoding. At 5h, the local HC temporal-proximity mechanism (CREB linkage window) dominates; the vmPFC top-down layer is not yet recruited.

**Top-down memory allocation as schema co-allocation:** vmPFC→MEC projections bias *which neurons encode* the second event. When vmPFC is engaged (separation), fresh neurons are allocated (schema independence). When vmPFC→MEC is inactive (assimilation), prior-schema engram neurons are preferentially co-allocated to encode the new event — creating the physical ensemble overlap that supports later associative recall. Schema assimilation is therefore not merely reduced interference; it is active co-allocation of new memories into the existing schema's neuron ensemble.

**Design implication for reasoning models:** The schema-integration gate requires an explicit top-down projection from the schema-organizing module (PFC analog) to the structural-code relay (MEC analog), which in turn controls inhibitory gain on the episodic memory store (CA1 analog). A model that routes schema signals only to output/readout layers, without gating the encoding process itself, cannot implement this.

---

## Assimilation vs. Accommodation

**Assimilation:** new experience fits existing schema → HC encodes rapidly (single trial; Tse et al.); mPFC engaged from the start because schema already available.

**Accommodation:** new experience conflicts with existing schema → mPFC drives modification. Evidence: A-B, A-C interference paradigm — mPFC damage increases intrusions and blocks adaptation; lateral PFC emphasizes distinctiveness of memories rather than integration.

This predicts **when mPFC is recruited:**
- **Low overlap / no schema:** HC-dominant encoding; mPFC recruited only after remote consolidation (contextual fear paradigm).
- **High overlap / schema exists:** HC and mPFC both engaged from the first trial (food-location, transitive inference paradigms).

---

## Post-Task Consolidation Window

mPFC activity during the **1–2 hours immediately after a learning session** is necessary for subsequent recall (Euston et al. 2012 [[wiki/papers/euston-mpfc-memory-decision-2012.md]]). Chemical disruption of mPFC within this window impairs memory tested 24–48h later; disruption before or after the window has no effect. The mechanistic interpretation: this window corresponds to HC-driven replay (sharp-wave ripples + mPFC spindles) that begins consolidating context-event-response mappings into mPFC while HC memory traces are still fresh.

**Critical constraint for a reasoning model:** the transition from HC-dependent to mPFC-independent recall is not triggered by a single event (e.g., sleep onset) but begins during a protected post-encoding window. A model that performs consolidation only at epoch boundaries will miss this constraint.

---

## Sleep-Phase Mechanism: SWA as Schema Consolidation Driver

NREM slow-wave activity (SWA: 0.8–4.6 Hz), generated by mPFC cortical circuits, is the oscillatory mechanism through which vmPFC-HC coupling consolidates schematic organizations overnight (Mander et al. 2013 [[wiki/papers/prefrontal-atrophy-nrem-mander-2013.md]]):

- **SWA predicts retrieval independence:** more SWA → less post-sleep HC activation → hippocampally-independent (schema-level) recall; the schema can be retrieved without HC reconstruction.
- **HC-mPFC coupling during retrieval** is the neural marker of success: memories that required HC participation at initial retrieval shift toward mPFC-driven retrieval after sufficient SWA, measurable as increased functional connectivity during post-sleep recognition tests.
- **mPFC generates its own consolidation scaffold:** the structure that selects and organizes schemas during waking is the same one that generates SWA during sleep — a feedback loop in which the schema hub actively drives its own offline storage.

**Design implication:** schema consolidation in a model cannot be a purely passive process (e.g., weight decay or replay without gating). It requires an active oscillatory drive from the schema-organizing module itself — analogous to mPFC generating SWA that coordinates the HC→neocortex transfer.

---

## Topological Maps as Spatial Schemas

Martinet et al. 2011 ([[wiki/papers/spatial-learning-pfc-martinet-2011.md]]) show that PFC learns a **topological graph of the environment** that functions as a spatial schema: a reusable relational structure that supports novel inference without re-exploration.

Three schema properties satisfied:
1. **Better memory for schema-consistent information** — locations visited multiple times consolidate into stable topological columns; the schema predicts path options before the animal arrives
2. **Conflict → schema modification** — when a path is blocked, the topological graph is updated (the blocked edge is removed); the animal does not persist with the wrong path but updates the schema dynamically
3. **Novel inference** — the Tolman & Honzik "insight" capability: after encountering a block on path 1 (which shares a segment with path 2), the animal infers that path 2 is *also* blocked and immediately selects path 3, without testing path 2. This requires the topological schema (a node is shared between paths 1 and 2) to support transitive inference (blocking the shared node blocks both paths) — identical to the associative inference property of schemas (A→C via shared B).

**Spreading activation as schema expression:** the same mechanism used for planning (reward back-propagation through the topological graph) is schema expression — the stored relational structure guides optimal action selection. Schema formation = Hebbian edge learning during exploration; schema expression = activation diffusion during planning.

**Spatial vs. declarative schemas:** consistent with Kumaran & Maguire 2005, HC is preferentially engaged for spatial/temporal schemas (topological maps with metric embedding) while mPFC organizes amodal associative schemas. The PFC topological map is a spatial schema implemented in PFC, not in HC — the HC provides the redundant spatial input that PFC *organizes* into the schema. This resolves a potential confusion: the schema hub (mPFC) and the schema medium (spatial topology) can be in the same region.

Hippocampal "time cells" fire at sequential moments during temporally ordered episodes, encoding the temporal structure of experience alongside place cells' spatial code. This temporal scaffold provides the ordered axis (A → B → C sequence) that schemas need to represent multi-event episodes as organized networks rather than unordered sets.

---

## Competing Schemas and Motivational Gating

**Fear/extinction coexistence** is the clearest biological case of competing schemas under context-gated selection (Jin & Maren 2015; [[wiki/papers/jin-maren-hpc-pfc-emotion-2015.md]]):

- Fear conditioning creates Schema A (cue → danger).
- Extinction creates Schema B (cue → safe) — but does not erase Schema A.
- Both schemas coexist in HC. HPC-mPFC contextual gating determines retrieval: outside extinction context → Schema A wins (fear renewal); inside extinction context → Schema B wins.
- Disrupting VH-mPFC connectivity → Schema A always wins regardless of context (impaired extinction recall).

**Motivational salience gates schema selection.** The amygdala provides an emotional valence/priority signal that biases *which* competing schema the HC-mPFC system retrieves:

| Signal | Source | Role in schema selection |
|---|---|---|
| Context code | Ventral HC | Constrains which schemas are eligible (context-match) |
| Emotional salience | Amygdala | Weights eligible schemas by goal-relevance/urgency |
| Rule/goal | mPFC (PL/IL) | Selects the specific schema arm (approach vs. avoidance) |
| Integrated action | NAcc | Downstream convergence: HC context + amygdala valence + mPFC rule → motor output |

**Nucleus accumbens (NAcc) as convergence hub:** NAcc receives simultaneous inputs from PFC (rule/goal), HPC (context), and amygdala (emotional valence). It is the site where context-dependent schema selection is converted into motivated action — not just "which schema matches" but "which schema is most urgent given current goals." This makes motivation a first-class input to schema selection, not a downstream tag.

**VH dual-projecting neurons** (projecting simultaneously to mPFC and amygdala) are the anatomical substrate for this gating: the same context-coding neurons modulate the cognitive selector (mPFC) and the motivational evaluator (amygdala) in one step, ensuring that context-dependent schema selection and motivational weighting are co-timed rather than sequential.

---

## Open Problems

- Cellular mechanism of vmPFC **accommodation**: how does mPFC selectively modify a schema to incorporate conflicting information without disrupting unaffected associations?
- How is contextual schema information (ventral HC → mPFC) bound to specific-event content (mPFC → dorsal HC) without conflating abstraction and instance levels?
- Schema consolidation timescale: human autobiographical schemas persist decades; rodent schemas consolidate within 24–48h. Difference explained by schema complexity or species differences in schema use?

---

## For Building a Reasoning Model

Schemas are the target latent structure in abstract reasoning:

- **Latent graph discovery = schema formation:** the hidden relational graph the model must infer IS the schema; shared elements are edges; schema formation is biological latent-graph discovery
- **mPFC as schema selector = configurator:** selects which rule-schema applies to the current context before querying the HC-like fast-M store for specific episodes — maps directly to Gap #2 (multi-level meta-graph)
- **Accommodation = controlled schema update:** when new input conflicts with the current schema, a meta-level module (mPFC analog) detects the conflict and triggers a controlled update, not catastrophic overwrite — biological solution to the incremental learning problem in Gap #4
- **vmPFC-HC coupling = latent-state gating:** the degree of schema overlap governs how strongly the PFC-analog biases HC retrieval; high overlap → tight gating; low overlap → open retrieval

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — schemas ARE the latent graph: episodes are nodes, shared elements are edges; schema formation is the biological solution to latent-graph discovery; mPFC schema selection = the configurator selecting which graph to navigate
- **[[wiki/concepts/associative-memory.md]]** — transitive inference (A→C via B) is schema expression: HC autoassociation retrieves one-step links; mPFC integration is needed to build the full schematic organization supporting multi-hop inference
- **[[wiki/concepts/continual-learning.md]]** — schema assimilation/accommodation is the biological consolidation mechanism: accommodation updates the schema when conflicting information arrives, analogous to EWC but driven by mPFC conflict detection; assimilation enables one-trial HC learning when schema overlap is high
- **[[wiki/concepts/prospective-coding.md]]** — HC prospective coding (X→Y one look-ahead step) is within-schema edge traversal; mPFC translates the look-ahead into the schema-level outcome (Y→Z); the two-stage architecture is the mechanistic account of schema-level inference
- **[[wiki/concepts/cognitive-control.md]]** — mPFC schema selection is cognitive control over HC retrieval: the same context-guided retrieval mechanism that suppresses context-inappropriate memories during expression also drives conflict-resolution during schema accommodation
- **[[wiki/concepts/replay.md]]** — HC-mPFC synchronized offline replay consolidates schematic organizations; vmPFC-HC coupling during rest predicts subsequent schema expression; reverse replay may credit-assign reward backward through schema edges
- **[[wiki/concepts/two-learning-timescales.md]]** — schema formation requires both fast HC (one-shot per-episode association) and slow mPFC (schematic organization built across multiple episodes); the timescale split maps onto the learning-vs-consolidation axis of Preston & Eichenbaum Table 1
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — ventral/anterior HC is the source of contextual schema signals sent to mPFC; dorsal/posterior HC retrieves specific events within the mPFC-selected schema; time cells provide the temporal axis; HC lesions block inferential expression even when individual associations are learned
- **[[wiki/entities/prefrontal-cortex.md]]** — mPFC is the schema hub: reconciles overlapping associations during learning, builds schematic organizations during consolidation, selects correct schemas during expression; the SEC (Structured Event Complex) framework (Wood & Grafman 2003) is a computational instantiation of how PFC stores structured event schemas
- **[[wiki/papers/preston-eichenbaum-hpc-pfc-2013.md]]** — primary source: schema definition, HC/mPFC division of labor table, associative inference paradigm, ventral/dorsal HC gradient, vmPFC-HC coupling results, assimilation/accommodation framework
- **[[wiki/papers/cls-mcclelland-1995.md]]** — McClelland et al. schema interleaving account; this page extends that framework by specifying mPFC's active role in conflict resolution and schema selection
- **[[wiki/papers/inferential-reasoning-dupret-2020.md]]** — provides the cellular mechanism (prospective code, SWR shortcuts) for the schema edge traversal that Preston & Eichenbaum describe at the behavioral level
- **[[wiki/entities/nucleus-reuniens.md]]** — RE (nucleus reuniens) is the relay for the mPFC schema-selection signal reaching back into dorsal HC; mPFC→RE→HC return arm of the schema-gating loop; goal-directed future path planning via mPFC→RE→sHPC
- **[[wiki/papers/jin-maren-hpc-pfc-emotion-2015.md]]** — source for competing schemas (fear/extinction coexistence), motivational gating via amygdala/NAcc, VH dual-projecting neurons as simultaneous modulator of cognitive selector (mPFC) and emotional evaluator (amygdala)
- **[[wiki/papers/prefrontal-atrophy-nrem-mander-2013.md]]** — source for SWA as the sleep-phase driver of vmPFC-HC schema consolidation; HC-independence and HC-mPFC retrieval coupling as the outcome metrics of successful schema installation; mPFC generates the oscillatory signal that consolidates its own schematic content
- **[[wiki/papers/desousa-pfc-memory-organization-hpc-2026.md]]** — identifies the vmPFC→MEC→NGF circuit as the biological mechanism for schema-guided assimilation vs. accommodation at the circuit level; vmPFC activity controls whether new HC memories are co-allocated into the existing schema engram or kept separate; the 7-day time-gate corresponds to systems consolidation of the prior schema in vmPFC
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — the vmPFC→MEC→dCA1 descending circuit is the physical implementation of the schema-gating arrow in the HC-mPFC division of labor table; MEC is the relay that translates the vmPFC schema signal into hippocampal ensemble control
- **[[wiki/concepts/engrams.md]]** — schema assimilation at the circuit level = co-allocation of new-event cells into the prior schema's engram ensemble; the vmPFC→MEC mechanism biases which prior-memory cells are re-recruited, implementing selective engram overlap as the physical substrate of assimilation
- **[[wiki/papers/euston-mpfc-memory-decision-2012.md]]** — source for the post-task consolidation window (1–2 hours) and the canonical (context, events) → adaptive response input-output framing of mPFC; explains why mPFC is more critical for remote than recent recall (mPFC stores the mapping, not just the components, after consolidation)
- **[[wiki/papers/spatial-learning-pfc-martinet-2011.md]]** — spatial topological maps as spatial schemas: PFC columnar network builds a reusable relational graph from exploration; Tolman insight (path-3 selection after path-1+2 blocking) is schema-based transitive inference via the topological graph; spreading activation is schema expression; edge blocking = schema conflict resolution.
- **[[wiki/concepts/latent-graph-discovery.md]]** — spatial schemas (topological maps) are the spatial instantiation of latent graph discovery; the PFC columnar model shows that schema formation = graph inference, and schema expression = graph search — the schema IS the recovered latent graph.
