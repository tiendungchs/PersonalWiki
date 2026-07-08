---
title: "Reasoning as Coupled Path-Integration ⇄ Strategizing (Information-Flow Account)"
type: query
tags: [reasoning, information-flow, path-integration, prospective-coding, refinement-loops, neuromodulation, intrinsic-motivation, curriculum, imitation-learning, latent-graph-discovery]
created: 2026-07-06
updated: 2026-07-08
sources: []
related: [wiki/concepts/path-integration.md, wiki/concepts/prospective-coding.md, wiki/concepts/refinement-loops.md, wiki/concepts/neuromodulation.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/meta-learning.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/memory-schemas.md, wiki/concepts/replay.md, wiki/concepts/relational-reinterpretation.md, wiki/concepts/temporal-context.md, wiki/concepts/neoteny.md, wiki/concepts/core-knowledge.md, wiki/entities/tem-model.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/queries/building-blocks-declarative-subsystem.md, wiki/papers/verifiers-math-cobbe-2021.md, wiki/queries/sota-review-brain-inspired-abstract-reasoning.md, wiki/queries/proposed-reasoning-model-block-architectures.md]
---

# Reasoning as Coupled Path-Integration ⇄ Strategizing

**Question:** TEM describes how information flows during *navigation* (encode x → retrieve p = f(g,x) → path-integrate g → g' on action a → reverse-predict the next observation). Told in the same voice, how does information flow and what gets updated during *reasoning* — and how does the brain overcome the three things navigation gets for free (a known action vocabulary, a given goal, and a straight path to it)?

---

## Answer in one line

**Reasoning is path integration over an operator graph whose edges, and sometimes whose destination, must be discovered while traversing it** — run as a *coupled loop* between a metric **Navigator** (MEC/HC: *where am I / what will I see*) and a **Strategist** (PFC/mPFC: *where do I want to go / how*), with a neuromodulatory bus (DA/5-HT/ACh/NE) setting the gains and — critically — supplying the reward the loop optimizes before any external goal exists.

---

## The two systems

| | **Navigator** (System 1, metric) | **Strategist** (System 2, declarative/control) |
|---|---|---|
| Asks | *where am I / what will I see* | *where do I want to go / how* |
| State | `x` content, `g` position, `p=f(g,x)`, `M` bindings, `W` operators | `G_goal`, `V(a)` (what each action does), `Ŝ` (candidate plan), `schema` (active rule-regime) |
| Updated by | transition error `ε_x = x' − x̂'` | value/reward error `ε_r` (dopamine) |
| Neuromod | ACh (write vs. read), NE (explore) | DA (teach `V`, `G_goal`), 5-HT (planning horizon) |
| Wiki home | [[wiki/concepts/path-integration.md]], [[wiki/entities/tem-model.md]] | [[wiki/queries/building-blocks-mec-hc-pfc.md]] (3A/3B/3C/3D), [[wiki/queries/building-blocks-declarative-subsystem.md]] |

The Navigator's crucial quirk: retrieval is **generalizing completion** — `p` encodes *"likely see x at g,"* a **distribution** over positions/contents, not the literal *"saw x at g."* This is CA3 pattern completion / softmax (modern-Hopfield) retrieval, and it is what lets `M` persist and generalize across environments instead of being wiped per environment (the *savings* phenomenon: a stale-but-familiar environment re-orients fast because `M` consolidated into schema, it was never reset). The analytic ancestor of this generalizing completion is the Temporal Context Model ([[wiki/concepts/temporal-context.md]]): its slowly-drifting context `t` is the minimal leaky-integrator precursor to the Navigator's `g`, and its "memory space" already yields **transitive inference as a similarity gradient** over co-occurrence statistics (the α_N context-reinstatement term, abolished by HC lesion) rather than by logical deduction — the primitive, fully-analytic form of the metric completion the Navigator runs.

**The two systems are Penn's two** (relational reinterpretation; [[wiki/concepts/relational-reinterpretation.md]]). The Navigator is System 1 — proto-symbolic, *featurally* systematic, functionally-but-not-concatenatively compositional, shared with animals; the Strategist is System 2 — the human-only graft that reinterprets first-order relations as role-governed, **role-filler-independent** structure (a Physical Symbol System). This is *why* the coupling is load-bearing rather than optional: left alone, System 1 **fakes** relational reasoning by chunking a relation into an analog scalar and segmenting the task — the default attractor that surfaces here as diffuse-`g` completion collapsing onto the nearest feature-match. The Strategist's job is precisely to hold relational structure *open* (dynamic role-filler binding) instead of chunking it away — and Penn's comparative argument that this is a *graft, not a scale-up* is why the model needs the second system as distinct machinery, not more Navigator capacity.

---

## The flow (first person)

A problem appears; its content encodes to **x**. The Navigator completes **p**: *"given x, I'm likely at g"* — sharp if `M` holds anything related (orient instantly), **diffuse** if `M` is empty. That diffuseness *is the signal to explore*.

The Strategist reads `g` and asks the other question. At the start it has no goal and no vocabulary, so it fires roughly at random: diffuse **G_goal**, flat **V(a)**, NE high. It proposes a tentative action **a**.

The two systems predict **in tandem**:
1. Navigator runs the *reverse/generative* process — given `(g, a)`, predict next content **x̂'**: *"if I apply a here, I'll likely see x̂'."*
2. Strategist checks: does `x̂'` move toward `G_goal`? (weak while `G_goal` is uncertain)
3. Act; observe the **actual x'**.

The mismatch splits into **two prediction errors that train different modules** — the crux:

- **Transition error** `ε_x = x' − x̂'` → updates `W` **and `V(a)`**. The operator's effect is *inferred from the error* (inverse path integration / Transformation Inferrer, [[wiki/queries/building-blocks-mec-hc-pfc.md]] Block 3A). **→ dissolves Problem 1 (latent vocabulary).**
- **Value error** `ε_r` (dopamine) → updates `G_goal`, `π`. With no external reward yet, **the transition error, routed through DA-novelty, *is* the reward** (curiosity = prediction-error-as-reward). **→ dissolves Problem 2 (latent goal during exploration):** the loop has something to optimize before a real goal is known.

**The Strategist's search (Problem 3).** Once `V(a)` is non-trivial, the Strategist stops testing in the world and uses the Navigator as a **simulator**. HC/DMN samples candidate sequences — *"then likely x at g′, then likely x″ at g″, …"* (asymmetric-STDP chaining; [[wiki/concepts/prospective-coding.md]] one-step CA1 look-ahead → PFC/STA multi-step trajectory). Each sampled trajectory is rolled forward and **scored against `G_goal`** (vmPFC/ACC); high-scoring ones are reinforced, low ones pruned. **This is the generate→verify→update refinement loop, with HC replay as generator and PFC value-evaluation as verifier** ([[wiki/concepts/refinement-loops.md]]). *Seeded* sequences = goal-directed preplay (mPFC biases which replay); *spontaneous* firing = the exploratory prior that stops the search collapsing onto known paths.

**The goal crystallizes.** `G_goal` begins as a scalar hormonal valence ("that felt good"). Each reward makes DA stamp the active `(g, schema)` as valuable, so vmPFC slowly learns *what winning looks like*, sharpening `G_goal` from a scalar into a **structured target in g-space**. The genome supplies the valence machinery; the world model supplies the structure; the goal is their **product**. We aren't born with `G_goal` — we're born with the DA/5-HT apparatus that lets any recurring high-valence configuration *become* one.

**The systems lock:**
- Navigator → Strategist: `g` + its **confidence** (diffuse `g` ⇒ explore).
- Strategist → Navigator: `G_goal` + active `schema` **bias which edges** are traversed/simulated (the gating interface: schema X unmasks region-A edges; [[wiki/queries/building-blocks-declarative-subsystem.md]] §4), and which sequences replay.
- Neuromodulation sets gains: ACh↑ when `g` is surprising ⇒ write fast; NE↑ when uncertain ⇒ explore; DA teaches `V` and `G_goal`; 5-HT sets look-ahead depth ([[wiki/concepts/neuromodulation.md]]).

**And it compiles.** As `M` consolidates into schema, `V(a)` sharpens, and `G_goal` stabilizes, the same problem is solved by near-straight path integration toward a known target — effortful dual-system search **cached** into fast System-1 navigation (SWR shortcuts caching the inference; automatization). Effortful reasoning becoming intuition falls straight out of this.

### Compact "what updates"
`ε_x → {W, V(a)}` (learn graph & vocabulary) · `ε_r/DA → {G_goal, π}` (learn goal & policy) · `p → M` (write bindings, ACh-gated) · `M → schema` (offline consolidation) · replay-sample + evaluate → reweight which sequences to generate (the search).

---

## Goal selection under diffuse `g` — which action, exactly?

The flow above says the Strategist "fires roughly at random" and that DA-novelty makes the raw transition error `ε_x` the reward. Both need refining: **selection is stochastic but value-shaped, and the reward is the *decrease* of `ε_x`, not its level.**

**Why not raw max-error.** Seeking maximal `ε_x` is captured by irreducible noise (the *noisy-TV problem*): `ε_x` = epistemic (reducible by learning) + aleatoric (irreducible); max-error cannot separate them and stalls on static. Raw novelty-seeking is pathological alone.

Three intrinsic objectives, all read off the same world model:

| Objective | Rule | Kills which failure | Neuromod correlate |
|---|---|---|---|
| **Learning progress (LP)** | maximize `−d/dt E[ε_x]` per region | ignores mastered (ε low) *and* unlearnable (ε flat) → peaks at intermediate difficulty; self-organizes a curriculum | ACC/PFC error-rate monitor |
| **Information gain** | maximize expected drop in posterior entropy over `W` | undirected novelty-seeking | NE (explore), ACh (write) |
| **Empowerment** | maximize `I(A;S′)` — reach controllable states | wandering into uncontrollable regions | DA keyed to *self-caused* confirmation (agency) |

Blended intrinsic reward replacing the single DA-novelty term:
`r_int = w₁·LP + w₂·InfoGain + w₃·Empowerment − w₄·cost` — weights plausibly shift **novelty → LP → mastery** developmentally.

**Are kids random?** Stochastic but *structured*: a genuine exploratory prior (motor babbling, spontaneous firing, high-NE softmax temperature) shaped by the above into a heavy-tailed policy that revisits the "Goldilocks" (intermediate-difficulty) zone far more than uniform-random would. Even babbling is non-uniform — *goal babbling* (sample in outcome space, not motor space) matches infant reaching development.

**Why fidgeting with "satisfying mechanisms."** Satisfying ≈ **controllability + residual learnability**: a switch/rattle/kicked-mobile is a high-empowerment locus (`I(A;S′)` high) that is not yet exhausted (LP > 0). Once mastered, LP → 0 and the toy is dropped — matching how kids abandon solved toys. (brainstorm) Fidgeting *is* `ε_x → V(a)` training aimed exactly where the action→effect model is most learnable; empowerment-seeking and vocabulary-learning share substrate. Infant evidence: contingency detection (Watson's "the game"), mobile-conjugate-reinforcement, distress at removed contingency (still-face).

**Net effect on Problem 2.** The loop optimizes error-*reduction* + controllability before any external goal exists — which, unlike raw novelty, cannot be hijacked by aleatoric noise and yields an *automatic curriculum*. Directly relevant to ARC-AGI-3 (latent goal, no in-loop verifier): LP+empowerment is a candidate internal substitute for the missing external verifier (Q6 below). *Ingest candidates to formalize this: Oudeyer & Kaplan 2007 (LP/IAC), Schmidhuber (compression-progress reward), Friston active inference (epistemic value), Klyubin et al. 2005 (empowerment), Gottlieb & Oudeyer 2018 (curiosity neuroscience).*

---

## Fine-tuning: a developmental curriculum (pretrain → imitate → practice)

The exploration loop above is only the *first* phase. It maps onto a three-stage curriculum — the first two proposed by the user (kids exploring, then kids at school), the third added because imitation alone provably caps out.

| Phase | Developmental analog | ML paradigm | Signal | What it updates | Which problem it cheapens |
|---|---|---|---|---|---|
| **1. Explore** | infant sensorimotor play | self-supervised world-model pretraining, curiosity-driven | intrinsic `ε_x` (novelty-as-reward) | `W`, `V(a)` (dynamics & vocabulary) | 1 (vocabulary), partial 2 |
| **2. Imitate** | learning worked examples at school | behavioral cloning / process supervision on human step-by-step traces | supervised `(g, a*, g')` triples + demonstrated endpoint | `V(a)` sharpened; `M`/schema seeded with good paths; `G_goal` revealed | 1, 2, **3 (search short-circuited)** |
| **3. Practice** | homework + exams with an answer key | RL / refinement with a verifier on the agent's *own* rollouts | task reward `ε_r` + verifier | `π`, `G_goal`, corrects off-distribution gaps left by imitation | robustness; **exceeds the teacher** |

### Why demonstration is computationally cheap — mental simulation of Phase 2

A worked example arrives: a teacher's sequence of `(state, action, next-state)` ending in a solved grid. Instead of the Strategist sampling random actions for sparse reward, the demonstration **clamps the trajectory**:

- The teacher's action `a*` is *observed*, so `ε_x` now trains `V(a)` on **correct, densely-labeled** transitions instead of trial-and-error → `V(a)` sharpens fast (**Problem 1 solved cheaply**).
- The Navigator path-integrates along the *demonstrated* `g`-path, writing strong `(g, a*, g')` bindings to `M` — high ACh, because a teacher/attention signal flags the trace as important (Block 2C importance-gated write).
- The demonstration's **endpoint reveals `G_goal`**: the teacher shows what "solved" looks like, so the goal is *supervised*, not inferred from scratch (**Problem 2 short-circuited**).
- The demonstrated sequence is exactly the chain the Strategist would otherwise have had to **search** for. Now it is *given*, so replay only has to **store and generalize** it, not discover it (**Problem 3's search cost collapses to imitation + consolidation**).
- **Offline consolidation** replays the demonstrated traces into schema/`W`. Next time a similar problem appears, `g` snaps to the right position and the path is retrieved in one shot — the demonstrated procedure has become **intuition**. This is the mechanism behind "learn to solve problems intuitively and efficiently later": demonstration → replay → schema caching → single-step System-1 retrieval.

In graph terms: **a worked example supplies the latent path (the sequence of `g`'s) for free**, which is precisely the expensive object the exploration loop must otherwise search for. The data is cheap to produce (record humans solving tasks step-by-step) and its value is disproportionate because it targets the single hardest source of cost.

### Why Phase 2 alone caps out → Phase 3 is required

Two failure modes, both already documented in the wiki, force a third phase:

1. **Covariate shift (compounding error).** Behavioral cloning teaches the human's path *distribution*; the moment the agent deviates, it is off-distribution with no guidance (the DAgger problem). The demonstrated traces cover the teacher's trajectory, not the agent's mistakes.
2. **Self-poisoning / subtle memorization.** Training on ground-truth step-by-step solutions helps (+~10% on MATH), but a model asked to generate its *own* chain-of-thought at test time can *lose* accuracy — self-generated intermediate nodes are unreliable and errors propagate ([[wiki/concepts/abstract-reasoning.md]], MATH 2021). Imitation can also install the technique-without-structural-check shortcut (MATH-Perturb brittleness).

**Phase 3 fixes both by practicing on the agent's own rollouts against a verifier** — the generate→verify→update loop with real task reward ([[wiki/concepts/refinement-loops.md]]). This is the AlphaGo pattern (SFT on human games → RL self-play surpasses them): imitation gives a strong prior; verifier-gated practice corrects the off-distribution blind spots and lets competence exceed the demonstrator. Cobbe et al. 2021's verifier result ([[wiki/papers/verifiers-math-cobbe-2021.md]]) is the quantitative backing: path *evaluation* is a more sample-efficient learning target than path *generation* (30× effective-size multiplier), so a learned verifier is the highest-leverage Phase-3 component.

**Biological reading:** Phase 1 = curiosity-driven exploration (intrinsic DA-novelty). Phase 2 = observational/pedagogical learning (the human trace supplies the intermediate `g`-nodes; consolidation caches them). Phase 3 = deliberate practice with feedback (DA-RPE on real task reward + ACC conflict monitoring), the only phase where the agent generates its own intermediate nodes and *corrects* them against an external check.

**Why the window is long — neoteny** ([[wiki/concepts/neoteny.md]]). The three-phase curriculum is gated by an *extended developmental plasticity window*: the prolonged immature phase **is** the long outer loop, and the biological deferral of synaptic pruning/consolidation (Somel 2009 localizes it to the gray-matter/synaptic slow-W substrate specifically, peaking at adolescent pruning) is the substrate for the "compile System-2 search into System-1 intuition" caching. The design reading is a **graded plasticity taper** that freezes structure *late* rather than early — keeping `W`/schema malleable across all three phases and consolidating only after practice, rather than a uniform slowdown. This also reframes Phase-1's length: the outer loop must run long enough to accumulate the compositional/causal priors Phases 2–3 recombine, and neoteny is the lever that buys that length.

---

## Implications

- **The three "extra" problems of reasoning-vs-navigation are not solved by one mechanism but by a division of labor**: latent vocabulary → inverse path integration (transition error); latent goal → neuromodulatory valence + curiosity bootstrapping; latent path → replay-generated, verifier-scored refinement loop.
- **Dopamine does double duty** (RPE for value + novelty for exploration), so *the same prediction error that builds the world model drives the exploration that discovers the goal*. This single overloaded signal is the cleanest statement of why a goal-free agent can still bootstrap goals — and it is absent from all current architectures (Block 3D gap, ARC-AGI-3).
- **Worked-example imitation targets the single most expensive object** in latent graph discovery — the path — which is why a cheap, manually recordable dataset (human step-by-step traces) has outsized value. But it must be sandwiched between self-supervised pretraining (to have a vocabulary to imitate *in*) and verifier-gated practice (to survive off its own distribution).
- **Extends the building-blocks decomposition** with the missing *dynamics*: [[wiki/queries/building-blocks-mec-hc-pfc.md]] and [[wiki/queries/building-blocks-declarative-subsystem.md]] enumerate the modules; this page specifies the coupled update loop and the training curriculum that drives them.

---

## Follow-up questions (including the three caveats on the underlying theory)

1. **Completion needs a separator.** Generalizing completion ("likely x at g") must be balanced by DG pattern separation (sparse 2–6% codes), or distinct episodes collapse into aliasing (hardness source 3) and "never reset M" becomes catastrophic interference. Cross-environment persistence is really *consolidation into mPFC schema slow-W*, not raw `M` persistence. What is the right completion/separation set-point, and is it neuromodulator-gated (NE in DG)?
2. **Not fully random at init.** "Everything fires randomly at first" overstates it: the grid manifold, Core Knowledge priors, and reward machinery are *priors*; only instance bindings (`M`) and the goal start random. Fully-random dual init hits sample-inefficiency *and* the spurious-edge trap (random exploration + reward locks in false edges, source 5). What is the minimal prior scaffold that makes the coupled loop tractable?
3. **Hormones don't encode goals — they supply the teaching signal.** DA/5-HT carry scalar valence/RPE + exploration/horizon, not the *structure* of a goal. Abstract goals are learned secondary reinforcers chained by TD up the PFC rostro-caudal hierarchy. The load-bearing mechanism for latent goals is intrinsic motivation (prediction-error-as-reward), which is what closes the loop with caveat-free Problem 2.
4. **Curriculum ordering and mixing.** Is strict staging (explore → imitate → practice) optimal, or should the three signals be interleaved (as in humans)? Does Phase-2 imitation data need to be *in the agent's own vocabulary* (`V(a)` from Phase 1) to be usable, or can demonstrations bootstrap vocabulary directly?
5. **Verifier availability.** Phase 3 needs a verifier; ARC-AGI-3's latent goal means no in-loop verifier exists. Can the Phase-1 intrinsic-motivation signal (curiosity) substitute for an external verifier in Phase 3, or does self-generated reward reintroduce reward-hacking?
6. **Region provenance (chicken-egg).** Learning progress is defined *per region/skill*, but the regions are exactly the latent-graph partition the agent is still discovering. How is the partition whose LP is tracked bootstrapped before `W` exists? And what is the cheap neural approximation to empowerment `I(A;S′)` (channel capacity is expensive) — a variational bound, or just a count of reliably-reachable next-states?

---

## See also
- [[wiki/concepts/path-integration.md]] — the Navigator's update rule, generalized from space to operator graphs.
- [[wiki/concepts/prospective-coding.md]] — the one-step→multi-step look-ahead that makes each candidate sequence simulable.
- [[wiki/concepts/refinement-loops.md]] — the generate→verify→update loop that the Strategist's replay-sample-evaluate cycle instantiates.
- [[wiki/concepts/neuromodulation.md]] — the DA/5-HT/ACh/NE gains; DA's dual role; ACh storage/retrieval switch.
- [[wiki/queries/building-blocks-mec-hc-pfc.md]] / [[wiki/queries/building-blocks-declarative-subsystem.md]] — the module inventory this loop drives.
</content>
</invoke>
