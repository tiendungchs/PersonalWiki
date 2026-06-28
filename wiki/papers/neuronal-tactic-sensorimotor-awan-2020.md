---
title: "Neuronal Representations of Tactic-Based Sensorimotor Transformations in the Primate Medial Prefrontal, Presupplementary, and Supplementary Motor Areas — Awan & Mushiake et al. 2020"
type: paper
tags: [medial-PFC, pre-SMA, SMA, tactic-selection, sensorimotor-transformation, cognitive-control, frontal-hierarchy, mixed-selectivity, spatial-gating]
created: 2026-06-27
updated: 2026-06-27
sources: ["Neuronal Representations of Tactic-Based Sensorimotor Transformations in the Primate Medial Prefrontal, Presupplementary, and Supplementary Motor Areas A Comparative Study.md"]
related: [wiki/entities/prefrontal-cortex.md, wiki/concepts/cognitive-control.md, wiki/papers/matsuzaka-pmpfc-tactics-2012.md, wiki/architectural-gaps.md]
---

# Awan & Mushiake et al. 2020 — pmPFC, pre-SMA, SMA: Tactic-Based Sensorimotor Cascade

Awan MH, Mushiake H, Matsuzaka Y. *Frontiers in Systems Neuroscience* 14:536246. doi:10.3389/fnsys.2020.536246

Direct extension of Matsuzaka et al. 2012 to compare all three medial frontal areas (pmPFC, pre-SMA, SMA) under the same two-choice reach/anti-reach tactic paradigm. CPD (coefficient of partial determination) analysis quantifies selectivity for each behavioral variable at each moment.

---

## Key Computational Insights

- **Three-level abstraction cascade.** CPD analysis reveals a clean dissociation: pmPFC encodes tactics + cue position + action; pre-SMA encodes tactics + action (no cue position); SMA encodes mainly action. Information is progressively abstracted from sensory-integrated (pmPFC) to action-only (SMA).

- **Spatial information is PFC-gated.** pre-SMA has abundant PFC afferents but sparse direct parietal afferents. When pmPFC is engaged in multi-tactic conditions, pre-SMA is "unburdened" from spatial integration — pmPFC processes cue location internally and passes only the abstracted tactic+action signal downstream. This explains why previous single-tactic studies found spatial tuning in pre-SMA (no pmPFC engagement → spatial info reaches pre-SMA via alternative routes).

- **Dynamic supervisory control.** Hierarchical shift of control from rostral to caudal: pmPFC supervises and integrates → pre-SMA implements tactic → SMA executes action. As execution begins, pmPFC disengages; control devolves to lower motor areas.

- **Mixed selectivity in individual pmPFC neurons.** Single neurons encode up to three variables simultaneously (tactic × cue position × action). pre-SMA neurons encode one or two variables (tactic and/or action). SMA neurons are predominantly action-selective.

- **Hub-suppresses-satellite evidence from schizophrenia.** PFC hypoactivity in schizophrenia is accompanied by compensatory overactivation of pre-SMA (Cieslik et al. 2015). In healthy brains, the engaged pmPFC hub inhibits/modulates downstream pre-SMA; when the hub fails, the satellite compensates suboptimally.

## Limitations

- Only two animals (*Macaca fuscata*); recordings correlational — no causal intervention.
- Single sensorimotor paradigm; generalization to purely abstract (non-spatial) tactic domains untested.
- Pre-SMA spatial tuning discrepancy with prior literature is explained post-hoc; direct manipulation of pmPFC activity needed to confirm gating hypothesis causally.

---

## Connections

- **[[wiki/entities/prefrontal-cortex.md]]** — adds three-area comparison table to the pmPFC tactic-selection account; spatial cue gating extends the medial supervisory role beyond simple rule selection to information filtering.
- **[[wiki/concepts/cognitive-control.md]]** — establishes the "dynamic supervisory control" cascade (pmPFC→pre-SMA→SMA) as the temporal implementation of the medial supervisory gate; extends the Block 3C design implication with the spatial gating mechanism.
- **[[wiki/papers/matsuzaka-pmpfc-tactics-2012.md]]** — predecessor paper establishing pmPFC tactic selection; this paper adds the pre-SMA/SMA comparison and spatial information gating evidence.
- **[[wiki/architectural-gaps.md]]** — partially grounds Gap #8 binding interface: the hub (pmPFC) integrates raw sensory + abstract rule signals, then gates downstream satellites (pre-SMA) to receive only the abstracted output — the hub suppresses the satellite during integration, then releases it for execution.
