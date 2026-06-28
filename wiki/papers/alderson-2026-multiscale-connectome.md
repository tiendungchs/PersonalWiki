---
title: "Shared spatial and temporal principles govern connectome dynamics across timescales — Alderson et al. 2026"
type: paper
tags: [connectome, timescales, ICN, co-activation, parallel-streams, EEG-fMRI, temporal-multiplexing, resting-state]
created: 2026-06-27
updated: 2026-06-27
sources: [alderson-2026-multiscale-connectome]
related:
  - wiki/concepts/temporal-multiplexing.md
  - wiki/concepts/cortical-traveling-waves.md
  - wiki/concepts/criticality.md
  - wiki/entities/default-mode-network.md
  - wiki/concepts/working-memory.md
  - wiki/concepts/canonical-microcircuit.md
---

# Alderson et al. 2026 — Shared Spatiotemporal Principles Across Connectome Timescales

**Citation:** Alderson TH, Jun S, Wirsich J, et al. Proc Natl Acad Sci USA. 2026;123(25):e2535464123.

Concurrent EEG-fMRI (N=26; validated in N=24 EEG-fMRI + N=443 EEG-only) tracking ICN co-activation blueprints across six neural timescales: infraslow fMRI, δ, θ, α, β, γ EEG.

---

## Key Computational Insights

- **Combinatorial ICN state space**: 7 canonical ICNs (VIS, SMN, DAN, VAN, LIM, FPN, DMN) define 126 co-activation blueprints (all non-empty subsets of up to 6 ICNs). Each time frame is assigned its best-fitting blueprint by spatial Pearson correlation. Single-ICN states account for only ~12% of total time; the full combinatorial space is nearly uniformly used.
- **Timescale-overarching spatial principle**: The same 126 blueprint set fits empirical co-activation patterns at all six timescales, significantly above two null models (spatial shuffle and phase permutation), replicated across three datasets.
- **Timescale-overarching temporal principle**: Transition probability matrices between blueprints are highly correlated across timescales (r = 0.90–0.96 within EEG bands; r = 0.62–0.67 between fMRI and EEG), all significantly exceeding shuffled-sequence nulls. ~70% of transitions change by only one ICN (spatial continuity); ~10% are large jumps enabling efficient state-space coverage.
- **Parallel asynchronous streams**: State lifetimes span three orders of magnitude (~20 ms at γ → ~3000 ms in fMRI). Temporal overlap of identical blueprint states across timescale pairs is at chance — parallel streams are asynchronous, not synchronized slowed copies of a single stream.
- **DMN × task-positive co-activation**: Two of the most frequently expressed blueprints are DMN+FPN+VAN+DAN (#118) and DMN+all-task-positive (#126), directly contradicting strict DMN–task-positive anti-correlation claims.
- **Laminar substrate**: Gamma-band (fast) streams localize to superficial feedforward cortical layers; beta and below (slow) to deep feedback layers — multi-stream architecture has a structural laminar basis.

---

## Limitations

- Small primary EEG-fMRI sample (N=26); spatial resolution of source-space EEG limits parcellation.
- Blueprint framework explains only a fraction of total variance (ICN co-activation is one component of a richer signal); residual variance reflects circuit-, layer-, and modality-specific processes.
- Resting-state only; whether identical timescale-overarching principles hold under task conditions remains untested.

---

## Links to Wiki

- [[wiki/concepts/temporal-multiplexing.md]] — primary concept introduced by this paper
- [[wiki/concepts/cortical-traveling-waves.md]] — frequency-specific (alpha/beta) subnetworks are the structural basis for parallel streams
- [[wiki/entities/default-mode-network.md]] — DMN×DAN/FPN co-activation finding updates the anti-correlation narrative
- [[wiki/concepts/criticality.md]] — parallel multi-stream dynamics require near-critical metastable operating regime
- [[wiki/concepts/canonical-microcircuit.md]] — laminar substrate for fast (superficial) vs. slow (deep) streams
