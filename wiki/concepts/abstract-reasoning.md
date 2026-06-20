---
title: "Abstract Reasoning"
type: concept
tags: [abstract-reasoning, model-building, causal-models, compositionality, one-shot-learning]
created: 2026-06-20
updated: 2026-06-20 (3)
sources: [building_machine_that_thinks_like_people, ARC-AGI-3-paper.md, analogy_reasoning.md, How does the brain solve visual object recognition]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/meta-learning.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/hierarchical-representations.md, wiki/entities/arc-agi.md, wiki/papers/arc-agi-overview.md, wiki/papers/arc-agi-3-paper.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md, wiki/concepts/analogical-reasoning.md, wiki/papers/analogy-holyoak-2012.md, wiki/papers/dicarlo-visual-object-recognition-2012.md]
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
