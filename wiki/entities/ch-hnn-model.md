---
title: "CH-HNN (Corticohippocampal Hybrid Neural Network)"
type: entity
tags: [continual-learning, hybrid-neural-networks, snn, ann, corticohippocampal, metaplasticity, episode-inference, neuromorphic]
created: 2026-06-27
updated: 2026-06-27
sources: [Hybrid neural networks for continual learning inspired by corticohippocampal circuits]
related: [wiki/concepts/continual-learning.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/hnn-framework.md, wiki/concepts/neuromodulation.md, wiki/entities/snn.md, wiki/concepts/engrams.md, wiki/papers/shi-ch-hnn-2025.md]
---

# CH-HNN (Corticohippocampal Hybrid Neural Network)

**A hybrid ANN+SNN continual learning architecture that maps the mPFC-CA1 (generalized memory) / DG-CA3 (specific memory) corticohippocampal recurrent loop onto an ANN (slow, offline) / SNN (fast, incremental) split — achieving task-agnostic continual learning via episode inference without memory overhead.**

---

## Architecture

| Component | Biological analog | Computational role |
|---|---|---|
| ANN (3-layer FC, 64/256 units) | mPFC-CA1 circuits | Offline; learns cross-episode regularities; generates modulation mask **R** |
| SNN (3-layer; EIF/LIF/IF neurons) | DG-CA3 circuits | Online incremental; encodes specific episodes under ANN guidance |
| Modulation mask **R** | mPFC-CA1 → DG-CA3 feedforward | Sparse binary n×c matrix; selectively gates SNN hidden neurons per episode |
| Metaplasticity f(m,W) | DA/5-HT modulation of DG-CA3 | Decays per-synapse plasticity as weights accumulate |
| LPC feedback (hypothesized) | Lateral parietal cortex → DG-CA3 | Proposed source of metaplasticity modulation; not directly modeled |

**Feedforward loop (mPFC-CA1 → DG-CA3):**

$$\mathbf{R} = A(\mathbf{x};\theta_A), \quad \text{out} = W_3 \prod_{l=1}^{2} \underline{\mathbf{R}_l} \cdot \theta^l(\text{BN}(W_l \mathbf{x}))$$

ANN training objective — masks should mirror inter-episode similarity with sparsity control:

$$\min_{\theta_A} \sum_i \left[ \left| \frac{\mathbf{R}_i \tilde{\mathbf{R}}_i}{|\mathbf{R}_i||\tilde{\mathbf{R}}_i|} - \text{sim}(\mathbf{x}, \tilde{\mathbf{x}}) \right|^p + \beta \left| \|\mathbf{R}_i\|_1 - \rho c \right| \right]$$

**Metaplasticity (both SNN and ANN in incremental mode):**

$$W_{i+1} = W_i - \alpha f(m, W_i), \quad f(m, W_i) = e^{-|mW_i|}$$

As |W| grows → f → 0: highly-committed synapses resist further change, protecting established memories.

---

## Key Results

| Benchmark | Scenario | Result |
|---|---|---|
| pMNIST (40 tasks) | Task-incremental | Rising accuracy with tasks; inter-episode disparity 12.53% vs. 29.77% without metaplasticity |
| sCIFAR-100 | Task-incremental | Outperforms EWC, SI, XdG; inter-episode disparity 17.32% vs. XdG's 48.76% |
| sCIFAR-100 / sTiny-ImageNet | Class-incremental | Outperforms EWC, SI, XdG, iCaRL, FOSTER with any neuron model |
| sTiny-ImageNet | Class-incremental | 70.72% avg accuracy; inter-episode disparity 44.34% |
| ImageNet→CIFAR-100 | Knowledge transfer | Retains top performance with ANN pre-trained on disjoint ImageNet |
| Neuromorphic energy | Hardware simulation | SNN 60.82% lower power than ANN for new concept learning |

Ablation: episode inference provides ~100% of the performance gain in class-incremental; metaplasticity primarily rescues scenarios where ANN guidance is inaccurate (off-domain priors).

---

## Comparison to Related Models

| Model | Biological basis | Task-agnostic | Reuse | Memory overhead | Metaplasticity |
|---|---|---|---|---|---|
| **CH-HNN** | mPFC-CA1/DG-CA3 recurrent loop | Yes | Yes (episode inference) | None | Yes (exponential) |
| **HMN** (Zhao 2022) | Cortical neuromodulatory gain | Yes | Yes (threshold modulation) | None | No |
| EWC | Synaptic consolidation | Soft (needs F_i) | No | No | No |
| iCaRL/FOSTER | — | No (task-class oracle) | No | Yes (growing) | No |
| XdG | Cortical gating | No (task oracle) | Partial | No | No |

**CH-HNN vs. HMN:** Both achieve task-agnostic learning via ANN-guided SNN subnet gating without memory overhead. CH-HNN adds (1) explicit corticohippocampal circuit mapping, (2) metaplasticity, (3) validated bidirectional loop, and (4) biologically derived neuron models. HMN uses learnable HU formalism and threshold modulation; CH-HNN uses binary masks and cosine-similarity alignment.

---

## Limitations

- ANN requires offline training access to task-similarity structure or sufficiently similar prior knowledge; not fully online
- Benefits degrade when inter-episode correlations are weak or absent
- Only 3-layer networks evaluated; scalability to deep hierarchies is unclear
- Simplified circuit: omits EC, CA1 invertible mapper role, and interneuron diversity

---

## Connections

- **[[wiki/concepts/continual-learning.md]]** — CH-HNN instantiates the CLS two-system principle: ANN = slow cortical consolidation (mPFC-CA1); SNN = fast specific encoding (DG-CA3); episode inference achieves task-agnostic routing without replay, memory overhead, or task oracle
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — provides direct computational evidence for mPFC-CA1 (generalization) vs. DG-CA3 (specificity) functional dissociation and validates the bidirectional recurrent loop via ablation experiments
- **[[wiki/entities/hnn-framework.md]]** — parallel ANN+SNN approach (HMN); CH-HNN extends with explicit corticohippocampal circuit mapping, metaplasticity, and bidirectional loop validation; both are task-agnostic without memory overhead
- **[[wiki/concepts/neuromodulation.md]]** — metaplasticity mechanism f(m,W) = exp(-|mW|) is modeled after DA/5-HT chemical modulation of DG-CA3 synaptic plasticity, bridging neuromodulatory theory to a concrete weight-update rule
- **[[wiki/entities/snn.md]]** — SNN (EIF/LIF/IF) serves as the DG-CA3 analog; more complex neuron models (EIF > LIF > IF) yield progressively better performance; SNN sparse firing enables 60.82% power reduction on neuromorphic hardware
- **[[wiki/concepts/engrams.md]]** — CH-HNN's success with episode inference (ANN-guided SNN routing) over per-episode engrams suggests episodes may be processed via regularities rather than distinct physical memory allocations
- **[[wiki/papers/shi-ch-hnn-2025.md]]** — primary source with full architecture details, training objectives, ablation studies, and quantitative benchmarks
