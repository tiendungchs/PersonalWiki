---
title: "Meta-Learning"
type: concept
tags: [meta-learning, learning-to-learn, PFC, reinforcement-learning, in-context-learning, two-timescales]
created: 2026-06-19
updated: 2026-06-23
sources: [PFC_as_a_meta_RL_system, making_working_mem_work, Human-like_systematic_generalization, The role of prefrontal cortex in cognitive control and executive function, building_machine_that_thinks_like_people, Modulation of striatal projection systems by dopamine, Exploring the cognitive and motor functions of the basal ganglia an integrative review of computational cognitive neuroscience models, Neuroscience-Inspired Artificial Intelligence, ARC Prize 2025 Technical Report.md]
related: [wiki/concepts/two-learning-timescales.md, wiki/concepts/neuromodulation.md, wiki/concepts/latent-states.md, wiki/concepts/structural-generalization.md, wiki/concepts/cognitive-control.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/refinement-loops.md, wiki/entities/tem-model.md, wiki/entities/prefrontal-cortex.md, wiki/entities/basal-ganglia.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/pbwm-oreilly-frank-2006.md, wiki/concepts/binding-problem.md, wiki/concepts/compositional-generalization.md, wiki/entities/mlc-model.md, wiki/papers/mlc-lake-baroni-2023.md, wiki/papers/pfc-cognitive-control-friedman-2021.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md, wiki/papers/arc-agi-3-paper.md, wiki/papers/arc-prize-2025-technical-report.md, wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md, wiki/papers/helie-ccn-bg-2013.md, wiki/papers/language-modeling-compression-deletang-2023.md, wiki/papers/hutter-aixi-2000.md, wiki/concepts/continual-learning.md, wiki/papers/hassabis-neuroscience-ai-2017.md, wiki/entities/covis-model.md]
---

# Meta-Learning

**Meta-learning (learning to learn) is the emergence of a fast, task-adapted learning algorithm within a system whose parameters were optimized by a slower outer learning process — the fast algorithm runs in activation dynamics, not weight updates.**

The key invariant: at test time, *weights are frozen*. All within-episode behavior comes from the dynamics of the recurrent hidden state accumulating (observation, action, reward) history.

---

## Formal Structure

```
Slow (outer loop):  θ* = argmin_{θ} E_{task ~ p(T)}[ L(f_θ, task) ]
Fast (inner loop):  a_t = f_{θ*}(o_1, a_1, r_1, ..., o_{t-1}, a_{t-1}, r_{t-1}, o_t)
```

- The slow loop optimizes weights θ across the *distribution* of tasks.
- The fast loop uses fixed θ* and derives behavior purely from the episode history.
- The fast algorithm is not explicitly programmed — it is the *emergent* computation of the trained recurrent network.

---

## Instantiations

| System | Slow outer loop | Fast inner loop | What the fast algorithm does |
|---|---|---|---|
| **PFC/BG (Wang et al. 2018)** | DA-driven A3C adjusts PFC+BG synaptic weights across episodes | LSTM recurrent dynamics over (o, a, r) history | Full RL: value estimation, exploration, model-based inference, learning-to-learn |
| **PBWM (O'Reilly & Frank 2006)** | PVLV (associative DA) trains BG (Basal Ganglia) Go/NoGo stripe weights | BG (Basal Ganglia)-gated PFC (Prefrontal Cortex) stripe activations maintain and update WM slots | Episode-level context management; dynamic variable binding (stimulus → WM slot) |
| **TEM (Whittington et al. 2020)** | Backprop updates W (transition weights) across environments | Hebbian fast M binds g to x per episode | Episodic content binding within structural scaffold |
| **MLC (Lake & Baroni 2023)** | Backprop across 100K episodic seq2seq tasks, each with a different compositional grammar | Transformer attention over in-context study instructions (frozen weights) | Infer grammar rules from a few examples; apply to novel queries; novel rules at 99%+ accuracy |
| **In-context learning (LLMs)** | Gradient descent on next-token prediction across documents | Transformer attention over in-context tokens | Pattern matching, rule application, few-shot generalization (order-sensitive; not robustly systematic); mechanically = **in-context compression** — frozen slow-W encodes prior statistics over the training distribution; fast inner loop adapts per-symbol prediction to the current context without gradient updates [[wiki/papers/language-modeling-compression-deletang-2023.md]] |
| **Harlow learning-to-learn (1949)** | Prior experience with object-reward tasks shapes behavior | Single-trial inference of which object is rewarded | One-shot rule identification from a single feedback trial |
| **COVIS dual-system categorization (Ashby et al. 1998)** | Procedural system: slow dopamine RL in BG (Basal Ganglia) direct pathway trains stimulus-response weights across trials | Hypothesis-testing system: rapid WM-based rule search + BG (Basal Ganglia) for rule switching within episode | Dissociable by feedback delay (delays impair procedural only); Dopamine depletion selectively impairs procedural; precursor dual-BG-loop architecture with BG (Basal Ganglia) implementing both the slow outer loop (procedural RL) and the fast inner loop's gating mechanism (hypothesis switching) |
| **Episodic control (Blundell et al. 2016)** | HC episodic store: all (state, action, cumulative return) triplets written one-shot during experience; no gradient update to the store | Cosine-similarity retrieval over stored states; action taken from highest-return nearest neighbor | One-shot reward generalization — first-visit high-reward experience immediately biases next action; outperforms deep RL in early training on Atari; fails when success requires integrating evidence across many trials; this is fast-M *action selection* rather than policy-gradient learning |
| **AIXI (Hutter 2000)** | Solomonoff prior ξ^AI: all computable programs weighted by 2^{-l(q)}, never trained, defined by Kolmogorov complexity | Expectimax over horizon m_k: pure credit-maximizing inference, no gradient updates | Optimal action selection under universal uncertainty; all other instantiations are bounded-program approximations to this ceiling; uncomputable |
| **Refinement loops (ARC Prize 2025)** | Pre-trained weights (TTT) or random initialization (zero-pretraining) — slow outer loop either present or absent | Per-task iterative generate-verify-refine cycle in weight space (TTT), program space (evolutionary synthesis), or NL space (CoT harness); weights *are updated* at test time, unlike classical meta-RL | Finds a task-specific solution program; fast loop speed bounded by verifier availability; zero-pretraining variant (TRM, 7M params) achieves 45% ARC-AGI-1 without any slow outer loop — the strongest empirical data point for test-time optimization substituting for pretraining on verifiable tasks [[wiki/concepts/refinement-loops.md]] |

---

## Stripe-Based Selective WM (PBWM)

PBWM establishes the circuit mechanism for why PFC (Prefrontal Cortex) supports multiple independent WM slots. Human frontal cortex has ~20,000 parallel BG (Basal Ganglia)-PFC "stripes" (Frank et al. 2001), each connected via its own Go/NoGo loop through BG (Basal Ganglia) → thalamus → PFC. Each stripe can be independently opened (Go) or held closed (NoGo), enabling:

- **Selective updating:** update one slot (task sub-cue A) while maintaining another (outer-loop cue 1)
- **Structural credit assignment:** per-stripe Dopamine signal (global PVLV δ × stripe Go firing) tells each stripe whether *its* update contributed to reward
- **Variable binding:** same stimulus bound to different slots (S1 vs. S2) depending on a concurrent control signal — non-gated networks completely fail at this (SIR-2 shared-stimulus result)

This stripe architecture is the biological mechanism Wang et al. 2018 abstracts as the LSTM hidden state — each stripe ≈ one hidden unit dimension that can be independently gated. The meta-RL framework (Wang 2018) drops the per-stripe circuit detail and shows that any recurrent network trained across a task distribution converges on the same functional behavior.

---

## PVLV: Biological Dopamine Signal for BG (Basal Ganglia) Learning

PBWM's global Dopamine signal requires a specific biological account. Doya 2002 maps Dopamine to TD (Temporal Difference) error δ, requiring an unbroken prediction chain from CS to reward. O'Reilly & Frank (2006) argue this fails in tasks with unpredictable intermediate stimuli (like the 1-2-AX task) and propose **Primary Value and Learned Value (PVLV)** as an alternative:

| Sub-system | Stands for | Mechanism | Biological correlate |
|---|---|---|---|
| **PV (primary value)** | Primary Value | Learns to cancel Dopamine burst at time of expected reward (delta rule on current reward) | Striosome/patch neurons in ventral striatum → direct inhibitory projection onto VTA/SNc |
| **LV (learned value)** | Learned Value | Fires at CS onset for stimuli reliably associated with reward; only trained when primary reward is present or expected | Central nucleus of amygdala (CNA, excitatory LVe) + ventral striatum (LVi, slow cancellation) |

**Key departure from TD:** LV is *not trained when no reward is expected*, so it avoids learning that CS onset carries zero reward — it learns a reward *association*, not a reward *prediction*. Produces anticipatory Dopamine without a sequential prediction chain; stable under unpredictable intervening stimuli where TD (Temporal Difference) chaining breaks down.

PVLV and TD (Temporal Difference) converge on the same behavioral signatures (CS-triggered Dopamine burst, reward-omission dip) but PVLV remains stable in the tasks PBWM was designed for (e.g. 1-2-AX), making it the biologically preferred account for BG (Basal Ganglia) Dopamine learning. See [[wiki/entities/basal-ganglia.md]] for BG (Basal Ganglia) anatomy and the broader cortico-striatal context.

**Cellular substrate of credit assignment (Gerfen & Surmeier 2011 [[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]]):** The opponent plasticity underlying PVLV is implemented at the receptor level. D1 activation (direct SPNs, Dopamine burst = reward): PKA → Cav1 ↑ + AMPA/NMDA receptor surface expression ↑ → corticostriatal LTP. D2 activation (indirect SPNs, Dopamine burst = reward): Gi → cAMP ↓ + endocannabinoid (EC) → retrograde CB1 → Glu release ↓ → LTD. Dopamine pause (aversive): direct SPNs shift to LTD (Long-Term Depression) bias, indirect SPNs become LTP-permissive — confirmed by PD optogenetics (Kravitz et al. 2010). PVLV's credit signal is therefore not a signed scalar applied uniformly — it is a chemically segregated *opponent* write operation across two cell populations via distinct receptor cascades.

---

## PFC/BG as Meta-RL System

The canonical neuroscience instantiation. Three conditions are jointly sufficient to produce meta-RL:
1. PFC (Prefrontal Cortex) + BG (Basal Ganglia) + thalamus modeled as a recurrent network (LSTM).
2. Synaptic weights adjusted by DA-driven model-free RL (slow loop).
3. Training occurs on a *distribution* of interrelated tasks, not a single fixed task.

Under these conditions, the LSTM dynamics come to implement a second, complete RL algorithm. Evidence across six simulations (Wang et al. 2018):

| Simulation | Behavior reproduced | What PFC (Prefrontal Cortex) dynamics compute |
|---|---|---|
| 1. Probability matching | Monkey dlPFC action/reward encoding | Running Q-value from history |
| 2. Volatility tracking | Human ACC (Anterior Cingulate Cortex) learning-rate adaptation | Dynamic learning-rate from decoded volatility |
| 3. Inferred value | Dopamine response to inferred (not experienced) reversal | Latent-state representation driving RPE |
| 4. Two-step task | Model-based stay/switch behavior; model-based striatal RPEs | Transition model inferred in activation space |
| 5. Learning to learn | Harlow one-trial learning after training | Abstract task structure (which object rewarded) held in WM |
| 6. Optogenetic manipulation | Behavioral shift from Dopamine block/stimulate at test | RPE as activity input (not weight modifier) shifts hidden state |

---

## Dual Role of Dopamine

Meta-RL clarifies that Dopamine plays two functionally distinct roles:

| Role | Timescale | Mechanism | Effect |
|---|---|---|---|
| **Synaptic plasticity signal** | Slow (training) | TD (Temporal Difference) error modulates cortico-striatal LTP/LTD | Shapes PFC (Prefrontal Cortex) recurrent weights → installs the fast algorithm |
| **Activity information signal** | Fast (within episode) | RPE injected as input to PFC (Prefrontal Cortex) hidden state | Carries reward information that the fast algorithm integrates over the episode |

The two roles are dissociable: at test with frozen weights, optogenetically blocking Dopamine shifts behavior via the activity channel alone.

---

## Implication for Reasoning Model

The meta-RL framework gives the correct computational account of what Block 3B (PFC working memory, [[wiki/queries/building-blocks-mec-hc-pfc.md]]) actually computes. The within-episode working memory is not a scalar gate — it is a full recurrent RL algorithm operating in the LSTM hidden state, accumulating task-relevant history and dynamically updating a behavioral policy.

For ARC-AGI and abstract reasoning: the fast algorithm must infer the latent transformation from a few (input, output) examples. This is exactly what PFC (Prefrontal Cortex) meta-RL does in the two-step and reversal tasks — except the latent variable is a task rule rather than a spatial state. The Transformation Inferrer (Block 3A, [[wiki/entities/tiwm-model.md]]) is the specialized version of this for the transformation-inference problem.

**Simulation-based planning as forward extension of the fast inner loop.** Meta-RL as described above is a *backward* operation: the fast algorithm accumulates evidence from the history (o₁, a₁, r₁, ..., oₜ) to infer the latent task structure. But the fast inner loop can also run *forward*: given an inferred task model, generate candidate future trajectories and evaluate them before committing to an action. This is hippocampal preplay — HC acts as the world model generating rollouts, OFC/striatum evaluates outcomes, PFC (Prefrontal Cortex) selects. For reasoning models, this means Block 3B is not only a history accumulator but also a forward simulator: once the task rule is inferred, it can project consequences of candidate actions into the future using the same fast inner loop dynamics, enabling model-based planning without slow gradient updates.

---

## Goal Maintenance / Biasing as the CC (Cognitive Control) Unity Account

Friedman & Robbins (2021) establish that "goal maintenance and biasing" (Miller & Cohen 2001) is the most parsimonious account of the Common CC (Cognitive Control) factor — the variance that all CC (Cognitive Control) tasks share. This links meta-learning to CC (Cognitive Control) theory:

- The meta-RL LSTM (Wang et al. 2018) *is* the neural implementation of goal maintenance: the hidden state encodes the current goal, and this biases the within-episode fast RL algorithm toward goal-relevant responses.
- The three CC (Cognitive Control) components (Inhibition / WM Updating / Set-Shifting) map directly onto PFC/BG blocks: Block 3D (goal = inhibition via bias), Block 3B (WM updating), Block 3A (transformation inferrer = set-shifting to new task-rule W).
- Meta-learning solves the CC (Cognitive Control) "unity" problem computationally: a single LSTM trained across task distributions acquires goal-maintenance as the emergent strategy because it minimizes cumulative regret only when the goal is stably represented across the episode.

**Hierarchical PFC (Prefrontal Cortex) as template for Block 3C.** The rostro-caudal gradient (BA-8 = stimulus-response → BA (Brodmann Area)-9/46 = contextual rule → BA (Brodmann Area)-10 = branching rules from WM) maps directly onto the hierarchical TEM stack (W_instance → W_meta → W_meta-meta). TMS-causal evidence shows the hierarchy is directional: mid-lateral PFC (Prefrontal Cortex) integrates the caudal and frontopolar signals, making it the "hub" where the fast algorithm runs on context from both levels. This justifies a three-level Block 3C, not two.

---

## AIXI (AI with (X) induction (I)) as the Theoretical Ceiling

All meta-learning instantiations above are computable approximations of AIXI (AI with (X) induction (I))'s two-component structure:

| AIXI (AI with (X) induction (I)) component | Biological/ML analog | Key approximation |
|---|---|---|
| Solomonoff prior ξ^AI (all programs, 2^{-l(q)} weight) | Slow W (backprop, shared structure across task distribution) | W covers training distribution; ξ covers all computable environments |
| Expectimax over horizon m_k (pure inference) | Fast M / LSTM hidden state / in-context attention | Bounded horizon; finite compute; restricted action space |

The LRM (Large Reasoning Model) knowledge-boundedness theorem ([[wiki/papers/arc-agi-3-paper.md]]) is a corollary of this: the fast inner loop cannot generalize beyond what ξ^approximation (the slow prior) covers. For AIXI (AI with (X) induction (I)), ξ^AI covers all computable environments — no knowledge bound. For LRMs, the approximation is the training distribution — hard knowledge ceiling. The gap is the formal statement of why current meta-learning falls short of AIXI (AI with (X) induction (I))-level abstract reasoning.

**Factorizable µ as the safe regime.** AIXI (AI with (X) induction (I))'s two-component structure works cleanly — with no pathological horizon effects — when the environment is factorizable (independent episodes). IID supervised learning, MLC's episodic meta-training, and PFC/BG's within-episode RL all exploit factorizability. ARC-AGI-3's interactive agents operate in non-factorizable environments (actions in exploration influence later rewards); this is where AIXI (AI with (X) induction (I))'s horizon problem becomes architecturally load-bearing.

---

## Open Problems

- **Mechanistic gap**: how do DA-driven synaptic changes *specifically* produce a recurrent RL algorithm? The answer is known computationally (train LSTM with RL on task distribution) but not biologically (what circuit-level changes implement this?).
- **Multiple loops**: PFC/BG is one recurrent loop; sensorimotor cortex-BG loops, OFC-BG loops also exist. Do they implement separate meta-RL algorithms for different task dimensions?
- **Compositional meta-learning**: MLC (Meta-Learning as Compositional) (Lake & Baroni 2023) demonstrates that episodic meta-learning solves compositional generalization within a single grammar family — the slow loop learns abstract rule-learning capacity rather than specific rules. Extension to multi-level compositions (ARC-AGI requires chaining rules across hierarchy levels) and open-vocabulary domains remains open — see Block 3C (hierarchical stack, [[wiki/queries/building-blocks-mec-hc-pfc.md]]). Critical distinction: MLC's fast algorithm is grammar inference (non-RL), not reward maximization; this generalizes meta-learning beyond the RL domain.
- **Efficiency dependency on representation structure (Lake et al. 2016):** Multi-task transfer on monolithic representations yields only 2–5× speed-up (Actor-Mimic achieves ~2× faster convergence on new Atari games); human-level one-shot learning represents a >100× gain. Lake et al. argue this gap exists because shared prior knowledge cannot decompose into reusable domain-independent primitives unless representations are compositional and causal. The representation structure is a prerequisite for effective meta-learning, not merely correlated with it — this means Block 3C cannot be solved by training curriculum alone; the slow-W representations must be compositional and causal for the meta-learning gain to match biology.
- **Large Reasoning Model (LRM) knowledge-boundedness (ARC Prize Foundation 2026):** Current LRM (Large Reasoning Model) meta-learning (test-time reasoning) is bounded by pretraining distribution coverage: the fast inner loop adapts only within the envelope of domains the slow outer loop has covered. ARC-AGI-3 tests environments with novel mechanics absent from any training corpus — frontier models score <1% vs. 100% human solvability. The structural claim: LRMs can reason only in domains where (a) base model training has knowledge coverage AND (b) an exact verifier exists; human reasoning has neither constraint. This is not "jagged intelligence" (inconsistency) but a principled limit: the fast inner loop cannot generalize beyond the slow outer loop's distribution envelope. It constrains what Block 3B's fast inner loop can achieve and defines the ceiling of the current meta-learning paradigm.

---

## Connections

- **[[wiki/concepts/refinement-loops.md]]** — a new fast-inner-loop variant that updates weights (or programs) per-task at test time rather than freezing weights and accumulating in activation dynamics; zero-pretraining DL (TRM) shows the fast loop can substitute for a slow outer loop entirely on verifiable tasks; establishes the upper limit of what test-time optimization can achieve under the LRM (Large Reasoning Model) knowledge-boundedness constraint.
- **[[wiki/concepts/two-learning-timescales.md]]** — meta-learning is the most explicit instantiation of the fast/slow split: slow Dopamine trains weights; fast LSTM dynamics implement the within-episode algorithm; no Hebbian write step, just recurrent accumulation.
- **[[wiki/concepts/neuromodulation.md]]** — DA's dual role (plasticity signal + activity input) discovered in the meta-RL framework extends Doya 2002's account; the within-episode Dopamine activity channel is the second role not covered by the TD (Temporal Difference) error hypothesis alone.
- **[[wiki/concepts/latent-states.md]]** — PFC (Prefrontal Cortex) LSTM hidden state clusters by task latent state (which cue is rewarded) before any observation; meta-RL is the mechanism by which PFC (Prefrontal Cortex) maintains and updates latent-state estimates within an episode, complementing HC's cross-episode latent-state representations.
- **[[wiki/concepts/structural-generalization.md]]** — meta-learning is one route to structural generalization: the slow loop extracts shared task structure across the distribution; the fast loop applies it within a new instance. This is the same principle as TEM's W/M split but instantiated in PFC (Prefrontal Cortex) recurrent dynamics rather than HC/MEC factorized codes.
- **[[wiki/entities/tem-model.md]]** — TEM's fast Hebbian M is a different fast mechanism (explicit content binding) compared to PFC (Prefrontal Cortex) meta-RL's implicit recurrent accumulation; both implement fast within-episode learning but differ in how the fast system stores information (weight delta vs. hidden state).
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — Block 3B (working memory gate) is properly understood as a meta-RL system: the LSTM hidden state IS the working memory; its dynamics implement the within-episode RL algorithm; the β-gate sketch in the query is a coarse approximation of this full recurrent system.
- **[[wiki/papers/pfc-meta-rl-wang-2018.md]]** — primary source; six simulations demonstrating meta-RL across probability matching, volatility adaptation, inferred value, model-based control, learning-to-learn, and optogenetic manipulation.
- **[[wiki/papers/pbwm-oreilly-frank-2006.md]]** — mechanistic precursor: establishes stripe-based BG (Basal Ganglia)-PFC gating and PVLV (full PVLV account now in this page's PVLV section); demonstrates PBWM ≈ LSTM computational equivalence, which Wang et al. 2018 then formalizes as full meta-RL.
- **[[wiki/entities/basal-ganglia.md]]** — BG (Basal Ganglia) is the biological substrate of the meta-RL slow outer loop; stripe-based BG (Basal Ganglia)-PFC gating implements the PBWM WM mechanism; PVLV is the BG (Basal Ganglia) Dopamine learning algorithm; full BG (Basal Ganglia) anatomy and connectivity to be covered there when sources are ingested.
- **[[wiki/concepts/binding-problem.md]]** — BG (Basal Ganglia)-gated variable binding is a new instantiation of the binding problem: abstract symbols bound to WM slots by a control signal, distinct from spatial or featural binding mechanisms.
- **[[wiki/concepts/compositional-generalization.md]]** — MLC (Meta-Learning as Compositional) is the key evidence that meta-learning solves the chunking failure: different grammar per episode prevents co-occurrence absorption; the slow loop embeds rule-learning capacity rather than rule instances.
- **[[wiki/entities/mlc-model.md]]** — architecture and benchmark details for MLC (Meta-Learning as Compositional) as the compositional-generalization instantiation of slow/fast meta-learning.
- **[[wiki/papers/mlc-lake-baroni-2023.md]]** — source for MLC (Meta-Learning as Compositional) results; establishes that training objective (episodic meta-learning) not architecture (transformer) is the critical variable for systematic generalization.
- **[[wiki/concepts/cognitive-control.md]]** — goal maintenance (Miller & Cohen) is the behavioral/circuit account of what meta-RL implements computationally: the three CC (Cognitive Control) components (inhibition, updating, shifting) map onto Blocks 3D/3B/3A; hierarchical PFC (Prefrontal Cortex) gradient (BA-8→9/46→10) is the anatomical template for a three-level Block 3C.
- **[[wiki/papers/pfc-cognitive-control-friedman-2021.md]]** — source for goal-maintenance as unified CC (Cognitive Control) mechanism, hierarchical PFC (Prefrontal Cortex) gradient, and three-component CC (Cognitive Control) decomposition.
- **[[wiki/entities/prefrontal-cortex.md]]** — PFC (Prefrontal Cortex) is the canonical biological substrate for meta-RL: dlPFC LSTM dynamics implement the fast inner loop; BG (Basal Ganglia) stripe circuits are the physical mechanism; the hierarchical BA (Brodmann Area)-8→9/46→10 gradient provides the anatomical template for a three-level Block 3C.
- **[[wiki/concepts/abstract-reasoning.md]]** — learning-to-learn is the third required ingredient for abstract reasoning; its efficiency is gated by whether the slow-loop representations are compositional and causal — without those, meta-learning yields 2–5× transfer, not the >100× one-shot efficiency of human abstract concept learning.
- **[[wiki/papers/building-machine-thinks-like-people-lake-2016.md]]** — source for the efficiency-dependency argument: Actor-Mimic's 2× speed-up vs. human >100× illustrates that compositional+causal representation structure, not training distribution alone, determines how much meta-learning gains buy.
- **[[wiki/papers/arc-agi-3-paper.md]]** — source for LRM (Large Reasoning Model) knowledge-boundedness: test-time reasoning cannot generalize beyond the pretraining distribution envelope; frontier models score <1% on ARC-AGI-3 (novel mechanics + no verifier) vs. 100% human, establishing the ceiling of the current meta-learning paradigm empirically.
- **[[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]]** — source for PVLV cellular mechanism: D1→PKA→LTP and D2→EC→CB1→LTD implement opponent credit assignment at the receptor level; Dopamine pause reversal in PD confirms opponent structure is architecturally necessary, not just a biological convenience.
- **[[wiki/papers/helie-ccn-bg-2013.md]]** — source for COVIS as precursor dual-system architecture: procedural BG (Basal Ganglia) RL (slow outer loop analog) + hypothesis-testing WM gating (fast inner loop analog); dissociation by feedback delay and Dopamine depletion; SPEED automaticity as the mechanism by which the slow outer loop eventually withdraws and compiles skills into cortex.
- **[[wiki/entities/covis-model.md]]** — entity page for COVIS as the dual-BG-loop precursor to meta-RL: procedural BG (Basal Ganglia) RL (slow outer loop) + hypothesis-testing WM gating (fast inner loop); behavioral dissociations by feedback delay and Dopamine depletion confirm the two loops are independently modifiable — the structural prerequisite the meta-RL framework assumes.
- **[[wiki/papers/language-modeling-compression-deletang-2023.md]]** — establishes that in-context learning is in-context compression: frozen slow-W is a compression prior over the training distribution; the fast inner loop (attention over context, no gradient updates) adapts the per-symbol prediction — this is the formal description of what MLC (Meta-Learning as Compositional) and other in-context meta-learners do; from this perspective the LRM (Large Reasoning Model) knowledge-boundedness limit is a compression limit: the fast loop cannot compress beyond what the slow prior has modeled.
- **[[wiki/papers/hutter-aixi-2000.md]]** — AIXI (AI with (X) induction (I)) is the theoretical ceiling: Solomonoff ξ^AI is the ideal slow prior; expectimax is the ideal fast inner loop; all meta-learning systems are bounded-program approximations; factorizable µ is the formal condition under which the two-timescale split is lossless and horizon effects are benign.
- **[[wiki/concepts/continual-learning.md]]** — episodic control requires a continual learning architecture: each episode's (state, return) pairs must coexist in the HC episodic store without overwriting prior memories; SDR (Sparse Distributed Representations) sparsity and the CLS (Complementary Learning Systems) fast/slow separation provide this; for the meta-RL fast inner loop, catastrophic forgetting in the slow-W outer loop would destroy the prior that makes within-episode generalization possible.
- **[[wiki/papers/hassabis-neuroscience-ai-2017.md]]** — source for episodic control as a distinct fast-M action-selection mechanism (cosine-similarity retrieval from HC store, distinct from experience replay which drives offline weight updates); source for simulation-based planning as a forward extension of the fast inner loop via HC preplay as a generative world model.
- **[[wiki/concepts/shortcut-reasoning.md]]** — meta-learning (IRM, causal invariant prediction) is the slow-W structural solution to shortcut reliance: the slow outer loop learns mechanisms that are invariant across environments rather than distribution-specific correlates; episodic meta-training is the training-side enforcement of this invariance.
