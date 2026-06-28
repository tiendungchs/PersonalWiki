---
title: "Human brain dynamics are shaped by rare long-range connections over and above cortical geometry — Vohryzek et al. 2024"
type: paper
tags: [connectome, harmonic-modes, long-range-connections, structure-function, low-dimensional-manifold, fMRI, EDR]
created: 2026-06-26
updated: 2026-06-26
sources: []
related:
  - wiki/concepts/small-world-networks.md
  - wiki/concepts/neural-field-theory.md
  - wiki/concepts/neural-manifolds.md
  - wiki/concepts/criticality.md
---

# Human brain dynamics are shaped by rare long-range connections over and above cortical geometry

**Citation:** Vohryzek, Sanz-Perl, Kringelbach, Deco. *PNAS* 2024. doi:10.1073/pnas.2415102122

---

## Key Computational Insights

- **Exponential Distance Rule (EDR):** Local brain wiring follows $C_{ij}^{\text{EDR}} = Ae^{-\lambda r(ij)}$ with $\lambda = 0.162\ \text{mm}^{-1}$; cortical geometry (folding) is the physical manifestation of this local connectivity — brain anatomy and cortical shape are two sides of the same coin.
- **Rare LR exceptions disproportionately matter:** Long-range (LR) connections defined as 3 standard deviations above the mean weight at Euclidean distances >40 mm form a tiny fraction of all connections yet are required to reconstruct long-range functional connectivity (FC > 0.5, distance > 40 mm); shuffling their spatial locations eliminates this advantage — the *identity* of specific LR connections matters, not just their existence.
- **Harmonic decomposition:** Brain activity decomposes as $F(x,t) = \sum_k a_k(t)\psi_k(x)$ where $\psi_k$ are eigenvectors of the normalized graph Laplacian of the anatomy graph; four representations compared: geometry (LBO), EDR binary, EDR continuous, EDR+LR.
- **EDR+LR superiority:** EDR+LR modes outperform geometry-only and EDR-only modes for reconstructing both LR functional connectivity and all 47 HCP task-activation maps (Bonferroni-corrected paired $t$-test, $p < 10^{-4}$).
- **Low-dimensional manifold:** Only ~20 modes account for the bulk of reconstruction — both spontaneous and task-evoked activity lie in the same low-dimensional manifold; EDR+LR achieves this with fewer modes ("less is more").
- **Topology shapes near-critical dynamics:** The paper links LR structural exceptions explicitly to "optimal brain information processing" (citing turbulence analysis), connecting them to the near-critical operating regime.

## Limitations

- Analysis restricted to the left hemisphere only (Glasser360, 180 ROIs); right-hemisphere and whole-brain replication required.
- Human dMRI tractography cannot resolve individual long-range fibers with the same fidelity as retrograde tract tracing in non-human primates — LR connection identities may be imprecise.
- Static FC and task activation maps; temporally resolved reconstruction of EDR+LR modes not directly shown.

## Related Pages

- **[[wiki/concepts/small-world-networks.md]]** — EDR quantifies the local connectivity that underlies small-world clustering; rare LR connections are the "shortcuts" that explain why small-world topology enables efficient computation.
- **[[wiki/concepts/neural-field-theory.md]]** — harmonic decomposition is the discrete graph version of the Laplace-Beltrami eigenmodes used in neural field theory; EDR+LR Laplacian extends the purely geometric approach.
- **[[wiki/concepts/neural-manifolds.md]]** — the ~20-mode result shows brain dynamics occupy a 7th type of low-dimensional structural-functional manifold shaped by the anatomy graph.
- **[[wiki/concepts/criticality.md]]** — LR connections support long-range spatial correlations that are the structural prerequisite for near-critical dynamics.
