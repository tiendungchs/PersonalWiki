---
title: "Connectivity Gradients"
type: concept
tags: [connectivity-gradients, functional-connectome, brain-organization, unimodal, transmodal, FC, dimensionality-reduction]
created: 2026-06-27
updated: 2026-06-27
sources: [bijsterbosch-2021-connectome-representations, dmn-cytoarchitecture-paquola-2025]
related: [wiki/concepts/hierarchical-representations.md, wiki/entities/default-mode-network.md, wiki/concepts/factorized-representations.md, wiki/concepts/latent-states.md, wiki/concepts/small-world-networks.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/cortical-traveling-waves.md, wiki/papers/dmn-cytoarchitecture-paquola-2025.md]
---

# Connectivity Gradients

**Smooth continuous axes of intrinsic functional organization derived from eigendecomposition of a pairwise FC (Functional Connectivity) similarity matrix; two regions with similar gradient scores share similar whole-brain connectivity profiles (integrated); two regions with maximally different scores are maximally dissimilar in their connectivity (segregated).**

---

## Formalism

1. Build affinity matrix **A** where $A_{ij}$ = normalized dot product of the FC profiles of regions $i$ and $j$.
2. Compute the diffusion embedding (or Laplacian eigenvectors) of **A**.
3. The $k$-th eigenvector = $k$-th gradient axis $\mathbf{g}_k$; gradient scores are coordinates in a continuous low-dimensional space.
4. Units with similar $\mathbf{g}_k$ values are functionally integrated; units at opposite ends are segregated.

Gradients complement parcellations: parcellations impose hard boundaries, gradients capture smooth variation *within and across* parcels simultaneously.

---

## Major Gradients

| Gradient | Axis | Key evidence |
|---|---|---|
| **G1 (principal)** | Unimodal sensory/motor → Transmodal association cortex (DMN apex) | Margulies et al. 2016; replicated in genetic/transcriptomic/evolutionary patterns; aligns with primate cortical expansion |
| **G3 (tertiary)** | Default Mode Network ↔ Multi-Demand Network (MDN) | Assem et al. 2021; predicts working memory performance and goal-directed cognition balance |
| **Hippocampal local** | Anterior (coarse, context) ↔ Posterior (fine-grained, spatial detail) | Vos de Wael et al. 2018; lateral-medial patterning tracks T1w/T2w cortical microstructure |
| **Striatal** | Reflects graded cortical input topology | Marquand et al. 2017; smooth axes capture behavioral variability |
| **Intra-DMN E1** (Paquola 2025) | Peaked (low-E1: inferior parietal, precuneus) → flat (high-E1: anterior cingulate, medial PFC); within-DMN cytoarchitectural axis; receiver periphery vs. insulated core | Not a sub-range of G1 — E1 is a mosaic, not a simple gradient; reveals internal heterogeneity orthogonal to the global hierarchy |

---

## Evidence / Instantiations

| System | Finding | ML relevance |
|---|---|---|
| Global cortex (Margulies 2016) | G1 runs sensorimotor → DMN; aligns with cortical evolution and transcriptomics | The principal gradient IS the cortical hierarchy in continuous form |
| DMN vs. MDN (Assem 2021) | G3 juxtaposes internally-directed (DMN) vs. externally-directed (MDN) networks; balance predicts WM performance | Suggests models need an analogous internal/external mode axis |
| ASD (Hong 2019) | G1 altered in ASD — atypical cortical development compresses the unimodal→transmodal spread | Gradient disruption as diagnostic; could signal architectural imbalance in models |
| Individual variability | Largest inter-individual variability in gradients at the transmodal (association cortex) end | Abstract/heteromodal representations are inherently more person-specific |
| Soft parcellations (PROFUMO) | Spatial overlap of probabilistic modes predicts behavior *better* than temporal correlation; overlap matrix is an additional representational layer atop gradients | Soft boundaries outperform hard parcels; model representations should allow overlap |
| Intra-network E1 vs. G1 (Paquola 2025) | Within the DMN, the cytoarchitectural gradient E1 is a mosaic (not a simple gradient); neighboring areas can be microarchitecturally distinct and distant areas can be similar — the DMN's internal organization is not simply a sub-range of G1 | A reasoning module that sits at the apex of G1 may have its own internal gradient axis orthogonal to the global hierarchy |

---

## Open Problems

1. **Individual gradient alignment** — aligning subject-specific gradient solutions is non-trivial; the ordering and orientation of eigenvectors can flip between individuals.
2. **Local vs. global integration** — how do global (G1) and local (hippocampal, striatal) gradients interact; no unified multi-scale framework exists.
3. **Causal interpretation** — gradients are correlational; the mechanistic relationship between SC topology and the gradient axes is an open question (see Honey et al. 2009 for SC → FC link).
4. **Architectural implication** — what specific inductive bias does the unimodal→transmodal gradient impose? Is it a learned embedding dimension or a fixed scaffold?

---

## Connections

- **[[wiki/concepts/hierarchical-representations.md]]** — G1 (unimodal→transmodal) is the biological implementation of the cortical hierarchy; hierarchical layers approximate in discrete stages what gradients capture continuously; the gradient perspective adds empirical grounding for why a perception-to-abstraction hierarchy is the right architectural prior.
- **[[wiki/entities/default-mode-network.md]]** — DMN occupies the transmodal extreme of G1 and one pole of G3; gradient position quantifies DMN's role as the apex of cortical abstraction and situates the DMN-MDN axis as the brain's internal/external mode dimension.
- **[[wiki/concepts/factorized-representations.md]]** — PROFUMO's overlapping probabilistic modes are a soft-parcellation complement to gradients; both reject hard boundaries, and the finding that spatial overlap beats temporal correlation supports factorized over monolithic representations.
- **[[wiki/concepts/latent-states.md]]** — gradient coordinates define a continuous manifold of functional states; brain regions with similar latent states cluster nearby in gradient space; gradients are a geometric organization of the latent functional state space.
- **[[wiki/concepts/small-world-networks.md]]** — hub nodes with shortest path lengths cluster at the transmodal end of G1; structural network topology and gradient position co-vary, linking hub architecture to the abstraction hierarchy.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the gradient space is the biological analog of the latent graph a model must infer; recovering the gradient from connectivity data is an instance of discovering hidden low-dimensional structure from pairwise observations.
- **[[wiki/concepts/cortical-traveling-waves.md]]** — SC instrength gradients (weighted in-degree) drive wave direction and suppress effective frequency; these are distinct from FC-derived connectivity gradients but both reflect the same underlying cortical hierarchy through different measurement axes.
- **[[wiki/papers/dmn-cytoarchitecture-paquola-2025.md]]** — introduces the intra-DMN E1 cytoarchitectural axis (distinct from G1); demonstrates that the apex network of G1 has its own internal gradient orthogonal to the global hierarchy, suggesting multi-scale gradient structure in association cortex.
