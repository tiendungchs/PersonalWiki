---
title: "Learning, Fast and Slow: Single- and Many-Shot Learning in the Hippocampus"
type: paper
tags: [hippocampus, plasticity, BTSP, STDP, replay, single-shot-learning, sequence-learning]
created: 2026-06-20
updated: 2026-06-20
sources: [Learning, Fast and Slow Single- and Many-Shot Learning in the Hippocampus]
related: [wiki/concepts/two-learning-timescales.md, wiki/concepts/replay.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/place-cells.md, wiki/concepts/associative-memory.md, wiki/concepts/structural-generalization.md]
---

# Learning, Fast and Slow: Single- and Many-Shot Learning in the Hippocampus

Liao & Losonczy. *Annual Review of Neuroscience* 47, 2024. DOI: 10.1146/annurev-neuro-102423-100258

---

- **BTSP as single-shot learning rule**: A dendritic plateau potential in CA1 — induced by an instructive signal (plausibly from entorhinal cortex; Grienberger & Magee 2022) — drives seconds-long potentiation of all synaptic inputs active within that behavioral window (Bittner et al. 2017). First direct synapse-level in vivo confirmation: CA2/3 inputs must be potentiated for new place field acquisition (Fan et al. 2023; Gonzalez et al. 2023). BTSP integrates population statistics over seconds rather than individual spike pairs over milliseconds — implementing one-shot concept acquisition equivalent to supervised learning of a binary classifier at the single-cell level.
- **STDP as many-shot sequence learning**: Millisecond-scale STDP accumulates many small weight changes across trials to embed pairwise sequential associations in recurrent CA3 weights. Symmetric STDP kernel in CA3 (Mishra 2016) — distinct from classically asymmetric neocortical STDP — enables both forward and backward replay generation. Two gap-bridging mechanisms: time cells respond with fixed delay, and theta oscillation organizes spikes into millisecond-separated pairs that fall within STDP windows.
- **Inhibitory plasticity for structural filtering**: Modeling work (Liao et al. 2022) shows that GABAergic synapse weight modification is required to selectively suppress non-generalizable stimuli from SWR replay while preserving structural regularities — the computational explanation for Terada et al. 2022's empirical finding that SWRs recruit representations of predictable stimuli and actively suppress random ones even after repeated online exposure.
- **Replay is adaptive not verbatim**: Three convergent findings establish an inductive bias toward a transferable cognitive map: (a) SWRs suppress salient random stimuli while upsampling predictable ones (Terada 2022); (b) replay upsamples under-experienced spatial regions relative to online exposure (Grosmark 2021); (c) replay appears after a single exposure and gains resolution with experience (Berners-Lee 2022). Inhibitory plasticity gradually implements a curriculum: first encode broadly, then selectively consolidate generalizable content.
- **Speed-amplitude trade-off unifies BTSP and STDP**: BTSP integrates over seconds → large Δw → single shot; STDP integrates over milliseconds → small Δw → many shots. The two rules are complementary: BTSP acquires new concepts (nodes); STDP embeds sequential relationships between them (edges). This two-primitive system is provably expressive enough to represent any graph — including abstract cognitive maps over non-spatial dimensions (frequency, faces, conjunctions).

**Limitations:** Review paper, no novel primary data. Inhibitory plasticity predictions (Liao et al. 2022) are primarily computational; direct in vivo GABAergic plasticity evidence at HC synapses remains sparse. BTSP generalization beyond CA1/CA3 to other brain areas is speculative. Mechanisms controlling the transition from specific to generalizable replay over experience are not yet identified.

---

**Links:**
- [[wiki/concepts/two-learning-timescales.md]] — BTSP is the molecular mechanism of fast-M write in HC; BTSP+STDP form a within-HC two-timescale hierarchy nested inside the HC/cortex split
- [[wiki/concepts/replay.md]] — adaptive replay selectivity and inhibitory plasticity as filtering mechanism
- [[wiki/entities/hippocampal-entorhinal-system.md]] — EC as instructive signal source for BTSP; CA1 dendritic plateau mechanism
- [[wiki/entities/place-cells.md]] — BTSP is the actual single-shot mechanism for place field acquisition ("one-shot Hebbian" is superseded)
- [[wiki/concepts/structural-generalization.md]] — concept+sequence graph representation is the computational target; BTSP+STDP together are sufficient for any graph
