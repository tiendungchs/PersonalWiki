---
title: "Learning produces an orthogonalized state machine in the hippocampus"
type: paper
tags: [hippocampus, latent-states, orthogonalization, state-machine, cscg, learning-dynamics, place-cells]
created: 2026-06-23
updated: 2026-06-23
sources: [sun-hippocampal-osm-2025]
related: [wiki/entities/cscg-model.md, wiki/concepts/latent-states.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/neural-manifolds.md, wiki/concepts/hebbian-learning.md, wiki/concepts/pattern-separation.md]
---

# Learning produces an orthogonalized state machine in the hippocampus

**Citation:** Sun, Winnubst et al. *Nature* 612 (2025-02-12). DOI: 10.1038/s41586-024-08548-w.

Longitudinal two-photon calcium imaging of thousands of CA1 neurons (3,034–5,354 cells tracked per mouse, n=11) across weeks of training on a two-alternative cue-delay-choice task (2ACDC). Two linear virtual tracks share visual cues everywhere except a brief indicator region; correct reward location depends on remembering which indicator was seen.

---

## Key Computational Insights

- **Progressive decorrelation produces an OSM.** CA1 population vectors for visually identical track segments decorrelate systematically across days of training. The decorrelation order is stereotyped: off-diagonal (across-track) regions first, then pre-R2, then pre-R1. The final representation is an orthogonalized state machine (OSM) — a finite state machine whose nodes are latent task states, not sensory features. Identical visual inputs receive distinct neural representations because they occupy different positions in the hidden task structure.
- **CSCG uniquely matches both final state and learning trajectory.** Among all models tested — sigmoid/ReLU RNN, LSTM, transformer, softmax-RNN, Hebbian-RNN with sWTA — only CSCG (a hidden Markov model variant trained by Baum-Welch EM) replicates the specific pre-R2 → pre-R1 decorrelation order. Standard sequence models (LSTM, transformer) achieve high prediction accuracy without orthogonalizing at all. Other models that achieve final orthogonalization (sWTA-RNN, Hebbian-RNN) produce the wrong trajectory order.
- **sWTA activations are necessary for RNN orthogonalization.** RNNs with sigmoid or ReLU activations trained to predict the next sensory input do not orthogonalize; softmax-activated RNNs do. A Hebbian-RNN with explicit soft winner-take-all also achieves the final OSM. The orthogonalization property requires sparse competitive activation or explicit decorrelation in the cost function; it is not a byproduct of sequence prediction.
- **OSM reuse accelerates new-task learning.** After learning the original task (483 ± 70 trials), mice learn new cue pairs in 147 ± 39 trials. Population vectors between old and new tasks match at all track locations except the indicator region — the state machine scaffold is preserved and new sensory-to-state mappings are learned rapidly. Direct in vivo evidence for two-timescale learning within CA1.
- **State cells form a continuum; no discrete categories.** Individual CA1 neurons dynamically transition between place-like and splitter-like response profiles during learning. A 2D feature space (difference score × correlation coefficient) is continuously populated; the place vs. splitter distinction is a gradient, not a boundary.

## Limitations

- Imaging restricted to dorsal CA1; CA3, DG, and MEC learning dynamics uncharacterized — whether orthogonalization originates in CA3 or is inherited by CA1 is unknown.
- CSCG matches the average decorrelation trajectory; individual mice show variability.
- How Baum-Welch EM (Expectation Maximization) is implemented biologically remains unknown; sWTA + Hebbian approximations achieve final orthogonalization but not the correct trajectory order.

## Links

[[wiki/entities/cscg-model.md]] · [[wiki/concepts/latent-states.md]] · [[wiki/entities/place-cells.md]] · [[wiki/entities/hippocampal-entorhinal-system.md]] · [[wiki/concepts/neural-manifolds.md]] · [[wiki/concepts/hebbian-learning.md]] · [[wiki/concepts/pattern-separation.md]]
