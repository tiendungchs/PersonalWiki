---
title: "Contextual Inference"
type: concept
tags: [contextual-inference, action-semantics, nonparametric-bayes, vocabulary-co-discovery, motor-learning, two-learning-timescales, memory-schemas]
created: 2026-07-17
updated: 2026-07-17
sources: [Contextual inference underlies the learning of sensorimotor repertoires, Frontal Networks for Learning and Executing Arbitrary Stimulus-Response Associations, Learning by neural reassociation, Neural constraints on learning]
related: [wiki/papers/sadtler-neural-constraints-learning-2014.md, wiki/papers/golub-neural-reassociation-2018.md, wiki/concepts/arbitrary-mapping.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/memory-schemas.md, wiki/concepts/working-memory.md, wiki/concepts/neural-manifolds.md, wiki/concepts/meta-learning.md, wiki/concepts/latent-states.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/neuromodulation.md, wiki/entities/arc-agi.md, wiki/entities/prefrontal-cortex.md, wiki/papers/heald-coin-contextual-inference-2021.md, wiki/papers/boettiger-desposito-sr-rule-learning-2005.md, wiki/queries/action-semantics-contextual-inference.md, wiki/architectural-gaps.md, wiki/papers/collins-frank-cts-task-set-2013.md, wiki/entities/basal-ganglia.md]
---

# Contextual Inference

**Memory creation, expression, and updating are all controlled by one computation: inferring a posterior over which context is currently active.** The learner never holds "what action A does" — it holds a *repertoire* of context-conditioned models and a belief about which one applies now.

---

## The Generative Model (COIN)

| Variable | Form | Role |
|---|---|---|
| Context $c_t \in \{1..\infty\}$ | sticky HDP Markov chain | which regime is active; unlabelled, must be inferred |
| State $x_t^{(j)}$ | $x_{t+1}^{(j)} = a^{(j)}x_t^{(j)} + d^{(j)} + \epsilon$ | context $j$'s own action→outcome model |
| Cue $q_t$ | $p(q_t \mid c_t) = \Phi_{c_t}$ | pre-movement evidence (appearance, style) |
| Feedback $y_t$ | $y_t \sim \mathcal{N}(x_t^{(c_t)}, \sigma^2)$ | post-movement evidence |

Hierarchical Dirichlet-process priors on transitions **Π** and cues **Φ** make the repertoire *unbounded*: a new context is instantiated when the novel-context responsibility is high. The hierarchy matters — a shared global $\boldsymbol\beta$ lets transition knowledge learned in one context generalize to all others, and initializes a brand-new context's transitions immediately.

**Two posteriors, computed at different moments:**
- **Predicted probability** $p(c_t \mid q_t, \ldots)$ — after the cue, *before* moving → gates **expression**.
- **Responsibility** $p(c_t \mid q_t, y_t, \ldots)$ — after feedback → gates **creation** and **updating**.

**Output is a mixture, not a selection:** $u_t = \sum_j p(c_t{=}j \mid q_t,\ldots)\,\hat{x}_t^{(j)}$.

**All memories update, scaled by responsibility:**
$$\Delta \hat{x}^{(j)} \;\propto\; \underbrace{p(c_t{=}j \mid q_t, y_t, \ldots)}_{\text{responsibility}} \times \underbrace{k_t^{(j)}}_{\text{Kalman gain}} \times \underbrace{\varepsilon_t^{(j)}}_{\text{prediction error}}$$

---

## Proper vs. Apparent Learning — the load-bearing distinction

| | **Proper learning** | **Apparent learning** |
|---|---|---|
| What changes | the memories (states $\hat{x}^{(j)}$) | only the context posterior |
| Weight update | yes | **none** |
| ML analog | gradient step | change in mixture weights at inference time |

Behaviour changes via *either* route. Heald et al. show that **savings, anterograde interference, and environmental-consistency effects — long read as learning-rate changes — are apparent**: across parameter-free cross-validated simulations, Kalman gain and inferred state are unchanged between conditions; only the context posterior differs.

**(brainstorm) The ML consequence:** an observed "faster learning" is not evidence of a learning-rate change. A system with a fixed repertoire and *zero* plasticity can display savings, interference, and consistency effects purely by re-weighting. Benchmarks that infer learning rate from behavioural adaptation curves are confounded.

**A candidate discriminator, from outside the behavioural data.** COIN's split is defined behaviourally and is therefore hard to falsify from adaptation curves alone. Boettiger & D'Esposito 2005 ([[wiki/papers/boettiger-desposito-sr-rule-learning-2005.md]]) supply an asymmetry that behaviour cannot show: while humans acquire a genuinely new arbitrary rule, dlPFC and SMA activity **decays** as accuracy rises and correlates inversely with it, while ventral premotor and striatum are equally learning-selective and **do not decay**. **(brainstorm)** If proper learning is happening, the module computing the posterior should disengage once the posterior has concentrated, while the modules holding and valuing the repertoire should not — so *selective* disengagement of the inference side is a signature that something was written, whereas pure re-weighting predicts no such handoff. Untested as a discriminator; the two literatures have never been run against each other, and BOLD decay has confounds (habituation, time-on-task) this design controls for only partially.

**A population-level instance of the fixed-repertoire regime.** Golub et al. 2018 ([[wiki/papers/golub-neural-reassociation-2018.md]]) perturb a BCI's action→outcome map and find that M1's **repertoire of activity patterns is preserved** across learning; what changes is which movement intent each pattern is bound to (*Reassociation*). Optimal *Realignment* and gain-*Rescaling* — both of which require new patterns — are refuted, as is *Subselection*: after learning a movement recruits patterns that had belonged to *other* movements. This is behaviour changing by re-binding within a fixed set, measured directly in neural population activity rather than inferred from an adaptation curve — the closest thing the wiki has to a physiological picture of expression-side change. **(brainstorm)** It is not literally COIN's apparent learning: the intent→pattern association *is* rewritten, so something was written; the constancy is of the *repertoire* (COIN's set of context-specific models), not of the posterior. The correspondence to preserve is **repertoire-preserved / binding-rewritten**, which is a third case beside COIN's proper-vs-apparent pair, and it is what makes the repertoire an observable object rather than a modelling posit.

The same study's **no-rule** control constrains what drives the inference side at all: blocks matched on novelty, uncertainty, and error rate but containing no latent rule engaged these regions *less* than learnable ones. Contextual inference is not driven by prediction error magnitude — consistent with COIN's abruptness-not-magnitude creation trigger, and converging on it from an independent direction.

---

## What a Model Must Have (condensed from COIN's rival comparison)

Each row is a missing feature that provably breaks a class of models — a design checklist, not motor-learning trivia:

| Missing feature | Consequence |
|---|---|
| No context concept (single-context: dual-rate, memory-of-errors) | cannot switch memories → no evoked recovery; savings needs an ad-hoc learning-rate dial |
| No **learned transition probabilities** | no spontaneous recovery, no anterograde interference, no consistency effect |
| No **state dynamics** (e.g. MOSAIC) | no spontaneous or evoked recovery — memories must be able to decay |
| No **cue** channel | cannot compute graded updates from pre-action evidence |
| **All-or-none** updating (winner-take-all) | contradicts measured graded single-trial learning |

The joint requirement — contexts *and* learned transitions *and* state dynamics *and* cues *and* graded updates — is why COIN is the only model in its table that covers all seven phenomena.

---

## Instantiations & Adjacent Evidence

| System | Contextual-inference content |
|---|---|
| **COIN** ([[wiki/papers/heald-coin-contextual-inference-2021.md]]) | the normative theory; HDP repertoire growth |
| **MOSAIC** (Haruno/Wolpert/Kawato 2001) | mechanistic ancestor: responsibility = softmax over each module's forward-model error; a *responsibility predictor* estimates context from cues before acting. Lacks state dynamics |
| **C-TS** ([[wiki/papers/collins-frank-cts-task-set-2013.md]]) | cognitive-control-side ancestor: same Dirichlet/CRP context→latent-state clustering (reuse ∝ popularity vs. create ∝ α), but over task-sets (S-A-outcome rules) rather than sensorimotor states; adds a **corticostriatal neural implementation** (nested PFC-BG / PMC-BG loops) COIN lacks. Single-particle MAP collapse, no cue channel, no continuous state dynamics |
| **Human frontal circuit** ([[wiki/papers/boettiger-desposito-sr-rule-learning-2005.md]]) | (brainstorm) the closest anatomical candidate for MOSAIC's parts: SMA/pre-SMA holds the bank of candidate S-R mappings, dlPFC accumulates outcomes and biases which candidate is expressed, striatum carries the feedback signal. Coupling between the first two — not the activity of either — explains 63% of variance in learning success |
| **Arbitrary mapping** ([[wiki/concepts/arbitrary-mapping.md]]) | the biological task COIN's contexts abstract; supplies the ~3-trials/cue binding rate |
| **Memory schemas** ([[wiki/concepts/memory-schemas.md]]) | assimilate = update an existing context; accommodate = instantiate a novel one |

---

## Open Problems

- **The concentration parameter is unfit.** γ (effective number of contexts) was *fixed at 0.1 by hand*. This is the false-split/false-merge dial — the single hyperparameter that decides "new operator" vs. "noisy instance of a known one" — and the paper does not learn it. α and ρ also recover poorly from synthetic data. **Human data says the dial is set aggressively, and that this is costly:** given blocks that covertly contained *no* rule, subjects scored **below chance (35%)** — worse than the 50% obtainable by ignoring the stimuli — because they kept positing structure that did not exist (Boettiger & D'Esposito 2005, [[wiki/papers/boettiger-desposito-sr-rule-learning-2005.md]]). **(brainstorm)** The biological setting is not the one that minimizes regret on a per-environment basis; it is tuned for a world in which latent structure is usually present, and it pays for that prior when it is not. A system whose γ is fit to average-case performance would likely land on a *less* eager value than the brain's — so matching human binding speed and matching human calibration may be different targets. **Third converging line:** Collins & Frank 2013 ([[wiki/papers/collins-frank-cts-task-set-2013.md]]) show humans *incidentally* build task-set structure on a flat problem that neither needs nor benefits from it, incurring **negative transfer** when a new context overlaps old task-sets — over-splitting/over-structuring is default-on in the cognitive domain too, with the same α (= COIN's γ) as the create-vs-reuse dial.
- **Selection, not invention.** The repertoire grows by instantiating contexts *from the generative family the model already assumes*. An operator outside that family is unreachable — the same wall [[wiki/concepts/neural-manifolds.md]] documents from the BCI side (fast rebinding inside the intrinsic manifold; **outside it, not learned in a session and no upper bound established** — Sadtler et al. 2014, [[wiki/papers/sadtler-neural-constraints-learning-2014.md]]; the "days" figure this page previously carried was the authors' proposal, not their result). **Golub 2018 makes the wall closer than "outside the manifold":** in *within*-manifold perturbations, where every pattern needed for optimal performance was already reachable, useful, and incentivized, monkeys still did not produce novel patterns within 1–2 hours. So the biological repertoire does not even freely populate its own reachable set on the fast timescale. If COIN's HDP is read as a model of what actually grows quickly, its unbounded repertoire is too permissive: the data show growth is the *slow* path (days–weeks, proposed) and re-binding is the *only* fast one.
- **Nothing bounds the repertoire in the model.** Related but distinct: COIN's context set is unbounded a priori and grown by the CRP; Golub's is fixed and small on the timescale where all the adaptation happens. No account reconciles "unbounded and growable" with "measurably preserved under pressure" — the γ dial governs *when* to grow, not *whether growth is available at all*, and the physiology says it largely is not.
- **Abruptness, not magnitude, triggers creation.** A gradually introduced perturbation creates *no* new memory — the existing one absorbs it. So the creation trigger is sensitive to the *rate* of evidence arrival, not just its size: an adversary could suppress repertoire growth by ramping a change slowly. No account explains what sets the right sensitivity.
- **No neural implementation.** The paper explicitly leaves the neural basis of the context/state partition open. Particle-filter inference is not a circuit.
- Scalar state, single effector: whether responsibility-gated mixing scales to high-dimensional operators is untested.

---

## Connections

- **[[wiki/papers/heald-coin-contextual-inference-2021.md]]** — source for the generative model, the proper/apparent split, evoked recovery, and the responsibility-scaled update rule.
- **[[wiki/queries/action-semantics-contextual-inference.md]]** — that query asks how the brain adapts to changing action semantics; this concept is the answer's core mechanism, and supplies the reason a trained `action_to_v` is the wrong *type*: a function commits to one effect per action, which is exactly the single-context assumption COIN falsifies.
- **[[wiki/concepts/arbitrary-mapping.md]]** — arbitrary mapping is the biological task (bind a content-free cue to an action by convention); contextual inference is the computation that decides *which* binding is live, and its graded-responsibility updating explains why binding takes ~3 trials rather than one.
- **[[wiki/concepts/two-learning-timescales.md]]** — apparent learning is a *third* mode the W/M split does not name: behaviour changes with no write to either store, purely by re-weighting expression of existing memories; slow W should learn the operator manifold, fast M binds pointer→operator, and the context posterior selects among them at play-time.
- **[[wiki/concepts/memory-schemas.md]]** — COIN's novel-context test is the formal, implemented version of accommodation: "assimilate vs. accommodate" becomes a computable posterior comparison rather than a heuristic, with γ as the (unfit) threshold.
- **[[wiki/concepts/working-memory.md]]** — COIN localizes a specific job to WM: maintaining the *context responsibilities* (not the states). A WM task abolishes spontaneous recovery by resetting predicted probabilities to their stationary values — making WM the store for "which model am I currently using."
- **[[wiki/concepts/neural-manifolds.md]]** — the manifold constraint is the boundary on contextual inference: re-weighting a repertoire is fast precisely because it does not leave the manifold; inventing an operator does, and was not achieved in any tested window. Golub 2018 tightens this — the *repertoire*, not the manifold, is what is preserved on the fast timescale, making COIN's repertoire an observable rather than a posit.
- **[[wiki/papers/sadtler-neural-constraints-learning-2014.md]]** — locates the outer wall on repertoire growth and shows it is *unlocated*, not merely distant: outside-manifold operators were not acquired in a session, and no experiment establishes what longer exposure buys. Its uncued, blinded design is also the condition under which the repertoire looked fixed — the caveat attached to reading these results as intrinsic limits.
- **[[wiki/papers/golub-neural-reassociation-2018.md]]** — the population-physiology instance of fixed-repertoire re-binding: Reassociation beats Realignment, Rescaling, and Subselection; supplies the repertoire-preserved/binding-rewritten third case beside proper and apparent learning, and the inputs-not-connectivity inference that puts the rewrite upstream of the executor.
- **[[wiki/concepts/latent-states.md]]** — a COIN context *is* a latent state inferred from a sequence, with the addition that the number of states is unbounded and inferred rather than fixed.
- **[[wiki/concepts/neuromodulation.md]]** — direct tension: Doya 2002 treats learning rate as an ACh-set metaparameter, while COIN shows the classic learning-rate phenomena are apparent (expression) changes with the Kalman gain held fixed. See [[wiki/empirical-tensions.md]].
- **[[wiki/concepts/meta-learning.md]]** — contextual inference is what a meta-learned fast loop should *compute*: the slow loop installs the repertoire and the generative family; the fast loop infers responsibilities in activations, with no weight change — the same fast-in-activations/slow-in-weights division meta-RL uses.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the edge-label half: the graph's action alphabet is re-bound per environment by contextual inference while structure stays shared — but only for operators already in the repertoire, which is exactly where vocabulary co-discovery (Gap #3) stays open.
- **[[wiki/entities/arc-agi.md]]** — ARC-AGI-3's per-game action semantics are the target case: ACTION1–5 are pointers whose effects must be inferred at play-time from observed transitions, not trained.
- **[[wiki/papers/boettiger-desposito-sr-rule-learning-2005.md]]** — supplies three things COIN lacks: a human false-split measurement for the unfit γ dial (below-chance performance when no rule exists), a candidate *neural* discriminator for the proper/apparent split (inference-side decay with executor persistence), and an anatomical candidate for MOSAIC's module bank / responsibility / error triple.
- **[[wiki/entities/prefrontal-cortex.md]]** — if COIN's context posterior has a cortical home, dlPFC is the candidate: it engages while a mapping is being inferred, disengages once acquired, and its coupling to the candidate-mapping bank predicts learning — but this is a forward-inference argument, and COIN's authors explicitly leave the neural basis open.
- **[[wiki/papers/collins-frank-cts-task-set-2013.md]]** — the cognitive-control-side ancestor of COIN and a partial answer to its "no neural implementation" open problem: the same CRP context→latent-state clustering, but over task-sets and *implemented* in nested corticostriatal loops (create-or-reuse = gating a blank vs. popular PFC stripe under DA-RL); its incidental-over-structuring result is a third converging line on the eager-γ dial.
