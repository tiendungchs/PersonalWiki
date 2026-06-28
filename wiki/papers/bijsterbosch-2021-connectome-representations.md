---
title: "Recent developments in representations of the connectome"
type: paper
tags: [connectome, fMRI, resting-state, functional-connectivity, parcellation, connectivity-gradients, individualized-connectome]
created: 2026-06-27
updated: 2026-06-27
sources: [bijsterbosch-2021-connectome-representations]
related: [wiki/concepts/connectivity-gradients.md, wiki/entities/default-mode-network.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/factorized-representations.md, wiki/concepts/small-world-networks.md]
---

# Recent developments in representations of the connectome

Bijsterbosch JD, Valk SL, Wang D, Glasser MF. *NeuroImage*. 2021 Nov 15;243:118533. PMCID: PMC8842504.

---

## Key Computational Insights

- **Principal gradient (G1):** The primary axis of intrinsic functional organization runs from unimodal sensory/motor cortex → transmodal association cortex (DMN); aligns with evolutionary cortical expansion and genetic/transcriptomic gradients — this is the continuous biological correlate of the cortical hierarchy.
- **Tertiary gradient (G3) — DMN vs. MDN:** A separate organizational axis juxtaposes the Default Mode Network with the Multi-Demand Network (MDN); possibly reflects the balance underlying working memory performance and goal-directed cognition.
- **Soft parcellations beat hard ones:** PROFUMO (Probabilistic Functional Modes) allows overlapping modes; individual differences in *spatial overlap* of modes predict behavior more strongly than temporal correlation, arguing for soft/factorized over hard-boundary representations.
- **Hard parcellations conflate spatial and connectivity variability:** Between-subject differences in parcellated connectomes are confounded by spatial variability in network topography — up to 62% of cross-subject FC variance is spatial in origin, not connectivity in origin (cf. Tripathi 2025 precision fMRI finding).
- **Dynamic representations:** Hidden Markov Models and quasi-periodic wave representations add temporal structure; parcellated and non-parcellated approaches are complementary, not mutually exclusive.

## Limitations

- Review article: all insights are synthesized from 2013–2021 literature; no new empirical data.
- fMRI macroscale only — cannot resolve single-neuron mechanisms underlying observed FC gradients.
- Gradient alignment across individuals and studies remains an unsolved methodological problem.

## Related Pages

- [[wiki/concepts/connectivity-gradients.md]] — primary concept page for G1/G3 and the gradient formalism
- [[wiki/entities/default-mode-network.md]] — DMN at the transmodal extreme of G1; G3 counterpart to MDN
- [[wiki/concepts/hierarchical-representations.md]] — gradients as continuous biological correlate of discrete hierarchical layers
- [[wiki/concepts/factorized-representations.md]] — PROFUMO soft parcellations as factorized alternative to hard parcels
- [[wiki/concepts/small-world-networks.md]] — hub nodes cluster at transmodal end of G1
