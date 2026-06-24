---
title: "Convergent Brain Structures for Spatial Memory (brainstorming transcript)"
type: paper
tags: [convergent-evolution, allocentric-coding, central-complex, cephalopod, crustacean, annelid]
created: 2026-06-13
updated: 2026-06-13
sources: [convergent-brain-structures-spatial-memory]
related: [wiki/concepts/convergent-allocentric-coding.md, wiki/concepts/ring-attractor.md, wiki/entities/insect-central-complex.md, wiki/entities/arthropod-mushroom-bodies.md, wiki/entities/cephalopod-vertical-lobe.md, wiki/entities/crustacean-hemiellipsoid-bodies.md, wiki/entities/polychaete-mushroom-bodies.md, wiki/papers/seelig-jayaraman-2015.md]
---

# Convergent Brain Structures for Spatial Memory (brainstorming transcript)

Claude conversation, 2026-06-13. **Source caveat:** All comparative biology claims are tentative unless corroborated by a primary source. CX (Central Complex) claims cross-checked against Seelig & Jayaraman 2015; all others flagged individually.

## Key Computational Insights

- The same expansion → compression circuit motif (fan-out to sparse high-dimensional code, fan-in to generalization/pattern-completion output) appears across at least 5 independent evolutionary lineages building allocentric world models.
- Insect central complex (CX) is the most precisely characterized system: full *Drosophila* connectome available; ring attractor directly confirmed in vivo (Seelig & Jayaraman 2015); 4-module pipeline (heading ring → path integrator → landmark correction → goal vector) cleanly separable from the rest of the brain.
- (tentative) Cephalopod vertical lobe mirrors DG→CA3→CA1 topology (amacrine expansion → large-field-cell compression); lesion studies confirm spatial and contextual learning deficits.
- (tentative) Crustacean hemiellipsoid bodies show place-cell-like activity in crabs during spatial exploration; mantis shrimp have disproportionately large hemiellipsoid bodies relative to body size.
- (tentative) Polychaete annelid mushroom body homologs (*Nereis*, *Platynereis*): same basic Kenyon-cell motif; deep homology vs. independent convergence actively debated.
- For ML purposes, the CX (Central Complex) provides the cleanest abstraction: heading state × path integration × landmark correction is a separable 3-variable system mapping directly onto circular RNN + GRU + attention.

## Limitations

- Source is a brainstorming conversation, not a systematic literature review. Cephalopod, crustacean, and polychaete claims should be treated as leads requiring primary-source verification before being used in design decisions.
- Evolutionary divergence dates in the conversation's summary table are rough order-of-magnitude estimates, not from primary phylogenetic analyses.
- CX (Central Complex) claims specific to non-*Drosophila* insects (locusts, cockroaches, bees) are less well-characterized than *Drosophila*; treat as directionally correct but quantitatively uncertain.

## Relevant Pages

- [[wiki/concepts/convergent-allocentric-coding.md]] — master comparative table and ML design implications
- [[wiki/entities/insect-central-complex.md]] — CX (Central Complex) circuit detail; ML mapping; Seelig & Jayaraman evidence
- [[wiki/entities/arthropod-mushroom-bodies.md]], [[wiki/entities/cephalopod-vertical-lobe.md]], [[wiki/entities/crustacean-hemiellipsoid-bodies.md]], [[wiki/entities/polychaete-mushroom-bodies.md]] — individual system pages
