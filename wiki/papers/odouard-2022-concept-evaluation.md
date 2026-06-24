---
title: "Evaluating Understanding on Conceptual Abstraction Benchmarks"
type: paper
tags: [concept-based-evaluation, abstract-reasoning, RAVEN, ARC, shortcut-learning, benchmark]
created: 2026-06-24
updated: 2026-06-24
sources: [Evaluating Understanding on Conceptual Abstraction Benchmarks.md]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/latent-graph-discovery.md, wiki/entities/ARC-AGI.md, wiki/papers/conceptarc-moskvichev-2023.md]
---

# Evaluating Understanding on Conceptual Abstraction Benchmarks

**Odouard & Mitchell, Santa Fe Institute. EBeM workshop, 2022.**

Proposes *concept-based evaluation*: instead of IID train/test splits, probe a system's understanding of a concept by testing it across systematic variations of that concept — deliberately violating the IID assumption to expose shortcut solutions.

---

## Key Computational Insights

- **Understanding = infinite conceptualizations.** Barsalou's definition: a concept is "a competence or disposition for generating infinite conceptualizations of a category." IID benchmarks test a single instantiation — a necessary but insufficient condition; a model solving one instance may have learned a distribution-specific correlate rather than the concept.
- **Concept-based evaluation as OOD null test.** Creates variations of the *same concept* (e.g., Sameness, Progression) across different attributes and instantiations, asking whether a system that solves one version can solve all. High IID accuracy predicts nothing about this.
- **RAVEN shortcut gap.** MRNet (Multi-scale Relation Network): 73% RAVEN test set → 49%/44% on Sameness/Progression concept variations. SCL (Scattering Compositional Learner): 89% → 62%/68%. Benchmark accuracy overestimates conceptual understanding by ~20–25 percentage points.
- **ARC per-concept asymmetry.** ARC-Kaggle2nd (19% overall) scores 29% on top/bottom variations but only 8% on boundary variations — understanding is not concept-uniform even when overall benchmark performance is positive.
- **Procedural-generation bias is a separate failure mode.** RAVEN's original answer-choice bias (90%+ solvable from answer choices alone without seeing the matrix) is independent of concept understanding — two distinct diagnostics are required.

## Limitations

Workshop paper (EBeM 2022); small probe sets (210 Sameness + 80 Progression RAVEN problems; 14 top/bottom + 12 boundary ARC tasks). No human baselines on the concept variations themselves. ARC-Kaggle2nd is a 2020-era program-synthesis solver, not a frontier LLM. Full benchmark formalization came in ConceptARC (Moskvichev et al. 2023, [[wiki/papers/conceptarc-moskvichev-2023.md]]).

---

## Connections

- **[[wiki/concepts/abstract-reasoning.md]]** — concept-based evaluation operationalizes Barsalou's definition of understanding; the RAVEN shortcut gap is the visual-relational-domain precursor to ConceptARC's near-miss vs. concept-failure error dissociation.
- **[[wiki/concepts/shortcut-reasoning.md]]** — RAVEN and ARC experiments confirm that high IID accuracy is achievable via shortcut solutions that do not generalize to concept variations; MRNet and SCL are operating in the shortcut regime despite strong benchmark scores.
- **[[wiki/concepts/latent-graph-discovery.md]]** — concept variations probe whether a model learned the true latent transformation rule (edge) or a distribution-specific correlate; MRNet/SCL's drop on Sameness/Progression confirms spurious edge covariate shift at the rule level.
- **[[wiki/entities/ARC-AGI.md]]** — ARC-Kaggle2nd's per-concept asymmetry (top/bottom 29% vs. boundary 8%) is an early diagnostic of the objectness prior gap that ConceptARC (2023) and Beger et al. (2025) later formalized.
- **[[wiki/papers/conceptarc-moskvichev-2023.md]]** — ConceptARC (Moskvichev, Odouard & Mitchell 2023) is the full formalization of the methodology introduced here; expanded to 16 concept groups with 10 tasks × 30 test inputs each.
