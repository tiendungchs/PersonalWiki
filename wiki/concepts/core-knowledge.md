---
title: "Core Knowledge"
type: concept
tags: [core-knowledge, innate-priors, objectness, number, geometry, agency, developmental, start-up-software]
created: 2026-07-08
updated: 2026-07-08
sources: [core-knowledge-spelke-kinzler-2007, review-spelke-what-babies-know, hauser-chomsky-fitch-2002]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/recursion.md, wiki/concepts/binding-problem.md, wiki/concepts/relational-reinterpretation.md, wiki/concepts/working-memory.md, wiki/concepts/convergent-allocentric-coding.md, wiki/concepts/path-integration.md, wiki/concepts/cultural-learning.md, wiki/entities/arc-agi.md, wiki/entities/grid-cells.md, wiki/papers/spelke-kinzler-core-knowledge-2007.md, wiki/papers/revencu-csibra-what-babies-know-2023.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md, wiki/papers/beger-conceptarc-multimodal-2025.md]
---

# Core Knowledge

**Core knowledge = a small number (four, possibly five) of innate, domain-specific, evolutionarily ancient representational systems that give humans and other animals structured priors over objects, agents, number, geometry, and (candidate) social partners — the "start-up software" on which all flexible learning is built.**

The central claim (Spelke & Kinzler 2007) rejects both dominant views of mind: neither a single general-purpose learner *nor* massively-modular (thousands of special-purpose devices). Instead, a **small set of core systems** supplies the inductive biases; new skills build on them. This is the developmental-psychology origin of ARC-AGI's "Core Knowledge Priors" and the objectness prior whose absence is [[wiki/architectural-gaps.md]] Gap #9.

---

## The Four (+1) Systems

Each system = a set of **individuation principles** (what counts as an entity in the domain) + a set of **signature limits** (identifiable across ages, species, cultures — the diagnostic fingerprint).

| System | Individuation principles | Signature limit | Notable dissociation |
|---|---|---|---|
| **Objects** | cohesion (bounded connected wholes), continuity (unobstructed paths), contact (no action at a distance) | **~3–4 item set-size** (parallel individuation) | Present in newborns / newly-hatched chicks; no core subcategories (food/artifact/liquid) |
| **Agents** | goal-directedness, efficiency (rational action), contingency, reciprocity, gaze-following | needs no face, no cohesion/continuity/contact | **Explicitly violates the object principles** — agents act at a distance, on discontinuous paths |
| **Number** | abstract (cross-modal: objects/sounds/actions), comparable, addable/subtractable | **Weber ratio limit** (scalar variability); ratio 2.0 at 6mo → 1.15 adult | The Approximate Number System (ANS); distinct from parallel individuation of ≤3 |
| **Geometry** | distance, angle, sense among extended surfaces | ignores non-geometric cues (color, odor) when disoriented | Reorientation uses layout geometry, not landmark objects; associative landmark use is a *separate* process |
| **Social** (candidate) | us/them coalition membership | strongest cue = language/accent, not race/gender | in-group preference emerges by 3–6 months |

**Two distinct number systems.** Small exact quantities (≤3–4) are tracked by the *object* system (parallel individuation, same set-size limit as attention/WM); large approximate quantities use the *ratio-limited* ANS. This is why "numbers/counting" and "objectness" co-appear in ARC's priors. Both systems are **shared with animals** (Hauser, Chomsky & Fitch 2002): rats/pigeons show scalar-variability magnitude estimation (Weber's law), and the ≤4 precise system is recruited via object tracking.

**The generative gap — successor function (HCF 2002).** What animals lack is not number representation but the *generative* integer list. Chimps trained on Arabic numerals (Boysen, Matsuzawa) learn each numeral one-by-one over thousands of trials with no transfer; human children at ~3.5 yr have an "aha" — after learning 1,2,3(,4) they grasp that the list is built by the **successor function** and acquire all the rest at once. This is the [[wiki/concepts/recursion.md]] discrete-infinity operator instantiated in the number domain: the child acquires a recursive generator, the chimp a finite lookup table. Design reading: the number prior a reasoning model needs is not more magnitude channels but the successor/recursion operator that makes the count list productive (a possible confound — Carey notes children first learn the *ordered symbol list*, then its meaning; animals were taught meanings without the list).

**Six domains in Spelke 2022 (vol. 1).** The book expands the 2007 four-system taxonomy to six: trackable objects, navigable spatial layouts, magnitudes of sets/sequences, shapes and object kinds, instrumental agents, and social beings. The object principles are stated as **bidirectional** (e.g. action-on-contact *includes* the no-action-at-a-distance principle) — an entity that fails cohesion (a pile of sand) simply falls outside the domain rather than becoming a defective object.

---

## The Composition Barrier: Why Core Systems Don't Combine (Revencu & Csibra 2023)

Core systems are individually powerful but **mutually encapsulated**, for two reasons Spelke gives:

1. **Modularity** — a core system's operation is insulated from the organism's beliefs.
2. **Attention-dependence** — activation is not automatic; core systems *compete* for a limited attentional resource.

Together these block a representation like "Mary broke the five bottles she liked," which must pool ≥3 core systems at once. This is exactly a [[wiki/concepts/binding-problem.md]] under a serial-attention bottleneck: the barrier to uniquely human cognition is *combining* encapsulated priors, not acquiring a new prior.

**What breaks the barrier? — an unresolved design axis.** Spelke's answer is *natural language* (syntax + compositional semantics), and she explicitly **rejects an innate language of thought (LoT)** to avoid combinatorial explosion. Revencu & Csibra ([[wiki/papers/revencu-csibra-what-babies-know-2023.md]]) argue the language-only account cannot work — the language↔core links do not obtain in either direction:

- Core concepts are *taken for granted* and rarely spoken → adult utterances cannot supply them.
- Many function words (logical operators, tense/aspect, modals) have *no* core-system counterpart → language cannot bootstrap them from core primitives.
- ⇒ an innate **LoT interface** is still required. See [[wiki/concepts/compositional-generalization.md]] for the full language-vs-LoT treatment and the combinatorial-explosion double bind.

**Core systems are not strictly unitary/all-or-none.** Spelke uses all-or-none unity as a criterion (an object failing one principle loses all objecthood). Revencu & Csibra counter with Stahl & Feigenson (2015): infants selectively explore an object by *which* principle it violated (bang a solidity-violator, drop a gravity-violator) rather than suspending all objecthood; continuity dissociates from cohesion (teleportation), action-on-contact is violable (remote controls). **Design reading:** a core prior is a *bundle of dissociable constraints*, not a monolithic switch — the objectness prior (Gap #9) should be implemented as separately-maskable sub-principles, not one binary gate. Tracked in [[wiki/empirical-tensions.md]].

---

## Why This Matters for a Reasoning Model

Core knowledge is the **extreme-prior end of the slow-W spectrum** ([[wiki/concepts/two-learning-timescales.md]]): structure that must exist *before* content binding begins, not learned from token statistics. Design consequences:

| System | Design requirement | Where it lives in the wiki |
|---|---|---|
| **Objects** | discrete-entity representation with persistence/boundaries; the missing prior behind pixel/connectivity shortcuts | Gap #9; TEM `p = f(g,x)`; [[wiki/concepts/shortcut-reasoning.md]] |
| **Geometry** | allocentric metric scaffold (grid/place code, reorientation) as an *innate* substrate | [[wiki/concepts/convergent-allocentric-coding.md]], [[wiki/concepts/path-integration.md]], [[wiki/entities/grid-cells.md]] |
| **Number** | ratio-limited magnitude code + parallel individuation; set-size ~4 shared with WM capacity | [[wiki/concepts/working-memory.md]] |
| **Agents** | goal-directed / rational-action prior; substrate for autonomous goal inference | ARC-AGI-3 Block 3D; [[wiki/concepts/abstract-reasoning.md]] |

**Three architectural lessons:**
1. **Content-generality within domain = a template for structural generalization.** Each core system applies the *same* principles to arbitrary new instances (any object, any set) — exactly the transfer property a reasoning model must have, but pre-supplied rather than learned.
2. **Signature limits are architectural fingerprints.** A brain-like model should *reproduce* the ~4 set-size limit and Weber ratio as emergent constraints, not treat them as bugs. Their cross-species universality (Pirahã object tracking; Mundurukú ANS) shows they are load-bearing, not cultural.
3. **Uniquely human cognition = combining core systems.** Spelke argues language and symbols *bind* otherwise-encapsulated core representations. This is a [[wiki/concepts/binding-problem.md]] / [[wiki/concepts/compositional-generalization.md]] claim: the human leap is composition *across* domain-specific priors, not a new prior.

---

## Open Problems

1. **Acquisition without hand-coding.** Core priors are the "start-up software" of [[wiki/concepts/abstract-reasoning.md]] open problem #1 — how to instantiate object/agent/geometry/number priors computationally, without either hard-coding them or hoping they emerge from discriminative training (they do not — Beger et al. 2025).
2. **Encapsulation vs. composition.** Core systems are domain-specific and mutually encapsulated (object principles *contradict* agent principles); what mechanism combines them into flexible, cross-domain reasoning is unspecified — the binding interface question.
3. **Core knowledge as error source.** The same priors that scaffold learning also *mislead* (non-Euclidean space, discontinuous quantum objects, us/them bias). A reasoning model needs the ability to override core priors via conceptual change — a stability/plasticity problem at the level of innate structure.
4. **The composition engine (language vs. LoT).** What mechanism composes across encapsulated core priors? Natural language (Spelke) fails the bidirectional-link test; an innate LoT (Revencu & Csibra) faces the combinatorial-explosion double bind (why compose *this* first?) and a representational-format codec problem (core outputs may be a different format than thought's building blocks). Neither is worked out computationally — this is the developmental-psychology face of Gaps #2 (continuous↔discrete codec) and #3 (composition/vocabulary selection).

---

## Connections

- **[[wiki/concepts/abstract-reasoning.md]]** — core knowledge is the "start-up software" (open problem #1): the structured domain priors (intuitive physics/psychology) that abstract reasoning builds on but that token-prediction training does not acquire; the extreme-prior end of the slow-W spectrum.
- **[[wiki/concepts/shortcut-reasoning.md]]** — the missing objectness core system *is* the root of ARC pixel/color/connectivity shortcuts; models default to spurious features precisely because they lack the object-individuation prior.
- **[[wiki/entities/arc-agi.md]]** — ARC-AGI's four "Core Knowledge Priors" (objectness, number, geometry, agency) are drawn directly from this theory; the prior budget is Chollet's fairness criterion for human-AI comparison.
- **[[wiki/concepts/structural-generalization.md]]** — each core system's content-generality (same principles → any new instance) is a pre-supplied instance of the transfer property structural generalization must learn.
- **[[wiki/concepts/binding-problem.md]]** — Spelke's proposal that uniquely human cognition arises from *combining* encapsulated core systems (via language) frames the human leap as a cross-domain binding problem.
- **[[wiki/concepts/compositional-generalization.md]]** — composition across domain-specific core priors (not a new prior) is the candidate origin of human systematicity.
- **[[wiki/concepts/working-memory.md]]** — the object system's ~3–4 set-size limit (parallel individuation) is the same capacity limit seen in visual WM and multiple-object tracking, suggesting a shared substrate.
- **[[wiki/concepts/convergent-allocentric-coding.md]]** — the geometry core system (reorientation by layout, ignoring non-geometric cues) is the behavioral expression of the allocentric spatial code convergently evolved across taxa.
- **[[wiki/concepts/path-integration.md]]** — geometric reorientation and layout representation are the perceptual counterpart of the path-integration substrate (grid cells).
- **[[wiki/entities/grid-cells.md]]** — grid/place codes are the neural substrate of the innate geometry core system; the metric scaffold Spelke's reorientation experiments probe behaviorally.
- **[[wiki/concepts/relational-reinterpretation.md]]** — the association-vs-productive-composition boundary Revencu & Csibra find under-specified is the developmental-psychology restatement of Penn's functional-vs-concatenative distinction: which combinations are mere association vs. role-governed productive composition.
- **[[wiki/concepts/recursion.md]]** — the number core system's generative gap (children's successor-function "aha" vs. chimps' one-by-one numeral learning) is the number-domain instance of recursion/discrete infinity; the approximate and parallel-individuation systems are shared with animals, only the recursive count-list generator is not.
- **[[wiki/papers/spelke-kinzler-core-knowledge-2007.md]]** — primary source: the four-system taxonomy, signature-limit methodology, fifth social-partner candidate, and the neither-general-nor-modular thesis.
- **[[wiki/papers/revencu-csibra-what-babies-know-2023.md]]** — critical commentary extending the taxonomy to six domains and supplying the modularity+attention composition barrier, the language-vs-LoT debate, and the non-unitarity revision.
- **[[wiki/papers/building-machine-thinks-like-people-lake-2016.md]]** — Lake et al.'s "start-up software" (intuitive physics/psychology) is the ML-facing restatement of Spelke's object and agent core systems as required developmental priors.
- **[[wiki/papers/beger-conceptarc-multimodal-2025.md]]** — empirical demonstration that frontier models lack the objectness core system, defaulting to shortcut features on ConceptARC.
- **[[wiki/concepts/cultural-learning.md]]** — Tomasello's "understanding persons as intentional agents" elaborates the innate *agent* core system into a social acquisition channel; language-enabled composition across encapsulated core priors is the same composition-barrier crossing this page frames.
