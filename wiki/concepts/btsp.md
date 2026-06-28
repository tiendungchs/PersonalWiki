---
title: "Behavioral Timescale Synaptic Plasticity (BTSP)"
type: concept
tags: [btsp, synaptic-plasticity, one-shot-learning, hippocampus, content-addressable-memory, place-cells, binary-weights]
created: 2026-06-27
updated: 2026-06-27
sources: [wu-maass-btsp-2025]
related: [wiki/concepts/hebbian-learning.md, wiki/concepts/associative-memory.md, wiki/concepts/continual-learning.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/pattern-separation.md, wiki/concepts/engrams.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/place-cells.md, wiki/papers/wu-maass-btsp-2025.md, wiki/papers/learning-fast-slow-liao-2024.md]
---

# Behavioral Timescale Synaptic Plasticity (BTSP)

**BTSP is a one-shot synaptic plasticity rule in hippocampal CA1 that creates content-addressable memory with binary weights, gated by stochastic dendritic plateau potentials from entorhinal cortex rather than by postsynaptic firing.**

---

## Key Equations

**Binary BTSP rule** (applied with probability 0.5 when presynaptic input arrives within the ~10s plateau window):
$$\Delta w_i = \begin{cases} +1 & \text{if } x_i = 1 \text{ and } w_i = 0 \\ -1 & \text{if } x_i = 1 \text{ and } w_i = 1 \end{cases}$$
Otherwise $\Delta w_i = 0$. The ±1 stochasticity captures the inner/outer sub-windows of the 10s plateau window (LTP window: −3 to +2s; LTD window: −6 to −3s or +2 to +4s).

**Active-weight probability after learning M patterns:**

For neurons in Q(**x**) (received plateau during pattern **x**):
$$p_e = \tfrac{1}{2}\!\left(1 + (1 - f_p f_q)^{M-1}\right)$$

For neurons **not** in Q(**x**):
$$p_o = \tfrac{1}{2}\!\left(1 - (1 - f_p f_q)^{M-1}\right)$$

where $f_p$ = input sparsity (~0.005) and $f_q$ = probability of a CA1 neuron receiving a plateau potential per presented pattern (~0.005).

---

## Five Differences from Prior Plasticity Rules

| Property | Classic Hebbian / STDP | BTSP |
|---|---|---|
| Timescale | ms (STDP) / trials (Hebb) | Seconds (one trial) |
| Gating signal | Postsynaptic firing | EC3 plateau potential |
| LTP/LTD decision | Pre/post spike timing | Weight value + timing relative to plateau onset |
| Number of trials | Many | **One** |
| Weight precision | Continuous | **Binary (0/1)** |

---

## Memory Mechanism: Bimodal Distribution

BTSP creates a **bimodal distribution** of weighted sums in memory neurons, unlike random projections (which produce a unimodal distribution with a sharp threshold):

- **High cluster:** neurons in Q(**x**) — their weights were systematically updated to match **x**; weighted sum is well above threshold
- **Low cluster:** neurons not in Q(**x**) — weights reflect random pattern of prior inputs; weighted sum is well below threshold

Setting the firing threshold between the two clusters gives recall that is robust to up to 33% masking of input bits. Random projections have no such gap → cannot tolerate any masking.

---

## Repulsion Effect

BTSP's LTD branch **actively pushes apart memory traces for similar patterns** — the first learning-based model to reproduce the experimentally documented repulsion effect in human memory (fMRI: similar experiences produce *less* similar neural traces, not more):

1. Two similar patterns **x_a** and **x_b** share many 1's (e.g., 40% overlap)
2. CA1 neurons receiving plateau potentials for both patterns update weights for shared 1's: first $+1$ (encoding **x_a**), then $-1$ (LTD during **x_b**)
3. Shared-input weights cancel → neuron less likely to fire for either pattern → lower trace overlap than input overlap

| Model | Effect on similar inputs |
|---|---|
| Hopfield / random projection | Attraction — more similar inputs → more similar traces |
| **BTSP** | **Repulsion — similar inputs → actively dissimilar traces** |

The repulsion requires a non-zero $f_q$ and depends on overlap ratio; the experimentally measured $f_q \approx 0.005$ is close to optimal.

---

## Capacity and Comparison to Hopfield

Brain-scale parameters: CA3 $m \approx 2.83\text{M}$ neurons (human), CA1 $n \approx 14\text{M}$, $f_p = 0.005$.
Theory predicts robust recall ($\leq$67% masking) for $>$800,000 stored patterns at human scale.

| System | Weights | Capacity (sparse $f_p$=0.005) | Recall w/ masking | Repulsion | One-shot? |
|---|---|---|---|---|---|
| Binary Hopfield | Continuous (→∞ values as M↑) | ~0.14N, collapses with binarization | Poor | No | Yes (Hebb) |
| Random projection | Binary (fixed a priori) | N/A — no attractor | Fails any masking | No | N/A |
| **BTSP** | **Binary (learned)** | **>800k items (human scale)** | **33% masking** | **Yes** | **Yes** |

Binary Hopfield networks (continuous weights quantized to binary) have drastically reduced capacity. BTSP achieves comparable or better CAM quality with binary weights from the start.

---

## Stochastic Gating Parameter f_q

$f_q$ is a novel control parameter with no analog in Hopfield, SDM, or STDP models:

| $f_q$ | Trace size | Interference | Repulsion strength | Recall robustness |
|---|---|---|---|---|
| Low (0.001) | Small | Low | Weak | High |
| Optimal (~0.005) | Moderate | Moderate | Moderate | High |
| High (0.01) | Large | High | Strong | Low |

The 10s plateau potential window brings $f_q$ into the optimal range: plateau rate 0.0005/s × 10s window = 0.005. Evolution may have tuned the plateau duration to the sweet spot of this trade-off.

---

## For Building a Reasoning Model

- **Fast-M write with binary weights:** BTSP is the correct biological fast-M write for CA1; any episodic memory layer should use a BTSP-like stochastic gating signal (not pure Hebbian) to distribute memory load uniformly and avoid repeated-neuron overwrite.
- **f_q as modulated capacity dial:** $f_q$ could be controlled by a novelty/neuromodulatory signal (high ACh → lower $f_q$ → focused encoding; low ACh → higher $f_q$ → broader recall). This gives a single knob to switch between high-discrimination and high-coverage modes.
- **Repulsion for near-duplicate discrimination:** for reasoning tasks where similar abstract patterns must be distinguished (e.g., ARC tasks differing by one transformation rule), a BTSP-like LTD branch at the output layer would automatically push representations apart without explicit contrastive training.
- **Attractor property without recurrence:** BTSP creates attractor-like recall from partial cues in a *feedforward* CA3→CA1 network; no recurrent connections are required for the basic pattern completion, only for full input reconstruction. This is architecturally attractive for low-latency reasoning.

---

## Open Problems

- Whether BTSP and STDP together cover all graph structure (BTSP: node acquisition in CA1; STDP: edge weights in CA3): the anatomical segregation hypothesis is plausible but untested directly.
- Biological setting of the threshold $v_{th}$: the paper uses grid search; the homeostatic mechanism in CA1 is unknown.
- Whether the repulsion effect persists through SWR-mediated replay or is modified during consolidation.
- How to implement the 10s plateau window integration in a non-spiking ML architecture while preserving the bimodal distribution benefit.

---

## Connections

- **[[wiki/concepts/hebbian-learning.md]]** — BTSP supersedes "one-shot Hebbian LTP" as the molecular account of CA1 fast-M writes; it extends Hebbian learning to the behavioral timescale and adds stochastic gating, a binary weight constraint, and the LTD repulsion branch absent from classic Hebb.
- **[[wiki/concepts/associative-memory.md]]** — BTSP creates a CAM with binary weights that matches or surpasses Hopfield networks with continuous weights for sparse inputs ($f_p$ = 0.005); the bimodal weight-sum distribution is the mechanism by which BTSP achieves better recall robustness than random projections.
- **[[wiki/concepts/continual-learning.md]]** — stochastic plateau gating distributes memory load uniformly across CA1 neurons, preventing the repeated-neuron recruitment that causes catastrophic forgetting in Hebbian-based systems; uniform allocation is the BTSP analog of SDR sparsity protection.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — BTSP exploits the same sparse coding regime ($f_p$ ≈ 0.005) as SDR theory; sparsity is essential for well-separated bimodal clusters and selective repulsion — at dense $f_p$, both effects degrade.
- **[[wiki/concepts/pattern-separation.md]]** — the repulsion effect is a CA1-level complement to DG pattern separation: DG orthogonalizes inputs before CA3 storage; BTSP's LTD branch further separates memory traces for similar patterns at the CA1 output level.
- **[[wiki/concepts/engrams.md]]** — BTSP is the molecular write mechanism for CA1 engrams; the memory trace z(**x**) is the BTSP-defined engram; stochastic plateau gating determines which neurons are recruited, implementing excitability-like competition without explicit CREB signaling.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — BTSP operates at CA3→CA1 synapses gated by EC3 plateau potentials; it is the cellular write step in the DG→CA3→CA1 pipeline, completing the fast-M encoding chain.
- **[[wiki/entities/place-cells.md]]** — BTSP creates place fields in a single environment traversal; the seconds-long plateau window integrates all inputs active during navigation into a stable code; the bimodal weight distribution underlies place field stability and robustness to partial cue input.
- **[[wiki/papers/wu-maass-btsp-2025.md]]** — primary source: binary BTSP rule, analytical theory (firing probability, expected Hamming distance), capacity analysis, repulsion effect, comparison to Hopfield and random projections, neuromorphic hardware implications.
- **[[wiki/papers/learning-fast-slow-liao-2024.md]]** — establishes BTSP as the correct fast-M write in CA1 and contextualizes it within the BTSP (CA1 nodes) + STDP (CA3 edges) two-timescale HC framework.
