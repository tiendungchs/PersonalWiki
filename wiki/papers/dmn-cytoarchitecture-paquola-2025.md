---
title: "The architecture of the human default mode network explored through cytoarchitecture, wiring and signal flow"
type: paper
tags: [default-mode-network, cytoarchitecture, connectivity, signal-flow, cortical-types, effective-connectivity]
created: 2026-06-27
updated: 2026-06-27
sources: []
related: [wiki/entities/default-mode-network.md, wiki/concepts/connectivity-gradients.md, wiki/concepts/canonical-microcircuit.md, wiki/concepts/hierarchical-representations.md]
---

# The architecture of the human default mode network

**Paquola et al., Nature Neuroscience 2025.** Combines BigBrain postmortem histology + multimodal in vivo MRI (3T cohort + 7T individual replication) to map DMN cytoarchitecture and its relationship to structural wiring and effective signal flow.

---

## Key Computational Insights

- **Cytoarchitectural heterogeneity**: DMN contains 5 of 6 cortical types (koniocortical absent); uniquely over-represents eulaminate-I (heteromodal cortex, +18%, P_spin=0.006). Most compositionally balanced multi-type network in the brain.
- **Intra-DMN axis E1**: Diffusion map embedding of BigBrain cell-staining profiles reveals a principal cytoarchitectural axis from peaked (unimodal eulaminate-III: retrosplenial, posterior middle temporal) to flat (agranular: medial parahippocampus, anterior cingulate). Distinct from the global G1 unimodal→transmodal gradient — the DMN's internal organization is a **mosaic** (some neighboring areas are microarchitecturally distinct; some distant areas are similar), not a simple gradient.
- **Two local integration motifs**: (1) Mesiotemporal subregion — smooth gradient; maps to sequential convergence of signals from lower- to higher-order representations. (2) Prefrontal subregion — high-waviness interdigitation; maps to cross-domain integration of signals from disparate sources at close range.
- **Receiver periphery / insulated core**: Low-E1 areas (inferior parietal, precuneus) have high navigation efficiency (E_nav) to sensory cortex (r=−0.60, P_spin=0.001) and receive convergent effective connectivity input from all cortical types. High-E1 areas (anterior cingulate, medial PFC) are structurally and functionally insulated from sensory systems. The insulated core is suppressed longest during externally oriented tasks.
- **Unique balanced output**: Of all functional networks in the human cortex, only the DMN distributes its effective connectivity output approximately equally across all cortical types (all levels of sensory hierarchies). Input to the DMN is unbalanced (concentrated at receiver periphery); output from the DMN is balanced. This is unique to the DMN.
- **Association hierarchy**: DMN is neither nested within nor parallel to the sensory-fugal hierarchy; it "protrudes" from it — strong afferent convergence at one end, insulation at the other. Internal organization is less constrained by spatial gradients than sensory hierarchies, consistent with a supramodal integrative role.

## Limitations

- Cytoarchitectural mapping relies on a single postmortem brain (BigBrain, male, 65y); individual-level replication in 8 participants via 7T qT1 shows moderate correspondence (r_avg=0.34), confirming the pattern but not eliminating interindividual variability.
- rDCM effective connectivity is a Bayesian linear regression approximation; non-linear dynamics are not captured.
- All findings are correlational between anatomy and connectivity; no causal manipulation of DMN subregions.

## Links

- [[wiki/entities/default-mode-network.md]] — primary entity updated with cytoarchitectural anatomy section, receiver/core split, and balanced output finding
- [[wiki/concepts/connectivity-gradients.md]] — E1 intra-DMN axis added as a within-network gradient distinct from G1
- [[wiki/concepts/canonical-microcircuit.md]] — cortical types (laminar elaboration levels) are the microcircuit substrate underlying E1; SLN% hierarchy rule predicts the feedforward/feedback asymmetry between receiver and insulated subregions
- [[wiki/concepts/hierarchical-representations.md]] — association hierarchy framing extends the hierarchical representations concept beyond the sensory-fugal system
