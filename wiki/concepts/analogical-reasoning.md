---
title: "Analogical Reasoning"
type: concept
tags: [analogy, relational-reasoning, abstract-reasoning, binding-problem, schema-induction, PFC, CWSG, LISA]
created: 2026-06-20
updated: 2026-06-20
sources: [analogy_reasoning.md]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/binding-problem.md, wiki/concepts/working-memory.md, wiki/concepts/cognitive-control.md, wiki/concepts/meta-learning.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/hierarchical-representations.md, wiki/entities/prefrontal-cortex.md, wiki/papers/analogy-holyoak-2012.md]
---

# Analogical Reasoning

**Analogical reasoning = systematic transfer of relational structure from a better-understood source analog to a novel target analog, generating new inferences and abstract schemas by exploiting role-based relational correspondences rather than surface similarity.**

The prototype of [[wiki/concepts/abstract-reasoning.md]]: it requires role-filler binding, simultaneous constraint satisfaction in WM, causal model construction, and schema induction — the full abstract-reasoning stack in a single task class.

---

## Algorithm: Four Components

| Stage | Operation | Bottleneck |
|---|---|---|
| **Retrieval** | Surface-biased LTM access; relational cues contribute when salient surface similarity also present | Surface bias: 88% same-domain retrieval vs. 12% remote-domain, even when mapping accuracy is equal (~86%) |
| **Mapping** | Constraint-satisfaction over three simultaneous constraints | WM: ≤2–3 propositions active simultaneously; frontal damage selectively impairs multi-relation problems |
| **Inference** | CWSG: copy unmapped source propositions, substitute mapped target elements, postulate new elements where no mapping exists | Inference from mismapped or under-mapped source → systematic errors; causal structure constrains which inferences are licensed |
| **Schema Induction** | Abstract shared relational pattern from two+ compared analogs | Schema formation requires active comparison, not passive exposure; incorrect comparison ordering inhibits schema formation |

---

## Multiconstraint Theory

Optimal mapping `MAP*` satisfies three constraints simultaneously (Holyoak & Thagard 1989):

```
MAP* = argmax_M [ α · Structure(M) + β · Similarity(M) + γ · Pragmatic(M) ]
```

- **Structural:** consistent 1-to-1 correspondences; higher-order relations preferred (causal backbone)
- **Semantic:** similar objects map to similar objects (surface + deep)
- **Pragmatic:** goal-relevant elements prioritized over incidental ones

Constraints converge on a unique mapping in most cases; when they conflict, bistable mappings arise (e.g., Persian Gulf–WWII yields two equally coherent but incompatible correspondence sets). Cross-mappings (one candidate optimal by structure, another by similarity) are especially difficult and require PFC interference suppression to resolve.

---

## Copy-With-Substitution-and-Generation (CWSG) Inference Algorithm

For each proposition `p` in Source:
1. If all role-fillers in `p` have mapped correspondents in Target → generate target proposition by substitution
2. If some role-fillers are unmapped → postulate new target elements as needed
3. Constrain generated inferences by the causal model of the source (causes constrain what effects can be inferred)

Unlike production rules, CWSG has no fixed "left-hand / right-hand" division — any subset of the two analogs can seed the mapping, and the unmapped remainder generates inferences (**omnidirectional access**). This makes it more flexible than rule application but computationally underconstrained without a causal model to filter inferences.

---

## LISA (Learning and Inference with Schemas and Analogies): Symbolic-Connectionist Implementation

| Component | Description |
|---|---|
| Units | Hierarchy: semantic features → predicate/object units → proposition units |
| **Binding** | Role-filler bindings encoded by **gamma-band (~40 Hz) temporal synchrony**: units within one proposition co-active in phase; different propositions active in anti-phase |
| WM | Driver (active propositions): ≤2–3 simultaneously; recipient (LTM candidates) activated by the semantic pattern |
| Mapping connections | Grow when source and target units are co-active during retrieval; enable learned structural correspondences |
| Inference | Uses learned correspondences + CWSG to generate new target propositions |

The 2–3 proposition WM limit matches the empirical relational complexity ceiling: frontal patients fail only when ≥2 relations must be held simultaneously (Waltz et al. 1999); normal adults show latency increases proportional to relational complexity.

---

## Neural Substrate

| Subregion | Role | Evidence |
|---|---|---|
| **Frontopolar PFC (BA-10)** | Integrating **multiple simultaneous relational constraints** | Selective activation at ≥2 relations in RPM, verbal analogy (Christoff 2001; Kroger 2002; Cho 2010); remains active after controlling for RT |
| Mid/inferior frontal gyri | Maintaining individual relation representations in WM during integration | Bilateral activation proportional to relational complexity |
| **Inferior frontal gyrus (BA-44/45)** | Interference suppression (semantically close distractors) | Selective impairment in negative-SFI analogy problems (Morrison et al. 2004; Krawczyk et al. 2008) |
| Hippocampus | Episodic analog storage and retrieval; schema induction from comparison | Required for analog access; schema retroactively enhances past-episode retrieval (Gentner et al. 2009) |
| Anterior temporal cortex | Semantic relation storage | Temporal lesions impair encoding of relations uniformly (vs. frontal: selective impairment) |

**Key dissociation:** temporal lobe lesions impair *all* verbal analogy performance uniformly (loss of relational content); frontal lesions selectively impair *multi-relation integration* (loss of simultaneous constraint satisfaction). These are separable deficits.

---

## Schema Induction as Relational Meta-Learning

Two compared analogs → one abstract relational schema, which then:
- Increases retrieval of structurally matching analogs from LTM (even episodes stored before the schema was induced)
- Transfers to novel problems with 80%+ success rate after 3-analog training with abstraction prompting (Catrambone & Holyoak 1989)
- Enables progressive alignment: easy pairs (surface + relational match) bootstrap relational categories, and later relational-only pairs extend them

This is the analogical-level implementation of slow-W structure extraction from episodic comparison — the same computation that MLC episodic meta-training performs at the grammar level.

---

## Implications for Building a Reasoning Model

1. **The retrieval gap is a diagnostic of abstract reasoning failure:** LLMs with next-token training replicate the surface-retrieval bias (high within-domain transfer, poor far-transfer) even when their mapping capacity is intact. This is not a scale problem; it is a structural bias in the training objective that makes relational structure invisible as a retrieval cue.

2. **The ≤2-3 proposition WM limit constrains Block 3C design:** the frontopolar multi-relational integration bottleneck means that the three-level rule hierarchy (BA-8→9/46→10) must decompose complex compositional chains into segments that each fit within a ≤3 proposition working window. Long compositional chains require sequential staging, not simultaneous integration.

3. **CWSG + causal model = the inference engine that Block 3A implements:** the Transformation Inferrer must not merely identify which transformation W fits, but use that transformation as a causal source model from which CWSG generates target predictions — omnidirectional access to the inverse is essential for counterfactual and goal-flexible use.

4. **Schema induction from episodic comparison is the missing mechanism in the current building-blocks sketch:** the slow-W extraction process should be described not just as "statistical learning" but as analogical schema induction over episodic pairs — this gives a more constrained target for Block 3C content and a biologically grounded learning signal.

---

## Open Problems

1. **Autonomous relational learning:** how does the system discover role-filler structure from non-relational perceptual inputs without hand-coded predicates?
2. **Flexible re-representation on the fly:** reasoners re-chunk knowledge to make latent analogies visible; no current model handles this.
3. **Far structural retrieval:** the retrieval gap — surface-dominated LTM access even when structural cues are present — remains largely unresolved in AI systems.
4. **Causal model construction:** CWSG requires the source to be understood as a causal model, but how the causal model is formed from limited experience is not specified within analogy theory.

---

## Connections

- **[[wiki/concepts/abstract-reasoning.md]]** — analogy is the canonical operationalization of abstract reasoning: it requires all three Lake et al. ingredients (compositionality + causality + learning-to-learn) in a single task, and the retrieval gap is a precise diagnostic of abstract-reasoning failure.
- **[[wiki/concepts/binding-problem.md]]** — LISA's gamma-band temporal synchrony is the fifth binding mechanism: role-filler binding by synchronous co-activation within a proposition, with different propositions separated by anti-phase timing.
- **[[wiki/concepts/working-memory.md]]** — the ≤2-3 proposition WM limit in LISA mirrors the empirical relational integration ceiling; this is a relational capacity limit distinct from the attention entropy bottleneck in transformers (which is positional/temporal, not structural).
- **[[wiki/concepts/cognitive-control.md]]** — frontopolar PFC (BA-10) is activated for simultaneous multi-relational integration — the constraint-satisfaction stage of mapping — not just for rule nesting depth; this refines how the three-level Block 3C hierarchy should be decomposed.
- **[[wiki/concepts/meta-learning.md]]** — schema induction from episodic analog comparison is the relational-level meta-learning mechanism: two episodes → one abstract schema, instantiating slow-W structure extraction at the relational/rule level.
- **[[wiki/concepts/structural-generalization.md]]** — structural generalization is what successful analogical transfer achieves: same relational structure, new content fillers; TEM's W/M factorization is the architectural solution to what multiconstraint mapping does episodically.
- **[[wiki/concepts/compositional-generalization.md]]** — the relational shift (object similarity → structural role dominance in development) parallels the chunking/systematicity failure in neural networks; both reflect failure to represent role-filler bindings independently of specific content.
- **[[wiki/entities/prefrontal-cortex.md]]** — frontopolar cortex (BA-10) is the neural bottleneck for the mapping stage: it integrates multiple simultaneous relational constraints, with the inferior frontal gyrus handling distractor suppression separately.
- **[[wiki/papers/analogy-holyoak-2012.md]]** — primary source; covers multiconstraint theory, LISA model, four-component decomposition, developmental evidence, and neuroimaging.
- **[[wiki/concepts/latent-graph-discovery.md]]** — analogy is a special case of latent edge discovery: given a source graph (understood causal model) and a target (partially observed), CWSG maps source edge labels onto target nodes and infers unobserved target edges; schema induction from two analogs is meta-graph discovery — building a new meta-graph entry from episodic comparison.
- **[[wiki/concepts/hierarchical-representations.md]]** — the ventral-stream identity factorization (CLSU stages) provides the role-filler-separated representations that analogical mapping operates on; feedforward hierarchy is the perceptual prerequisite for relational structure extraction.
