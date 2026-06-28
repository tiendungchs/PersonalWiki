---
title: "Mapping the Structural Core of Human Cerebral Cortex — Hagmann et al. 2008"
type: paper
tags: [structural-connectivity, connectome, dsi, hub-nodes, small-world, default-mode-network, cortical-modules]
created: 2026-06-25
updated: 2026-06-25
sources: [mapping-structural-core-hagmann-2008]
related: [wiki/entities/default-mode-network.md, wiki/concepts/small-world-networks.md, wiki/entities/fcann.md]
---

# Mapping the Structural Core of Human Cerebral Cortex

Hagmann P, Cammoun L, Gigandet X, Meuli R, Honey CJ, Wedeen VJ, Sporns O (2008). *PLoS Biology* 6(7): e159. https://doi.org/10.1371/journal.pbio.0060159

---

## Key Computational Insights

- **Structural core identified:** k-core and s-core decomposition on DSI (Diffusion Spectrum Imaging)-derived connection matrices (998 ROIs, 5 participants) converge on 8 bilateral anatomical subregions as the structural core: posterior cingulate cortex (PCC), precuneus, cuneus, paracentral lobule, isthmus of cingulate, banks of the superior temporal sulcus (BSTS), and inferior/superior parietal cortex. These share high degree, strength, and betweenness centrality.
- **Connector hubs on medial axis only:** spectral modularity detection yields 6 modules (4 hemisphere-local frontal/temporal + 2 bilateral medial centered on PCC and precuneus). Connector hubs (participation index p ≥ 0.3, linking multiple modules) are exclusively located on the anterior-posterior medial axis; ~70% of inter-module edge mass routes through the core.
- **Structure predicts function (r² = 0.62):** resting-state fMRI functional connectivity measured in the same participants is strongly predicted by DSI-derived structural connectivity across all anatomical subregions (r² = 0.62, p < 10⁻¹⁰); r² = 0.53 for core regions alone (PCC, precuneus). Stronger structural connections → stronger functional correlations.
- **Degree distribution is exponential, not scale-free:** cumulative degree and strength distributions follow exponential decay (~10-fold range), with positive assortativity — hub nodes preferentially connect to other hubs; plus confirmed small-world attributes (high clustering, short path lengths).
- **DMN structural-functional dissociation:** the structural core overlaps with *posterior* DMN nodes (PCC, precuneus, cuneus, parietal) but explicitly **excludes mPFC**, which is a functional DMN hub. This suggests mPFC's DMN membership is maintained through functional coupling, not white-matter architecture.
- **DSI vs. DTI:** DSI resolves multiple fiber orientations per voxel (fiber crossings), yielding more accurate tractography than DTI; validated against macaque anatomical tract tracing (78.9% of DSI fibers co-located with known pathways).

---

## Limitations

- Study uses only 5 healthy right-handed male participants (ages 24–32); individual variability and generalizability across sex, age, and clinical populations is untested.
- Tractography is probabilistic and may underrepresent short-range intracortical fibers and interhemispheric connections to lateral cortex (centrum semiovale complexity).
- Subcortical nodes (thalamus, basal ganglia) are excluded from network analysis — a known gap the authors flag for future work.

---

## Connections

- **[[wiki/entities/default-mode-network.md]]** — the structural core provides the anatomical backbone for posterior DMN nodes (PCC, precuneus, cuneus, parietal); mPFC's exclusion from the structural core reveals a structural-functional dissociation: posterior DMN is structurally grounded, mPFC DMN membership is functionally sustained
- **[[wiki/concepts/small-world-networks.md]]** — first in-vivo human connectome confirming small-world attributes, exponential degree distribution, and positive assortativity; directly instantiates the structural core as the empirically identified integration hub cluster
- **[[wiki/entities/fcann.md]]** — r² = 0.62 structure-function correspondence provides the mechanistic justification for J = −Σ⁻¹ as a proxy for structural topology; the structural core (PCC, precuneus, parietal) maps to fcANN's principal DMN/anti-DMN attractor axis
