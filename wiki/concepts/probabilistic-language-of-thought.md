---
title: "Probabilistic Language of Thought (PLoT) / Program Induction"
type: concept
tags: [probabilistic-language-of-thought, program-induction, Church, conditional-inference, language-of-thought, rival-reduction, central-framing-audit]
created: 2026-07-09
updated: 2026-07-10
sources: [goodman2024probabilistic, johnson-human-program-induction-arc-2021]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/meta-learning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/world-models.md, wiki/concepts/core-knowledge.md, wiki/concepts/recursion.md, wiki/concepts/planning-as-inference.md, wiki/concepts/predictive-coding.md, wiki/entities/vsa-model.md, wiki/papers/goodman-plot-probabilistic-programs-2024.md, wiki/papers/johnson-human-program-induction-arc-2021.md, wiki/papers/hutter-aixi-2000.md, wiki/queries/central-framing-epistemic-audit.md, wiki/papers/butz-unified-subsymbolic-cognition-2016.md]
---

# Probabilistic Language of Thought (PLoT) / Program Induction

**PLoT = concepts are stochastic functions in a universal probabilistic programming language (Church); all reasoning, learning, and theory-of-mind are *conditional inference* (`query`) over compositionally-built generative programs.** It is the primary **non-navigational rival reduction** to [[wiki/concepts/latent-graph-discovery.md]] — the competing answer to "what is the *one problem* cognition solves."

---

## Core formal claims (Goodman, Gerstenberg & Tenenbaum 2024)

| Cognitive object | PLoT formalization |
|---|---|
| **Concept** | a stochastic function (memoized with `mem` for object-persistent properties) |
| **Reasoning** | conditional inference — `query` = sample from prior until `condition` holds (rejection sampling), definable *inside* the language (no new operator) |
| **Composition** | ordinary function composition (sampling semantics: a program = a distribution over execution traces) |
| **Learning** | **program induction** — a higher-order *program-generating program* proposes hypotheses; condition on matching data |
| **Theory of mind** | **nested `query`** = inference-about-inference (inverse planning: goal = predicate, belief = transition fn) |
| **Counterfactual** | **program intervention** on the execution trace (Pearl 3-step: condition → intervene → re-evaluate) |
| **Universality thesis** | stochastic λ-calculus represents *any computable probability distribution* (parallels Church–Turing) |

**The universality thesis is load-bearing:** it gives PLoT's "one framework" claim **theorem-grade standing**, unlike LGD's "reasoning = navigation" which the [[wiki/queries/central-framing-epistemic-audit.md]] classes as a *framing bet*.

**The effective LoT evolves.** Learned concepts are added as primitives → the inductive bias itself changes → later concepts become *shorter* (more probable, more tractable). Candidate driver of development and expertise; the mechanism behind program-level **vocabulary co-discovery** (Gap #3).

---

## Instantiations

| System | What it adds |
|---|---|
| **Church / WebChurch** (Goodman et al. 2012) | reference universal PPL; `query` via MCMC/enumeration; tug-of-war strength inference fits humans r=.98 |
| **WebPPL / Pyro / Gen** | scalable inference (HMC, variational, amortized, programmable) — attacking PLoT's tractability wall |
| **DreamCoder** (Ellis 2021) | library learning: abstracts shared sub-programs into new primitives → program-level vocabulary co-discovery |
| **LAPS** (Wong 2022) | joint prior over programs + natural-language translations — language bootstraps the library ([[wiki/concepts/cultural-learning.md]]) |
| **ARC as abduction** (Johnson 2021) | humans *invent* rules per task from an unbounded store (not search a fixed grammar) — the empirical Axis-2 case ([[wiki/papers/johnson-human-program-induction-arc-2021.md]]) |

---

## PLoT vs. LGD: two "one-problem" reductions

| Axis | PLoT (program induction) | LGD (navigation over a latent graph) |
|---|---|---|
| **Formal standing** | universality *theorem* (any computable distribution) | *framing bet* (audit sub-claim C) |
| **Core primitive** | stochastic function + `query` | node/edge graph + path integration |
| **Native slice** | discrete/symbolic/abductive (ARC, ToM, intuitive theories) | metric/orderable + transition-sampled (spatial, social rank, Garvert graph) |
| **Marr level** | computational (*what* is computed) — no neural claim | offered as substrate (*how*) — grid/map biology |
| **Unsolved core** | inference intractability (program search) | tractability of graph inference + vocabulary co-discovery |

**Mutual foldability ⇒ neither is a finding.** Navigation-over-a-graph is *literally one stochastic program* (a graph is a generative model; path integration is a recursive function; latent-graph discovery is program induction over graph-hypotheses) → **PLoT subsumes LGD**. Conversely, folding PLoT into LGD (nodes = programs, edges = program-space moves) is the frame-preserving absorption the audit warns against — and now the object being absorbed is a *universal* language, making the fold nearly tautological. Because each folds into the other, *neither* "one problem" claim is established by the other's foldability.

**The honest synthesis is a two-level Marr stack, not a winner.** PLoT is silent on implementation; navigation/grid is a candidate *how*. The two are complementary if `query`'s sampling dynamics are physically realized by (or alongside) an emergent map — exactly the open question the audit's Axis-4 (Nanda 2023) probes. They are rivals only if forced onto the same Marr level.

**There is a *third* "one-problem" frame — the free-energy reduction (Butz 2016; [[wiki/concepts/predictive-coding.md]]).** Cognition = distributed free-energy minimization; a concept = a **free-energy-minimum attractor**, learning/reasoning = settling that attractor. Its distinctive standing: unlike PLoT (computational-level, no neural claim) it is pitched at Marr's *implementation* level, so it contests the navigation **substrate** directly — offering FE-attractor relaxation (with spatial coding as only 1 of 3 primitives) as a rival *how*. All three are **mutually foldable** (a graph is a stochastic program is a set of predictive encodings), so none is *the* reduction. The audit resolves C into this **three-frame cross-Marr stack**: PLoT = *what*; navigation-map and free-energy-attractor = two candidate *hows* that may themselves be foldable into each other.

---

## Application to building a reasoning model

- **Supplies the abstract-reasoning ingredients natively** ([[wiki/concepts/abstract-reasoning.md]]): compositionality = function composition; causality = generative program + intervention; learning-to-learn = library/meta-program. These are the three Lake et al. prerequisites, formalized.
- **Owns the symbolic slice** the grid/navigation frame leaves open — abduction, flexible object parsing, language-scaffolded hypothesis generation (Johnson 2021).
- **Vocabulary co-discovery (Gap #3) = library learning**: DreamCoder's abstraction step co-discovers primitives with structure — the program-level version of the action-alphabet problem.
- **The bottleneck is inference, and it is the same wall a brain-inspired model must climb.** Universal `query` is uncomputably slow; the biological answer is **amortized inference** (a fast model-free net trained on the model-based generator's rollouts) — the same fast/slow split as [[wiki/concepts/meta-learning.md]] and abstract-reasoning open problem #3.

---

## Open problems

1. **Level connection (the decisive audit question):** is `query` implemented on an emergent map-like substrate (Axis-4 style), on non-navigational sampling dynamics (MCMC over traces), or both? Only this adjudicates PLoT-vs-LGD.
2. **Inference tractability:** rejection sampling is universal but impractical; program-space induction is combinatorially hard. Amortized/programmable inference is the frontier.
3. **Where the primitives come from:** the program-generating program needs a base language; PLoT is agnostic about its origin (Core Knowledge? language? [[wiki/concepts/core-knowledge.md]]).
4. **Integration with the metric substrate:** how a symbolic PLoT and a continuous grid/SR code gate each other (the two-format codec, Gap #2).

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — the rival "one problem" reduction; PLoT subsumes LGD as one stochastic program, and LGD absorbs PLoT only by a frame-preserving fold — mutual foldability shows neither is *the* established reduction, only a chosen lens.
- **[[wiki/concepts/abstract-reasoning.md]]** — PLoT formalizes the three Lake et al. ingredients (compositionality/causality/learning-to-learn) as function composition / generative programs + intervention / library learning; program induction is the non-navigational account of ARC.
- **[[wiki/concepts/meta-learning.md]]** — concept learning as a program-generating meta-program is the symbolic analog of the slow-outer / fast-inner loop; amortized inference = a fast net trained on the generative model's rollouts.
- **[[wiki/concepts/compositional-generalization.md]]** — the productivity argument (a Church program = infinitely many Bayes nets via symbols + `mem`) is the PPL statement of compositional generalization; program composition is concatenative, not merely functional.
- **[[wiki/concepts/world-models.md]]** — a Church program *is* a generative world model; sampling semantics = mental simulation (noisy-Newtonian physics), counterfactuals via trace intervention — the symbolic-generative cousin of JEPA/RSSM world models.
- **[[wiki/concepts/recursion.md]]** — nested `query` (inference-about-inference) and recursive stochastic function definitions are where PLoT's productivity and discrete infinity live; the meta-program is a phrase-structure generator over hypotheses.
- **[[wiki/concepts/planning-as-inference.md]]** — inverse planning (ToM as nested query) is planning-as-inference made recursive: an agent's action is the `query` output for its goal-predicate; observing it inverts to infer the goal.
- **[[wiki/concepts/core-knowledge.md]]** — the base primitives the program-generating program composes over are candidate Core Knowledge systems; Johnson's flexible object parsing is the objectness prior applied per-task.
- **[[wiki/entities/vsa-model.md]]** — VSA/HRR is a *neural* substrate for compositional symbol binding; PLoT is the computational-level account it could implement — the 94.5%→3% vocabulary cliff is the same program-level co-discovery gap PLoT's library learning targets.
- **[[wiki/papers/hutter-aixi-2000.md]]** — AIXI's Solomonoff prior weights *all computable programs* by 2^{-l(q)}; PLoT's universality thesis is the representation-level cousin (any computable *distribution* = a stochastic λ-term), and program induction is bounded-resource AIXI-style hypothesis search.
- **[[wiki/papers/goodman-plot-probabilistic-programs-2024.md]]** — primary source: the PLoT hypothesis, stochastic λ-calculus universality, `query`, nested query for ToM, program induction + library learning.
- **[[wiki/papers/johnson-human-program-induction-arc-2021.md]]** — the empirical Axis-2 case: humans solve ARC by abduction over an unbounded store, not fixed-grammar search — behavioral evidence for PLoT on the wiki's target benchmark.
- **[[wiki/queries/central-framing-epistemic-audit.md]]** — PLoT is the Axis-2 #6 theoretical rival; the audit's re-score demotes strong-C to "one contestable frame" and reframes PLoT-vs-LGD as a Marr-level complementarity pending the level-connection test; Axis-2 #7 (Butz) then adds the third frame and closes the audit.
- **[[wiki/concepts/predictive-coding.md]]** — the *third* "one-problem" reduction (Butz 2016): concepts = free-energy-minimum attractors; being implementation-level, it rivals the navigation *substrate* (which PLoT, computational-level, cannot), making the terminal picture a three-frame cross-Marr stack rather than a PLoT-vs-LGD pair.
