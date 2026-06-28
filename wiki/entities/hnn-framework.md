---
title: "HNN Framework (Hybrid Neural Networks)"
type: entity
tags: [hybrid-neural-networks, snn, ann, neuromorphic, reasoning, continual-learning, neuromodulation, visual-tracking, hybrid-units]
created: 2026-06-26
updated: 2026-06-26
sources: [A framework for the general design and computation of hybrid neural networks]
related: [wiki/entities/snn.md, wiki/concepts/working-memory.md, wiki/concepts/neuromodulation.md, wiki/concepts/continual-learning.md, wiki/concepts/hebbian-learning.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/meta-learning.md, wiki/papers/zhao-2022-hnn-framework.md, wiki/entities/ch-hnn-model.md]
---

# HNN Framework (Hybrid Neural Networks)

**A general design framework combining SNNs and ANNs via learnable/designable Hybrid Units (HUs); demonstrated across sensing (HSN), meta-continual learning (HMN), and interpretable multimodal reasoning (HRN).**

---

## Hybrid Unit (HU) Formalism

The central primitive: a four-stage interface between heterogeneous representations.

$$Y = \text{HU}[X] = Q \cdot F \cdot H \cdot W(X)$$

| Stage | Symbol | Function |
|---|---|---|
| **Window** | W | Synchronize time scales via parametric window W(t, k, T_s); truncates async SNN/sync ANN timebases |
| **Kernel** | H | Convolve with kernel H(t) to extract spatiotemporal features; output: intermediate h(t, k) |
| **Nonlinear transform** | F | Arbitrary nonlinear function for complex domain-to-domain mapping |
| **Discretization** | Q | Threshold or integrate to produce spike trains (→SNN) or real-valued sequences (→ANN); omitted in modulation HUs |

**Configuration modes:**

| Mode | When to use | Training |
|---|---|---|
| **Designable HU** | Known, deterministic, simple relationship between representations | Manual parameter setting from prior knowledge |
| **Learnable HU** | Non-deterministic, complex, or unknown relationship | Joint training with connected networks; independent goal; or full-model training |

Universal approximation capability: H and F together can approximate any target transformation (via kernel + nonlinear composition).

---

## Three Instantiations

### HSN — Hybrid Sensing Network (visual tracking)

| Pathway | Paradigm | Information | Mechanism |
|---|---|---|---|
| "What" | ANN | Static frame features SF(t) | Fully convolutional feature extractor |
| "Where" | SNN (LIF) | Dynamic Δ features ΔDF(Δt) | Event-driven spike encoding of frame differences |
| Fusion | Learnable HU | SF(t) + HU[ΔDF(Δt)] → predicted next-frame features | Jointly trained HU bridges SNN dynamic output to ANN feature space |

**Results (Tianjic neuromorphic chip):** 5952 FPS, 129 μJ/inference — 11× faster than pure ANN; 2× more energy-efficient; 0.679 mIoU online vs. 0.33 mIoU for pure ANN (real-world latency included).

**Biological analog:** ANN "what" ≈ midget-parvocellular (P) pathway; SNN "where" ≈ parasol magnocellular (M) pathway.

---

### HMN — Hybrid Modulation Network (meta-continual learning)

ANN backbone encodes task context → learnable HUs generate per-SNN-neuron threshold modulation vectors V_th:

$$V_{\text{th},i} = \max\left(\mathbb{E}_{(x,y) \in \mathcal{D}_i}[\text{HU}[\text{ANN}(x)]] - \tfrac{1}{2},\ 0\right)$$

Applied threshold in SNN branch: $\tilde{v} = (1 - V_{\text{th},i}) \cdot v_T$

High V_th → neuron inhibited (blocks irrelevant task interference); low V_th → neuron excitable (subnet reuse for similar tasks). Training objective aligns modulation cosine similarity with task Hamming similarity.

**Results (permuted N-MNIST, 40 MCL tasks):** HMN accuracy keeps improving with sequential tasks; single SNN saturates and forgets. HMN outperforms SNN+EWC, SNN+SI, SNN+CDG. Similar tasks cluster in t-SNE of V_th — backbone learns genuine task-similarity geometry.

**Biological analog:** ANN backbone ≈ slow neuropeptide network; threshold modulation ≈ cortical gain/excitability modulation by diffuse neuromodulatory signals.

---

### HRN — Hybrid Reasoning Network (multimodal VQA)

Two-tier structure for interpretable causal reasoning on CLEVRER (descriptive / explanatory / predictive / counterfactual):

**ANN frontend:**
- Mask RCNN: extracts color, shape, material, mask per object
- PropNet: predicts motion trajectories and collision events
- SGM (Sequential Generation Model): translates questions into sequential instruction tokens

**SNN backend (integrate-and-fire graph):**
- *Representative neurons*: symbolic concepts (red, cube, shape, collision, …)
- *Functional neurons*: logical operators (inhibition, excitation, copy, filter, order, …)
- *Edges*: working memory — long-term priors (prior knowledge: "red is a color") + perceived scene bindings (Hebb-written current episode: "object A is red")

**HU interfaces:**
- *Designable HUs* → static attributes to spike stimuli; constructs object–attribute connections via Hebb rules
- *Learnable HUs* → dynamic event detection (collision) from multi-frame trajectories (UNet + 2× MLP heads); supervised with CE + MSE

**Execution:** SGM generates instructions → HU converts to spike stimuli → SNN propagates via graph logic → response node fires when network stabilizes → output read from active node.

**Results (CLEVRER):**

| Question type | Accuracy |
|---|---|
| Descriptive | 91.7% |
| Explanatory | 95.3% |
| Predictive | 86.0% |
| Counterfactual | 78.8% |

Latency remains constant as scene object count grows (parallel SNN evaluation). Robust to noisy/abnormal HU detections — prior knowledge graph constrains answer space, unlike program-based models that fail on abnormal input.

**Biological analog:** HRN ≈ simplified PFC working memory — SNN symbolic substrate does reasoning; ANN perception modules provide grounded sensory input from other cortical areas.

---

## Comparison to Related Models

| Model | Paradigm | Reasoning | Interpretable | One-shot | CL |
|---|---|---|---|---|---|
| **HRN** | Hybrid ANN+SNN | VQA (causal) | Yes (instruction set) | Yes (Hebb) | — |
| **HMN** | Hybrid ANN+SNN | Continual classification | No | No | Task-agnostic; no memory overhead |
| **CH-HNN** (Shi 2025) | Hybrid ANN+SNN | Continual classification | No | No | Task-agnostic; metaplasticity; bidirectional loop |
| **DNC** | ANN + external memory | Graph traversal | No | No | — |
| **NS-DR** | ANN + symbolic | VQA (static) | Partial | No | — |
| **LISA** | Connectionist-symbolic | Analogy | Via synchrony | No | — |
| **SNN (pure)** | SNN | Classification | No | Partial | Poor (forgetting) |

---

## Design Implications for a Reasoning Model

1. **ANN–SNN split by abstraction level:** ANN handles continuous, high-dimensional perceptual grounding (images, language); SNN handles discrete, sparse symbolic reasoning. HUs are the principled interface — this is more modular than end-to-end hybrid training.
2. **One-shot Hebb binding for scene content:** HRN's Hebb-written perceived edges show that one-shot episodic writes (fast-M) into a symbolic substrate are achievable without backpropagation at inference time.
3. **Threshold modulation as artificial neuromodulation:** HMN shows that a learned ANN signal encoding task similarity can modulate SNN excitability to enable parameter reuse and prevent catastrophic forgetting — a direct implementation of the neuromodulation-as-CL-gating principle.
4. **Dual-pathway sensing:** HSN's ANN+SNN "what"+"where" split achieves Pareto-optimal efficiency×precision that neither paradigm achieves alone — a design template for any perception module requiring both dense feature extraction and efficient event-driven dynamics.

---

## Limitations

- HRN instruction set is manually constructed and domain-specific; extending to open-domain reasoning requires a scalable symbol grounding pipeline.
- HMN requires backbone pre-training on all tasks before SNN continual learning — not fully online; task similarity must be available at training time.
- All three demos use homogeneous ANN/SNN sub-networks; cross-paradigm heterogeneous dynamics (e.g., temporal coding + rate coding within the same ANN block) are unexplored.

---

## Connections

- **[[wiki/entities/snn.md]]** — HRN's SNN backend extends the SNN framework to graph-structured symbolic reasoning, showing that integrate-and-fire dynamics can implement interpretable logical operations (filter, inhibit, copy, order) beyond classification.
- **[[wiki/concepts/working-memory.md]]** — HRN implements a graph-based hybrid WM: the SNN graph encodes prior knowledge (slow-W analog) and Hebb-writes perceived scene bindings (fast-M analog); spike propagation across this graph constitutes the reasoning trajectory.
- **[[wiki/concepts/neuromodulation.md]]** — HMN's ANN-generated threshold modulation vectors are an artificial implementation of neuromodulatory gain control: high V_th inhibits neurons (mimicking ACh/DA-mediated threshold elevation), enabling task-specific subnet activation without catastrophic interference.
- **[[wiki/concepts/continual-learning.md]]** — HMN achieves meta-continual learning by learning a task-similarity geometry in the modulation space; similar tasks reuse overlapping subnets while dissimilar tasks activate disjoint populations, implementing the biological parameter-reuse and interference-prevention principles in an artificial hybrid architecture.
- **[[wiki/concepts/hebbian-learning.md]]** — HRN uses Hebb rules to bind perceived object attributes (ANN detections → spike stimuli) to SNN concept nodes, providing a concrete implementation of one-shot Hebb binding for symbolic content within a reasoning architecture.
- **[[wiki/concepts/hierarchical-representations.md]]** — HMN is a two-level cross-paradigm hierarchy: ANN backbone abstracts high-level task context; SNN branch executes specific tasks under modulation; HUs link the levels, providing a template for cross-paradigm hierarchical architectures.
- **[[wiki/concepts/meta-learning.md]]** — HMN's meta-continual learning shares the structure of outer/inner loop meta-learning: ANN backbone (outer, learned to encode task similarity) guides SNN branch (inner, adapts to each task under threshold modulation).
- **[[wiki/papers/zhao-2022-hnn-framework.md]]** — primary source; full architecture details, training objectives, and quantitative results for all three demonstrations.
- **[[wiki/entities/ch-hnn-model.md]]** — independent parallel architecture (Shi et al. 2025) that applies ANN→SNN episode routing to the explicit mPFC-CA1/DG-CA3 corticohippocampal circuit, adds metaplasticity, and validates the bidirectional loop — extending HMN with biological grounding.
