---
title: "Development of non-spatial grid-like neural codes tracks inference and intelligence — Qu et al. 2026"
type: paper
tags: [grid-cells, entorhinal-cortex, mPFC, cognitive-map, development, fluid-intelligence, schema, assimilation, inferential-reasoning]
created: 2026-07-09
updated: 2026-07-09
sources: [qu-grid-code-development-intelligence-2026]
related: [wiki/entities/grid-cells.md, wiki/concepts/memory-schemas.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/intelligence-density.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/prefrontal-cortex.md, wiki/queries/central-framing-epistemic-audit.md, wiki/queries/mec-abstract-codes-vs-declarative-rules.md, wiki/papers/garvert-abstract-relational-map-2017.md, wiki/papers/grid-like-all-perception-chen-2022.md, wiki/papers/gridlikecode-constantinescu-2016.md]
---

# Development of non-spatial grid-like neural codes tracks inference and intelligence

**Citation:** Qu Y, Ou J, Pang L, Wu S, Luo Y, Behrens TEJ, Liu Y (2026). *Cell* 189, 3091–3106. https://doi.org/10.1016/j.cell.2026.02.028

The strongest correlational link in the wiki between the *navigation code* and *reasoning ability* — grid-code maturation tracks both inference and standardized fluid-intelligence (Raven's SPM). Axis-1 #3 of the central-framing audit.

## Key computational insights

- **Paradigm:** 203 participants aged 8–25, fMRI. A 2D non-spatial "knowledge map" (5×5 monsters, dimensions = attack power / defense power). Subjects learned only adjacent 1D rank differences via *piecemeal* learning (never told the latent 2D structure), then made 2D "map-based inference." **Training was performance-matched** (≥80% premise accuracy for all ages) so age effects are not confounded by learning speed.
- **EC grid-like code strengthens with age and *mediates* inference.** Three convergent fMRI methods (hexagonal modulation, hexagonal consistency, RSA of trajectory-angle) all find 6-fold-specific grid code in EC (4/5/7/8-fold null). Grid strength correlates with age (r=0.16) and inference (r=0.31); a **mediation analysis** shows EC grid code carries the age→inference improvement (β_ab=0.04) — survives controlling for SNR, socioeconomic status, training sessions, and holds in the youngest (8–12: r=0.32).
- **mPFC distance code is derived from the EC schema.** mPFC encodes 2D Euclidean distance (> 1D hierarchy), *modulated by EC grid alignment* (aligned > misaligned trials). In **parallel mediation**, only the EC grid effect survives for map-based inference — the map-like (distance) code is downstream of the schema (grid) code.
- **Assimilation via a stable schema (game 2).** New objects inserted at map center; the EC grid schema is *retained* (conjunction in right EC across original + assimilated maps), and map-alignment strength predicts nonlocal inference (r=0.21) independent of age. Here the **mPFC distance code has an independent, age-dependent role** in assimilation (β_ab=0.02, controlling for game 1) — a second mechanism beyond the EC schema.
- **Developmental heuristic→schema shift (congruency dissociation).** 8-year-olds solve *congruent* trials (one monster dominates both dims → a "which monster usually wins" heuristic / model-free RL suffices) but are at chance on *incongruent* trials (each monster wins one dim → requires true 2D structure). A three-way age × grid-strength × congruency interaction: the age-related closing of the congruency gap occurs **only in high-grid-code participants**. Grid maturation is what enables the shift off the statistical shortcut onto structured inference.
- **Structural double dissociation.** EC gray-matter volume *increases* 8→25 (against the whole-brain adolescent decline); mPFC GMV *decreases*; EC–mPFC structural connectivity (cingulum, not fornix) increases with age and predicts inference. Later-maturing EC→mPFC pathways plausibly gate the extension of grid coding from physical to abstract space.
- **Link to fluid intelligence (CCA).** EC grid code + mPFC distance code jointly predict Raven's SPM reasoning and WISC comprehension; SPM partially mediates the age→inference gain. The cognitive-map substrate tracks real-world reasoning, not just task performance.

## Limitations

- The abstract space is **2D-Euclidean-embeddable and orderable** (5 ranks/dim) — the authors explicitly flag genuinely graph-like / non-Euclidean structure as future work. So this validates the *metric-continuous* slice, not the non-embeddable symbolic slice.
- **Cross-sectional** → mediation is correlational, no temporal precedence / causal direction (longitudinal + perturbation needed).
- **BOLD-only** grid detection (Chen 2022 caveat applies); but mediation + congruency dissociation supply the strongest *usage* (not mere co-occurrence) evidence to date.

## Links

Grid code as a developing, intelligence-tracking substrate ([[wiki/entities/grid-cells.md]]); schema-guided assimilation with EC-schema + mPFC-distance division of labor ([[wiki/concepts/memory-schemas.md]]); the congruency dissociation as a developmental heuristic→structure transition ([[wiki/concepts/shortcut-reasoning.md]]); grid maturation as a correlate of fluid intelligence ([[wiki/concepts/intelligence-density.md]]); re-scores sub-claims A/B/C of [[wiki/queries/central-framing-epistemic-audit.md]]; refines EC-host vs. mPFC roles in [[wiki/queries/mec-abstract-codes-vs-declarative-rules.md]]; the active-task, developmental counterpart to Garvert's passive implicit graph ([[wiki/papers/garvert-abstract-relational-map-2017.md]]) and Constantinescu's abstract 2D space ([[wiki/papers/gridlikecode-constantinescu-2016.md]]).
