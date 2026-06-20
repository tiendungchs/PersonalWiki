---
title: "Hierarchical Representations"
type: concept
tags: [hierarchical-representations, feature-abstraction, manifold-untangling, ventral-stream, deep-learning]
created: 2026-06-20
updated: 2026-06-20
sources: [How does the brain solve visual object recognition]
related: [wiki/concepts/neural-manifolds.md, wiki/concepts/factorized-representations.md, wiki/concepts/structural-generalization.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/binding-problem.md, wiki/concepts/analogical-reasoning.md, wiki/entities/htm-thousand-brains.md, wiki/entities/tem-model.md, wiki/papers/dicarlo-visual-object-recognition-2012.md]
---

# Hierarchical Representations

**Multi-level feature abstraction in which each processing stage applies nonlinear transformations to produce representations with progressively greater invariance to task-irrelevant variation and greater explicit availability of task-relevant structure.**

---

## Manifold Untangling: What Each Level Must Do

Object identity manifolds: for object k, M_k = {v(T(I_k)) : T ∈ identity-preserving transformations} where v(·) is the population response vector. Invariant recognition requires a hyperplane separating M_k from all M_{j≠k}.

| Level | Manifold state | Readout |
|---|---|---|
| Retina / LGN | Highly curved; M_k tangled with M_{j≠k} | Nonlinear classifier needed; fails with any linear scheme |
| V1 | ~30× dimensionality expansion; slightly less tangled | Marginally better than pixel-based baseline |
| V4 | Increasing flatness and separation | Intermediate decoding quality |
| IT (primate) | Flat, separated manifolds | Simple linear classifier from ~300 neurons → near-ceiling human generalization |
| Deep CNN (trained) | Same progression, engineered | Quantitatively approaches IT-level manifold geometry (Yamins & DiCarlo 2016) |

---

## Canonical Mechanism at Each Level: CLSU

Cortically local subspace untangling (DiCarlo et al. 2012) — three genetically encoded mechanisms proposed for each ~40K-neuron cortical sub-population:

1. **NLN non-linearities + divisive normalization** — AND-like conjunctions build selectivity; OR-like (MAX) pooling builds tolerance; normalization provides partial untangling even with random weights.
2. **Natural image statistics tuning** — concentrate response range on the input distribution; avoid encoding rarely encountered patterns.
3. **Unsupervised temporal contiguity learning** — same object produces temporally proximate retinal images (via saccades); learning similar responses for temporally contiguous stimuli factorizes identity from position/scale/pose without labels.

The same motif is applied at every cortical locus, tiled laterally (visual field coverage) and stacked vertically (progressive abstraction). No global coordinator is required; each sub-population only needs to improve local untangling.

---

## Evidence / Instantiations

| System | Levels | Invariances built | Mechanism |
|---|---|---|---|
| Primate ventral stream | V1→V2→V4→IT (~4 stages) | Position, scale, pose, illumination, clutter | NLN cascade + temporal contiguity (saccades) |
| Deep CNNs | 5–150+ layers | ImageNet recognition; near-IT representational geometry | Supervised gradient descent; functionally approximates CLSU |
| HTM cortical column | L6→L4→L2-3 (within column) + cross-column hierarchy | Sensorimotor prediction across reference frames | Predictive coding within each column; same motif replicated in ~150K columns |
| TEM (g/x factorization) | Single global factorization level | Environment-invariant structural code | Explicit factorization at g/x split rather than staged local processing |

---

## Reasoning-Model Implications

1. **Hierarchy is necessary, not sufficient.** The ventral stream produces position/scale/pose invariance — perceptual invariance — but not relational or causal invariance. Abstract reasoning requires a further level of hierarchy organized around *relational structure*, not object identity; the loss objective and the "transformations" to be made invariant to are different.
2. **Local unsupervised learning may suffice.** Temporal contiguity cues bootstrap tolerance without supervision. An analogous unsupervised signal for relational invariance might be *temporal contiguity of relational structure* — if the same structural relationship holds across different surface realizations presented in sequence, a hierarchical system could learn to respond similarly.
3. **The abstraction target determines the architecture.** A vision hierarchy organized around object identity cannot automatically produce relational invariance. The CLSU insight is that the meta job description ("what should be untangled locally?") must match the target invariance; for abstract reasoning, the meta job description needs to be "untangle relational structure from surface content."
4. **Feedforward hierarchy ≠ reasoning.** Core recognition achieves 150 ms performance without top-down feedback; this is precisely the pattern recognition regime. Abstract reasoning requires reentrant processing for hypothesis testing — hierarchy is the substrate, but the computational mode differs.

---

## Open Problems

1. What determines the number of levels required? Visual hierarchy converges in 4–5 stages; relational/abstract hierarchy depth is unknown.
2. Does the same CLSU mechanism generalize to relational abstraction, or is a fundamentally different learning rule needed?
3. Can a single hierarchical system produce both perceptual invariance and relational invariance, or must these be separate hierarchies?
4. How are local per-level untangling solutions composed globally without a coordinator? (Lateral connections + normalization suffice for vision; unclear for abstract domains.)

---

## Connections

- **[[wiki/concepts/neural-manifolds.md]]** — object identity manifolds are the geometric objects that hierarchical processing untangles; the manifold perspective provides the formal criterion (hyperplane separability) for what each level must achieve; this paper adds a fourth empirical category (object identity manifold) to the three manifold types documented in neural-manifolds.md.
- **[[wiki/concepts/factorized-representations.md]]** — TEM's g/x factorization is a special case of hierarchical abstraction where the structural dimension is explicitly separated globally; CLSU generalizes this to staged, local factorization of identity from identity-preserving transformations at each cortical level.
- **[[wiki/concepts/structural-generalization.md]]** — hierarchical representations are necessary but not sufficient for structural generalization; structural generalization additionally requires that the relational code be explicitly separated from content, which a generic perceptual hierarchy does not guarantee.
- **[[wiki/concepts/abstract-reasoning.md]]** — core recognition via feedforward hierarchy is the paradigm case of pattern recognition; abstract reasoning requires top-down causal model-building that hierarchical feedforward processing alone cannot provide; the feedforward/feedback distinction maps directly onto the pattern-recognition/model-building distinction.
- **[[wiki/concepts/binding-problem.md]]** — temporal contiguity learning builds separable IT tuning for identity and spatial variables simultaneously, avoiding the need for a downstream binding step; hierarchy solves the binding problem for transformation variables by factorizing them during learning.
- **[[wiki/entities/htm-thousand-brains.md]]** — HTM's ~150K cortical columns each implement the same three-layer CLSU-like hierarchy; the canonical sub-network hypothesis from DiCarlo et al. maps directly to Hawkins's universal cortical algorithm.
- **[[wiki/entities/tem-model.md]]** — TEM represents a single-level global factorization rather than a multi-level staged hierarchy; the relationship between CLSU (staged local) and TEM (global factorized) is an open architectural question.
- **[[wiki/papers/dicarlo-visual-object-recognition-2012.md]]** — primary source for the manifold untangling perspective, the CLSU canonical mechanism, temporal contiguity as unsupervised teacher, and feedforward sufficiency for core recognition.
- **[[wiki/concepts/analogical-reasoning.md]]** — hierarchical-representations describes the perceptual substrate (feedforward manifold untangling) whose output — factored identity representations — is the prerequisite input for relational role-filler binding; the CLSU identity factorization is what makes the role variable slot available for analogical mapping.
