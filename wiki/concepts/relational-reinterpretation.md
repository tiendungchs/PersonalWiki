---
title: "Relational Reinterpretation (RR)"
type: concept
tags: [relational-reasoning, abstract-reasoning, dual-process, physical-symbol-system, role-filler, comparative-cognition, chunking]
created: 2026-07-08
updated: 2026-07-08
sources: [penn-darwins-mistake-2008]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/analogical-reasoning.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/binding-problem.md, wiki/concepts/working-memory.md, wiki/concepts/core-knowledge.md, wiki/concepts/cultural-learning.md, wiki/entities/lisa-model.md, wiki/entities/prefrontal-cortex.md, wiki/papers/penn-darwins-mistake-2008.md]
---

# Relational Reinterpretation (RR)

**RR hypothesis (Penn, Holyoak & Povinelli 2008): every biological mind builds functionally compositional, particular-involving, *featurally* systematic representations of first-order perceptual relations; only the human mind adds a second system that *reinterprets* those first-order relations as higher-order, role-governed, explicitly structural relations — approximating a Physical Symbol System (PSS).**

This is the comparative-cognition grounding of the wiki's [[wiki/concepts/abstract-reasoning.md]] model-building/pattern-recognition split. It supplies a *representational-level* diagnostic vocabulary for exactly what the second (System-2) system must add, and — crucially — a mechanism for how the first system *fakes* relational competence.

---

## The Two Systems (dual-process, sharpened)

| Property | System 1 (proto-symbolic; shared with animals) | System 2 (relational reinterpretation; human-only) |
|---|---|---|
| Similarity judged on | Perceptual features of constituents | Role-based structural correspondence between relations |
| Compositionality | **Functional** (van Gelder): reliable build + decompose | **Concatenative** (PSS): constituents preserved with role-filler independence |
| Categories | Feature-based ("things that look/act alike") | Role-governed ("lovers", "tools" — no shared perceptual feature) |
| Rules | Pattern-based / repeating dependencies (AAB) | Algebraic / category-based over role variables (Marcus 2001) |
| Systematicity | **Featural** — recombination constrained only by observable features | **Classical** — `R(a,b)∧R(b,c) ⟹ R(a,c)` by structural necessity, domain-independent |
| Types/tokens | Absent | Explicit: `loves` invariant to John↔Mary |

Not a two-value dichotomy: "every species gets the syntax it deserves" — species and modules approximate PSS features to *varying degrees*. Difference of **degree at the representational level** (how closely PSS features are approximated) produces a difference of **kind at the functional level** (what reasoning is manifest). This is the same degree→kind logic behind [[wiki/concepts/intelligence-density.md]].

---

## Chunking + Segmentation: How System 1 Fakes Relational Reasoning

The central mechanistic contribution — and the representational-level root of [[wiki/concepts/shortcut-reasoning.md]]:

1. **Conceptual chunking** — collapse a relation into a single analog scalar (e.g., Shannon-entropy estimate of within-display variability), discarding constituent structure.
2. **Segmentation** — evaluate a multi-relation task as a sequence of chunked conditional discriminations, never holding relational structure open.

**Empirical signatures (why this is not hand-waving):**

| Finding | What it reveals |
|---|---|
| Pigeons/baboons find 16-item same/different *easier* than 2-item | Judging entropy of a display, not the same/different *relation* |
| Baboon RMTS collapses to chance on "different" trials at 2 items, "same" unaffected | 2-item "same" = zero entropy (easy); "different" = small entropy (hard) — entropy chunk, not relation |
| Sarah (chimp) "analogies" tracked *number of featural changes* (Oden et al. 2001) | Feature-count chunk substituting for role-based mapping |
| Human same/different is *categorical* (any variability = "different") | System-2 discretization into a role-governed relation |

Chunking is lossy-but-sufficient whenever the task does not require relational structure to be preserved — precisely the i.i.d.-benchmark regime where shortcuts pass.

---

## LISA: An Existence Proof for the Graft

[[wiki/entities/lisa-model.md]] (Hummel & Holyoak) is offered as the one worked mechanism: it grafts a higher-order relational system (role-filler binding via gamma-band temporal synchrony) onto a simpler conjunctive store that is functionally-but-not-concatenatively compositional. It shows the graft is *possible* on a connectionist substrate — and *hard*: the difficulty is achieving **role-filler independence AND dynamic role-filler binding simultaneously**. Neural corollary: the difference lies in PFC, specifically synchronized activity among prefrontal populations supporting WM ([[wiki/entities/prefrontal-cortex.md]], [[wiki/concepts/working-memory.md]]). Halford's dynamic binding to a WM coordinate-system is the necessary lower bound for *any* relational reasoning (authors' response).

---

## Implications for Building a Reasoning Model

1. **The System-2 target is a specification, not a module label.** A reasoning model must add, on top of a proto-symbolic store, the four PSS features System 1 lacks: role-filler independence, type/token separation, concatenative composition, and classical (structural) systematicity. Each is separately testable — a model can pass featural systematicity (transformers do) while failing all four.
2. **Chunking is the default attractor.** Discriminative objectives converge on the entropy/feature-chunk solution because it is simpler and i.i.d.-sufficient — the representational-level statement of why shortcuts win (Gap #10 routing problem).
3. **"Graft," not "scale."** LISA argues the second system is unlikely to emerge from more parameters, plasticity, or size alone — it required a distinct binding mechanism. Argues against the scale-solves-reasoning hypothesis on comparative grounds.
4. **Diagnostic: does the model reinterpret or re-chunk?** Give a relation solvable *either* by an analog variability estimate *or* by role-based structure; a System-2 reasoner shows the categorical, entropy-invariant signature and omni-directional generalization to novel fillers on first trial.

---

## Open Problems

1. **Autonomous relational learning** — how does role-filler structure get discovered from non-relational perceptual input without hand-coded predicates? (LISA hand-codes; Doumas & Hummel 2008 begins to address.)
2. **The graft interface** — how does the higher-order system query and reinterpret the lower-order store's outputs? (RR describes *that* it does, criticized by Bermúdez as redescription, not *how*.)
3. **What changed in the hominin brain** — RR is representational-level; the physical-level change (PFC synchrony? long-range connectivity?) is unspecified.

---

## Connections

- **[[wiki/concepts/abstract-reasoning.md]]** — RR is the comparative-cognition grounding of the model-building/pattern-recognition split: role-based reinterpretation is model-building; feature-based chunking is pattern recognition.
- **[[wiki/concepts/analogical-reasoning.md]]** — analogy is the prototype System-2 operation (role-based structural mapping); feature-matching "analogies" (Sarah) are the canonical chunking failure that masquerades as it.
- **[[wiki/concepts/structural-generalization.md]]** — classical (structural) systematicity is exactly what structural generalization achieves; featural systematicity is the System-1 imitation that transfers only over observable features.
- **[[wiki/concepts/compositional-generalization.md]]** — RR supplies the functional-vs-concatenative distinction: transformers achieve functional (build/decompose) but not concatenative (role-filler-preserving) composition — the representational statement of the chunking failure mode.
- **[[wiki/concepts/shortcut-reasoning.md]]** — chunking + segmentation is the representational-level root of shortcut reasoning: an analog entropy/feature scalar substitutes for relational structure and passes i.i.d. tests.
- **[[wiki/concepts/binding-problem.md]]** — the System-2 graft *is* a binding solution: dynamic role-filler binding with preserved role-filler independence, which LISA implements via temporal synchrony.
- **[[wiki/concepts/working-memory.md]]** — the human specialization is localized to PFC WM (synchronized prefrontal populations); dynamic binding to a WM coordinate-system is the necessary substrate for any relational reasoning.
- **[[wiki/entities/lisa-model.md]]** — the concrete existence proof of the graft; demonstrates both feasibility and the independence+binding difficulty.
- **[[wiki/entities/prefrontal-cortex.md]]** — the proposed physical locus of the second system; frontopolar integration and prefrontal synchrony are candidate implementations.
- **[[wiki/papers/penn-darwins-mistake-2008.md]]** — source stub.
- **[[wiki/concepts/core-knowledge.md]]** — Revencu & Csibra's under-specified association-vs-productive-composition boundary (over the outputs of encapsulated core systems) is the developmental-psychology restatement of the functional-vs-concatenative distinction; the missing criterion is role-filler independence.
- **[[wiki/concepts/cultural-learning.md]]** — Tomasello's self-other equivalence ("I do what you did") and one-referent-many-construals are the developmental seeds of the role-filler independence and type/token separation System 2 must add; imitation (copy intention) vs. emulation (copy surface) is the acquisition-layer form of the model-building/chunking split.
