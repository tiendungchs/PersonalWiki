---
title: "The Tolman-Eichenbaum Machine"
type: paper
tags: [hippocampus, entorhinal-cortex, structural-generalization, grid-cells, place-cells, foundational]
sources: [TEM.pdf]
related: [wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/path-integration.md, wiki/concepts/two-learning-timescales.md, wiki/entities/tem-model.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/queries/tem-implementation-vs-theory.md]
---

# The Tolman-Eichenbaum Machine (Whittington et al., Cell 2020)

Whittington JCR et al. *Cell* 183:1249–1263. https://doi.org/10.1016/j.cell.2020.10.024

**Full model description → [[wiki/entities/tem-model.md]]**

## Key Computational Insights

1. Structural generalization on graphs reduces to factorizing structural code (g) from sensory code (x) — then W (transition rules) can generalize across environments
2. Grid cells emerge without supervision as optimal basis for path integration on hexagonal/square environments; all spatial cell types follow from one objective
3. Place cell remapping is non-random: remap-to-positions preserve grid-phase (g) relationships — testable prediction, verified in two datasets
4. Non-spatial hippocampal cells (chunking, counting, spatial) emerge in same model when structural code indexes task dimensions beyond physical space
5. Fast Hebbian M (per-environment) + slow backprop W (shared) are the minimal two-timescale learning system needed for generalization

## Implementation Notes

See [[wiki/queries/tem-implementation-vs-theory.md]]: key divergences between paper description and reference code (`djcrw/generalising-structural-knowledge`) include learned MLP transitions (not ring attractors), scalar-product Hebbian trick, three reconstruction losses, no KL divergence despite variational framing.
