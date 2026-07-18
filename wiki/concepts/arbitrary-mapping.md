---
title: "Arbitrary Mapping (Conditional Motor Learning)"
type: concept
tags: [arbitrary-mapping, action-semantics, conditional-motor-learning, vocabulary-co-discovery, contextual-inference, premotor, two-learning-timescales]
created: 2026-07-17
updated: 2026-07-17
sources: [Arbitrary associations between antecedents and actions, Role of prefrontal cortex in a network for arbitrary, Frontal Networks for Learning and Executing Arbitrary Stimulus-Response Associations, Learning by neural reassociation]
related: [wiki/concepts/contextual-inference.md, wiki/papers/murray-bussey-wise-pfc-arbitrary-mapping-2000.md, wiki/concepts/working-memory.md, wiki/papers/heald-coin-contextual-inference-2021.md, wiki/papers/golub-neural-reassociation-2018.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/memory-schemas.md, wiki/concepts/neural-manifolds.md, wiki/concepts/meta-learning.md, wiki/concepts/representational-geometry.md, wiki/concepts/cognitive-control.md, wiki/entities/prefrontal-cortex.md, wiki/entities/basal-ganglia.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/arc-agi.md, wiki/queries/action-semantics-contextual-inference.md, wiki/papers/wise-murray-arbitrary-mapping-2000.md, wiki/papers/boettiger-desposito-sr-rule-learning-2005.md, wiki/papers/frontal-cortex-abstract-rules-badre2010.md, wiki/architectural-gaps.md]
---

# Arbitrary Mapping (Conditional Motor Learning)

**An antecedent maps onto a consequent by convention alone: the cue's identity and location neither constrain nor determine the action it selects.** This is the biological form of the problem that an action index (ARC-AGI-3's ACTION1–5, a keyboard button) carries no intrinsic content — its effect must be bound, not derived.

---

## The Mapping Taxonomy

| Type | Relation of cue to action | Constraint on action choice |
|---|---|---|
| **Standard** | Cue *is* the target of action | Fully determined by cue location |
| **Transformational** | Cue location is input to an algorithm (tennis: aim at opponent's backhand) | Determined up to the algorithm |
| **Arbitrary (nonstandard)** | No natural relation (red light → brake) | **None** — any action in the repertoire may bind to any cue |

Only the third type frees action selection from spatial information. That liberation is the whole point: it permits *any* action already in the repertoire to be selected by *any* input, so the choice can be made on **prevailing context** rather than geometry (Passingham). Wise & Murray argue the same arbitrariness underlies the sound–meaning arbitrariness of words ("the word 'pig' is not porcine"), making arbitrary mapping a plausible preadaptation to language.

---

## The Circuit — an Asymmetric Dissociation

| Lesion | Novel mappings | Pre-lesion mappings | Reading |
|---|---|---|---|
| **Hippocampal system** (incl. fornix) | Severely impaired | **Spared** | Needed to *acquire*, not to *express* |
| **PMd** (dorsal premotor) | Impaired | **Also impaired** | The executor for both — not a retention-only store |
| **PFdl** / uncinate fascicle cut (IT→PF) | Impaired | — | General arbitrary-mapping engine |
| **BG→thalamus→frontal** | Impaired | — | Early-phase contribution |

**This is not a double dissociation.** The acquisition/retention split is *hippocampus-specific*: HC drops out once a mapping is overlearned, but premotor cortex is required throughout. The spared pre-lesion mappings also prove the deficit is not perceptual or motor — the same monkeys still discriminate the cues and make the movements.

The HC-lesion result unintentionally reproduced **H.M.**'s amnesia in monkeys — spared old knowledge, spared skill learning, profound failure to acquire new knowledge — after two or three decades of deliberate attempts had failed.

**PFC is the general engine; the rest is specialized.** Premotor is necessary for visuo*motor* but not visuo*visual* mapping; HC may serve visuo*spatial* but not visuovisual. PFC lesions impair both — only PFC has cue *and* action *and* outcome information converging (Passingham).

---

## Three Levels: Mappings, Rules, Strategies

Murray, Bussey & Wise 2000 ([[wiki/papers/murray-bussey-wise-pfc-arbitrary-mapping-2000.md]]) decompose the task into three separable abilities and assign each to the network by lesion. This is the structure the single-`v`-per-action framing misses entirely.

| Level | What it is | Example | Lost after |
|---|---|---|---|
| **Lower-order rule** (= exemplar, = specific mapping) | One cue → one action, by convention | red square → leftward joystick | PM, BG output, PFv+o (novel); HS (novel only) |
| **Higher-order rule** | The abstraction *over* exemplars — what *kind* of information instructs action | "nonspatial visual features instruct the action" | PFv+o |
| **Strategy** | A plan for solving the *problem*, not a mapping at all | Repeat-Stay/Change-Shift | PFv+o (**spared by HS lesions**) |

**The lesion matrix** (Table 1 — monkeys):

| Lesion | Higher-order rules & strategies | Familiar mappings | Novel mappings |
|---|---|---|---|
| **PFv+o** (ventral + orbital PF) | **Lost** | Partially preserved; relearned across sessions | **Lost** |
| **PFdl** | ? | Preserved | Partially disrupted |
| **PM** | ? | **Lost** | **Lost** |
| **BG output** (via thalamus) | ? | **Lost** | Presumably lost |
| **HS** | **Preserved** | Preserved | Severely disrupted |

**Higher-order rules are not necessary for lower-order ones — the authors say so themselves.** Each exemplar "could be learned, one by one, without ever encoding the general rule that nonspatial visual information always provided the critical signal." So rule loss cannot explain the PFv+o deficit; the hierarchy buys **speed and efficiency**, not capability. This is a caveat the wiki's Badre-flavoured hierarchy story ([[wiki/papers/frontal-cortex-abstract-rules-badre2010.md]]) does not otherwise carry: an abstraction hierarchy is a *learning accelerator*, and an architecture without one should be slow, not incapable.

### Strategy: the level above `v`

The **Repeat-Stay/Change-Shift** strategy is the concrete instance, and it is not a mapping — it is a policy over *trial history*: if the instruction stimulus repeats, repeat the response; if it changes, shift. In a three-choice task this **solves repeat trials completely** and reduces change trials to a two-choice problem, cutting initial error from 67% → 33%.

The dissociation is the load-bearing part: **HS-lesioned monkeys keep applying RS/CS** while failing to learn new mappings; **PFv+o lesions abolish the strategy** *and* the learning. So strategy is stored where rules are (PF cortical-BG modules), not where novel bindings are acquired (HS).

But the arithmetic constrains how much it explains: perfect RS/CS predicts ~67% initial errors after a PFv+o lesion, which is what was observed — yet it does **not** explain why the reinforced mappings were not learned *at all* over 50 trials. Strategy loss and mapping loss are additive deficits, not one deficit seen twice.

**Design consequence.** A strategy is what makes a fresh alphabet cheap *before* any binding exists — it exploits the task's *structure over trials* rather than the cue→action content. An agent that infers `v_a` per action but has no RS/CS-like layer is paying full price for information the trial sequence gives away free. See [[wiki/concepts/meta-learning.md]] — RS/CS is a learned inner-loop policy, and the fact that it is *lesionable separately from the mappings it accelerates* is the biological argument for making it a distinct component.

**A methodological warning aimed at this literature's own evidence.** Only a task with **three or more** responses can dissociate strategy use from mapping acquisition — with two choices, RS/CS alone solves the problem, so intact performance is not evidence of learning. Every rat study reviewed used two choices, and the authors offer this as a candidate explanation for the discrepant rat HC results they otherwise cannot reconcile. Filed in [[wiki/empirical-tensions.md]].

---

## Cortical-BG Modules: What the Repertoire Is Made Of

The architectural frame (Houk & Wise 1995, adopted by Murray, Bussey & Wise): the unit of computation is a **recurrent cortex → BG → thalamus → cortex loop**, and each cortical area participates in a **large number of such modules operating largely in parallel**.

| Module family | Contents |
|---|---|
| **PM cortical-BG modules** | Specific object→action mappings (exemplars) |
| **PF cortical-BG modules** | The same specific mappings **plus** higher-order rules and strategies |

**The split is not "PF abstracts, PM executes."** PF has higher-order functions *in addition to* its lower-order ones — which is why removing PFv+o eliminates both at once, and why the deficit is more than the sum of a rule deficit and a strategy deficit.

**(brainstorm)** This is a concrete proposal for what an operator bank physically *is*: not one store, but many parallel loops, each holding a candidate mapping, with abstraction implemented as *some loops holding rules over other loops' contents* rather than as a separate hierarchical module. It is the anatomical shape MOSAIC's *N* paired modules assume, arrived at from lesion data three years before COIN's ancestor was published.

### The disconnection hypothesis: PF as a route, not only a store

PFv+o may support arbitrary mapping by **either or both** of two mechanisms, which the authors are explicit are not mutually exclusive:

1. **Store** — computing and holding the mappings within its own cortical-BG modules.
2. **Route** — carrying object-vision information from IT to PM. IT (area TE + perirhinal) supplies most of the frontal lobe's object input and **does not project directly to PM**; PFv+o is the relay. A PFv+o lesion therefore severs IT→PM whether or not PFv+o stores anything.

The evidence that the store account is insufficient: **PF cannot support learning without PMd.** Conversely, PM lesions may deprive PF of information about what movement was just made — blocking exemplar encoding *and* the extraction of higher-order rules from those exemplars.

**This converges on the coupling result from a different method.** Boettiger & D'Esposito found dlPFC↔SMA *correlation* explains 63% of variance in human learning while neither region's activity does; lesion anatomy here says PFv+o may matter partly *as a wire*. Two methods, two decades apart, both pointing at the interface rather than the endpoints — which is an argument for treating the inferrer↔repertoire channel as an explicit, measurable component rather than a tensor hand-off.

---

## Not a Working-Memory Deficit

The authors explicitly dismiss the WM interpretation of the PFv+o mapping deficit, and the argument is unusually clean:

- **The stimulus never left the screen.** In the key experiment the instruction stimulus was present throughout choice *and* execution — storage and manipulation demands were minimal — yet the deficit was profound.
- **PFv is not needed for storage.** Rushworth et al. 1997: monkeys with PFv removals held visual stimuli for up to 8s in delayed matching-to-sample.
- **Perseveration is also ruled out.** Post-lesion, a previously emitted incorrect response was no more likely than any *other* alternative response, and no tendency to repeat a rewarded response on change trials was found.

The authors' conclusion is stronger than a local one: this "falsifies the widely promoted hypothesis that the sole specialized function of PF, as a whole, is the mediation of working memory." See [[wiki/concepts/working-memory.md]].

---

## The Human Extension: Categorical Mappings, and Acquisition vs. Execution Within One Task

Boettiger & D'Esposito 2005 ([[wiki/papers/boettiger-desposito-sr-rule-learning-2005.md]]) run the human fMRI counterpart, with two changes that matter: the mapping is **categorical** (a *set* of 10 stimuli sharing a latent covarying-element rule → one button, not one cue → one action), and acquisition and execution are contrasted **within one task**, with stimulus statistics and motor actions matched.

| Contrast | Regions | Reading |
|---|---|---|
| **novel > familiar** | right dlPFC (MFG), SMA/pre-SMA, left ventral premotor, right caudate | binding a fresh alphabet |
| **familiar > novel** | left rostral dorsal premotor (SFG), frontopolar, rostral ACC | expressing a bound one |

Two results carry design weight beyond the anatomy:

- **The regions track learnable structure, not surprise.** A covert **no-rule** condition matched novelty, uncertainty, and error rate while removing any latent rule; all four learning regions were *less* active for it than for the learnable-novel condition. Uncertainty alone does not engage the binding circuit — the presence of an inferable regularity does.
- **Humans over-split.** On no-rule blocks subjects scored **below chance (35%)**, worse than the 50% available from ignoring the stimuli entirely, because they persisted in hypothesis-testing a rule that did not exist. Fast binding of arbitrary alphabets is bought at the price of a strong structure prior that misfires — the false-split cost is measured, not hypothetical (see [[wiki/concepts/contextual-inference.md]]).

**Only higher-order mappings recruit dlPFC.** Earlier human imaging of 1:1 mappings found no reliable dlPFC involvement, contradicting the lesion and monkey-physiology literature; the categorical design recovers it. Arbitrary mapping engages the PFC hierarchy *in proportion to how much lower-order structure the rule compresses* — which is why this result sits directly upstream of Badre 2010's policy-abstraction hierarchy ([[wiki/papers/frontal-cortex-abstract-rules-badre2010.md]]).

**Coupling, not activation, is the bottleneck.** Block-wise dlPFC↔SMA correlation explains **63%** of between-subject variance in accuracy. **(brainstorm)** If SMA/pre-SMA carries the candidate-mapping bank and dlPFC computes which candidate the evidence supports, then what predicts learning is the *bandwidth between inferrer and repertoire*, not the capacity of either — an argument for making that interface an explicit, measurable component rather than an implicit tensor hand-off.

---

## Quantitative Binding Rate

The number to design against, from four rhesus monkeys learning **24 new mappings per day**:

| Exposure | Performance |
|---|---|
| ~10 trials (≈3 trials/cue) | Substantial learning |
| ~25 trials (≈8 trials/cue) | <10% error; some monkeys near-perfect thereafter |

Fast binding of a fresh arbitrary alphabet is *routine* for an experienced brain — but it costs a few trials per symbol, not one. Any claim that a novel action's semantics are inferred from a single observation overstates the biology.

**This number does not survive contact with the BCI literature.** Golub et al. 2018 ([[wiki/papers/golub-neural-reassociation-2018.md]]) re-bind an action→outcome map *within* the intrinsic manifold and it takes **600–870 trials over 1–2 hours** — two orders of magnitude off ~3 trials/cue, for what both literatures describe as fast re-binding inside an existing repertoire. **(brainstorm)** The most likely reconciler is that the two paradigms differ in whether a *pointer exists*: Wise & Murray's monkey is handed a discrete cue and must find its consequent, so there is a slot to bind into and the search is over a small labelled set; Golub's monkey is handed no cue at all — the perturbation is silent, and the animal must discover both that semantics changed and what they changed to, by acting. If that is right, the ~3-trials/cue rate is the cost of *binding given a pointer*, and the BCI number is the cost of *binding without one* — which would make the discrete action index of ARC-AGI-3 the favourable case rather than the hard one. Filed in [[wiki/empirical-tensions.md]]; untested, and the paradigms differ on enough other axes (effector, novelty of the mapping *type*, feedback density) that this is one candidate among several.

---

## Neural Signatures

- **The mapping is the represented variable.** During the delay, ~50% of PFC neurons code the specific cue×action *combination* — more than code the cue (~30%) or the action direction (~20%) alone (Miller). Conjunctive/mixed selectivity is the format of an arbitrary binding; see [[wiki/concepts/representational-geometry.md]].
- **Two intermingled learning signals** in SEF/premotor: *learning-dependent* activity **rises** with learning; *learning-selective* activity **falls**, often to silence. The population vector's predicted direction converges on the correct response as learning proceeds.
- **Sparse vs. dense (tentative).** HC learning-related changes are weak (a few spikes/s) and predominantly learning-*selective*; premotor changes are robust and learning-*dependent*. Wise & Murray speculate this reflects a sparsely coded network vs. a densely coded one — and it matches HC's time-limited role.
- **Striatum is an early-phase, post-cue module.** ~30% of striatal neurons differentiate novel from familiar mappings; learning-related change concentrates immediately after the *cue* rather than at other task events — a special role in the earliest phase of a structured event sequence.
- **The two signals dissociate by region in humans, and only one decays.** dlPFC and SMA decline as accuracy rises and go quiet once the rule is acquired; ventral premotor and striatum are equally learning-selective but **do not decay** (striatum trends upward, matching monkey recordings). So "activity falls with learning" is not a property of the binding circuit as a whole — it separates the inferring side, which disengages, from the executing/valuating side, which does not (Boettiger & D'Esposito 2005).

---

## Why This Matters for a Reasoning Model

1. **The action index is a pointer.** Biology never derives an action's effect from the cue; it binds them by convention and stores the *conjunction*. A trained `action → effect` function is the wrong type — see [[wiki/queries/action-semantics-contextual-inference.md]].
2. **Fast binding and slow execution are different circuits.** The W/M split ([[wiki/concepts/two-learning-timescales.md]]) appears here in its action-semantics form — but with the asymmetry above: fast M is what drops out, not what the executor is made of.
3. **Rebinding is cheap, inventing is not.** ~3 trials/cue to bind a *known* action to a *new* cue. This is selection within an existing repertoire, which is exactly the boundary Gap #3 runs into.
4. **Strategy is a separate, separately-lesionable layer.** RS/CS exploits structure *over trials* rather than cue→action content, and survives the lesion that destroys new binding. An agent inferring `v_a` per action without an equivalent layer pays full price for information the trial sequence gives away.
5. **The interface may be the component.** PFv+o's contribution may be partly *as a route* (IT→PM), not only as a store — converging with the human 63%-coupling result on the inferrer↔repertoire channel being where the capacity actually lives.
6. **Consolidation runs on all three levels at once.** HS holds mappings, rules, *and* strategies in the intermediate term pending transfer to frontal cortical-BG modules — so a fast store binding only `action → v` is holding one of the three things biology puts there.

---

## Open Problems

- The visuomotor / visuospatial / visuovisual decomposition "has yet to be explored systematically" — which parts of the network are general arbitrary mappers vs. consequent-type-specific is unresolved.
- **Store vs. route is unresolved for PFv+o**, and the authors decline to choose (the two mechanisms "are not mutually exclusive"). Nothing in the lesion data separates "PFv+o holds the mappings" from "PFv+o carries IT's output to the modules that hold them" — and the design consequences differ sharply: a store is a component, a route is an interface.
- **What sets the strategy/mapping division of labour?** RS/CS is spared by HS lesions and abolished by PFv+o, but nothing explains *why* a strategy consolidates into PF modules while a novel mapping needs HS first — both are new information acquired within a session.
- **The three-choice methodology point has not been acted on.** The authors call for three-choice designs and explicit strategy evaluation to disambiguate the rat literature; the wiki has no source indicating this was done.
- The sparse/dense coding explanation for the HC-vs-premotor effect-size gap is speculation; the studies differ enough in design to preclude direct comparison.
- Cerebellar involvement is reported in humans, disputed in monkeys.
- What *sets* the ~3-trials-per-cue rate? Nothing in the account explains why binding is that fast and not faster or slower. **(brainstorm)** [[wiki/concepts/contextual-inference.md]] offers a candidate shape for the answer: if updating is scaled by responsibility, a *fresh* cue starts with responsibility spread across candidate contexts, so the first trials produce fractional updates and the rate is set by how fast the posterior concentrates — not by a plasticity constant. Untested here; COIN was never fit to conditional-motor-learning data.

---

## Connections

- **[[wiki/concepts/contextual-inference.md]]** — the computational theory this concept lacks. Wise & Murray describe *that* an arbitrary binding is acquired and where; contextual inference specifies *how* the live binding is selected (a posterior over contexts) and why all candidate mappings update in proportion to responsibility rather than winner-take-all — which is a mechanism for the graded, few-trials-per-cue acquisition measured here.
- **[[wiki/queries/action-semantics-contextual-inference.md]]** — this concept is the biological task that query is about; arbitrary mapping supplies the lesion/physiology evidence that action effects are bound rather than derived, which is why `action_to_v` is the wrong type signature.
- **[[wiki/concepts/two-learning-timescales.md]]** — the HC-acquires/premotor-executes result is the W/M split applied to action semantics, in an asymmetric form: HC is required only while the mapping is new, but premotor is required always, so "fast M vs. slow W" maps onto *which circuit drops out*, not onto acquisition vs. execution roles.
- **[[wiki/entities/prefrontal-cortex.md]]** — PFC is the general arbitrary-mapping engine (only region with cue + action + outcome convergence); its ~50% cue×action conjunctive neurons are where the binding physically lives.
- **[[wiki/entities/basal-ganglia.md]]** — striatum contributes at the earliest phase of the mapping (novel-vs-familiar differentiation concentrated immediately post-cue), consistent with its RL-gate role in installing new cortical rule representations.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — HC is required to acquire novel arbitrary mappings but not to express overlearned ones; its weak, learning-selective activity changes fit the sparse-coding/time-limited-role account of HC's contribution.
- **[[wiki/concepts/representational-geometry.md]]** — the ~50% cue×action conjunctive PFC population is a mixed-selectivity code; an arbitrary binding has no lower-dimensional structure to exploit, so conjunctive coding is the only available format.
- **[[wiki/concepts/neural-manifolds.md]]** — the ~3-trials-per-cue rate applies to rebinding *within* an existing repertoire; the BCI intrinsic-manifold constraint is the same boundary seen from the other side (fast inside the manifold; outside it, not learned in a session and never shown to be learnable at all — the "days" figure the wiki previously carried was Sadtler's authors' proposal, not their result) — except that the two literatures' rebinding rates differ by ~100×, which is the open tension.
- **[[wiki/papers/golub-neural-reassociation-2018.md]]** — the BCI counterpart of this concept's central claim: re-binding is re-association within a preserved repertoire, shown directly in population activity. Supplies the conflicting rate (hundreds of trials) and, via the cross-pointer recruitment result, the strongest physiological evidence that intent→pattern bindings are re-shuffled rather than pruned.
- **[[wiki/concepts/latent-graph-discovery.md]]** — arbitrary mapping is the edge-label half of the problem: the graph's action alphabet is bound by convention per environment while the structure is shared, which is why vocabulary and structure must be discovered together.
- **[[wiki/entities/arc-agi.md]]** — ARC-AGI-3's ACTION1–5 are literal arbitrary mappings: a fixed set of content-free pointers whose semantics are re-bound per game.
- **[[wiki/papers/wise-murray-arbitrary-mapping-2000.md]]** — source review for the taxonomy, the lesion dissociations, the trials-per-cue rate, and the single-neuron learning signatures.
- **[[wiki/papers/murray-bussey-wise-pfc-arbitrary-mapping-2000.md]]** — the companion review and source for everything above that the *TINS* paper omits: the cortical-BG module architecture, the three-level mappings/rules/strategies decomposition and its lesion matrix, the Repeat-Stay/Change-Shift dissociation, the disconnection hypothesis, and the working-memory falsification.
- **[[wiki/concepts/working-memory.md]]** — this concept supplies a *negative* constraint on that one: the PFv+o mapping deficit occurs with the instruction stimulus on-screen throughout and with PFv-lesioned monkeys able to hold stimuli for 8s, which is why "PF = WM" cannot be the whole account of prefrontal function.
- **[[wiki/concepts/meta-learning.md]]** — Repeat-Stay/Change-Shift is a biological inner-loop policy: a learned plan for exploiting trial structure that accelerates mapping acquisition without being a mapping, and that lesions separate from the mappings it accelerates.
- **[[wiki/papers/boettiger-desposito-sr-rule-learning-2005.md]]** — source for the human categorical extension: the within-task acquisition/execution circuit split, the no-rule control showing these regions track learnable structure rather than uncertainty, the below-chance false-split cost, and the 63%-of-variance dlPFC–SMA coupling result.
- **[[wiki/papers/frontal-cortex-abstract-rules-badre2010.md]]** — the hierarchy result this concept feeds into: dlPFC engages only when the mapping is *categorical* (compressing many lower-order bindings), which is Badre's policy-abstraction claim stated in arbitrary-mapping terms — an arbitrary alphabet is bound at whatever level of the frontal hierarchy its structure lives at.
- **[[wiki/concepts/cognitive-control.md]]** — SMA/pre-SMA's role as the bank of contextually appropriate candidate mappings, biased by dlPFC, is the arbitrary-mapping instance of goal-maintenance-as-top-down-bias.
