---
title: "State-of-the-Art Review: Brain-Inspired Architectures for Abstract Reasoning via Latent Graph Discovery"
type: query
tags: [review, state-of-the-art, abstract-reasoning, latent-graph-discovery, brain-inspired-ai, rationale]
created: 2026-07-02
updated: 2026-07-08
sources: []
related: [wiki/overview.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/planning-as-inference.md, wiki/concepts/neural-manifolds.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/intelligence-density.md, wiki/concepts/memory-schemas.md, wiki/concepts/world-models.md, wiki/concepts/refinement-loops.md, wiki/entities/tem-model.md, wiki/entities/arc-agi.md, wiki/entities/spacetime-attractor.md, wiki/entities/vsa-model.md, wiki/entities/jepa-model.md, wiki/entities/vl-jepa-model.md, wiki/entities/dinov2-model.md, wiki/entities/dinov3-model.md, wiki/entities/equilibrium-propagation.md, wiki/entities/baba-is-ai.md, wiki/entities/frontiermath-benchmark.md, wiki/entities/pgm-benchmark.md, wiki/entities/gpqa-benchmark.md, wiki/entities/olymmath.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/queries/brain-inspired-vs-solver-approach.md, wiki/papers/math-reasoning-survey-2026.md, wiki/queries/reasoning-as-coupled-navigation-strategizing.md, wiki/concepts/relational-reinterpretation.md, wiki/concepts/recursion.md, wiki/concepts/core-knowledge.md]
---

# State-of-the-Art Review: Brain-Inspired Architectures for Abstract Reasoning via Latent Graph Discovery

> **Purpose of this document.** A self-contained review of the field as it stands, written to lay out the foundation for a specific methodological direction and to justify the design choices that follow from it. It synthesises the wiki's concept, entity, and paper pages into a single narrative: what the target capability is, why current systems fail to reach it, what neuroscience contributes as a blueprint, and — given all of this — which architectural path is best supported by the evidence. Citations are given as *(Author et al. year)* for later completion.

---

## Abstract

Deep learning has saturated most i.i.d. benchmarks yet still fails at out-of-distribution *systematic generalization* — the ability to recombine known structure in novel ways. Human and animal brains do not share this failure. This review argues that (i) the diverse tasks grouped under "abstract reasoning" reduce to a single computational problem, **latent graph discovery** — inferring the hidden relational structure of a domain from observations and then navigating it; (ii) the reason current architectures fail is not scale or data but a missing *inductive structure* — specifically the factorization of relational structure from sensory content, which places the required generalization outside a monolithic model's reachable manifold *by construction*; and (iii) the mammalian entorhinal–hippocampal–prefrontal (MEC/HC/PFC) system provides a validated, convergent blueprint for the missing structure. We review the benchmark evidence isolating the bottleneck (ARC-AGI, FrontierMath, PGM, ConceptARC, Baba Is AI), the brain-inspired principles that address it, and the biologically-plausible learning algorithms that could train such a system. We conclude that the highest-leverage direction is a **factorized, two-timescale world model in the lineage of the Tolman–Eichenbaum Machine (TEM; Whittington et al. 2020), extended with an inverse path-integration module ("Transformation Inferrer") to close the single largest gap — inferring latent transformation rules from before/after pairs (the ARC-AGI/Type-2 regime).** We further show that the two leading *non*-brain-inspired programs — self-supervised world models (JEPA/DINO, §4.5) and solver-plus-external-verifier stacks (§4.6) — are complementary rather than competing: each empirically corroborates part of the thesis while leaving the core gap (latent transformation inference / vocabulary co-discovery) open, and the brain-inspired generator can plug into the same external verifier the solver stack already uses. The rationale for each choice is stated explicitly.

---

## 1. Motivation: Why "Abstract Reasoning" Is the Right Target

The distinction that organizes the whole field is **model-building versus pattern recognition** (Lake et al. 2016):

| Capability | Pattern Recognition | Abstract Reasoning (Model-Building) |
|---|---|---|
| Transfer to new goals | Requires retraining | Immediate: same world model, new reward |
| Transfer to new instances | Relearn from scratch | Zero-shot via structural code |
| One-shot concept acquisition | Thousands of examples | Single example |
| Counterfactual / explanation | Not supported | Produces causal generative model |

The canonical quantitative signature is the **Frostbite gap**: DQN uses ~924 h of play to reach <10% of human score; a human reaching parity in ~15 minutes after two minutes of observation implies a >100× efficiency difference (Lake et al. 2016). The gap is *representational* — causal-structural models transfer, discriminative mappings do not.

Three prerequisites, each necessary and none individually sufficient (Lake et al. 2016): **compositionality** (infinite concepts from finite parts), **causality** (a generative model supporting counterfactuals), and **learning-to-learn** (extracting shared prior structure for one-shot transfer). Crucially, learning-to-learn reaches human efficiency *only* when representations are already compositional and causal — multi-task training on entangled features yields only 2–5× speed-ups. This dependency is the first hint that the missing ingredient is a **representational constraint**, not more optimization.

**The representational-level specification (Penn, Holyoak & Povinelli 2008; [[wiki/concepts/relational-reinterpretation.md]]).** Comparative cognition sharpens both *what* the model-building system must add and *how* pattern recognition counterfeits it. Every animal mind builds **functionally compositional, featurally systematic** representations of first-order perceptual relations (System 1, shared across taxa); only the human mind adds a second system that **reinterprets** them as higher-order, role-governed, explicitly structural relations approximating a Physical Symbol System (System 2, human-only). The target is thus four *separable* properties System 1 lacks — **role-filler independence, type/token separation, concatenative composition, and classical (structural) systematicity** — each individually testable, which is why a transformer can pass featural systematicity while failing all four. System 1 *fakes* relational competence by **chunking** a relation into an analog scalar (e.g. a display-entropy estimate) and **segmenting** a multi-relation task into chunked conditionals — the representational-level root of the shortcut reasoning §3 diagnoses. Penn's verdict from the comparative record is that the second system is a **graft, not a scale-up**: it required a distinct binding mechanism (LISA, gamma-band role-filler synchrony in PFC), not more parameters or plasticity — an independent, cross-species anticipation of §4's "architectural, not scale" verdict.

A formal criterion sharpens this. Choi (2026) defines **intelligence density** $\mathcal{I}(S) = \log_2 N(S)/C(S)$ (states handled per unit description length) and proves a domain is *known* (rather than memorized) iff $\mathcal{I}\to\infty$ as the domain scales. Fixed-depth feedforward networks are provably bounded to $\mathcal{I}=\Theta(1)$; **recurrence/iteration is the minimal architectural condition** for $\mathcal{I}\to\infty$. This is a substrate-independent argument that a reasoning system must iterate, not merely widen.

---

## 2. Problem Framing: Latent Graph Discovery

The central thesis of this review is that abstract reasoning, analogy, planning, mathematics, navigation, and scientific discovery are all instances of one problem:

> **Latent graph discovery — infer the structure (nodes, edges, topology) of a relational graph from observations, then navigate it, where the graph is never given explicitly.**

Nodes = states; edges = transformations/actions; edge labels = the rule applied (often unknown); topology = the relational skeleton. The graph is recovered from sequences of *(observation, action, next-observation)* triples — or, in the hardest visual case, from *(before, after)* pairs where the edge label itself is what must be inferred.

**Taxonomy — what is latent** (this is more principled than enumerating domains, because it predicts which tasks share computational structure):

| Latent component | Observed | Canonical benchmark |
|---|---|---|
| **Edges** (transformation rules) | Start + end pairs | ARC-AGI, IQ/analogy tasks |
| **Path** (edge sequence) | Start + end nodes | Navigation, planning; competition math (MATH, AIME) |
| **Node content** (partial state) | Path + partial content | Algebra, physics; GPQA (graduate causal chains) |
| **Topology + edges** | Observations only | Scientific/causal discovery |

**The two-level hierarchy.** Every domain factors into a slow **meta-graph** (rules shared across episodes) and a fast **instance-graph** (task-specific topology). A system that conflates them must relearn the rules for every new problem. This maps *directly* onto the brain's two-timescale split: **slow synaptic weights W = meta-graph; fast Hebbian memory M = instance-graph** (McClelland et al. 1995; Whittington et al. 2020). It is the pivotal design constraint of the whole program.

**Meta-graph expressiveness is graded by the Chomsky hierarchy** (Hauser, Chomsky & Fitch 2002; [[wiki/concepts/recursion.md]]). A flat, Markov/finite-state transition model is *provably insufficient* for natural reasoning: local transitional statistics are the finite-state floor — spontaneously available to infants and cotton-top tamarins across modalities — and are therefore **not** the missing ingredient. Recursively-embedded (phrase-structure) dependencies — the AₙBₙ / center-embedding regime tamarins fail and humans acquire implicitly — are the minimum, which is the formal content of the multi-level meta-graph (§9 open problem #3 / Gap #2): W must be *recursively nested*, not flat. The FLB/FLN cut restates the review's recurring theme — the perceptual/world-model modules are largely shared and reusable (FLB); the qualitatively new piece is a single **recursive combinator** (FLN) that composes them productively, and discrete infinity ≅ the natural-number successor function ties it to the number core system (§3, §8.3).

**Six sources of hardness** (the difficulty axes any architecture must be measured against):

1. **Two-level entanglement** — meta and instance structure co-occur in every observation → requires a factorized latent space + two learning rates.
2. **Unknown vocabulary** — the action/node alphabet is not given and must be co-discovered.
3. **Observation aliasing** — the same observation appears at distinct graph positions → path-context identity (clone cells / path-integrated code).
4. **Simultaneity** — structure must be inferred *while* navigating.
5. **Spurious-edge covariate shift** — training contains false edges that work i.i.d. and fail o.o.d. Quantified cleanly by ANLI: a hypothesis-only NLI shortcut scores ~72% i.i.d. but 42–51% once the false H→label edge is blocked (Nie et al. 2020); larger LLMs are *more* susceptible (inverse scaling; Yuan et al. 2024).
6. **Non-stationary topology** — the edge set rewrites *within* one episode (rules change, doors open). The only source that breaks the stationarity assumption the other five share. Learnable *iff* the rewrite process is itself a stationary higher-tier generator (a "rewrite-graph"); provably unsolvable when rewrites are incompressible. **Baba Is AI** pins this to its most tractable pole (legible, controllable, bounded rewrites) yet GPT-4o/Gemini score only ~15–20% on composing rewrites (Cloos et al. 2024) — the current-model bottleneck sits far below the in-principle ceiling.

**Formal ceiling.** AIXI (Hutter 2000) is the only system satisfying all six simultaneously — a Bayesian mixture over all computable environments — but is uncomputable. Every feasible architecture is a bounded approximation that fails on whichever hardness sources its search budget cannot reach. This positions the engineering problem precisely: not "reach AIXI" but "cover the tractable interior of sources 1–5 with a computable, trainable model."

---

## 3. The Benchmark Landscape: Isolating the Bottleneck

The strongest empirical argument that the bottleneck is *latent structure inference* — not knowledge, scale, or data — is the **convergence of two opposite design extremes**:

| Benchmark                                    | Prior knowledge required      | Failure mode                                              | SOTA                                             |
| -------------------------------------------- | ----------------------------- | --------------------------------------------------------- | ------------------------------------------------ |
| **ARC-AGI-2** (Chollet 2019; ARC Prize 2025) | Minimal (Core Knowledge only) | Infer novel transformation rules from few grids           | 24–54% verified; ≤85% self-reported (unverified) |
| **FrontierMath** (Glazer et al. 2024)        | Maximal (research math)       | Navigate theorem graph with near-zero vocabulary coverage | <2%                                              |

FrontierMath still sits at <2%; verified/reproducible ARC-AGI-2 has climbed to 24–54% (frontier labs self-report ≤85% on closed models, but these are unverifiable), yet both remain far below human under any cost-controlled, reproducible setting. The diagnostic gap is not *how much* a system knows but whether it can *discover and traverse the structural graph* organizing what it knows — and, increasingly, whether high scores survive independent verification rather than resting on closed-model self-reports.

Supporting evidence, each isolating a different facet:

- **ARC-AGI series.** ARC-AGI-1 resisted a ~50,000× LLM scale-up (2019–2024), then fell to o3 via test-time reasoning — validating *fast within-episode adaptation*, not pre-training scale, as the lever. ARC-AGI-2 (verified 24–54% vs. ~84% human; ≤85% self-reported on closed models, unverified) localizes three deficits: symbolic interpretation, compositional (multi-rule) reasoning, and contextual rule selection. ARC-AGI-3 adds a fourth capability entirely — *autonomous goal inference*: the agent is told only "win," and must discover both what its actions do and what winning means (<1% AI vs. 100% human; ARC Prize 2026).
- **VSA/HRR isolates the vocabulary gap most cleanly** (Joffe & Eliasmith 2025): the same neuro-symbolic solver scores **94.5% on Sort-of-ARC (pre-given DSL) but 3% on ARC-AGI-1-Eval (open DSL)**. Once path integration and binding are solved, *vocabulary co-discovery is the residual gap*. This is the single most diagnostic number in the corpus for where to spend effort.
- **PGM** (Barrett et al. 2018) supplies a controlled composition-decomposition taxonomy: models recombine familiar (relation, object, attribute) triples above chance but collapse to near-chance on genuinely novel primitives — recombination competence ≠ decomposition competence.
- **ConceptARC** (Moskvichev et al. 2023) and its multimodal extension (Beger et al. 2025) show that **accuracy conflates shortcut solutions with concept acquisition**: AI produces correct-but-unintended rules ~27–29% of the time vs. ~5% for humans, and the dominant shortcut is treating grids as pixel matrices rather than scenes of discrete objects — a **missing objectness prior** (Spelke Core Knowledge). Humans make *near-miss* errors (concept present, execution slips); programs make *concept-failure* errors — a diagnostic of model-building visible only at the error-structure level, not in accuracy.
- **Shortcut suites** (Geirhos et al. 2020; Yuan et al. 2024) formalize the i.i.d./o.o.d. decision-rule gap and the inverse-scaling paradox.

**Benchmarks mapped to the six sources of hardness (§2).** Each benchmark is diagnostic precisely because it isolates a different hardness axis; read the table as "to score here, a system must solve *this* source." The clustering on **source 2 (unknown vocabulary)** is itself the argument: the frontier benchmarks converge on the same missing machinery.

| Benchmark                             | AI SOTA                                | Primary hardness source(s) (§2)                 | What it isolates diagnostically                                                        |
| ------------------------------------- | -------------------------------------- | ----------------------------------------------- | -------------------------------------------------------------------------------------- |
| **ARC-AGI-1**                         | fell to o3 (~88%)                      | 2 (unknown vocabulary), 1 (edges latent)        | Fast *within-episode* adaptation > pretraining scale (resisted ~50,000× scale-up)      |
| **ARC-AGI-2**                         | 24–54% verified; ≤85% self-reported (vs ~84% human) | 1 + 2 + compositional rule selection            | Symbolic interpretation, multi-rule composition, contextual rule choice                |
| **ARC-AGI-3**                         | <1% (vs 100% human)                    | 4 (simultaneity) + latent goal (beyond the six) | Autonomous goal inference; the *verifier-free* regime                                  |
| **FrontierMath**                      | <2%                                    | 2 (unknown vocabulary, extreme)                 | Near-zero vocabulary coverage over a research-math theorem graph                       |
| **VSA: Sort-of-ARC → ARC-AGI-1-Eval** | 94.5% → 3%                             | 2 (unknown vocabulary), *cleanly isolated*      | Vocabulary co-discovery is the residual gap once binding + path integration are solved |
| **PGM**                               | above-chance recomb.; ~chance on novel | 2 (decomposition facet)                         | Recombination competence ≠ decomposition competence                                    |
| **ConceptARC**                        | ~27–29% shortcut rate (vs ~5% human)   | 5 (spurious edges) + objectness prior (§8.3)    | Shortcut vs. genuine concept; missing Core-Knowledge objectness                        |
| **ANLI**                              | 72% i.i.d. → 42–51% shortcut-blocked   | 5 (spurious-edge covariate shift), *canonical*  | Quantifies the false H→label edge; larger LLMs *more* susceptible (inverse scaling)    |
| **GSM-Symbolic / MATH-Perturb**       | NoOp −65%; hard −12–28%                | 5 (spurious edges), structural                  | (Non-)robustness of trajectory pattern-matching to irrelevant perturbation             |
| **Baba Is AI**                        | ~15–20% (GPT-4o/Gemini)                | 6 (non-stationary topology), tractable pole     | Composing bounded, legible rule rewrites (rules change mid-episode)                    |

**Takeaway for method design.** A benchmark that a system passes by scale is a benchmark measuring the wrong thing. The evaluation target should be ARC-AGI-2/3 (contamination-resistant, structure-novel), scored ideally with a *dual channel* (accuracy + rule quality) to prevent shortcut inflation (Beger et al. 2025).

### 3.1 Capability confounds — which benchmark actually isolates *reasoning*

The §3 tables rank benchmarks by the **hardness source** they probe. For validating whether *our model reasons*, a second axis matters just as much: every benchmark also taxes **auxiliary capabilities** (perception, language, domain knowledge, motor/exploration) that can pass or fail *independently of reasoning*, confounding the measurement. A model can lose points for parsing a grid wrong, missing a word, or lacking a theorem — none of which is a reasoning failure — and can also *gain* points by exploiting a non-reasoning shortcut (surface word-flow that mimics a chain of thought; MCQ guessing). The goal is a benchmark whose confounds are either **absent** or **neutralizable** (strippable by a change of input format or scoring), leaving reasoning as the sole free variable.

**Legend:** ⬤ heavy load · ◑ moderate · ○ low/absent. "Neutralizable" = the confound can be removed without changing the reasoning task.

| Benchmark        | Perception (visual parsing)                   | Language (NL comprehension)     | Domain knowledge                                                             | Agentic / motor / exploration               | Dominant confound → neutralizer                                                                                                                                                                                             |
| ---------------- | --------------------------------------------- | ------------------------------- | ---------------------------------------------------------------------------- | ------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ARC-AGI-1/2**  | ⬤ *neutralizable*                             | ○                               | ○ (Core Knowledge; solve-rate demographic-independent, §"human calibration") | ○                                           | Visual parsing — feed integer-matrix **text**: o3 scores 75.6% textual vs. 29.2% visual on ConceptARC, so the gap is *perceptual, not conceptual* (Beger et al. 2025). **Cleanest language + domain isolation of the set.** |
| **ARC-AGI-3**    | ⬤                                             | ○                               | ○                                                                            | ⬤ (exploration + autonomous goal inference) | Motor/exploration/goal-inference are *intrinsic to the task* (not strippable) — measures the full agentic loop, not reasoning in isolation.                                                                                 |
| **PGM**          | ⬤ *baked-in*                                  | ○                               | ○ (finite, **given** (r,o,a) vocabulary)                                     | ○                                           | Rendered 80×80 panels — perception is *mandatory and non-separable*; but the known vocabulary cleanly isolates recombination-vs-decomposition. Reasoning is conflated with vision by construction.                          |
| **FrontierMath** | ○                                             | ◑                               | ⬤ (research math, near-zero coverage)                                        | ○                                           | Domain expertise — score is *expertise-gated*; conflates reasoning with vocabulary coverage; <2% ceiling gives no variance to rank models. Worst domain confound.                                                           |
| **OlymMATH**     | ○ (no multimodal geometry)                    | ◑ (word-flow-vs-reasoning risk) | ⬤ (olympiad)                                                                 | ○                                           | Language + domain — but the **LEAN track's process-level verification is the neutralizer**: it separates a genuine reasoning-graph traversal from heuristic word-flow guessing (the exact confound you flagged).            |
| **GPQA**         | ○                                             | ⬤ (NL MCQ)                      | ⬤ (graduate science)                                                         | ○                                           | Language + domain + **4-choice guessing** (25% floor); google-proof design targets spurious-edge suppression but cannot separate reasoning from expertise. Weakest isolation; contamination risk.                           |
| **Baba Is AI**   | ◑ (grid image; *grounding errors documented*) | ◑ (emits textual plan)          | ○ (game rules only)                                                          | ⬤ (multi-step planning)                     | Visual grounding + path-planning are the *documented failure modes* (Cloos et al. 2024) — non-reasoning confounds that contaminate the rule-composition signal.                                                             |

**Reading the table for benchmark choice.**
- **To isolate structural/relational reasoning with minimal confounds — the primary validation target:** **text-encoded ARC-AGI-2.** It is the only benchmark that zeroes *both* the language and domain-knowledge confounds (Core-Knowledge-only; human solve-rate is uncorrelated with age/education/background), and its one heavy confound — perception — is neutralizable by supplying grids as integer matrices. Use dual-channel scoring (accuracy + NL rule) to also block the word-flow shortcut.
- **As a controlled complement:** **PGM**, accepting its mandatory vision front-end in exchange for a fully-specified vocabulary that isolates the recombination-vs-decomposition axis a single ARC score cannot separate.
- **Avoid as a *pure-reasoning* claim:** FrontierMath and GPQA — high scores there certify domain-knowledge coverage as much as reasoning, and MCQ/answer-match formats reward word-flow that mimics but does not perform inference. If a math benchmark is mandated, use **OlymMATH-LEAN**, whose process verification is the only mechanism in the set that mechanically distinguishes a reasoning chain from a plausible-sounding one.
- **Reserve for the specific capability it uniquely probes:** ARC-AGI-3 (autonomous goal inference) and Baba Is AI (non-stationary topology) — both add irreducible motor/agentic confounds, so treat their scores as *capability-specific*, not as clean reasoning measurements.

**The general principle:** no benchmark is confound-free; the choice is *which confound you can neutralize*. Perception is neutralizable (change the input encoding) and word-flow is neutralizable (process/rule verification); domain knowledge is **not** (it is entangled with the reasoning task itself), which is why the minimal-knowledge, text-encodable ARC family dominates for a reasoning-isolation claim.

---

## 4. Why Current Architectures Fail — A Structural, Not Empirical, Verdict

The most important claim in this review is that transformer/LLM failure on ARC-AGI is **architectural, not a data or scale problem**. Three independent lines of evidence:

1. **Manifold reachability** (neural-manifolds concept; Lake & Baroni 2023). A training objective can only converge on patterns reachable within a model's intrinsic manifold. A monolithic transformer entangles structure and content in shared weights; abstract relational generalization lies *outside* its reachable manifold *by construction*. More gradient steps cannot cross that boundary. The positive control is decisive: the *same* transformer architecture, trained with episodic meta-learning (a different grammar per episode), reaches 92.9–96.8% systematicity, while standard-pretrained GPT-4 reaches 58% and collapses to 14% under input permutation (Lake & Baroni 2023). **The critical variable is the training objective's enforcement of the W/M split, not the architecture's raw capacity.**

2. **Catastrophic interference as formal necessity** (McClelland et al. 1995). Without a fast/slow split, a monolithic system must absorb each new episode rapidly, overwriting shared structure. The W/M factorization is not an efficiency choice; it is the theoretically-forced solution to storing new instances without destroying the meta-graph.

3. **Compositionality is unsolved even on data designed to require it** (Hupkes et al. 2020): transformers hit 72% systematicity / 50% productivity / 54% localism despite 92% task accuracy, because they learn *function-pair chunks* rather than atomic primitives. High accuracy hides the failure.

LLMs/LRMs specifically are **knowledge-bounded** (Choi 2026; ARC Prize 2026): the in-context fast loop cannot generalize beyond the pretraining envelope to genuinely novel graph structure. Chain-of-thought partially mitigates spurious-edge shortcuts by forcing multi-hop traversal, but cannot repair an incorrect edge vocabulary, and self-generated intermediate nodes corrupt downstream traversal (the MATH self-poisoning effect). The verdict: scaling the *wrong* inductive structure cannot reach the target; the missing piece is **factorization + iteration + a mechanism to infer latent edges**.

---

## 4.5 The World-Model Pivot: JEPA and DINO as the Leading Alternative

Faced with the LLM-failure verdict of §4, a large fraction of the field has pivoted from token-generative scaling to **self-supervised world models** — most visibly LeCun's JEPA program. This is the most serious *non*-brain-inspired alternative to the direction this review advocates. It is treated in depth here because it shares one of this review's core commitments (representation-space prediction) while diverging on the other (factorization), so the comparison sharpens exactly what the brain blueprint adds.

Two distinct lineages are usually conflated under "world models":

| Lineage | Role | Members | What it actually is |
|---|---|---|---|
| **DINO** ([[wiki/entities/dinov2-model.md]] → [[wiki/entities/dinov3-model.md]]) | *Perception front-end* | DINOv2 (1.1B), DINOv3 (7B + distilled) | Self-supervised ViT foundation models (EMA teacher-student + masked-patch iBOT + KoLeo/Gram). **Not world models** — frozen patch features that transfer to segmentation/depth/tracking. |
| **JEPA** ([[wiki/entities/jepa-model.md]], [[wiki/entities/vl-jepa-model.md]]) | *World model* | I-JEPA → V-JEPA 2 (1B, 1M h video) → V-JEPA 2-AC (action-conditioned) → VL-JEPA → LeJEPA/LeWorldModel | Predict *representations* of masked/future states, not pixels; V-JEPA 2-AC adds a Mode-2 MPC planning loop. |

**Where the pivot corroborates this review** (independent empirical support for the framing, from a non-brain-inspired camp):

- **Representation-space prediction beats generation.** VL-JEPA-SFT (1.6B) beats GPT-4o/Claude-3.5/Gemini-2.0 on WorldPrediction-WM *without generating a token*; V-JEPA 2-AC beats pixel-space Cosmos 65–80% vs. 0% on real-robot manipulation. This is exactly the §5/[[wiki/concepts/world-models.md]] claim (predict `s_y`, not `y`).
- **SSL from observation, not reward** — LeCun's central thesis, matching the observation-only regime of [[wiki/concepts/latent-graph-discovery.md]].
- **DINO supplies the missing objectness prior.** DINOv2 patch-token PCA yields emergent object-part decomposition with *no labels* — a candidate solution to the Core-Knowledge/objectness gap that ConceptARC diagnoses (§3) and that §8.3 flags as a risk for the sensory front-end (Blocks 1A+2A).

**Where it stops short of the target** — scored against this review's own requirements:

| Requirement (this review) | JEPA / DINO status | Consequence |
|---|---|---|
| Representation-space prediction (§5) | ✅ core principle; empirically vindicated (above) | Corroborates a pillar |
| SSL from observation, not reward | ✅ LeCun's thesis | Corroborates a pillar |
| Objectness / Core-Knowledge prior (§3, §8.3) | ✅ DINOv2 emergent object parts, no labels | Supplies a sensory front-end |
| **Structure/content factorization** (§5.1 keystone) | ❌ monolithic entangled encoder; no explicit `g` vs `x` | **Manifold-reachability ceiling (§4) is unaddressed** — better features, same recombination limit |
| **Latent transformation inference** (Block 3A) | ❌ forward-only (`s_x→ŝ_y`); `z` is a *minimum-information* x–y relation (Lett 2025), not a discovered rule vocabulary | Cannot do Type-2 / ARC-AGI edges |
| Discovered (not fixed) hierarchy/vocabulary (Gap 3) | ❌ H-JEPA/HiT-JEPA levels are pre-specified | Vocabulary co-discovery unsolved here too |
| Learned reasoning algorithm (System II) | ❌ Mode-2 = hard-wired CEM over a learned model (Lett 2025): same model + same search = same plan | System I only |
| Two-timescale W/M split (§4.2, §5.2) | ❌ slow weights only; no fast Hebbian instance memory | Catastrophic interference unaddressed |

**Verdict — how the pivot updates the direction.** JEPA is a *monolithic, forward-only, single-timescale* world model. It ratifies two of this review's pillars empirically (representation-space prediction; SSL-from-observation) and DINO hands us a ready objectness front-end — but it inherits, unmodified, the two gaps this review argues are the crux: **no structure/content factorization** (so the §4 manifold-reachability ceiling still bites) and **no inverse-path-integration to infer latent transformations** (so it is blind to the ARC-AGI/Type-2 regime, the same forward-only limit TEM has, §8). The synthesis is therefore *not* JEPA-as-the-architecture but **a DINO/JEPA-style SSL encoder as the sensory front-end (Blocks 1A/2A) feeding a factorized, two-timescale TEM-lineage core with a Transformation Inferrer (Block 3A).** One further datum sharpens the regime: LeJEPA's in-domain result — 11K images beating DINOv3's hundreds of millions — shows that when the data distribution is narrow (as abstract-reasoning data always is), *principled* SSL, not scale, is the operative lever, reinforcing §4's "scaling the wrong inductive structure cannot reach the target."

---

## 4.6 The Solver Pivot: Generation + External Verification — The Other Leading Alternative

The second major response to §4's LLM-failure verdict is the opposite of JEPA's. Where the world-model camp tries to build a *better internal model*, the **solver** camp *externalizes the problem entirely*: pair a powerful (unreliable) generator with a trusted external verifier and search. This is the **most demonstrably successful** attack on abstract reasoning to date — IMO gold (Gemini Deep Think 2025), silver via AlphaProof+AlphaGeometry (2024), MiniF2F 25%→93% and PutnamBench 0→60%+ in ~1 yr, AlphaEvolve improving best-known bounds, four Erdős problems Lean-verified — and therefore the alternative a reviewer will raise first. It is treated at depth here because it factors the *same* latent-graph-discovery problem (§2) differently, and — decisively — its ceiling coincides *exactly* with this review's target gap ([[wiki/queries/brain-inspired-vs-solver-approach.md]]; [[wiki/papers/math-reasoning-survey-2026.md]]).

**What it is — externalization, not solution.** The solver does not learn an internal latent graph. It moves each of the three hardest LGD hardness sources (§2) out of the model and into human-built infrastructure, using the neural net only as a *search policy* over given structure:

| Hardness source (§2) | Solver externalization | Substrate / mechanism |
|---|---|---|
| **2 — Unknown vocabulary** | Pre-built symbolic alphabet | Lean **mathlib** (1.6M lines), geometry **DSL** (AlphaGeometry DDAR), Python operator set — the edge vocabulary is *given*, not co-discovered |
| **5 — Spurious edges / validity** | Trusted external kernel | Lean kernel, symbolic solver, unit test — does *not* share the generator's distribution, so hallucinated false edges are simply rejected |
| **4 — Simultaneity** | Test-time search | Refinement loops ([[wiki/concepts/refinement-loops.md]]): TTT, MCTS, expert iteration, evolutionary program search |

The residual work — comprehension, path proposal, autoformalization — is exactly what large pretrained models are good at. Hence the wins.

**The organizing principle: the supervision ladder ("representation engineering → verifier engineering").** The math survey names the field's trajectory as climbing a ladder of increasingly informative-but-costly external constraints — **answer-match → code execution → PRM (process reward model) → kernel-checked proof**. The key shift is that the *structured intermediate* (the latent graph) is no longer hand-designed to be always-correct; it is **externalized into a symbolic substrate and checked**. The mechanism is the generate–verify–refine [[wiki/concepts/refinement-loops.md]] skeleton (four instantiations: test-time training, zero-pretraining DL, evolutionary program synthesis, CoT harness), whose defining property is that *without a verifier the loop degenerates to random search*.

**Verifier quality is the binding constraint — and has three axes, not one.** Verification improves reasoning only when the verifier is (i) accurate, (ii) resistant to adversarial exploitation by the generator, (iii) rich enough to give partial-progress signal. Only **kernel-checked formal proofs** (Lean) satisfy all three — which is *why the formal track moved fastest*. Rule-based answer graders satisfy (iii) cheaply but fail (i)/(ii): ~38% of correct RLVR answers are miss-graded on formatting, and the loop is Goodhart-gamed. A crucial non-monotonicity: **reward hacking scales with verifier richness** — more accurate learned verifiers (PRMs) can be *more* hackable, because the policy has a richer signal to exploit. "Better verifier ⇒ better loop" is false.

**Where it corroborates this review** (triangulation from an independent, non-brain-inspired camp):

- **It ratifies the LGD framing itself.** The solver factors the *same* problem into the same taxonomy cells (§2): formal proving = *path over a given vocabulary*; discovery (FunSearch/AlphaEvolve) = *topology+edges externalized to program space*; FrontierMath Tier-4 = *the un-externalizable vocabulary cell*. That a working research program decomposes cleanly onto the taxonomy is evidence the taxonomy is right.
- **The verifier-availability boundary is empirically load-bearing.** The discovery track works *precisely* where an external checker exists (Python fitness, Lean kernel) and degenerates to unguided search where it does not — exactly the [[wiki/concepts/refinement-loops.md]] prediction, now confirmed at research scale.
- **Its ceiling is the same wall three other diagnostics hit.** Tao's *"discovery modulo expertise"* — strong at connecting a problem to an *existing* technique (traversing a known meta-graph), weak at *genuinely novel ideas* (extending the vocabulary) — is **hardness source 2**, the identical wall the VSA 94.5%→3% cliff (§3) and ARC-AGI-3's latent goal expose from the visual side.

**Where it stops — scored against this review's requirements:**

| Requirement (this review) | Solver status | Consequence |
|---|---|---|
| Per-instance correctness guarantee | ✅ kernel-certified | **The solver's decisive advantage — reuse it, don't compete with it** |
| Structure/content factorization (§5.1) | ❌ externalized to human substrate, not learned | Manifold-reachability ceiling (§4) is *avoided where infra exists*, not closed |
| **Latent transformation / vocabulary inference** (Block 3A; source 2) | ❌ vocabulary *given* (mathlib/DSL) | **Tao ceiling**: FrontierMath Tier-4 stays single-digit; co-mathematician workbench 48% |
| **Verifier-free operation** | ❌ requires an external kernel | Cannot enter ARC-AGI-3 (latent goal), open conjecture, real-world planning |
| Structural robustness | ❌ generator pattern-matches trajectories | GSM-Symbolic NoOp −65%, MATH-Perturb hard −12–28%; a verifier can *reject* but not *supply* structure |
| Sample / energy efficiency | ❌ brute-force search (o3-high ≈ $30k/ARC task) | The Frostbite / intelligence-density gap (§1) restated on the compute axis |
| Cross-domain generality | ❌ per-domain human infrastructure (mathlib ≠ DSL ≠ Python) | Not a general reasoner; a Lean substrate does not transfer to a domain lacking one |

**Verdict — how the pivot updates the direction.** The solver does not *dissolve* latent graph discovery; it **externalizes** it wherever a formal substrate and a cheap, non-hackable verifier already exist. This is a statement about *infrastructure*, not about closing the model-building gap. The two programs are therefore complementary along orthogonal axes: **the solver owns verifiable domains, correctness guarantees, and immediate practical mathematics** — do not benchmark the wiki's model against it on saturated verifiable math (AIME, MiniF2F), which measures externalized infrastructure, not model-building. **The brain-inspired program owns the seam** the solver's own ceiling isolates: vocabulary **co-discovery** (source 2), **verifier-free** domains (ARC-AGI-3, open discovery), sample/energy efficiency, and autonomous goal inference. The synthesis is not "brain-inspired *instead of* solvers": a factorized internal world model can serve as the *proposer* inside the very same verified-discovery loop the solver already runs (Open Problem, §9), reusing the external kernel as complementary infrastructure rather than a rival paradigm — its structural transfer potentially cutting the brute-force search cost the solver currently pays.

---

## 5. The Brain-Inspired Blueprint

Neuroscience contributes not vague inspiration but a *specific, convergent, and increasingly formalized* solution to exactly the constraints above. Six principles, each with a computational justification and a validated substrate.

### 5.1 Factorize structural code from sensory content — the keystone

The MEC grid code `g` (structural) and LEC content code `x` (sensory) are bound in HC as `p = f(g, x)` (Whittington et al. 2020). **TEM is the reference proof-of-concept**: it demonstrates zero-shot structural generalization, and its emergent grid/place cells reproduce biology. Two unifications elevate this from analogy to theory:

- **TEM = transformer** (Whittington et al. 2022): the factorized key/value structure (Q=K=f(g), V=f(x)) follows *necessarily* from outer-product memory, and Hopfield↔attention is grounded in the Boltzmann distribution (softmax *is* P∝exp(−E/T)).
- **Grid cells = successor-representation eigenvectors = optimal path-integration bases**; place cells = SR rows = p=f(g,x). Periodic codes make graph-matching (NP-hard in general) a phase shift, because all positions are treated equivalently and the code can be *shifted* to register any new environment.

Human fMRI confirms the structural code generalizes beyond space: hexagonal grid-like signals appear during abstract 2D "conceptual navigation," strongest in vmPFC (Constantinescu et al. 2016). **Caveat / open controversy:** HC uniquely engages *metric or sequential* relational graphs, not topology-matched *social/declarative* ones (Kumaran & Maguire 2005) — implying the meta-graph may be **two representational formats** (continuous/metric via MEC→HC; discrete/declarative via PFC hierarchy + mPFC schemas) that must gate each other. This is a genuine design fork, addressed below.

### 5.2 Two-timescale learning — the W/M split

Slow W (cortex/MEC, backprop-like, interleaved across environments) builds the shared meta-graph; fast Hebbian M (HC, one-shot) binds the episode-specific instance-graph (McClelland et al. 1995; Whittington et al. 2020). This is the computational implementation of the two-level hierarchy from §2 and the direct answer to catastrophic interference.

### 5.3 Maintain latent state via path integration

An RNN updating `g` under actions de-aliases observations and compresses rule-learning from O(transitions) to O(relation types) (path-integration concept). Confirmed in vivo as a ring attractor in the *Drosophila* central complex (Seelig & Jayaraman 2015).

### 5.4 Gate and modulate via basal ganglia / neuromodulation

Credit assignment in the brain is *structurally opponent*: a single phasic dopamine event drives D1→LTP (Go) and D2→LTD (NoGo) simultaneously (Gerfen & Surmeier 2011). Doya (2002) maps DA=TD-error, 5-HT=discount/horizon, NA=inverse-temperature/exploration, ACh=learning-rate — a closed meta-learning loop. Wang et al. (2018) show dopamine-trained slow weights give rise to a within-episode RL algorithm in PFC recurrent activity: **model-based behavior emergent from model-free training** — the biological instantiation of learning-to-learn.

### 5.5 Hierarchical control — rules about rules

The PFC rostro-caudal gradient (BA-8 → BA-9/46 → BA-10) implements nested rule abstraction (Friedman & Robbins 2021). Badre et al. (2010) show all frontal levels **search in parallel from trial 1** with reward-gated depth pruning, producing *step-wise* (not gradual) learning curves as the signature of genuine rule compression. Single PFC neurons carry abstract, remappable, sharp-boundary category tuning acquired in 5–15 trials (Miller et al. 2002) — grounding meta-graph edge labels at the single-cell level and showing that *symbols can be induced from task-relevant experience* (bearing directly on the vocabulary co-discovery gap).

### 5.6 Canonical hardware and predictive coding

Every cortical region runs the L4→L2/3→L5→L6→L4 microcircuit: recurrent amplification of weak input, soft winner-take-all hypothesis selection, and an explore(superficial)/exploit(deep) split (Douglas & Martin 2004). Bastos et al. (2012) map this onto predictive coding — superficial layers carry feedforward error (gamma), deep layers carry feedback prediction (beta) — making the PC message hierarchy a structural consequence of laminar anatomy.

### 5.7 The contextual and planning layers (recent additions)

- **Memory schemas = mPFC slow-W = latent graphs** (Preston & Eichenbaum 2013; de Sousa et al. 2026): schemas are organized overlapping association networks; the vmPFC→MEC→NGF circuit gates whether new memories are *assimilated* into or *accommodated* alongside prior schema engrams — controlled meta-graph update without catastrophic interference.
- **Planning as inference via the Spacetime Attractor (STA)** (Jensen et al. 2026): rather than sequential rollout (which accumulates error), the world model (adjacency matrix A) is embedded in inter-subspace weights and the optimal T-step trajectory is inferred as an attractor fixed point *in parallel*. Meta-trained RNNs spontaneously discover STA-like codes (r=0.91 with the adjacency matrix). This is the strongest current candidate for the planning module and sidesteps the planning-horizon dilemma.
- **DMN as contextual buffer**: a slow "frame of thought" integrating episodic memory, semantics, and self-reference, uniquely broadcasting to all cortical types (Paquola et al. 2025), gated by the salience network, toggled between segregated/integrated states by LC-NA arousal (Shine et al. 2016).

### 5.8 Why the brain blueprint meets the requirements the other two camps miss

§4.5 and §4.6 scored JEPA and the solver against this review's requirements and found each ❌ on the crux rows. This table completes the trio by scoring the **brain-inspired core (TEM-lineage factorized world model)** on the *same* requirement list, showing where its suitability comes from — and, crucially, that its one remaining gap is structurally *different* from the other camps' gaps.

| Requirement (this review) | Brain-inspired (TEM-lineage core) status | Why it holds / mechanism |
|---|---|---|
| Representation-space prediction (§5) | ✅ native | Predicts `p = f(g, x)` in latent space, never pixels (Whittington et al. 2020) — the same pillar JEPA independently vindicates |
| SSL from observation, not reward | ✅ native | Trains on *(obs, action, next-obs)* sequences; no reward channel required — matches the observation-only LGD regime (§2) |
| **Structure/content factorization (§5.1 keystone)** | ✅ native | Explicit `g` (structural) vs. `x` (content) split — places relational generalization *inside* the reachable manifold by construction (§4); the exact machinery both JEPA (monolithic encoder) and the solver's learned core lack |
| Two-timescale W/M split (§5.2) | ✅ native | Slow-W meta-graph (cortex/MEC) + fast-Hebbian-M instance-graph (HC); the theoretically-forced answer to catastrophic interference (McClelland et al. 1995) |
| Latent-state path integration (§5.3) | ✅ native | RNN updates `g` under actions, de-aliasing observations; compresses rule-learning to O(relation types) (ring attractor confirmed, Seelig & Jayaraman 2015) |
| Learned reasoning algorithm (System II) | ✅ native | Model-based behavior emerges from model-free training in PFC recurrence (Wang et al. 2018); planning-as-inference via STA (§5.7), not hard-wired search |
| Objectness / Core-Knowledge front-end (§3, §8.3) | ◐ via front-end | Supplied by a DINO/JEPA SSL encoder at Blocks 1A/2A (§4.5) — the one component deliberately borrowed from the world-model camp rather than re-derived |
| Verifier-free operation (ARC-AGI-3, open discovery) | ✅ native | An internal world model needs no external kernel — it can enter the latent-goal / open-conjecture regime the solver (§4.6) structurally cannot |
| **Latent transformation inference (Block 3A; source 2)** | ◐ reachable extension | Absent in *base* TEM (forward-only), **but is the exact inverse of the path integration TEM already computes** — a natural graft (set-attention over Δg → posterior over W), not a structural impossibility. Contrast: JEPA is forward-only *by design*, the solver has its vocabulary *given* — for both, closing this gap means abandoning the paradigm |

**The decisive asymmetry.** Every requirement JEPA and the solver miss on their crux rows, the brain blueprint supplies *natively* — and the single row where the brain core is *also* incomplete (Block 3A) is qualitatively different: it is the **inverse of an operation the architecture already performs**, reachable by grafting rather than by re-founding. That is precisely why this review recommends *extending* the brain-inspired lineage rather than either of the alternatives: it starts already satisfying the requirements that are structural dead-ends for the other two, and its one gap is the one gap that lineage is uniquely positioned to close (§8).

---

## 6. The Learning Algorithm: Can W Be Trained Biologically?

If the target is a two-timescale factorized model, the slow-W training rule is a first-class design question. The lineage:

```
Hopfield (1982) → Boltzmann Machine (1985, intractable Z)
  → Contrastive Hebbian Learning (Movellan 1990, mode-mismatch bug)
  → Equilibrium Propagation (Scellier & Bengio 2017): weak nudge → EXACT gradient, no backward circuit
Parallel: Predictive Coding / FEP → local error; F = −ELBO
  → TEM (2020): factorized ELBO, cross-environment transfer, emergent grid/place cells
```

**Equilibrium Propagation** resolves the *theoretical* half of biologically-plausible credit assignment: Theorem 1 (Scellier & Bengio 2017) proves the local contrastive-Hebbian update computes ∂J/∂W exactly as the nudge β→0; the free (inference) phase and learning phase use *identical* dynamics — no separate backprop machinery. **But the practical half is open**: EqProp requires symmetric weights, scales poorly on digital hardware, and has no result beyond small scale. The honest empirical picture (Bartunov et al. 2018): feedback alignment, target-prop, and SDTP all reach >93% top-1 error on ImageNet vs. backprop's 71%. **Differentiable plasticity** (Miconi; Schmidgall et al. 2023) is the pragmatic middle path: an outer loop (BPTT or evolutionary) discovers a *local* Hebbian/neuromodulated rule that the deployed system runs — the retroactive-neuromodulation variant (eligibility trace + delayed dopamine-like signal) being the most biologically faithful.

**Design implication.** For a first implementable system, do *not* stake the project on biologically-plausible credit assignment. Train slow-W with backprop/BPTT (or episodic meta-learning, per Lake & Baroni 2023), treat EqProp/analog-hardware as a *long-horizon substrate* question, and keep the *architecture* biologically faithful (factorization, two timescales, local fast-M writes) where it actually buys generalization. The generalization win comes from the factorized inductive structure, not from the credit-assignment rule.

---

## 7. The Convergent-Evolution Argument

The strongest evidence that the expansion→compression, factorized world-model motif is *near-optimal* rather than merely one option: at least 5–6 independent evolutionary lineages derive it (convergent-allocentric-coding concept) — vertebrate HC (DG→CA3), insect central complex (ellipsoid→fan-shape body), arthropod mushroom body (Kenyon cells→MBONs), cephalopod vertical lobe, crustacean hemiellipsoid body, polychaete mushroom body, spanning ~500–600 Mya of independent origin. When evolution finds the same circuit six times for allocentric world modeling, that circuit is a strong prior for the computational problem. The insect CX is the cleanest implementation target (full connectome known; ring attractor confirmed by Seelig & Jayaraman 2015); HC adds the cross-environment W generalization no invertebrate system has demonstrated.

---

## 8. Synthesis — The Gap, and the Direction This Justifies

Pulling the review together, the field's state can be stated as a single sentence: **we have a validated blueprint for representing and navigating a *known* structural graph (TEM and its unifications), but no trained architecture that *infers latent transformation rules* (Type-2 / ARC-AGI edges) while retaining cross-environment meta-graph transfer.**

The gap is localized with unusual precision by three convergent pieces of evidence:
- VSA's 94.5%→3% cliff (Joffe & Eliasmith 2025): **vocabulary/edge co-discovery** is the residual bottleneck once binding and path integration are solved.
- TEM's own limitation: the action vocabulary `a_t` is always *externally given*; TEM is forward-only and cannot infer transformations (building-blocks synthesis, Block 3A).
- ARC-AGI-2's three deficits map onto three missing PFC blocks: symbolic interpretation (Block 3A, Transformation Inferrer), compositional reasoning (Block 3C, hierarchical stack), contextual rule application (Block 3B, WM context).

### 8.0 The requirements matrix — what LGD demands, and which model supplies it

Consolidating the scattered checklists (§1, §4.5, §4.6, §5) into one matrix. Rows are the machinery the latent-graph-discovery problem *requires*; columns are the leading model classes. The row that matters is **Latent transformation inference (Block 3A)**: it is empty everywhere except the proposed core — that single vacant cell is the entire thesis of this review. The bottom two rows show the two camps are *complementary*, not rival: the solver uniquely owns per-instance correctness; everything else uniquely owns verifier-free operation.

| Requirement (for LGD) | LLM | JEPA | DINO | Solver | VSA | TEM |
|---|---|---|---|---|---|---|
| Iteration / recurrence (§1, intelligence density) | ~ | ~ | ❌ | ✅ | ~ | ✅ |
| Structure/content factorization (§5.1, keystone) | ❌ | ❌ | ❌ | ext | ~ | ✅ |
| Two-timescale W/M split (§5.2) | ❌ | ❌ | ❌ | ❌ | ~ᴹ | ✅ |
| Latent-state path integration (§5.3) | ❌ | ❌ | ❌ | n/a | ✅ | ✅ |
| **Latent transformation inference (Block 3A; source 2)** | ❌ | ❌ | ❌ | ❌ᵍ | ❌ | ❌ |
| Hierarchical rule-of-rules control (§5.5) | ~ | ❌ | ❌ | ext | ~ | ❌ |
| Planning-as-inference, not rollout (§5.7) | ❌ | ~ | ❌ | ext | ❌ | ❌ |
| Objectness / Core-Knowledge front-end (§3, §8.3) | ❌ | ~ | ✅ | n/a | ❌ | ❌ |
| Verifier-free operation (ARC-AGI-3, open discovery) | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ |
| Per-instance correctness guarantee (§4.6) | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ |

*Legend:* ✅ satisfies · ~ partial · ◐ planned in build order (§8.1) · ext externalized to human infrastructure · n/a not applicable to substrate · ❌ absent. *Superscripts:* ᴹ fast Hebbian M only, no slow learned W · ᵍ vocabulary *given* (mathlib/DSL), not inferred → Tao ceiling (§4.6) · ˢ via the Spacetime Attractor planner (§5.7) · ᴰ via a DINO/JEPA SSL front-end (Blocks 1A/2A, §4.5).

### 8.1 The recommended architecture

A factorized, two-timescale world model in the TEM lineage, extended to close the Type-2 gap. The functional decomposition (building-blocks query) and a defensible build order:

| Priority | Block | What it adds | Difficulty |
|---|---|---|---|
| **Foundation** | 1A/1B grid substrate + path integration | Structural code `g`; continuous SO(N) action update (replaces TEM's discrete W(a) lookup) | Low–Med |
| **Foundation** | 2A–2D HC binding | Bidirectional g↔x, iterative pattern completion, surprise-gated + top-k sparse write | Low |
| Next | 3A Transformation Inferrer | Set-attention over {Δg = g_out − g_in} → posterior over the shared W vocabulary; the inverse of path integration | High |
| Next | 3B Working memory | TRNN (high-capacity episodic) + meta-RL LSTM (policy/context) | Med |
| Next | 3C Hierarchical stack | Three-level W (rule-of-rules → context → instance) for multi-rule composition | High |
| Later | 3D Goal generator + planning | STA-style planning-as-inference; argmin over W toward `g_goal` | Med–High |

### 8.2 Rationale for each major choice

- **Why TEM as the base, not a transformer or LLM?** Because factorization is a *manifold-reachability* requirement (§4): the target generalization is unreachable for a monolithic model regardless of scale, and TEM is the reference architecture that puts it inside the reachable manifold by construction while remaining a transformer under the hood (Whittington et al. 2022) — so transformer tooling still applies.
- **Why Transformation Inferrer.** It is precisely the missing inverse of the one operation TEM already does well (path integration), it directly targets the empirically-isolated bottleneck (edge/vocabulary co-discovery; Joffe & Eliasmith 2025), and it is the prerequisite for *all* Type-2 tasks (ARC-AGI, analogy, rule induction). Everything else refines a system that, without 3A, cannot do abstract reasoning at all.
- **Why two timescales, non-negotiable.** Catastrophic interference makes the W/M split a formal necessity, not a tuning choice (McClelland et al. 1995).
- **Why train W with backprop/meta-learning now.** The generalization win is in the inductive structure; the credit-assignment rule is a separate (and currently unsolved at scale) problem (Bartunov et al. 2018). Episodic meta-training is the demonstrated route to enforcing the split in a gradient-trained model (Lake & Baroni 2023).
- **Why planning-as-inference (STA), not rollout.** Sequential rollout accumulates error; STA infers the whole trajectory as an attractor fixed point and is spontaneously discovered by meta-trained RNNs (Jensen et al. 2026).
- **Why evaluate on ARC-AGI-2/3 with rule-quality scoring.** These are structure-novel and contamination-resistant; dual-channel scoring blocks the shortcut inflation that makes accuracy misleading (Beger et al. 2025).

### 8.3 Risks and the domain fork to decide early

- **Metric vs. declarative representational format** (Kumaran & Maguire 2005). The grid/path-integration machinery is validated for *metric/sequential* graphs. If the target tasks are purely declarative/logical, an mPFC-schema-style discrete substrate may be needed instead of (or gating with) the MEC grid code. **Decide the target task's format before committing**, because it changes whether the grid substrate (1A/1B) is load-bearing or a detour.
- **Non-stationary topology (source 6)** is out of scope for a first system and unsolved by any wiki architecture; the lifting construction (rule-state as a node dimension) restores stationarity for Baba-class rewrites but is a later extension (rule-changes-as-meta-graph-rules query).
- **Objectness prior** (Beger et al. 2025; [[wiki/concepts/core-knowledge.md]]) — grids are scenes of discrete entities, not pixel matrices. This must be built into the sensory front-end (Blocks 1A+2A) or the model inherits the dominant ARC shortcut. Two refinements from the Core-Knowledge literature: (i) the prior is not a monolithic binary gate but a **bundle of dissociable sub-principles** (cohesion, continuity, contact) — infants violate them one at a time (Stahl & Feigenson 2015), so implement them as *separately-maskable* constraints; (ii) the *uniquely-human* step is composing *across* encapsulated core systems (objects × number × agents), which is a binding problem under a serial-attention bottleneck (Revencu & Csibra 2023), **not** the acquisition of any single prior — reinforcing that the crux gap is combinatorial (Block 3A/3C), not perceptual.

---

## 9. Open Problems the Direction Must Confront

1. **Type-2 transformation inference** (Block 3A) — architecturally absent everywhere.
2. **Vocabulary co-discovery with cross-environment transfer** — no model does both simultaneously (LAPA does vocabulary co-discovery but domain-specifically; VSA does binding but learns no W). This is the *same wall the solver stack hits from the formal side* — Tao's "discovery modulo expertise" ceiling and FrontierMath Tier-4's single-digit scores (§4.6) — making it the shared frontier of both literatures and the natural site of a novelty claim.
3. **Multi-level meta-graph** — how the abstract state space for a higher-level hierarchy/STA is *discovered* remains open (Badre et al. 2010 give the biology; the training algorithm is unspecified).
4. **Biologically-plausible slow-W at scale** — EqProp is exact-but-unscaled; target-prop is scalable-but-biased (Bartunov et al. 2018).
5. **Autonomous goal inference** (ARC-AGI-3) — inferring the objective, not just the transformation; absent from all mainstream architectures, and the defining case of the *verifier-free* regime the solver stack (§4.6) cannot enter (no external kernel to certify a latent goal). **Candidate internal substitute for the missing verifier:** intrinsic motivation — dopamine's dual role (RPE + novelty) bootstrapping a goal from scalar valence, blended with learning-progress + empowerment to avoid the noisy-TV trap — plus a pretrain → imitate → practice curriculum in which worked-example imitation cheaply supplies the latent path (the single most expensive object in §2's taxonomy). Worked out in [[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]].
6. **Objectness / Core-Knowledge priors from naturalistic data** without hand-coding.

---

## 10. Conclusion

The literature synthesized here supports a clear and defensible direction. The target capability (abstract reasoning) reduces to a single well-posed problem (latent graph discovery); the reason scale has not solved it is structural (missing factorization → unreachable manifold), not empirical; and the brain supplies a convergent, increasingly formalized blueprint (factorized two-timescale world model + hierarchical PFC control + planning-as-inference). The field's frontier gap is narrow and specific — **inferring latent transformation rules while retaining meta-graph transfer** — and the highest-leverage contribution is therefore an inverse-path-integration "Transformation Inferrer" grafted onto a TEM-lineage factorized world model, evaluated on structure-novel, shortcut-resistant benchmarks. Every subsidiary choice (two timescales, gradient/meta-training of W, STA planning, objectness front-end) follows from the evidence rather than convenience. This is the rationale on which a concrete method can now be built.

---

## Implications

- The method's novelty claim should center on **Block 3A (Transformation Inferrer)** — it is where the field's isolated gap and the wiki's proposed mechanism coincide.
- Benchmark selection is a *methodological commitment*, not a detail: ARC-AGI-2/3 with dual-channel scoring, not accuracy-only on contaminated sets.
- The metric-vs-declarative format fork should be resolved before implementation, as it determines whether the grid substrate is load-bearing.

## Follow-up Questions

- Is set-attention over Δg sufficient for *multi-step* transformation chains (A→B→C), or is iterative inference required (building-blocks follow-ups)?
- Can Block 1B's continuous SO(N) rotation be pre-trained on spatial navigation and transferred to abstract domains by fine-tuning only the v→R(v) map?
- What is the minimum number of hierarchical levels (Block 3C) to solve ARC-AGI-2 — two (meta+instance) or three?
- Does STA's wall-gating generalize from edge *masking* to edge *appearance*, the boundary between planning and continual structure learning?
