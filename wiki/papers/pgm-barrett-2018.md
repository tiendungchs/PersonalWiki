---
title: "Measuring Abstract Reasoning in Neural Networks — Barrett et al., ICML 2018"
type: paper
tags: [abstract-reasoning, relational-reasoning, generalisation, benchmark, visual-reasoning]
created: 2026-06-21
updated: 2026-06-21
sources: [raven]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/entities/arc-agi.md, wiki/entities/pgm-benchmark.md]
---

# Measuring Abstract Reasoning in Neural Networks — Barrett et al., ICML 2018

**Barrett, D.G.T., Hill, F., Santoro, A., Morcos, A.S., Lillicrap, T.** DeepMind. *ICML 2018.*

- **PGM dataset and 8 generalisation regimes:** Procedurally Generated Matrices express each puzzle as a set of (relation × object × attribute) triples (e.g. [progression, shape, colour]). Eight train/test splits probe distinct generalisation types — Neutral, Interpolation, Extrapolation, Held-out Triples, Held-out Triple Pairs, Held-out Attribute Pairs, and two single Held-out Attributes — providing a finer taxonomy than held-out task type alone. 1.2M training, 20K validation, 200K test questions.

- **Relational scoring architecture is necessary:** CNN-MLP 33%, ResNet-50 42% on Neutral; WReN — a Relation Network scoring each of 8 answer candidates independently by relating it pairwise to all 8 context panels — achieves 62.6%. The independent-per-candidate scoring structure contributes alongside the RN module itself (Wild-ResNet, same structure with ResNet instead of RN: 48%).

- **Composition-decomposition asymmetry:** WReN recombines familiar triples into novel combinations (Held-out Triple Pairs: 41.9%; Held-out Attribute Pairs: 27.2%) but collapses on genuinely novel triples (19.0%) and extrapolation beyond the training attribute range (17.2%). The model learns to combine relations and attributes it has seen; it cannot derive meanings of unfamiliar (r, o, a) combinations from their constituent parts.

- **Symbolic meta-targets improve composition, not decomposition:** Training to predict a 12-bit relation/object/attribute meta-target raises neutral accuracy +13.9% and strongly boosts recombination regimes (Triple Pairs +14.4%; Attribute Pairs +24.5%) but barely helps novel primitive regimes (Held-out Triples +1.1%; Held-out shape-colour +0.5%). Discrete symbolic pressure on known relations improves composition of those relations; it cannot supply meanings for genuinely unseen component primitives.

- **Relation type is the binding constraint:** Accuracy when relation meta-target is correct vs. incorrect: 86.8% vs. 32.1% — dominating attribute type (79.5% / 49.0%) and shape type (78.2% / 62.2%). Relational understanding is the bottleneck, not perceptual accuracy.

**Limitations:** Constrained finite-discrete attribute domain (no open-ended or naturalistic content); no hierarchically nested or multi-step rules (all relations applied within a single 3×3 matrix); WReN performance well below human level (>80% with practice) even on the neutral split; held-out regimes test generalisation breadth but not compositional depth.

**Links:** [[wiki/concepts/abstract-reasoning.md]] — [[wiki/concepts/compositional-generalization.md]] — [[wiki/concepts/structural-generalization.md]] — [[wiki/concepts/factorized-representations.md]] — [[wiki/entities/arc-agi.md]] — [[wiki/entities/pgm-benchmark.md]]
