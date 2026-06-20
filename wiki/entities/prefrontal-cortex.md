---
title: "Prefrontal Cortex (PFC)"
type: entity
tags: [PFC, prefrontal-cortex, cognitive-control, working-memory, goal-maintenance, SEC, hierarchy, biological-system]
created: 2026-06-19
updated: 2026-06-20
sources: [pfc.md, pfc-cognitive-control-friedman-2021.md, pfc-meta-rl-wang-2018.md, pbwm-oreilly-frank-2006.md, analogy_reasoning.md]
related: [wiki/concepts/cognitive-control.md, wiki/concepts/working-memory.md, wiki/concepts/meta-learning.md, wiki/concepts/neuromodulation.md, wiki/concepts/predictive-coding.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/papers/pfc-wood-grafman-2003.md, wiki/papers/pfc-cognitive-control-friedman-2021.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/pbwm-oreilly-frank-2006.md, wiki/concepts/analogical-reasoning.md, wiki/papers/analogy-holyoak-2012.md]
---

# Prefrontal Cortex (PFC)

Anterior cortex rostral to premotor areas. Divided into two functional streams with distinct connectivity and computational roles.

---

## Anatomy and Connectivity

| Subregion | Connectivity | Computational role |
|---|---|---|
| **vmPFC (BA-10/11/12)** | Amygdala, hippocampus, temporal visual areas | Goal value; social/emotional SECs; abstract grid codes (Constantinescu 2016) |
| **dlPFC (BA-8/9/46)** | Basal ganglia, premotor cortex, parietal cortex | Goal maintenance; WM interference resistance; contextual rule keeping |
| **Frontopolar (BA-10, anterior)** | Bilateral PFC, dorsal/ventral streams | **Simultaneous multi-relational integration** (Christoff 2001; Kroger 2002; Cho 2010): selectively activated when ≥2 relations must be integrated at once, not merely for rule nesting depth; also: branching subgoal management; longest-duration SECs |
| **ACC (BA-24/32)** | Brainstem neuromodulatory nuclei, SMA | Unsigned prediction error; proactive/reactive CC modulation |
| **RIFG (BA-44/45)** | Subthalamic nucleus (hyperdirect pathway) | Response inhibition; stop-signal via STN |

PFC pyramidal cells have more dendritic spines than other cortical pyramidal cells → broader multi-source integration. Majority of dlPFC delay-period neurons show transient (not persistent) activity.

---

## Functional Properties

- **Goal maintenance** — PFC goal representations send top-down bias signals enabling non-prepotent task-correct responses to win lateral inhibition competition in posterior cortex (Miller & Cohen 2001)
- **SEC storage** — stores Structured Event Complexes: goal-oriented temporal event sequences encoding rules, abstractions, grammars (Wood & Grafman 2003); SEC activation predicts subsequent events
- **Hierarchical gradient** — rostro-caudal: BA-10 (long SECs / rules-of-rules) → BA-9/46 (contextual rule / WM hub) → BA-8 (S-R conditional mapping); mid-lateral is the integration hub
- **Meta-RL** — DA encodes slow synaptic updates (outer loop); PFC LSTM dynamics implement within-episode model-free RL (fast inner loop); model-based behavior emerges (Wang et al. 2018)
- **Multi-relational integration (BA-10 specificity)** — frontopolar activation scales with number of relations held simultaneously, not with rule nesting depth per se; inferior frontal gyrus (BA-44/45) handles distractor suppression (semantically close competitors) independently; together they implement the mapping constraint-satisfaction stage of analogical reasoning (Holyoak 2012)
- **WM** — activated long-term memory (Goldman-Rakic); dlPFC mediates interference resistance and updating specifically; transient delay activity is TRNN-compatible

---

## Mapping to Model Components

| PFC component | Block | Best ML tool |
|---|---|---|
| Transient delay activity (dlPFC) | Block 3B | TRNN (transient) + meta-RL LSTM (policy context) |
| Hierarchical gradient (BA-8→9/46→10) | Block 3C | Three-level W: W_ror → W_context → W_instance |
| Transformation inferrer (efference copy inversion) | Block 3A | Set-attention over Δg |
| vmPFC goal generator | Block 3D | Argmin over W vocabulary toward g_goal |
| ACC unsigned prediction error | Block 2C gate | Surprise-gated write |

---

## Comparison with Hippocampal-Entorhinal System

| Feature | PFC | HC/MEC |
|---|---|---|
| Timescale | Seconds (WM); lifetime (SEC representations) | Fast binding (minutes); sleep-phase consolidation |
| Representation | SECs: temporal sequences, rules, grammars | Maps: g/x/p factorized; episodic (g, x) bindings |
| Generalization | Rule/grammar abstraction; cross-context transfer | Structural: same W across environments |
| Neuromodulation | DA D1/D2 (stability/flexibility); NA (inhibition); ACC (unsigned PE) | ACh (storage-retrieval switch); DA (consolidation RPE) |
| ML analog | LSTM meta-RL + TRNN + three-level hierarchy | TEM W/M two-timescale factorized model |

---

## Connections

- **[[wiki/concepts/cognitive-control.md]]** — PFC is the primary biological substrate of CC; dlPFC goal maintenance = the unified CC mechanism; hierarchical PFC gradient (BA-8→9/46→10) directly maps onto Blocks 3B/3C; SEC framework grounds Block 3C content as structured event sequences.
- **[[wiki/concepts/working-memory.md]]** — dlPFC mediates WM interference resistance and updating; transient delay activity is consistent with TRNN (not persistent attractor); WM = activated long-term memory (Goldman-Rakic).
- **[[wiki/concepts/meta-learning.md]]** — PFC/BG is the canonical meta-RL instantiation; DA (slow synaptic plasticity = outer loop) + PFC LSTM dynamics (fast inner loop) = the two-timescale split in PFC; model-based RL emerges from model-free meta-training.
- **[[wiki/concepts/neuromodulation.md]]** — DA D1 (WM stability), D2 (flexibility/updating), NA via RIFG→STN (response inhibition), 5-HT via OFC (reversal learning / set-shifting); each PFC subregion has a distinct neuromodulatory signature.
- **[[wiki/concepts/predictive-coding.md]]** — ACC as CC-domain PC: unsigned prediction error modulates both reactive and proactive CC; vmPFC encodes a prior over expected outcomes; SEC predictive function is consistent with FEP generative-model framing.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — HC provides episodic bindings that PFC consolidates into abstract SECs during sleep; vmPFC abstract grid codes (Constantinescu 2016) suggest HC/MEC architecture extends into PFC for abstract domains; HC is the short-term storage layer that feeds the long-term PFC representational system.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — Blocks 3A–3D are the ML decomposition of PFC function; this entity page is the biological anchor for all four; vmPFC/dlPFC categorical specificity informs content type of each W level in Block 3C.
- **[[wiki/papers/pbwm-oreilly-frank-2006.md]]** — PBWM establishes the BG-PFC stripe circuit and PVLV learning rule that underlies the meta-RL system described on this page; ~20K parallel per-stripe BG-PFC loops are the physical implementation of the LSTM hidden-state abstraction in Wang et al. 2018.
- **[[wiki/concepts/analogical-reasoning.md]]** — frontopolar BA-10 is the neural bottleneck for simultaneous multi-relational constraint integration (the mapping stage of analogy); the ≤2-3 proposition WM limit in LISA is the mechanistic explanation for why BA-10 activation scales with relational count, not just nesting depth.
- **[[wiki/papers/analogy-holyoak-2012.md]]** — source for the BA-10 multi-relational integration specificity (Christoff 2001; Kroger 2002; Cho 2010 neuroimaging; Waltz 1999 lesion dissociation); refines the Block 3C architecture specification.
