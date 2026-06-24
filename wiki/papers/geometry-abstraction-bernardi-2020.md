---
title: "The Geometry of Abstraction in the Hippocampus and Prefrontal Cortex"
type: paper
tags: [representational-geometry, abstraction, CCGP (Cross-Condition Generalization Performance), hippocampus, prefrontal-cortex, mixed-selectivity]
created: 2026-06-21
updated: 2026-06-21
sources: [geometry-of-abstraction-bernardi-2020]
related: [wiki/concepts/representational-geometry.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/factorized-representations.md, wiki/concepts/latent-states.md, wiki/concepts/neural-manifolds.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/prefrontal-cortex.md]
---

# The Geometry of Abstraction in the Hippocampus and Prefrontal Cortex

**Bernardi, Benna, Rigotti, Munuera, Fusi & Salzman — Cell 183(4), November 2020.** DOI: 10.1016/j.cell.2020.09.031

---

## Five Key Computational Insights

- **CCGP as operational abstraction:** a variable is abstract when a linear decoder trained on a subset of conditions generalizes to held-out conditions (cross-condition generalization performance, CCGP (Cross-Condition Generalization Performance)); requires parallel coding directions across condition pairings (quantified by parallelism score, PS); distinct from traditional within-condition cross-validated accuracy — high accuracy does not imply high CCGP (Cross-Condition Generalization Performance).
- **CCGP/SD coexistence:** shattering dimensionality (SD = fraction of all balanced dichotomies linearly decodable) is near-maximal in HPC, DLPFC, and ACC (Anterior Cingulate Cortex) simultaneously with high CCGP (Cross-Condition Generalization Performance) for 2–3 variables; a purely disentangled representation achieves high CCGP (Cross-Condition Generalization Performance) but low SD (Shattering Dimensionality) (XOR unseparable); the observed geometry is a distortion of perfect factorization that recovers near-maximal SD (Shattering Dimensionality) without sacrificing CCGP (Cross-Condition Generalization Performance) for the key abstract variables.
- **Context as canonical abstract hidden variable:** in an uncued serial-reversal task, context (hidden; defined by temporal statistics of events) is represented in abstract format in all three areas before stimulus onset; of 35 possible balanced dichotomies, only context, value, and action achieve high CCGP (Cross-Condition Generalization Performance) — the rest are decodable but not abstract.
- **HPC vs. PFC (Prefrontal Cortex) temporal division:** HPC maintains abstract context through the decision epoch; DLPFC loses context abstraction post-stimulus (context non-linearly mixed with stimulus identity during action selection), recovering it before the next trial; value and action achieve high CCGP (Cross-Condition Generalization Performance) in all areas during the decision; CCGP (Cross-Condition Generalization Performance) for context on error trials is significantly reduced across all areas, while traditional decoding is unchanged — abstraction, not mere decodability, tracks behavioral performance.
- **RL networks develop the same geometry:** DQN trained on the task spontaneously develops abstract context in its final hidden layer despite context not being in the input or output; supervised networks (MNIST parity/magnitude) develop abstract representations for exactly the output dichotomies; geometry is an emergent consequence of the training objective.

## Limitations

- Two monkeys only; pseudo-simultaneous population vectors (neurons from different sessions).
- CCGP (Cross-Condition Generalization Performance) generalizes to "novel to the decoder" conditions, not necessarily to truly novel environments — transfer is proxy, not directly measured.

## Links

→ [[wiki/concepts/representational-geometry.md]], [[wiki/concepts/abstract-reasoning.md]], [[wiki/concepts/factorized-representations.md]], [[wiki/entities/hippocampal-entorhinal-system.md]], [[wiki/entities/prefrontal-cortex.md]], [[wiki/concepts/latent-states.md]]
