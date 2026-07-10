---
title: "Parallel cognitive maps for multiple knowledge structures in the hippocampal formation — Zheng, Hebart, … Garvert 2024"
type: paper
tags: [cognitive-map, hippocampus, entorhinal-cortex, semantic-memory, parallel-maps, relational-knowledge, fMRI-adaptation, anterior-posterior-gradient]
created: 2026-07-09
updated: 2026-07-09
sources: [zheng-parallel-cognitive-maps-2024]
related: [wiki/papers/garvert-abstract-relational-map-2017.md, wiki/concepts/memory-schemas.md, wiki/concepts/successor-representation.md, wiki/concepts/latent-graph-discovery.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/grid-cells.md, wiki/queries/mec-abstract-codes-vs-declarative-rules.md, wiki/queries/central-framing-epistemic-audit.md, wiki/papers/kumaran-maguire-2005-hippocampus.md]
---

# Parallel cognitive maps for multiple knowledge structures in the hippocampal formation

**Citation:** Zheng XY, Hebart MN, Grill F, Dolan RJ, Doeller CF, Cools R, Garvert MM (2024). *Cerebral Cortex* 34(2):bhad485. https://doi.org/10.1093/cercor/bhad485

A reanalysis of the **Garvert et al. 2017** fMRI dataset asking whether the hippocampal formation, when objects are simultaneously embedded in *two* relational structures, forms **one conjunctive map** (integrating the dimensions) or **parallel separable maps** (one per dimension). Answer: parallel and anatomically separable.

## Key computational insights

- **Two structures, same stimuli:** the *newly-learned transition structure* (implicit, random-walk-sampled graph; Day-1 learning) and the *pre-existing semantic structure* (taxonomic similarity, lifetime-acquired) over the same objects. Semantic distance was measured independently via a triplet odd-one-out task (Hebart 2020) and isolated from perceptual similarity by regressing out a matched THINGS-database rating (residual = perceptual). The two distances were **uncorrelated** (ρ≈0.03).
- **Both are cognitive maps, both in the hippocampal formation.** fMRI adaptation scaled with *both* link distance (transition) *and* semantic distance — each an independent parametric regressor, no orthogonalization. Semantic similarity adheres to geometric map norms (metric, symmetric; MDS recovers category clusters — animate/inanimate, natural/manmade). Residual (perceptual) distance predicted *nothing*.
- **Parallel, not conjunctive — anatomically separable.** Link-distance code → bilateral **entorhinal cortex** (more **anterior**); semantic code → bilateral **hippocampus** (more **posterior**); non-overlapping clusters, each null in the other's ROI. The brain does **not** fuse the two relational structures into one integrated map — it keeps separable maps in parallel, along an **anterior–posterior gradient** of the hippocampal long axis (reminiscent of the coarse-anterior→fine-posterior grid-scale gradient).
- **Semantic map is HC-formation-specific and task-irrelevant.** No adaptation in the usual semantic hubs (left ATL, angular gyrus) — attributed to the *passive* design (participants attended only a gray-patch cover task; semantics never demanded). So a *lifetime-acquired, explicit, taxonomic* structure is mapped in HC **automatically and implicitly**, like Garvert's recent implicit transition graph.

## Limitations

- fMRI adaptation only (like Garvert) — recovers the *map* but does **not** test hexagonal grid symmetry; correlational, no causal/lesion test.
- Cannot fully disentangle an *anterior–posterior gradient* from *two discrete clusters* (fMRI spatial autocorrelation); higher-res or intracranial needed.
- Both structures are **2D-embeddable** (MDS recovers each) → speaks to parallel *metric/embeddable* maps, not non-embeddable symbolic structure. Semantic vs. transition also confounds several axes (taxonomic-vs-associative, lifetime-vs-recent, explicit-vs-implicit) — the source of the separation is not isolated.

## Links

Parallel separable relational maps over one entity set — a design principle for [[wiki/concepts/memory-schemas.md]] (parallel schemas, non-conjunctive) and [[wiki/concepts/latent-graph-discovery.md]] (multiple latent graphs + a *which-map* selection problem, not one graph). Refines the HC-vs-mPFC routing in [[wiki/entities/hippocampal-entorhinal-system.md]] and [[wiki/queries/mec-abstract-codes-vs-declarative-rules.md]]: *embeddability*, not declarative/explicit character, is the disqualifier — taxonomic semantic similarity (metric category space) gets an HC map even though it is explicit and lifetime-old, whereas Kumaran & Maguire's non-metric acquaintance graph does not. Direct sibling of [[wiki/papers/garvert-abstract-relational-map-2017.md]]; re-scores Axis-1 #4 of [[wiki/queries/central-framing-epistemic-audit.md]].
