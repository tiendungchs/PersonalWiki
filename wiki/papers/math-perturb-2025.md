---
title: "MATH-Perturb: Benchmarking LLMs' Math Reasoning Abilities against Hard Perturbations"
type: paper
tags: [math-reasoning, benchmark, memorization, robustness, perturbation]
created: 2026-06-24
updated: 2026-06-24
sources: [MATH-Perturb Benchmarking LLMs' Math Reasoning Abilities against Hard Perturbations.md]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/abstract-reasoning.md]
---

# MATH-Perturb: Benchmarking LLMs' Math Reasoning Abilities against Hard Perturbations

Huang, Guo, Li, Ji, Ge, Li, Guo, Cai, Yuan et al. 2025. arxiv.org/html/2502.06453v2.

---

## Key Computational Insights

1. **Simple perturbations cause minimal drops**: non-essential changes (numerical substitutions, irrelevant constraints) cause <5% accuracy drops in state-of-the-art models — these models are robust to surface variation.
2. **Hard perturbations reveal structural blindness**: changes requiring different solution strategies cause 12–28% drops (o1-mini −16.5%, GPT-4o −27.6%); models cannot detect when the underlying mathematical structure changes.
3. **Subtle memorization is the dominant failure**: models blindly apply memorized techniques without assessing structural applicability — not verbatim text copying; mode collapse (exact repetition) accounts for <10% of errors; most memorization is applied-technique-without-checking.
4. **In-context learning with original problems is dual-edged**: helpful ICL corrects 24–40% of errors for large models; misleading effect causes 18–40% of remaining errors by demonstrating inappropriate techniques; net gain is marginal.
5. **Memorization scales with capability**: larger models trained on more mathematical text accumulate more technique-context associations, amplifying the risk of blind technique application — a mathematical instantiation of the inverse scaling paradox.

---

## Limitations

Limited to 279 level-5 problems; hard perturbations are costly to construct at scale; memorization detection requires manual inspection. No tool/code use permitted.

---

## Links

- [[wiki/concepts/latent-graph-discovery.md]] — hard perturbations empirically instantiate spurious edge covariate shift: models apply edges (solution techniques) valid in the original graph but not the perturbed one
- [[wiki/concepts/shortcut-reasoning.md]] — subtle memorization mode extends the shortcut taxonomy: technique-without-structural-check is a new class distinct from surface pattern matching
