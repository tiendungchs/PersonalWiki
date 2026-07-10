---
title: "Probabilistic programs as a unifying language of thought — Goodman, Gerstenberg & Tenenbaum 2024"
type: paper
tags: [probabilistic-language-of-thought, program-induction, Church, stochastic-lambda-calculus, conditional-inference, theory-of-mind, central-framing-audit, rival-frame]
created: 2026-07-09
updated: 2026-07-09
sources: [goodman2024probabilistic]
related: [wiki/concepts/probabilistic-language-of-thought.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/meta-learning.md, wiki/concepts/world-models.md, wiki/concepts/compositional-generalization.md, wiki/papers/johnson-human-program-induction-arc-2021.md, wiki/queries/central-framing-epistemic-audit.md]
---

# Probabilistic programs as a unifying language of thought

**Citation:** Goodman, N. D., Gerstenberg, T., & Tenenbaum, J. B. (2024). *Probabilistic programs as a unifying language of thought.* Chapter 18 in *Bayesian Models of Cognition: Reverse Engineering the Mind* (Griffiths, Chater & Tenenbaum, eds.), MIT Press.

**Role in the wiki:** the **Axis-2 #6 rival-frame anchor** for the central-framing audit ([[wiki/queries/central-framing-epistemic-audit.md]]) — the *theoretical/foundational* competitor to LGD's "one problem" claim (where Johnson 2021 #5 is the *empirical* one). Full concept treatment: [[wiki/concepts/probabilistic-language-of-thought.md]].

## Key computational insights

- **PLoT (formal): concepts are stochastic functions in a universal probabilistic programming language (Church).** Reasoning, learning, planning, and theory-of-mind are all the *same* operation — **conditional inference** (`query`) — over compositionally-built generative programs. The direct "one framework" rival to *reasoning ≅ navigation over a latent graph*.
- **Universality thesis (proven standing, not a bet).** Stochastic λ-calculus represents *any computable probability distribution* (parallel to the Church–Turing thesis). This gives PLoT's unification claim a **theorem-grade** formal footing that LGD's framing reduction lacks.
- **`query` = conditional inference, definable inside the language** (rejection sampling; no new operator needed). Bayesian belief update, learning, and ToM differ only by *nesting depth*: **nested query = inference-about-inference = inverse planning** (goal = predicate, belief = transition function → Baker-style ToM).
- **Concept learning = program induction** via a higher-order stochastic *program-generating program*. The **effective LoT evolves**: learned concepts become primitives → the inductive bias itself changes → candidate driver of development/expertise. **DreamCoder / LAPS** are the AI instantiations (library learning; natural language bootstraps the library) — a program-level mechanism for vocabulary co-discovery (Gap #3).
- **Counterfactuals = program intervention on the execution trace** (Pearl's 3-step: condition → intervene → re-evaluate). Sampling semantics = **mental simulation** (noisy-Newtonian intuitive physics; intuitive theories = libraries of stochastic functions). Symbols + `mem` individuate unbounded objects on the fly → a Church program is a spec from which *infinitely many* Bayes nets are built (the productivity argument). Quantitative fits r=.98/.97 (tug-of-war / ping-pong strength inference).

## Limitations

- **Computational-level (Marr-1) account only** — explicitly *not* "the algorithmic processes underlying inference, much less their neural instantiation." It therefore **cannot contradict the navigation substrate** (sub-claim B); it competes with LGD only over *what* is computed. Connecting levels is flagged by the authors as the key open challenge — leaving open whether `query` is itself implemented on an emergent map (audit Axis-4).
- **Inference intractability is PLoT's own unsolved core.** Universal `query` (rejection sampling) is "not generally practical"; induction over the vast program space is "extremely challenging." Scalable/amortized/programmable inference (Pyro, Gen, DreamCoder) is the live engineering frontier — the PLoT analog of LGD's tractability wall.
