---
title: "Cognitive Control"
type: concept
tags: [cognitive-control, executive-function, PFC, goal-maintenance, inhibition, working-memory, set-shifting, hierarchy]
created: 2026-06-19
updated: 2026-06-28
sources: [The role of prefrontal cortex in cognitive control and executive function, "The prefrontal cortex- categories, concepts and cognition", pfc-wood-grafman-2003.md, A Path Towards Autonomous Machine Intelligence, "Deep brain stimulation of the internal capsule enhances human cognitive control and prefrontal cortex function.md", frontal-cortex-abstract-rules-badre2010.md, "Neuronal activity in the primate dorsomedial prefrontal cortex contributes to strategic selection of response tactics.md", "Neuronal Representations of Tactic-Based Sensorimotor Transformations in the Primate Medial Prefrontal, Presupplementary, and Supplementary Motor Areas A Comparative Study.md"]
related: [wiki/concepts/meta-learning.md, wiki/concepts/working-memory.md, wiki/concepts/two-learning-timescales.md, wiki/papers/pfc-categories-concepts-miller-2002.md, wiki/concepts/neuromodulation.md, wiki/concepts/predictive-coding.md, wiki/concepts/attention.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/papers/pfc-cognitive-control-friedman-2021.md, wiki/papers/pfc-wood-grafman-2003.md, wiki/entities/prefrontal-cortex.md, wiki/entities/basal-ganglia.md, wiki/concepts/analogical-reasoning.md, wiki/papers/analogy-holyoak-2012.md, wiki/papers/bogacz-gurney-bg-msprt-2007.md, wiki/entities/gwt-model.md, wiki/papers/gnw-mashour-2020.md, wiki/papers/raccah-pfc-consciousness-2021.md, wiki/entities/jepa-model.md, wiki/concepts/world-models.md, wiki/entities/c2c-model.md, wiki/papers/yoo-2022-c2c.md, wiki/papers/frontal-cortex-abstract-rules-badre2010.md, wiki/papers/matsuzaka-pmpfc-tactics-2012.md, wiki/papers/neuronal-tactic-sensorimotor-awan-2020.md, wiki/concepts/network-integration-segregation.md]
---

# Cognitive Control

**Cognitive control (CC) is the capacity to flexibly guide behavior toward goals by maintaining active goal representations in PFC (Prefrontal Cortex) that bias downstream processing toward contextually correct but non-prepotent responses.**

Miller & Cohen (2001) formulation: goal representations in PFC (Prefrontal Cortex) send top-down bias signals to sensorimotor regions, enabling weak task-correct mappings to out-compete stronger habitual ones via lateral inhibition.

---

## Three Dissociable Components (Miyake et al. 2000)

| Component | Definition | PFC (Prefrontal Cortex) subregion | Neuromodulator |
|---|---|---|---|
| **Inhibition / response inhibition** | Suppressing a dominant prepotent response | RIFG (BA-44/45); hyperdirect STN (Subthalamic Nucleus) pathway | NA (Noradrenaline / Norepinephrine) (atomoxetine enhances stop-signal) |
| **WM Updating** | Continuously monitoring and replacing WM content with task-relevant items | Mid-dorsal PFC (Prefrontal Cortex) (BA-9/46); parietal for manipulation | Dopamine D1 (inverted-U for dlPFC WM stability) |
| **Mental Set-Shifting** | Switching between established task-set mappings | vlPFC (BA-12/47) for extra-dim shift; OFC (Orbitofrontal Cortex) (BA-11) for reversal | 5-HT (OFC reversal learning specifically) |

Latent factor correlations: r = 0.42–0.63 (unity); separable (diversity). Inhibition = Common CC (Cognitive Control) factor — the variance that is shared across all three is isomorphic with response inhibition.

**Key result (bifactor model):** Inhibition-specific variance = 0; there is no response-inhibition-specific factor beyond what is common to all CC. Set-shifting and WM updating have residual specific variance. This implies: individual differences in CC (Cognitive Control) *are* individual differences in goal maintenance.

---

## Hierarchical Lateral PFC (Prefrontal Cortex) — Template for Block 3C

A well-confirmed rostro-caudal gradient (TMS-causal, fMRI, lesion):

| PFC (Prefrontal Cortex) region | Level | Content |
|---|---|---|
| Caudal PFC (Prefrontal Cortex) (BA-8) | Stimulus-response | Conditional mapping: this cue → this action |
| Mid-lateral PFC (Prefrontal Cortex) (BA-9/46) | Contextual rule | Maintain task context; monitor (n-back, tagging); resist interference |
| Frontopolar PFC (Prefrontal Cortex) (BA-10) | **Simultaneous multi-relational integration** | Constraint-satisfaction over ≥2 relational structures held simultaneously in WM; selectively activated by *relational count*, not nesting depth alone (Christoff 2001; Cho 2010); also handles branching rule-of-rules and sequential subgoals |

Hub / apex is mid-lateral, not rostral PFC (Prefrontal Cortex) (TMS: mid-lateral integrates the caudal sensory and rostral memorial signals).

---

## Parallel Multi-Level Policy Search (Badre et al. 2010)

A direct empirical test of *how* the frontal hierarchy facilitates **learning** (not just execution) of abstract rules via reinforcement, providing the key architectural prescription for Block 3C.

**Task:** Two RL rule sets with identical stimulus parameters. *Flat*: 18 arbitrary 1st-order rules (stimulus → response). *Hierarchical*: same 18 rules but with an embedded 2nd-order structure (color → relevant dimension → response). Participants never told about the higher-order structure; they had to discover it from feedback alone.

**Policy abstraction levels:**

| Level | Mapping | Region | Coordinates |
|---|---|---|---|
| 1st-order | Specific stimulus → specific response | PMd (~BA6 dorsal premotor) | ±30–42, −2–10, 56–68 |
| 2nd-order | Context → which 1st-order rule set applies | prePMd (~BA6/44 pre-premotor) | ±46–54, 4–14, 30–34 |
| 3rd-order | Higher context → which 2nd-order rule set | mid-DLPFC (~BA9/46) | ±48–50, 26–34, 24–40 |
| 4th-order | Branching rule-of-rules | FPC/RPC (~BA10) | ±34–40, 50–60, 6–14 |

A 2nd-order rule *compresses* a set of 1st-order rules: once the 2nd-order rule "color → dimension" is known, 9 individual stimulus-response mappings become immediately deducible — the step-wise jump in accuracy is the behavioral fingerprint of this compression.

**Simultaneous not sequential search (main finding):**

Both PMd and prePMd were active above baseline from trial 1 of learning — before any 2nd-order rule could have been discovered. prePMd Beginning-phase activation, collapsed across Flat/Hierarchical conditions, correlated with *subsequent* 2nd-order rule discovery: learning trial difference (R=0.51, p<0.05), terminal accuracy (R=0.56, p<0.05), max learning rate (R=0.51, p<0.05). Early PMd activation showed no such correlation (Rs<0.3, ps>0.21). The proactive higher-level search — independent of whether a higher-order rule exists — is the neural substrate of rule discovery.

**Reward-gated depth pruning:** prePMd activity declined to baseline for the Flat set by the Middle phase of learning (F(1,19)=4.2, p<0.05) and remained suppressed. For the Hierarchical set, prePMd stayed active throughout. The mechanism is per-level reward gating: each level's search continues until it fails to produce reward-validated structure, then is suppressed. This is competitive reward gating, not sequential handoff.

**Step-wise learning curves as rule-discovery marker:**

| Metric | Hierarchical | Flat | p |
|---|---|---|---|
| Terminal accuracy | 84% | 58% | <0.0001 |
| Rules learned | 72% | 43% | <0.005 |
| Sigmoid slope α | Large (steep step) | Small (gradual) | <0.01 |
| Sigmoid offset β | Small (early step) | Large (late ramp) | <0.005 |

A step-wise learning curve (large α, small β) means the system is generalizing — once an abstract rule clicks, all instances under it are immediately available. A gradual curve means independent rote learning of each rule separately. The signature is architecturally diagnostic: a system that produces step-wise learning curves must have a hierarchical representation that can compress a class of rules under a single abstraction.

**Design implications for Block 3C:**

| Principle | Mechanism | Implementation |
|---|---|---|
| **Parallel search** | All W levels simultaneously search from the first trial of any new task | W_instance, W_context, W_meta must all have active search dynamics from observation 1 — no sequential handoff |
| **Per-level reward gating** | Each level has an independent credit signal; unproductive levels prune their output without stopping other levels | BG (Basal Ganglia) sends per-level reward validation; failing levels decay their output weight without killing the others |
| **Discovery cascade** | When a k-th order rule is confirmed, all (k−1)-th order rules it subsumes become immediately constrained | A discovered 2nd-order rule should initialize/constrain the parameter space of all 1st-order rules under it — generalization is batch, not incremental |
| **Fronto-striatal directed chain** | putamen → cortex (RL gate); cortex → caudate (value learning); chain is abstraction-level invariant | Per-level Block 3C modules need individual RL validation from the BG loop via a directed putamen→cortex→caudate circuit |

---

## PFC (Prefrontal Cortex) as Representational System — SEC (Structured Event Complex) Framework

Wood & Grafman (2003) resolve the representation/process debate: PFC (Prefrontal Cortex) stores long-term memory representations; WM = those representations currently activated; processes = representations that remain active. Implication for design: Block 3C should store **structured representations** (grammars, rule sequences), not just weight matrices over transformations.

The **Structured Event Complex (SEC)** is the proposed representational unit:

> An SEC (Structured Event Complex) is a goal-oriented, temporally ordered event sequence encoding abstractions, rules, grammars, social schemas, and event boundaries. Activating an SEC (Structured Event Complex) generates predictions about subsequent events.

| SEC (Structured Event Complex) property | Block 3C implication |
|---|---|
| Sequential temporal structure | W_rule-of-rules encodes a grammar over event sequences, not just a single transformation label |
| Grammar encoding | Abstract compositional structure stored at the highest level; lower levels sample episodes from it |
| Goal-orientation | Terminal event = goal state → natural grounding for Block 3D goal generator |
| Predictive function | SEC (Structured Event Complex) = generative model of event futures; consistent with PC/FEP framing |

**vmPFC/dlPFC categorical specificity (via connectivity):** vmPFC (amygdala + HC connectivity) = social/emotional SECs; dlPFC (BG + premotor connectivity) = mechanistic/action SECs. This categorical split maps onto the content of W levels: W_instance (dlPFC) stores action-sequence mappings; vmPFC contributes goal value (Block 3D).

**Convergence with Friedman & Robbins 2021:** The SEC (Structured Event Complex) anterior-posterior gradient (frontopolar = long multi-event SECs; posterior = short/single-event) and the rule-nesting gradient (BA-10 = rules-of-rules; BA (Brodmann Area)-8 = S-R) are two descriptions of the same rostro-caudal axis — event-sequence *duration* and rule *depth* increase together. Both justify the three-level W stack.

---

## Goal Maintenance as the Unified CC (Cognitive Control) Mechanism

The PFC (Prefrontal Cortex) maintains goal representations `g*` that modulate downstream processing:
```
P(response | state, goal) ∝ P(response | state) × exp(β · b(g*, response))
```
Where `b(g*, response)` is the goal-congruence bias. Higher goal activation → stronger suppression of competing (habitual) responses via lateral inhibition in posterior cortex. CC (Cognitive Control) fails = goal deactivates early → prepotent response wins.

This "active bias" account subsumes response inhibition (goal causes inhibition of prepotent act), WM updating (goal signals that current content is no longer task-relevant → triggers replacement), and set-shifting (goal signals to switch — activates new task-set W).

---

## Sustained Activity as a Distinct Representational Format (Miller, Freedman & Wallis 2002)

A core computational argument of the Miller & Cohen model: cognitive control requires holding task knowledge in **sustained neural activity**, not in **synaptic weights** — these are two representational formats with opposite affordances.

| Property | Synaptic-weight code | Sustained-activity code |
|---|---|---|
| Persistence | Long-term (structural change) | Seconds (until overwritten) |
| Flexibility | Inflexible — fires the same way when triggered | Instantly reconfigurable — "changing behaviour is as easy as changing the pattern" |
| Reach | **Local** — only affects neurons sharing the synapse | **Global** — can be broadcast to bias many brain systems at once |
| Role | Slow storage of learned mappings | Orchestrating diverse processors around a current goal |

**Why control needs the activity format:** cognitive control must impose one pattern of task demands on *many* distinct circuits simultaneously. A synaptic-weight code can only express itself when its own circuit fires; a sustained-activity code can be read out and propagated everywhere. This is the mechanistic reason goal maintenance is implemented as persistent PFC firing rather than fast synaptic learning.

**Capacity limit falls out for free:** because control-relevant information is a *population code* distributed across simultaneously-active neurons, holding more than a few items causes the overlapping patterns to overwrite and interfere. The severe capacity limit of controlled (vs. automatic) processing is a direct consequence of using sustained activity as the carrier — not a separate bottleneck.

**Task model = "map of the neural pathways":** reward-related signals (VTA dopamine, via basal ganglia) strengthen associative links among the PFC neurons that were active just before reward, bootstrapping from direct reward-associations to a multivariate network describing the task. Once built, a subset of cues re-evokes the full model including the correct response; excitatory bias then selects the needed forebrain pathways. As pathways consolidate, they run without PFC — control → automaticity.

**Architectural mapping:** this activity-format vs. synaptic-format distinction is the biological statement of the wiki's **fast-M / slow-W split** ([[wiki/concepts/two-learning-timescales.md]]): the activity/fast store holds the currently-configured task model (broadcastable, disposable), while slow synaptic weights hold consolidated structure. A reasoning system's "configurator" state (LeCun) is an activity-format code by this logic — it must be globally broadcast and cheaply swapped, which is exactly why it cannot be baked into weights.

---

## Application to Reasoning Model

| CC (Cognitive Control) Component | Building Block | Mechanism |
|---|---|---|
| Response inhibition / Common CC (Cognitive Control) | Block 3D (goal generator) | Active maintenance of g_goal biases downstream processing |
| WM updating | Block 3B (DLPFC WM) | TRNN (Transition RNN) or LSTM receives signal to update held context |
| Mental set-shifting | Block 3A (Transformation Inferrer) | New transformation W selected; old task-set suppressed |
| Hierarchical PFC (Prefrontal Cortex) (BA-8→9/46→10) | Block 3C (hierarchical stack) | Three-level W: stimulus-response → contextual rule → rule-of-rules |
| BG (Basal Ganglia) selection objective (proficient phase) | Block 3D (action selection module) | MSPRT (Bogacz & Gurney 2007): log-posterior selection via STN (Subthalamic Nucleus) exp + GP log-softmax; not argmax — requires global normalization S(T) = ln(Σ exp(salience_j)) |
| **Configurator (LeCun 2022)** | All modules (world model, perception, cost, actor) | Task-specific modulation of parameters + attention circuits; single configurable world model engine; subgoal decomposition is the hardest unspecified component |

---

## ACC (Anterior Cingulate Cortex): Conflict Monitoring and Proactive CC

The Predicted Response Outcome model (Botvinick / Rushworth): ACC (Anterior Cingulate Cortex) computes *unsigned* prediction errors at multiple timescales — both unexpected omission and unexpected occurrence. Output modulates:
- **Reactive CC:** error-correction signal after conflict
- **Proactive CC:** anticipatory bias adjustment before expected conflict (risk-avoidance, foraging)

Distinct from DA/TD error: unsigned (not signed reward prediction error), multi-timescale, modulates control effort not value. See [[wiki/concepts/predictive-coding.md]].

---

## GNW (Global Neuronal Workspace) as the CC (Cognitive Control) Hub Circuit

The PFC's CC (Cognitive Control) role (goal maintenance, bias signaling) is mechanistically grounded in its role as the highest-density node in the Global Neuronal Workspace hub. The GNW (Global Neuronal Workspace) provides the structural implementation of Miller & Cohen's biased competition model:

- **Goal representations = GNW (Global Neuronal Workspace) broadcasting:** long-range GNW (Global Neuronal Workspace) neurons in PFC (Prefrontal Cortex) broadcast goal-congruent bias top-down to all specialized processors simultaneously, making goal maintenance equivalent to sustained GNW (Global Neuronal Workspace) ignition of the goal representation
- **Raven's Progressive Matrices** — identified in GNW (Global Neuronal Workspace) theory as the canonical multi-processor integration task: solving requires integrating feature, count, spatial, and rule-relation representations across distributed cortical areas via the hub core — identical to the Block 3C hierarchical CC (Cognitive Control) requirement
- **Dynamic repertoire as the CC (Cognitive Control) signature:** the GNW (Global Neuronal Workspace) hub's richer-than-anatomical functional connectivity diversity in the waking brain reflects CC-enabled flexible routing; loss of CC (Cognitive Control) (anesthesia, frontal lesion) collapses this diversity to the fixed anatomical connectivity matrix

---

## Theta Oscillations: The Oscillatory Substrate of CC Gating

Non-phase-locked theta (4–8 Hz) in PFC is the measurable oscillatory implementation of the goal-bias mechanism (Widge et al. 2019):

| Theta property | Functional role |
|---|---|
| **Conflict-evoked, not tonic** | Induced theta increases during conflict but not during rest — CC gating is a triggered mode switch, not a background state |
| **VLPFC (anterior IFG) locus** | Largest conflict × DBS effect; mPFC/dACC theta also increases but evoked potential amplitude is unchanged by DBS |
| **Frontal ensemble synchrony** | mPFC theta synchronizes frontal ensembles with downstream targets, enabling PFC to gate response sets and behavior styles |
| **Biomarker of CC engagement** | VLPFC ON–OFF theta change predicts depression symptom improvement (r=0.76, AUC=0.87); resting theta has no predictive value |

**Causal evidence:** VCVS DBS retrograde-activates corticofugal fibers in the internal capsule → enhances PFC theta → improves conflict task performance (34 ms RT reduction). The effect is frequency-specific (theta only) and task-specific (no resting-state change).

**Design implication:** The CC gating signal is not always-on oscillatory synchrony but a conflict-triggered burst. An implementation sequence: ACC detects prediction error → triggers theta burst in VLPFC/mPFC → theta synchronizes downstream processing → response set selected. A reasoning system implementing CC needs a triggered oscillatory mode rather than a static goal-bias signal.

---

## pmPFC: Tactic Selection — A Medial Supervisory Layer (Matsuzaka et al. 2012)

A fourth CC-related operation distinct from the three Miyake components: **tactic selection** — choosing *which response protocol* to apply, upstream of and orthogonal to conflict monitoring.

**Dissociation from ACC conflict monitoring:**

| Region | Function | Active when |
|---|---|---|
| **pmPFC (~area 8b, medial)** | Tactic selection: *how* to respond | ≥2 response strategies simultaneously available |
| **ACC (BA-24/32)** | Conflict monitoring: detects response conflict | Prepotent response competes with task-correct response |

Key evidence: 51% of pmPFC neurons are tactic-selective in mixed-tactic conditions; only 5/260 ACC neurons were concordance-selective. The two operations are anatomically and computationally dissociated.

**Key properties of pmPFC tactic-selection:**
- **Demand-responsive**: neurons activate when ≥2 tactics are available, regardless of which action is performed; a single-tactic condition (concordant-only or discordant-only) silences most pmPFC neurons even though actions continue to vary
- **Predictive**: ensemble onset ~125–145ms before the motor response (RT 247–313ms); tactic is encoded before action execution
- **Controlled→automatic transition**: multi-tactic condition requires pmPFC; single-tactic training installs a habit (cortico-BG loop), disengages pmPFC, and reduces reaction times — supervisory control is bypassed by automatization

**Design implication:** Block 3C needs a medial supervisory gate operating in parallel with the lateral PFC rule hierarchy. This gate: (1) engages *conditionally* when multiple response protocols are simultaneously live; (2) selects among them *before* action selection (not after conflict is detected); (3) disengages as the selected protocol becomes automatic. This is a different operation from prePMd 2nd-order rule search (which operates on context → rule-set mappings) — pmPFC operates on *which response strategy* to invoke given the immediate cue, not which abstract rule applies across contexts.

---

### Dynamic Supervisory Cascade: pmPFC → pre-SMA → SMA (Awan et al. 2020)

Comparative CPD (coefficient of partial determination) analysis of all three medial frontal areas under the same tactic paradigm (Awan & Mushiake et al. 2020, extending Matsuzaka 2012):

| Area | Tactics | Cue position | Action | Role |
|------|---------|--------------|--------|------|
| **pmPFC** | ✓ delay + response | ✓ response period | ✓ response period | Integration hub: tactics + spatial + action |
| **pre-SMA** | ✓ delay + response | ✗ absent | ✓ response period | Tactic buffer: tactics → action, no spatial |
| **SMA** | Weak (minority) | ✗ absent | ✓ strong | Motor executor: action only |

**Spatial information gating:** pre-SMA has abundant PFC afferents but sparse direct parietal afferents. When pmPFC is engaged (multi-tactic condition), pre-SMA is relieved of spatial integration — pmPFC processes cue location internally and passes only the abstracted tactic+action signal downstream. When pmPFC is absent (single-tactic, invariant condition), spatial information may reach pre-SMA via non-PFC routes — explaining why prior single-tactic studies found spatial tuning in pre-SMA.

**Hub-suppresses-satellite pattern:** PFC hypoactivity in schizophrenia is accompanied by compensatory pre-SMA overactivation (Cieslik et al. 2015). The engaged pmPFC hub actively suppresses the downstream satellite's need for raw sensory input; when the hub fails, the satellite compensates but suboptimally. This is topologically consistent with Gap #8: the abstract hub does not *query* the satellite for sensory details — it *processes* those details itself, then releases a distilled abstract signal for execution.

**Refined Block 3C design implication:** The medial supervisory gate is an integration hub, not a simple router. It must: (a) receive and integrate both abstract rule (tactic) and raw sensory (spatial cue) signals simultaneously; (b) gate spatial information to downstream areas — pre-SMA receives tactic+action signal without raw spatial; (c) suppress downstream area's direct sensory processing while it is engaged; (d) disengage when tactics become invariant, handing control to the pre-SMA→SMA cascade.

---

## Open Problems

- Exact circuit mechanism for goal bias: how does dlPFC goal representation selectively amplify task-relevant processing in posterior cortex without a labeled connection map?
- How do hot CC (Cognitive Control) (OFC/vmPFC: value/emotion) and cool CC (Cognitive Control) (lateral PFC: rule-governed) integrate — shared MD network nodes with different content, or qualitatively different circuits?
- Does the hierarchical PFC (Prefrontal Cortex) gradient imply three separate modules or a single continuous system graded by temporal context (longer context = more rostral)?

---

## Connections

- **[[wiki/concepts/meta-learning.md]]** — goal maintenance is the behavioral description of what the PFC (Prefrontal Cortex) meta-RL LSTM (Block 3B) implements: the held goal representation in the hidden state biases the within-episode fast RL algorithm.
- **[[wiki/concepts/working-memory.md]]** — WM updating is the second CC (Cognitive Control) component; WM maintenance (what's in the workspace) is the substrate for goal maintenance itself; dlPFC role shifts from "maintenance" to "interference resistance" upon closer scrutiny.
- **[[wiki/concepts/neuromodulation.md]]** — Dopamine D1 stabilizes goal maintenance (inverted-U); 5-HT modulates OFC (Orbitofrontal Cortex) reversal (set-shifting over values); NA (Noradrenaline / Norepinephrine) via Right Inferior Frontal Gyrus (RIFG)→STN hyperdirect pathway implements response inhibition; ACC (Anterior Cingulate Cortex) outputs to LC (NA) for proactive CC.
- **[[wiki/concepts/predictive-coding.md]]** — ACC (Anterior Cingulate Cortex)'s conflict signal is the CC-domain prediction error; proactive CC (Cognitive Control) (anticipatory adjustment) is active inference (minimizing expected future free energy) applied to the control domain.
- **[[wiki/concepts/attention.md]]** — top-down goal-based biasing is attentional: dlPFC goal representations modulate posterior cortex attention weights; this is the Desimone & Duncan biased competition model.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — three CC (Cognitive Control) components → Blocks 3D (inhibition), 3B (updating), 3A (shifting); hierarchical PFC (Prefrontal Cortex) gradient → Block 3C three-level template (BA-8/9/46/10).
- **[[wiki/papers/pfc-cognitive-control-friedman-2021.md]]** — primary source for three CC (Cognitive Control) components, hierarchical PFC (Prefrontal Cortex) gradient, ACC (Anterior Cingulate Cortex) PRO model, and neurochemical specificity content.
- **[[wiki/papers/pfc-wood-grafman-2003.md]]** — source for SEC (Structured Event Complex) framework; resolves representation/process debate; establishes vmPFC/dlPFC categorical specificity via connectivity.
- **[[wiki/papers/pfc-categories-concepts-miller-2002.md]]** — source for the sustained-activity-vs-synaptic-weight format argument, the capacity-limit-from-population-code corollary, the task-model-as-pathway-map, and VTA-dopamine bootstrapping; the single-neuron empirical grounding of the Miller & Cohen biased-competition model.
- **[[wiki/concepts/two-learning-timescales.md]]** — the activity-format vs. synaptic-format distinction is the biological statement of the fast-M / slow-W split: sustained PFC activity holds the disposable, broadcastable task configuration while slow weights hold consolidated structure.
- **[[wiki/entities/prefrontal-cortex.md]]** — biological substrate of all CC (Cognitive Control) mechanisms; anatomy, connectivity, and mapping to Blocks 3A–3D; vmPFC/dlPFC categorical specificity informs Block 3C content types.
- **[[wiki/concepts/analogical-reasoning.md]]** — the mapping stage of analogy is the canonical task that drives frontopolar BA (Brodmann Area)-10: simultaneous satisfaction of structural + semantic + pragmatic constraints is a concrete operationalization of "multi-relational integration"; the ≤2-3 proposition WM limit constrains how the Block 3C three-level hierarchy must decompose long compositional chains into sequential integration steps.
- **[[wiki/papers/analogy-holyoak-2012.md]]** — source for the BA (Brodmann Area)-10 multi-relational integration specificity and its dissociation from BA (Brodmann Area)-44/45 interference control; refines what "frontopolar" means in the Block 3C template.
- **[[wiki/entities/basal-ganglia.md]]** — BG (Basal Ganglia) provides two distinct CC (Cognitive Control) contributions: (1) hyperdirect Hold signal implements response inhibition (the common CC (Cognitive Control) factor); (2) MSPRT in the proficient phase specifies the Bayesian selection objective for Block 3D; the three CC (Cognitive Control) components map onto Go/NoGo/Hold + MSPRT as the complete CC-BG interface.
- **[[wiki/papers/bogacz-gurney-bg-msprt-2007.md]]** — algorithmic source for Block 3D's BG (Basal Ganglia) selection objective: MSPRT = log-posterior Bayesian selection; the same hyperdirect STN (Subthalamic Nucleus) pathway that implements Hold/response inhibition also provides the global competition term S(T) in MSPRT; Hick's Law derivation shows decision time ∝ log(N) in any log-softmax selection system.
- **[[wiki/entities/gwt-model.md]]** — GNW (Global Neuronal Workspace) hub is the structural substrate for CC (Cognitive Control) goal maintenance; PFC's high density of long-range GNW (Global Neuronal Workspace) neurons is the mechanistic basis for why goal representations in dlPFC bias downstream processing; Raven's Matrices as the canonical GNW/CC task requiring multi-processor integration.
- **[[wiki/papers/gnw-mashour-2020.md]]** — source for GNW (Global Neuronal Workspace) as CC (Cognitive Control) hub; dynamic state repertoire diversity as the CC (Cognitive Control) operational indicator; anesthesia/frontal lesion as natural experiments confirming hub necessity.
- **[[wiki/papers/raccah-pfc-consciousness-2021.md]]** — iES evidence that lateral PFC (Prefrontal Cortex) is not constitutive of consciousness (near-zero phenomenal elicitation rate) does not challenge CC: PFC's role in goal maintenance, WM, and hierarchical rule use is enabling, not constitutive of phenomenal experience; the ACC (Anterior Cingulate Cortex) consciousness finding (emotional/motivational iES effects) is consistent with ACC (Anterior Cingulate Cortex)'s conflict and proactive CC (Cognitive Control) functions.
- **[[wiki/entities/jepa-model.md]]** — the configurator in LeCun's cognitive architecture is the computational CC (Cognitive Control) module: it takes inputs from all other modules and primes the world model, perception, cost, and actor for the task at hand — directly instantiating goal-maintenance as dynamic parameter modulation rather than a static goal representation.
- **[[wiki/concepts/world-models.md]]** — the configurator operates on a single configurable world model; goal maintenance in CC (Cognitive Control) = the configurator holding the current task configuration active while the world model runs; subgoal decomposition (the hardest open piece) maps to how the hierarchical PFC (Prefrontal Cortex) gradient sequences subgoals over time.
- **[[wiki/entities/c2c-model.md]]** — C2C state transformation modeling provides empirical quantification of task-mode switching: PCA-derived subsystems split into a stable backbone (~6 task-general components preserved across all 7 cognitive states) and a task-modulated overlay (task-specific components that change differently per task); this is the whole-brain implementation of the CC backbone + configurator decomposition, confirming it at the level of functional connectivity topology.
- **[[wiki/papers/widge-2019-dbs-pfc-theta-cc.md]]** — causal evidence (VCVS DBS intervention) that conflict-evoked PFC theta is the oscillatory substrate of CC gating; corticostriatal stimulation enhances theta and performance simultaneously; resting-state theta is unaffected, establishing the triggered (not tonic) nature of CC oscillatory gating.
- **[[wiki/papers/frontal-cortex-abstract-rules-badre2010.md]]** — source for parallel multi-level policy search: prePMd activates from trial 1 across both Flat and Hierarchical conditions; reward-gated attenuation when higher-order rules are unavailable; step-wise sigmoid learning curves as the diagnostic of rule-discovery compression; putamen→cortex→caudate Granger chain as the RL validation circuit.
- **[[wiki/papers/matsuzaka-pmpfc-tactics-2012.md]]** — source for the pmPFC tactic-selection dissociation: demand-responsive activation (only when ≥2 strategies live), predictive ensemble onset, ACC dissociation (tactic selection ≠ conflict monitoring), and automatization-driven disengagement; establishes the need for a conditional medial supervisory gate in Block 3C alongside the lateral PFC rule hierarchy.
- **[[wiki/papers/neuronal-tactic-sensorimotor-awan-2020.md]]** — extends Matsuzaka 2012 with three-area CPD analysis; establishes the full sensorimotor cascade (pmPFC integrates all three variables → pre-SMA handles tactics+action, no spatial → SMA executes); reveals spatial information gating mechanism and hub-suppresses-satellite pattern; refines the Block 3C medial gate as an integration hub that filters sensory details before passing distilled signals downstream.
- **[[wiki/concepts/network-integration-segregation.md]]** — whole-brain integration (elevated B_T) is the network-level substrate of complex CC and WM updating; N-back (the prototypical CC task) produces the largest integration shift of any HCP task; integration accelerates drift rate (evidence accumulation) specifically rather than response caution, matching the speed-up observed in CC-enhancing interventions like VCVS DBS.
