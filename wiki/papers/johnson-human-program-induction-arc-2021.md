---
title: "Fast and flexible: Human program induction in abstract reasoning tasks — Johnson et al. 2021"
type: paper
tags: [program-induction, abduction, language-of-thought, ARC, abstract-reasoning, objectness, central-framing-audit, rival-frame]
created: 2026-07-09
updated: 2026-07-09
sources: [johnson-human-program-induction-arc-2021]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/core-knowledge.md, wiki/entities/arc-agi.md, wiki/queries/central-framing-epistemic-audit.md, wiki/concepts/probabilistic-language-of-thought.md, wiki/papers/goodman-plot-probabilistic-programs-2024.md]
---

# Fast and flexible: Human program induction in abstract reasoning tasks

**Citation:** Johnson, A., Vong, W. K., Lake, B. M., & Gureckis, T. M. (2021). *Fast and flexible: Human program induction in abstract reasoning tasks.* CogSci 2021 (arXiv:2103.05823). First behavioral study of humans solving ARC (Chollet 2019).

**Role in the wiki:** the **Axis-2 rival-frame anchor** for the central-framing audit ([[wiki/queries/central-framing-epistemic-audit.md]]) — reasoning-as-**program induction / abduction**, explaining the wiki's own target benchmark (ARC) with *no* navigation/grid/map vocabulary. The *behavioral* instance of the **Probabilistic Language of Thought** framework ([[wiki/concepts/probabilistic-language-of-thought.md]], Goodman et al. 2024 = Axis-2 #6); this paper supplies the human ARC data, PLoT the formal "one problem" reduction it evidences.

## Key computational insights

- **Home-turf human data.** 95 participants, 40/1000 ARC tasks; humans **83.8%** avg (every task solved by ≥1 participant, 65% of tasks ≥80% solve rate) vs. Kaggle program-synthesis winner **21%** (full test set) / **57.5%** (these 40 tasks). Human–Kaggle rank correlation only 0.35 — different difficulty profiles.
- **Abduction, not induction.** ARC tasks were hand-designed *without* a pre-specified grammar, so solvers must **flexibly generate new rules / decide which variables to bind on the fly**, not select from a fixed primitive set — unlike classic pLoT experiments where the grammar itself generates the stimuli. This is the load-bearing challenge to fixed-hypothesis-space language-of-thought models.
- **Two challenges to LoT theories.** (1) *Unbounded conceptual background* — the largest unique-word classes in solution descriptions are geometric + transformation, implying hypotheses drawn from a large conceptual store, not a small primitive set; description length negatively predicts accuracy (b=−0.17; r=−0.50) and within-task naming divergence (0.41) is far below shuffled (0.68) → **natural language scaffolds hypothesis generation**, possibly instead of / alongside a symbolic LoT. (2) *Flexible object parsing* — what counts as an object is task-dependent (occlusion, grouping); humans re-parse per task, whereas standard LoT assumes a fixed symbolic parse.
- **Object-centric action planning.** State-space graphs show bottleneck states = task-relevant *objects*; humans generate outputs object-by-object or copy-then-move objects. Human errors **obey object priors** (right shapes/colors, one alignment dimension); Kaggle errors **violate** them (egregiously elongated shapes, grid wrap-around) — a behavioral precursor to the ConceptARC near-miss vs. concept-failure dissociation and Beger 2025's missing-objectness finding.
- **Fast + flexible.** 2–3 examples, ≤10 tasks of experience, ~3 min/task, **~36 s of thinking before the first action** (hypothesis formulation), 1.59 attempts avg.

## Limitations

- **Algorithmic-level cognitive-science account with no neural claim.** It says nothing about the presence/absence of a grid/map code, so it cannot directly contradict the navigation *substrate* — it competes with "reasoning ≅ navigation" only at the computational-description level, and program search is *foldable* into latent-graph navigation over a hypothesis space (the frame-preserving absorption the audit flags).
- **Small, descriptive.** 40/1000 tasks (single test item, ≤15×15 grids), MTurk sample; state-space and error analyses are qualitative; no computational model is implemented (flagged as future work — connect NL descriptions to ARC semantics).
