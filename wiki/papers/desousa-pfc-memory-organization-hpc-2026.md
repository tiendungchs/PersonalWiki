---
title: "The prefrontal cortex controls memory organization in the hippocampus"
type: paper
tags: [prefrontal-cortex, hippocampus, memory-organization, vmPFC, MEC, NGF, memory-integration, memory-separation, memory-allocation, engrams]
created: 2026-06-27
updated: 2026-06-27
sources: ["The prefrontal cortex controls memory organization in the hippocampus"]
related: [wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/prefrontal-cortex.md, wiki/concepts/engrams.md, wiki/concepts/pattern-separation.md, wiki/concepts/memory-schemas.md]
---

# The prefrontal cortex controls memory organization in the hippocampus

de Sousa, Zeidler, Almeida-Filho et al., *Nature Neuroscience*, 2026-04-28. doi:10.1038/s41593-026-02231-1

Demonstrates a direct vmPFC→MEC→dCA1 circuit that gates memory integration vs. separation in hippocampus, with neurogliaform (NGF/NDNF+) inhibitory cells in CA1 SLM as the local effectors and top-down memory allocation as a novel mechanism.

---

## Key Computational Insights

- **vmPFC activity gates integration vs. separation bidirectionally.** vmPFC neurons (prelimbic + infralimbic) show *increased* calcium event rates when mice explore different contexts 7 days apart (separation condition) and *decreased* rates for the same context at any interval or different contexts 5h apart (integration conditions). Chemogenetic inhibition of vmPFC during 7-day encoding forces memory linking; inhibition during 5h encoding has no effect. Activating vmPFC→MEC terminals during same-context encoding (normally integration) forces separation. The vmPFC is an active memory-separation signal, not merely a permissive gate.

- **Circuit: vmPFC → MEC → NGF cells in CA1 SLM → ensemble overlap.** The specific pathway is: excitatory vmPFC neurons (mostly deep layers, GAD67−) project to MEC layers II, III, and V. MEC layers II/III/V neurons project via the temporoammonic pathway to the CA1 stratum lacunosum moleculare (SLM) and the DG molecular layer. In the SLM, neurogliaform (NGF) cells marked by NDNF (neuron-derived neurotrophic factor) are the downstream effectors: vmPFC→MEC activity activates NGF cells; NGF cell activity gates EC and CA3 inputs to CA1 pyramidal neurons; when NGF cells are inhibited (chemogenetically), dCA1 ensemble overlap increases, mirroring vmPFC inhibition. Causal evidence: direct inhibition of NDNF+ cells replicates the increased-overlap phenotype.

- **Top-down memory allocation beyond CREB excitability.** vmPFC→MEC projections determine which neurons are co-allocated to encode the second memory, beyond intrinsic excitability competition. Control conditions: top 10% most-active neurons encoding context B draw ~15% from prior-context A engram, ~24% from home-cage neurons, ~45% from context-B-unique neurons. With vmPFC→MEC inhibited: prior-context A neurons increase to ~27% while home-cage neurons decrease to ~18% and context-B-unique neurons to ~38% — the distribution matches what is seen when the same context is revisited. Activating vmPFC→MEC during same-context revisit reverses this (prior-context neurons drop from ~25% to ~12%). This is a novel mechanism: the vmPFC shapes *which prior-memory cells are re-recruited*, not just whether firing rates change.

- **Systems consolidation prerequisite (time-gate at ~7 days).** vmPFC control is absent at the 5h interval and emerges by 7 days. This aligns with the timeline of memory consolidation in PFC: the vmPFC must have a consolidated representation of the prior memory before it can influence new encoding. Architectural implication: the top-down control circuit has a temporal gate — the schema-organizing module requires offline consolidation before it can exert selective integration control.

- **Contextual specificity.** vmPFC→MEC inhibition increases overlap between two contexts but not between a context and a home-cage event, or between a context and an unrelated hippocampus-dependent task. The top-down control targets contextually related memories specifically — it is not a global gain modulator.

---

## Limitations

- All causal experiments in mice; direct translation of the vmPFC→MEC pathway to primate dorsolateral/ventromedial PFC anatomy is not established.
- vmPFC→LEC inhibition produced memory generalization (elevated freezing in novel context C), suggesting LEC projections have a separate role in preventing overgeneralization that was not fully characterized.
- Direct excitability measures (patch-clamp) were not taken; the claim that vmPFC→MEC shapes memory allocation beyond excitability is inferred from ensemble imaging, not from single-neuron conductance measurements.

---

## Links

- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — vmPFC→MEC→dCA1 SLM circuit added; NGF/NDNF+ cells as fourth interneuron regulatory layer on CA1 ensemble overlap
- **[[wiki/entities/prefrontal-cortex.md]]** — vmPFC memory-organization role via MEC projection added; bidirectional separation/integration control
- **[[wiki/concepts/engrams.md]]** — top-down memory allocation mechanism (vmPFC→MEC biases co-allocation of prior-memory engram cells) added alongside CREB excitability mechanism
- **[[wiki/concepts/pattern-separation.md]]** — vmPFC→MEC→NGF circuit as top-down regulatory layer of the integration/separation balance, complementing the hilar/noradrenergic bottom-up circuit
- **[[wiki/concepts/memory-schemas.md]]** — vmPFC→MEC circuit identified as the biological mechanism for schema-guided assimilation vs. accommodation at the circuit level
