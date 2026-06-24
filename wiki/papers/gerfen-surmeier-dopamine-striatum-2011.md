---
title: "Modulation of Striatal Projection Systems by Dopamine — Gerfen & Surmeier 2011"
type: paper
tags: [basal-ganglia, dopamine, striatum, direct-pathway, indirect-pathway, action-selection, synaptic-plasticity, D1-receptor, D2-receptor, cholinergic]
created: 2026-06-20
updated: 2026-06-20
sources: [Modulation of striatal projection systems by dopamine]
related: [wiki/entities/basal-ganglia.md, wiki/concepts/neuromodulation.md, wiki/concepts/meta-learning.md, wiki/papers/pbwm-oreilly-frank-2006.md, wiki/papers/metalearning-neuromodulation-doya-2002.md]
---

# Modulation of Striatal Projection Systems by Dopamine — Gerfen & Surmeier 2011

Gerfen CR, Surmeier DJ. *Annual Review of Neuroscience* 34:441–466, 2011. doi:10.1146/annurev-neuro-061010-113641. PMID: 21469956.

Review of two decades of evidence for D1/D2 receptor segregation in striatal direct and indirect pathways, culminating in cell-type-specific physiological and plasticity characterization enabled by BA (Brodmann Area)C transgenic reporter mice.

---

## Five Key Computational Insights

- **Opponent plasticity from a single Dopamine event.** D1 (direct SPN) → Gs → PKA → Cav1 Ca²⁺ ↑, K⁺ ↓, AMPA/NMDA surface expression ↑ → LTP (Long-Term Potentiation) + excitability ↑. D2 (indirect SPN) → Gi → cAMP ↓, Cav1 ↓, K⁺ ↑, endocannabinoid production → retrograde CB1 → Glu release ↓ → LTD (Long-Term Depression) + excitability ↓. A single phasic Dopamine burst writes opposite plasticity rules to both populations simultaneously — credit assignment is inherently bidirectional, not scalar.

- **Up-state bistability as convergence gating.** SPNs rest at −90 mV (Kir2 K⁺ "down-state") and only transition to "up-state" under spatially/temporally *convergent* glutamatergic input. D1 lowers the convergence threshold in direct SPNs; D2 raises it in indirect SPNs. Action selection is therefore implemented as hardware-level coincidence detection, not winner-take-all rate coding.

- **Structural asymmetry.** Indirect SPNs have ~50% fewer primary dendrites (less total glutamatergic input) but higher intrinsic somatic excitability than direct SPNs. The "NoGo" pathway is wired to be a hair-trigger sensor held back by tonic D2 suppression — releasing the brake (DA drop) activates action suppression rapidly.

- **Cholinergic temporal gating.** Thalamic salience inputs drive cholinergic interneurons through burst-pause firing. Burst: M2 presynaptic suppression of corticostriatal Glu release. Pause: M1 postsynaptic on D2 SPNs closes Kir2 → ~1-second window of enhanced indirect-pathway dendritic excitability. Dopamine (D2 on cholinergic interneurons) gates the pacemaker — baseline Dopamine suppresses the burst-pause; Dopamine drops allow thalamic salience to redirect processing through the NoGo pathway.

- **Parkinson's disease as natural experiment.** Dopamine depletion reverses plasticity bias in both pathways simultaneously: D1 loss → direct SPNs shift to LTD (Long-Term Depression) bias; D2 loss → indirect SPNs gain LTP (Long-Term Potentiation) capacity. Both shifts favor indirect pathway dominance → action suppression locked in. Confirmed by optogenetic selective activation (Kravitz et al. 2010). Implication: opponent credit assignment is architecturally necessary — lesioning one side is not compensated by the other.

---

## Limitations

- Cellular plasticity rules established almost entirely in vitro (brain slice); convergent-input dynamics in intact awake animals may differ substantially.
- Virtually all plasticity work conflates corticostriatal and thalamostriatal synapses (not experimentally separable with macro-electrodes); the two synapse populations are computationally distinct.
- Distal SPN (Spiny Projection Neuron) dendritic integration is almost completely unknown; D1/D2 receptors are most dense in distal dendrites yet all patch-clamp work is somatic or proximal.

---

## Links

- [[wiki/entities/basal-ganglia.md]] — full anatomical and functional account of the BG (Basal Ganglia) circuit
- [[wiki/concepts/neuromodulation.md]] — D1/D2 cellular cascades ground the "DA = TD (Temporal Difference) error" metaparameter in specific receptor biochemistry
- [[wiki/concepts/meta-learning.md]] — PVLV cellular substrate: opponent LTP/LTD is the synaptic plasticity step underlying BG (Basal Ganglia) slow outer loop
- [[wiki/papers/pbwm-oreilly-frank-2006.md]] — PBWM model whose per-stripe Dopamine signal this paper grounds at the receptor level
