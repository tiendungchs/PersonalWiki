---
title: "Abstract Reasoning"
type: concept
tags: [abstract-reasoning, model-building, causal-models, compositionality, one-shot-learning]
created: 2026-06-20
updated: 2026-06-23
sources: [building_machine_that_thinks_like_people, ARC-AGI-3-paper.md, analogy_reasoning.md, How does the brain solve visual object recognition, geometry-of-abstraction-bernardi-2020, raven, The ConceptARC Benchmark, A Path Towards Autonomous Machine Intelligence]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/meta-learning.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/continual-learning.md, wiki/entities/arc-agi.md, wiki/entities/pgm-benchmark.md, wiki/papers/arc-agi-overview.md, wiki/papers/arc-agi-3-paper.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md, wiki/concepts/analogical-reasoning.md, wiki/papers/analogy-holyoak-2012.md, wiki/papers/dicarlo-visual-object-recognition-2012.md, wiki/concepts/representational-geometry.md, wiki/papers/geometry-abstraction-bernardi-2020.md, wiki/papers/hutter-aixi-2000.md, wiki/papers/hassabis-neuroscience-ai-2017.md, wiki/papers/pgm-barrett-2018.md, wiki/papers/conceptarc-moskvichev-2023.md, wiki/concepts/world-models.md, wiki/entities/jepa-model.md, wiki/concepts/energy-based-models.md]
---

# Abstract Reasoning

**Abstract reasoning = building and applying causal-structural models of domains — supporting explanation, counterfactual inference, and arbitrary goal repurposing across novel instances — as opposed to pattern recognition, which memorizes discriminative mappings locked to the training task and goal.**

This is the target capability of the wiki. Every other concept page describes either a required ingredient or an architectural constraint on its implementation.

---

## Model-Building vs. Pattern Recognition

| Capability | Pattern Recognition | Abstract Reasoning (Model-Building) |
|---|---|---|
| Transfer to new goals | Requires retraining | Immediate; same world model, new reward |
| Transfer to new instances | Must relearn from scratch | Zero-shot via structural code |
| One-shot concept acquisition | Needs thousands of examples | Single example sufficient |
| Counterfactual inference | Not supported | "What if the floes were glued?" |
| Explanation | Produces label, not cause | Produces causal generative model |

**The Frostbite gap:** DQN uses 924h of experience and reaches <10% of human performance. A person watching 2 minutes of expert play reaches parity in 15 minutes — a >100× efficiency difference. The gap is causal-structural representation, not compute or training data.

---

## Required Ingredients (Lake et al. 2016)

Three prerequisites — each necessary, none individually sufficient:

| Ingredient | Role | What fails without it |
|---|---|---|
| **Compositionality** | Build new representations from known primitives; infinite concepts from finite parts | Cannot recombine across tasks; learning-to-learn gives only 2–5× speed-up |
| **Causality** | Generative model resembles actual data generation; supports counterfactual and explanatory queries | Cannot invert perception; cannot generate, parse, or adapt to novel goal structure |
| **Learning-to-learn** | Extract prior structure shared across tasks; enables one-shot transfer of compositional+causal models | Must relearn causal model from scratch for each new task |

**Key dependency:** learning-to-learn achieves human-level efficiency *only* when representations are compositional and causal. Multi-task training on entangled features yields modest gains; the representation structure is what makes prior knowledge transferable at all.

---

## Diagnostic Tests

From the Characters and Frostbite Challenges (Lake et al. 2016):
- **One-shot classification:** discriminate new instances from a single seen example
- **One-shot generation:** produce novel instances of the concept
- **Part parsing:** identify compositional structure without additional training
- **Goal repurposing:** apply the same world model to 11+ novel goals (Frostbite variants), no retraining
- **Counterfactual prediction:** answer "what if..." queries about unseen physical or causal configurations

---

## PGM: Controlled Generalisation Taxonomy (Barrett et al. 2018)

Barrett et al.'s Procedurally Generated Matrices ([[wiki/papers/pgm-barrett-2018.md]]) operationalise visual abstract reasoning with explicit (relation × object × attribute) triple semantics, providing a finer failure taxonomy than a single held-out test split:

| Regime | What is tested | WReN (no aux.) | WReN (meta-targets) |
|---|---|---|---|
| Neutral | Same distribution | 62.6% | 76.9% |
| Held-out Triple Pairs | Novel *combinations* of familiar triples | 41.9% | 56.3% |
| Held-out Attribute Pairs | Novel attribute pairings, familiar relations | 27.2% | 51.7% |
| Held-out Triples | Genuinely novel (r, o, a) primitive | 19.0% | 20.1% |
| Extrapolation | Attribute values beyond training range | 17.2% | 15.5% |

**The composition-decomposition boundary:** WReN recombines familiar primitives into novel combinations (held-out pair regimes, well above 12.5% chance) but collapses on genuinely novel primitives (held-out triples and extrapolation, near chance). Recombination competence does not imply decomposition competence — a model can combine known (r, o, a) packages without understanding how their meaning arises from constituents. This is the Lake et al. compositionality gap expressed at the visual-relational level.

**Symbolic meta-target implication:** auxiliary training to predict relation/object/attribute type labels boosts recombination regimes (+14.4%/+24.5%) but barely helps novel primitive understanding (+1.1%). Discrete symbolic pressure on *known* relations improves how they compose; it cannot supply meanings for genuinely unseen component primitives. The slow-W system must encode atomic relational meanings — not co-occurrence statistics over triple tuples.

---

## ConceptARC: Near-Miss Errors Operationalize Model-Building (Moskvichev et al. 2023)

ConceptARC ([[wiki/papers/conceptarc-moskvichev-2023.md]]) reveals that the model-building/pattern-recognition distinction is diagnosable from *error structure*, not just accuracy:

| Error type | Who makes it | What it means |
|---|---|---|
| **Near-miss** | Humans | Concept model exists; execution error only (off-by-one, wrong size, deleted original after copy) |
| **Concept failure** | Programs | Concept model does not exist; output is uninterpretable as a rule application |

Across all 16 Core Knowledge concepts, human errors are near-misses. No program produces near-misses reliably — their errors indicate the concept was not grasped. Accuracy alone cannot capture this: a program can score above chance on some variations of "Copy" while having no mental model of copying.

**Why near-misses require model-building:** Near-miss production requires an internal representation of the goal that is structurally close-to-correct. Pattern matchers (heuristic pipelines over grid transformations) have no such representation — their outputs are search results, not model applications. An agent that near-misses on "Extend to Boundary" has a concept of extension and made a spatial slip; an agent whose output bears no resemblance to the rule lacked the concept.

**Concept-group methodology as diagnostic:** If a solver achieves high accuracy on some variations of a concept but fails others, it found a task-instance shortcut rather than the concept. Genuine concept abstraction predicts uniformly high accuracy across all 30 variations in a concept group.

---

## Autonomous Goal Inference (ARC-AGI-3 Extension)

ARC-AGI-3 reveals a fourth required capability not captured by Lake et al. 2016's three-ingredient model: the ability to infer the objective itself.

In ARC-AGI-1/2, task framing is provided (apply the demonstrated transformation to the test grid). In ARC-AGI-3, the agent receives only *"You are playing a game. Your goal is to win."* — it must determine what winning means by exploring the environment. This requires:
- A generative model not just of *how the world works* but of *what would constitute a desirable outcome*
- Hypothesis formation about goal structure, tested through actions
- Intrinsic exploration drive that does not depend on an external reward signal

**Operationalization:** Frontier AI scores <1% on ARC-AGI-3 vs. 100% human solvability (April 2026), despite frontier models solving ARC-AGI-1 at 87%+ when given explicit framing. The gap is not raw capability — it is autonomous objective inference in genuinely novel environments.

---

## Analogy as the Prototype Case (Holyoak 2012)

Analogical reasoning operationalizes abstract reasoning as a testable algorithm, revealing *how* model-building works at the task level. A single analogical problem requires:
- **Compositionality:** identify role-based relational structure (not feature similarity) between source and target
- **Causality:** use the causal model of the source to constrain which CWSG inferences about the target are licensed
- **Learning-to-learn:** schema induction from two compared analogs → reusable abstract relational category

**The retrieval gap as diagnostic:** people who can correctly map a remote source analog (once both analogs are in WM) nonetheless retrieve it from long-term memory only 12% of the time vs. 88% for near-domain analogs. This surface-retrieval bias is a precise marker of abstract-reasoning failure: the system has the mapping competence but the wrong retrieval signal. LLMs trained on next-token prediction replicate this bias structurally — far structural retrieval remains poor regardless of scale.

See [[wiki/concepts/analogical-reasoning.md]] for full treatment of the four-component process, CWSG, multiconstraint theory, and LISA model.

---

## Pattern Recognition as the Feedforward Boundary (DiCarlo et al. 2012)

Core object recognition — identifying objects across position, scale, pose, illumination, clutter — is solved by the ventral visual stream in ~150 ms via a largely feedforward cascade. No top-down feedback, no attention, no working memory is required for this regime. This operationalizes the pattern recognition pole of the Lake et al. distinction with unprecedented precision:

| Property | Core recognition (pattern recognition pole) | Abstract reasoning (model-building pole) |
|---|---|---|
| Time scale | ~150 ms, first-spike IT response | Hundreds of ms to minutes |
| Top-down feedback | Not required; feedforward suffices | Required: hypothesis-testing, attention, WM |
| Required memory | IT manifold geometry (learned over months) | Fast episodic M + slow structural W |
| Transfer to novel goals | Requires retraining (new task → new linear readout) | Immediate: same world model, new reward |
| Invariance type | Identity-preserving transformations (position, scale, pose) | Relational/structural transformations |

**Critical implication:** hierarchical feedforward processing is the substrate for *perceptual pattern recognition*. The additional cognitive machinery required for abstract reasoning — top-down hypothesis testing, reentrant processing, model-based inference — is precisely what the feedforward stream lacks. Any model that only implements the feedforward hierarchy has, by construction, only solved the perceptual end of this spectrum.

---

## Neural-Population Definition: Geometry of Abstraction (Bernardi et al. 2020)

Lake et al. 2016 defines abstraction at the computational/behavioral level. Bernardi et al. 2020 provide the complementary neural-population-level operationalization: **a variable is abstract when the cross-condition generalization performance (CCGP) of a linear decoder is significantly above chance**.

CCGP measures whether a linear decoder trained to classify a variable under one subset of conditions still works under a disjoint subset. High CCGP requires the population's coding direction for the variable to be *parallel* across all condition groupings. This is distinct from traditional decoding: a variable can be decoded within conditions yet have CCGP at chance (the coding direction rotates between condition sets).

**The CCGP/SD duality:** HPC, DLPFC, and ACC simultaneously achieve high CCGP for context, value, and action and near-maximal shattering dimensionality (SD = number of decodable dichotomies). A purely disentangled representation achieves high CCGP but severely low SD (XOR unseparable). The brain uses a *distorted* factorized geometry that preserves both — a direct constraint for reasoning model design.

**CCGP correlates with behavior:** on error trials, CCGP for context drops significantly in all three areas; traditional decoding accuracy does not. Abstraction of the latent variable — not mere decodability — tracks flexible behavioral performance.

See [[wiki/concepts/representational-geometry.md]] for the full CCGP/SD/PS framework.

---

## Formal Definition via AIXI

AIXI (Hutter 2000 [[wiki/papers/hutter-aixi-2000.md]]) provides the first formal definition of **general intelligence** as an order relation: system p is at least as intelligent as p' if p yields equal or higher ξ^AI-expected credit in every possible situation, for all environments. AIXI is the maximal element of this order — no unbiased system is more intelligent.

This grounds the abstract-reasoning ingredients computationally:

| Lake et al. ingredient | AIXI grounding | Why it emerges from 2^{-l(q)} prior |
|---|---|---|
| **Compositionality** | Compositional rules have compact programs; higher prior weight than lookup tables of equal capability | Shorter description = higher probability; combinatorial programs beat tabular enumeration exponentially |
| **Causality** | Causal world models have lower K(µ) than associative lookup tables; prior weight tracks generativity | The generative program is the shortest description of the distribution; AIXI discovers it |
| **Learning-to-learn** | A meta-program shared across tasks has a shorter description than N task-specific programs; prior weight ∝ sharing | K(task₁, task₂, ..., taskₙ \| shared structure) ≪ K(task₁) + ... + K(taskₙ) |
| **Autonomous goal inference** | The credit function c(·) is part of the environment model; AIXI must infer it alongside the transition model | In AIXI, µ encodes both transitions and rewards; environment with latent reward is a harder µ but within the computable class |

**ARC-AGI-3 maps exactly to the autonomous goal inference row.** Frontier AI fails at <1% not because it lacks world-modeling capability but because c(·) is not given externally — the reward structure must be inferred from exploratory interactions. This is the active-environment regime where K(µ)-bounded bounds don't apply, formally proven by AIXI theory.

---

## Open Problems

1. **Acquiring start-up software:** intuitive physics and psychology are structured domain priors — but how to acquire them computationally without hand-coding is unsolved. In the building-blocks model this maps to Blocks 1A+1B (structural scaffold that must exist before content binding begins).
2. **Efficient inference in structured models:** rich causal models are slow; amortized inference (a network trained to approximate the output of probabilistic inference) is the candidate solution — the fast model-free system trained on model-based rollouts.
3. **Multi-step causal chains:** ARC-AGI-2 (~4% AI vs. ~84% human) remains unsolved because it requires multiple interacting rules simultaneously; single-rule causal models are not sufficient.
4. **Autonomous goal inference:** even with correct causal world models, systems cannot determine what to optimize for without explicit instruction. ARC-AGI-3 operationalizes this gap: the model of the world and the model of desirable outcomes must be jointly inferred from environmental cues alone. No current architecture addresses this; it requires a goal-prior or intrinsic-motivation module (Block 3D) that is currently absent from all mainstream reasoning architectures.

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — structural generalization is the architectural implementation of abstract reasoning: factorized representations transfer the causal-structural model to new content instances without relearning; the graph formalism is the formal language for the causal model.
- **[[wiki/concepts/compositional-generalization.md]]** — compositionality is the first required ingredient; the five Hupkes et al. facets operationalize precisely how current systems fail to build combinatorial abstract representations, and why chunking is the failure mode.
- **[[wiki/concepts/meta-learning.md]]** — learning-to-learn is the third required ingredient; human-level transfer efficiency requires the slow outer loop to extract compositional+causal prior structure shared across tasks, not just surface statistics.
- **[[wiki/concepts/two-learning-timescales.md]]** — the W/M split is the computational implementation of model-building: slow W extracts the causal-structural model; fast M binds new instances to it within an episode; start-up software corresponds to the extreme-prior end of the slow-W spectrum.
- **[[wiki/entities/arc-agi.md]]** — primary operational benchmark; ARC-AGI-2 identifies three capability gaps (symbolic interpretation, compositional reasoning, contextual rule application); ARC-AGI-3 adds a fourth: autonomous goal inference without instruction, operationalizing the gap between model-building and pattern recognition at the level of objective formation, not just rule inference.
- **[[wiki/papers/arc-agi-overview.md]]** — Chollet's formal intelligence definition (skill-acquisition efficiency) is the quantitative operationalization of the model-building vs. pattern-recognition distinction.
- **[[wiki/papers/arc-agi-3-paper.md]]** — source for the autonomous goal inference gap; establishes that <1% frontier AI vs. 100% human on ARC-AGI-3 reflects the absence of autonomous objective inference and the LRM knowledge-boundedness constraint, not raw capability limitations.
- **[[wiki/papers/building-machine-thinks-like-people-lake-2016.md]]** — primary source; defines the pattern recognition / model-building distinction, the three required ingredients and their dependency, and the Characters + Frostbite diagnostic challenges.
- **[[wiki/concepts/analogical-reasoning.md]]** — analogy is the prototype case of abstract reasoning; the four-component process (retrieval→mapping→inference→schema induction) provides the algorithmic-level description of model-building; the retrieval gap is the key diagnostic of abstract-reasoning failure in current AI systems.
- **[[wiki/papers/analogy-holyoak-2012.md]]** — source for CWSG formalism, multiconstraint theory, LISA model, and frontopolar integration bottleneck; grounds the abstract-reasoning capability in a specific tested algorithm with neural correlates.
- **[[wiki/concepts/hierarchical-representations.md]]** — hierarchical feedforward representations are the substrate for pattern recognition; the feedforward/feedback distinction added here marks the boundary between what hierarchy alone can provide and what abstract reasoning additionally requires.
- **[[wiki/papers/dicarlo-visual-object-recognition-2012.md]]** — source for the feedforward/feedback operationalization; core recognition (~150 ms, no top-down) is the clearest biological instantiation of the pattern recognition pole of the Lake et al. distinction.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the lower-level problem formulation that grounds abstract reasoning computationally: causal model-building = discovering the latent graph (nodes, edges, topology) that generates observations, then using it to answer counterfactual and goal-flexible queries.
- **[[wiki/concepts/representational-geometry.md]]** — provides the neural-population-level operational definition of abstraction via CCGP; complements the Lake et al. computational/behavioral framing with a measurable geometric criterion for when a neural representation will generalize to novel conditions.
- **[[wiki/papers/hutter-aixi-2000.md]]** — provides the formal definition of general intelligence (order relation ⪰); the three Lake et al. ingredients emerge from the Kolmogorov simplicity prior; autonomous goal inference is the formal active-environment extension where K(µ)-bounded bounds break down.
- **[[wiki/entities/pgm-benchmark.md]]** — the Raven-style PGM benchmark operationalizes visual abstract reasoning with explicit (r,o,a) triple semantics and eight generalisation regimes; its composition-decomposition asymmetry is the clearest empirical instantiation of the Lake et al. compositionality gap.
- **[[wiki/papers/pgm-barrett-2018.md]]** — PGM provides an operational taxonomy of visual abstract reasoning failure: the composition-decomposition asymmetry (recombination of familiar primitives succeeds; genuinely novel primitive understanding fails near-chance) precisely instantiates the Lake et al. compositionality gap at the visual-relational level; the meta-target auxiliary training result supports the factorized-representation design requirement.
- **[[wiki/concepts/continual-learning.md]]** — abstract reasoning across episodes requires retaining prior causal models without catastrophic interference; the stability-plasticity trade-off is the temporal complement to compositionality/causality/learning-to-learn — a system that forgets its causal models after each episode cannot scaffold progressive abstraction or accumulate structured world knowledge.
- **[[wiki/papers/hassabis-neuroscience-ai-2017.md]]** — survey source identifying simulation-based planning (HC preplay → model-based rollouts) and efficient one-shot learning (episodic control) as the key architectural mechanisms for model-building; frames these as the two most concrete near-term neuro-inspired AI contributions beyond the attention/RL foundations already incorporated.
- **[[wiki/papers/conceptarc-moskvichev-2023.md]]** — provides the behavioral operationalization of model-building: human near-miss errors (concept grasped, execution wrong) vs. machine concept-failure errors (no concept model) are qualitatively distinct failure modes; the concept-group methodology establishes within-concept generalization as the evidence standard for genuine concept abstraction.
- **[[wiki/concepts/world-models.md]]** — world models are the mechanistic substrate for model-based reasoning; the LLM "shallow common sense" failure (§8.2.2 LeCun 2022) is traceable to the absence of a grounded world model; autonomous goal inference (open problem 4) additionally requires inferring the objective from the world model without external instruction.
- **[[wiki/entities/jepa-model.md]]** — Mode-2 planning in LeCun's architecture implements model-based reasoning as energy minimization over world-model trajectories; the Mode-1/Mode-2 dual process is a concrete implementation of the pattern-recognition/model-building distinction at the architecture level.
- **[[wiki/concepts/energy-based-models.md]]** — reasoning as energy minimization (constraint satisfaction) is the formal bridge between AIXI's optimal world model and differentiable neural architectures; any reasoning task expressible as constraints over world states can be formulated as EBM inference.
