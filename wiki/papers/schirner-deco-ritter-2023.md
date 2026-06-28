---
title: "Learning how network structure shapes decision-making for bio-inspired computing — Schirner, Deco & Ritter 2023"
type: paper
tags: [brain-network-model, functional-connectivity, excitation-inhibition-balance, decision-making, working-memory, intelligence, synchrony, winner-take-all]
created: 2026-06-25
updated: 2026-06-25
sources: [schirner-deco-ritter-2023]
related: [wiki/concepts/excitation-inhibition-balance.md, wiki/concepts/working-memory.md, wiki/concepts/ring-attractor.md, wiki/entities/fcann.md, wiki/concepts/neuromodulation.md]
---

# Learning how network structure shapes decision-making for bio-inspired computing

Schirner M, Deco G, Ritter P (2023). *Nature Communications*. https://doi.org/10.1038/s41467-023-38626-y

---

## Key Computational Insights

- **Counter-intuitive finding:** Participants with higher fluid intelligence (PMAT) took *more* time on hard questions (≥ question 9/24), not less; simple processing speed tests showed the expected negative correlation with RT. The result rules out the "faster brain = smarter" account.
- **FC predicts decision speed:** Higher mean resting-state FC correlates with longer RT regardless of question difficulty (r = 0.13 single-subject; strong group-level effect), linking resting FC directly to a cognitive mode rather than to intelligence per se.
- **E/I balance controls FC monotonically:** Personalized BNMs (379-region, neural mass model with NMDA/GABA dynamics + FIC) show that the ratio of long-range excitation (LRE) to feedforward inhibition (FFI) — w^LRE / w^FFI — monotonically tunes pairwise FC from full anti-synchrony to full synchrony. FIC (Feedback Inhibition Control, local inhibitory plasticity to fix 4 Hz average firing) is the necessary condition for this monotonic relationship.
- **Synchrony mediates E/I → cognition:** Higher E/I → higher FC → higher synchrony of synaptic currents + lower amplitude → slower but more accurate WTA decisions. Lower E/I → lower FC → noisy, low-synchrony currents → fast but error-prone jumps to conclusions.
- **WTA decision module (frontoparietal DM circuit):** Two competing excitatory populations (PFC + PPC) with cross-inhibition via shared inhibitory population implement a speed-accuracy tradeoff. Input synchrony (r ~ 0.5 optimal) increases decision accuracy and integration time; input amplitude decreases accuracy when increased. WM robustness also depends on amplitude: lower amplitude → higher induction threshold → more stable (less flexible) WM — matching slower subjects' behavioral profile.
- **Multiscale validation:** Coupling PFC and PPC nodes of individual BNMs to the DM circuit reproduces the empirical PMAT correlation: models of higher-intelligence subjects were slower but more accurate.

---

## Limitations

- BNM is a mean-field neural mass model; cell-type-level E/I heterogeneity and spike-timing structure are not captured.
- WTA decision module uses two populations (PFC vs. PPC) — a major simplification of real frontoparietal decision circuits.
- All analyses are correlational on HCP data (N = 650–1176); the E/I → intelligence causal direction cannot be established observationally.

---

## Connections

- **[[wiki/concepts/excitation-inhibition-balance.md]]** — this paper is the primary source establishing that long-range E/I ratio is a monotonic control knob for FC and, downstream, for synchrony, WM stability, and decision accuracy.
- **[[wiki/concepts/working-memory.md]]** — the DM circuit bifurcation analysis shows that input amplitude (linked to FC via E/I) determines the WM induction and disruption thresholds; higher synchrony = more stable WM content.
- **[[wiki/entities/fcann.md]]** — validates that mean FC (which fcANN uses as its attractor landscape parameter) tracks E/I regime and hence cognitive operating point; the monotonic E/I–FC relationship provides a mechanistic grounding for using J = −Σ⁻¹ as a proxy for reasoning mode.
- **[[wiki/concepts/ring-attractor.md]]** — the WTA frontoparietal DM circuit is an attractor-based decision mechanism (cross-inhibition between two excitatory populations) — a two-state analog of the ring bump; E/I balance controls the bump stability and transition rate, matching the ring attractor's bifurcation structure.
