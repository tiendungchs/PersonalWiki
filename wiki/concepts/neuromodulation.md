---
title: "Neuromodulation"
type: concept
tags: [neuromodulation, reinforcement-learning, dopamine, serotonin, noradrenaline, acetylcholine, meta-learning, learning-rate, basal-ganglia]
created: 2026-06-19
updated: 2026-07-08
sources: [Metalearning_and_Neuromodulation, PFC_as_a_meta_RL_system, making_working_mem_work, The role of prefrontal cortex in cognitive control and executive function, Pattern separation in the hippocampus.md, Modulation of striatal projection systems by dopamine, The free-energy principle - a rough guide to the brain, Improving the adaptive and continuous learning capabilities of artificial neural networks Lessons from multi-neuromodulatory dynamics, "Dynamic Network Connectivity A New Form of Neuroplasticity", a-natural-history-of-the-human-mind]
related: [wiki/concepts/two-learning-timescales.md, wiki/concepts/predictive-coding.md, wiki/concepts/meta-learning.md, wiki/concepts/cognitive-control.md, wiki/concepts/associative-memory.md, wiki/concepts/pattern-separation.md, wiki/concepts/spike-frequency-adaptation.md, wiki/concepts/phase-precession.md, wiki/concepts/continual-learning.md, wiki/concepts/excitation-inhibition-balance.md, wiki/concepts/pfc-dynamic-network-connectivity.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/prefrontal-cortex.md, wiki/entities/basal-ganglia.md, wiki/entities/snn.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/papers/metalearning-neuromodulation-doya-2002.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/pbwm-oreilly-frank-2006.md, wiki/papers/pfc-cognitive-control-friedman-2021.md, wiki/papers/podlaski-context-modular-memory-2025.md, wiki/papers/yassa-stark-pattern-separation-2011.md, wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md, wiki/papers/friston-free-energy-2009.md, wiki/papers/sfa-ganguly-2024.md, wiki/papers/spiking-tem-kawahara-2025.md, wiki/papers/mei-multimodulatory-continual-2025.md, wiki/papers/spedding-jay-hpfc-psychiatric-2013.md, wiki/papers/arnsten-dynamic-network-connectivity-2010.md, wiki/papers/lai-mpfc-bla-nac-affective-2026.md, wiki/papers/sherwood-natural-history-mind-2008.md, wiki/concepts/neoteny.md]
---

# Neuromodulation

**The four major ascending neuromodulatory systems (DA, 5-HT, NA, ACh) are global chemical signals that set the metaparameters of distributed learning — they carry parameter values, not content.**

Doya (2002) maps each to a specific RL metaparameter, providing a falsifiable computational theory grounded in actor-critic reinforcement learning.

---

## Metaparameter Mapping

| Neuromodulator | RL metaparameter | Role | Brain source | Primary target |
|---|---|---|---|---|
| **Dopamine (DA)** | TD (Temporal Difference) error δ | Global learning signal for value + action | VTA / SNc (midbrain) | Striatum, PFC (Prefrontal Cortex) |
| **Serotonin (5-HT)** | Discount factor γ | Time horizon of reward prediction | Dorsal raphe | Striatum, cortex |
| **Noradrenaline (NA)** | Inverse temperature β; **network integration mode** | Exploration/exploitation balance; shifts whole-brain topology from segregated to integrated | Locus coeruleus (LC) | Cortex, globus pallidus |
| **Acetylcholine (ACh)** | Learning rate α | Speed of memory storage vs. retrieval | Basal forebrain / brainstem | Hippocampus, cortex, striatum |

---

## Key Equations

**TD error (dopamine signal):**
```
δ(t) = r(t) + γ V(s(t)) − V(s(t−1))
```
DA neurons fire above baseline for δ > 0, below for δ < 0, silent for δ = 0. Direction of cortico-striatal synaptic plasticity is gated by Dopamine level (Reynolds & Wickens 2001).

**State value function (serotonin sets γ):**
```
V(s(t)) = E[r(t+1) + γ r(t+2) + γ² r(t+3) + ...]
```
Low γ → discounts future rapidly → impulsive choice. High γ → near-patient planning. Serotonin depletion in rats → impulsive preference for small immediate over large delayed reward.

**Boltzmann action selection (NA sets β):**
```
P(a_i | s) = exp(β Q(s, a_i)) / Σ_j exp(β Q(s, a_j))
```
β → 0: uniform exploration. β → ∞: greedy winner-take-all. LC activation calibrates β via neuronal gain modulation.

**Weight update (ACh sets α):**
```
Δv_j ∝ α · δ(t) · b_j(s)
```
High ACh → large α → fast memory storage. Low ACh → small α → retrieval mode.

---

## Evidence Summary

| Neuromodulator | Evidence quality | Key finding |
|---|---|---|
| **DA** | Strong (electrophysiology) | Schultz et al. 1993–1998: Dopamine neurons match TD (Temporal Difference) error exactly across three behavioral phases: pre-learning (responds to reward), post-learning (responds to cue, not reward), omission (negative response) |
| **NA** | Good (behavior + pharmacology) | Aston-Jones et al. 1994: LC activity correlates with attention task accuracy; amphetamine (↑NA) → stereotyped behavior (high-β exploitation) |
| **ACh** | Good (circuit + pharmacology) | Hasselmo & Bower 1993: ACh suppresses CA3→CA1 (Schaffer collaterals) and enables LEC→CA1 encoding; Alzheimer's = cholinergic neuron loss |
| **5-HT** | Moderate (complex interactions) | Depletion → impulsive small-immediate over large-delayed reward; but DA/5-HT interactions are bidirectional and receptor-subtype-dependent |

---

## Dopamine Receptor Cellular Mechanisms (D1 / D2)

The abstract "DA = TD (Temporal Difference) error" mapping is implemented via biochemically opponent receptor cascades in the striatum (Gerfen & Surmeier 2011, [[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]]):

| Pathway | Receptor | Cascade | Net effect |
|---|---|---|---|
| **Direct SPN** | D1 → Gs | cAMP ↑ → PKA ↑ → Cav1 Ca²⁺ ↑, K⁺ ↓, AMPA/NMDA surface expression ↑ | Excitability ↑; corticostriatal LTP (Long-Term Potentiation) (requires D1 + NMDA co-activation) |
| **Indirect SPN** | D2 → Gi | cAMP ↓ → Cav1 ↓, K⁺ ↑; endocannabinoid (EC) production → retrograde CB1 → Glu release ↓ | Excitability ↓; LTD (Long-Term Depression) (requires D2 + postsynaptic depolarization) |

**A single phasic Dopamine burst writes opposite plasticity rules to both populations simultaneously.** Dopamine pause (aversive event) reverses both: direct SPNs shift to LTD (Long-Term Depression) bias, indirect SPNs become LTP-permissive. Parkinson's disease (DA depletion) confirms the opponent structure is architecturally required — both pathways reverse simultaneously; neither compensates for the other.

**Convergence requirement:** SPNs rest at −90 mV ("down-state") via Kir2 K⁺ channels and only reach spike threshold ("up-state") under spatially/temporally convergent glutamatergic input. D1 lowers this convergence threshold in direct SPNs; D2 raises it in indirect SPNs. Dopamine sculpts *which population* detects convergence — not just how strongly. See [[wiki/entities/basal-ganglia.md]] for full circuit detail.

---

## ACh and HC Storage/Retrieval Switch

The most direct architectural implication. Hasselmo & Bower 1993 (cited in Doya 2002):

| ACh level | HC mode | Mechanism |
|---|---|---|
| **High** | **Storage (encoding)** | Suppresses CA3→CA1 Schaffer collateral (blocks old pattern completion); enables LEC→CA1 direct encoding of new episode |
| **Low** | **Retrieval** | Restores CA3 Schaffer collateral; pattern completion from stored attractors dominates; LEC input de-emphasized |

This is the biological mechanism for the fast-M/slow-W switch in [[wiki/concepts/two-learning-timescales.md]]: ACh gates whether HC is in write (fast M) or read (structural W consultation) mode. Novelty and task demand elevate ACh via basal forebrain cholinergic neurons.

**Structural complement (Rolls 2013):** The ACh switch has an architectural counterpart: CA3 mossy fiber synapses (~46 per cell, strong, soma-proximal) are structurally designed to dominate RC dynamics during encoding even without ACh modulation. ACh suppression of CA3→CA3 RC amplifies an advantage already wired into the mossy fiber pathway. The two mechanisms are convergently redundant — structural wiring enforces mossy fiber dominance; neuromodulation refines it. See [[wiki/entities/hippocampal-entorhinal-system.md]] and [[wiki/papers/pattern-completion-rolls-2013.md]].

**Context-gating circuit mechanisms (Podlaski et al. 2025):** The context-modular Hopfield model (see [[wiki/concepts/associative-memory.md]]) proposes two circuit-level implementations of the inhibitory mask that a contextual signal must impose on a memory network: (1) **neuronal gating** — perisomatic inhibition (basket/chandelier cells) suppresses whole neurons in non-active contexts; (2) **synaptic gating** — dendrite-targeting interneurons (SOM+, SST+ cells in cortex and HC) selectively gate individual dendritic branches, enabling synapse-group-level control. This maps neuromodulatory context signals (top-down from PFC/BG via interneuron recruitment) to a concrete gating mechanism that the associative memory framework can analyze rigorously.

**Noradrenergic specificity in DG (Dentate Gyrus) (Yassa & Stark 2011 [[wiki/papers/yassa-stark-pattern-separation-2011.md]]):** Locus coeruleus noradrenergic axons terminate in the DG (Dentate Gyrus) polymorphic layer at *orders of magnitude* greater density than anywhere else in HC. This structural specialization suggests NA (Noradrenaline / Norepinephrine) plays a DG-specific role — modulating the hilar mossy cells and HIPP interneurons that regulate DG's separation/completion bias — distinct from the global inverse-temperature (β) function identified by Doya 2002. NA's elevated presence specifically in the DG (Dentate Gyrus) regulatory layer (polymorphic/hilar zone) is a structural argument that arousal/stress signals can shift the separation/completion balance independently of the global NA (Noradrenaline / Norepinephrine) broadcast. See [[wiki/concepts/pattern-separation.md]] (Regulatory Control section) for the hilar circuit.

**Striatal ACh: temporal gating of pathway routing (Gerfen & Surmeier 2011 [[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]]):** In the striatum, cholinergic interneurons (~5% of neurons) receive dominant glutamatergic input from the *thalamus* (not cortex) and fire in burst-pause patterns following salient stimuli — a function architecturally distinct from the HC ACh storage/retrieval switch. Thalamic burst → ACh burst → M2 presynaptic receptors suppress corticostriatal Glu release probability (reduces drive to both SPN (Spiny Projection Neuron) types). Pause → M1 postsynaptic on D2 SPNs closes Kir2 K⁺ → ~1-second window of enhanced indirect-pathway dendritic excitability; cortical input now preferentially activates the NoGo pathway. Dopamine (via D2 on cholinergic interneurons) gates the pacemaker — baseline Dopamine suppresses the burst-pause; phasic Dopamine drops allow thalamic salience to redirect corticostriatal processing through the indirect pathway. Same neuromodulator (ACh), different circuit role: the HC switch gates memory encoding/retrieval; the striatal switch gates pathway routing on salient events. See [[wiki/entities/basal-ganglia.md]].

---

## SFA: Single-Neuron Intrinsic Gain Control

Spike frequency adaptation (SFA, [[wiki/concepts/spike-frequency-adaptation.md]]) is the most local scale of intrinsic gain modulation — the neuron adapts its own firing threshold based on its own spike history, without any external signal:

$$a_j(t + \delta t) = \rho_j \cdot a_j(t) + (1-\rho_j)\cdot z_j(t), \quad v_{th,j} = b_0 + \beta \cdot a_j(t)$$

This sits below the neuromodulatory and liquid-τ levels in a hierarchy of gain adaptation:

| Scale | Mechanism | What adapts | Signal source |
|---|---|---|---|
| Global neuromodulation (ACh, NA, DA) | Diffuse chemical broadcast | Integration window / learning rate for an entire circuit | Basal forebrain / LC / VTA |
| Local synaptic conductance (liquid τ) | Per-neuron input-driven recurrent gate | Per-neuron integration time constant, per-timestep | Current synaptic inputs |
| **SFA / adaptive threshold** | **Per-neuron spike-triggered trace** | **Per-neuron firing threshold, per-spike** | **Own spike history** |

**Design implication for reasoning models:** SFA (Spike Frequency Adaptation) provides gain control that is maximally local and requires no dedicated modulatory pathway. A network can implement coarse gain control via neuromodulation (Blocks 2C/3B), fine time-constant adaptation via liquid τ, and finest-grained activity-history sensitivity via SFA (Spike Frequency Adaptation) — all three can co-exist in the same neuron population.

---

## Liquid τ: Input-Dependent Time-Constant Modulation

Neuromodulators shift neural time constants globally — ACh shortens HC integration windows by suppressing Schaffer collaterals; NA (Noradrenaline / Norepinephrine) modulates LC pacemaker timing; Dopamine affects striatal up-state dwell times. LTCs ([[wiki/entities/ltc-model.md]]) formalize an analogous mechanism at the local, continuous level: the effective time constant of each neuron becomes `τ_sys = τ / (1 + τ·f(x, I, t, θ))`, adapting per-neuron integration windows based on what is currently arriving — a *self-modulating* time constant that does not require a separate chemical signal.

| Scale | Mechanism | What changes |
|---|---|---|
| Global neuromodulation (ACh, NA, DA) | Diffuse chemical broadcast | Integration window for an entire circuit or region |
| Local synaptic conductance (gl in cable eq.) | Per-synapse receptor kinetics | Integration window of a single dendritic compartment |
| **Liquid τ (LTC)** | **Input-dependent recurrent gate** | **Per-neuron integration window, updated at each timestep** |

The liquid τ is therefore a mechanistic formalization of neuromodulatory time-constant control at the unit level, derived from the same cable equation that describes biological leaky integration. Unlike neuromodulation (which requires a separate broadcast signal), τ_sys adapts intrinsically. This suggests a design principle: a reasoning model's time constants should be input-dependent, allowing fast integration during rapid sensory transitions and slow integration during steady-state maintenance — without requiring a dedicated neuromodulatory signal.

---

## Dynamic Interactions — Metalearning Loop

The four modulators are co-regulated, not independent:

```
DA variance high  →  inhibit 5-HT  (γ ↓: shorten horizon in uncertain env)
5-HT (γ) high    →  inhibit NA (Noradrenaline / Norepinephrine) (β ↓) + inhibit ACh (α ↓)
V(s) extreme     →  NA (Noradrenaline / Norepinephrine) ↑  (β ↑: focus when value is very high or very low)
DA sign reversals frequent  →  ACh ↓  (α ↓: delta-bar-delta: stop learning when oscillating)
```

Predicted trajectory in a novel environment: high Dopamine variance → 5-HT suppressed (short γ) → NA (Noradrenaline / Norepinephrine) low (wide exploration) → ACh high (fast write). As learning stabilizes: Dopamine variance drops → 5-HT rises → NA (Noradrenaline / Norepinephrine) and ACh increase → focused, patient, slower-writing agent.

---

## Application to Reasoning Model

Doya's framework grounds three building blocks from [[wiki/queries/building-blocks-mec-hc-pfc.md]]:

| Block | Biology (Doya 2002) | ML implementation |
|---|---|---|
| **2C: Write gate** | ACh = α; novelty/surprise → high ACh → high write rate | `M ← M + σ(δ_pred) · p_t`; δ_pred ≈ Dopamine signal (prediction error) |
| **3B: WM gate** | Dopamine D1 stabilizes PFC (Prefrontal Cortex) working memory (β ↑); D2 destabilizes (β ↓) | Learned β scalar: freeze (D1 dominant) vs. update (D2 dominant) on prediction error |
| **3D: Goal generator** | Dopamine TD (Temporal Difference) error signals goal miss; ACC (Anterior Cingulate Cortex) conflict → triggers re-planning | Prediction error gates Block 3A (transformation inference): large δ → invoke inferrer |

---

**PVLV (O'Reilly & Frank 2006):** A biologically grounded non-TD alternative for the BG (Basal Ganglia) Dopamine signal — more robust than TD (Temporal Difference) chaining when intermediate stimuli are unpredictable. Full account in [[wiki/concepts/meta-learning.md]] (PVLV section), where it belongs alongside PBWM as the Dopamine algorithm underlying the BG (Basal Ganglia) slow outer loop. See also [[wiki/entities/basal-ganglia.md]].

---

## Dopamine = Precision vs. Dopamine = TD (Temporal Difference) Error (Friston 2009 vs. Doya 2002)

Two competing accounts; see [[wiki/open-problems.md]] Empirical Tensions for status.

**Friston 2009** ([[wiki/papers/friston-free-energy-2009.md]]): Dopamine encodes the **precision of prior predictions** (incentive salience / "the value of prediction error"). Under this account: (a) action is only triggered when predictions are sufficiently precise; (b) Parkinson's bradykinesia = low Dopamine = imprecise priors = small action-triggering prediction errors = poverty of movement — without requiring any reward computation; (c) all four neuromodulators encode precision in anatomically distinct hierarchies (ACh in exteroceptive/posterior, Dopamine in interoceptive/motor/prior systems), not four distinct RL metaparameters.

**Doya 2002** ([[wiki/papers/metalearning-neuromodulation-doya-2002.md]]): Dopamine encodes TD (Temporal Difference) error δ(t) = r(t) + γV(s(t)) − V(s(t−1)), requiring an explicit reward signal.

Both accounts predict the same Pavlovian signatures (DA burst to reward/cue, dip to omission). They diverge for instrumental/motor tasks without explicit reward: Friston → Dopamine governs motor initiation via prior precision; Doya → Dopamine signals value prediction error across episodes. The Gerfen & Surmeier 2011 D1/D2 cellular mechanism is compatible with either — it specifies *how* Dopamine gates plasticity, not *what* it signals computationally.

**Partial reconciliation (Friston 2009):** Friston notes Dopamine may encode the "value of prediction error" = incentive salience (Berridge 2007 [[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]] for mechanism). If incentive salience = precision of goal-predicting priors, then the precision account subsumes value-learning: goal pursuit = making precise predictions about desired states self-fulfilling via action. The Dopamine dual role (Wang et al. 2018) — Dopamine as plasticity signal (slow, shaping PFC (Prefrontal Cortex) weights) and as activity input (fast, informing PFC (Prefrontal Cortex) recurrent dynamics) — is compatible with the precision account if the activity channel carries precision estimates rather than raw TD (Temporal Difference) error.

---

## Dual Role of Dopamine (Wang et al. 2018)

Doya 2002 establishes Dopamine as a synaptic plasticity signal (TD error). Wang et al. 2018 ([[wiki/papers/pfc-meta-rl-wang-2018.md]]) identifies a second, distinct role:

| Role | Timescale | Mechanism | Function |
|---|---|---|---|
| **Plasticity signal** | Slow (training) | Dopamine modulates cortico-striatal LTP/LTD | Shapes PFC (Prefrontal Cortex) recurrent weights → installs the fast within-episode RL algorithm |
| **Activity input** | Fast (within episode) | RPE injected as input to PFC (Prefrontal Cortex) LSTM hidden state | Carries reward information that the recurrent dynamics integrate over the episode |

These are experimentally dissociable: optogenetically blocking/inducing Dopamine at test (frozen weights) shifts behavior via the activity channel alone — the fast algorithm depends on Dopamine as a *signal*, not just as a plasticity trigger. This means the ACh = learning-rate interpretation (Doya) and the Dopamine = activity-information interpretation (Wang et al.) are complementary, not competing.

---

## PFC Network Modulation: The DNC Mechanism (Arnsten et al. 2010)

While Doya 2002 maps neuromodulators to RL metaparameters and Gerfen & Surmeier 2011 gives the striatal D1/D2 cascade, Arnsten et al. 2010 ([[wiki/papers/arnsten-dynamic-network-connectivity-2010.md]]) reveal the molecular implementation of neuromodulatory control specifically in PFC working memory circuits. All four signals converge on **cAMP** as the central switch for network connection strength.

**The cAMP hub:**
```
cAMP ↑  →  HCN channels open (direct) + KCNQ K⁺ channels open (via PKA)
        →  K⁺ conductance ↑ at spine neck  →  shunts synaptic input  →  network WEAKENED
cAMP ↓  →  HCN/KCNQ close + TRPC depolarizing channels open  →  network STRENGTHENED
```

| Signal | Receptor | cAMP | Network effect |
|--------|----------|------|---------------|
| **NE (optimal)** | α2A-AR → Gi | ↓ | Strengthens preferred-direction firing (signal ↑) |
| **ACh** | α7 nAChR → NMDA direct | — | Strengthens (direct spine depolarization) |
| **ACh** | M1 muscarinic → KCNQ closure | — | Strengthens (M-current block) |
| **DA (moderate)** | D1R → Gs (nonpreferred spines) | ↑ moderate | Sculpts network: reduces noise in nonpreferred directions |
| **DA/NE (high/stress)** | D1R/α1-AR/β-AR | ↑↑ | Collapses entire network |
| Ca²⁺ entry (NMDA) | → SK channels | — | Negative feedback: limits excitability |
| Glu spillover | mGluR1/5 → Gq → IP3-Ca²⁺ | — | Negative feedback |

**Stress → PFC offline:** Acute stress drives massive NE + DA release → cAMP surge → HCN/KCNQ open → PFC delay-period firing collapses within seconds → amygdala and striatum simultaneously strengthen → reflexive behavior takes over. Molecular mechanism for the integration→segregation switch (see [[wiki/concepts/network-integration-segregation.md]]).

**WM capacity limit as epilepsy prevention:** The same negative feedback (Ca²⁺/SK + cAMP/HCN/KCNQ) that prevents seizures in recurrent PFC circuits also limits WM duration to ~10–30 sec. This is why HC must engage for longer delay periods — HC provides storage not subject to this ceiling.

**Design implication:** The NA (NE) analog (α2A-AR axis) is the molecular basis for Gap #8's conditional hub activation. A reasoning model's hub module should have an analog of α2A-AR gating: a global demand/arousal signal that, when at optimal level, closes the equivalent of HCN channels and strengthens hub connectivity; when overdriven (stress analog), collapses it. See [[wiki/concepts/pfc-dynamic-network-connectivity.md]] for the full mechanistic formalism.

---

## Neurochemical CC (Cognitive Control) Specificity (Friedman & Robbins 2021)

Friedman & Robbins identify a finer-grained mapping between neuromodulators and CC (Cognitive Control) components than Doya's global metaparameter account:

| Neuromodulator | CC (Cognitive Control) component | Evidence |
|---|---|---|
| **DA D1 in dlPFC** | WM stability / interference resistance | Inverted-U: too little Dopamine → signal lost; too much → noise amplification. Lesion: Dopamine depletion in marmoset dlPFC impairs spatial delayed response *but improves* extra-dimensional shifting (opponent effects on WM vs. flexibility) |
| **5-HT in OFC** | Reversal learning (value-based flexibility) | OFC (Orbitofrontal Cortex) serotonin depletion in marmoset → impairs reversal learning, NOT extra-dimensional set-shifting; citalopram (SSRI) in humans enhances OFC (Orbitofrontal Cortex) reversal, no effect on stop-signal |
| **NA via RIFG → STN** | Response inhibition | Atomoxetine (NA reuptake inhibitor) enhances stop-signal performance, no effect on OFC (Orbitofrontal Cortex) reversal; hyperdirect RIFG→STN pathway is the anatomical substrate — RIFG modulates STN (Subthalamic Nucleus) excitability to gate the global motor inhibition signal |
| **ACh (basal forebrain)** | Cognitive effort allocation (top-down) | PFC (Prefrontal Cortex) "top-down" control over cholinergic system: PFC (Prefrontal Cortex) → NBM circuitry suggests cholinergic arousal is itself gated by PFC, not just the reverse |

**Key implication for reasoning model:** Dopamine and 5-HT mediate *different* CC (Cognitive Control) components, not just different timescales of the same signal. The dissociation (DA impairs flexibility while improving WM; 5-HT specifically modulates OFC (Orbitofrontal Cortex) value-reversal not rule-shifting) means neuromodulation should be CC-component-specific in the model, not a global learning-rate dial.

The NA/RIFG/STN inhibitory circuit is a separate response-gating mechanism distinct from the Dopamine D1 WM-stability mechanism — this maps to the distinction between Block 3D (goal generator, driven by goal/error signal) and Block 3B (WM, stabilized by Dopamine D1 analog).

**D1 modulation of H-PFC pathway plasticity (Spedding & Jay 2013 [[wiki/papers/spedding-jay-hpfc-psychiatric-2013.md]]):** D1 receptors regulate LTP/LTD in the direct vHPC→mPFC projection — not only in PFC-internal circuits. Two mechanisms: (a) D1 activation increases interneuron excitability in mPFC, shifting the H-PFC pathway's net effect from direct pyramidal excitation to interneuron-mediated feed-forward inhibition — a gain-normalizing mechanism stabilizing PFC representation under variable hippocampal drive; (b) dopamine application to PFC increases HC-PFC theta-coherence, directly linking DA neuromodulation to H-PFC channel strength. Stress disrupts D1-gated LTP → WM failure; antidepressants and glucocorticoid receptor antagonists restore both LTP and WM. This extends the D1=WM-stability mapping from PFC-internal dynamics to the incoming HC-PFC information channel.

---

## Neuromodulation as Temporal Coding Mode Controller

Spiking TEM ([[wiki/papers/spiking-tem-kawahara-2025.md]]) introduces a dimension of neuromodulatory function not captured by Doya's RL-metaparameter account: neuromodulation controls *which temporal coding regime* a network layer operates in, not just how fast it learns.

The model's gain factor G scales total synaptic input per neuron:
$$I(t) = G \cdot \sum_j w_{ij} \cdot s_j(t)$$

G is a learnable parameter initialized at 1.0 and optimized via backpropagation. Applied to MECII and MECIII output layers, it acts as an acetylcholine/dopamine analog for gain modulation.

| Condition | MECII temporal mode | MECIII temporal mode |
|---|---|---|
| G on, theta_MECIII on (biological) | Phase-precessing (80.2%) | Phase-locked (86.7%) |
| G on, theta_MECIII off | Phase-precessing | Phase-precessing |
| G off, theta_MECIII on | Phase-locked | Phase-locked |
| G off, theta_MECIII off | (impaired grid formation) | (impaired grid formation) |

**Implication:** neuromodulation is not just a learning rate dial — it determines whether a neural layer encodes a *temporal sequence* (precession = ordered look-ahead) or a *stable reference state* (locking = anchored phase). A reasoning model that needs to switch between sequential state tracking and stable state maintenance should implement G-like gain modulation per layer, not just globally.

See [[wiki/concepts/phase-precession.md]] for the phase precession formalism.

---

## Beyond Single Neuromodulators: Many-to-One Interactions (Mei et al. 2025)

Doya's one-to-one mapping (DA=δ, 5-HT=γ, NA=β, ACh=α) is a useful first-order approximation but misses the interactive structure of real neuromodulatory systems ([[wiki/papers/mei-multimodulatory-continual-2025.md]]).

**Three interaction modes observed experimentally:**

| Mode | Description | Example |
|---|---|---|
| **Modulatory** | One neuromodulator alters the release/transmission of another | Dopamine (via D2 on striatal CINs) gates ACh burst-pause → temporal routing |
| **Convergent** | Multiple neuromodulators exert overlapping effects on the same process | ACh+NA co-modulate attention allocation in PFC (Prefrontal Cortex) under uncertainty |
| **Opponent** | One neuromodulator suppresses the other's effect | 5-HT and Dopamine exert opponent reinforcement control in striatum |

**Projection specificity:** The same neuromodulator produces different functional effects depending on *where* it projects. ACh from the basal forebrain (BF) shapes:
- Emotional learning at BF→amygdala
- Spatial memory at BF→dorsal HC
- Cue encoding at BF→medial PFC

**Cortical neuron projection-specificity (Lai et al. 2026 [[wiki/papers/lai-mpfc-bla-nac-affective-2026.md]]):** This principle extends beyond neuromodulatory systems to cortical excitatory neurons. mPFC prelimbic neurons projecting to BLA vs. NAc are functionally distinct ensembles within the same cortical region: mPFC→BLA encodes negatively-valenced states (anxiety, aversion); mPFC→NAc encodes positively-valenced states (exploration, social preference via pattern decorrelation). Critically, population-level firing rates are equivalent — functional divergence is invisible to rate coding and emerges only at the ensemble dynamics level. This means a single global modulatory signal to mPFC cannot explain the routing; structural projection identity is the primary functional determinant. See [[wiki/entities/prefrontal-cortex.md]] for the full table and architectural implication.

A single global ACh broadcast cannot implement this diversity — the neuromodulatory effect is target-circuit-specific.

**Ionotropic vs. metabotropic timescales:** Two receptor classes enable multi-timescale operations within a single neuromodulatory system:

| Class | Examples | Speed | Effect |
|---|---|---|---|
| Ionotropic | 5-HT₃, nicotinic ACh (nAChR) | Fast (ms) | Direct ion flux, short-term plasticity |
| Metabotropic | All DA, all NA (Noradrenaline / Norepinephrine) (GPCRs), most 5-HT, muscarinic ACh | Slow (sec–min) | Second-messenger cascades (cAMP, PKA, PKC, Ca²⁺), gene expression, long-term excitability |

The coexistence of both enables a network to respond rapidly (ionotropic) while simultaneously initiating longer-lasting structural changes (metabotropic). Current ANNs model the ionotropic path only — the metabotropic path (slow cascade → gene expression → structural plasticity) has no principled ANN analog beyond vague "slow learning rate" approximations.

---

## Neuromodulation as Attractor Landscape Controller

Viewing neural dynamics through the lens of **attractor landscapes** provides a framing that unifies the metaparameter and continual learning roles of neuromodulators (Mei et al. 2025):

- Neuromodulators **stabilize** task-relevant attractor basins (deepen basins, reduce transition probability → exploitation)
- Neuromodulators **reshape** basins when task demands shift (alter basin geometry, bifurcate or merge attractors → reconfiguration)
- Neuromodulators **trigger transitions** between basins when contingencies change (flatten landscape → enable cross-basin exploration)

**NA's role in contingency shifting** is the clearest example: when the LC-NA system detects an unexpected environmental change (via a predictive coding discrepancy signal), a phasic NA (Noradrenaline / Norepinephrine) burst transiently *flattens* the energy landscape, increasing the network's effective temperature and enabling rapid exploration of alternative action policies. Once a new policy is found, tonic NA (Noradrenaline / Norepinephrine) decreases and the landscape steepens around the new attractor. This is the mechanism by which DA-only learning fails after a set-shift (trapped at old optimum) while DA+NA co-modulation recovers (NA flattens → explores → new basin found).

**NA as whole-brain topology gate (Shine et al. 2016 [[wiki/papers/shine-2016-integrated-network-states.md]]):** The same LC-NA arousal signal also governs the macroscale integration/segregation toggle. Pupil diameter (LC proxy) correlates with network-wide between-module participation coefficient B_T (r = 0.241 ± 0.06), maximal in frontoparietal, striatal, and thalamic hub regions. Mechanistically: NA gain increase amplifies cross-module hub inputs relative to within-module recurrence, shifting whole-brain topology from segregated (high-modularity, low global efficiency) to integrated (low modularity, high global efficiency). This is the attractor-landscape framing instantiated at the whole-brain scale: NA flattens within-module energy wells → inter-module coupling wins → integration. Crucially, integration specifically accelerates evidence accumulation (drift rate ↑, non-decision time ↓) without affecting response caution (boundary unchanged), ruling out a global arousal confound. See [[wiki/concepts/network-integration-segregation.md]] for the full topology formalism.

**Design implication:** An adaptive reasoning model needs not just a learning-rate dial (Doya) but an attractor topology modulator — a signal that can transiently increase effective temperature (NA-like) when the model detects environmental non-stationarity.

---

## Three-Factor Learning Rule and Eligibility Traces

The neuromodulatory signal M acts as the **third factor** in the extended Hebbian update:

$$\dot{w} = F(M, \text{pre}, \text{post})$$

Standard two-factor Hebb: `Δw ∝ pre · post`. The third factor M gates *when* Hebbian updates are applied, based on contextual signals from neuromodulatory systems. This resolves the temporal credit assignment problem: the synapse maintains an **eligibility trace** (a decaying memory of recent pre-post co-activity), and the neuromodulatory signal M converts the trace into an actual weight change when reward/surprise arrives.

| Third factor M | Source | Role |
|---|---|---|
| Reward (RPE) | Dopamine | Standard R-STDP: reward-driven plasticity |
| Surprise / contingency change | NA (Noradrenaline / Norepinephrine) (LC) | Enables rapid relearning after environment shifts; recent SNN implementations use prediction error to trigger LC phasic burst |
| Goal relevance | ACh (BF) | Tags synapses encoding task-relevant cue-action mappings for preferential consolidation |

**Key distinction from pure RL:** Eligibility traces allow the synapse to remember that it was recently active even if no reward has yet arrived — M converts this latent eligibility into a committed weight change when contextual information arrives asynchronously. This is the biological credit assignment solution that bridges fast synaptic events (ms) and slow neuromodulatory signals (sec).

---

## Artificial Threshold Modulation as Neuromodulation (HMN)

Zhao et al. 2022 ([[wiki/entities/hnn-framework.md]]) provide a direct artificial implementation of neuromodulatory threshold control in the **Hybrid Modulation Network (HMN)**:

An ANN backbone processes task context → learnable HUs generate a per-neuron threshold modulation vector $V_{\text{th},i}$ (same dimension as the SNN branch neuron count), trained to be cosine-similar to a task-similarity score:

$$V_{\text{th},i} = \max\left(\mathbb{E}_{(x,y)\in\mathcal{D}_i}[\text{HU}[\text{ANN}(x)]] - \tfrac{1}{2},\ 0\right)$$

Applied threshold: $\tilde{v} = (1 - V_{\text{th},i}) \cdot v_T$

High $V_{\text{th}}$ → large additional threshold → neuron inhibited (analogous to DA-D1 / high-ACh driven threshold elevation). Low $V_{\text{th}}$ → neuron active → task-specific subnet engaged. The ANN backbone learns to cluster similar tasks in the modulation space (confirmed by t-SNE of $V_{\text{th}}$), enabling parameter reuse across similar sub-tasks and preventing interference across dissimilar ones.

**Mapping to biological neuromodulation:**

| HMN component | Biological analog |
|---|---|
| ANN backbone (task context encoding) | Slow neuropeptide network / PFC contextual signal |
| Learnable HUs (→ threshold vector) | Cholinergic basal forebrain projections modulating cortical excitability |
| $V_{\text{th}}$ (per-neuron binary gate) | ACh/DA sculpting of which neurons enter up-state under convergent input |
| Task similarity alignment objective | Learning to map task structure onto neuromodulatory pattern space |

This is the first demonstration that a *learned* ANN signal can implement fine-grained neuromodulation (per-neuron, per-task) and achieve meta-continual learning performance superior to hand-designed EWC/SI approaches.

---

## Phylogenetic Upgrade of PFC Neuromodulatory Innervation (Sherwood et al. 2008)

A comparative-evolution data point on *where* neuromodulatory investment increased ([[wiki/papers/sherwood-natural-history-mind-2008.md]]): serotonin, dopamine, and acetylcholine axons provide **denser innervation of prefrontal layers V/VI (Brodmann 9, 32) in chimpanzees and humans than in macaques** — with *no* species difference in primary motor cortex (area 4). Additionally, chimp/human (not macaque) neocortex accumulates varicose axon **"coils"** for all three modulators, interpreted as markers of ongoing synaptic plasticity/reorganization.

**Implication:** the hominid cognitive upgrade included a *targeted* increase of neuromodulatory (learning-rate/gain) signaling specifically onto associative prefrontal circuits — consistent with the domain-general→domain-specific emergence thesis ([[wiki/concepts/neoteny.md]]), where reweighting general primitives (here, plasticity gain onto PFC) rather than adding modules drives specialization. Design cue: if a reasoning model concentrates its adaptive-plasticity budget on the executive/associative hub rather than uniformly, it mirrors the phylogenetic pattern.

---

## Open Problems

- Serotonin's role is the least settled: Daw et al. (2002) propose 5-HT = average reward (not γ); discriminating experiment requires comparing 5-HT effects when V(s) is positive vs. negative — not yet done definitively.
- The ACh switch assumes a simple high/low binary; real cholinergic modulation uses multiple receptor subtypes with opposing effects at different synapses (muscarinic vs. nicotinic; pre- vs. postsynaptic).
- Online learning vs. offline consolidation both involve ACh at different timescales — how the continuous cholinergic signal coordinates with event-gated SWR (Sharp Wave Ripple) plasticity is unresolved.
- Projection-specific neuromodulation has no ANN implementation: a single global ACh/NA/DA signal cannot replicate the target-specific functional diversity observed in biology (Gap: projection-specific modular neuromodulation).
- The metabotropic second-messenger cascade (slow, gene-expression-level plasticity) is not captured by any current ANN gate or activation function; bridging ionotropic-to-metabotropic timescale hierarchy in ANNs remains open.

---

## Connections

- **[[wiki/concepts/two-learning-timescales.md]]** — ACh (learning rate α) is the neuromodulatory mechanism that switches HC between fast-M storage mode (high ACh) and slow-W retrieval mode (low ACh); grounds the timescale split in a specific diffuse chemical signal.
- **[[wiki/concepts/predictive-coding.md]]** — Dopamine = TD (Temporal Difference) error is the reinforcement learning realization of the prediction error principle; both PC's ε and δ signal "better-than-predicted," differing only in whether the model predicts sensory input (PC) or reward (RL).
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — ACh from basal forebrain directly gates HC between encoding (high ACh, suppress CA3→CA1) and retrieval (low ACh, enable CA3 pattern completion) modes.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — Doya's theory gives biological grounding for Block 2C (write gate = ACh/α), Block 3B (WM gate = Dopamine D1/D2), and Block 3D (goal generator = Dopamine TD (Temporal Difference) error).
- **[[wiki/papers/metalearning-neuromodulation-doya-2002.md]]** — primary source; full derivation of each metaparameter hypothesis and their experimental evidence.
- **[[wiki/concepts/meta-learning.md]]** — meta-RL (Wang et al. 2018) reveals DA's dual role: the within-episode activity channel is the information feed for the PFC (Prefrontal Cortex) fast RL algorithm, extending beyond Doya's plasticity-only account.
- **[[wiki/papers/pfc-meta-rl-wang-2018.md]]** — source for Dopamine dual role; optogenetic simulation 6 dissociates synaptic vs. activity channels.
- **[[wiki/papers/pbwm-oreilly-frank-2006.md]]** — PBWM model; per-stripe Dopamine training of BG (Basal Ganglia) Go/NoGo weights; PVLV is the underlying Dopamine learning algorithm (full account in [[wiki/concepts/meta-learning.md]]).
- **[[wiki/entities/basal-ganglia.md]]** — BG (Basal Ganglia) is the biological substrate for DA-mediated action selection; stripe-based BG (Basal Ganglia)-PFC gating implements the WM update mechanism; PVLV is the BG (Basal Ganglia)-specific Dopamine learning algorithm.
- **[[wiki/concepts/cognitive-control.md]]** — neurochemical CC (Cognitive Control) specificity (DA→WM, 5-HT→OFC reversal, NA→RIFG inhibition) maps onto three dissociable CC (Cognitive Control) components; the inverted-U Dopamine function constrains Block 3B design.
- **[[wiki/papers/pfc-cognitive-control-friedman-2021.md]]** — source for neurochemical CC (Cognitive Control) specificity, inverted-U DA, OFC/5-HT dissociation, and NA/RIFG/STN response-inhibition circuit.
- **[[wiki/papers/pattern-completion-rolls-2013.md]]** — source for the structural complement to the ACh switch: mossy fiber dominance during encoding is architecturally wired independent of ACh; ACh suppression of CA3→CA3 RC amplifies this structural advantage.
- **[[wiki/papers/yassa-stark-pattern-separation-2011.md]]** — source for noradrenergic DG (Dentate Gyrus) specialization: LC axons terminate preferentially in DG (Dentate Gyrus) polymorphic layer at orders-of-magnitude greater density than elsewhere in HC, implicating NA (Noradrenaline / Norepinephrine) in DG-specific separation/completion balance regulation via hilar cells.
- **[[wiki/concepts/pattern-separation.md]]** — the hilar regulatory circuit (mossy cells + HIPP interneurons) and noradrenergic DG (Dentate Gyrus) specialization are documented in the Regulatory Control section; neuromodulation.md's ACh/NA entries are the chemical signals that drive that circuit.
- **[[wiki/concepts/associative-memory.md]]** — context-modular Hopfield framework provides the formal theory for how top-down contextual signals (plausibly carried by neuromodulatory or interneuron-mediated pathways) implement neuronal and synaptic gating to control which stored attractor states are accessible.
- **[[wiki/papers/podlaski-context-modular-memory-2025.md]]** — perisomatic interneurons (neuronal gating) and dendrite-targeting interneurons (synaptic gating) are the proposed biological mechanisms for the context-dependent inhibitory masks analyzed in the model.
- **[[wiki/entities/prefrontal-cortex.md]]** — Dopamine D1 inverted-U (dlPFC WM stability), NA/RIFG→STN (response inhibition), and ACC (Anterior Cingulate Cortex) unsigned PE are all PFC-subregion-specific neuromodulatory mechanisms; the entity page is the biological substrate for all three CC-component-specific neuromodulator mappings identified in the Friedman & Robbins analysis.
- **[[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]]** — source for D1/D2 cellular mechanisms (PKA→LTP vs. EC→CB1→LTD) that ground the DA=TD-error metaparameter in receptor biochemistry; also source for striatal cholinergic temporal gating — a context-sensitive pathway routing function (ACh burst-pause on salience) distinct from the HC ACh storage/retrieval switch.
- **[[wiki/entities/ltc-model.md]]** — the liquid time constant τ_sys is a local continuous-time formalization of neuromodulatory time-constant control: τ adapts per-neuron integration windows based on inputs, mechanistically equivalent to synaptic conductance modulation but implemented as an intrinsic recurrent gate.
- **[[wiki/papers/ltc-hasani-2021.md]]** — source for the liquid τ derivation from C. elegans cable equation; biological grounding in leakage conductance gl and synaptic current steady-state approximation.
- **[[wiki/papers/friston-free-energy-2009.md]]** — primary source for the DA=precision hypothesis (Contradiction entry); also grounds the claim that all four neuromodulators may encode precision in different hierarchical systems, with ACh handling exteroceptive and Dopamine handling interoceptive/motor precision.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — SFA (Spike Frequency Adaptation) is the most local level of the gain-adaptation hierarchy: per-neuron spike-triggered threshold adaptation requires no external signal, complementing global neuromodulatory and per-neuron liquid-τ adaptation; all three scales can co-exist in one neural population.
- **[[wiki/papers/sfa-ganguly-2024.md]]** — source for SFA (Spike Frequency Adaptation) biological prevalence (20–40% neocortical excitatory neurons), adaptive threshold formalism, and intrinsic gain-control characterization.
- **[[wiki/concepts/phase-precession.md]]** — neuromodulatory gain G is the sufficient condition for phase precession in SpikingTEM; the G + theta_MECIII combination produces the biologically observed MECII/MECIII temporal coding dissociation, establishing neuromodulation as a coding-mode controller beyond its RL-metaparameter role.
- **[[wiki/papers/spiking-tem-kawahara-2025.md]]** — source for the G-controlled temporal coding mode result; ablation table quantifying the four jointly necessary mechanisms for grid cell formation.
- **[[wiki/concepts/continual-learning.md]]** — neuromodulatory plasticity gating (three-factor rule, synaptic tagging, LC network-reset) are the biological solutions to catastrophic forgetting; the ACh/DA/NA metaparameter roles directly determine which CL paradigm (transfer, incremental, online) a system can support.
- **[[wiki/entities/snn.md]]** — SNNs are the natural substrate for integrating multi-timescale neuromodulatory signals; Dopamine R-STDP + NA-phasic burst implements the three-factor rule in the Mei et al. Go/No-Go conceptual demo.
- **[[wiki/papers/mei-multimodulatory-continual-2025.md]]** — source for the many-to-one principle, three interaction modes (modulatory/convergent/opponent), projection-specificity, ionotropic vs. metabotropic timescale hierarchy, attractor landscape framing, and NA-as-contingency-reset mechanism.
- **[[wiki/concepts/network-integration-segregation.md]]** — LC-NA broadcast is the gating signal for the whole-brain integration/segregation toggle; pupil-B_T correlation (r=0.241) provides empirical evidence; the attractor-landscape flattening by phasic NA implements the state transition from segregated to integrated topology.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — ACh, DA-D1, and NA all converge on E/I balance as the shared downstream variable through which neuromodulatory signals shift whole-brain synchrony and WM stability; E/I balance is the common currency of the metaparameter effects described in this page.
- **[[wiki/entities/hnn-framework.md]]** — HMN's ANN-generated threshold modulation vectors are the only published artificial implementation of fine-grained per-neuron neuromodulatory control: a learned ANN signal encoding task similarity directly modulates SNN excitability thresholds, achieving meta-continual learning performance superior to EWC/SI baselines and demonstrating that the neuromodulatory threshold-control principle is directly implementable in silicon.
- **[[wiki/papers/spedding-jay-hpfc-psychiatric-2013.md]]** — source for D1 modulation of H-PFC pathway LTP; interneuron-mediated inhibitory mechanism; dopamine → HC-PFC coherence link; stress-disrupted LTP as pathophysiology model; extends D1=WM-stability mapping to the incoming HC-PFC channel rather than PFC-internal dynamics alone.
- **[[wiki/concepts/pfc-dynamic-network-connectivity.md]]** — molecular implementation of NE/DA/ACh effects specifically in PFC working memory circuits; all three modulators act through the cAMP → HCN/KCNQ hub to rapidly and reversibly adjust network connection strength on seconds timescales; grounds the RL-metaparameter level in a biophysically specific cascade.
- **[[wiki/papers/arnsten-dynamic-network-connectivity-2010.md]]** — primary source for PFC DNC mechanism; α2A-AR/D1R/ACh pathways; stress-collapse mechanism; WM capacity limit from negative feedback; DISC1 as stress buffer.
- **[[wiki/papers/lai-mpfc-bla-nac-affective-2026.md]]** — demonstrates that projection-specificity applies to cortical excitatory neurons (not just neuromodulators): mPFC→BLA vs. mPFC→NAc are functionally distinct ensembles encoding opposite affective valences; rate coding cannot distinguish them — ensemble dynamics are required.
- **[[wiki/papers/sherwood-natural-history-mind-2008.md]]** — comparative evidence that hominids increased 5-HT/DA/ACh innervation *specifically* onto prefrontal L5/6 (not primary motor cortex), plus plasticity-marker axon coils; a phylogenetic instance of concentrating adaptive-plasticity budget on the executive/associative hub.
- **[[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]]** — supplies the neuromodulatory bus for the reasoning loop: ACh gates write-vs-read on surprise, NE sets exploration, 5-HT sets look-ahead depth, and DA's *dual duty* (RPE for value + novelty for exploration) is the mechanism by which a goal-free agent bootstraps latent goals — the same prediction error that builds the world model drives the exploration that discovers the goal.
