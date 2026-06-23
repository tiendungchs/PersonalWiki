---
title: "Neuromodulation"
type: concept
tags: [neuromodulation, reinforcement-learning, dopamine, serotonin, noradrenaline, acetylcholine, meta-learning, learning-rate, basal-ganglia]
created: 2026-06-19
updated: 2026-06-21
sources: [Metalearning_and_Neuromodulation, PFC_as_a_meta_RL_system, making_working_mem_work, The role of prefrontal cortex in cognitive control and executive function, Pattern separation in the hippocampus.md, Modulation of striatal projection systems by dopamine, The free-energy principle - a rough guide to the brain]
related: [wiki/concepts/two-learning-timescales.md, wiki/concepts/predictive-coding.md, wiki/concepts/meta-learning.md, wiki/concepts/cognitive-control.md, wiki/concepts/associative-memory.md, wiki/concepts/pattern-separation.md, wiki/concepts/spike-frequency-adaptation.md, wiki/concepts/phase-precession.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/prefrontal-cortex.md, wiki/entities/basal-ganglia.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/papers/metalearning-neuromodulation-doya-2002.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/pbwm-oreilly-frank-2006.md, wiki/papers/pfc-cognitive-control-friedman-2021.md, wiki/papers/podlaski-context-modular-memory-2025.md, wiki/papers/yassa-stark-pattern-separation-2011.md, wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md, wiki/papers/friston-free-energy-2009.md, wiki/papers/sfa-ganguly-2024.md, wiki/papers/spiking-tem-kawahara-2025.md]
---

# Neuromodulation

**The four major ascending neuromodulatory systems (DA, 5-HT, NA, ACh) are global chemical signals that set the metaparameters of distributed learning — they carry parameter values, not content.**

Doya (2002) maps each to a specific RL metaparameter, providing a falsifiable computational theory grounded in actor-critic reinforcement learning.

---

## Metaparameter Mapping

| Neuromodulator | RL metaparameter | Role | Brain source | Primary target |
|---|---|---|---|---|
| **Dopamine (DA)** | TD error δ | Global learning signal for value + action | VTA / SNc (midbrain) | Striatum, PFC |
| **Serotonin (5-HT)** | Discount factor γ | Time horizon of reward prediction | Dorsal raphe | Striatum, cortex |
| **Noradrenaline (NA)** | Inverse temperature β | Exploration/exploitation balance | Locus coeruleus (LC) | Cortex, globus pallidus |
| **Acetylcholine (ACh)** | Learning rate α | Speed of memory storage vs. retrieval | Basal forebrain / brainstem | Hippocampus, cortex, striatum |

---

## Key Equations

**TD error (dopamine signal):**
```
δ(t) = r(t) + γ V(s(t)) − V(s(t−1))
```
DA neurons fire above baseline for δ > 0, below for δ < 0, silent for δ = 0. Direction of cortico-striatal synaptic plasticity is gated by DA level (Reynolds & Wickens 2001).

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
| **DA** | Strong (electrophysiology) | Schultz et al. 1993–1998: DA neurons match TD error exactly across three behavioral phases: pre-learning (responds to reward), post-learning (responds to cue, not reward), omission (negative response) |
| **NA** | Good (behavior + pharmacology) | Aston-Jones et al. 1994: LC activity correlates with attention task accuracy; amphetamine (↑NA) → stereotyped behavior (high-β exploitation) |
| **ACh** | Good (circuit + pharmacology) | Hasselmo & Bower 1993: ACh suppresses CA3→CA1 (Schaffer collaterals) and enables LEC→CA1 encoding; Alzheimer's = cholinergic neuron loss |
| **5-HT** | Moderate (complex interactions) | Depletion → impulsive small-immediate over large-delayed reward; but DA/5-HT interactions are bidirectional and receptor-subtype-dependent |

---

## DA Receptor Cellular Mechanisms (D1 / D2)

The abstract "DA = TD error" mapping is implemented via biochemically opponent receptor cascades in the striatum (Gerfen & Surmeier 2011, [[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]]):

| Pathway | Receptor | Cascade | Net effect |
|---|---|---|---|
| **Direct SPN** | D1 → Gs | cAMP ↑ → PKA ↑ → Cav1 Ca²⁺ ↑, K⁺ ↓, AMPA/NMDA surface expression ↑ | Excitability ↑; corticostriatal LTP (requires D1 + NMDA co-activation) |
| **Indirect SPN** | D2 → Gi | cAMP ↓ → Cav1 ↓, K⁺ ↑; endocannabinoid (EC) production → retrograde CB1 → Glu release ↓ | Excitability ↓; LTD (requires D2 + postsynaptic depolarization) |

**A single phasic DA burst writes opposite plasticity rules to both populations simultaneously.** DA pause (aversive event) reverses both: direct SPNs shift to LTD bias, indirect SPNs become LTP-permissive. Parkinson's disease (DA depletion) confirms the opponent structure is architecturally required — both pathways reverse simultaneously; neither compensates for the other.

**Convergence requirement:** SPNs rest at −90 mV ("down-state") via Kir2 K⁺ channels and only reach spike threshold ("up-state") under spatially/temporally convergent glutamatergic input. D1 lowers this convergence threshold in direct SPNs; D2 raises it in indirect SPNs. DA sculpts *which population* detects convergence — not just how strongly. See [[wiki/entities/basal-ganglia.md]] for full circuit detail.

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

**Noradrenergic specificity in DG (Yassa & Stark 2011 [[wiki/papers/yassa-stark-pattern-separation-2011.md]]):** Locus coeruleus noradrenergic axons terminate in the DG polymorphic layer at *orders of magnitude* greater density than anywhere else in HC. This structural specialization suggests NA plays a DG-specific role — modulating the hilar mossy cells and HIPP interneurons that regulate DG's separation/completion bias — distinct from the global inverse-temperature (β) function identified by Doya 2002. NA's elevated presence specifically in the DG regulatory layer (polymorphic/hilar zone) is a structural argument that arousal/stress signals can shift the separation/completion balance independently of the global NA broadcast. See [[wiki/concepts/pattern-separation.md]] (Regulatory Control section) for the hilar circuit.

**Striatal ACh: temporal gating of pathway routing (Gerfen & Surmeier 2011 [[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]]):** In the striatum, cholinergic interneurons (~5% of neurons) receive dominant glutamatergic input from the *thalamus* (not cortex) and fire in burst-pause patterns following salient stimuli — a function architecturally distinct from the HC ACh storage/retrieval switch. Thalamic burst → ACh burst → M2 presynaptic receptors suppress corticostriatal Glu release probability (reduces drive to both SPN types). Pause → M1 postsynaptic on D2 SPNs closes Kir2 K⁺ → ~1-second window of enhanced indirect-pathway dendritic excitability; cortical input now preferentially activates the NoGo pathway. DA (via D2 on cholinergic interneurons) gates the pacemaker — baseline DA suppresses the burst-pause; phasic DA drops allow thalamic salience to redirect corticostriatal processing through the indirect pathway. Same neuromodulator (ACh), different circuit role: the HC switch gates memory encoding/retrieval; the striatal switch gates pathway routing on salient events. See [[wiki/entities/basal-ganglia.md]].

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

**Design implication for reasoning models:** SFA provides gain control that is maximally local and requires no dedicated modulatory pathway. A network can implement coarse gain control via neuromodulation (Blocks 2C/3B), fine time-constant adaptation via liquid τ, and finest-grained activity-history sensitivity via SFA — all three can co-exist in the same neuron population.

---

## Liquid τ: Input-Dependent Time-Constant Modulation

Neuromodulators shift neural time constants globally — ACh shortens HC integration windows by suppressing Schaffer collaterals; NA modulates LC pacemaker timing; DA affects striatal up-state dwell times. LTCs ([[wiki/entities/ltc-model.md]]) formalize an analogous mechanism at the local, continuous level: the effective time constant of each neuron becomes `τ_sys = τ / (1 + τ·f(x, I, t, θ))`, adapting per-neuron integration windows based on what is currently arriving — a *self-modulating* time constant that does not require a separate chemical signal.

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
5-HT (γ) high    →  inhibit NA (β ↓) + inhibit ACh (α ↓)
V(s) extreme     →  NA ↑  (β ↑: focus when value is very high or very low)
DA sign reversals frequent  →  ACh ↓  (α ↓: delta-bar-delta: stop learning when oscillating)
```

Predicted trajectory in a novel environment: high DA variance → 5-HT suppressed (short γ) → NA low (wide exploration) → ACh high (fast write). As learning stabilizes: DA variance drops → 5-HT rises → NA and ACh increase → focused, patient, slower-writing agent.

---

## Application to Reasoning Model

Doya's framework grounds three building blocks from [[wiki/queries/building-blocks-mec-hc-pfc.md]]:

| Block | Biology (Doya 2002) | ML implementation |
|---|---|---|
| **2C: Write gate** | ACh = α; novelty/surprise → high ACh → high write rate | `M ← M + σ(δ_pred) · p_t`; δ_pred ≈ DA signal (prediction error) |
| **3B: WM gate** | DA D1 stabilizes PFC working memory (β ↑); D2 destabilizes (β ↓) | Learned β scalar: freeze (D1 dominant) vs. update (D2 dominant) on prediction error |
| **3D: Goal generator** | DA TD error signals goal miss; ACC conflict → triggers re-planning | Prediction error gates Block 3A (transformation inference): large δ → invoke inferrer |

---

**PVLV (O'Reilly & Frank 2006):** A biologically grounded non-TD alternative for the BG DA signal — more robust than TD chaining when intermediate stimuli are unpredictable. Full account in [[wiki/concepts/meta-learning.md]] (PVLV section), where it belongs alongside PBWM as the DA algorithm underlying the BG slow outer loop. See also [[wiki/entities/basal-ganglia.md]].

---

## DA = Precision vs. DA = TD Error (Friston 2009 vs. Doya 2002)

> **Contradiction [2026-06-21]:** Friston (2009, [[wiki/papers/friston-free-energy-2009.md]]) argues dopamine encodes the **precision of prior predictions** (incentive salience / "the value of prediction error"), not the **prediction error on value** (TD error). Under this account: (a) action is only triggered when predictions are sufficiently precise; (b) Parkinson's bradykinesia = low DA = imprecise priors = small action-triggering prediction errors = poverty of movement — without requiring any reward computation; (c) all four neuromodulators encode precision in anatomically distinct hierarchies (ACh in exteroceptive/posterior, DA in interoceptive/motor/prior systems), not four distinct RL metaparameters. The Doya 2002 account ([[wiki/papers/metalearning-neuromodulation-doya-2002.md]]) maps DA to the TD error δ(t) = r(t) + γV(s(t)) − V(s(t−1)), requiring an explicit reward signal. Both accounts make similar predictions for standard Pavlovian conditioning (both predict DA burst to reward/cue, dip to omission). They diverge for instrumental/motor tasks without explicit reward: Friston predicts DA governs motor action initiation via prior precision; Doya predicts DA signals value prediction error across episodes. The Gerfen & Surmeier 2011 D1/D2 cellular mechanism is compatible with either account — it specifies *how* DA gates plasticity, not *what* it signals computationally.

**Partial reconciliation (Friston 2009):** Friston notes DA may encode the "value of prediction error" = incentive salience (Berridge 2007 [[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]] for mechanism). If incentive salience = precision of goal-predicting priors, then the precision account subsumes value-learning: goal pursuit = making precise predictions about desired states self-fulfilling via action. The DA dual role (Wang et al. 2018) — DA as plasticity signal (slow, shaping PFC weights) and as activity input (fast, informing PFC recurrent dynamics) — is compatible with the precision account if the activity channel carries precision estimates rather than raw TD error.

---

## Dual Role of Dopamine (Wang et al. 2018)

Doya 2002 establishes DA as a synaptic plasticity signal (TD error). Wang et al. 2018 ([[wiki/papers/pfc-meta-rl-wang-2018.md]]) identifies a second, distinct role:

| Role | Timescale | Mechanism | Function |
|---|---|---|---|
| **Plasticity signal** | Slow (training) | DA modulates cortico-striatal LTP/LTD | Shapes PFC recurrent weights → installs the fast within-episode RL algorithm |
| **Activity input** | Fast (within episode) | RPE injected as input to PFC LSTM hidden state | Carries reward information that the recurrent dynamics integrate over the episode |

These are experimentally dissociable: optogenetically blocking/inducing DA at test (frozen weights) shifts behavior via the activity channel alone — the fast algorithm depends on DA as a *signal*, not just as a plasticity trigger. This means the ACh = learning-rate interpretation (Doya) and the DA = activity-information interpretation (Wang et al.) are complementary, not competing.

---

## Neurochemical CC Specificity (Friedman & Robbins 2021)

Friedman & Robbins identify a finer-grained mapping between neuromodulators and CC components than Doya's global metaparameter account:

| Neuromodulator | CC component | Evidence |
|---|---|---|
| **DA D1 in dlPFC** | WM stability / interference resistance | Inverted-U: too little DA → signal lost; too much → noise amplification. Lesion: DA depletion in marmoset dlPFC impairs spatial delayed response *but improves* extra-dimensional shifting (opponent effects on WM vs. flexibility) |
| **5-HT in OFC** | Reversal learning (value-based flexibility) | OFC serotonin depletion in marmoset → impairs reversal learning, NOT extra-dimensional set-shifting; citalopram (SSRI) in humans enhances OFC reversal, no effect on stop-signal |
| **NA via RIFG → STN** | Response inhibition | Atomoxetine (NA reuptake inhibitor) enhances stop-signal performance, no effect on OFC reversal; hyperdirect RIFG→STN pathway is the anatomical substrate — RIFG modulates STN excitability to gate the global motor inhibition signal |
| **ACh (basal forebrain)** | Cognitive effort allocation (top-down) | PFC "top-down" control over cholinergic system: PFC → NBM circuitry suggests cholinergic arousal is itself gated by PFC, not just the reverse |

**Key implication for reasoning model:** DA and 5-HT mediate *different* CC components, not just different timescales of the same signal. The dissociation (DA impairs flexibility while improving WM; 5-HT specifically modulates OFC value-reversal not rule-shifting) means neuromodulation should be CC-component-specific in the model, not a global learning-rate dial.

The NA/RIFG/STN inhibitory circuit is a separate response-gating mechanism distinct from the DA D1 WM-stability mechanism — this maps to the distinction between Block 3D (goal generator, driven by goal/error signal) and Block 3B (WM, stabilized by DA D1 analog).

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

## Open Problems

- Serotonin's role is the least settled: Daw et al. (2002) propose 5-HT = average reward (not γ); discriminating experiment requires comparing 5-HT effects when V(s) is positive vs. negative — not yet done definitively.
- The ACh switch assumes a simple high/low binary; real cholinergic modulation uses multiple receptor subtypes with opposing effects at different synapses (muscarinic vs. nicotinic; pre- vs. postsynaptic).
- Online learning vs. offline consolidation both involve ACh at different timescales — how the continuous cholinergic signal coordinates with event-gated SWR plasticity is unresolved.

---

## Connections

- **[[wiki/concepts/two-learning-timescales.md]]** — ACh (learning rate α) is the neuromodulatory mechanism that switches HC between fast-M storage mode (high ACh) and slow-W retrieval mode (low ACh); grounds the timescale split in a specific diffuse chemical signal.
- **[[wiki/concepts/predictive-coding.md]]** — DA = TD error is the reinforcement learning realization of the prediction error principle; both PC's ε and δ signal "better-than-predicted," differing only in whether the model predicts sensory input (PC) or reward (RL).
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — ACh from basal forebrain directly gates HC between encoding (high ACh, suppress CA3→CA1) and retrieval (low ACh, enable CA3 pattern completion) modes.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — Doya's theory gives biological grounding for Block 2C (write gate = ACh/α), Block 3B (WM gate = DA D1/D2), and Block 3D (goal generator = DA TD error).
- **[[wiki/papers/metalearning-neuromodulation-doya-2002.md]]** — primary source; full derivation of each metaparameter hypothesis and their experimental evidence.
- **[[wiki/concepts/meta-learning.md]]** — meta-RL (Wang et al. 2018) reveals DA's dual role: the within-episode activity channel is the information feed for the PFC fast RL algorithm, extending beyond Doya's plasticity-only account.
- **[[wiki/papers/pfc-meta-rl-wang-2018.md]]** — source for DA dual role; optogenetic simulation 6 dissociates synaptic vs. activity channels.
- **[[wiki/papers/pbwm-oreilly-frank-2006.md]]** — PBWM model; per-stripe DA training of BG Go/NoGo weights; PVLV is the underlying DA learning algorithm (full account in [[wiki/concepts/meta-learning.md]]).
- **[[wiki/entities/basal-ganglia.md]]** — BG is the biological substrate for DA-mediated action selection; stripe-based BG-PFC gating implements the WM update mechanism; PVLV is the BG-specific DA learning algorithm.
- **[[wiki/concepts/cognitive-control.md]]** — neurochemical CC specificity (DA→WM, 5-HT→OFC reversal, NA→RIFG inhibition) maps onto three dissociable CC components; the inverted-U DA function constrains Block 3B design.
- **[[wiki/papers/pfc-cognitive-control-friedman-2021.md]]** — source for neurochemical CC specificity, inverted-U DA, OFC/5-HT dissociation, and NA/RIFG/STN response-inhibition circuit.
- **[[wiki/papers/pattern-completion-rolls-2013.md]]** — source for the structural complement to the ACh switch: mossy fiber dominance during encoding is architecturally wired independent of ACh; ACh suppression of CA3→CA3 RC amplifies this structural advantage.
- **[[wiki/papers/yassa-stark-pattern-separation-2011.md]]** — source for noradrenergic DG specialization: LC axons terminate preferentially in DG polymorphic layer at orders-of-magnitude greater density than elsewhere in HC, implicating NA in DG-specific separation/completion balance regulation via hilar cells.
- **[[wiki/concepts/pattern-separation.md]]** — the hilar regulatory circuit (mossy cells + HIPP interneurons) and noradrenergic DG specialization are documented in the Regulatory Control section; neuromodulation.md's ACh/NA entries are the chemical signals that drive that circuit.
- **[[wiki/concepts/associative-memory.md]]** — context-modular Hopfield framework provides the formal theory for how top-down contextual signals (plausibly carried by neuromodulatory or interneuron-mediated pathways) implement neuronal and synaptic gating to control which stored attractor states are accessible.
- **[[wiki/papers/podlaski-context-modular-memory-2025.md]]** — perisomatic interneurons (neuronal gating) and dendrite-targeting interneurons (synaptic gating) are the proposed biological mechanisms for the context-dependent inhibitory masks analyzed in the model.
- **[[wiki/entities/prefrontal-cortex.md]]** — DA D1 inverted-U (dlPFC WM stability), NA/RIFG→STN (response inhibition), and ACC unsigned PE are all PFC-subregion-specific neuromodulatory mechanisms; the entity page is the biological substrate for all three CC-component-specific neuromodulator mappings identified in the Friedman & Robbins analysis.
- **[[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]]** — source for D1/D2 cellular mechanisms (PKA→LTP vs. EC→CB1→LTD) that ground the DA=TD-error metaparameter in receptor biochemistry; also source for striatal cholinergic temporal gating — a context-sensitive pathway routing function (ACh burst-pause on salience) distinct from the HC ACh storage/retrieval switch.
- **[[wiki/entities/ltc-model.md]]** — the liquid time constant τ_sys is a local continuous-time formalization of neuromodulatory time-constant control: τ adapts per-neuron integration windows based on inputs, mechanistically equivalent to synaptic conductance modulation but implemented as an intrinsic recurrent gate.
- **[[wiki/papers/ltc-hasani-2021.md]]** — source for the liquid τ derivation from C. elegans cable equation; biological grounding in leakage conductance gl and synaptic current steady-state approximation.
- **[[wiki/papers/friston-free-energy-2009.md]]** — primary source for the DA=precision hypothesis (Contradiction entry); also grounds the claim that all four neuromodulators may encode precision in different hierarchical systems, with ACh handling exteroceptive and DA handling interoceptive/motor precision.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — SFA is the most local level of the gain-adaptation hierarchy: per-neuron spike-triggered threshold adaptation requires no external signal, complementing global neuromodulatory and per-neuron liquid-τ adaptation; all three scales can co-exist in one neural population.
- **[[wiki/papers/sfa-ganguly-2024.md]]** — source for SFA biological prevalence (20–40% neocortical excitatory neurons), adaptive threshold formalism, and intrinsic gain-control characterization.
- **[[wiki/concepts/phase-precession.md]]** — neuromodulatory gain G is the sufficient condition for phase precession in SpikingTEM; the G + theta_MECIII combination produces the biologically observed MECII/MECIII temporal coding dissociation, establishing neuromodulation as a coding-mode controller beyond its RL-metaparameter role.
- **[[wiki/papers/spiking-tem-kawahara-2025.md]]** — source for the G-controlled temporal coding mode result; ablation table quantifying the four jointly necessary mechanisms for grid cell formation.
