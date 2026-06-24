---
title: "Neuronal Circuits of the Neocortex"
type: paper
tags: [canonical-microcircuit, neocortex, laminar-organization, recurrent-amplification, winner-take-all, inhibitory-interneurons]
created: 2026-06-23
updated: 2026-06-23
sources: [douglas-martin-neocortex-2004]
related: [wiki/concepts/canonical-microcircuit.md, wiki/concepts/predictive-coding.md, wiki/concepts/dendritic-computation.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/attention.md, wiki/papers/bastos-canonical-microcircuit-2012.md]
---

# Neuronal Circuits of the Neocortex

Douglas, R.J. & Martin, K.A.C. *Annual Review of Neuroscience* 27:419–451, 2004.

---

- **Canonical circuit universality:** The same basic laminar loop (L4→L2/3→L5→L6→L4) is found across all neocortical areas (V1, V2, motor, somatosensory, PFC, auditory) and across mammalian species from marsupials to primates. Differences between areas are sublamination refinements of one basic pattern — analogous to a grandfather clock vs. a Swiss chronometer, not different mechanisms.
- **Recurrent amplification:** Thalamic synapses constitute <10% of excitatory inputs in L4, yet they drive cortical responses; peak EPSP amplitudes from thalamic synapses are only ~2× those of cortico-cortical synapses. Resolution: small inputs trigger cascading recurrent excitation through the canonical loop, amplifying weak afferent signals to cortical scale without requiring anomalously strong synapses.
- **Inhibitory dissociation (two functional classes):** Horizontal smooth cells (basket, chandelier) target soma, AIS, and proximal dendrites — implementing a soft winner-take-all / soft MAX among competing L2/3 patches. Vertical smooth cells (double bouquet) target distal basal and apical dendrites — dynamically gating the input-output transfer function of individual dendritic compartments.
- **Explore / exploit layer split:** Superficial L2/3 neurons are organized to explore all possible interpretations of inputs: patchy lateral connections (~10–30 patches at 400–700 µm) provide heterogeneous sampling, horizontal inhibition selects the most consistent interpretation. Deep L5/6 neurons exploit the winning interpretation: L5 drives subcortical structures (motor output, BG (Basal Ganglia), colliculus); L6 closes the loop to thalamus.
- **SLN% hierarchical distance rule:** The proportion of superficial-layer neurons (SLN%) contributing to a projection between two areas encodes their hierarchical distance: SLN%→100% is feedforward (L3→L4 of target); SLN%→0% is feedback (L5/6→L1/5/6 of target). Confirmed quantitatively in macaque visual cortex; implies a single consistent hierarchy rather than a partial order.

**Limitations:**
- Pre-molecular-subtypes era; cannot resolve inhibitory interneuron diversity now accessible via scRNA-seq (e.g., PV/SST/VIP dissociation missing).
- Synapse counts are sparse; most connection strengths inferred from anatomy rather than physiology, leaving quantitative circuit parameters underdetermined.
- The soft WTA (Winner-Take-All) model is qualitative; no formal derivation of selection dynamics or convergence criteria.

→ [[wiki/concepts/canonical-microcircuit.md]] — primary anatomy source for the canonical laminar circuit, recurrent amplification, soft WTA (Winner-Take-All) model, and SLN% hierarchy rule
→ [[wiki/concepts/predictive-coding.md]] — the laminar circuit is the anatomical substrate mapped to PC (Predictive Coding) variables by Bastos et al. 2012, which cites this paper as primary anatomy source
→ [[wiki/concepts/dendritic-computation.md]] — double bouquet / basket cell dissociation is the biological substrate for the dual-compartment (distal/proximal) dendritic gating described there
→ [[wiki/concepts/hierarchical-representations.md]] — SLN% rule grounds the feedforward/feedback functional asymmetry that distinguishes bottom-up pattern recognition from top-down model building
→ [[wiki/papers/bastos-canonical-microcircuit-2012.md]] — directly builds on this paper: maps PC (Predictive Coding) equations onto the circuit described here
