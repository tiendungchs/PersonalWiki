---
title: "Hierarchical Reinforcement Learning (HRL) / Options"
type: concept
tags: [hierarchical-reinforcement-learning, options, temporal-abstraction, subgoal-discovery, pseudo-reward, semi-markov, actor-critic, goal-decomposition, meta-learning]
created: 2026-07-18
updated: 2026-07-18
sources: [Hierarchically organized behavior and its neural foundations A reinforcement learning perspective]
related: [wiki/concepts/cognitive-control.md, wiki/entities/basal-ganglia.md, wiki/entities/prefrontal-cortex.md, wiki/concepts/successor-representation.md, wiki/concepts/meta-learning.md, wiki/concepts/neuromodulation.md, wiki/concepts/planning-as-inference.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/arbitrary-mapping.md, wiki/queries/hrl-goal-decomposition-coverage.md, wiki/queries/proposed-reasoning-model-block-architectures.md, wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md]
---

# Hierarchical Reinforcement Learning (HRL) / Options

**HRL attacks RL's scaling problem by adding *temporally abstract actions* (options) — mini-policies that group a variable-length sequence of primitive actions into a single selectable skill — so exploration and credit assignment happen over a shrunken decision tree.** (Botvinick, Niv & Barto 2009.)

The scaling problem: standard RL training time grows super-linearly in |states| × |actions|; exploration must discover reward-bearing traversals of an exponential decision tree. Options cut the tree: a 7-primitive path discovered as 2 option selections needs 2 decisions, not 7 — fewer exploration steps **and** fewer decision-points to learn.

---

## The option (SMDP formalism)

An **option** = ⟨initiation set `I`, termination function `β(s)`, option policy `π_o(s→a)`⟩ where actions `a` may themselves be options (→ nested hierarchy). Once selected, `π_o` runs until `β` fires. This makes the process a **semi-Markov decision process (SMDP)**: decisions occur at variable time intervals, not fixed steps.

**Actor–critic implementation** (the paper's contribution — enables neural mapping):

| Element | Standard RL | HRL extension |
|---|---|---|
| Actor policy | `π(s)` action strengths | + which option `o` is in control; **separate `π_o(s)` per option** |
| Critic value | `V(s)` | + **option-specific `V_o(s)`** (incorporates pseudo-reward) |
| Prediction error `δ` | per time-step | + **option-scope `δ`** at termination: `[V(s_term) − V(s_init) + Σ rewards accrued]` |

**Pseudo-reward:** options are learned toward **subgoal** states; reaching a subgoal yields internal *pseudo-reward* (distinct from external reward) that shapes `π_o`. Option-specific value functions are required precisely because expected future reward depends on which option (hence which policy + which pseudo-reward) is active.

---

## The option discovery problem (the crux)

Options only help if they are *useful*; a mismatched option set produces **negative transfer** (four-rooms "window" options, or doorway options that blind the agent to a new shortcut — it slavishly routes through learned doorways). Where do good subgoals come from?

| Route | Mechanism | Reasoning-model relevance |
|---|---|---|
| **Evolutionary / innate** | genetically specified building blocks (grooming chains) | prior scaffold; Core-Knowledge analog |
| **Bottleneck (trajectory)** | states frequent in reward-reaching trajectories → subgoals | frequency statistics over solved episodes |
| **Bottleneck (graph)** | graph-partition the state-transition graph; access points = subgoals | **direct latent-graph-discovery link** — subgoals = graph cut-vertices |
| **Intrinsic motivation** | salient/surprising outcomes are intrinsically rewarding → build options to re-attain them (developmental "circular reactions") | curiosity engine (Block 3D); LP/empowerment |
| **Social / imitation** | infer subgoals from others' behavior; shaping | demonstration/distillation route (Gap #3) |
| **Impasse-driven (Soar)** | subgoal created at a problem-solving impasse; later chunked | refinement-loop trigger |

Subgoal discovery = **the** unspecified hard component; it is the same object as bottleneck/cut-vertex discovery in [[wiki/concepts/latent-graph-discovery.md]].

---

## Neural mapping (actor–critic → functional neuroanatomy)

| HRL extension | Structure | Evidence |
|---|---|---|
| Option identifiers + which-option-in-control | **DLPFC** (+ pre-SMA, PMC) | task-set/policy coding; nested action at multiple temporal scales, **higher levels more anterior** (rostro-caudal) |
| Option-specific policies `π_o(s)` | **dorsolateral striatum (DLS)** | context-dependent action coding (grooming-in-sequence vs isolated); frontal option reps *select* which S-R pathway (guided-activation / Frank-O'Reilly gating) |
| Option-specific value `V_o(s)` | **OFC** | reward-value coding that shifts with strategy/task-set; strong VS + DLPFC connectivity |
| Option-scope prediction error (SMDP) | **OFC + midbrain DA** | sustained reward-predictive activity spanning task segments; DA responses to delayed reward fit an SMDP account (Daw) |
| Subtask boundaries | phasic DLS + frontal activity at sequence boundaries | = points where new options are selected; DA-gated WM update |

**Testable prediction:** phasic dopamine at *subtask boundaries*, scaling with option-level prediction-error magnitude — and a possible neural correlate of *pseudo-reward* at subgoal attainment.

---

## Temporal vs. representational abstraction — the "genuine hole"

The wiki's rostro-caudal PFC hierarchy ([[wiki/concepts/cognitive-control.md]], Badre 2010) is a **representational** hierarchy — rule *depth* (S→R / context / rule-of-rules). Options are a **temporal** hierarchy — action *chunks* over variable-length sequences. Botvinick maps both onto the *same* frontal axis (higher = more anterior = both longer-horizon and more abstract), so they are two readings of one substrate rather than rivals — but the wiki previously had only the representational reading. HRL supplies the missing temporal-abstraction axis: the meta-graph must chunk *edges into super-edges* (options), not only *nest rules*.

**Model-based extension (saltatory search):** each option can carry an **option model** (predicted outcome, accrued reward, expected duration); planning then "skips over" primitive sequences — the same tree-reduction, now at plan time. This is the HRL form of [[wiki/concepts/planning-as-inference.md]] / STA hierarchical stacking (Gap #2).

**Strict vs. quasi-hierarchical limit:** naturalistic tasks share structure (spread jam / mustard / icing) and are context-sensitive (grip depends on write-vs-erase intent), which strict options cannot capture — an open tension between compositional reuse and context-sensitivity that also appears inside HRL.

---

## Application to the reasoning model

- **Block 3C/3D:** options = the temporal-abstraction operator absent from the representational three-level stack; a subgoal generator feeding `V_o`/`V(g)` value heads is the concrete addition.
- **Subgoal discovery** is the highest-leverage open piece — bottleneck/graph-partition ties it to latent-graph cut-vertices; intrinsic-motivation ties it to the Block 3D curiosity engine.
- **Pseudo-reward** = an internal shaping signal that lets the agent train sub-policies without external reward — the RL substrate of self-supervised skill acquisition during the "explore" curriculum phase.
- **Negative transfer** is a design warning: a fixed/over-fit option library *slows* new learning, motivating create-or-reuse gating ([[wiki/entities/basal-ganglia.md]] C-TS).

---

## Open Problems

- Where subgoals come from remains unsolved end-to-end (discovery problem); graph-partition is principled but presupposes the transition graph HRL is trying to help discover (chicken-egg with Block 3D region provenance).
- Options vs. context-sensitive/overlapping subtasks (strict vs. quasi-hierarchy) — how to keep compositional reuse without losing context-dependent execution.
- Pseudo-reward has no confirmed neural correlate; distinguishing it from external reward at subgoal states is an open experiment.
- HRL-framework dependence: options (option-specific `V_o`) vs. MAXQ (value decomposition) vs. HAM (fixed task hierarchy, no pseudo-reward) make different DA predictions — the "right" biological variant is unsettled.

---

## Connections

- **[[wiki/concepts/cognitive-control.md]]** — the rostro-caudal PFC axis is the *representational* (rule-depth) hierarchy; HRL supplies its *temporal* (option-chunk) twin, and Botvinick maps both onto the same "higher = more anterior" frontal gradient — options are the temporal-abstraction reading of Block 3C.
- **[[wiki/entities/basal-ganglia.md]]** — the DLS implements option-specific policies (frontal option reps gate which S-R pathway fires); subtask-boundary phasic DA gates WM option updates; C-TS create-or-reuse is the antidote to HRL negative transfer from a fixed option set.
- **[[wiki/entities/prefrontal-cortex.md]]** — DLPFC houses option identifiers and the which-option-in-control signal, and OFC computes option-specific value + the SMDP option-scope prediction error; the anterior-more-abstract gradient is HRL's nested-option hierarchy.
- **[[wiki/concepts/successor-representation.md]]** — SR/DR is the *flat* predictive map; option models are its temporally-abstract counterpart (multi-step outcome/duration predictions), letting planning skip over primitive-action sequences (saltatory search).
- **[[wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md]]** — the MB/MF uncertainty arbiter's **partial evaluation** (search partway, then compare uncertainties to decide expand-tree vs. fall back on cache) is the same expand/skip decision an option model makes at each node; also the source of the SMDP delayed-reward DA account this page maps to OFC + midbrain DA.
- **[[wiki/concepts/meta-learning.md]]** — pseudo-reward and intrinsic-motivation subgoal discovery are the RL substrate of learning-to-learn skills; option acquisition during a developmental period is meta-learning a reusable skill library.
- **[[wiki/concepts/neuromodulation.md]]** — the SMDP widened prediction-error scope predicts phasic DA at subtask boundaries (not just per-step), refining DA = TD-error into DA = option-scope-TD-error; 5-HT (γ) sets the option horizon.
- **[[wiki/concepts/planning-as-inference.md]]** — model-based HRL (option models) reduces the planning tree by skipping over sub-sequences; the hierarchical-STA stacking result (abstract→concrete) is the attractor-dynamics form of the same tree reduction.
- **[[wiki/concepts/latent-graph-discovery.md]]** — graph-partition subgoal discovery = finding bottleneck/cut-vertex states in the transition graph; option subgoals are exactly the access points a latent-graph discoverer must find, making subgoal discovery a sub-problem of graph discovery.
- **[[wiki/concepts/arbitrary-mapping.md]]** — options are content-free action pointers over *temporally extended* sequences, the temporal-abstraction generalization of the single-step arbitrary cue→action pointer; both bind an index to a policy inferred/learned rather than hard-wired.
- **[[wiki/queries/hrl-goal-decomposition-coverage.md]]** — this concept page is the "genuine hole" that audit identified; it is the dedicated home HRL goal-decomposition previously lacked.
- **[[wiki/queries/proposed-reasoning-model-block-architectures.md]]** — supplies the temporal-abstraction operator and subgoal generator missing from Blocks 3C/3D of the proposed model.
