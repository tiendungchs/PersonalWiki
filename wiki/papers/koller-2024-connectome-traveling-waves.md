---
title: "Human connectome topology directs cortical traveling waves and shapes frequency gradients"
type: paper
tags: [traveling-waves, connectome, structural-connectivity, oscillations, functional-connectivity, kuramoto, frequency-gradients, instrength]
created: 2026-06-27
updated: 2026-06-27
sources: [koller-2024-connectome-traveling-waves]
related:
  - wiki/concepts/cortical-traveling-waves.md
  - wiki/concepts/neural-field-theory.md
  - wiki/concepts/criticality.md
  - wiki/concepts/small-world-networks.md
  - wiki/entities/default-mode-network.md
---

# Koller et al. 2024 — Human connectome topology directs cortical traveling waves and shapes frequency gradients

Koller DP, Schirner M, Ritter P. *Nature Communications* 15, 3754 (2024). DOI: 10.1038/s41467-024-47860-x

---

## Key Computational Insights

- **Instrength gradient mechanism**: sum of incoming SC connection strengths (instrength = weighted in-degree) forms a spatial gradient across the human connectome, increasing from temporal/parietal to frontal/occipital cortex; Kuramoto oscillator networks on this SC produce traveling waves directed from low → high instrength regions; conduction delays are a necessary ingredient (zero-delay models fail)
- **Effective frequency suppression**: high instrength nodes phase-lag relative to low instrength nodes; this suppresses their effective oscillation frequency (EF), generating large-scale EF gradients co-emergent with wave direction — waves propagate from fast (low instrength) to slow (high instrength) oscillators
- **Competing gradient mechanisms**: instrength gradients (waves: low→high IS) and intrinsic frequency (IF) gradients (waves: high→low IF) act in opposition; their balance point produces spiral/rotating waves; the brain may dynamically modulate IF gradients via stimuli or thalamocortical loops to switch wave types against a stable structural baseline
- **Frequency-specific SC subnetworks**: NMF decomposes the full SC into additive subnetworks; putative alpha-subnetwork (instrength decreasing anterior→posterior) and beta-subnetwork (instrength increasing anterior→posterior) produce opposing EF gradients matching resting-state MEG and independently generate instrength-directed traveling waves
- **FC coordination**: models producing instrength-directed waves and smooth EF gradients achieve highest correlation with resting-state MEG FC (PLV-FC r > 0.56 across alpha/beta/gamma; PLI-FC r = 0.46 in alpha band), suggesting traveling waves are a substrate for large-scale synchronization

## Limitations

- Kuramoto model is highly simplified (uniform IF, no E/I distinction, no laminar structure); Jansen-Rit replication is partial (41.7% instrength-directed vs. 94% for Kuramoto)
- Instrength patterns are sensitive to tractography algorithm and parcellation choices (~1760 pipeline variants produce different topographies; Gajwani et al.)
- No direct experimental evidence that instrength gradients exist at the cellular/laminar scale or direct waves in task conditions (white matter changes slowly, so task modulation would require IF gradient override)

## Related Pages

- **[[wiki/concepts/cortical-traveling-waves.md]]** — full treatment of instrength gradient mechanism, competing mechanisms, and ML design implications
- **[[wiki/concepts/neural-field-theory.md]]** — mathematical framework for wave emergence; Kuramoto model context; delayed coupling as wave substrate
- **[[wiki/concepts/criticality.md]]** — traveling waves emerge in the metastable near-critical regime; instrength-directed waves coordinate FC
- **[[wiki/concepts/small-world-networks.md]]** — exponential distance rule + instrength gradients as structural properties of the connectome
- **[[wiki/entities/default-mode-network.md]]** — DMN hub regions may overlap with high-instrength areas; instrength-directed waves may preferentially reach DMN hubs
