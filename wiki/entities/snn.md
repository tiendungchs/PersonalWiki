---
title: "Spiking Neural Networks"
type: entity
tags: [snn, temporal-coding, neuromorphic, spike-coding, rate-coding, surrogate-gradient, e-prop, ALIF (Adaptive Leaky Integrate-and-Fire), FILT]
created: 2026-06-22
updated: 2026-06-23
sources: [snn-encoding-auge-2021, supervised_spiking_nn, A neuronal learning rule for sub-millisecond temporal coding, sfa-ganguly-2024, tavanaei-deep-snn-2018, Networks of Spiking Neurons]
related: [wiki/concepts/temporal-coding.md, wiki/concepts/spike-frequency-adaptation.md, wiki/concepts/hebbian-learning.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/binding-problem.md, wiki/concepts/associative-memory.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/papers/snn-encoding-auge-2021.md, wiki/papers/gardner-gruning-supervised-snn.md, wiki/papers/gerstner-temporal-coding-1996.md, wiki/papers/tavanaei-deep-snn-2018.md, wiki/papers/maass-snn-third-gen-1997.md, wiki/papers/spiking-cam-hippocampus-casanueva-2024.md]
---

# Spiking Neural Networks (SNN)

**Networks in which information is processed and communicated via discrete spike events whose timing — not only rate — carries information; the native computational substrate of biological neural circuits and neuromorphic hardware.**

---

## Computational Hierarchy: Three Generations (Maass 1997)

| Generation | Unit | Output | Paradigm |
|---|---|---|---|
| **1st** | Threshold gate (McCulloch-Pitts) | Digital | Perceptrons, Hopfield nets |
| **2nd** | Sigmoidal gate | Analog | Backprop nets, RBF nets |
| **3rd** | Spiking neuron | Spike train | SNN |

SNNs are *strictly more powerful* per neuron count. A **single type B spiking neuron** computes:
- **CD_n (coincidence detection):** fires iff inputs x and y agree in some position; requires Ω(n/log n) threshold gates or Ω(n²) sigmoidal gates.
- **ED_n (element distinctness):** fires iff any two of n real inputs are equal; requires Ω(n) sigmoidal hidden units.

**Type A vs. Type B:**

| Type | PSP (Post-Synaptic Potential) shape | Analog input power |
|---|---|---|
| **A** (piecewise constant) | Step function | Cannot simulate threshold circuits for real-valued input |
| **B** (piecewise linear) | Triangular/ramped EPSPs | Universal approximator; simulates any sigmoidal net |

Biological EPSPs approximate type B (Figure 2, Maass 1997). The extra power comes from continuous temporal shift: EPSP linearity allows the firing time to encode a weighted sum algebraically (see [[wiki/concepts/temporal-coding.md]]).

**Design implication:** any module requiring coincidence detection (binding, synchrony coding) is exponentially cheaper in a type B SNN than a sigmoidal network.

---

## Rate vs. Temporal Encoding Taxonomy (Auge et al. 2021)

| Code | Information carrier | SNN advantage | ANN equivalent |
|---|---|---|---|
| **Rate** | Mean firing rate per window | Energy scales with activity, not network size | Continuous activation |
| **Temporal** | Spike timing relative to reference | Sub-ms precision (ITD, FILT); encodes causal order | No direct equivalent |
| **Synchrony / SDR** | Identity of co-active population subset | Natural sparse coding; NMDA coincidence detection | Sparse activations |
| **Phase** | Spike phase within oscillation | Multiplexes multiple objects per cycle; role-filler binding | Positional encoding (indirect) |

Temporal and synchrony codes carry information not available to rate-coded ANNs. The SNN framework makes explicit what rate coding discards.

---

## ANN→SNN Conversion and Training

| Method | Mechanism | Precision | Online? | Limitation |
|---|---|---|---|---|
| **Rate conversion** | Replace ReLU with IF neuron; activations → firing rates | Low | No | Slow convergence; loses temporal information |
| **Surrogate gradient BPTT** | Differentiate through spike threshold with smooth surrogate | Medium | No | Non-local in time; memory-intensive |
| **e-prop** | Eligibility-trace-based online gradient | Medium | Yes | Approximation error vs. BPTT |
| **FILT (Gardner & Grüning)** | Filtered spike-train error; stable fixed point at target weights | High (0.2 ms) | Yes | Requires reference spike train targets |
| **STDP + Hebbian** | Unsupervised; selects causal connections | Low (for complex tasks) | Yes | Cannot optimize arbitrary objectives |
| **ReSuMe** (Ponulak 2010) | Widrow-Hoff rule decomposed as STDP + anti-STDP; desired vs. actual spike trains drive weight changes via correlated and anti-correlated presynaptic pairing | Medium | Yes | Requires a teacher spike train target; limited to shallow networks; teacher signal is "remote" (not local to synapse) |

**FILT stability principle:** filtering the postsynaptic error converts unstable weight dynamics (point-process → discontinuous ΔW at spike threshold) into a stable fixed point at the desired weight. Optimal filter time constant τ_q ≈ τ_m (membrane time constant) — one free parameter.

---

## STDP as Probabilistic Generative Inference

Nessler et al. (2009/2013): STDP with Poisson inputs and a stochastic winner-take-all (WTA) lateral inhibitory circuit approximates online Expectation-Maximization for a multinomial mixture distribution:

| Phase | Spiking Mechanism | EM (Expectation Maximization) Step |
|---|---|---|
| **E-step** | WTA (Winner-Take-All) output neuron fires → sample from posterior P(hidden \| input) | Infer the mixture component (hidden cause) most consistent with current input |
| **M-step** | STDP update on synapses of the winning neuron | Update that component's parameters toward the sampled posterior |

- WTA (Winner-Take-All) competition prevents all output neurons collapsing to the same component (each neuron develops distinct selectivity).
- Extension to recurrent reservoirs (Klampfl & Maass 2013): STDP on lateral excitatory synapses represents spatio-temporal patterns as samples from a Hidden Markov Model — each WTA (Winner-Take-All) spike train is a draw from an HMM state space.
- **Implication for reasoning:** an SNN with STDP and WTA (Winner-Take-All) is a Bayes-optimal generative model for its input statistics under the mixture model assumption. Unsupervised latent structure discovery requires no teacher — only spike timing and local competition, directly connecting to [[wiki/concepts/latent-graph-discovery.md]].

---

## Adaptive Leaky Integrate-and-Fire (ALIF)

Standard Leaky Integrate-and-Fire (LIF) with a slow adaptation current a(t):

$$\tau_m \dot{V} = -(V - V_\text{rest}) + I - a(t), \qquad \tau_a \dot{a} = -a + \beta z(t)$$

where z(t) is the spike output, τ_a ≫ τ_m, and β is adaptation strength.

After a burst, a(t) grows and raises the effective threshold → Spike Frequency Adaptation (SFA). ALIF (Adaptive Leaky Integrate-and-Fire) tiles the rate→temporal coding transition and maps directly to neuromorphic hardware (Intel Loihi, BrainScaleS). The slow state a(t) acts as an intrinsic per-neuron working memory without a separate WM module.

---

## Neuromorphic Deployment Relevance

| Property | Benefit | Mechanism |
|---|---|---|
| **Sparse activity** | Energy ∝ spike count, not network size | IF threshold gates output |
| **Event-driven processing** | Zero idle power between spikes | Asynchronous spike-driven architecture |
| **On-chip STDP / e-prop** | No off-chip gradient computation | Local eligibility traces |
| **ALIF adaptation** | Intrinsic state memory per neuron | Slow adaptation current a(t) |

Neuromorphic hardware exploits all four simultaneously, achieving 10–1000× energy efficiency over GPU inference for sparse tasks.

**SpiNNaker CA3-CAM (Casanueva-Morato et al. 2024 [[wiki/papers/spiking-cam-hippocampus-casanueva-2024.md]]):** First hardware implementation of a fully-functional bidirectional spiking hippocampal CAM (Content-Addressable Memory) on SpiNNaker (1 ms time step). Two parallel STDP sub-networks implement cue→content and content→cue retrieval in 6 ms; memory writes complete in 7 ms. STDP's LTD (Long-Term Depression) branch handles forgetting implicitly; interneuron gating via 1 ms spike-timing delays routes activity between sub-networks. This validates that the CA3 associative memory computation is achievable with real neuromorphic silicon at biologically-motivated timescales.

---

## For Building a Reasoning Model

1. **Temporal binding:** gamma-band synchrony codes (~40 Hz) implement role-filler binding (LISA model) — unavailable in rate-coded ANNs without explicit oscillatory dynamics. If temporal binding is required for abstract reasoning, a spiking substrate is structurally necessary.
2. **Energy efficiency:** neuromorphic SNNs enable persistent reasoning agents on battery-constrained hardware; inference cost scales with task complexity (more decisions = more spikes), not with parameter count.
3. **ALIF as intrinsic WM:** the slow adaptation current a(t) carries recent history per neuron; for simple sequential tasks, ALIF (Adaptive Leaky Integrate-and-Fire) may reduce reliance on a separate HC-style storage module.
4. **FILT for online learning:** filtered-error learning achieves sub-millisecond temporal precision with only local computations — critical for a reasoning model that must adapt without batch backpropagation.

---

## Open Problems

- Whether temporal coding beyond rate codes is necessary for abstract reasoning, or whether rate-equivalent representations suffice at the relational/compositional level.
- Whether e-prop/FILT scale to multi-layer, multi-area hierarchies (all current demonstrations are ≤3 layers).
- How to compose spiking modules with heterogeneous coding strategies (rate at lower levels, temporal/phase at higher levels) without losing credit assignment.

---

## Connections

- **[[wiki/concepts/temporal-coding.md]]** — temporal coding is the defining computational mode distinguishing SNNs from rate-coded ANNs; the precision paradox (Gerstner 1996) and FILT learning rule establish that temporal codes are both achievable and learnable at sub-millisecond resolution; the rate/temporal/synchrony/phase taxonomy is the unifying classification.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — SFA (Spike Frequency Adaptation) is the primary biological mechanism implementing the slow adaptation current in ALIF (Adaptive Leaky Integrate-and-Fire); the SFA→ALIF mapping is the direct bridge from biological ion-channel dynamics to neuromorphic circuit element.
- **[[wiki/concepts/hebbian-learning.md]]** — STDP is the SNN-native unsupervised learning rule; it writes sequence edges and selects delay-matched axons using only local spike timing, making it the biologically default training signal when no supervised target is available.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — synchrony codes (the SNN native format for SDRs) require sparse active populations (≈2% activity) to make coincidence detection (NMDA spikes, ALIF (Adaptive Leaky Integrate-and-Fire) thresholding) reliable; the SDR (Sparse Distributed Representations) scaling laws explain why temporal binding requires neocortical sparse coding as its substrate.
- **[[wiki/papers/snn-encoding-auge-2021.md]]** — primary source for the rate/temporal/synchrony/phase taxonomy and ANN→SNN conversion survey.
- **[[wiki/papers/gardner-gruning-supervised-snn.md]]** — primary source for FILT learning rule, stability principle, and sub-millisecond precision capacity (α_m ≈ 0.07 at 0.2 ms).
- **[[wiki/papers/gerstner-temporal-coding-1996.md]]** — foundational source for coherent convergence and W(s) delay selection as the mechanism enabling sub-millisecond ITD precision in a biological SNN; establishes the population precision amplification scaling σ_pop ∝ 1/√(tN).
- **[[wiki/papers/tavanaei-deep-snn-2018.md]]** — source for STDP-as-Bayesian-EM (Nessler 2009/2013 interpretation), ReSuMe (supervised STDP+anti-STDP decomposition of Widrow-Hoff), and two-track deep SNN performance survey (online learning vs. offline ANN-to-SNN conversion benchmarks on MNIST/CIFAR).
- **[[wiki/papers/maass-snn-third-gen-1997.md]]** — foundational complexity-theoretic proof that type B SNNs are strictly more powerful than 1st and 2nd gen networks; establishes CD_n and ED_n as the benchmark functions demonstrating the gap; introduces the type A/B distinction critical for reasoning model design.
- **[[wiki/concepts/binding-problem.md]]** — CD_n (coincidence detection) is the formal SNN primitive for synchrony-based binding: the exponential size advantage over sigmoidal nets justifies using SNN layers specifically at the binding stage of a reasoning model.
- **[[wiki/papers/spiking-cam-hippocampus-casanueva-2024.md]]** — SpiNNaker CA3-CAM operationalizes content-addressable memory as a spiking circuit; STDP drives both learning and implicit forgetting using only local spike timing; the 1 ms SpiNNaker time-step and 6 ms recall latency establish the hardware timescale for HC-inspired fast-M retrieval.
- **[[wiki/concepts/associative-memory.md]]** — the SNN spiking CA3-CAM is the neuromorphic instantiation of content-addressable memory; it extends the Hopfield/MHN/SDM framework to the spiking domain with bidirectional retrieval (cue→content and content→cue) not achievable by rate-coded associative networks alone.
