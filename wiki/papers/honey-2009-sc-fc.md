---
title: "Predicting human resting-state functional connectivity from structural connectivity"
type: paper
tags: [structural-connectivity, functional-connectivity, resting-state, connectome, neural-mass-model, DMN, indirect-connections, structure-function]
created: 2026-06-27
updated: 2026-06-27
sources: []
related: [wiki/entities/default-mode-network.md, wiki/entities/fcann.md, wiki/concepts/criticality.md, wiki/concepts/small-world-networks.md, wiki/concepts/neural-field-theory.md, wiki/concepts/excitation-inhibition-balance.md, wiki/papers/mapping-structural-core-hagmann-2008.md, wiki/papers/deco-dynamic-brain-2008.md, wiki/papers/deco-resting-state-2011.md]
---

# Predicting human resting-state functional connectivity from structural connectivity

**Honey, Sporns, Cammoun, Gigandet, Thiran, Meuli & Hagmann — PNAS 2009**

Same 5-participant DSI+fMRI dataset as Hagmann et al. 2008; extends it from structural-core anatomy to SC→FC prediction at both 66-region and 998-ROI resolutions.

---

## Key Computational Insights

- **SC-rsFC correlation quantified at high resolution:** r = 0.66 (66 regions); r = 0.36–0.48 per participant (998 ROIs); increases to r = 0.82 / 0.53 when excluding absent SC connections — confirming SC is the dominant shaper of FC topology but leaves substantial unexplained variance.
- **FC does not imply SC (critical limitation):** Strong rsFC exists between structurally unconnected pairs across a wide range; thresholding FC to infer SC yields AUC = 0.79 (empirical) and 0.95 (model) — impractical in both cases because unconnected pairs outnumber connected pairs ~30:1 at 998-ROI resolution.
- **Indirect 2-hop SC induces rsFC (r = 0.29)** between unconnected pairs, independent of Euclidean distance — multi-hop anatomical paths mediate functional coupling without direct white-matter links; particularly strong for interhemispheric visual cortex.
- **SC + inverse-distance bivariate model** explains 69% of rsFC variance (66 regions) and 30% (998 ROIs); distance contributes both neuronal (activation spread, SC auto-correlation) and non-neuronal (vascular, acquisition) factors.
- **rsFC is temporally variable** (reliability r = 0.38–0.69 across sessions, 0.39–0.61 within-session; model reliability r = 0.69–0.80) — variability arises from long-range temporal autocorrelations in BOLD, not only measurement noise; FC is a distribution over configurations, not a static matrix.
- **SC stabilizes rsFC:** ROI pairs with direct SC show significantly lower rsFC variance within and across sessions — structural backbone anchors the functional attractor.
- **DMN structural asymmetry:** Strong direct SC links PCC ↔ precuneus ↔ mPFC along the medial cortical wall (interhemispherically and bilaterally); lateral parietal cortex has weak direct SC to medial nodes, coupling via indirect parieto-frontal pathways. Neural mass model reproduces medial DMN rsFC well; fails on lateral parietal component.
- **998-node nonlinear neural mass model** (Deco et al. 2008 formalism; SC-weighted coupling; simulated BOLD) matches empirical SC-rsFC structure without subcortical input or specialized local circuitry — systems-level FC is primarily determined by cortico-cortical topology.

---

## Limitations

- n = 5 participants; no individual-difference or developmental analysis possible.
- SC measured as fiber count (exponentially distributed, Gaussian-resampled for normalization) — approximates but does not capture interregional synaptic efficacies or directionality.
- Model excludes thalamus, basal ganglia, and local inhibitory circuitry; aggregate node dynamics only.
- High-resolution (998-ROI) SC-rsFC correlation is substantially lower than low-resolution (66-region), partly due to interparticipant morphological variability preventing clean averaging.

---

## Connections

- **[[wiki/entities/default-mode-network.md]]** — quantifies the DMN's internal SC backbone: strong direct SC along the medial axis (PCC↔precuneus↔mPFC); lateral parietal cortex relies on indirect paths; model reproduces medial DMN rsFC but not lateral parietal — explaining the structural-functional dissociation documented in fcANN's attractor geometry.
- **[[wiki/entities/fcann.md]]** — provides the empirical SC→FC relationship (r = 0.66 at 66 regions; r²≈0.18–0.23 at 998 ROIs) that grounds fcANN's J = −Σ⁻¹ design; the indirect-connection finding shows why FC (and hence J) carries information about multi-hop structural topology, not just direct connections.
- **[[wiki/concepts/small-world-networks.md]]** — confirms SC-rsFC correspondence at 998-ROI resolution: the structural core topology (PCC, precuneus, medial axis) directly shapes functional topology; indirect 2-hop paths implement the functional analog of the small-world shortcut mechanism.
- **[[wiki/concepts/criticality.md]]** — the neural mass model reproduces rsFC structure from SC + criticality-tuned coupling (Deco 2008 formalism); the 998-node model instantiates the Deco 2011 principle that near-critical SC-weighted coupling generates realistic FC.
- **[[wiki/concepts/neural-field-theory.md]]** — the 998-node nonlinear neural mass model is an early BNM implementation using the same Deco 2008 formalism underlying NFT applications; SC-weighted coupling reproduces rsFC without spatial field PDE — validates the neural mass ODE level of description.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — FC variability (reliability r = 0.38–0.69) implies the empirical FC matrix used by fcANN (J = −Σ⁻¹) samples from a distribution rather than a fixed E/I landscape; session-to-session FC instability is the empirical basis for treating the attractor landscape as probabilistic.
- **[[wiki/papers/mapping-structural-core-hagmann-2008.md]]** — companion paper (same 5-participant DSI dataset): Hagmann 2008 identifies the structural core topology; this paper quantifies the SC→FC relationship it generates and demonstrates that indirect connections extend functional coupling beyond direct structural links.
- **[[wiki/papers/deco-dynamic-brain-2008.md]]** — the neural mass model used here is directly derived from the Deco 2008 formalism; this paper provides its first application to empirical human whole-brain SC prediction of rsFC.
- **[[wiki/papers/deco-resting-state-2011.md]]** — Deco 2011 extended this SC→FC modeling to show criticality is a necessary condition; Honey 2009 is the empirical foundation that Deco 2011's three-model synthesis is designed to explain.
