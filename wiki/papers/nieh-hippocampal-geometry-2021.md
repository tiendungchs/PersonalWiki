---
title: "Geometry of Abstract Learned Knowledge in the Hippocampus"
type: paper
tags: [hippocampus, neural-manifolds, latent-states, representational-geometry, place-cells, evidence-accumulation]
created: 2026-06-23
updated: 2026-06-23
sources: []
related: [wiki/concepts/latent-states.md, wiki/concepts/neural-manifolds.md, wiki/concepts/representational-geometry.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/place-cells.md]
---

# Geometry of Abstract Learned Knowledge in the Hippocampus

Nieh et al. 2021. *Nature* 595, 80–84. DOI: 10.1038/s41586-021-03652-7

---

- **Joint encoding of physical + abstract variables:** ~29% of dorsal CA1 neurons (917/3,144 imaged) have 2D firing fields in joint evidence-by-position (E×Y) space, with significantly greater mutual information than either variable alone; ~1.7 fields/cell. Task: evidence accumulation T-maze in VR; 2-photon Ca²⁺ imaging; n=7 mice.
- **Low-dimensional nonlinear manifold (~5.4D):** MIND (manifold inference from neural dynamics) — transition-probability-based nonlinear dimensionality reduction — reveals a ~4-6D manifold embedded in the ~450D neural state space. PCA requires 40 principal components to match 5 MIND latent dimensions. Dimensionality scales with task complexity (one-side-cues control: ~4.2D, significantly lower).
- **Orderly gradient structure:** both position and evidence appear as smooth gradients in the embedding — neural state trajectory progresses along a position axis and splits along an orthogonal evidence axis. The visual input manifold shows a luminance gradient but NOT evidence (evidence requires memory integration); the neural manifold shows evidence but less luminance — the manifold encodes learned knowledge, not raw sensation.
- **Cross-animal geometry sharing (~70%):** after SO(5) hyperalignment rotation, ~69–75% of manifold geometry is shared across animals. The geometry is task-specific, not animal-specific: HC constructs a canonical geometric representation of learned knowledge.
- **Sequential doublets predict behavior:** choice-predictive cell pairs (doublets, triplets) correspond to trajectories through the manifold; doublet timing correlates with manifold distance traversed (Wilcoxon p=0.031). Manifold predicts doublet presence with 0.87 TPR / 0.14 FPR.

**Limitations:** single behavioral paradigm; no account of how the manifold forms during learning; abstract variable (accumulated evidence) retains temporal/sensorimotor structure — purely discrete or symbolic abstractions unstudied.

---

**Connections:**

- [[wiki/concepts/latent-states.md]] — evidence cells as the canonical 2D joint-encoding instance; the E×Y manifold is the geometric substrate of the "expanded cognitive map" that latent-states theory predicts
- [[wiki/concepts/neural-manifolds.md]] — quantifies the task-plastic HC manifold (type 2) with MIND; cross-animal geometry sharing constrains how plastic vs. canonical the manifold actually is
- [[wiki/concepts/representational-geometry.md]] — gradient organization in the manifold is a continuous analog of CCGP (Cross-Condition Generalization Performance): the evidence coding axis is orthogonal to and consistent across all position values, satisfying the parallelism criterion
- [[wiki/entities/hippocampal-entorhinal-system.md]] — joint physical+abstract encoding within the same CA1 population challenges strict g/x/p factorization for learned abstract variables; supports HC as a general geometric organizer
- [[wiki/entities/place-cells.md]] — evidence cells are place cells in a higher-dimensional space; 2D E×Y firing fields make the expanded cognitive map a measurable geometric object
