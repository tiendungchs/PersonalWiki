---
title: "Basal Ganglia"
type: entity
tags: [basal-ganglia, reinforcement-learning, dopamine, striatum, action-selection, direct-pathway, indirect-pathway, hyperdirect-pathway, synaptic-plasticity, D1-receptor, D2-receptor, cholinergic, BG (Basal Ganglia)-gating, TANs, automaticity, cognitive-motor-integration]
created: 2026-06-20
updated: 2026-06-20 (2)
sources: [Modulation of striatal projection systems by dopamine, Exploring the cognitive and motor functions of the basal ganglia an integrative review of computational cognitive neuroscience models, Basal_Ganglia_and_Cortex]
related: [wiki/concepts/neuromodulation.md, wiki/concepts/meta-learning.md, wiki/concepts/working-memory.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/cognitive-control.md, wiki/concepts/sequence-memory.md, wiki/entities/prefrontal-cortex.md, wiki/papers/pbwm-oreilly-frank-2006.md, wiki/papers/metalearning-neuromodulation-doya-2002.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md, wiki/papers/helie-ccn-bg-2013.md, wiki/papers/bogacz-gurney-bg-msprt-2007.md, wiki/papers/long-sequence-hopfield-chaudhry-2023.md, wiki/entities/covis-model.md, wiki/papers/frontal-cortex-abstract-rules-badre2010.md]
---

# Basal Ganglia

**Subcortical nuclei implementing dopamine-gated action selection via opponent modulation of direct (Go) and indirect (NoGo) striatal pathways — the biological substrate for corticostriatal credit assignment and working-memory gating.**

---

## Anatomy

| Nucleus | Principal input | Principal output | Computational role |
|---|---|---|---|
| **Striatum** (caudate + putamen + NAcc) | Cortex (Glu), thalamus (Glu), SNc/VTA (DA) | GPe, GPi, SNr | Input integration; ~90% GABAergic SPNs |
| **GPe** | Indirect SPNs | STN, GPi/SNr | Indirect relay; autonomous pacemaker |
| **STN** | GPe, cortex (hyperdirect Glu) | GPi / SNr (Glu) | Global "hold" signal; NA (Noradrenaline / Norepinephrine) from LC gates excitability |
| **GPi / SNr** | Direct SPNs (GABA ↓), STN (Subthalamic Nucleus) (Glu ↑) | Thalamus, SC, PPN | Output interface; tonic inhibition gated by pathways |
| **SNc / VTA** | Striatum (feedback), limbic | Striatum (DA) | Phasic Dopamine = reward prediction error (TD-like) |

---

## Direct / Indirect Pathway Opponent System

Spiny projection neurons (SPNs) constitute ~90% of striatum. Two populations defined by Dopamine receptor expression (D1 or D2; segregation confirmed by BA (Brodmann Area)C transgenic imaging, Gerfen & Surmeier 2011):

| Property | Direct pathway (D1 SPN) | Indirect pathway (D2 SPN) |
|---|---|---|
| **Projection** | GPi / SNr directly | GPe → STN (Subthalamic Nucleus) → GPi/SNr (multisynaptic) |
| **Output effect** | Inhibits GPi/SNr → releases thalamus (**Go**) | Disinhibits GPi/SNr → suppresses thalamus (**NoGo**) |
| **DA receptor cascade** | D1 → Gs → cAMP ↑ → PKA ↑ | D2 → Gi → cAMP ↓ |
| **Excitability with Dopamine burst** | ↑ (Cav1 ↑, K⁺ ↓) | ↓ (Cav1 ↓, K⁺ ↑) |
| **LTP rule** | D1 + NMDA co-activation | A2a adenosine (cAMP pathway) + NMDA |
| **LTD rule** | Macro-stimulation + D2-mediated Glu suppression | D2 → EC (Entorhinal Cortex) production → retrograde CB1 → Glu release ↓ |
| **Phasic Dopamine burst (reward)** | Excitability ↑ + corticostriatal LTP (Long-Term Potentiation) | Excitability ↓ + LTD (Long-Term Depression) |
| **Phasic Dopamine pause (aversive)** | LTD (Long-Term Depression) bias, excitability ↓ | LTP (Long-Term Potentiation) permissive, excitability ↑ |
| **Structural dendrite count** | More primary dendrites (~50% more Glu input) | Fewer primary dendrites, higher intrinsic excitability |

**Key design principle:** A single phasic Dopamine event writes opposite plasticity rules to both populations simultaneously — credit assignment is an *opponent* write operation, not a scalar reward broadcast. Parkinson's disease (DA depletion) confirms this: both pathways reverse plasticity bias simultaneously, locking in action suppression (Kravitz et al. 2010 optogenetics).

---

## Three-Pathway Algorithmic Dissociation

The direct/indirect account is incomplete. A third, faster pathway implements a qualitatively distinct computation:

| Pathway | Route | Computation | Speed | Coverage in CCN models |
|---|---|---|---|---|
| **Direct** | Striatum (D1) → GPi/SNr → Thalamus | **Go** — selectively disinhibit one action channel | Slow (monosynaptic str→GPi) | All models |
| **Indirect** | Striatum (D2) → GPe → STN (Subthalamic Nucleus) → GPi/SNr | **NoGo** — channel-specific suppression of competing actions | Slow (multisynaptic) | ~5 of 19 reviewed CCN models |
| **Hyperdirect** | Cortex → STN (Subthalamic Nucleus) → GPi/SNr | **Hold** — non-specific elevation of GPi inhibition before pathway competition settles; enables deliberate pause | Fast (monosynaptic cortex→STN) | ~3 of 19 reviewed CCN models |

Go + NoGo = selection system: activate target, suppress competitors. Hold + Go + NoGo = *decision architecture*: gate closed until evidence or goal is resolved, then select. PFC (Prefrontal Cortex) can fire hyperdirect before any striatal competition begins — the mechanism of goal-directed override of habitual response (Chersi et al. 2013). Helie et al. 2013 find no reviewed model includes all three simultaneously.

**For a reasoning agent:** Go selects the committed action; NoGo suppresses competing habitual responses; Hold implements deliberate pause while awaiting goal resolution or additional evidence. Models using only the direct pathway cannot reproduce response inhibition, impulsivity control, or action withholding — all necessary for an agent that must plan before acting.

---

## MSPRT: Optimal Decision Making in the Proficient Phase

The Go/NoGo/Hold account describes *which pathways* are active. Bogacz & Gurney 2007 provide the algorithmic level: the cortex–BG circuit implements the **Multihypothesis Sequential Probability Ratio Test (MSPRT)** — the asymptotically optimal Bayesian test for selecting among N competing actions when evidence is noisy and accumulates over time.

**Circuit decomposition (proficient phase):**

| Term | Formula | Neural substrate |
|---|---|---|
| **Salience** | −yi(T) (accumulated cortical evidence for action i) | Direct pathway: D1 striatum → GPi/SNr |
| **Competition** | S(T) = ln(Σ_j exp(yj(T))) | STN (Subthalamic Nucleus) (exp transfer) + GP (log-compression via STN→GP feedback) → GPi/SNr |
| **BG output** | OUT_i(T) = −yi(T) + S(T) = −ln P(H_i \| evidence) | GPi/SNr tonic inhibition |

Selection fires when any OUT_i drops below threshold — disinhibiting that action's thalamic target. Equivalent to selecting the action with maximum Bayesian posterior probability. This is log-posterior selection, not winner-take-all.

**Biologically validated transfer functions (quantitative predictions, confirmed post-derivation):**

| Nucleus | Required by MSPRT | Biological validation |
|---|---|---|
| **STN** | Firing rate ∝ exp(input) — nonzero spontaneous activity + capacity for very high rates | Confirmed: Hallworth et al. 2003; Wilson et al. 2004 (current-injection I/O fits) |
| **GP** | Log-compression of STN (Subthalamic Nucleus) activity | Confirmed: Nambu & Llinas 1994 — GP neurons fire ≈ linearly in STN (Subthalamic Nucleus) input; ln(linear · N) ≈ log for large N |

**Hick's Law from first principles:** S(T) = ln(Σ exp(yj)) grows with N, raising the minimum salience required for any action to cross threshold → decision time ∝ log(N). This is Hick's Law, derived analytically and validated in simulation against the race model and UM model (mutual inhibition).

**Proficient vs. learning phase:** The same D2 striatum → GPe → STN (Subthalamic Nucleus) pathway serves MSPRT normalization during *execution* (computing S(T)) and punishment blocking during *learning* (Frank et al. 2004). Both modes coexist in the same anatomy, determined by Dopamine state and context. PVLV/RL (credit assignment during acquisition) and MSPRT (Bayesian selection during execution) are the complete dual-phase BG (Basal Ganglia) account.

**For a reasoning agent:** Block 3D's action selection module should implement log-softmax competition (the S(T) term), not argmax(salience). The Hold function (hyperdirect) and the Bayesian stopping criterion are the same computation at different levels of description — deliberate pause continues until S(T) rises high enough relative to the top action's salience that the posterior is decisive.

---

## Convergence Gating: Up-state Bistability

SPNs rest at −90 mV ("down-state") held by constitutively open Kir2 K⁺ channels. Transition to "up-state" (near spike threshold, lasting hundreds of milliseconds) requires spatially or temporally **convergent** glutamatergic inputs sufficient to overwhelm Kir2.

- D1 receptor activation lowers the convergence threshold in direct SPNs (Cav1 ↑, Kv4 inactivation facilitated, dendritic impedance ↑).
- D2 receptor activation raises the convergence threshold in indirect SPNs (Cav1 ↓, K⁺ ↑, NMDA Ca²⁺ ↓).
- Structural asymmetry: indirect SPNs have fewer dendrites (less Glu input) but higher intrinsic somatic excitability — a hair-trigger NoGo pathway held back by tonic D2 suppression from baseline DA. Releasing this brake (DA pause) activates action suppression rapidly.

This means action selection is implemented as **hardware-level coincidence detection** — SPNs respond only to convergent cortical ensembles, not diffuse activation, and Dopamine sculpts which population detects that convergence.

---

## Cholinergic Temporal Gating

Cholinergic interneurons (~5% of striatal neurons) receive dominant glutamatergic input from **thalamus** (not cortex) and fire in burst-pause patterns following salient stimuli:

1. **Burst** → ACh release → M2 presynaptic receptors suppress corticostriatal Glu release probability (reduces drive to both SPN (Spiny Projection Neuron) types)
2. **Pause** → ACh cessation → M1 postsynaptic on D2 SPNs → Kir2 K⁺ closure → ~1-second window of enhanced indirect-pathway dendritic excitability; cortical input now preferentially activates NoGo pathway

DA modulates this gate: D2 receptors on cholinergic interneurons suppress basal pacemaking → baseline Dopamine keeps the gate quiet; phasic Dopamine drops allow thalamic salience signals to redirect corticostriatal processing through the indirect pathway. This is ACh acting as **context-sensitive pathway routing** in the striatum — architecturally distinct from the HC ACh storage/retrieval switch (different circuit; same neuromodulator).

**Tonically Active Neurons (TAN) learning role — catastrophic interference prevention (Ashby & Crossley 2011):** TANs also *learn* to pause in rewarding contexts, gating whether corticostriatal learning occurs at all:

| Phase | TAN state | MSN state | Learning outcome |
|---|---|---|---|
| **Acquisition** | Pause (context = rewarding) | Released from inhibition | Dopamine RL updates stimulus-response weights |
| **Extinction** | No pause (context no longer rewarding) | Inhibited | Learned weights *protected* — not overwritten |
| **Fast reacquisition** | Re-learns to pause | Re-released | Intact learned weights re-emerge immediately |

This is a **second-order gate**: the BG (Basal Ganglia) RL gate (dopamine-gated MSN plasticity) is itself gated by TAN context learning. The TAN pause does not select which action is reinforced; it controls whether any learning occurs in this context. Architecturally equivalent to the interference protection the CLS (Complementary Learning Systems) two-timescale split achieves at the cortical level — protecting learned associations from destruction during temporary non-reward periods.

---

## Multi-Loop Corticostriatal Topography

Corticostriatal projections follow a rostro-caudal topography creating functionally parallel loops. All loops use the same Go/NoGo/Hold architecture with loop-specific dopamine inputs:

| Loop | Cortical input | Striatal target | Dopamine source | Function |
|---|---|---|---|---|
| **Limbic / value** | OFC, vmPFC, ACC (Anterior Cingulate Cortex) | Ventral striatum / NAcc | VTA | Reward valuation; effort-cost tradeoff |
| **Cognitive** | DLPFC (areas 9, 46), lateral PFC (Prefrontal Cortex) (area 8) | Dorsal caudate | VTA | WM gating, rule learning, categorization |
| **Motor** | Premotor (area 6), SMA, M1 | Caudal putamen | SNc | Action execution, motor timing, sequence production |

Loops interact at striatal input (partial overlap) and at GPi/SNr output (convergence), but are otherwise anatomically parallel. Sequence learning transfers from cognitive loop (fast, WM-dependent, anterior caudate) to motor loop (slower, automatic, posterior putamen) over training (Nakahara et al.; Miyachi lesion data: muscimol in anterior caudate disrupts early learning; in posterior putamen disrupts automated performance). The motor loop implements not just *which* action but *timing and kinematics* — Subthalamic Nucleus (STN)-Globus Pallidus externus (GPe) oscillatory dynamics regulate movement amplitude and velocity; dopamine depletion (PD) destabilizes these oscillations, producing bradykinesia and micrographia (Gangadhar et al. 2008).

**For agent architectures:** A reasoning agent controlling a body needs parallel cognitive and motor BG (Basal Ganglia) loops. The cognitive loop selects *what to do* (task sub-goal, rule application); the motor loop selects *how to do it* (motor primitive, timing). Helie et al. 2013 identify that no reviewed CCN model integrates both simultaneously — this is an open architectural gap directly relevant to embodied reasoning agents.

---

## Effective Connectivity in Fronto-Striatal Rule Learning (Badre et al. 2010)

Granger causality (GC) analysis of BOLD time series during abstract rule learning establishes the directed architecture of the fronto-striatal RL loop across abstraction levels:

| Connection | GC value (left / right) | Significance |
|---|---|---|
| Putamen → PMd | 0.016 / 0.026 | p<0.05 |
| Putamen → prePMd | 0.003 / 0.007 | p<0.05 |
| PMd → Caudate | 0.012 / 0.022 | p<0.0005 |
| prePMd → Caudate | 0.013 / 0.013 | p<0.0005 |

Directed chain: **anterior putamen → frontal cortex (PMd/prePMd) → caudate**. This chain is consistent across Hierarchical and Flat rule sets (no between-condition GC differences, ps>0.18) — the RL circuit architecture is abstraction-level invariant; only the content of the cortical rule representations changes between conditions.

**Computational interpretation:**
- *Putamen → cortex*: putamen delivers the RL gating signal (reward prediction error or salience) that opens the update window for frontal cortical rule representations; corresponds to the "putamen provides context for cortical rule learning" hypothesis (Houk & Wise 1995).
- *Cortex → caudate*: frontal rule representations drive caudate learning — cortex provides the structured representation of what was learned, which caudate integrates for value and future action selection; corresponds to the "cortex consolidates into BG" hypothesis (Graybiel 1998).
- The directed chain reconciles both accounts: the putamen instructs cortex (bottom-up RL gate) and cortex instructs caudate (top-down consolidation). Neither is purely prior; they are separate roles in a single directed chain.

**Late striatal activation for abstract rules:** Caudate and putamen showed greater stimulus-related activation by the End of learning for the Hierarchical vs. Flat set (F(1,19)=6.9, p<0.05), without a time × condition interaction. Once a 2nd-order rule is acquired, the more valuable abstract rule (compressing 9 individual rules) is represented more strongly by striatum, consistent with value-weighted consolidation.

**Design implication:** The BG loop is not a symmetric bidirectional loop. For Block 3D: (a) the putamen module provides per-level reward gates to Block 3C rule representations; (b) the caudate module receives signals from those rule representations and learns value over them. These are distinct functional roles requiring distinct architectural connections — not a generic RL signal broadcast to all modules equally.

---

## Mapping to Model Components

| Building block | Biology | Design implication |
|---|---|---|
| **Block 3B: WM gate** | BG (Basal Ganglia)-PFC stripe gating (~20K parallel stripes via PBWM) | Per-stripe Go/NoGo independently opens or holds each PFC (Prefrontal Cortex) WM slot |
| **Block 3D: Credit assignment** | Opponent D1-LTP/D2-LTD from single phasic Dopamine event | Credit assignment must be bidirectional and pathway-segregated; a scalar reward signal is insufficient |
| **Block 3B: WM stability** | D1 in PFC (Prefrontal Cortex) stabilizes WM; D2 enables flexible updating | Inverted-U Dopamine function constrains the WM-update gate — too much Dopamine locks slots, too little loses signal |
| **Block 3C: Action selection** | Up-state bistability as convergence detector | Model needs explicit convergence detection, not max-activation rule, to replicate BG (Basal Ganglia) selectivity |
| **Block 3D: Response inhibition** | Hyperdirect STN→GPi as fast pre-selection Hold signal; PFC (Prefrontal Cortex) drives STN (Subthalamic Nucleus) before striatal competition settles | Model needs a deliberate pause mechanism enabling goal-directed override of habitual selection — not just an action selector |
| **Automaticity (SPEED)** | BG (Basal Ganglia) direct pathway trains cortico-cortical weights via dopamine RL until they run without BG (Basal Ganglia) (Ashby et al. 2007) | BG (Basal Ganglia) is a temporary training scaffold for permanent cortical skills; frequently-used action patterns should be compiled into direct cortical weights; agent architecture should allow BG (Basal Ganglia) to progressively hand off execution |
| **Cognitive-motor integration** | Parallel cognitive (dorsal caudate) and motor (caudal putamen) loops; no CCN model integrates both | Agent with both task selection and motor execution needs two BG (Basal Ganglia) loops — conflating them into one BG (Basal Ganglia) module loses the anatomical specialization and prevents the cognitive→motor transfer that implements automaticity |
| **Sequence executor gating (CBGT)** | DenseNet bipartite: motor cortex (visible $v$) + thalamic motor motifs (hidden $h_\mu$, each encoding sequence element $\xi^\mu$) + BG (Basal Ganglia) context gate (inhibit/disinhibit $h_\mu$) | BG (Basal Ganglia) in this mode is not selecting among competing actions (Go/NoGo) but selecting which sequence-memory program drives the thalamus — each $h_\mu$ inhibited by BG (Basal Ganglia) corresponds to suppressing transition to $\xi^{\mu+1}$; see [[wiki/concepts/sequence-memory.md]] |
| **Block 3D: Selection objective** | MSPRT in proficient phase: OUT_i = −ln P(H_i\|evidence); log-softmax normalization via STN (Subthalamic Nucleus) exp + GP log | Selection head must implement S(T) = ln(Σ exp(salience_j)) normalization, not argmax; STN (Subthalamic Nucleus) exp + GP log are the circuit-level softmax denominator — pure threshold selection is suboptimal for noisy distributed evidence |

---

## Open Problems

- Distal SPN (Spiny Projection Neuron) dendritic integration is virtually unknown; D1/D2 receptors are densest there but all direct recordings are somatic/proximal — the full plasticity landscape is missing.
- Whether direct and indirect SPNs receive identical vs. segregated cortical input is unresolved; non-identical input would mean the Go/NoGo system is not a pure selection mechanism on the same cortical context.
- Timing of direct/indirect pathway activity relative to each other (not just average level) appears critical for movement initiation in PD — timing as a computational dimension is absent from the current excitability/plasticity model.
- No reviewed CCN model integrates cognitive and motor BG (Basal Ganglia) loops simultaneously; for an embodied reasoning agent this is not an optional extension — cognitive-motor integration is structurally required to convert task-level goals into timed motor primitives, and the two loops must be jointly optimized.
- TAN catastrophic interference prevention has been studied only in the direct pathway and simple instrumental conditioning tasks; how TANs interact with indirect/hyperdirect pathways and more complex multi-step tasks is unknown.

---

## Connections

- **[[wiki/concepts/neuromodulation.md]]** — D1/D2 cellular cascades (PKA vs. Gi, EC-CB1 for LTD, AMPA/NMDA surface trafficking for LTP) ground the abstract "DA = TD (Temporal Difference) error" metaparameter in specific receptor biochemistry; cholinergic temporal gating is the striatal ACh function (context-sensitive pathway routing) complementing HC's ACh storage/retrieval switch.
- **[[wiki/concepts/meta-learning.md]]** — BG (Basal Ganglia)-PFC stripe circuit is the biological meta-RL slow outer loop; opponent LTP/LTD is the synaptic plasticity mechanism underlying "DA trains PFC (Prefrontal Cortex) weights"; PVLV is the biological Dopamine learning algorithm requiring this opponent substrate.
- **[[wiki/entities/prefrontal-cortex.md]]** — cortico-striatal-thalamic loop: BG (Basal Ganglia) gating (per-stripe PVLV DA) determines which PFC (Prefrontal Cortex) WM slots update vs. hold; D1 in dlPFC provides the within-episode WM stability that BG (Basal Ganglia) gating enables.
- **[[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]]** — primary source for all cellular mechanisms: D1/D2 receptor cascades, up-state bistability, structural SPN (Spiny Projection Neuron) asymmetry, cholinergic temporal gating, PD plasticity reversal.
- **[[wiki/papers/pbwm-oreilly-frank-2006.md]]** — PBWM model: stripe-based selective WM, PVLV Dopamine algorithm, dynamic variable binding; builds the computational layer above this paper's cellular account.
- **[[wiki/papers/metalearning-neuromodulation-doya-2002.md]]** — actor-critic RL grounding; Dopamine = TD (Temporal Difference) error at the behavioral level; striatum as critic; this page now grounds that abstraction in the D1/D2 receptor level.
- **[[wiki/papers/pfc-meta-rl-wang-2018.md]]** — meta-RL: BG (Basal Ganglia) as the slow-loop RL trainer for PFC (Prefrontal Cortex) LSTM; Dopamine dual role (plasticity signal + activity input to PFC (Prefrontal Cortex) hidden state).
- **[[wiki/papers/helie-ccn-bg-2013.md]]** — integrative CCN review: three-pathway algorithmic dissociation (Go/NoGo/Hold); TAN catastrophic interference gate; BG (Basal Ganglia)-WM three-architecture debate; COVIS dual-system categorization; SPEED automaticity model; cognitive-motor integration gap.
- **[[wiki/entities/covis-model.md]]** — COVIS dual-system model: procedural BG (Basal Ganglia) RL (direct pathway slow outer loop) implements Go/NoGo training via DA; hypothesis-testing WM (fast inner loop) manages rule switching; Dopamine depletion selectively impairs the procedural system, confirming the two BG (Basal Ganglia) loops are independently modifiable; entity page holds full architecture and dissociation evidence.
- **[[wiki/concepts/working-memory.md]]** — BG (Basal Ganglia)-WM three-architecture debate (thalamo-cortical vs. cortico-cortical gate vs. BG (Basal Ganglia)-in-loop) directly concerns which of the three BG (Basal Ganglia) WM models is correct; this page provides the BG (Basal Ganglia)-side anatomy; working-memory.md provides the WM-side debate; MSPRT specifies the gating criterion independently of which architecture is correct.
- **[[wiki/concepts/two-learning-timescales.md]]** — SPEED automaticity is a third slow-W writing mechanism (within-lifetime, task-specific cortical compilation via BG (Basal Ganglia) bootstrap), complementing the HC-cortex consolidation route and the meta-RL DA-driven weight update.
- **[[wiki/concepts/cognitive-control.md]]** — MSPRT (proficient phase) and response inhibition (hyperdirect Hold) are the two distinct BG (Basal Ganglia) contributions to cognitive control: Hold pauses selection while evidence accumulates, MSPRT determines the Bayesian stopping criterion; the three CC (Cognitive Control) components (inhibition/updating/shifting) map onto Go/NoGo/Hold + MSPRT.
- **[[wiki/papers/bogacz-gurney-bg-msprt-2007.md]]** — primary source for MSPRT as the algorithmic level of BG (Basal Ganglia) action selection; STN (Subthalamic Nucleus) exponential + GP log transfer functions validated in physiology; Hick's Law derivation; proficient-vs.-learning-phase dissociation that pairs with PVLV (this page) as a complete two-mode BG (Basal Ganglia) account.
- **[[wiki/concepts/sequence-memory.md]]** — DenseNet's bipartite implementation maps onto the CBGT loop, adding a second mode to BG (Basal Ganglia)'s computational repertoire: beyond Go/NoGo action selection, BG (Basal Ganglia) gates thalamic motor-motif hidden units to control which sequence-memory program drives motor cortex — a context-dependent sequence executor distinct from competitive action selection.
- **[[wiki/papers/long-sequence-hopfield-chaudhry-2023.md]]** — source for the CBGT bipartite implementation: visible neurons (motor cortex) + hidden neurons (thalamic motor motifs) + BG (Basal Ganglia) context gate; thalamo-cortical loops for song generation in zebra finches cited as biological confirmation.
- **[[wiki/papers/frontal-cortex-abstract-rules-badre2010.md]]** — source for the directed putamen→cortex→caudate Granger causality chain: putamen provides the RL gate signal to frontal cortical rule representations (PMd/prePMd), which in turn drive caudate learning; chain is consistent across abstraction levels; late striatal activation for hierarchical rule learning reflects value consolidation of the discovered abstract rule.
