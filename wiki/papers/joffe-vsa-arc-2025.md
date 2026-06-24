---
title: "Vector Symbolic Algebras for the Abstraction and Reasoning Corpus"
type: paper
tags: [VSA, HRR, neurosymbolic, binding, ARC, program-synthesis, spatial-semantic-pointers, grid-cells]
created: 2026-06-24
updated: 2026-06-24
sources: [Vector Symbolic Algebras for the Abstraction and Reasoning Corpus.md]
related: [wiki/entities/vsa-model.md, wiki/concepts/binding-problem.md, wiki/concepts/path-integration.md, wiki/concepts/latent-graph-discovery.md, wiki/entities/ARC-AGI.md, wiki/concepts/abstract-reasoning.md]
---

# Vector Symbolic Algebras for the Abstraction and Reasoning Corpus

**Joffe & Eliasmith, Centre for Theoretical Neuroscience, University of Waterloo. 2025.**

First application of VSAs to ARC-AGI. Object-centric program synthesis solver using Holographic Reduced Representations (HRRs) and Spatial Semantic Pointers (SSPs) for object encoding, guided search, and lightweight neural rule learning.

---

## Key Computational Insights

- **VSA circular convolution as role-filler binding.** HRR (Holographic Reduced Representations) binding (ROLE ⊛ FILLER) encodes structured objects (colour, SSP centre, bundled shape) in fixed-width distributed vectors; unbinding c ⊛ a⁻¹ ≈ b recovers any component. Directly implements the binding problem for visual grid reasoning without conjunctive neuron explosion.
- **SSPs implement path integration in representation space.** $\phi(\mathbf{x}) = \mathcal{F}^{-1}\{e^{i\Theta \mathbf{x}/l}\}$ extends HRR (Holographic Reduced Representations) to continuous spatial domains; the key property is that binding = addition in feature space: $\phi(\mathbf{x}_1) \circledast \phi(\mathbf{x}_2) = \phi(\mathbf{x}_1 + \mathbf{x}_2)$. Specific choices of phase matrix $\Theta$ produce hexagonal grid-cell-like representations — the MEC spatial code emerges from fractional binding structure.
- **System 1 / System 2 via VSA similarity vs. DSL (Domain-Specific Language) search.** Cosine similarity (dot product) over object representations is the fast S1 heuristic pruning the object-hypothesis space and inferring object correspondences. Minimum hitting set search over the DSL (Domain-Specific Language) is the slow S2 generating the simplest consistent program. No deep learning; comparable to GPT-4 on ConceptARC at ~1% of compute cost.
- **Single-layer prototype learner.** Rule predictor NNs are 1-layer; the learned weight vector (restricted to unit norm) is itself a valid VSA vector — the prototype of objects satisfying the rule condition. Directly interpretable: weight vector ≈ centroid of training examples subject to the operation.
- **Vocabulary co-discovery as the residual bottleneck.** 94.5% Sort-of-ARC (fully known vocabulary) → 3.0% ARC-AGI-1-Eval (open vocabulary) isolates the unknown-vocabulary hardness source: the hand-crafted DSL (Domain-Specific Language) (11 operations, 3 object types) cannot express transformations absent from the pre-specified set.

## Limitations

Workshop/preliminary paper (2025); hand-crafted DSL (Domain-Specific Language) is the principal limitation. No multi-coloured objects, chained operations, or many-to-one mappings. Phase matrix $\Theta$ is partially hand-specified (not co-discovered from data). No cross-task meta-graph learning — each ARC task solved independently (no slow-W update). 0% on ARC-AGI-2-Eval signals the same vocabulary gap is more acute on harder tasks.

---

## Connections

- **[[wiki/entities/vsa-model.md]]** — entity page for the VSA/HRR/SSP framework: formal operations, SSP derivation, full ARC-AGI results table, and comparison to TEM.
- **[[wiki/concepts/binding-problem.md]]** — circular convolution (ROLE ⊛ FILLER) is the paper's binding mechanism; invertible unbinding avoids conjunctive explosion; the approach directly targets the objectness prior gap identified in ConceptARC literature.
- **[[wiki/concepts/path-integration.md]]** — SSPs implement distributed path integration; φ(x) ⊛ φ(d) = φ(x+d) makes each step a convolution; grid-cell-like periodicity is an emergent property of the fractional binding structure.
- **[[wiki/concepts/latent-graph-discovery.md]]** — empirically isolates hardness source 2 (unknown vocabulary): the Sort-of-ARC vs. ARC-AGI gap is exactly the difference between known-DSL and unknown-DSL edge discovery.
- **[[wiki/entities/ARC-AGI.md]]** — ARC benchmark results; diagnoses the missing vocabulary co-discovery as the next architectural requirement after binding is solved.
- **[[wiki/concepts/abstract-reasoning.md]]** — the System-1/System-2 integration and explicit objectness prior encoding implements the model-building side of the pattern-recognition/model-building distinction at a lower compute budget than LLMs.
