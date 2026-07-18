---
title: "Two Learning Timescales"
type: concept
tags: [learning, memory, complementary-learning-systems, fast-slow-learning, hebbian, replay]
created: 2026-06-09
updated: 2026-07-17
sources: [engram-transcript, memory-gate-transcript, bolzman-machine-transcript, reservoir-computing-transcript, Metalearning_and_Neuromodulation, PFC_as_a_meta_RL_system, Recurrent neural networks with transient trajectory explain working memory encoding mechanisms, Robust and brain-like working memory through short-term synaptic plasticity, Hopfield Networks Neural Memory Machines, Complementary Learning Systems, Complementary learning systems Why - Claude summary, Learning Fast and Slow Single- and Many-Shot Learning in the Hippocampus, Exploring the cognitive and motor functions of the basal ganglia an integrative review of computational cognitive neuroscience models, High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations, kanerva-sdm-1993, prefrontal-atrophy-nrem-mander-2013, fact-finding-post1, fact-finding-post2, fact-finding-post3, fact-finding-post4, Neural constraints on learning]
related: [wiki/concepts/contextual-inference.md, wiki/papers/heald-coin-contextual-inference-2021.md, wiki/papers/sadtler-neural-constraints-learning-2014.md, wiki/concepts/neural-manifolds.md, wiki/concepts/arbitrary-mapping.md, wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/replay.md, wiki/concepts/engrams.md, wiki/concepts/information-theory.md, wiki/concepts/predictive-coding.md, wiki/concepts/neuromodulation.md, wiki/concepts/meta-learning.md, wiki/concepts/working-memory.md, wiki/concepts/associative-memory.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/hebbian-learning.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/tem-model.md, wiki/entities/boltzmann-machine.md, wiki/entities/reservoir-computing.md, wiki/entities/place-cells.md, wiki/entities/basal-ganglia.md, wiki/entities/trnn-model.md, wiki/entities/vector-hash-model.md, wiki/papers/engram-transcript.md, wiki/papers/memory-gate-transcript.md, wiki/papers/boltzmann-machine-transcript.md, wiki/papers/reservoir-computing-transcript.md, wiki/papers/metalearning-neuromodulation-doya-2002.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/trnn-liu-2025.md, wiki/papers/stsp-kozachkov-2022.md, wiki/papers/hopfield-networks-crouse-2022.md, wiki/papers/cls-oreilly-2011.md, wiki/papers/cls-mcclelland-1995.md, wiki/papers/learning-fast-slow-liao-2024.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md, wiki/papers/helie-ccn-bg-2013.md, wiki/papers/vector-hash-chandra-2023.md, wiki/entities/sdm-model.md, wiki/papers/kanerva-sdm-1993.md, wiki/entities/cerebellum.md, wiki/concepts/neoteny.md, wiki/papers/somel-transcriptional-neoteny-2009.md, wiki/papers/pcm-l2l-ortner-2025.md, wiki/entities/snn.md, wiki/concepts/credit-assignment.md, wiki/concepts/temporal-multiplexing.md, wiki/papers/fact-finding-factual-recall-nanda-2023.md, wiki/entities/transformer-model.md, wiki/concepts/cognitive-control.md, wiki/papers/pfc-categories-concepts-miller-2002.md, wiki/queries/reasoning-as-coupled-navigation-strategizing.md, wiki/concepts/memory-schemas.md, wiki/concepts/differentiable-plasticity.md, wiki/concepts/continual-learning.md, wiki/concepts/dendritic-computation.md]
---

# Two Learning Timescales

**Robust generalization requires two learning systems: slow extraction of shared structure across environments, and fast binding of specific content within each environment.**

TEM implements this as two weight sets. The principle maps onto the Complementary Learning Systems (CLS) theory (McClelland et al., 1995) and the biological fast/slow memory systems.

---

## The Two Systems

| | Slow (W) | Fast (M) |
|--|----------|---------|
| **Stores** | Structural world model — transition rules | Episodic memories — what is at each location |
| **Update** | Backprop across many environments | Hebbian at every timestep |
| **Scope** | Shared — all environments | Specific — current environment only |
| **Brain analog** | MEC/cortex long-term plasticity | Hippocampal LTP (Long-Term Potentiation) |

**Why both are necessary:** Fast alone = memorizes arbitrary content, no transfer. Slow alone = extracts structure, cannot recall specific episodes. Together: slow system defines the structural vocabulary; fast system writes environment-specific content into those slots. This enables both zero-shot structural inference (from W) and specific recall (from M).

---

## Catastrophic Interference: The Computational Case for CLS

McClelland et al. 1995 ([[wiki/papers/cls-mcclelland-1995.md]]) provide the formal *why* for the two-timescale split — not a biological description but a proof-of-necessity.

**McCloskey & Cohen (1989) demonstration:** Training a standard network on list A then intensively on list B erased ~100% of list A — far worse than human interference. A network using *interleaved* training (A and B mixed throughout) showed normal acquisition and minimal interference.

**Why interference is catastrophic in a monolithic system:**

| | Monolithic (single system) | Factorized (CLS) |
|---|---|---|
| **New content storage** | Large, focused weight change | Fast M: local Hebbian, isolated from slow weights |
| **Effect on prior patterns** | Overwrites shared weights | Slow W: insulated; receives interleaved not focused updates |
| **Structured knowledge** | Disrupted by each new episode | Accumulates safely via diverse interleaved replay |

**Rumelhart (1990) interleaved semantic network:** Coarse-to-fine conceptual differentiation (plant/animal → bird/fish → robin/canary) reproducing child development occurs *only* under interleaved training. Focused training on any subset destroys prior structure. This is direct evidence that structured generalization requires interleaved exposure — exactly what HC replay provides.

**Statistical learning theory:** Discovering population-level regularities requires averaging over many diverse samples with small gradient steps. Large focused updates overfit to single-episode surface statistics. This gives a mathematical — not merely biological — reason that slow-W updates must be small and distributed across many environments.

---

## HC Bootstraps Cortical Learning

A key insight from Whittington 2022: hippocampal maps don't just store fast memories — they *enable* slow cortical learning by providing clean, de-aliased training sequences.

Without HC de-aliasing, cortex receives ambiguous data (same observation, different futures → contradictory training signal). With HC de-aliasing, cortex receives clean (latent state, next latent state) pairs from which shared structural regularities can be extracted.

Proposed trajectory:
1. Novel environment → HC builds relational map de novo (fast, CSCG-style)
2. HC map provides high-fidelity sequences to cortex
3. Cortex slowly learns shared structure across many HC episodes
4. Familiar structure type → HC transitions from map role to memory role

This operationalizes CLS: HC fast binding is not just for recall, but for generating the clean sequences that make slow cortical learning tractable.

**HC-neocortex synergy (O'Reilly et al. 2011):** The relationship is bidirectional, not one-directional. Cortex provides a coarse partial attractor state that helps HC pattern completion during recall (neocortex partially settles toward the target memory, priming HC with a better partial cue). HC provides interference resistance that stabilizes cortical learning (AB-AC task: integrated system suffers less interference than cortex alone). Sleep-stage directionality: SWS = HC→cortex consolidation; REM = cortex→HC memory protection (neocortical input and endogenous CA3 activity equalize memory strengths and re-encode HC representations to reduce interference).

---

## Theta-Phase Error-Driven Learning in HC

CLS (O'Reilly et al. 2011 [[wiki/papers/cls-oreilly-2011.md]]) reveals HC is not a pure Hebbian one-shot system. The theta oscillation (4–8 Hz) creates a *constant*, fine-grained alternation:

| Theta sub-phase | Dominant input | Learning role |
|---|---|---|
| **Retrieval (minus)** | CA3 strong, EC (Entorhinal Cortex) weak | Expectation: prior memory recalled from CA3 attractor |
| **Encoding (plus)** | EC (Entorhinal Cortex) strong, CA3 weak | Outcome: actual current input from EC (Entorhinal Cortex) drives CA3/CA1 |

The difference — `Δ = encoding_activity − retrieval_activity` — is a prediction error driving Leabra-style contrastive Hebbian weight updates inside HC. HC continuously corrects its own retrieval errors at theta frequency rather than only writing new content Hebbianly.

**Implications for the two-timescale picture:**
- The fast-M system has an internal error signal, not just a write mechanism; this makes fast-M updates more accurate under repeated exposure to the same episode.
- Theta-phase error signals in HC may feed into cortical plasticity during encoding — a candidate biological mechanism for the W-update biological plausibility problem.
- The ACh neuromodulatory switch sets a coarser bias (encoding vs. retrieval mode); theta oscillates *within* that bias, providing fine-grained alternation regardless of ACh state.

---

## SWR (Sharp Wave Ripple) Consolidation Timeline

Sharp wave ripples (Science 2024) provide mechanistic specificity to the HC→cortex transfer:

| Phase | SWR (Sharp Wave Ripple) type | Function | Temporal constraint |
|-------|----------|----------|---------------------|
| Waking pauses (post-reward) | **Awake SWR** | Tag: replay recent trajectory; trigger local HC plasticity priming patterns for sleep | Cortex not consolidation-receptive; HC must maintain ongoing map — cannot consolidate in parallel |
| Sleep | **Sleep SWR** | Transfer: repeatedly replay bookmarked sequences (10–20× compressed) to cortex | Cortex enters receptive state; many repetitions needed; HC freed from online mapping |

**Temporal compression (~100ms per replay)** is mechanistically necessary: compressed replays arrive within cortical STDP windows, enabling synaptic strengthening. Without compression, replay would fail to drive cortical plasticity at the timescale of sleep oscillations.

**Mapping onto W/M split:**
- Awake SWR (Sharp Wave Ripple) = fast M tagging: local Hebbian plasticity within HC marks which episodic patterns matter
- Sleep SWR (Sharp Wave Ripple) = slow W transfer: repeated compressed sequences drive cortical weight updates across many environments over many nights

**SWA: the oscillatory scaffold for sleep SWR transfer.** NREM slow-wave activity (SWA: 0.8–4.6 Hz), generated by mPFC cortical circuits, creates the excitability windows within which sleep SWRs can produce lasting cortical weight changes (Mander et al. 2013 [[wiki/papers/prefrontal-atrophy-nrem-mander-2013.md]]). SWA strength predicts overnight episodic memory retention independently of SWR count, sleep stage duration, and spindle density — isolating SWA as the gating mechanism for slow-W transfer, not merely a correlate of it. The functional endpoint of successful slow-W transfer is measurable: post-sleep hippocampal retrieval activation decreases (memories become hippocampally independent) and HC-mPFC coupling during retrieval increases. This operationalizes the CLS prediction that repeated HC replay should produce cortical representations that no longer require HC at retrieval — the slow-W weight update is "complete" when retrieval is HC-independent.

---

## Engrams as the Biological Fast-M Substrate

Engram research [[wiki/concepts/engrams.md]] makes the fast M system concrete at the cellular level:

- **Which cells get written:** excitability competition via inhibitory interneurons — the most excitable cells at training time suppress neighbors and win allocation. This is the biological softmax: winner-take-most with lateral inhibition enforcing sparsity.
- **How sparse:** 2–6% in dentate gyrus; 10–20% in amygdala — homeostically conserved across memory strength and valence. TEM assumes sparse p codes; engram data specifies the quantitative constraint.
- **Temporal interference:** elevated excitability persists ~5–24h. Events within this window share neurons → linked memories. TEM's idealized M treats each environment independently; biology introduces a time-dependent interference channel that could couple or corrupt episodic bindings.

**CREB as a third timescale.** The molecular mechanism behind the linkage window is CREB (cAMP-responsive element-binding protein): LTP (Long-Term Potentiation) at encoding triggers the ERK→CREB cascade; CREB reduces K⁺ conductance for hours; recently-potentiated neurons remain more excitable, biasing allocation for subsequent memories. This defines a **third learning timescale** that interpolates between fast-M (seconds, BTSP single-shot write) and slow-W (days–years, SWR (Sharp Wave Ripple) replay consolidation):

| Timescale | Mechanism | Duration | Function |
|---|---|---|---|
| **Fast M** | BTSP / STDP synaptic write | Seconds | Encode node or edge content |
| **CREB eligibility** | K⁺ conductance reduction via ERK→CREB | Hours (~5–24h) | Bias allocation, link temporally proximate memories |
| **Slow W** | SWR (Sharp Wave Ripple) replay → cortical STDP | Nights / years | Extract cross-environment structural regularity |

The CREB timescale is not a memory store — it is an eligibility window that determines *which* fast-M writes form a linked cluster. Assembly consolidation hypothesis adds a second CREB-timescale effect: CREB-elevated cells are more likely to be recruited into SWRs, biasing the awake-SWR bookmarking step toward recently-potentiated cells — coupling the CREB hours-timescale directly to the consolidation pipeline.

---

## PFC/BG Instantiation — Meta-RL

Wang et al. 2018 ([[wiki/papers/pfc-meta-rl-wang-2018.md]]) provides the sharpest single-circuit demonstration of the two-timescale principle, in a different brain region and with a different fast mechanism than the TEM/HC account:

| | Slow (W analog) | Fast (M analog) |
|--|---|---|
| **TEM / HC** | Backprop updates W across environments | Hebbian M binds g to x content per episode |
| **PFC / BG (Basal Ganglia) (meta-RL)** | DA-driven A3C updates PFC+BG synaptic weights across episodes | LSTM recurrent hidden state accumulates (o, a, r) history — no weight change |

The fast system differs critically: TEM's M is an explicit Hebbian write of content into a weight matrix; PFC (Prefrontal Cortex) meta-RL stores episode history implicitly in the LSTM hidden state, and this hidden state *is* the running RL algorithm (value estimate, policy, exploration state). There is no write step — memory is carried forward by recurrent dynamics.

This means the two-timescale principle applies across multiple brain circuits with circuit-specific fast mechanisms: Hebbian content binding in HC, recurrent activity accumulation in PFC.

---

## BTSP and STDP: A Within-HC Two-Timescale Hierarchy

Liao & Losonczy 2024 ([[wiki/papers/learning-fast-slow-liao-2024.md]]) reveal that the fast-M side of the HC/cortex split is itself a two-timescale system:

| Rule | Timescale | Δw per event | Mechanism | Learning target |
|---|---|---|---|---|
| **BTSP** (behavioral timescale synaptic plasticity) | Seconds | Large | Dendritic plateau potential → eligibility trace → mass potentiation | Single concept (node) in one shot |
| **STDP** (spike timing–dependent plasticity) | Milliseconds | Small | Causal pre/post spike pair within ~20ms window | Sequential edge between two concepts, many-shot |

**BTSP mechanism:** An instructive signal — plausibly from entorhinal cortex (Grienberger & Magee 2022) — evokes a long-lasting plateau potential in CA1 distal apical dendrites. Synapses active within the preceding and immediately following seconds become potentiated together. Result: a new place field acquired in a single trial from population statistics, not pairwise spike coincidences. First synapse-level in vivo confirmation: Fan et al. 2023 (all-optical physiology) and Gonzalez et al. 2023.

**STDP mechanism:** Each STDP event is small but sequential pairs fire within millisecond windows repeatedly, embedding the structure of experienced sequences into CA3 recurrent weights. Symmetric kernel in CA3 (Mishra 2016, distinct from asymmetric neocortical STDP) enables both forward and backward replay from the same weights. Time cells + theta oscillation bridge the gap between slow behavioral timescales and fast STDP windows.

**Relationship to fast-M:** "One-shot Hebbian" in the fast-M row ([[wiki/entities/tem-model.md]]) refers functionally to single-trial episodic binding — BTSP is the actual molecular substrate, not classic pairwise Hebbian LTP. STDP is the *many-shot* incremental write for sequences, operating within the same fast-M timescale but requiring multiple exposures.

**Why both are needed for any graph:** BTSP acquires concepts (nodes), STDP embeds their sequential relationships (directed edges). Together these two primitives are sufficient to represent any graph — the paper's central computational claim. Abstract cognitive maps over non-spatial dimensions (frequency, faces, conjunctions of stimuli) are all graph representations of this form.

**Speed-amplitude trade-off:** A single unifying principle governs both: the magnitude of weight change in a plasticity event scales with the information integrated. BTSP integrates over seconds across many synapses → large Δw, one shot. STDP integrates over milliseconds from two synapses → small Δw, many shots.

---

## SPEED: BG (Basal Ganglia) as Training Scaffold for Cortical Automaticity

The SPEED model (Ashby et al. 2007 in Helie et al. 2013 [[wiki/papers/helie-ccn-bg-2013.md]]) provides a third slow-W writing mechanism distinct from HC-cortex consolidation and meta-RL weight updates:

**Mechanism:** BG (Basal Ganglia) direct pathway trains cortico-cortical connections via dopamine RL. Consistent BG (Basal Ganglia)-mediated selection of the correct action in premotor cortex → co-activation of sensory association cortex (input) and premotor cortex (output) → Hebbian LTP (Long-Term Potentiation) on the direct cortico-cortical route. Once the route is strong enough to fire autonomously, BG (Basal Ganglia) is no longer required for execution.

| Phase | BG (Basal Ganglia) role | Cortical result |
|---|---|---|
| **Early training** | Active — Dopamine RL drives corticostriatal selection, ensuring consistent premotor firing | Hebbian LTP (Long-Term Potentiation) accumulates on direct cortico-cortical route |
| **Late / automatic** | Withdrawn — cortico-cortical connection sufficient for execution | Stimulus activates sensory cortex → premotor cortex without BG (Basal Ganglia) |

**Comparison to other slow-W routes:**

| Route | Scope | Mechanism | Timescale |
|---|---|---|---|
| **HC-cortex consolidation** | Cross-environment structural regularities | SWR (Sharp Wave Ripple) replay → STDP during sleep | Nights/years |
| **Meta-RL (DA synaptic)** | Cross-episode task structure | DA-driven A3C weight updates in PFC/BG | Episodes/days |
| **SPEED automaticity** | Single task-specific skill | BG (Basal Ganglia) bootstraps Hebbian cortico-cortical LTP, then withdraws | Trials/weeks |

**Empirical confirmation:** GPi inactivation (Desmurget & Turner 2010) disrupts movement kinematics but not learned sequence knowledge — the compiled cortical route survives BG (Basal Ganglia) disconnection. SPEED accounts for this dissociation; Nakahara's visual→motor sequence model cannot.

**For reasoning models:** Frequently-used reasoning patterns (e.g., a practiced ARC transformation type) should progressively compile into direct cortical routes, with BG (Basal Ganglia) participation becoming unnecessary for execution. This implies an agent's cognitive architecture should have a mechanism for BG (Basal Ganglia) to progressively hand off execution of mastered skills to cortex — pure BG (Basal Ganglia)-gating models that require BG (Basal Ganglia) at every step cannot achieve this.

---

## TRNN (Transition RNN) and STSP: Third and Fourth Fast Mechanisms

Liu et al. 2025 ([[wiki/papers/trnn-liu-2025.md]]) and Kozachkov et al. 2022 ([[wiki/papers/stsp-kozachkov-2022.md]]) establish two additional distinct fast mechanisms:

| | Slow (W analog) | Fast (M analog) | Storage medium |
|--|---|---|---|
| **TEM / HC** | Backprop updates W across environments | Hebbian M: explicit synaptic write of g⊗x content | Synaptic weight matrix M |
| **PFC / BG (Basal Ganglia) (meta-RL)** | DA-driven weight updates across episodes | LSTM hidden state: gated recurrent accumulation | Recurrent activation vector h_t |
| **TRNN** | Backprop trains self-inhibition + connectivity bias | Transient trajectory: sequential neuron chain, no write step | Sequential firing chain |
| **STSP / PS-hebb** | Backprop trains recurrent skeleton; calcium constants fixed | Synaptic efficacy: spikes drive calcium dynamics, modifying weights transiently | Synaptic efficacy state (calcium) |

**TRNN:** no write step — memory propagates by self-inhibition forcing sequential chain. Wins on multi-item capacity and spatial WM vs. vanilla LSTM. Lacks within-episode RL algorithm.

**STSP:** no write step — spikes automatically drive calcium dynamics that transiently modify synaptic efficacy. Storage is in synaptic state, not neural state → activity-silent during maintenance, burst spiking only during readout. Empirically confirmed in NHP PFC (Prefrontal Cortex) (Kozachkov 2022). Structurally robust: 50% synapse ablation tolerated. Anti-Hebbian excitatory rule (PS-hebb) provides provable stability enabling modular composition.

**Capacity comparison (same parameter count):**
- Hebbian M (linear Hopfield): O(N/log N) items
- Modern Hopfield (TEM-t): O(exp d) items, single-pass
- LSTM hidden state: bounded by hidden dimension; no slot interpretation
- TRNN (Transition RNN) transient trajectory: scales with neuron count N
- STSP (Short-Term Synaptic Plasticity) (PS-hebb): bounded by calcium decay timescale (~200ms); capacity in terms of items not yet characterized

---

## SDM (Sparse Distributed Memory) A/C Split: Circuit-Level Instantiation of the Slow/Fast Timescale

Kanerva's **Sparse Distributed Memory (SDM)** [[wiki/entities/sdm-model.md]] makes the slow-W/fast-M distinction concrete at the level of two distinct synaptic populations with physically different update rules:

| SDM (Sparse Distributed Memory) component | Timescale analog | Biological parallel |
|---|---|---|
| Hard-address matrix **A** (random, never modified) | Slow-W: structural projection scaffold | MEC grid cell weights; Vector-HaSH scaffold; DG (Dentate Gyrus) granule cell mossy-fiber connectivity |
| Contents matrix **C** (Hebbian write per episode) | Fast-M: episodic content accumulation | HC mossy fiber → CA3 synaptic weights; parallel fiber → Purkinje LTD (Long-Term Depression) |

**Key property:** **A** is sampled at random once during construction and never updated — it provides the stable address vocabulary into which all episodic writes are indexed. **C** accumulates outer-product Hebbian writes from each episode. This is the most explicit circuit-level implementation of the two-timescale split: not just "slow weights vs. fast activations" but two distinct synapse populations with physically different update rules (none for **A**, Hebbian for **C**).

**Why this matters architecturally:** SDM (Sparse Distributed Memory) proves that the structural projection (**A**) does not need to be learned — a random draw already provides near-orthogonal addressing for any uniform random input distribution, with activation-set overlaps of only p² × M ≈ 0 for typical p. The only thing requiring episodic writes is the content layer (**C**). This licenses the design choice (confirmed by Vector-HaSH [[wiki/entities/vector-hash-model.md]]) of holding the fast-M store's address scaffold fixed while training only its content layer — the simplest biologically realizable version of the slow/fast factorization.

---

## Cholinergic Gating of the Timescale Switch

Doya 2002 ([[wiki/concepts/neuromodulation.md]]) provides the biological signal that determines which timescale is active at any moment:

| ACh level | HC mode | W/M analog |
|---|---|---|
| **High** | **Storage** — CA3→CA1 Schaffer collateral suppressed; LEC→CA1 encoding enabled | Fast-M write: new episodic binding |
| **Low** | **Retrieval** — CA3 pattern completion restored; LEC input de-emphasized | Slow-W consultation: retrieve structural model |

ACh is released by basal forebrain cholinergic neurons in response to novelty and task demand, then declines as familiarity increases. The same metalearning loop that suppresses ACh (α ↓) when Dopamine sign reversals stabilize also signals when to transition from encoding to retrieval — the system self-schedules the M→W handoff.

This grounds Block 2C (surprise-gated write) in the building-blocks decomposition: the write gate `σ(prediction_error)` approximates the ACh-mediated learning rate; high prediction error ≈ high novelty ≈ high ACh ≈ fast-M write mode.

---

## PCM-L2L: Three Biological Timescales Made Explicit

Ortner et al. 2025 [[wiki/papers/pcm-l2l-ortner-2025.md]] explicitly map their meta-learning framework onto the three-loop biological timescale hierarchy proposed by Wang et al. 2018:

| Loop | Timescale (biological) | Mechanism (paper) | Mechanism (biology) |
|---|---|---|---|
| **Outer (evolutionary)** | Evolutionary / developmental | Software BPTT across 30K–100K tasks; optimizes Θ (initial weights) and Ψ (LSG) | Evolutionary processes shaping neural circuits to be efficient learners for behaviorally relevant task families |
| **Middle (lifetime)** | Years / lifetime | Not modeled explicitly (noted as future work) | Unsupervised plasticity during development; candidate for ACh-gated encoding vs. retrieval modes |
| **Inner (fast)** | Seconds / single exposure | 4 gradient steps or 1 e-prop update on PCM hardware; updates <1% of weights | Rapid synaptic modification during active task engagement |

**PCM devices as a slow-W/fast-M substrate:** The non-volatile PCM crossbar instantiates the two-timescale memory split in silicon:
- Meta-trained weights Θ (slow W) = crystalline/amorphous state of 99%+ of PCM devices; programmed once, read continuously.
- Inner-loop update (fast M) = re-programming <1% of devices (the last dense layer); triggered by task exposure; non-volatile (persists between power cycles).

**Natural e-prop and eligibility traces as the fast-M write mechanism:** The eligibility trace $e_{jk}^t$ in e-prop is the PCM-hardware analog of a synaptic tag: it accumulates locally during the trial, then is gated by the LSG learning signal (analogous to a neuromodulatory pulse from VTA/LC) to produce the final weight change. The fast-M write does not require backpropagating errors through the PCM network — it is a purely forward, local operation.

---

## LLM Factual Recall: Slow-Trained but M-like (Nanda et al. 2023)

Nanda et al. 2023 ([[wiki/papers/fact-finding-factual-recall-nanda-2023.md]]) provide the sharpest mechanistic counterexample to a clean W/M mapping in standard transformers. In Pythia 2.8B, athlete→sport facts are stored by ordinary slow backprop into MLP weights (layers 2–6) — a W-like *learning process* — yet the resulting content is a pure lookup table with **zero macrofeature structure**: knowing "Tim Duncan → basketball" shares no learnable rule with "George Brett → baseball," so distributed/superposed storage is not an efficiency trick but the only structure gradient descent has to exploit.

**Formal criterion (micro vs. macrofeature):** a *microfeature* (e.g. `is_Tim_Duncan`) is specific to one input and useless for generalization; a *macrofeature* (e.g. "is in cluster X") generalizes across inputs. A task is pure memorization exactly when its only macrofeature is the output label itself — no intermediate representation can beat a raw lookup table, so mechanistic interpretability and generalization fail together, for the same structural reason.

**The decoupling this reveals:** the two-timescale framework treats *learning-process timescale* (slow backprop vs. fast Hebbian write) and *generalization-character of content* (structural/generalizing W vs. instance-specific/memorized M) as coupled — slow learning produces W, fast learning produces M. Standard transformers break this: they use a uniformly slow learning process to bake in what is functionally M-like content (non-generalizing, entangled in the same weights as structural computation). This confirms — at the mechanistic, single-neuron level, not just architecturally — the "Standard DNN: jointly trained (entangled) / none (no factorization) / single timescale" row of the W/M spectrum table (see [[wiki/overview.md]]).

**Where rules that aren't facts get stored:** the multi-token embedding produced by early MLPs is the model's *only* engram-like substrate — there is no separate fast-write system. Every new fact must be compiled into permanent weights via further training, not bound in one shot the way HC binds an episode. This is the clearest mechanistic evidence that transformers lack a fast-M pathway altogether, not merely that they conflate W and M. It also suggests a mechanistic root for catastrophic-forgetting susceptibility during fine-tuning: overwriting shared weights can corrupt unrelated memorized facts and generalizing circuits simultaneously, the McCloskey & Cohen (1989) failure mode this page documents above for any monolithic system, now located in a specific sub-circuit (early-mid MLP layers) rather than the network as a whole.

---

## Apparent Learning: Behaviour Change With No Write to Either Store

Heald et al. 2021 ([[wiki/concepts/contextual-inference.md]]) identify a mode this page's two-store framing does not name. Adaptation can arise from:

| Mode | What changes | Write to W? | Write to M? |
|---|---|---|---|
| **Slow structural learning** | shared transition model | yes | — |
| **Fast binding (proper learning)** | this environment's content/state | — | yes |
| **Apparent learning** | **only the posterior over which stored memory applies** | **no** | **no** |

Apparent learning is not a third *store* — it is re-weighting the expression of memories already held. Its evidential force is that COIN accounts for **savings, anterograde interference, and environmental-consistency effects** this way, in parameter-free cross-validated simulations where the Kalman gain (the proper learning rate) and the inferred states are *unchanged* across conditions. Those three phenomena are standard evidence for learning-rate modulation.

**Consequences for this page's framework:**

1. **Savings is not necessarily M persistence or W consolidation.** [[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]] reads cross-environment savings as consolidation into mPFC schema slow-W. COIN offers a cheaper competing account for at least the motor case: the memory was never lost or consolidated — it is simply re-expressed once the context posterior favours it again. Both mechanisms may operate; the wiki should not treat savings as diagnostic of either store.
2. **The ACh timescale-switch story needs a third position.** The high-ACh/low-ACh switch (above) selects between fast-M write and slow-W consultation. Apparent learning is neither: no encoding, no structural retrieval — just mixture re-weighting over the existing repertoire. See the tension row in [[wiki/empirical-tensions.md]].
3. **Behavioural adaptation curves do not identify the store.** A system with frozen W and frozen M still adapts, via the posterior alone. Any claim that a model "learned" from a behavioural curve needs the apparent-learning null ruled out first.

---

## Adaptation vs. Skill Learning: The Manifold as the Dividing Line

Sadtler et al. 2014 ([[wiki/papers/sadtler-neural-constraints-learning-2014.md]]) propose a split that cuts across this page's W/M axis and is worth keeping distinct from it. Perturbing a BCI decoder two ways — permuting the *factors* (within-manifold) vs. permuting the *units* (outside-manifold) — dissociates two learning regimes in the same circuit, same session, same behaviour:

| Regime | Perturbation | Learned in ~hours? | Authors' reading |
|---|---|---|---|
| **Re-associate existing patterns with new outcomes** | within-manifold | yes; leaves aftereffects | "the fast-timescale learning mechanisms that underlie **adaptation**" |
| **Generate new patterns** | outside-manifold | no; no aftereffects | "the neural mechanisms required for **skill learning**"; "might require the IM to expand or change orientation" |

**Why this is not the W/M split.** Both regimes are within-lifetime, within-circuit, and neither is cross-environment structural extraction. The dividing variable is whether the *repertoire of producible patterns* must change — which is orthogonal to whether the change is written to episodic or structural weights. A model could have a perfectly clean W/M factorization and still hit this wall, because the wall is about what the executor can emit at all.

**The timescale on the slow side is a proposal, not a measurement.** "Skill learning takes days" is what Sadtler's authors suggest their negative result implies; the experiment establishes only that it does not happen in a session. Statements elsewhere in this wiki that attributed a measured multi-day figure to this paper were overreading it.

**Design consequence.** If the corpus/pretraining stage is the analog of skill learning and the per-episode stage is the analog of adaptation, then the two-timescale architecture inherits an unmeasured boundary: nothing in the biology says how much repertoire extension a fast loop can buy, only that it bought none in the tested window. See [[wiki/concepts/neural-manifolds.md]] for the two nested boundaries and [[wiki/concepts/contextual-inference.md]] for the selection/invention consequence.

---

## Biological Plausibility Problem

W update requires backpropagation — no clear neural mechanism. Leading candidates: hippocampal replay during sleep (sends compressed sequences to cortex for structure extraction); [[wiki/concepts/predictive-coding.md]] error signals (local `Δw ∝ ε · x` rule — biologically plausible for within-environment learning, but cross-environment structural generalization remains open); theta-phase error-driven learning in HC (delta between retrieval and encoding sub-phases propagates to cortex during active encoding). None fully specified. This is the biggest gap between TEM's account and biology.

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — structural generalization is the purpose of W; the slow system extracts the shared relational vocabulary that makes generalization possible; fast M handles per-instance content.
- **[[wiki/concepts/factorized-representations.md]]** — W and M are the slow/fast update rules for the factorized codes: W updates the structural code and transition rules; M updates the episodic binding of g to x.
- **[[wiki/concepts/replay.md]]** — replay is the candidate biological mechanism for the slow W update: HC de-aliased sequences replayed during sleep → cortex extracts structural regularities across many environments.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — the dual map/memory roles of HC map onto the two timescales: early in a new environment HC = fast map builder; later HC = memory index that frees cortex to hold the slow structural model.
- **[[wiki/concepts/engrams.md]]** — engrams are the cellular substrate of fast M; CREB-mediated excitability competition is the biological softmax that produces sparse p codes; the CREB ~5–24h eligibility window is a third timescale (between fast-M and slow-W) not captured by TEM's idealized M; CREB also links temporally proximate memories via shared ensemble allocation and may bias SWR (Sharp Wave Ripple) participation (assembly consolidation hypothesis).
- **[[wiki/papers/lisman-memory-allocation-2018.md]]** — source for CREB as the third timescale mechanism: dual-pathway coincidence detection, allocate-to-link hypothesis with Ca²⁺ imaging confirmation, and assembly consolidation hypothesis linking CREB excitability to SWR (Sharp Wave Ripple) consolidation.
- **[[wiki/concepts/information-theory.md]]** — slow W and fast M each minimize cross-entropy over different distributions (cross-environment structural regularity vs. single-environment episodic binding); the two-timescale split is formally two nested KL (Kullback-Leibler) minimization problems with different data distributions.
- **[[wiki/concepts/predictive-coding.md]]** — the Free Energy Principle decomposes into exactly the same two-timescale structure: fast perceptual inference (minimize F w.r.t. recognition model activations, ~100ms) and slow learning (minimize F w.r.t. generative model weights), providing the principled theoretical justification for the slow-W/fast-M split.
- **[[wiki/papers/memory-gate-transcript.md]]** — SWR (Sharp Wave Ripple) consolidation timeline provides mechanistic specificity: awake SWRs bookmark via local HC plasticity (fast-M tagging); sleep SWRs perform repeated compressed transfer to cortex (slow-W); temporal compression to ~100ms enables cortical STDP.
- **[[wiki/concepts/cognitive-control.md]]** — Miller, Freedman & Wallis (2002) give the biological form of the split as two *representational formats*: sustained neural activity (broadcastable, instantly reconfigurable, capacity-limited — the fast/configuration store) vs. synaptic weights (local, inflexible, long-term — the slow structural store); explains why the task configuration must be held in activity and cannot be baked into weights.
- **[[wiki/queries/rule-changes-as-meta-graph-rules.md]]** — non-stationary topology does not defeat the W/M split; it forces M from write-once binding to *continuous* update (put the stationary rule-change generator in slow W, the mutating rule-config in fast M), with a genuine third timescale needed only for Nomic-class self-amendment.
- **[[wiki/entities/boltzmann-machine.md]]** — the contrastive Hebbian rule's two phases anticipate the timescale split: positive phase (data-clamped, local Hebbian binding) is a fast-M analog; negative phase (free-running model generating from slow weights) is a W-prior analog; the two-phase structure is the historical precursor to the FEP (Free Energy Principle) two-timescale decomposition.
- **[[wiki/papers/boltzmann-machine-transcript.md]]** — source for contrastive Hebbian learning and two-phase training structure.
- **[[wiki/entities/reservoir-computing.md]]** — the most extreme instantiation of the W/M split: reservoir = maximally slow W (frozen random, never updated); readout = maximally fast M (one-shot linear regression); shows that a fixed random structural basis plus adaptive readout is computationally sufficient for arbitrary temporal signals.
- **[[wiki/papers/reservoir-computing-transcript.md]]** — source for the echo-state framework and the fixed-W / trained-readout architecture.
- **[[wiki/concepts/neuromodulation.md]]** — ACh (learning rate α) is the neuromodulatory mechanism that switches HC between fast-M and slow-W modes; high ACh = storage (fast M write), low ACh = retrieval (W consultation); Doya 2002 gives this biological grounding.
- **[[wiki/papers/metalearning-neuromodulation-doya-2002.md]]** — source for ACh storage/retrieval switch, DA=TD error, and the closed metalearning loop across all four neuromodulators.
- **[[wiki/concepts/meta-learning.md]]** — meta-learning is the formal name for what the two-timescale split produces: the slow loop installs a fast algorithm; the fast algorithm runs in activations; Wang et al. 2018 (PFC meta-RL) is the most explicit instantiation.
- **[[wiki/papers/pfc-meta-rl-wang-2018.md]]** — demonstrates the two-timescale split in the PFC/BG circuit with frozen-weight LSTM: slow = Dopamine synaptic updates; fast = recurrent hidden-state RL algorithm.
- **[[wiki/concepts/working-memory.md]]** — provides a dedicated treatment of the four fast WM mechanisms (Hebbian M, LSTM hidden state, TRNN (Transition RNN) transient trajectory, STSP) and their capacity/energy/robustness trade-offs; working memory is the function the fast timescale implements.
- **[[wiki/papers/trnn-liu-2025.md]]** — source for TRNN (Transition RNN) as third fast mechanism; establishes that transient trajectory storage (no write step, no fixed point) outperforms attractor RNN on multi-item and spatial WM tasks.
- **[[wiki/papers/stsp-kozachkov-2022.md]]** — source for STSP (Short-Term Synaptic Plasticity) as fourth fast mechanism; NHP PFC (Prefrontal Cortex) empirical confirmation of activity-silent WM; PS-hebb structural robustness (50% ablation) and provable stability enabling modular composition.
- **[[wiki/concepts/associative-memory.md]]** — one-shot Hebbian learning (W = YᵀY/n) is the formal fast-M write mechanism; the actual molecular substrate in CA1 is BTSP (behavioral timescale synaptic plasticity), which integrates over seconds rather than millisecond spike pairs — functionally equivalent to a single-shot Hebbian write but mechanistically distinct; modern Hopfield exponential capacity O(exp d) is what TEM-t exploits over the linear-capacity classical version.
- **[[wiki/papers/learning-fast-slow-liao-2024.md]]** — source for BTSP/STDP within-HC two-timescale hierarchy; speed-amplitude trade-off unifying both rules; adaptive replay selectivity and inhibitory plasticity as the mechanism that filters non-generalizable content from SWR (Sharp Wave Ripple) consolidation.
- **[[wiki/entities/place-cells.md]]** — BTSP is the mechanism by which place cells acquire new fields in single trials; the DG (Dentate Gyrus) competitive learning that forms place fields from grid inputs feeds into CA1 where BTSP writes the actual field in one shot.
- **[[wiki/papers/cls-mcclelland-1995.md]]** — foundational CLS (Complementary Learning Systems) paper providing the formal computational necessity argument: catastrophic interference (McCloskey & Cohen 1989) proves a monolithic system cannot do both; interleaved training (Rumelhart 1990) proves structured generalization requires a mixed diverse stream; statistical learning theory grounds why slow-W updates must be small and distributed.
- **[[wiki/papers/cls-oreilly-2011.md]]** — 2011 CLS (Complementary Learning Systems) update adding biological mechanism detail: theta-phase error-driven learning (delta-rule at 4–8 Hz inside HC); consolidation as transformation not transfer; bidirectional HC-neocortex synergy. Builds on the 1995 necessity argument with architectural specifics.
- **[[wiki/concepts/contextual-inference.md]]** — adds *apparent learning*, a behaviour-change mode that writes to neither store: the context posterior re-weights how much each existing memory is expressed. Savings, anterograde interference, and consistency effects — three phenomena this page's framework would attribute to W or M — are reproduced with the Kalman gain and states held fixed, so behavioural adaptation alone cannot identify which store changed.
- **[[wiki/queries/action-semantics-contextual-inference.md]]** — applies the split to *action semantics*: slow W should learn the *manifold of possible operators* and fast M should bind action-pointer → operator per environment — never a trained `action → effect` function, which averages conflicting contexts.
- **[[wiki/papers/sadtler-neural-constraints-learning-2014.md]]** — source for the adaptation/skill-learning dissociation: within-manifold BCI perturbations are learned in a session and leave aftereffects, outside-manifold ones are not learned and leave none, with five alternative explanations experimentally matched. The split is *repertoire re-use vs. repertoire extension* and is orthogonal to this page's W/M axis.
- **[[wiki/concepts/neural-manifolds.md]]** — supplies the object the adaptation/skill split is defined over: what the executor can emit. The manifold and the repertoire within it are two nested boundaries, and both sit across the fast/slow axis rather than along it.
- **[[wiki/concepts/arbitrary-mapping.md]]** — the action-semantics form of the split, with a caveat this page's framing must absorb: the arbitrary-visuomotor-mapping lesion data give an **asymmetric** dissociation, not a clean fast-acquire/slow-retain division of labor. Hippocampectomy impairs *novel* mappings while sparing pre-lesion ones, but PMd lesions impair *both* — so what the two timescales dissociate is **which circuit drops out with overlearning** (HC), not which circuit does acquisition vs. execution (premotor does both). Also supplies the binding-rate benchmark: ~3 trials/cue.
- **[[wiki/concepts/abstract-reasoning.md]]** — the W/M split is the computational implementation of model-building: slow W encodes the causal-structural world model; fast M binds new instances to it within an episode; together they enable one-shot transfer across novel tasks rather than relearning from scratch.
- **[[wiki/papers/building-machine-thinks-like-people-lake-2016.md]]** — cognitive science grounding for why two timescales are necessary: the 924h vs. 15-minute Frostbite gap is the efficiency difference between a monolithic pattern-recognizer (single slow system) and a model-builder with separate structural (W) and episodic (M) systems.
- **[[wiki/entities/basal-ganglia.md]]** — BG (Basal Ganglia) is the biological substrate for the SPEED slow-W writing mechanism: direct-pathway Dopamine RL trains cortico-cortical Hebbian connections that become the permanent, BG (Basal Ganglia)-independent substrate for automatic skills; also the meta-RL slow-loop trainer for PFC (Prefrontal Cortex) LSTM weights.
- **[[wiki/papers/helie-ccn-bg-2013.md]]** — source for SPEED automaticity model and the three-route slow-W comparison (consolidation vs. meta-RL vs. SPEED); also TAN catastrophic interference prevention as the BG (Basal Ganglia)-level analog of CLS (Complementary Learning Systems) interference protection.
- **[[wiki/entities/trnn-model.md]]** — TRNN (Transition RNN) is the recommended Block 3B episodic layer — transient trajectory coding is a third fast-M mechanism complementary to Hebbian M and LSTM hidden state.
- **[[wiki/concepts/hebbian-learning.md]]** — the fast-M write is a Hebbian operation ($W = Y^\top Y / n$); BTSP and STDP are its molecular substrates at behavioral and spike timescales respectively; Hebbian instability is the formal reason fast-M writes require sparse SDR (Sparse Distributed Representations) codes — unconstrained co-activation produces exponentially diverging weights.
- **[[wiki/entities/vector-hash-model.md]]** — Vector-HaSH formalizes the fast-M operation as *heteroassociation* (plastic HC↔neocortex bidirectional weights), distinct from the scaffold (fixed grid-HC circuit); the scaffold plays an intermediate developmental role between slow-W (structural extraction) and fast-M (episodic binding) — it is neither, but enables fast-M writes to be interference-free.
- **[[wiki/papers/vector-hash-chandra-2023.md]]** — source for the scaffold/heteroassociation decomposition of the fast-M system; sequence memory via shift operator as an efficient low-dimensional alternative to pairwise cortical associations.
- **[[wiki/entities/sdm-model.md]]** — SDM's fixed-**A** / modifiable-**C** decomposition is the most explicit circuit-level instantiation of the slow-W/fast-M split: the address matrix **A** (random, never updated) = slow-W analog; the contents matrix **C** (Hebbian per episode) = fast-M; this is not just a conceptual analogy but an exact correspondence with distinct synapse populations.
- **[[wiki/papers/kanerva-sdm-1993.md]]** — source for the fixed-A/variable-C architecture and its biological grounding in both HC (random granule cell connectivity = fixed address structure, CA3 synapses = content) and cerebellum (granule cell connectivity = fixed, Purkinje fiber synapses = LTD-trained).
- **[[wiki/entities/cerebellum.md]]** — cerebellar A (granule cell random connectivity, fixed) / C (parallel fiber synapses, trained via climbing fiber LTD) is a second biological realization of the slow/fast split in a motor learning circuit; confirms that the A-fixed/C-plastic decomposition is a domain-general biological design principle, not hippocampus-specific.
- **[[wiki/concepts/neoteny.md]]** — neoteny is a *developmental schedule* on the slow-W end: it defers the freezing/pruning of structural (synaptic) weights, keeping W malleable longer. Somel 2009's finding that the human delay is mosaic (gray-matter/synaptic genes) and peaks at adolescent pruning localizes the deferral to exactly the slow-W consolidation stage — a biological argument for a graded, subsystem-specific plasticity taper rather than a single global learning-rate schedule.
- **[[wiki/concepts/adult-neurogenesis.md]]** — adult neurogenesis operates within the fast-M timescale but at the level of capacity maintenance: BTSP is the fast-M write mechanism; neurogenesis is the capacity renewal mechanism that prevents the fast-M store from saturating; both are HC fast-timescale processes at different functional levels.
- **[[wiki/papers/pcm-l2l-ortner-2025.md]]** — explicitly instantiates three biological timescales in hardware: evolutionary/developmental outer meta-training (slow W, in software); rapid task-specific inner adaptation (<4 steps, on PCM crossbar); PCM non-volatile weights as a silicon realization of the W/M split where only ~1% of devices are re-written per task.
- **[[wiki/entities/snn.md]]** — natural e-prop's eligibility trace $e_{jk}^t$ is the SNN fast-M write mechanism for temporal credit: it accumulates locally until gated by the LSG learning signal; the LSG+eligibility-trace system is the biological equivalent of the ACh/DA neuromodulatory gating of the fast-M write step.
- **[[wiki/concepts/credit-assignment.md]]** — e-prop's eligibility trace + externalized learning signal decomposes temporal credit assignment into a local component (eligibility trace per synapse) and a global component (LSG signal per neuron); this is the most biologically precise implementation of the temporal credit problem's solution in this wiki.
- **[[wiki/concepts/temporal-multiplexing.md]]** — the slow W / fast M two-timescale learning split is the learning analog of the connectome's parallel processing streams: just as the brain runs γ through infraslow streams concurrently at different speeds, W and M operate on different temporal scales simultaneously rather than sequentially; both principles assert that concurrent multi-timescale operation is the rule, not the exception, in biological cognition.
- **[[wiki/papers/prefrontal-atrophy-nrem-mander-2013.md]]** — source for SWA as the oscillatory scaffold for sleep SWR transfer; mPFC atrophy → ↓SWA → ↓slow-W transfer; HC-independence during retrieval as the measurable endpoint of successful slow-W installation in cortex.
- **[[wiki/papers/fact-finding-factual-recall-nanda-2023.md]]** — mechanistic counterexample showing standard transformers use a slow (W-like) learning process to store what is functionally M-like content (pure memorization, no macrofeatures); reveals transformers lack any physically separate fast-M pathway, unlike CLS's two-substrate solution.
- **[[wiki/entities/transformer-model.md]]** — the factual-recall circuit (token concatenation → MLP lookup → attribute extraction) is the concrete transformer instantiation of the "jointly trained, entangled, single timescale" row in the W/M spectrum table.
- **[[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]]** — runs the W/M split *as the reasoning dynamic*: transition error routes to slow W (`ε_x → {W, V(a)}`), episode bindings write to fast M (`p → M`, ACh-gated), and offline consolidation (`M → schema`) is the *compilation* step where an effortful searched path is cached into fast, near-straight System-1 path integration. Cross-environment "savings" is really consolidation into mPFC schema slow-W, not raw M persistence.
