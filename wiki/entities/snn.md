---
title: "Spiking Neural Networks"
type: entity
tags: [snn, temporal-coding, neuromorphic, spike-coding, rate-coding, surrogate-gradient, e-prop, ALIF (Adaptive Leaky Integrate-and-Fire), FILT]
created: 2026-06-22
updated: 2026-06-27
sources: [snn-encoding-auge-2021, supervised_spiking_nn, A neuronal learning rule for sub-millisecond temporal coding, sfa-ganguly-2024, tavanaei-deep-snn-2018, Networks of Spiking Neurons, "Biologically inspired heterogeneous learning for accurate, efficient and low-latency neural network", "Efficient event-based delay learning in spiking neural networks"]
related: [wiki/concepts/temporal-coding.md, wiki/concepts/spike-frequency-adaptation.md, wiki/concepts/hebbian-learning.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/binding-problem.md, wiki/concepts/associative-memory.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/papers/snn-encoding-auge-2021.md, wiki/papers/gardner-gruning-supervised-snn.md, wiki/papers/gerstner-temporal-coding-1996.md, wiki/papers/tavanaei-deep-snn-2018.md, wiki/papers/maass-snn-third-gen-1997.md, wiki/papers/spiking-cam-hippocampus-casanueva-2024.md, wiki/papers/hifi-snn-wang-2024.md, wiki/concepts/working-memory.md, wiki/concepts/two-learning-timescales.md, wiki/papers/meszaros-eventprop-delays-2025.md, wiki/concepts/small-world-networks.md, wiki/concepts/credit-assignment.md, wiki/concepts/meta-learning.md, wiki/concepts/neuromodulation.md, wiki/papers/pcm-l2l-ortner-2025.md]
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
| **Surrogate gradient BPTT** | Differentiate through spike threshold with smooth surrogate | Medium | No | Non-local in time; memory-intensive; memory scales with sequence length |
| **e-prop / Natural e-prop** (Bellec et al. 2020; Ortner et al. 2025) | Eligibility traces $e_{jk}^t$ (local) combined with externally generated learning signals $L_j^t$ from an LSG SNN; inner-loop update $\theta^1 = \theta - \alpha \sum_t L^t \odot e^t$ | Medium (online approx. of BPTT) | Yes | Outer-loop (meta-training) still requires BPTT; one-shot hardware adaptation demonstrated on PCM crossbar |
| **EventProp** (Wunderlich & Pehle 2021; Nowotny et al. 2022) | Adjoint method on hybrid ODE+spike dynamics; exact gradients; backward pass is itself event-based | High | No | Requires sorting event times; no spike creation/deletion gradient (addressed by loss shaping) |
| **EventProp+Delay** (Mészáros et al. 2025) | Extends EventProp to learn synaptic delays alongside weights; same adjoint dynamics; per-neuron buffer; supports recurrent SNNs | High | No | Delay initialisation problem open; delays quantised to timestep grid |
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

## HIFI: Heterogeneous SNN with Self-Inhibiting Autapse

Wang et al. 2024 ([[wiki/papers/hifi-snn-wang-2024.md]]). Two bio-inspired modifications to standard SNNs that jointly improve accuracy, energy, and biological fidelity.

### Self-Inhibiting Autapse

Each neuron feeds its own last spike back to suppress its next-step input:

$$I^k(t) = S^k(t) - \gamma^k O^k(t-1)$$

where $S^k(t)$ is external input (weighted sum from neighbors) and $\gamma^k$ is a learnable per-neuron autapse strength. This gives each neuron a one-timestep memorizing effect — biologically grounded in the self-inhibiting autapse (axon→soma loop) observed in mammalian cortex, which regulates spike precision and forms the biophysical basis of neural memorizing.

**Contrast with ALIF/SFA:** SFA modifies the *threshold* via a slow adaptation current $a(t)$; the autapse modifies the *input* via last-step output feedback. Both are per-neuron, both are intrinsic, but they operate on different variables with different timescales (autapse: one timestep; SFA: $\tau_a \gg \tau_m$).

**Contrast with TRNN self-inhibition:** TRNN self-inhibition ($V_t = (1-\alpha_v)V_{t-1} + \alpha_v m r_{t-1}$) is a network-level mechanism to force sequential chain propagation across neurons; the autapse is a single-neuron computation that modulates its own input.

### Heterogeneous Neuron Parameters (HIFI)

Each neuron $k$ learns unique biophysical parameters:
$$\alpha^k = [\tau^k, \gamma^k, C^k, u_{th}^k, u_{re}^k]$$
(membrane decay, autapse strength, capacitance, threshold, resting potential). Traditional SNNs share one parameter set across all neurons; HIFI makes every neuron a distinct computational element.

**Biological basis:** Neuroscience shows population-level heterogeneity produces stable behavior, efficient signal coding, robustness to fluctuations (Bhatt et al.; Perez-Nieves et al.), and enhances fading-memory property and WM capacity in cortical neurons. Trained HIFI parameter distributions match Allen Cell Type Database electrophysiology recordings.

### Bi-Level Biophysics Meta-Learning

HIFI learning separates two optimization levels:

$$\min_\alpha \mathcal{L}_v(D_v; W^*(\alpha), \alpha) + \lambda\,\Omega(W^*(\alpha), \alpha)$$
$$\text{s.t.} \quad W^*(\alpha) = \arg\min_W \mathcal{L}_t(D_t; W, \alpha)$$

- **Inner loop (network level):** learns synaptic weights $W$ on training data $D_t$ with fixed $\alpha$
- **Outer loop (neuron level):** learns biophysical params $\alpha$ on validation data $D_v$ using the trained $W^*(\alpha)$; Laplacian smoother $\Omega$ encourages spatially neighboring neurons to share similar params

This maps directly onto [[wiki/concepts/two-learning-timescales.md]]: $W$ is the fast task-specific loop (inner); $\alpha$ is the slow architectural loop (outer). The biological analogy: synapses evolve on the timescale of single-task training; neuron biophysics evolve on longer developmental timescales.

**Reasoning model implication:** the bi-level framework can, in principle, search over neuron-level inductive biases (e.g., which neurons should be fast vs. slow integrators) rather than hand-designing them. Heterogeneous $\tau^k$ distributions provide a natural temporal basis spanning multiple timescales simultaneously.

### HIFI Results

| Task | Improvement over best baseline SNN |
|---|---|
| CIFAR10 accuracy | +1% (95.98% at 6 steps) |
| MNIST latency | 13× lower than comparable accuracy SNN |
| CIFAR10 energy (vs. ANN) | 17.83× reduction at 2 time steps |
| Neuromorphic datasets (5) | Best accuracy and lowest latency on all |
| scRNA-seq rare cell types | Identifies ~0.09% cells missed by all baselines |

Limitation: bi-level optimization is expensive to train; no abstract reasoning evaluation (all tasks are classification).

---

## Synaptic Delay Learning (Mészáros et al. 2025)

Synaptic delays are heterogeneous transmission lags $d_{ji}$ on each connection. With delays, the effective temporal receptive field of a neuron spans $[0, d_{\max}]$ ms beyond its membrane time constant — a free extension of temporal memory without additional parameters.

**EventProp+Delay:** exact gradient descent on delays using the adjoint method. The delay gradient reuses the same adjoint variables $(\lambda_I, \lambda_V)$ computed for weight gradients — a byproduct at zero extra cost. See [[wiki/papers/meszaros-eventprop-delays-2025.md]] for full derivation.

**Why delays multiply capacity (Maass & Schmitt):** $k$ adjustable delays compute a *strictly richer* function class than $k$ adjustable weights. A network with $N$ neurons and adjustable delays is not equivalent to a wider network without delays.

**Efficiency:** per-neuron delay buffers (not per-synapse convolution kernels) → memory scales with $N$, not $N^2$; 26× faster and >2× less memory than dilated-convolution surrogate-gradient methods.

**Empirical results:**

| Dataset | With delays | Without delays |
|---|---|---|
| SHD | 93.24 ± 1.0% (5× fewer params) | ~89% |
| SSC | 76.1 ± 1.0% | ~74% |
| Braille | 83.1 ± 1.5% | 80.9% baseline |

**Architectural finding:** recurrent delays are especially beneficial in small networks; large networks gain less. Learned delay distributions follow a small-world pattern — most delays short, few large — consistent with the brain's EDR + rare LR shortcut principle.

---

## For Building a Reasoning Model

1. **Temporal binding:** gamma-band synchrony codes (~40 Hz) implement role-filler binding (LISA model) — unavailable in rate-coded ANNs without explicit oscillatory dynamics. If temporal binding is required for abstract reasoning, a spiking substrate is structurally necessary.
2. **Energy efficiency:** neuromorphic SNNs enable persistent reasoning agents on battery-constrained hardware; inference cost scales with task complexity (more decisions = more spikes), not with parameter count.
3. **ALIF as intrinsic WM:** the slow adaptation current a(t) carries recent history per neuron; for simple sequential tasks, ALIF (Adaptive Leaky Integrate-and-Fire) may reduce reliance on a separate HC-style storage module.
4. **FILT for online learning:** filtered-error learning achieves sub-millisecond temporal precision with only local computations — critical for a reasoning model that must adapt without batch backpropagation.
5. **Learnable delays as temporal depth:** delays extend the effective context of an SNN beyond its membrane time constant at zero parameter cost; gradient-trainable via EventProp+Delay, compatible with neuromorphic hardware (SpiNNaker 2).

---

## Natural e-prop and the Learning Signal Generator (LSG)

Ortner et al. 2025 [[wiki/papers/pcm-l2l-ortner-2025.md]] combine meta-learning with natural e-prop to achieve one-shot adaptation of a recurrent SNN on PCM neuromorphic hardware.

**Architecture:** Two SNNs operate jointly:

| Network | Input | Output | Role |
|---|---|---|---|
| **LSG** (800 LIF/ALIF neurons) | Clock signal + target trajectory | Per-neuron learning signals $L_j^t$ | Generates the teaching signal conditioned on task context |
| **Trainee** (250 LIF neurons) | Clock signal only | Motor commands (angular velocities) | Produces functional output; weights adapted by LSG signals |

**Inner-loop update (single step, on hardware):**

$$\theta^1_{jk} = \theta_{jk} - \alpha \sum_t L_j^t \cdot e_{jk}^t$$

where the eligibility trace is $e_{jk}^t = h_j^t \sum_{t' \le t} \gamma^{t-t'} z_i^{t'}$ — a low-pass filtered version of pre-synaptic spikes gated by the pseudo-derivative $h_j^t$ of the postsynaptic neuron. The learning signal is a low-pass filtered version of LSG output: $L_j^t = \alpha_e L_j^{t-1} + \sum_i \psi_{ji}^{out} \xi_i^t$.

**Biological interpretation:**
- Eligibility traces = molecular synaptic tags that persist until a neuromodulatory event arrives.
- LSG output = brain area specialized for generating global learning signals (e.g., VTA dopamine, LC norepinephrine) conditioned on the task/goal context.
- The LSG→trainee architecture is a computational model of how neuromodulatory systems coordinate with local synaptic plasticity to produce rapid task-specific learning.

**Meta-training (outer loop, in software):** BPTT jointly optimizes Θ (trainee initial weights) and Ψ (LSG weights) to minimize average loss after the single inner-loop update across a distribution of motor trajectories (100K iterations). After meta-training, trainee weights are transferred to the PCM crossbar; the LSG runs in software.

**Result:** Single weight update on PCM hardware → real robot arm tracks arbitrary trajectories with RMSE ~6.7 cm deviation; on par with software model.

---

## HNN Framework: SNN as Symbolic Reasoning Substrate

Zhao et al. 2022 ([[wiki/entities/hnn-framework.md]]) demonstrate that SNN's non-differentiable, event-driven dynamics — usually viewed as an obstacle — become an architectural advantage when the SNN plays a *symbolic reasoning* role rather than a classification role.

In the **HRN (Hybrid Reasoning Network)**, integrate-and-fire neurons represent semantic concepts (red, cube, shape, collision) and logical operators (inhibition, excitation, copy, filter, order). Edges encode working memory — prior knowledge graph plus Hebb-written scene bindings. The SNN executes logical operations in parallel via spike propagation: synchronized stimuli on "object-inhibition" + "red" neurons deactivate all non-red objects, implementing "filter by red" in one forward pass. This achieves O(1) reasoning latency regardless of scene size, and robustness to abnormal inputs (prior knowledge constrains the answer space).

The interface to ANN perceptual frontends is provided by **Hybrid Units (HUs)**: `Y = Q·F·H·W(X)`. Designable HUs convert static attributes (ANN detections) to spike stimuli; learnable HUs detect dynamic events (collisions) from multi-frame trajectory features.

**Implication for building a reasoning model:** SNN graph-based symbolic reasoning is not just biologically motivated — it provides properties that ANN-only architectures lack: interpretability (instruction set is human-readable), parallel evaluation, and robustness via prior-knowledge constraints. The HRN architecture suggests a concrete division of labor: ANN for grounded feature extraction, SNN for symbolic rule execution, HUs as the interface.

---

## Open Problems

- Whether temporal coding beyond rate codes is necessary for abstract reasoning, or whether rate-equivalent representations suffice at the relational/compositional level.
- Whether e-prop/FILT scale to multi-layer, multi-area hierarchies (all current demonstrations are ≤3 layers).
- How to compose spiking modules with heterogeneous coding strategies (rate at lower levels, temporal/phase at higher levels) without losing credit assignment.
- Whether HRN's manual instruction ontology can be replaced by learned symbolic primitives, and whether STDP/Hebb rules suffice for discovering the ontology from data.

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
- **[[wiki/papers/hifi-snn-wang-2024.md]]** — primary source for the HIFI model (self-inhibiting autapse, heterogeneous bi-level learning); all HIFI architecture and results described above.
- **[[wiki/concepts/working-memory.md]]** — the HIFI autapse ($I^k(t) = S^k(t) - \gamma^k O^k(t-1)$) is an 8th fast WM trace mechanism: per-neuron input-modulation memory, distinct from SFA (threshold) and TRNN (network trajectory); heterogeneous $\tau^k$ distribution gives the population a natural multi-timescale temporal basis for fading memory.
- **[[wiki/concepts/two-learning-timescales.md]]** — HIFI bi-level programming instantiates two-timescale learning at sub-synaptic granularity: outer loop (neuron biophysics $\alpha$, validation-set objective) plays the role of slow structural learning; inner loop (synaptic weights $W$, training-set objective) plays the role of fast task-specific learning.
- **[[wiki/entities/hnn-framework.md]]** — HNN Framework operationalizes SNN as a symbolic reasoning substrate: integrate-and-fire graph neurons implement logical primitives (filter, inhibit, copy, order) alongside the HU formalism for ANN↔SNN interfacing, directly addressing the open problem of composing SNN modules with heterogeneous coding strategies for reasoning tasks.
- **[[wiki/papers/meszaros-eventprop-delays-2025.md]]** — primary source for EventProp+Delay: exact adjoint-method gradients w.r.t. synaptic delays in recurrent SNNs; per-neuron buffer architecture; 26× efficiency gain; empirical results on SHD/SSC/Braille; emergent small-world delay distributions.
- **[[wiki/concepts/credit-assignment.md]]** — EventProp is the SNN-native entry in the credit assignment taxonomy: exact gradient (near-zero bias) via adjoint method; event-based backward pass avoids dense BPTT; delay extension adds a second trainable parameter type with no extra backward-pass dynamics. Natural e-prop is the eligibility-trace + externalized-learning-signal entry: medium bias but fully online and hardware-compatible in the inner loop.
- **[[wiki/concepts/meta-learning.md]]** — natural e-prop's LSG architecture instantiates parameter-generation-based meta-learning: the outer loop trains Ψ (LSG weights) so the LSG generates task-specific learning signals in one exposure; the inner loop is a single local weight update on hardware — the most efficient fast-adaptation demonstration in this wiki.
- **[[wiki/concepts/neuromodulation.md]]** — the LSG (Learning Signal Generator) is a computational model of neuromodulatory systems: it reads task context (target trajectory) and emits learning signals L_j^t that gate synaptic eligibility traces, mirroring how VTA/dopamine or LC/norepinephrine signals gate synaptic tags in biological circuits.
- **[[wiki/papers/pcm-l2l-ortner-2025.md]]** — primary source for natural e-prop + LSG architecture, MAML few-shot classification on PCM hardware, one-shot robot arm trajectory learning, and the hardware-robustness finding (software meta-training transfers to 4-bit PCM without loss).
- **[[wiki/concepts/small-world-networks.md]]** — learned delay distributions (most delays short, few long-range) recapitulate the brain's EDR + rare LR shortcut principle at the single-synapse level, grounding the small-world architecture principle in a concrete trainable parameter.
