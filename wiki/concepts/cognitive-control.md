---
title: "Cognitive Control"
type: concept
tags: [cognitive-control, executive-function, PFC, goal-maintenance, inhibition, working-memory, set-shifting, hierarchy]
created: 2026-06-19
updated: 2026-06-20
sources: [The role of prefrontal cortex in cognitive control and executive function, pfc-wood-grafman-2003.md]
related: [wiki/concepts/meta-learning.md, wiki/concepts/working-memory.md, wiki/concepts/neuromodulation.md, wiki/concepts/predictive-coding.md, wiki/concepts/attention.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/papers/pfc-cognitive-control-friedman-2021.md, wiki/papers/pfc-wood-grafman-2003.md, wiki/entities/prefrontal-cortex.md, wiki/entities/basal-ganglia.md, wiki/concepts/analogical-reasoning.md, wiki/papers/analogy-holyoak-2012.md, wiki/papers/bogacz-gurney-bg-msprt-2007.md]
---

# Cognitive Control

**Cognitive control (CC) is the capacity to flexibly guide behavior toward goals by maintaining active goal representations in PFC that bias downstream processing toward contextually correct but non-prepotent responses.**

Miller & Cohen (2001) formulation: goal representations in PFC send top-down bias signals to sensorimotor regions, enabling weak task-correct mappings to out-compete stronger habitual ones via lateral inhibition.

---

## Three Dissociable Components (Miyake et al. 2000)

| Component | Definition | PFC subregion | Neuromodulator |
|---|---|---|---|
| **Inhibition / response inhibition** | Suppressing a dominant prepotent response | RIFG (BA-44/45); hyperdirect STN pathway | NA (atomoxetine enhances stop-signal) |
| **WM Updating** | Continuously monitoring and replacing WM content with task-relevant items | Mid-dorsal PFC (BA-9/46); parietal for manipulation | DA D1 (inverted-U for dlPFC WM stability) |
| **Mental Set-Shifting** | Switching between established task-set mappings | vlPFC (BA-12/47) for extra-dim shift; OFC (BA-11) for reversal | 5-HT (OFC reversal learning specifically) |

Latent factor correlations: r = 0.42–0.63 (unity); separable (diversity). Inhibition = Common CC factor — the variance that is shared across all three is isomorphic with response inhibition.

**Key result (bifactor model):** Inhibition-specific variance = 0; there is no response-inhibition-specific factor beyond what is common to all CC. Set-shifting and WM updating have residual specific variance. This implies: individual differences in CC *are* individual differences in goal maintenance.

---

## Hierarchical Lateral PFC — Template for Block 3C

A well-confirmed rostro-caudal gradient (TMS-causal, fMRI, lesion):

| PFC region | Level | Content |
|---|---|---|
| Caudal PFC (BA-8) | Stimulus-response | Conditional mapping: this cue → this action |
| Mid-lateral PFC (BA-9/46) | Contextual rule | Maintain task context; monitor (n-back, tagging); resist interference |
| Frontopolar PFC (BA-10) | **Simultaneous multi-relational integration** | Constraint-satisfaction over ≥2 relational structures held simultaneously in WM; selectively activated by *relational count*, not nesting depth alone (Christoff 2001; Cho 2010); also handles branching rule-of-rules and sequential subgoals |

Hub / apex is mid-lateral, not rostral PFC (TMS: mid-lateral integrates the caudal sensory and rostral memorial signals).

---

## PFC as Representational System — SEC Framework

Wood & Grafman (2003) resolve the representation/process debate: PFC stores long-term memory representations; WM = those representations currently activated; processes = representations that remain active. Implication for design: Block 3C should store **structured representations** (grammars, rule sequences), not just weight matrices over transformations.

The **Structured Event Complex (SEC)** is the proposed representational unit:

> An SEC is a goal-oriented, temporally ordered event sequence encoding abstractions, rules, grammars, social schemas, and event boundaries. Activating an SEC generates predictions about subsequent events.

| SEC property | Block 3C implication |
|---|---|
| Sequential temporal structure | W_rule-of-rules encodes a grammar over event sequences, not just a single transformation label |
| Grammar encoding | Abstract compositional structure stored at the highest level; lower levels sample episodes from it |
| Goal-orientation | Terminal event = goal state → natural grounding for Block 3D goal generator |
| Predictive function | SEC = generative model of event futures; consistent with PC/FEP framing |

**vmPFC/dlPFC categorical specificity (via connectivity):** vmPFC (amygdala + HC connectivity) = social/emotional SECs; dlPFC (BG + premotor connectivity) = mechanistic/action SECs. This categorical split maps onto the content of W levels: W_instance (dlPFC) stores action-sequence mappings; vmPFC contributes goal value (Block 3D).

**Convergence with Friedman & Robbins 2021:** The SEC anterior-posterior gradient (frontopolar = long multi-event SECs; posterior = short/single-event) and the rule-nesting gradient (BA-10 = rules-of-rules; BA-8 = S-R) are two descriptions of the same rostro-caudal axis — event-sequence *duration* and rule *depth* increase together. Both justify the three-level W stack.

---

## Goal Maintenance as the Unified CC Mechanism

The PFC maintains goal representations `g*` that modulate downstream processing:
```
P(response | state, goal) ∝ P(response | state) × exp(β · b(g*, response))
```
Where `b(g*, response)` is the goal-congruence bias. Higher goal activation → stronger suppression of competing (habitual) responses via lateral inhibition in posterior cortex. CC fails = goal deactivates early → prepotent response wins.

This "active bias" account subsumes response inhibition (goal causes inhibition of prepotent act), WM updating (goal signals that current content is no longer task-relevant → triggers replacement), and set-shifting (goal signals to switch — activates new task-set W).

---

## Application to Reasoning Model

| CC Component | Building Block | Mechanism |
|---|---|---|
| Response inhibition / Common CC | Block 3D (goal generator) | Active maintenance of g_goal biases downstream processing |
| WM updating | Block 3B (DLPFC WM) | TRNN or LSTM receives signal to update held context |
| Mental set-shifting | Block 3A (Transformation Inferrer) | New transformation W selected; old task-set suppressed |
| Hierarchical PFC (BA-8→9/46→10) | Block 3C (hierarchical stack) | Three-level W: stimulus-response → contextual rule → rule-of-rules |
| BG selection objective (proficient phase) | Block 3D (action selection module) | MSPRT (Bogacz & Gurney 2007): log-posterior selection via STN exp + GP log-softmax; not argmax — requires global normalization S(T) = ln(Σ exp(salience_j)) |

---

## ACC: Conflict Monitoring and Proactive CC

The Predicted Response Outcome model (Botvinick / Rushworth): ACC computes *unsigned* prediction errors at multiple timescales — both unexpected omission and unexpected occurrence. Output modulates:
- **Reactive CC:** error-correction signal after conflict
- **Proactive CC:** anticipatory bias adjustment before expected conflict (risk-avoidance, foraging)

Distinct from DA/TD error: unsigned (not signed reward prediction error), multi-timescale, modulates control effort not value. See [[wiki/concepts/predictive-coding.md]].

---

## Open Problems

- Exact circuit mechanism for goal bias: how does dlPFC goal representation selectively amplify task-relevant processing in posterior cortex without a labeled connection map?
- How do hot CC (OFC/vmPFC: value/emotion) and cool CC (lateral PFC: rule-governed) integrate — shared MD network nodes with different content, or qualitatively different circuits?
- Does the hierarchical PFC gradient imply three separate modules or a single continuous system graded by temporal context (longer context = more rostral)?

---

## Connections

- **[[wiki/concepts/meta-learning.md]]** — goal maintenance is the behavioral description of what the PFC meta-RL LSTM (Block 3B) implements: the held goal representation in the hidden state biases the within-episode fast RL algorithm.
- **[[wiki/concepts/working-memory.md]]** — WM updating is the second CC component; WM maintenance (what's in the workspace) is the substrate for goal maintenance itself; dlPFC role shifts from "maintenance" to "interference resistance" upon closer scrutiny.
- **[[wiki/concepts/neuromodulation.md]]** — DA D1 stabilizes goal maintenance (inverted-U); 5-HT modulates OFC reversal (set-shifting over values); NA via Right Inferior Frontal Gyrus (RIFG)→STN hyperdirect pathway implements response inhibition; ACC outputs to LC (NA) for proactive CC.
- **[[wiki/concepts/predictive-coding.md]]** — ACC's conflict signal is the CC-domain prediction error; proactive CC (anticipatory adjustment) is active inference (minimizing expected future free energy) applied to the control domain.
- **[[wiki/concepts/attention.md]]** — top-down goal-based biasing is attentional: dlPFC goal representations modulate posterior cortex attention weights; this is the Desimone & Duncan biased competition model.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — three CC components → Blocks 3D (inhibition), 3B (updating), 3A (shifting); hierarchical PFC gradient → Block 3C three-level template (BA-8/9/46/10).
- **[[wiki/papers/pfc-cognitive-control-friedman-2021.md]]** — primary source for three CC components, hierarchical PFC gradient, ACC PRO model, and neurochemical specificity content.
- **[[wiki/papers/pfc-wood-grafman-2003.md]]** — source for SEC framework; resolves representation/process debate; establishes vmPFC/dlPFC categorical specificity via connectivity.
- **[[wiki/entities/prefrontal-cortex.md]]** — biological substrate of all CC mechanisms; anatomy, connectivity, and mapping to Blocks 3A–3D; vmPFC/dlPFC categorical specificity informs Block 3C content types.
- **[[wiki/concepts/analogical-reasoning.md]]** — the mapping stage of analogy is the canonical task that drives frontopolar BA-10: simultaneous satisfaction of structural + semantic + pragmatic constraints is a concrete operationalization of "multi-relational integration"; the ≤2-3 proposition WM limit constrains how the Block 3C three-level hierarchy must decompose long compositional chains into sequential integration steps.
- **[[wiki/papers/analogy-holyoak-2012.md]]** — source for the BA-10 multi-relational integration specificity and its dissociation from BA-44/45 interference control; refines what "frontopolar" means in the Block 3C template.
- **[[wiki/entities/basal-ganglia.md]]** — BG provides two distinct CC contributions: (1) hyperdirect Hold signal implements response inhibition (the common CC factor); (2) MSPRT in the proficient phase specifies the Bayesian selection objective for Block 3D; the three CC components map onto Go/NoGo/Hold + MSPRT as the complete CC-BG interface.
- **[[wiki/papers/bogacz-gurney-bg-msprt-2007.md]]** — algorithmic source for Block 3D's BG selection objective: MSPRT = log-posterior Bayesian selection; the same hyperdirect STN pathway that implements Hold/response inhibition also provides the global competition term S(T) in MSPRT; Hick's Law derivation shows decision time ∝ log(N) in any log-softmax selection system.
