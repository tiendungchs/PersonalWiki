---
title: "Dynamics of Adaptive Continuous Attractor Neural Networks — Li, Chu & Wu 2024"
type: paper
tags: [cann, ring-attractor, spike-frequency-adaptation, traveling-wave, phase-precession, levy-flights]
created: 2026-06-22
updated: 2026-06-22
sources: [acann-li-2024]
related: [wiki/concepts/ring-attractor.md, wiki/concepts/spike-frequency-adaptation.md, wiki/concepts/phase-precession.md, wiki/concepts/replay.md, wiki/papers/seelig-jayaraman-2015.md, wiki/papers/sfa-ganguly-2024.md]
---

# Dynamics of Adaptive Continuous Attractor Neural Networks — Li, Chu & Wu 2024

Li Y., Chu T., Wu S. — Peking University. arXiv:2410.06517 (2024).

- **Projection method for tractability:** reduces A-CANN dynamics to 4 coupled ODEs (bump height A_u, adaptation amplitude A_v, bump position z, adaptation lag s_v), enabling full analytical derivation of all dynamical modes from a single unified framework.
- **Static/traveling-wave bifurcation at m = τ/τ_v:** SFA adaptation strength m above the threshold destabilizes the static bump into spontaneous propagation at analytic speed v_int = (2a/τ_v)√(mτ_v/τ − √(mτ_v/τ)); below threshold, the bump holds position as working memory.
- **Anticipative tracking with speed-independent lead time:** when v_int > v_ext, the bump leads the external input by constant t_ant ≈ A_u τ_v/α × (m − τ/τ_v), independent of input speed — directly matches the 20–25 ms head-direction anticipation observed in rat anterior thalamus.
- **Oscillatory tracking via Hopf bifurcation:** at intermediate adaptation, a limit-cycle emerges at frequency ω ∝ √(αk(1+m)/ττ_v), tunable to theta band (~8 Hz); the bump sweeps forward and backward around the external input, providing a direct attractor-dynamics account of hippocampal place-cell phase precession and procession.
- **Lévy flights from noisy adaptation near the traveling-wave boundary:** multiplicative noise on adaptation strength drives power-law displacements p(||Δz||) ∝ ||Δz||^{−1−α}, with α = 1 + 2μ/γ² (μ = distance-to-boundary, γ = noise-to-strength ratio); matches sequential place-cell reactivation statistics at rest (Pfeiffer & Foster 2015).

**Limitations:** 1D feature-space analysis only; Gaussian bump approximation breaks down far from steady states; extension to 2D torus (grid cells) not addressed; noise model uses multiplicative adaptation noise, not realistic vesicular/channel-based noise sources.

[[wiki/concepts/ring-attractor.md]] · [[wiki/concepts/spike-frequency-adaptation.md]] · [[wiki/concepts/phase-precession.md]] · [[wiki/concepts/replay.md]]
