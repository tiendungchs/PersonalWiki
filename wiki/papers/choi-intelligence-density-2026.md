---
title: "A Quantitative Definition of Intelligence — Choi 2026"
type: paper
tags: [intelligence, kolmogorov-complexity, algorithmic-information-theory, generalization, memorization, measurement]
created: 2026-06-23
updated: 2026-06-23
sources: [choi-intelligence-density-2026]
related: [wiki/concepts/intelligence-density.md, wiki/concepts/information-theory.md, wiki/concepts/abstract-reasoning.md, wiki/papers/hutter-aixi-2000.md, wiki/papers/arc-agi-overview.md]
---

# A Quantitative Definition of Intelligence — Choi 2026

**Citation:** Kang-Sin Choi, arXiv 2604.10873v1, 2026. Ewha Womans University.

---

## Key Computational Insights

- **Intelligence Density $\mathcal{I}(S) = \log_2 N(S) / C(S)$** — ratio of informational output diversity ($N$: number of mutually Kolmogorov-independent outputs) to total system description length ($C$, in bits). Asymptotic criterion: $\mathcal{I}(n) \to \infty$ iff the system genuinely *knows* its domain (finite mechanism, infinite inputs); $\mathcal{I}(n) \to 0$ iff it *memorises* (description length grows with output count). Multiplication algorithm: $\mathcal{I}(n) \approx 6.6n/667 \to \infty$; lookup table: $\mathcal{I}(n) \to 0$.

- **Proposition 1 (generalisation necessity):** any finite rulebook that must handle an infinite input domain must be algorithmic, not tabular — the set of possible inputs is countably infinite, so any lookup table requires unbounded storage. Generalisation is mathematically necessary, not a design choice.

- **Proposition 2 (Legg-Hutter unification):** under evolutionary selection with a fixed environment and survival-based reward, Legg-Hutter universal intelligence $\Upsilon(\pi)$ is monotonically increasing in $\mathcal{I}(\pi)$. Thus $\mathcal{I}$ generalises Legg-Hutter to substrate-independent settings without requiring environment or reward specification.

- **Multi-domain multiplication:** $N_\text{total} = \prod_i N_i$, so $\log_2 N_\text{total} = \sum_i \log_2 N_i$. A single algorithm covering arithmetic, chess, and language simultaneously accumulates unprecedented output diversity — explaining why general-purpose systems (LLMs, human brains) achieve $\mathcal{I} \to \infty$ despite modest per-domain description length.

- **$\mathcal{I}$ as dual of $K$ and inverse of MDL:** Kolmogorov complexity $K$ compresses output → program (minimum description of data); $\mathcal{I}$ measures program → output generative power (diversity achievable from a given description length). MDL finds optimal $C$ for given data; $\mathcal{I}$ measures what a given $C$ can generate. The two are formally dual with distinct directionality.

---

## Limitations

- $K$ is provably uncomputable; treated as an idealised limit (like Carnot efficiency). Practical measurement uses computable approximations (compression algorithms, LLMs as proxies).
- Independence condition (Definition 2) is binary; graded version based on $K(o_1 \mid o_2)/K(o_1)$ continuous ratio is left for future work.
- Exact $N(n)$ growth rate for LLMs and biological brains is unknown; qualitative determination ($\mathcal{I} \to \infty$) is clear, but the precise growth exponent is an open empirical question.

---

- [[wiki/concepts/intelligence-density.md]] — full formalism, four-way taxonomy, worked examples, and connections
- [[wiki/concepts/information-theory.md]] — $\mathcal{I}$ as dual of $K$; Solomonoff predictor and AIXI (AI with (X) induction (I)) as related ceilings; MDL inverse relationship; uniform/non-uniform computation dichotomy
- [[wiki/concepts/abstract-reasoning.md]] — $\mathcal{I}(n) \to \infty$ as formal criterion for abstract reasoning; feedforward/recurrent architectural implication
- [[wiki/papers/hutter-aixi-2000.md]] — Legg-Hutter $\Upsilon$ (Proposition 2 connection); AIXI (AI with (X) induction (I)) expectimax over the same Kolmogorov prior
- [[wiki/papers/arc-agi-overview.md]] — Chollet's skill-acquisition efficiency converges with $\mathcal{I}$ on the generalisation-not-memorisation criterion
