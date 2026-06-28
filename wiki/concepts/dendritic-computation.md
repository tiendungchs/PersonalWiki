---
title: "Dendritic Computation"
type: concept
tags: [dendritic-computation, NMDA, active-dendrites, coincidence-detection, binding-problem, credit-assignment]
created: 2026-06-20
updated: 2026-06-27
sources: [ahmad-hawkins-sdr-2016, gerfen-surmeier-dopamine-striatum-2011, bi-poo-stdp-1998, A deep learning framework for neuroscience, Theories of Error Back-Propagation in the Brain, Dendrites endow artificial neural networks with accurate, robust and parameter-efficient learning]
related: [wiki/concepts/sparse-distributed-representations.md, wiki/concepts/binding-problem.md, wiki/concepts/canonical-microcircuit.md, wiki/entities/basal-ganglia.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/hebbian-learning.md, wiki/concepts/credit-assignment.md, wiki/concepts/representational-geometry.md, wiki/concepts/continual-learning.md, wiki/papers/bi-poo-stdp-1998.md, wiki/papers/richards-lillicrap-dl-framework-2019.md, wiki/papers/millidge-activation-relaxation-2020.md, wiki/papers/douglas-martin-neocortex-2004.md, wiki/papers/chavlis-dann-2025.md, wiki/papers/meta-learning-plasticity-random-feedback.md]
---

# Dendritic Computation

**Dendritic computation is the use of sub-threshold nonlinear integration in dendritic branches — particularly N-Methyl-D-Aspartate (NMDA)-receptor-dependent plateau potentials — to implement coincidence detection, local binding, and gating independently of somatic firing.**

---

## NMDA Spike Mechanism

Each pyramidal neuron has 100+ independent dendritic segments. A segment fires an NMDA plateau potential when 8–20 co-localized synapses (within 20–300 µm, synchronized within 1–5 ms) become co-active:

$$\mathbf{D} \cdot \mathbf{A}_t \geq \theta \quad (\theta_\text{opt} \approx 9\text{–}20)$$

This is a **threshold-logic coincidence detector** operating entirely locally — the soma need not fire, and the segment's output is independent of other dendritic compartments. Each neuron thus contains >100 independent pattern detectors. False positive probability for typical SDR (Sparse Distributed Representations) parameters ($n=10{,}000$, $a=300$, $s=30$, $\theta=12$): $P(\text{FP}) \approx 10^{-27}$ (Ahmad & Hawkins 2016).

The same NMDA Mg²⁺-unblock requirement underlies STDP: LTP (Long-Term Potentiation) requires pre-then-post within ~20ms (glutamate binds NMDA → Mg²⁺ partly relieved → back-propagating AP fully relieves Mg²⁺ → Ca²⁺ influx); LTD (Long-Term Depression) requires post-before-pre, driven by L-type Ca²⁺ from back-propagating APs without subsequent NMDA opening (Bi & Poo 1998). The ±20ms STDP window is thus set by NMDA Mg²⁺-unblock decay kinetics, not by a separate timing circuit.

---

## Instantiations

| System | Dendritic mechanism | Computation | Reasoning-model implication |
|---|---|---|---|
| **Neocortical pyramidal neuron** | NMDA spike from 8–20 co-localized synapses | >100 independent coincidence detectors per neuron | Single-neuron capacity ≫ linear integration models; enables one-shot feature binding |
| **DG granule cell (BTSP)** | EC-instructed dendritic plateau potential (behavioral timescale) | One-shot place field acquisition via dendritic depolarization | Fast-M episodic write occurs at the dendritic level, not the soma |
| **Striatal SPN (Spiny Projection Neuron) (up-state gating)** | Convergent Glu input overcomes Kir2 to reach up-state; D1/D2 modulate the threshold | Coincidence-gated action selection | Credit assignment requires convergence detection at dendrite, not max-firing |
| **CA3 pyramidal cell** | NMDA-dependent Hebbian LTP (Long-Term Potentiation) on recurrent collaterals | Pattern completion via attractor dynamics | Associative memory write is a local dendritic event; theta-phase timing regulates write window |
| **dANN (Chavlis & Poirazi 2025)** | Structured tree-like masked weights (dendrite→soma) + receptive-field-restricted input sampling | ML implementation of dendritic computation without NMDA spikes | Bio-inspired sparsity achieves 1–3 OoM parameter reduction; mixed-selectivity nodes emerge spontaneously |

---

## Application to Building a Reasoning Model

- **Local binding without a global serializer:** NMDA spike binding (8–20 synapses) is the biological implementation of the conjunctive code `p = f(g, x)` — role-filler binding occurs at the dendritic segment without requiring global attention.
- **Scalable coincidence detection:** Because each segment operates independently, the same neuron can detect hundreds of distinct patterns simultaneously — architecturally equivalent to multi-head attention with a hard threshold rather than softmax.
- **Active gating (BG):** SPN (Spiny Projection Neuron) up-state bistability means that action selection is hardware-level coincidence detection, not winner-take-all activation. Artificial BG (Basal Ganglia) blocks should replicate convergence gating, not scalar threshold selection.

---

## Dual-Compartment Credit Assignment

The apical/basal dendritic segregation in pyramidal neurons implements structural credit assignment at the single-cell level (Sacramento et al. 2018; Richards & Lillicrap 2019):

| Compartment | Location | Input | Computes | Role in learning |
|---|---|---|---|---|
| **Basal dendrites** | Proximal | Feedforward (sensory / lateral) | Feedforward drive → somatic firing | Pre-synaptic trace for weight update |
| **Apical dendrites** | Distal | Top-down feedback (higher cortex) | Error / mismatch signal δ | Credit signal: Δw ∝ δ × (basal activity) |

The weight update at basal synapses is Hebbian *gated by the apical error signal*:

$$\Delta w_{\text{basal}} \propto \delta_{\text{apical}} \cdot x_{\text{pre}}$$

This makes credit assignment local: each synapse only needs its own presynaptic activity and the apical δ from the layer above — neither global weight symmetry nor a backward-pass freeze is required.

**Biological evidence for the two-compartment split:**
- Apical dendrites of L5 pyramidal neurons receive dense top-down input from higher cortical areas and from feedback projections (layer 1 inputs in primate and rodent neocortex)
- Somatic burst firing is reliably triggered by coincidence of basal drive and apical depolarization (Larkum et al. 1999), providing a natural gating mechanism: the weight update occurs only when both compartments are co-active
- **Burst/spike multiplexing (Naud et al. 2019; Payeur et al. 2021):** Activations and error signals can be multiplexed by the distinction between bursts and single action potentials, communicated separately via synaptic projections onto the soma vs. apical dendrites. Plasticity dependence on spike type (burst vs. single) and synaptic contact site is experimentally established — enabling a single neuron to encode forward activations (single spikes) and backward error signals (bursts) simultaneously. This provides the biological substrate for eHebb-style plasticity rules (Shervani-Tabar & Rosenbaum 2023): co-burst events between adjacent cortical layers implement the error co-activity product $\mathbf{e}_\ell\mathbf{e}_{\ell-1}^T$ that pushes forward weights toward the random feedback matrix.
- Attention-gated RL (AGREL, Roelfsema & van Ooyen 2005) implements this computationally: attentional feedback tags active basal synapses, then Dopamine RPE sets the direction of update — a two-signal structure matching the apical/neuromodulatory dissociation
- **L1 inhibitory route (Bastos et al. 2012):** Feedback projections from L5/6 of higher areas terminate in L1, which contains nearly 100% inhibitory cells. These cells make monosynaptic inhibitory connections onto the apical dendrites of L2/3 pyramidal cells — the specific route by which top-down PC (Predictive Coding) predictions suppress prediction errors. L1 is the "hotspot" of inhibitory control for the feedback stream. A specific subtype of GABAergic neuron in L1 controls distal dendritic excitability and gates top-down signals differentially during behavior (Gentet et al. 2012). The apical dendrite is therefore both a credit-delivery site (top-down δ signal) and a prediction-suppression target — two computations using the same anatomical substrate.

**Martinotti cells as the local error-prediction circuit (Sacramento et al. 2018):** In the dendritic error model, the specific interneuron type implementing local error prediction is the **Martinotti cell** — a class of GABAergic interneuron that (a) receives excitatory input from pyramidal neurons in the same cortical layer and (b) projects back to *their* apical dendrites (Silberberg & Markram 2007; Kubota 2014). This self-loop lets interneurons learn to predict what feedback from higher areas should look like (given current local activity), and then inhibit the apical dendrite by that prediction — so the net apical signal is actual-feedback minus predicted-feedback = error δ. Evidence that inhibitory interneurons also receive top-down feedback from higher areas (Leinweber et al. 2017) further grounds this: the interneuron has access to both the locally generated prediction and the actual higher-level signal needed to compute the mismatch.

**Design implication for a reasoning model:** Top-down feedback connections are not optional decorations — they are the credit signal delivery system. Any trainable module must be connected to a feedback source carrying a teaching signal. Modules with no apical-analog input can only be trained by a different mechanism (e.g., a separate reward signal or frozen initialization).

---

## ML Instantiation: Dendritic ANNs (Chavlis & Poirazi 2025)

The dANN architecture demonstrates that biological dendritic properties can be captured in a differentiable model **without NMDA spike simulation**. Key design choices and their biological analogs:

| dANN component | Biological analog | Effect |
|---|---|---|
| Masked weight matrix $\mathbf{W}_k \leftarrow \mathbf{W}_k \odot \mathbf{M}_k$ | Dendrite-to-soma sparse tree connectivity | Structured sparsity; natural regularizer |
| Local receptive field (LRF) input sampling | Visual cortex RF clustered synaptic inputs | Best efficiency; 1–3 OoM fewer params |
| Gradient zeroing at non-connections: $\frac{\partial\mathcal{L}}{\partial\vartheta} \leftarrow \frac{\partial\mathcal{L}}{\partial\vartheta} \odot \mathbf{M}_k$ | Local synaptic updates only | Respects structural constraint during learning |
| Two hidden layers (dendritic + somatic) | Dendrite + soma two-compartment neuron | Hierarchical feature extraction within a single neuron |

**Mixed-selectivity emergence:** dANN nodes converge to high-entropy, multi-class responses (mixed selectivity) while vANN nodes become class-specific. This is not imposed by the training objective — it emerges from the structured sparse connectivity. The bimodal cable-weight distribution (layer 2) confirms near-full utilization of trainable parameters, in contrast to vANN Gaussian weights clustered near zero.

**Robustness profile:** On noisy inputs (Gaussian σ up to 1.0) and sequential class-incremental learning, dANNs degrade more slowly than vANNs — a direct ML analog of dendrites filtering irrelevant or noisy stimuli in biology.

**Design implication for reasoning models:** structured dendritic sparsity is a drop-in module applicable to any fully-connected layer in transformer or CNN architectures; it simultaneously reduces parameter count, improves regularization, and induces mixed-selectivity representations without any additional training objective.

---

## Open Problems

1. **NMDA spikes in differentiable ML:** Chavlis & Poirazi 2025 show dendritic structural properties (sparsity, RFs) alone are sufficient for efficiency gains without simulating NMDA spikes. The remaining question is whether adding threshold-logic dendritic nonlinearity (NMDA plateau approximation) adds further benefits or creates optimization pathology.
2. How active dendritic segments interact with global attention mechanisms — do they operate in parallel or in competition?
3. Whether dendritic branches implement learned routing (i.e., do the 8–20 synapses per segment self-organize via local Hebbian rules or require a global error signal)?
4. **Phase multiplexing for AR:** Activation Relaxation (Millidge et al. 2020) proposes apical dendrites as the solution to its two-phase problem — apical compartments maintain the forward-pass activation while basal/somatic compartments iterate toward gradient equilibrium during relaxation. Whether apical-basal segregation is sufficient and whether oscillatory rhythms (alpha/gamma) can coordinate the phase transitions remains an open design question.
5. **Structured vs. learned sparsity:** dANN uses fixed, handcrafted RFs. Whether learning the connectivity mask (e.g., via differentiable pruning) could discover better-than-biological topologies for reasoning tasks is open.

---

## Connections

- **[[wiki/concepts/sparse-distributed-representations.md]]** — NMDA spike coincidence detection is only reliable when presynaptic populations are sparse and high-dimensional; SDR (Sparse Distributed Representations) scaling laws explain why dendritic binding requires the neocortical sparse coding regime.
- **[[wiki/concepts/binding-problem.md]]** — local dendritic NMDA spikes are the binding mechanism for local feature conjunctions; the binding table in that page lists this as the "local dendritic binding" row.
- **[[wiki/entities/basal-ganglia.md]]** — SPN (Spiny Projection Neuron) up-state bistability is a dendritic computation: Kir2 K⁺ channels block transition to up-state until convergent Glu input overcomes them; D1/D2 receptors modulate the convergence threshold in opposite directions via their distinct downstream cascades.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — BTSP uses EC-instructed dendritic plateau potentials in CA1 to write one-shot place fields; the EC (Entorhinal Cortex) input is the instructive signal that depolarizes the dendrite to the plateau threshold during a behavioral event.
- **[[wiki/concepts/two-learning-timescales.md]]** — BTSP (single-shot, seconds timescale) vs. STDP (many-shot, milliseconds timescale) are two dendritic plasticity rules that together span the fast-M timescale; both operate at dendritic synapses, not the soma.
- **[[wiki/concepts/hebbian-learning.md]]** — STDP is Hebbian learning with a dendritic mechanistic implementation: NMDA Mg²⁺-unblock kinetics set the ±20ms coincidence window; L-type Ca²⁺ provides the separate Ca²⁺ source for LTD; the E→E cell-type constraint (Bi & Poo 1998) limits Hebbian writes to excitatory circuits.
- **[[wiki/papers/bi-poo-stdp-1998.md]]** — primary empirical source for STDP timing window, NMDA requirement, synaptic-strength ceiling, cell-type specificity, and L-type Ca²⁺ asymmetry.
- **[[wiki/concepts/credit-assignment.md]]** — the dual-compartment pyramidal cell architecture is the biological implementation of dendritic error learning, one of the medium-bias/medium-variance credit assignment approximations in the bias–variance taxonomy.
- **[[wiki/papers/richards-lillicrap-dl-framework-2019.md]]** — frames apical dendritic credit signals as the neural substrate for structural credit assignment; establishes that top-down feedback pathways need not be precise weight transposes (feedback alignment principle) for credit delivery to work.
- **[[wiki/papers/millidge-activation-relaxation-2020.md]]** — proposes apical dendrites as the solution to AR's two-phase problem: the apical compartment maintains the original forward-pass activation during the backward relaxation phase, enabling the two tasks (activation encoding and gradient computation) to coexist in the same neuron via dendritic segregation.
- **[[wiki/papers/bastos-canonical-microcircuit-2012.md]]** — establishes L1 inhibitory cells as the specific anatomical route through which feedback predictions arrive at apical dendrites of L2/3 pyramidal cells; the "L1 as feedback inhibition hotspot" result grounds the dual-compartment architecture in quantitative anatomy and identifies the apical dendrite as simultaneously a credit-signal landing site and a prediction-suppression target.
- **[[wiki/concepts/predictive-coding.md]]** — predictive coding's two-population architecture (error vs. prediction neurons) is implemented via the apical/basal compartment split; the L1 inhibitory route is the mechanism by which deep-layer prediction neurons suppress superficial prediction-error neurons.
- **[[wiki/papers/theories-backprop-brain-whittington-2019.md]]** — source for Martinotti cells as the specific interneuron type implementing local error prediction in the dendritic error model; explains the circuit logic by which the Martinotti cell self-loop computes actual-feedback minus predicted-feedback at the apical dendrite.
- **[[wiki/concepts/canonical-microcircuit.md]]** — Douglas & Martin's two-class inhibitory dissociation (horizontal basket/chandelier → soma/AIS; vertical double bouquet → distal dendrites) is the circuit-level origin of the dual-compartment architecture described here; proximal inhibition implements WTA (Winner-Take-All) at the soma while distal inhibition gates dendritic input-output independently.
- **[[wiki/concepts/representational-geometry.md]]** — dANNs spontaneously develop mixed-selectivity nodes (high entropy, multi-class response), providing an ML-side confirmation that structured sparsity — not explicit training pressure — can induce the mixed-selectivity geometry associated with high CCGP (Cross-Condition Generalization Performance)/SD balance.
- **[[wiki/concepts/continual-learning.md]]** — dANN structured sparsity reduces sequential learning interference without explicit CL mechanisms, paralleling the SDR (Sparse Distributed Representations) passive protection argument; the sequential task results add an ML benchmark to support bio-inspired sparsity as a CL strategy.
- **[[wiki/papers/chavlis-dann-2025.md]]** — primary source for the dANN instantiation, mixed-selectivity analysis, parameter-efficiency results, and sequential learning robustness experiments.
- **[[wiki/papers/meta-learning-plasticity-random-feedback.md]]** — source for burst/spike multiplexing as the biological substrate for eHebb plasticity: co-burst events between adjacent cortical layers implement the error co-activity product $\mathbf{e}_\ell\mathbf{e}_{\ell-1}^T$, grounding the discovered meta-learned plasticity rule in the apical/basal compartment architecture described in this page.
