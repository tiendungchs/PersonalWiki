---
title: "How to build a cognitive map"
type: paper
tags: [cognitive-map, latent-states, successor-representation, replay, structural-generalization, review]
sources: [cognitivemap.md, cognitivemap.pdf]
related: [wiki/concepts/structural-generalization.md, wiki/concepts/latent-states.md, wiki/concepts/successor-representation.md, wiki/concepts/factorized-representations.md, wiki/concepts/replay.md, wiki/concepts/two-learning-timescales.md, wiki/entities/tem-model.md, wiki/entities/cscg-model.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/papers/tem-whittington-2020.md]
---

# How to build a cognitive map (Whittington et al., arXiv 2022)

Whittington JCR, McCaffary D, Bakermans JJW, Behrens TEJ. *arXiv:2202.01682v1* [q-bio.NC].

Perspective unifying six model families (SR/DR, CSCG, TEM, SMP, CANN/VCO) under three shared principles. Uses TEM to demonstrate that non-spatial hippocampal cells are all latent state representations. Key new ideas:

## Key Computational Insights

1. **Latent states unify all "anomalous" HC cells:** splitter cells (T-maze), lap cells (4-lap task), evidence accumulation cells all emerge as latent dimensions tracking task-relevant hidden variables — same TEM objective, different structural graph topology ([[wiki/concepts/latent-states.md]])
2. **HC dual role (map vs. memory):** HC = relational map in novel environments (CSCG-style); HC = episodic memory binding cortical structure to content in familiar environments (TEM-style); predicted transition with experience tied to behavioral generalization ([[wiki/entities/hippocampal-entorhinal-system.md]])
3. **Replay = offline state-space construction:** not credit assignment or consolidation — offline path-integration building factorized GVC-location bindings, reducing online computation ([[wiki/concepts/replay.md]])
4. **Factorized vs. entangled phase prediction:** regularly switching tasks → grid cells stay factorized; single repeated task → representations warp toward it. Generalization pressure determines representational regime ([[wiki/concepts/factorized-representations.md]])
5. **SR eigenvectors = grid cells:** all powers T^n share the same eigenvectors as S = (I−γT)^{−1}, so grid codes support multi-step planning with the same representations as 1-step navigation ([[wiki/concepts/successor-representation.md]])

## Limitations

- Perspective only; no new model development. TEM demonstrations use existing code.
- CSCG + TEM integration is conceptual and untested.
- Speculative extensions (language, math, hierarchy) lack formal models.
