---
title: "Cooperative actions of interneuron families support the hippocampal spatial code"
type: paper
tags: [hippocampus, interneurons, place-cells, inhibitory-circuits, spatial-coding, Pvalb, Sst, Vip, Id2, excitation-inhibition]
created: 2026-06-26
updated: 2026-06-26
sources: [valero-interneuron-families-2025]
related: [wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/excitation-inhibition-balance.md, wiki/concepts/canonical-microcircuit.md]
---

# Cooperative actions of interneuron families support the hippocampal spatial code

Valero, Abad-Perez et al. (Buzsáki lab), *Science* 389, eadv5638 (2025). [PMC13124309]

---

- **Physiological fingerprinting:** 5-feature decision tree (CV2, ACG rise time, spike width, theta modulation, spike asymmetry) classifies four GABAergic families — *Pvalb*, *Sst*, *Vip*, *Id2* — and pyramidal cells (*CaMK2α*) with >89.7% accuracy; family fractions in unlabeled populations correlate with gene-expression ground truth.
- **Division of labor:** each family shapes a distinct place field feature — Pvalb → stability; Sst → context generalization (L/R arm); Vip → space-rate MI and selectivity; Id2 → context specificity.
- **Time-division control:** Pvalb activation suppresses the *first half* of place fields (entorhinal input phase); Sst and Id2 activation suppresses the *second half* (CA3 recurrent phase). Mechanism: potentiation of the place cell–OLM (Sst) synapse shifts input dominance from EC to CA3 across the field.
- **VIP disinhibitory gate:** Vip suppresses Sst/OLM cells → disinhibits pyramidal cells → strongest place field amplitude boost of any family. Directly validates the canonical Vip→Sst→Pyramidal disinhibitory motif in vivo.
- **Interneurons as active spatial coders:** interneuron-only CEBRA position decoder matches down-sampled pyramidal cell decoder; leaving out any single family degrades decoding (Vip, Id2, Pvalb exclusions most damaging).
- **Cross-region conservation:** functional coupling matrix between families is conserved between hippocampus and neocortex, confirming the four-family motif is a canonical circuit module.

**Limitations:** CA1 field only; freely-moving mouse; spatial alternation task (single behavioral context); physiological fingerprinting not yet validated in human electrophysiology.

---

- **[[wiki/entities/place-cells.md]]** — interneuron families shape place field stability, selectivity, generalization, and MI; time-division control segregates entorhinal vs. CA3 input phases across the field
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — interneuron cooperation is a circuit mechanism implementing the CA1 cognitive map; VIP disinhibitory gate is a context-sensitive gain modulator for HC encoding
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — partially resolves the open problem of cell-type E/I decomposition: Pvalb/Sst/Vip/Id2 have orthogonal computational roles that the single-population E/I parameter collapses
- **[[wiki/concepts/canonical-microcircuit.md]]** — empirical grounding for four-family inhibitory dissociation conserved across hippocampus and neocortex, extending the canonical horizontal/vertical split
