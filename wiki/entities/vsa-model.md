---
title: "Vector Symbolic Algebra (VSA / HRR)"
type: entity
tags: [VSA, HRR, hyperdimensional-computing, neurosymbolic, binding, spatial-semantic-pointers, grid-cells]
created: 2026-06-24
updated: 2026-06-24
sources: [Vector Symbolic Algebras for the Abstraction and Reasoning Corpus.md]
related: [wiki/concepts/binding-problem.md, wiki/concepts/path-integration.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/compositional-generalization.md, wiki/entities/arc-agi.md, wiki/papers/joffe-vsa-arc-2025.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/abstract-reasoning.md]
---

# Vector Symbolic Algebra (VSA / HRR)

**Family of neuro-symbolic algebras over high-dimensional vector spaces bridging distributed connectionist representations with structured symbolic computation.** Holographic Reduced Representations (HRRs) implement binding via circular convolution. Spatial Semantic Pointers (SSPs) extend HRR (Holographic Reduced Representations) to continuous domains, producing grid-cell-like spatial codes.

---

## Core Operations

| Operation | Symbol | Definition | Key property |
|---|---|---|---|
| **Similarity** | $\mathbf{a} \cdot \mathbf{b}$ | Cosine similarity (unit vectors) | Near-zero for random vectors; used for clean-up and querying |
| **Bundling** | $\mathbf{a} + \mathbf{b}$ | Element-wise addition (then normalize) | Result similar to both inputs; implements set superposition |
| **Binding** | $\mathbf{a} \circledast \mathbf{b}$ | Circular convolution: $\mathcal{F}^{-1}\{\mathcal{F}\{\mathbf{a}\} \odot \mathcal{F}\{\mathbf{b}\}\}$ | Result dissimilar to both; creates a unique association |
| **Inversion** | $\mathbf{a}^{-1}$ | $\mathbf{a} \circledast \mathbf{a}^{-1} \simeq \mathbf{I}$ | Unbinding: $(\mathbf{a} \circledast \mathbf{b}) \circledast \mathbf{a}^{-1} \simeq \mathbf{b}$ |

**Slot-filler encoding:** $\sum_i \mathtt{ROLE}_i \circledast \mathtt{FILLER}_i$ stores structured objects in fixed-width vectors regardless of the number of role-filler pairs.

---

## Spatial Semantic Pointers (SSPs)

Extension to continuous feature spaces via fractional binding:

$$\phi(\mathbf{x}) = \mathcal{F}^{-1}\left\{e^{i\Theta \mathbf{x}/l}\right\}$$

| Property | Form | Interpretation |
|---|---|---|
| **Binding = addition** | $\phi(\mathbf{x}) \circledast \phi(\mathbf{d}) = \phi(\mathbf{x} + \mathbf{d})$ | Path integration: one convolution step = one displacement |
| **Inversion = negation** | $\phi(\mathbf{x})^{-1} = \phi(-\mathbf{x})$ | Reverse traversal |
| **Similarity = kernel** | $\phi(\mathbf{x}_1) \cdot \phi(\mathbf{x}_2) = k(\mathbf{x}_1, \mathbf{x}_2)$ | Soft spatial query |
| **Grid-cell periodicity** | Specific $\Theta$ → hexagonal grid patterns | MEC grid codes emerge from fractional binding |

The grid-cell-like periodicity is an emergent property of the fractional binding structure, not separately imposed.

---

## ARC-AGI Results (Joffe & Eliasmith 2025)

Object-centric program synthesis: objects encoded as colour + SSP(centre) + bundled SSP(shape offsets). System 1 = VSA similarity heuristics; System 2 = minimum hitting set Domain-Specific Language (DSL) search.

| Benchmark | Task Accuracy |
|---|---|
| Sort-of-ARC | 94.5% |
| 1D-ARC | 83.1% (vs. GPT-4 at similar difficulty) |
| ConceptARC | 20.5% (vs. GPT-4, at ~1% compute) |
| ARC-AGI-1-Train | 10.8% |
| ARC-AGI-1-Eval | 3.0% |
| ARC-AGI-2-Eval | 0.0% |

**Gap interpretation:** 94.5% (Sort-of-ARC, known vocabulary) → 3% (ARC-AGI-1-Eval, open vocabulary) isolates the unknown vocabulary problem — the hand-crafted DSL (Domain-Specific Language) cannot express novel transformations.

---

## Limitations

- DSL (Domain-Specific Language) (11 operations, 3 object types) is hand-crafted; vocabulary co-discovery is unsolved
- No cross-task meta-graph learning (tasks treated independently)
- Phase matrix $\Theta$ partially hand-specified
- No multi-coloured objects, chained operations, or many-to-one mappings

---

## Comparison to Related Models

| Model | Binding mechanism | Continuous space | Meta-graph learning |
|---|---|---|---|
| **VSA/HRR** | Circular convolution (invertible) | SSPs (fractional binding) | No |
| **TEM** | p = f(g, x) conjunctive layer | Grid codes (learned) | Yes (slow W) |
| **SDM** | Hamming-distance content addressing | No | No |
| **Transformer** | Soft key-value attention | Sinusoidal PE | Implicit in weights |

---

## Connections

- **[[wiki/concepts/binding-problem.md]]** — circular convolution implements invertible role-filler binding: ROLE ⊛ FILLER produces a fixed-width vector; unbinding recovers any component; avoids combinatorial explosion of conjunctive neurons while remaining algebraically queryable.
- **[[wiki/concepts/path-integration.md]]** — SSP binding is path integration in representation space: φ(x) ⊛ φ(d) = φ(x+d) makes each step a convolution; grid-cell-like hexagonal patterns emerge from the phase matrix structure, linking SSP encoding to the MEC mechanism.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — both SDR (Sparse Distributed Representations) and VSA use high-dimensional distributed codes; SDRs are sparse binary (Hawkins), VSAs are dense real-valued; VSA binding (circular convolution) achieves compositionality that SDR (Sparse Distributed Representations) bundling alone cannot; complementary approaches from the same high-dimensionality intuition.
- **[[wiki/concepts/compositional-generalization.md]]** — slot-filler encoding (ROLE ⊛ FILLER + ...) directly implements systematic compositionality: the same binding operation applies to any content, and unbinding recovers any component, satisfying the localism requirement that sub-expression results be bound to their roles.
- **[[wiki/concepts/latent-graph-discovery.md]]** — maps to hardness source 2 (unknown vocabulary): the Sort-of-ARC vs. ARC-AGI gap isolates vocabulary co-discovery; SSP path integration (φ(x) ⊛ φ(d) = φ(x+d)) addresses path-consistency within episodes but no cross-task W is learned.
- **[[wiki/entities/arc-agi.md]]** — VSA solver achieves 3% ARC-AGI-1-Eval; diagnoses vocabulary co-discovery as the residual bottleneck; strong performance on simpler benchmarks confirms the binding and objectness approach is sound.
- **[[wiki/papers/joffe-vsa-arc-2025.md]]** — primary source: HRR (Holographic Reduced Representations) formalism, SSP derivation, ARC-AGI solver architecture, benchmark results, and failure mode analysis.
- **[[wiki/concepts/abstract-reasoning.md]]** — explicit System-1/System-2 integration and objectness prior encoding implement model-building at a fraction of LLM compute; the 20.5% ConceptARC result confirms genuine rule representations rather than shortcut pattern matching.
