---
title: "Canonical Microcircuits for Predictive Coding"
type: paper
tags: [predictive-coding, cortical-microcircuit, laminar-anatomy, free-energy, gamma-oscillations, beta-oscillations]
created: 2026-06-22
updated: 2026-06-22
sources: [bastos-canonical-microcircuit-2012]
related: [wiki/concepts/predictive-coding.md, wiki/concepts/dendritic-computation.md, wiki/concepts/temporal-coding.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/attention.md, wiki/concepts/canonical-microcircuit.md, wiki/papers/douglas-martin-neocortex-2004.md]
---

# Canonical Microcircuits for Predictive Coding

Bastos, Usrey, Adams, Mangun, Fries & Friston, *Neuron* 2012 (76:695–711). [PMC3777738](https://pmc.ncbi.nlm.nih.gov/articles/PMC3777738/)

---

- **Laminar-to-computational mapping:** Superficial L2/3 pyramidal cells = prediction-error neurons on hidden causes (broadcast feedforward); deep L5/6 pyramidal cells = conditional expectation neurons (broadcast feedback predictions); L4 granular spiny stellate cells = receive incoming prediction errors from the level below and relay to L2/3; supragranular excitatory and inhibitory interneurons = expectations about hidden causes and states respectively; granular inhibitory interneurons = prediction errors on hidden states. The quantitative Haeusler & Maass (2007) intrinsic connectivity data match nearly every connection required by this assignment (two exceptions shown as dotted lines).
- **Spectral asymmetry as a PC (Predictive Coding) prediction:** Conditional expectations integrate prediction errors (ẋ ∝ ε); Fourier analysis shows this suppresses high-frequency content in deep prediction cells (x̃(ω) ∝ ε̃(ω)/ω). Therefore deep layers express more beta; superficial layers more gamma. Confirmed empirically (Buffalo et al. 2011; Maier et al. 2010; Bosman et al. 2012): feedforward inter-areal connections operate at gamma; feedback at beta/alpha.
- **Feedback is both driving and modulatory:** Predictions must obligate responses in lower-level error cells (driving) while remaining context-sensitive (modulatory). Both properties observed anatomically: proximate-area feedback can drive as strongly as feedforward (Covic & Sherman; De Pasquale & Sherman); classical studies show modulatory gain-control for distal areas. PC (Predictive Coding) requires both: prediction must elicit an obligatory error response, but the error magnitude must be context-sensitive.
- **Feedback is net inhibitory via L1:** Top-down feedback terminates in cortical layer 1, which contains nearly 100% inhibitory cells. These cells make monosynaptic inhibitory connections onto apical dendrites of L2/3 pyramidal cells — the specific anatomical route by which predictions suppress prediction errors. L1 is the "hotspot" of inhibition for the feedback stream (Meyer et al. 2011; Shlosberg et al. 2006).
- **Feedforward = linear; feedback = nonlinear:** The PC (Predictive Coding) update equations require prediction errors to be a linear subtraction (ε = x − g(x̃)), while predictions are nonlinear functions of expectations. This asymmetry matches anatomy: feedforward connections are linearly driving; feedback connections express nonlinear/modulatory post-synaptic effects required for context-sensitive prediction formation.

**Limitations:**
- The assignment of granular inhibitory interneurons to hidden-state prediction errors requires two connections not present in the Haeusler & Maass dataset; these remain anatomically under-quantified.
- Many other laminar mappings are consistent with the same PC (Predictive Coding) equations; the assignment will be refined as optogenetic and connectomic data accumulate.
- The model addresses intrinsic (within-column) and extrinsic (inter-areal) connections but does not specify how lateral (same-level) connections implement the lateral competition term in the PC (Predictive Coding) energy objective.

→ [[wiki/concepts/predictive-coding.md]] — derives the full laminar mapping from first principles and adds spectral asymmetry section
→ [[wiki/concepts/dendritic-computation.md]] — L1 inhibitory cells + apical dendrites are the anatomical substrate for feedback prediction delivery
→ [[wiki/concepts/temporal-coding.md]] — gamma/beta spectral asymmetry is the temporal-coding fingerprint of feedforward error vs. feedback prediction signals
→ [[wiki/concepts/hierarchical-representations.md]] — the feedforward/feedback functional asymmetry established here is the mechanistic basis for the pattern-recognition vs. model-building distinction
→ [[wiki/concepts/canonical-microcircuit.md]] — this paper maps PC (Predictive Coding) equations onto the canonical loop described in Douglas & Martin 2004; the anatomy here is the substrate on which the PC (Predictive Coding) variable assignments sit
→ [[wiki/papers/douglas-martin-neocortex-2004.md]] — primary anatomy source; establishes the circuit, recurrent amplification, soft WTA, and SLN% hierarchy rule that Bastos et al. assign PC (Predictive Coding) variables to
