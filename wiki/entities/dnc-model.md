---
title: "DNC (Differentiable Neural Computer)"
type: entity
tags: [differentiable-neural-computer, external-memory, graph-reasoning, planning, attention, working-memory]
created: 2026-06-22
updated: 2026-06-22
sources: [Hybrid computing using a neural network with dynamic external memory]
related: [wiki/concepts/associative-memory.md, wiki/concepts/working-memory.md, wiki/concepts/sequence-memory.md, wiki/concepts/latent-graph-discovery.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/attention.md, wiki/concepts/two-learning-timescales.md, wiki/papers/dnc-graves-2016.md]
---

# DNC (Differentiable Neural Computer) (Differentiable Neural Computer)

**Neural network controller + external read-write memory matrix, fully differentiable, trained end-to-end with gradient descent. Introduced by Graves et al., Nature 2016.**

---

## Architecture

| Component | Specification | Biological analog |
|---|---|---|
| **Controller** | Recurrent LSTM; outputs interface vector ξ_t and pre-output υ_t | Prefrontal cortex (PFC) |
| **Memory matrix M** | N×W matrix; N locations, W-dimensional vectors; external to controller | Hippocampus (CA3 store) |
| **Write head** | Single write weighting w^w; erase + add vectors; gated by allocation gate g^a and write gate g^w | CA1 BTSP write |
| **Read heads (R)** | R soft attention weightings w^{r,i}; read vectors r^i = Σ_l M[l,·] w^{r,i}[l] | CA3 pattern completion |
| **Temporal link matrix L** | N×N; L[i,j] ≈ 1 iff location i was written after j; sparse approx. at O(N log N) | Temporal context model (free recall) |
| **Usage vector u** | u∈[0,1]^N; tracks cumulative use; free gates release locations after read | DG (Dentate Gyrus) representational sparsity |
| **Allocation weighting a** | Picks least-used location for new writes (differentiable free list) | DG (Dentate Gyrus) adult neurogenesis (new coding units) |

**Three addressing modes** (read heads interpolate via read mode vector π∈S3):

1. **Content lookup** — cosine-similarity key-value:
   `C(M, k, β)[i] = softmax(β · cos(k, M[i,·]))`
   Partial key match suffices; value at matched location includes information absent from the key (associative completion).

2. **Temporal forward/backward** —
   `f^i = L w^{r,i}_{t-1}` (forward);  `b^i = L^⊤ w^{r,i}_{t-1}` (backward)
   Recovers write order regardless of address adjacency; enables replay of input sequences in the order written.

3. **Dynamic allocation** — usage vector u sorts locations by ascending usage; allocation weighting focuses write on least-used slots; free gates set u[i]←0 after read. Memory can be grown at test time without retraining.

---

## Key Results

| Task | DNC (Differentiable Neural Computer) | LSTM | Notes |
|---|---|---|---|
| bAbI mean error (20 tasks) | **3.8%** (2 failed tasks) | 7.5% (6 failed) | Jointly trained; word-level input |
| Graph traversal (London Underground) | **98.8%** | 37% | LSTM fails curriculum entirely |
| Shortest-path (4-step, Underground) | **55.3%** | fails curriculum | Structured prediction; harder |
| Inference (family tree, 4-step relations) | **81.8%** | fails curriculum | Relations never given explicitly |
| Mini-SHRDLU (RL, block puzzle) | **Completes curriculum** | Fails curriculum | — |
| Memory upgrade without retraining | **Yes** (performance scales with N) | N/A | Key architectural claim |

**Planning decode (Mini-SHRDLU):** First-action classification accuracy from memory contents at goal-write time = **89%** (vs. 17% chance baseline) — DNC (Differentiable Neural Computer) committed to a plan in memory many steps before execution.

**Visualization (Fig. 3, London Underground traversal):** Read head 1 uses temporal links forward to retrieve instructions in order; Read head 2 uses content lookup to find stations along the path. The two heads specialize spontaneously: one sequential, one associative.

---

## Comparison to Related Models

| Model | External memory | Sequential retrieval | Dynamic allocation | Cross-episode generalization |
|---|---|---|---|---|
| **DNC** | Yes (N×W, soft) | Yes (temporal links) | Yes (free gates) | No (controller W fixed) |
| NTM | Yes (N×W, soft) | Partial (index-adjacent) | No | No |
| LSTM | No (weights only) | Via hidden state only | N/A | No |
| TEM | Fast-M (Hebbian) | Phase precession + STDP | N/A | Yes (slow W transfers) |
| Memory Networks | Read-only external | No | No | No |

DNC resolves all three NTM limitations: interference (single-location allocation), deallocation (free gates), and order tracking (temporal link matrix replaces index-iteration).

---

## Limitations

- **O(N²) temporal link matrix:** dense L costs quadratic memory and compute; sparse approximation (K=8 non-zero per row/column) reduces to O(N log N) with no performance loss, but the matrix is still the scaling bottleneck.
- **Fixed controller capacity:** meta-graph (slow W) lives in LSTM weights — only instance-graph (fast M) is externalized; no cross-environment structural generalization.
- **No cross-episode memory persistence:** DNC (Differentiable Neural Computer) memory is reset between episodes; long-term consolidation (HC → neocortex) is absent — fast-M only.
- **Synthetic small-scale evaluation:** tasks use ≤512 memory locations; real-world knowledge graph scaling is untested.

---

## Connections

- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — DNC (Differentiable Neural Computer) is the clearest engineered instantiation of the PFC-queries-HC planning architecture: controller=PFC, memory matrix=HC, content lookup=CA3 pattern completion, temporal links=temporal context model for free recall, allocation=DG neurogenesis; three out of three HC mechanisms have direct DNC (Differentiable Neural Computer) analogs.
- **[[wiki/concepts/associative-memory.md]]** — DNC (Differentiable Neural Computer) content lookup generalizes Hopfield's binary CAM (Content-Addressable Memory) to differentiable soft attention over a continuous memory matrix; DNC (Differentiable Neural Computer) demonstrates that external CAM (Content-Addressable Memory) provides graph traversal capability inaccessible to weight-bound associative memory (LSTM: 37%).
- **[[wiki/concepts/working-memory.md]]** — the N×W external memory is a 6th fast WM mechanism: unlimited capacity (memory can be expanded without retraining), entirely external (no weight changes on write), accessed via soft attention — distinct from all five weight-or-activation-bound fast-WM mechanisms.
- **[[wiki/concepts/sequence-memory.md]]** — the temporal link matrix L is a dynamic directed graph over memory locations encoding write order; one-shot sequential encoding (write once → retrieve in order) without STDP training; complementary to DenseNet's weight-encoded sequence memory (DenseNet: many-shot; DNC: one-shot).
- **[[wiki/concepts/latent-graph-discovery.md]]** — first architecture in the wiki empirically verified to solve graph traversal and shortest-path via external memory; satisfies instance-graph binding and sequential path retrieval, but not meta-graph cross-environment learning (controller W is fixed across environments).
- **[[wiki/concepts/attention.md]]** — DNC's three addressing modes are differentiable attention mechanisms; content lookup is equivalent to single-head cross-attention; temporal links are recurrent attention over write-order structure rather than positional encoding.
- **[[wiki/concepts/two-learning-timescales.md]]** — DNC (Differentiable Neural Computer) mechanically instantiates the W/M split: controller LSTM weights = slow W (trained across episodes by BPTT); external memory writes = fast M (written within episode by soft attention with no weight gradient needed for the write itself).
- **[[wiki/papers/dnc-graves-2016.md]]** — source paper; Graves, Wayne et al., Nature 2016.
