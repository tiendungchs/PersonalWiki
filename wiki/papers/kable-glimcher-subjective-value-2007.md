---
title: "The neural correlates of subjective value during intertemporal choice (Kable & Glimcher 2007)"
type: paper
tags: [temporal-discounting, subjective-value, intertemporal-choice, common-currency, vmpfc, ventral-striatum, neuromodulation, reinforcement-learning]
created: 2026-07-18
updated: 2026-07-18
sources: [The neural correlates of subjective value during intertemporal choice]
related: [wiki/concepts/neuromodulation.md, wiki/queries/hrl-goal-decomposition-coverage.md, wiki/queries/proposed-reasoning-model-block-architectures.md, wiki/entities/prefrontal-cortex.md]
---

# The Neural Correlates of Subjective Value During Intertemporal Choice

**Citation:** Kable, J.W. & Glimcher, P.W. (2007). *Nature Neuroscience* 10(12):1625–1633. fMRI, 10 subjects choosing between a fixed immediate $20 and a variable delayed reward ($20.25–$110, 6 h–180 d).

## Key computational insights

- **Subjective value is an explicit neural variable, not an "as-if" construct.** Activity in **ventral striatum, medial PFC (vmPFC), and posterior cingulate cortex (PCC)** tracks the *behaviorally-revealed* subjective value (SV) of a delayed reward — up with amount, down with delay, up when the delayed option is chosen. SV beat objective amount, objective delay, and choice as a regressor in ≥62–100% of voxels.
- **Hyperbolic discount function:** `SV = A / (1 + kD)` (A = amount, D = delay in days, k = subject-specific discount rate; median R²=0.95). k spanned 200× across subjects (0.0005 patient → 0.1189 impulsive). Hyperbolic fit the data better than single-exponential, and as well as a sum-of-two-exponentials.
- **Psychometric-neurometric match:** the *neural* discount rate estimated from BOLD equals each subject's *behavioral* discount rate (difference centered on zero) and rises with it across subjects — a per-individual, idiosyncratic preference function is physically instantiated, not a group-average constant.
- **Falsifies the β–δ two-system valuation hypothesis (McClure et al. 2004):** these three regions do **not** exclusively or even primarily value immediate rewards. Neural activity is neither more impulsive (β) nor more patient (δ) than behavior — it tracks a **single continuous common-currency value scale** covering rewards at *all* delays. Argues against a limbic-impulsive vs. cortical-patient split for inter-temporal choice.

## Limitations

- Only one option varied (immediate reward fixed at $20), so addition/subtraction/division combination rules and chosen-value coding are indistinguishable here; no delayed-vs-delayed condition.
- Only subjects with *stable* discount functions were scanned — says nothing about heuristic/cut-off choosers. Correlational fMRI; no causal or single-unit evidence.

## Links
- [[wiki/concepts/neuromodulation.md]] — grounds 5-HT=γ (discount factor): supplies the vmPFC/striatal common-currency SV signal and the hyperbolic k the abstract γ parameter must produce.
- [[wiki/queries/hrl-goal-decomposition-coverage.md]] — mechanism #3 (temporal discounting); this is the ingest that moves inter-temporal choice from "a parameter" toward "a modeled decision."
- [[wiki/queries/proposed-reasoning-model-block-architectures.md]] — Block 3D: the common-currency SV signal is the biological template for the `V(g)` value head.
- [[wiki/entities/prefrontal-cortex.md]] — vmPFC as the common-currency valuation node.
