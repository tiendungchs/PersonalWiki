---
title: "Abstract Reasoning"
type: concept
tags: [abstract-reasoning, model-building, causal-models, compositionality, one-shot-learning]
created: 2026-06-20
updated: 2026-07-08
sources: [building_machine_that_thinks_like_people, ARC-AGI-3-paper.md, analogy_reasoning.md, How does the brain solve visual object recognition, geometry-of-abstraction-bernardi-2020, raven, The ConceptARC Benchmark, A Path Towards Autonomous Machine Intelligence, shortcut learning.md, choi-intelligence-density-2026, beger-conceptarc-multimodal-2025, Evaluating Understanding on Conceptual Abstraction Benchmarks.md, math-dataset-hendrycks-2021, math-perturb-2025, verifiers-math-cobbe-2021, "The prefrontal cortex- categories, concepts and cognition", a-natural-history-of-the-human-mind, penn-darwins-mistake-2008]
related: [wiki/concepts/core-knowledge.md, wiki/papers/spelke-kinzler-core-knowledge-2007.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/meta-learning.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/continual-learning.md, wiki/entities/arc-agi.md, wiki/entities/pgm-benchmark.md, wiki/entities/frontiermath-benchmark.md, wiki/papers/arc-agi-overview.md, wiki/papers/arc-agi-3-paper.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md, wiki/concepts/analogical-reasoning.md, wiki/papers/analogy-holyoak-2012.md, wiki/papers/dicarlo-visual-object-recognition-2012.md, wiki/concepts/representational-geometry.md, wiki/papers/geometry-abstraction-bernardi-2020.md, wiki/papers/hutter-aixi-2000.md, wiki/papers/hassabis-neuroscience-ai-2017.md, wiki/papers/pgm-barrett-2018.md, wiki/papers/conceptarc-moskvichev-2023.md, wiki/concepts/world-models.md, wiki/entities/jepa-model.md, wiki/concepts/energy-based-models.md, wiki/papers/shortcut-learning-geirhos-2020.md, wiki/concepts/intelligence-density.md, wiki/concepts/shortcut-reasoning.md, wiki/papers/beger-conceptarc-multimodal-2025.md, wiki/papers/glazer-frontiermath-2024.md, wiki/papers/odouard-2022-concept-evaluation.md, wiki/papers/math-perturb-2025.md, wiki/papers/verifiers-math-cobbe-2021.md, wiki/papers/frontal-cortex-abstract-rules-badre2010.md, wiki/queries/reasoning-as-coupled-navigation-strategizing.md, wiki/papers/maclean-human-cognition-evolution-2016.md, wiki/concepts/convergent-allocentric-coding.md, wiki/concepts/neoteny.md, wiki/papers/sherwood-natural-history-mind-2008.md, wiki/concepts/cognitive-control.md, wiki/concepts/relational-reinterpretation.md, wiki/papers/penn-darwins-mistake-2008.md]
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

## Shortcut Learning and the I.I.D. / O.O.D. Gap (Geirhos et al. 2020)

Geirhos et al. ([[wiki/papers/shortcut-learning-geirhos-2020.md]]) formalise the decision-rule taxonomy that underlies the model-building / pattern-recognition distinction:

| Rule class | Performance | Generalises o.o.d.? |
|---|---|---|
| **Uninformative features** | Poor even on training data | — |
| **Overfitting solutions** | Good on training; fails i.i.d. test | No |
| **Shortcut solutions** | Good on i.i.d. test | No — exploits correlated spurious features |
| **Intended solution** | Good on i.i.d. test | Yes — uses causal / structural features |

**Pattern recognition = shortcut regime.** A system that achieves good benchmark accuracy via shortcuts has learned a decision rule that succeeds on identically-distributed test data but fails when spurious correlations are broken. This is precisely what ARC-AGI-2/3 are designed to expose: the jump from ARC-AGI-1 (~i.i.d. coverage attackable) to ARC-AGI-2/3 (structural novelty that breaks shortcuts) explains why o3 at 87% on ARC-1 collapses to ~7% on ARC-2 (llm-stats) and <1% on ARC-3 — later frontier models self-report ≤85% on ARC-2, but on closed, unverifiable systems.

**Inductive bias as the design lever.** Four factors determine which decision rule is easiest to learn: (a) **architecture** (hard constraints on representable functions), (b) **training data** (shortcut opportunities persist even at scale), (c) **loss function** (cross-entropy stops once any discriminative predictor is found), (d) **optimisation** (SGD biases toward simplest functions). Generative/world-model approaches (JEPA, PC, EBM) resist shortcuts because they must model the full data distribution — shortcut features alone do not span all training variation.

**Mathematical reasoning evidence (GSM-Symbolic/GSM-Plus 2024, MATH 2021, MATH-Perturb 2025).** The shortcut regime is confirmed across the full difficulty spectrum of formal mathematics:

- **Grade-school level (GSM-Symbolic/GSM-Plus):** GSM-Symbolic's GSM-NoOp variant causes avg 65% performance collapse across 25+ LLMs; GSM-Plus reversal perturbations cause up to 20% drops. Arithmetic accuracy remains 97–99%; the failure is structural.
- **Competition level (MATH 2021):** GPT-3 175B achieves 6.9%; extrapolating log-linear trends requires ~10^35 params to reach 40%. Training on ground-truth step-by-step solutions improves accuracy +10%; but model-generated CoT (Chain of Thought) at test time *decreases* accuracy — self-generated intermediate nodes are unreliable and propagate errors (self-poisoning failure mode).
- **Competition robustness (MATH-Perturb 2025):** state-of-the-art models suffer 12–28% drops on hard perturbations (structural edits requiring different solution strategies) vs. <5% on simple edits (surface changes). Dominant failure: subtle memorization — models apply techniques learned in training without assessing structural applicability, not verbatim copying. ([[wiki/papers/math-perturb-2025.md]])
- **Verifier asymmetry (Cobbe et al. 2021):** separating path generation from path evaluation yields a 30× effective size multiplier — a 6B verifier matches a finetuned 175B generator. Path evaluation is more learnable than path generation, consistent with the hypothesis that correctness structure is more regular than solution structure. ([[wiki/papers/verifiers-math-cobbe-2021.md]])

All four results share the same bottleneck: models cannot navigate the latent proof/computation graph structurally — they exploit surface correlations from training data instead of causal-structural reasoning.

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

## FrontierMath: Gap Generalizes Across Domains (Glazer et al. 2024)

FrontierMath ([[wiki/entities/frontiermath-benchmark.md]]) extends the ARC-AGI failure pattern to formal mathematical reasoning, providing the key cross-domain validation of the model-building gap.

| Feature | ARC-AGI-2 | FrontierMath |
|---|---|---|
| Domain | Visual grid tasks | Research-level mathematics |
| Prior knowledge required | Minimal (Core Knowledge priors only) | Maximal (deep domain expertise) |
| Failure mode | Structural rule inference from few examples | Domain-technique graph navigation with sparse vocabulary |
| SOTA performance | 24–54% verified; ≤85% self-reported (unverified) | <2% |

**The convergence is the key insight:** these two benchmarks represent opposite design extremes — ARC-AGI minimizes prior knowledge requirements, FrontierMath maximizes them — FrontierMath still yields <2%, and while verified/reproducible ARC-AGI-2 now reaches 24–54% (with unverifiable ≤85% closed-model self-reports), both remain far below human under cost-controlled reproducible evaluation. This isolates the shared bottleneck: the inability to infer and navigate latent relational structure. The gap is not about how much domain knowledge a system has, but whether it can discover and use the structural graph that organizes that knowledge.

**Different failure modes, same ceiling.** ARC-AGI fails because systems cannot infer novel transformation rules from a handful of grid examples. FrontierMath fails because systems cannot identify which theorems from a vast but sparsely-covered domain are relevant to a specific problem and how to chain them. The surface causes differ; the underlying latent graph discovery deficit is the same.

---

## Rule-Level Evaluation: Accuracy ≠ Abstraction (Beger et al. 2025)

Beger et al. ([[wiki/papers/beger-conceptarc-multimodal-2025.md]]) extend ConceptARC evaluation beyond output-grid accuracy by requiring models to also generate natural-language rules explaining each solution. Rule-grid alignment exceeds 90% across all models and settings, validating NL rules as faithful proxies for underlying reasoning.

**Accuracy is directionally misleading by modality:**

| Setting | Accuracy bias | Mechanism |
|---|---|---|
| Textual modality | Overestimates abstraction | Shortcuts (integer color encodings, bounding boxes, connectivity) achieve correct outputs without correct concepts |
| Visual modality | Underestimates abstraction | Perceptual failures (wrong grid size, misplaced objects) cause incorrect outputs even when the correct-intended rule was formed |

**Shortcut rate on textual ConceptARC:**

| System | Correct-intended (of correct outputs) | Correct-unintended (shortcuts) |
|---|---|---|
| Humans | ~90.3% | ~4.6% |
| o3 (medium + tools) | ~57% | ~29% |
| Claude Sonnet 4 | ~44% + | ~5% |
| Gemini 2.5 Pro | ~44% | ~12% |

**Visual modality gap is perceptual, not conceptual.** In wrong-grid visual cases, o3 produces correct-intended rules ~28% of the time — the model understood the concept but could not perceive the grid accurately enough to apply it. Visual errors (wrong dimensions, misplaced objects) occur in 49–77% of visual cases. Python tools (computer vision libraries) partially compensate.

**Missing objectness prior.** The dominant shortcut pattern across all models and concept groups is treating grids as pixel matrices rather than scenes of discrete objects. AI models lack Spelke's Core Knowledge objectness prior (objects persist, move coherently, have boundaries). Token-prediction training does not acquire this prior; it must be architecturally encoded.

See [[wiki/concepts/shortcut-reasoning.md]] for the ARC-domain shortcut catalogue and broader taxonomy.

---

## Concept-Based Evaluation (Odouard & Mitchell 2022)

**Understanding a concept = competence for generating infinite conceptualizations (Barsalou).** IID test splits test a single concept instantiation — necessary but insufficient. Concept-based evaluation probes OOD variations of the *same* concept across different attributes and contexts, deliberately violating the IID assumption to expose shortcut solutions ([[wiki/papers/odouard-2022-concept-evaluation.md]]).

RAVEN experiments: MRNet 73% → 49%/44%, SCL 89% → 62%/68% on Sameness/Progression concept probes — benchmark accuracy overestimates conceptual understanding by ~20–25 pp. ARC-Kaggle2nd per-concept breakdown (top/bottom 29%, boundary 8% vs. 19% overall) shows concept understanding is uneven even when overall benchmark performance is positive. This methodology was formalized as ConceptARC (below).

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

## Step-Wise Learning Curves as Neural Signature of Rule Discovery (Badre et al. 2010)

The model-building/pattern-recognition distinction produces a measurable difference in the *temporal dynamics* of learning, complementing the error-structure diagnostic from ConceptARC.

**Two learning regimes:**

| Regime | Learning curve shape | Sigmoid α | Sigmoid β | Mechanism |
|---|---|---|---|---|
| Abstract rule learning (Hierarchical) | Step-wise jump | Large (steep step) | Small (early) | Higher-order rule discovered → all subsumed lower-order rules immediately available |
| Rote association (Flat) | Gradual monotone | Small (shallow ramp) | Large (late) | Each rule must be learned independently, one by one |

Both α (p<0.01) and β (p<0.005) differ significantly. Crucially, the step-wise jump is specifically faster for 1st-order rules that are *members of a known 2nd-order set* — not for Hierarchical rules generally (rules not subsumed by a known 2nd-order rule learn at the same rate as Flat rules). The learning benefit is structural, not generic familiarity.

**Behavioral efficiency numbers:** Terminal accuracy 84% Hierarchical vs. 58% Flat; 72% vs. 43% of individual rules learned. This efficiency gain directly results from compression: 9 individual rules become learnable as consequences of a single 2nd-order rule.

**Neural substrate:** prePMd (~BA6/44) is active from trial 1 of learning — before any 2nd-order rule is known — and its early activation predicts subsequent rule discovery (r=0.51–0.56). prePMd is the neural substrate of the *search* for higher-order rules, not only their execution. When no higher-order rule exists (Flat condition), prePMd activity declines to baseline by the Middle phase — reward-gated suppression of the unproductive higher-level search.

**Design implication:** A reasoning model that discovers abstract rules should produce step-wise learning curves as a byproduct of its architecture. If a model only produces gradual curves even on Hierarchical-type tasks, it is likely learning each instance independently rather than discovering the compressing abstraction. Step-wise curve shape is an architectural diagnostic for genuine rule compression, not just accuracy measurement.

See [[wiki/papers/frontal-cortex-abstract-rules-badre2010.md]] for experimental details.

---

## Abstract Rules as Compression; Categories as Discretization (Miller et al. 2002)

Single-neuron PFC evidence ([[wiki/papers/pfc-categories-concepts-miller-2002.md]]) grounds two of the required ingredients — compositionality and one-shot transfer — in a concrete neural mechanism.

**Rule abstraction = compression (the learning-shortcut argument).** In the Wallis et al. (2001) match/non-match task, a monkey could in principle solve the task as 16 cue-specific paired associates. Abstracting *two rules* (match, non-match) that apply regardless of stimulus reduces this to a constant description length and — critically — transfers to *first-ever-seen* stimuli with no new learning. This is the behavioral instantiation of the intelligence-density claim ([[wiki/concepts/intelligence-density.md]]): a finite rule generalizes over an unbounded stimulus set, whereas the lookup-table (paired-associate) solution grows with the domain and never transfers. The neural signature is that single PFC neurons encode the rule independent of cue, stimulus, response, and reward — the abstraction is carved into the code, not emergent only at the population readout.

**Categorical perception = discretization into sharp-boundary symbols.** In the cat/dog DMC task (Freedman et al. 2001), a continuous morph space is mapped to two categories with a *sharp* boundary at the single-neuron level: 60/40 dog-like cats are coded like prototype cats, not like the physically-more-similar cat-like dogs just across the boundary. Retraining on orthogonal boundaries re-partitions the tuning. This is a candidate mechanism for the missing step between continuous perception and symbolic reasoning — turning a similarity continuum into a discrete, behaviorally-defined, *learnable and re-partitionable* symbol alphabet. It bears directly on the vocabulary co-discovery gap (Gap #3): the "symbols" a reasoner manipulates need not be given — categorical tuning shows they can be induced from task-relevant experience, with boundaries set by behavioral relevance rather than physical distance.

**Caveat:** these rules are shallow (single match/non-match), with no nesting or compositional chaining; Miller et al. supply the atomic discretization + single-rule abstraction, while Badre et al. 2010 (above) supply the multi-level hierarchical discovery that composes them.

---

## Autonomous Goal Inference (ARC-AGI-3 Extension)

ARC-AGI-3 reveals a fourth required capability not captured by Lake et al. 2016's three-ingredient model: the ability to infer the objective itself.

In ARC-AGI-1/2, task framing is provided (apply the demonstrated transformation to the test grid). In ARC-AGI-3, the agent receives only *"You are playing a game. Your goal is to win."* — it must determine what winning means by exploring the environment. Crucially, **even the action semantics are latent**: the effect of each action is undefined and varies per game, so the agent must simultaneously discover *what its actions do* and *what state they should reach*. This requires:
- A generative model not just of *how the world works* but of *what would constitute a desirable outcome* — built from scratch through exploration, since actions change the environment state and their meaning must be learned by probing
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

CCGP measures whether a linear decoder trained to classify a variable under one subset of conditions still works under a disjoint subset. High CCGP (Cross-Condition Generalization Performance) requires the population's coding direction for the variable to be *parallel* across all condition groupings. This is distinct from traditional decoding: a variable can be decoded within conditions yet have CCGP (Cross-Condition Generalization Performance) at chance (the coding direction rotates between condition sets).

**The CCGP (Cross-Condition Generalization Performance)/SD duality:** HPC, DLPFC, and ACC (Anterior Cingulate Cortex) simultaneously achieve high CCGP (Cross-Condition Generalization Performance) for context, value, and action and near-maximal shattering dimensionality (SD = number of decodable dichotomies). A purely disentangled representation achieves high CCGP (Cross-Condition Generalization Performance) but severely low SD (Shattering Dimensionality) (XOR unseparable). The brain uses a *distorted* factorized geometry that preserves both — a direct constraint for reasoning model design.

**CCGP correlates with behavior:** on error trials, CCGP (Cross-Condition Generalization Performance) for context drops significantly in all three areas; traditional decoding accuracy does not. Abstraction of the latent variable — not mere decodability — tracks flexible behavioral performance.

See [[wiki/concepts/representational-geometry.md]] for the full CCGP (Cross-Condition Generalization Performance)/SD/PS framework.

---

## Formal Definition via AIXI (AI with (X) induction (I))

AIXI (Hutter 2000 [[wiki/papers/hutter-aixi-2000.md]]) provides the first formal definition of **general intelligence** as an order relation: system p is at least as intelligent as p' if p yields equal or higher ξ^AI-expected credit in every possible situation, for all environments. AIXI (AI with (X) induction (I)) is the maximal element of this order — no unbiased system is more intelligent.

This grounds the abstract-reasoning ingredients computationally:

| Lake et al. ingredient | AIXI (AI with (X) induction (I)) grounding | Why it emerges from 2^{-l(q)} prior |
|---|---|---|
| **Compositionality** | Compositional rules have compact programs; higher prior weight than lookup tables of equal capability | Shorter description = higher probability; combinatorial programs beat tabular enumeration exponentially |
| **Causality** | Causal world models have lower K(µ) than associative lookup tables; prior weight tracks generativity | The generative program is the shortest description of the distribution; AIXI (AI with (X) induction (I)) discovers it |
| **Learning-to-learn** | A meta-program shared across tasks has a shorter description than N task-specific programs; prior weight ∝ sharing | K(task₁, task₂, ..., taskₙ \| shared structure) ≪ K(task₁) + ... + K(taskₙ) |
| **Autonomous goal inference** | The credit function c(·) is part of the environment model; AIXI (AI with (X) induction (I)) must infer it alongside the transition model | In AIXI (AI with (X) induction (I)), µ encodes both transitions and rewards; environment with latent reward is a harder µ but within the computable class |

**ARC-AGI-3 maps exactly to the autonomous goal inference row.** Frontier AI fails at <1% not because it lacks world-modeling capability but because c(·) is not given externally — the reward structure must be inferred from exploratory interactions. This is the active-environment regime where K(µ)-bounded bounds don't apply, formally proven by AIXI (AI with (X) induction (I)) theory.

---

## Intelligence Density: Formal Criterion for Knowing (Choi 2026)

$\mathcal{I}(n) \to \infty$ as domain scales is a **formal sufficient criterion for abstract reasoning** [[wiki/concepts/intelligence-density.md]]: a system with fixed description length that handles an unbounded input domain must generalise via algorithms, not lookup tables (Proposition 1). This makes the memorisation/knowing distinction operationally testable.

| Decision rule | $\mathcal{I}$ scaling | Abstract reasoning? |
|---|---|---|
| Lookup table / memorisation | $\to 0$ | No |
| Hardware family (different circuit per input size) | $\Theta(1)$ | No — computes but does not know |
| Algorithm / generalising system | $\to \infty$ | Yes |

**Architectural implication:** feedforward networks have bounded computation depth for any fixed architecture, so their domain is bounded → $\mathcal{I} = \Theta(1)$ at best. Recurrent or iterative networks can scale depth with problem size → $\mathcal{I}$ can diverge. Recurrence is the minimal architectural condition for *knowing* a domain — not Turing completeness, but the weaker property of handling an unbounded input space with finite code.

**Complement to AIXI (AI with (X) induction (I)):** AIXI (AI with (X) induction (I)) gives the theoretical ceiling for general intelligence; $\mathcal{I}$ gives a measurable criterion (via computable $K$ approximations) for whether a system has crossed the knowing threshold. Under evolutionary selection with a fixed reward, Legg-Hutter $\Upsilon(\pi)$ is monotonically increasing in $\mathcal{I}(\pi)$ (Proposition 2), formally unifying both measures with Chollet's skill-acquisition efficiency.

---

## Which Brain to Model? The Constellation Problem (MacLean 2016)

"Brain-inspired" underspecifies the target: many animals with brains cannot do abstract reasoning, so *which* brain (or which mix) to model is itself a design choice. MacLean 2016 ([[wiki/papers/maclean-human-cognition-evolution-2016.md]]) argues human cognition is a **constellation** — a synergy of *representational* traits (theory of mind, shared intentionality) and *motivational* traits (prosocial/cooperative drive) — "unlikely to be accounted for by changes to any singular cognitive system." This cuts against the scale-one-module thesis.

Two consequences for model design:
- **No single animal has the whole constellation**, but its components appear as homologies and (more usefully) **analogies from convergent evolution** scattered across taxa — mirroring the spatial-coding case in [[wiki/concepts/convergent-allocentric-coding.md]]. One may compose the target from multiple convergent solutions rather than copying one lineage.
- **The systemizing axis is (partly) dissociable from the social stack.** Baron-Cohen's *systemizing* (analyzing the world as lawful, deterministic rules — spatial cognition, tool use, causal reasoning; chimpanzee-leaning) vs. *empathizing* (theory-of-mind; bonobo-leaning) suggests the rule-extraction capacity central to abstract reasoning need not require full human sociality. **Caveat:** human *cumulative culture* — not a bigger solitary reasoner — is the actual engine (a culture-deprived human ≈ a great ape), so social learning + external transmission may be a necessary scaffold rather than an optional extra (relevant to tool use, external memory, and multi-agent designs).

See also [[wiki/concepts/neoteny.md]] for the developmental-timing lever (heterochrony/self-domestication) that shifts capability without changing the hardware.

---

## Modules vs. Reweighted Primitives; Latent-Cause Binding (Sherwood et al. 2008)

Sherwood et al. ([[wiki/papers/sherwood-natural-history-mind-2008.md]]) supply two design-relevant claims about *where* human abstract reasoning comes from.

**Emergence over module-addition.** Human reasoning specializations are *not* new domain-specific cortical modules — macaque homologues exist for ~all human cortical areas, and total prefrontal fraction is at ape-scaling predictions. The proposed mechanism is quantitative **reweighting of domain-general primitives** (attention, executive control, WM, inhibition) amplified through an extended plastic window (see [[wiki/concepts/neoteny.md]]). Design consequence: the pattern-recognition→model-building gap may be closable by a schedule that reweights general primitives, not by bolting on a bespoke "reasoning module" — the constellation/emergence complement to MacLean's which-brain-to-model argument.

**The observable-feature / unobservable-cause decoupling (Povinelli).** The crux of causal reasoning is binding *observable correlates* to *latent causal variables* — and these can dissociate. An agent may reason adeptly about "eyes" (observable) while never representing "seeing" (the unobservable state), behaving indistinguishably from one that does. This is the precise mechanism behind the shortcut/model-building split: a shortcut learner binds decisions to observable surface features; a model-builder binds them to inferred hidden causes. Sherwood et al. add the enabling primitive — **inhibitory "cognitive self-control"**: reasoning about hidden causes requires *inhibiting stereotyped responses to superficially similar stimuli*, treating them differently when the inferred cause differs (see [[wiki/concepts/cognitive-control.md]]). Surface-feature capture is the failure to inhibit; latent-cause inference is what inhibition buys.

---

## Comparative Grounding: Relational Reinterpretation (Penn et al. 2008)

Comparative cognition supplies the phylogenetic version of the model-building/pattern-recognition split and a sharper *representational-level* target. Penn, Holyoak & Povinelli's **relational reinterpretation** hypothesis ([[wiki/concepts/relational-reinterpretation.md]]): all animals build functionally compositional, *featurally* systematic representations of first-order perceptual relations (pattern recognition); only humans reinterpret these as higher-order, role-governed, explicitly structural relations approximating a Physical Symbol System (model-building).

Two contributions that refine this page:
- **A deeper account of the shortcut/pattern-recognition pole.** "Pattern recognition" is not merely surface-feature classification — it is **conceptual chunking**: collapsing a relation into an analog scalar (Shannon entropy of variability) and applying conditional discrimination. Non-human minds pass same/different and relational-match tasks this way (16-item easier than 2-item; "different"-at-2-items collapses). This is the representational root of every shortcut in [[wiki/concepts/shortcut-reasoning.md]].
- **A precise specification of what model-building must add.** Not one capability but four PSS features System-1 lacks: role-filler independence, type/token separation, concatenative (not merely functional) composition, and classical (structural, domain-independent) systematicity. Each is separately testable — a system can have featural systematicity (transformers do) while failing all four. The [[wiki/entities/lisa-model.md]] "graft" is the existence proof that these can be added on a neural substrate, and the argument that they do not emerge from scale alone.

---

## Open Problems

1. **Acquiring start-up software:** intuitive physics and psychology are structured domain priors — the four Core Knowledge systems (objects/agents/number/geometry; [[wiki/concepts/core-knowledge.md]]) — but how to acquire them computationally without hand-coding is unsolved. In the building-blocks model this maps to Blocks 1A+1B (structural scaffold that must exist before content binding begins).
2. **Objectness prior acquisition:** discriminative token-prediction training does not produce objectness representations; models default to pixel/connectivity shortcuts. A structured world model explicitly representing discrete entities (as in TEM's p = f(g, x)) is required, but how to acquire this representation from naturalistic data is open.
3. **Efficient inference in structured models:** rich causal models are slow; amortized inference (a network trained to approximate the output of probabilistic inference) is the candidate solution — the fast model-free system trained on model-based rollouts.
4. **Multi-step causal chains:** ARC-AGI-2 (verified 24–54% vs. ~84% human) remains far from solved because it requires multiple interacting rules simultaneously; single-rule causal models are not sufficient.
5. **Autonomous goal inference:** even with correct causal world models, systems cannot determine what to optimize for without explicit instruction. ARC-AGI-3 operationalizes this gap: the model of the world and the model of desirable outcomes must be jointly inferred from environmental cues alone. No current architecture addresses this; it requires a goal-prior or intrinsic-motivation module (Block 3D) that is currently absent from all mainstream reasoning architectures. A candidate mechanism — dopamine's dual role (RPE + novelty) bootstrapping a goal from scalar valence into a structured g-space target, with learning-progress/empowerment as the intrinsic reward substituting for the missing external verifier — is worked out in [[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]].

---

## Connections

- **[[wiki/concepts/core-knowledge.md]]** — Spelke's four core-knowledge systems are the "start-up software" (open problem #1): the innate domain-specific priors abstract reasoning builds on but that discriminative token-prediction training does not acquire; the extreme-prior end of the slow-W spectrum.
- **[[wiki/papers/spelke-kinzler-core-knowledge-2007.md]]** — primary source for the core-knowledge theory that grounds the "start-up software" open problem and ARC-AGI's prior budget.
- **[[wiki/concepts/structural-generalization.md]]** — structural generalization is the architectural implementation of abstract reasoning: factorized representations transfer the causal-structural model to new content instances without relearning; the graph formalism is the formal language for the causal model.
- **[[wiki/concepts/compositional-generalization.md]]** — compositionality is the first required ingredient; the five Hupkes et al. facets operationalize precisely how current systems fail to build combinatorial abstract representations, and why chunking is the failure mode.
- **[[wiki/concepts/meta-learning.md]]** — learning-to-learn is the third required ingredient; human-level transfer efficiency requires the slow outer loop to extract compositional+causal prior structure shared across tasks, not just surface statistics.
- **[[wiki/concepts/two-learning-timescales.md]]** — the W/M split is the computational implementation of model-building: slow W extracts the causal-structural model; fast M binds new instances to it within an episode; start-up software corresponds to the extreme-prior end of the slow-W spectrum.
- **[[wiki/entities/arc-agi.md]]** — primary operational benchmark; ARC-AGI-2 identifies three capability gaps (symbolic interpretation, compositional reasoning, contextual rule application); ARC-AGI-3 adds a fourth: autonomous goal inference without instruction, operationalizing the gap between model-building and pattern recognition at the level of objective formation, not just rule inference.
- **[[wiki/papers/arc-agi-overview.md]]** — Chollet's formal intelligence definition (skill-acquisition efficiency) is the quantitative operationalization of the model-building vs. pattern-recognition distinction.
- **[[wiki/papers/arc-agi-3-paper.md]]** — source for the autonomous goal inference gap; establishes that <1% frontier AI vs. 100% human on ARC-AGI-3 reflects the absence of autonomous objective inference and the LRM (Large Reasoning Model) knowledge-boundedness constraint, not raw capability limitations.
- **[[wiki/papers/building-machine-thinks-like-people-lake-2016.md]]** — primary source; defines the pattern recognition / model-building distinction, the three required ingredients and their dependency, and the Characters + Frostbite diagnostic challenges.
- **[[wiki/concepts/analogical-reasoning.md]]** — analogy is the prototype case of abstract reasoning; the four-component process (retrieval→mapping→inference→schema induction) provides the algorithmic-level description of model-building; the retrieval gap is the key diagnostic of abstract-reasoning failure in current AI systems.
- **[[wiki/papers/analogy-holyoak-2012.md]]** — source for CWSG formalism, multiconstraint theory, LISA model, and frontopolar integration bottleneck; grounds the abstract-reasoning capability in a specific tested algorithm with neural correlates.
- **[[wiki/concepts/hierarchical-representations.md]]** — hierarchical feedforward representations are the substrate for pattern recognition; the feedforward/feedback distinction added here marks the boundary between what hierarchy alone can provide and what abstract reasoning additionally requires.
- **[[wiki/papers/dicarlo-visual-object-recognition-2012.md]]** — source for the feedforward/feedback operationalization; core recognition (~150 ms, no top-down) is the clearest biological instantiation of the pattern recognition pole of the Lake et al. distinction.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the lower-level problem formulation that grounds abstract reasoning computationally: causal model-building = discovering the latent graph (nodes, edges, topology) that generates observations, then using it to answer counterfactual and goal-flexible queries.
- **[[wiki/concepts/representational-geometry.md]]** — provides the neural-population-level operational definition of abstraction via CCGP (Cross-Condition Generalization Performance); complements the Lake et al. computational/behavioral framing with a measurable geometric criterion for when a neural representation will generalize to novel conditions.
- **[[wiki/papers/hutter-aixi-2000.md]]** — provides the formal definition of general intelligence (order relation ⪰); the three Lake et al. ingredients emerge from the Kolmogorov simplicity prior; autonomous goal inference is the formal active-environment extension where K(µ)-bounded bounds break down.
- **[[wiki/entities/pgm-benchmark.md]]** — the Raven-style PGM (Progressive Generalization Matrix) benchmark operationalizes visual abstract reasoning with explicit (r,o,a) triple semantics and eight generalisation regimes; its composition-decomposition asymmetry is the clearest empirical instantiation of the Lake et al. compositionality gap.
- **[[wiki/papers/pgm-barrett-2018.md]]** — PGM (Progressive Generalization Matrix) provides an operational taxonomy of visual abstract reasoning failure: the composition-decomposition asymmetry (recombination of familiar primitives succeeds; genuinely novel primitive understanding fails near-chance) precisely instantiates the Lake et al. compositionality gap at the visual-relational level; the meta-target auxiliary training result supports the factorized-representation design requirement.
- **[[wiki/concepts/continual-learning.md]]** — abstract reasoning across episodes requires retaining prior causal models without catastrophic interference; the stability-plasticity trade-off is the temporal complement to compositionality/causality/learning-to-learn — a system that forgets its causal models after each episode cannot scaffold progressive abstraction or accumulate structured world knowledge.
- **[[wiki/papers/hassabis-neuroscience-ai-2017.md]]** — survey source identifying simulation-based planning (HC preplay → model-based rollouts) and efficient one-shot learning (episodic control) as the key architectural mechanisms for model-building; frames these as the two most concrete near-term neuro-inspired AI contributions beyond the attention/RL foundations already incorporated.
- **[[wiki/papers/conceptarc-moskvichev-2023.md]]** — provides the behavioral operationalization of model-building: human near-miss errors (concept grasped, execution wrong) vs. machine concept-failure errors (no concept model) are qualitatively distinct failure modes; the concept-group methodology establishes within-concept generalization as the evidence standard for genuine concept abstraction.
- **[[wiki/concepts/world-models.md]]** — world models are the mechanistic substrate for model-based reasoning; the LLM "shallow common sense" failure (§8.2.2 LeCun 2022) is traceable to the absence of a grounded world model; autonomous goal inference (open problem 4) additionally requires inferring the objective from the world model without external instruction.
- **[[wiki/entities/jepa-model.md]]** — Mode-2 planning in LeCun's architecture implements model-based reasoning as energy minimization over world-model trajectories; the Mode-1/Mode-2 dual process is a concrete implementation of the pattern-recognition/model-building distinction at the architecture level.
- **[[wiki/concepts/energy-based-models.md]]** — reasoning as energy minimization (constraint satisfaction) is the formal bridge between AIXI (AI with (X) induction (I))'s optimal world model and differentiable neural architectures; any reasoning task expressible as constraints over world states can be formulated as EBM (Energy-Based Model) inference.
- **[[wiki/papers/shortcut-learning-geirhos-2020.md]]** — formalises the i.i.d./o.o.d. decision-rule taxonomy: shortcut solutions pass i.i.d. tests but fail o.o.d.; the intended solution is what ARC-AGI and abstract reasoning demand; the four-factor inductive-bias decomposition (architecture, data, loss, optimisation) is the design space for shortcut avoidance.
- **[[wiki/concepts/intelligence-density.md]]** — $\mathcal{I}(n) \to \infty$ is the formal information-theoretic criterion for abstract reasoning: finite mechanism, infinite domain; the four-way taxonomy (rock → lookup table → hardware family → algorithm) directly operationalises the pattern-recognition/model-building distinction at the Kolmogorov level.
- **[[wiki/concepts/shortcut-reasoning.md]]** — synthesizes three papers (Geirhos 2020, Yuan 2024, Beger 2025) into a unified account of how shortcut solutions arise; the ARC-domain shortcut catalogue (integer encodings, bounding boxes, connectivity, density) identifies the specific features that substitute for objectness-based reasoning.
- **[[wiki/papers/beger-conceptarc-multimodal-2025.md]]** — dual-channel evaluation methodology (accuracy + rule quality) reveals that accuracy is directionally misleading by modality; rule-level analysis is the operationalization of the model-building/pattern-recognition distinction at the individual-task level.
- **[[wiki/entities/frontiermath-benchmark.md]]** — cross-domain validation: research-level mathematics shows a persistent frontier-AI gap like ARC-AGI-2's (verified 24–54% vs. ~84% human) despite opposite prior knowledge requirements — confirming the bottleneck is latent structure inference, not knowledge quantity.
- **[[wiki/papers/glazer-frontiermath-2024.md]]** — source for FrontierMath benchmark construction, 3-axis difficulty decomposition, and model results; the <2% SOTA ceiling is the formal mathematics counterpart to ARC-AGI-2's verified 24–54% (≤85% self-reported but unverified).
- **[[wiki/papers/odouard-2022-concept-evaluation.md]]** — introduces concept-based evaluation (OOD concept variations as understanding probe) and provides the earliest empirical demonstration of the concept-shortcut gap on RAVEN/ARC; directly precedes ConceptARC, which formalized this methodology into a systematic 16-concept benchmark.
- **[[wiki/papers/math-perturb-2025.md]]** — MATH-Perturb's hard perturbations (12–28% drops vs. <5% on surface edits) empirically show that high benchmark accuracy does not imply structural robustness; the subtle memorization failure mode (technique-without-structural-check) is a mathematical instantiation of shortcut learning.
- **[[wiki/papers/verifiers-math-cobbe-2021.md]]** — verifier training shows path evaluation is more learnable than path generation (30× size multiplier), revealing that correctness structure is more regular than solution structure — relevant to the model-building / pattern-recognition distinction.
- **[[wiki/papers/pfc-categories-concepts-miller-2002.md]]** — single-neuron grounding of two required ingredients: abstract rule = compression (2 rules replace 16 paired associates; transfers to novel stimuli), and categorical perception = discretization of a continuous morph space into sharp-boundary, learnable, re-partitionable symbols (bears on the vocabulary co-discovery gap).
- **[[wiki/papers/frontal-cortex-abstract-rules-badre2010.md]]** — neural and behavioral evidence that abstract rule acquisition produces step-wise sigmoid learning curves (large α, small β) whereas rote association produces gradual curves; the step-wise jump is structurally selective (only for rules subsumed by a known 2nd-order rule) — an architectural diagnostic for genuine rule compression vs. independent rote learning.
- **[[wiki/papers/maclean-human-cognition-evolution-2016.md]]** — the "which brain to model" / constellation argument: human cognition is a synergy of representational + motivational traits, no single animal has all of it, and the systemizing (rule-extraction) axis is partly dissociable from the social stack.
- **[[wiki/concepts/convergent-allocentric-coding.md]]** — the comparative "which substrate" case for spatial world-modeling; the constellation argument generalizes the same which-brain-to-model logic to the full trait set.
- **[[wiki/concepts/neoteny.md]]** — developmental-timing lever: heterochrony/self-domestication shifts attainable cognition without changing the hardware; the plastic window is a candidate substrate for accumulating compositional/causal priors.
- **[[wiki/papers/sherwood-natural-history-mind-2008.md]]** — source for the modules-vs-reweighted-primitives (emergence) thesis and the observable-feature/unobservable-cause decoupling; grounds the shortcut/model-building split in latent-cause binding and inhibitory cognitive self-control.
- **[[wiki/concepts/relational-reinterpretation.md]]** — the comparative-cognition grounding of the model-building/pattern-recognition split: role-based reinterpretation is model-building, feature-based chunking is pattern recognition; specifies the four PSS features (role-filler independence, type/token, concatenative composition, classical systematicity) that model-building must add.
- **[[wiki/papers/penn-darwins-mistake-2008.md]]** — source for the relational reinterpretation hypothesis, conceptual chunking, and the degree→kind logic linking representational-level PSS approximation to functional-level reasoning differences.
- **[[wiki/concepts/recursion.md]]** — recursion (FLN, Hauser-Chomsky-Fitch 2002) is the candidate uniquely-human combinatorial engine that composes the largely-shared FLB perceptual/semantic modules; maps onto the model-building-vs-pattern-recognition split as the operator that makes composition productive rather than associative.
- **[[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]]** — supplies the dynamics behind two open problems here: (Problem 5) how the Block-3D intrinsic-motivation module bootstraps a latent goal via DA's dual role + learning-progress/empowerment; and (the MATH self-poisoning note) why Phase-2 imitation must be sandwiched by self-supervised pretraining and verifier-gated practice. Also frames the model-building/pattern-recognition transition as *compilation*: effortful dual-system search caching into fast System-1 intuition via replay→schema consolidation.
