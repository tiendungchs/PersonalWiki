---
title: "The Dynamics of Functional Brain Networks: Integrated Network States during Cognitive Task Performance"
type: paper
tags: [functional-connectivity, network-topology, integration-segregation, neuromodulation, cognitive-control, working-memory, fMRI, locus-coeruleus, hub-nodes]
created: 2026-06-27
updated: 2026-06-27
sources: ["The Dynamics of Functional Brain Networks Integrated Network States during Cognitive Task Performance"]
related:
  - wiki/concepts/network-integration-segregation.md
  - wiki/concepts/neuromodulation.md
  - wiki/concepts/small-world-networks.md
  - wiki/concepts/cognitive-control.md
  - wiki/concepts/criticality.md
  - wiki/entities/default-mode-network.md
  - wiki/entities/prefrontal-cortex.md
---

# Shine et al. 2016 — Integrated Network States during Cognitive Task Performance

Shine JM, Bissett PG, Bell PT, Koyejo O, Balsters JH, Gorgolewski KJ, Moodie CA, Poldrack RA. *Neuron* 92(2):544–554. doi:10.1016/j.neuron.2016.09.018. HCP (Human Connectome Project) discovery cohort N=92, replication N=92, NKI N=152. Time-resolved fMRI connectivity (MTD metric) with k-means clustering of "cartographic profiles."

---

## Key Computational Insights

- **Two-state topology toggle:** k=2 clustering of the cartographic profile (joint histogram of W_T, B_T per temporal window) cleanly partitions all brain states into **segregated** (high modularity Q_S=0.55, low global efficiency E_S=0.18) and **integrated** (low Q_I=0.42, high E_I=0.24); brain spends ~70% of rest in integrated states.
- **Task demand scales integration:** N-back task shifts cartographic profile toward integration (r=0.52 with task block regressor); degree of integration scales with task complexity — N-back (hardest) > relational/language/emotion > motor (most segregated); each task type occupies a distinct point on the integration axis.
- **Integration predicts evidence accumulation quality, not caution:** higher B_T → higher EZ-diffusion drift rate *v* (faster evidence accumulation) + shorter non-decision time *t* (faster perceptual/motor processing); no relationship with boundary separation *a* (response caution); effect concentrated in frontoparietal, striatal, thalamic, pallidal regions.
- **Locus coeruleus (LC) as integration gate:** pupil diameter (LC-NA proxy, separate N=14 dataset) correlates with mean B_T (r=0.241 ± 0.06), maximal in frontoparietal, striatal, and thalamic regions; implicates noradrenergic gain modulation as the mechanism shifting whole-brain topology.
- **Hub regions mediate integration:** frontoparietal, striatal, and thalamic "rich club" nodes show the largest B_T increases during task; these hubs act as bridges enabling otherwise-isolated modules to communicate during demanding cognition.
- **DMN segregated at rest:** DMN nodes show elevated within-module W_T in segregated states and reduced W_T during integrated task states — DMN participates in segregated rest but withdraws its within-module dominance during integration.

---

## Methodology

- **MTD (Multiplication of Temporal Derivatives):** time-resolved connectivity metric — point-wise product of pairwise temporal derivatives averaged over a sliding window (w=14 TRs ≈ 10s); greater temporal resolution than sliding-window Pearson correlation.
- **Cartographic profile:** 2D joint histogram of W_T (within-module degree Z-score) and B_T (participation coefficient) across 375 parcels per temporal window; avoids pre-labeling nodes into fixed cartographic classes.
- **EZ-diffusion model:** decomposes N-back behavioral data into drift rate *v*, non-decision time *t*, and boundary *a* — allows mapping network topology to latent cognitive process, not just RT/accuracy.

---

## Limitations

- fMRI BOLD temporal resolution limits causal inference; pupillometry-B_T correlation is indirect evidence for LC involvement — direct optogenetic or pharmacological manipulation required.
- k=2 clustering imposes binary partition on a continuous state space; higher-k solutions are mutually informative (high MI with k=2) but intermediate states are not characterized.
- Cannot determine whether integration *causes* better performance or is a byproduct of increased communication between specialist regions already engaged by task demands.

---

## Links to Concept and Entity Pages

- [[wiki/concepts/network-integration-segregation.md]] — full formalism and design implications for the integration/segregation toggle
- [[wiki/concepts/neuromodulation.md]] — LC-NA as gain control mechanism for the network topology switch
- [[wiki/concepts/small-world-networks.md]] — hub nodes (rich club) as the architectural substrate for integration
- [[wiki/entities/default-mode-network.md]] — DMN elevated in segregated states; integration suppresses DMN within-module dominance
- [[wiki/concepts/cognitive-control.md]] — integration as a whole-brain CC mechanism beyond goal maintenance
- [[wiki/concepts/criticality.md]] — integration/segregation as two poles of the metastable dynamic repertoire
