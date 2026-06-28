---
title: "Dendrites endow artificial neural networks with accurate, robust and parameter-efficient learning — Chavlis & Poirazi 2025"
type: paper
tags: [dendritic-computation, parameter-efficiency, mixed-selectivity, continual-learning, bio-inspired-ml]
created: 2026-06-27
updated: 2026-06-27
sources: [Dendrites endow artificial neural networks with accurate, robust and parameter-efficient learning]
related: [wiki/concepts/dendritic-computation.md, wiki/concepts/representational-geometry.md, wiki/concepts/continual-learning.md, wiki/concepts/credit-assignment.md, wiki/concepts/sparse-distributed-representations.md]
---

# Dendrites endow artificial neural networks with accurate, robust and parameter-efficient learning

**Citation:** Chavlis S. & Poirazi P., *Nature Communications*, 22 Jan 2025. https://www.nature.com/articles/s41467-025-56297-9

---

## Key Computational Insights

- **dANN architecture**: sparse two-layer ANN where layer 1 (dendrites) receives restricted input via receptive fields and connects to layer 2 (soma) via structured tree-like masked weights; forward pass is standard; backward pass zeroes gradients at non-existing connections (Hadamard mask).
- **Parameter efficiency**: dANNs match or exceed vanilla ANN (vANN) accuracy on image classification using 1–3 orders of magnitude fewer trainable parameters; gap widens on harder tasks (CIFAR-10).
- **Emergent regularization**: structured sparsity acts as a natural regularizer without dropout or explicit weight decay; overfitting absent even at large model sizes.
- **Both features required**: restricted input sampling and structured internal connectivity each contribute to efficiency; randomly-connected sparse ANNs at matched sparsity are substantially worse.
- **Mixed-selectivity learning strategy**: dANN nodes respond to multiple classes (high entropy, high selectivity index) while vANN nodes become class-specific; dANNs use weights more efficiently (bimodal cable-weight distribution, few near-zero weights).
- **Robustness**: dANNs degrade more slowly under Gaussian input noise and perform better on sequential (class-incremental) learning vs. vANNs of matched accuracy.
- **LRF sampling is best**: local receptive field subsampling (each dendrite receives 16 inputs from a 4×4 neighborhood) is the most efficient configuration, consistent with biological feature-clustered synaptic inputs.

## Limitations

- Masked-gradient implementation requires a Hadamard multiplication after each gradient step, adding FLOPs (floating-point operations); not FLOP-efficient on standard ML hardware despite parameter savings.
- Cable weights are unconstrained (can go negative); biologically realistic models restrict them to positive values.
- Tested only on feedforward classification; integration with convolutional nets or transformers is proposed but not demonstrated.

## Links to Wiki Pages

- [[wiki/concepts/dendritic-computation.md]] — primary concept this paper instantiates
- [[wiki/concepts/representational-geometry.md]] — dANN mixed selectivity is an ML validation of the mixed-selectivity principle
- [[wiki/concepts/continual-learning.md]] — dANN sequential learning robustness as evidence for structured sparsity CL benefits
- [[wiki/concepts/credit-assignment.md]] — masked-gradient backprop as a structured sparse credit assignment implementation
- [[wiki/concepts/sparse-distributed-representations.md]] — bio-inspired structured sparsity outperforms random sparsity at same level
