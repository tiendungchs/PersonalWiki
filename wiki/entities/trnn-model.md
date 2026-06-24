---
title: "TRNN (Transient Trajectory RNN)"
type: entity
tags: [TRNN, working-memory, transient-dynamics, RNN, recurrent-networks]
created: 2026-06-20
updated: 2026-06-20
sources: [Recurrent neural networks with transient trajectory explain working memory encoding mechanisms]
related: [wiki/concepts/working-memory.md, wiki/concepts/neural-manifolds.md, wiki/entities/reservoir-computing.md, wiki/papers/trnn-liu-2025.md]
---

# TRNN (Transition RNN) (Transient Trajectory RNN)

A recurrent neural network modified to produce transient sequential dynamics during working memory delay periods, outperforming attractor-based RNNs on every evaluated WM task. Liu et al. 2025 ([[wiki/papers/trnn-liu-2025.md]]).

---

## Architecture

Three modifications to a vanilla RNN produce high-TI transient dynamics:

| Modification | Mechanism | Effect |
|---|---|---|
| **Self-inhibition** | $V_t = (1-\alpha_v)V_{t-1} + \alpha_v m r_{t-1}$; neuron input reduced by $\gamma V_t$ | Prevents sustained firing; forces sequential chain propagation |
| **Sparse connections** | Random zero-initialization of proportion of $W_r$ (trainable after init) | Reduces attractor-forming strong recurrence |
| **Hierarchical topology** | Three sub-regions: sensory → association → motor; inter-region connections sparser than intra-region | Critical for high TI; without it TI drops dramatically even with the other two modifications |

**Transient Index (TI)** = peak-firing-time entropy + ridge-to-background ratio + proportion of memory-related peak firing. Higher TI = more transient dynamics = better WM performance.

---

## Key Results

| Property | Attractor RNN (low TI) | TRNN (Transition RNN) (high TI) |
|---|---|---|
| Shannon entropy of delay activity | Low (persistent state) | High (neurons fire at distinct times → uniform distribution) |
| Metabolic cost (avg squared firing rate) | High | Low (stepwise drop with TI) |
| Multi-item capacity | Limited by attractor count | Scales with neuron count N |
| Spatial WM (water maze) | Fails (≈ feedforward baseline) | Succeeds (strong across-trial improvement) |
| Distractor robustness | Lower reward with 3 distractors | Higher reward with 3 distractors |

**Key inference:** transient coding achieves higher capacity AND lower energy simultaneously because information is spread across time (uniform distribution over neurons → maximum entropy). This is not a capacity trade-off.

---

## Variable Delay Mechanism

TRNN handles variable delays (3–6 s) by **recruiting additional neurons**, not by slowing trajectory velocity:
- Early-memory neurons: same functional role in short and long trials
- Late-memory neurons: recruited from baseline and test-response groups for long trials

Implication: WM duration is **neuron-count limited** — longer memory requires more neurons, paralleling the biological 7±2 capacity limit and the "slot" interpretation of WM.

---

## Limitations

- Trained on fixed-length delay distributions; the mechanism for handling unlimited variable delays without an end-of-delay signal is unspecified
- No within-episode RL algorithm (unlike PFC (Prefrontal Cortex) meta-RL LSTM); TRNN (Transition RNN) is a WM buffer, not a policy accumulator — the two must be combined for full meta-RL function
- Whether the three modifications suffice for abstract (non-sensory) WM content is untested
- Combining TRNN (Transition RNN) with STSP (Short-Term Synaptic Plasticity) is unspecified: STSP (Short-Term Synaptic Plasticity) offers structural robustness + activity-silent bridging; TRNN (Transition RNN) offers high multi-item capacity — the interface mechanism is open

---

## Comparison to Related WM Mechanisms

| Mechanism | Storage medium | Write step? | Capacity limit | Structural robustness |
|---|---|---|---|---|
| **TRNN transient trajectory** | Sequential neuron firing chain | None — self-inhibition propagates chain | Scales with neuron count N | Not measured |
| **LTC (liquid τ)** | ODE hidden state with input-dependent τ_sys | None — continuous ODE integration | Not measured; vanishing gradients limit long delays | Yes — Theorems 1 & 2 (bounded τ and state) |
| **LSTM hidden state** | Recurrent activation vector $h_t$ | None — gated accumulation | Hidden dimension | High (most robust to process noise) |
| **STSP / PS-hebb** | Synaptic efficacy (calcium dynamics) | None — spikes drive calcium update | Bounded by calcium decay (~200 ms) | High: 50% ablation tolerated |
| **Hebbian M (TEM/HC)** | Synaptic weight matrix M | Explicit Hebbian write | O(N/log N); O(exp d) modern Hopfield | Not measured |

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — TRNN (Transition RNN) is one of four fast WM mechanisms; comparative debate (attractor vs. transient trajectory) and the full Four Fast Mechanisms table live there; this entity page holds the architecture and implementation details.
- **[[wiki/concepts/neural-manifolds.md]]** — dPCA on TRNN (Transition RNN) delay-period activity reveals a low-dimensional trajectory manifold where stimulus-dependent components remain separated throughout the delay; trajectory velocity is constant (memory is in the path, not a fixed point), adding a new manifold signature.
- **[[wiki/entities/reservoir-computing.md]]** — reservoirs naturally have high TI (transient dynamics, spectral radius < 1); Barak 2013 showed reservoir already outperforms pure attractor RNN on delay tasks; TRNN (Transition RNN) adds learned hierarchical topology to the reservoir's inherently transient dynamics.
- **[[wiki/entities/ltc-model.md]]** — LTC (Liquid Time-Constant) is the continuous-time counterpart to TRNN's discrete-step dynamics; TRNN (Transition RNN) achieves transience via self-inhibition and sparse hierarchy; LTC (Liquid Time-Constant) achieves it via liquid τ in an ODE; TRNN (Transition RNN) is preferred for multi-item WM and long delays, LTC (Liquid Time-Constant) for continuous-time signal modeling with provable stability.
- **[[wiki/papers/ltc-hasani-2021.md]]** — source for LTC (Liquid Time-Constant) architecture and comparison to CT-RNN and Neural ODE families.
- **[[wiki/papers/trnn-liu-2025.md]]** — primary source; Liu et al. 2025; all results and architecture descriptions.
