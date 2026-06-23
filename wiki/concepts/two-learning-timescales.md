---
title: "Two Learning Timescales"
type: concept
tags: [learning, memory, complementary-learning-systems, fast-slow-learning, hebbian, replay]
created: 2026-06-09
updated: 2026-06-22
sources: [engram-transcript, memory-gate-transcript, bolzman-machine-transcript, reservoir-computing-transcript, Metalearning_and_Neuromodulation, PFC_as_a_meta_RL_system, Recurrent neural networks with transient trajectory explain working memory encoding mechanisms, Robust and brain-like working memory through short-term synaptic plasticity, Hopfield Networks Neural Memory Machines, Complementary Learning Systems, Complementary learning systems Why - Claude summary, Learning Fast and Slow Single- and Many-Shot Learning in the Hippocampus, Exploring the cognitive and motor functions of the basal ganglia an integrative review of computational cognitive neuroscience models, High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations, kanerva-sdm-1993]
related: [wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/replay.md, wiki/concepts/engrams.md, wiki/concepts/information-theory.md, wiki/concepts/predictive-coding.md, wiki/concepts/neuromodulation.md, wiki/concepts/meta-learning.md, wiki/concepts/working-memory.md, wiki/concepts/associative-memory.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/hebbian-learning.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/tem-model.md, wiki/entities/boltzmann-machine.md, wiki/entities/reservoir-computing.md, wiki/entities/place-cells.md, wiki/entities/basal-ganglia.md, wiki/entities/trnn-model.md, wiki/entities/vector-hash-model.md, wiki/papers/engram-transcript.md, wiki/papers/memory-gate-transcript.md, wiki/papers/boltzmann-machine-transcript.md, wiki/papers/reservoir-computing-transcript.md, wiki/papers/metalearning-neuromodulation-doya-2002.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/trnn-liu-2025.md, wiki/papers/stsp-kozachkov-2022.md, wiki/papers/hopfield-networks-crouse-2022.md, wiki/papers/cls-oreilly-2011.md, wiki/papers/cls-mcclelland-1995.md, wiki/papers/learning-fast-slow-liao-2024.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md, wiki/papers/helie-ccn-bg-2013.md, wiki/papers/vector-hash-chandra-2023.md, wiki/entities/sdm-model.md, wiki/papers/kanerva-sdm-1993.md, wiki/entities/cerebellum.md]
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
| **Brain analog** | MEC/cortex long-term plasticity | Hippocampal LTP |

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
| **Retrieval (minus)** | CA3 strong, EC weak | Expectation: prior memory recalled from CA3 attractor |
| **Encoding (plus)** | EC strong, CA3 weak | Outcome: actual current input from EC drives CA3/CA1 |

The difference — `Δ = encoding_activity − retrieval_activity` — is a prediction error driving Leabra-style contrastive Hebbian weight updates inside HC. HC continuously corrects its own retrieval errors at theta frequency rather than only writing new content Hebbianly.

**Implications for the two-timescale picture:**
- The fast-M system has an internal error signal, not just a write mechanism; this makes fast-M updates more accurate under repeated exposure to the same episode.
- Theta-phase error signals in HC may feed into cortical plasticity during encoding — a candidate biological mechanism for the W-update biological plausibility problem.
- The ACh neuromodulatory switch sets a coarser bias (encoding vs. retrieval mode); theta oscillates *within* that bias, providing fine-grained alternation regardless of ACh state.

---

## SWR Consolidation Timeline

Sharp wave ripples (Science 2024) provide mechanistic specificity to the HC→cortex transfer:

| Phase | SWR type | Function | Temporal constraint |
|-------|----------|----------|---------------------|
| Waking pauses (post-reward) | **Awake SWR** | Tag: replay recent trajectory; trigger local HC plasticity priming patterns for sleep | Cortex not consolidation-receptive; HC must maintain ongoing map — cannot consolidate in parallel |
| Sleep | **Sleep SWR** | Transfer: repeatedly replay bookmarked sequences (10–20× compressed) to cortex | Cortex enters receptive state; many repetitions needed; HC freed from online mapping |

**Temporal compression (~100ms per replay)** is mechanistically necessary: compressed replays arrive within cortical STDP windows, enabling synaptic strengthening. Without compression, replay would fail to drive cortical plasticity at the timescale of sleep oscillations.

**Mapping onto W/M split:**
- Awake SWR = fast M tagging: local Hebbian plasticity within HC marks which episodic patterns matter
- Sleep SWR = slow W transfer: repeated compressed sequences drive cortical weight updates across many environments over many nights

---

## Engrams as the Biological Fast-M Substrate

Engram research [[wiki/concepts/engrams.md]] makes the fast M system concrete at the cellular level:

- **Which cells get written:** excitability competition via inhibitory interneurons — the most excitable cells at training time suppress neighbors and win allocation. This is the biological softmax: winner-take-most with lateral inhibition enforcing sparsity.
- **How sparse:** 2–6% in dentate gyrus; 10–20% in amygdala — homeostically conserved across memory strength and valence. TEM assumes sparse p codes; engram data specifies the quantitative constraint.
- **Temporal interference:** elevated excitability persists ~5–24h. Events within this window share neurons → linked memories. TEM's idealized M treats each environment independently; biology introduces a time-dependent interference channel that could couple or corrupt episodic bindings.

**CREB as a third timescale.** The molecular mechanism behind the linkage window is CREB (cAMP-responsive element-binding protein): LTP at encoding triggers the ERK→CREB cascade; CREB reduces K⁺ conductance for hours; recently-potentiated neurons remain more excitable, biasing allocation for subsequent memories. This defines a **third learning timescale** that interpolates between fast-M (seconds, BTSP single-shot write) and slow-W (days–years, SWR replay consolidation):

| Timescale | Mechanism | Duration | Function |
|---|---|---|---|
| **Fast M** | BTSP / STDP synaptic write | Seconds | Encode node or edge content |
| **CREB eligibility** | K⁺ conductance reduction via ERK→CREB | Hours (~5–24h) | Bias allocation, link temporally proximate memories |
| **Slow W** | SWR replay → cortical STDP | Nights / years | Extract cross-environment structural regularity |

The CREB timescale is not a memory store — it is an eligibility window that determines *which* fast-M writes form a linked cluster. Assembly consolidation hypothesis adds a second CREB-timescale effect: CREB-elevated cells are more likely to be recruited into SWRs, biasing the awake-SWR bookmarking step toward recently-potentiated cells — coupling the CREB hours-timescale directly to the consolidation pipeline.

---

## PFC/BG Instantiation — Meta-RL

Wang et al. 2018 ([[wiki/papers/pfc-meta-rl-wang-2018.md]]) provides the sharpest single-circuit demonstration of the two-timescale principle, in a different brain region and with a different fast mechanism than the TEM/HC account:

| | Slow (W analog) | Fast (M analog) |
|--|---|---|
| **TEM / HC** | Backprop updates W across environments | Hebbian M binds g to x content per episode |
| **PFC / BG (meta-RL)** | DA-driven A3C updates PFC+BG synaptic weights across episodes | LSTM recurrent hidden state accumulates (o, a, r) history — no weight change |

The fast system differs critically: TEM's M is an explicit Hebbian write of content into a weight matrix; PFC meta-RL stores episode history implicitly in the LSTM hidden state, and this hidden state *is* the running RL algorithm (value estimate, policy, exploration state). There is no write step — memory is carried forward by recurrent dynamics.

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

## SPEED: BG as Training Scaffold for Cortical Automaticity

The SPEED model (Ashby et al. 2007 in Helie et al. 2013 [[wiki/papers/helie-ccn-bg-2013.md]]) provides a third slow-W writing mechanism distinct from HC-cortex consolidation and meta-RL weight updates:

**Mechanism:** BG direct pathway trains cortico-cortical connections via dopamine RL. Consistent BG-mediated selection of the correct action in premotor cortex → co-activation of sensory association cortex (input) and premotor cortex (output) → Hebbian LTP on the direct cortico-cortical route. Once the route is strong enough to fire autonomously, BG is no longer required for execution.

| Phase | BG role | Cortical result |
|---|---|---|
| **Early training** | Active — DA RL drives corticostriatal selection, ensuring consistent premotor firing | Hebbian LTP accumulates on direct cortico-cortical route |
| **Late / automatic** | Withdrawn — cortico-cortical connection sufficient for execution | Stimulus activates sensory cortex → premotor cortex without BG |

**Comparison to other slow-W routes:**

| Route | Scope | Mechanism | Timescale |
|---|---|---|---|
| **HC-cortex consolidation** | Cross-environment structural regularities | SWR replay → STDP during sleep | Nights/years |
| **Meta-RL (DA synaptic)** | Cross-episode task structure | DA-driven A3C weight updates in PFC/BG | Episodes/days |
| **SPEED automaticity** | Single task-specific skill | BG bootstraps Hebbian cortico-cortical LTP, then withdraws | Trials/weeks |

**Empirical confirmation:** GPi inactivation (Desmurget & Turner 2010) disrupts movement kinematics but not learned sequence knowledge — the compiled cortical route survives BG disconnection. SPEED accounts for this dissociation; Nakahara's visual→motor sequence model cannot.

**For reasoning models:** Frequently-used reasoning patterns (e.g., a practiced ARC transformation type) should progressively compile into direct cortical routes, with BG participation becoming unnecessary for execution. This implies an agent's cognitive architecture should have a mechanism for BG to progressively hand off execution of mastered skills to cortex — pure BG-gating models that require BG at every step cannot achieve this.

---

## TRNN and STSP: Third and Fourth Fast Mechanisms

Liu et al. 2025 ([[wiki/papers/trnn-liu-2025.md]]) and Kozachkov et al. 2022 ([[wiki/papers/stsp-kozachkov-2022.md]]) establish two additional distinct fast mechanisms:

| | Slow (W analog) | Fast (M analog) | Storage medium |
|--|---|---|---|
| **TEM / HC** | Backprop updates W across environments | Hebbian M: explicit synaptic write of g⊗x content | Synaptic weight matrix M |
| **PFC / BG (meta-RL)** | DA-driven weight updates across episodes | LSTM hidden state: gated recurrent accumulation | Recurrent activation vector h_t |
| **TRNN** | Backprop trains self-inhibition + connectivity bias | Transient trajectory: sequential neuron chain, no write step | Sequential firing chain |
| **STSP / PS-hebb** | Backprop trains recurrent skeleton; calcium constants fixed | Synaptic efficacy: spikes drive calcium dynamics, modifying weights transiently | Synaptic efficacy state (calcium) |

**TRNN:** no write step — memory propagates by self-inhibition forcing sequential chain. Wins on multi-item capacity and spatial WM vs. vanilla LSTM. Lacks within-episode RL algorithm.

**STSP:** no write step — spikes automatically drive calcium dynamics that transiently modify synaptic efficacy. Storage is in synaptic state, not neural state → activity-silent during maintenance, burst spiking only during readout. Empirically confirmed in NHP PFC (Kozachkov 2022). Structurally robust: 50% synapse ablation tolerated. Anti-Hebbian excitatory rule (PS-hebb) provides provable stability enabling modular composition.

**Capacity comparison (same parameter count):**
- Hebbian M (linear Hopfield): O(N/log N) items
- Modern Hopfield (TEM-t): O(exp d) items, single-pass
- LSTM hidden state: bounded by hidden dimension; no slot interpretation
- TRNN transient trajectory: scales with neuron count N
- STSP (PS-hebb): bounded by calcium decay timescale (~200ms); capacity in terms of items not yet characterized

---

## SDM A/C Split: Circuit-Level Instantiation of the Slow/Fast Timescale

Kanerva's **Sparse Distributed Memory (SDM)** [[wiki/entities/sdm-model.md]] makes the slow-W/fast-M distinction concrete at the level of two distinct synaptic populations with physically different update rules:

| SDM component | Timescale analog | Biological parallel |
|---|---|---|
| Hard-address matrix **A** (random, never modified) | Slow-W: structural projection scaffold | MEC grid cell weights; Vector-HaSH scaffold; DG granule cell mossy-fiber connectivity |
| Contents matrix **C** (Hebbian write per episode) | Fast-M: episodic content accumulation | HC mossy fiber → CA3 synaptic weights; parallel fiber → Purkinje LTD |

**Key property:** **A** is sampled at random once during construction and never updated — it provides the stable address vocabulary into which all episodic writes are indexed. **C** accumulates outer-product Hebbian writes from each episode. This is the most explicit circuit-level implementation of the two-timescale split: not just "slow weights vs. fast activations" but two distinct synapse populations with physically different update rules (none for **A**, Hebbian for **C**).

**Why this matters architecturally:** SDM proves that the structural projection (**A**) does not need to be learned — a random draw already provides near-orthogonal addressing for any uniform random input distribution, with activation-set overlaps of only p² × M ≈ 0 for typical p. The only thing requiring episodic writes is the content layer (**C**). This licenses the design choice (confirmed by Vector-HaSH [[wiki/entities/vector-hash-model.md]]) of holding the fast-M store's address scaffold fixed while training only its content layer — the simplest biologically realizable version of the slow/fast factorization.

---

## Cholinergic Gating of the Timescale Switch

Doya 2002 ([[wiki/concepts/neuromodulation.md]]) provides the biological signal that determines which timescale is active at any moment:

| ACh level | HC mode | W/M analog |
|---|---|---|
| **High** | **Storage** — CA3→CA1 Schaffer collateral suppressed; LEC→CA1 encoding enabled | Fast-M write: new episodic binding |
| **Low** | **Retrieval** — CA3 pattern completion restored; LEC input de-emphasized | Slow-W consultation: retrieve structural model |

ACh is released by basal forebrain cholinergic neurons in response to novelty and task demand, then declines as familiarity increases. The same metalearning loop that suppresses ACh (α ↓) when DA sign reversals stabilize also signals when to transition from encoding to retrieval — the system self-schedules the M→W handoff.

This grounds Block 2C (surprise-gated write) in the building-blocks decomposition: the write gate `σ(prediction_error)` approximates the ACh-mediated learning rate; high prediction error ≈ high novelty ≈ high ACh ≈ fast-M write mode.

---

## Biological Plausibility Problem

W update requires backpropagation — no clear neural mechanism. Leading candidates: hippocampal replay during sleep (sends compressed sequences to cortex for structure extraction); [[wiki/concepts/predictive-coding.md]] error signals (local `Δw ∝ ε · x` rule — biologically plausible for within-environment learning, but cross-environment structural generalization remains open); theta-phase error-driven learning in HC (delta between retrieval and encoding sub-phases propagates to cortex during active encoding). None fully specified. This is the biggest gap between TEM's account and biology.

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — structural generalization is the purpose of W; the slow system extracts the shared relational vocabulary that makes generalization possible; fast M handles per-instance content.
- **[[wiki/concepts/factorized-representations.md]]** — W and M are the slow/fast update rules for the factorized codes: W updates the structural code and transition rules; M updates the episodic binding of g to x.
- **[[wiki/concepts/replay.md]]** — replay is the candidate biological mechanism for the slow W update: HC de-aliased sequences replayed during sleep → cortex extracts structural regularities across many environments.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — the dual map/memory roles of HC map onto the two timescales: early in a new environment HC = fast map builder; later HC = memory index that frees cortex to hold the slow structural model.
- **[[wiki/concepts/engrams.md]]** — engrams are the cellular substrate of fast M; CREB-mediated excitability competition is the biological softmax that produces sparse p codes; the CREB ~5–24h eligibility window is a third timescale (between fast-M and slow-W) not captured by TEM's idealized M; CREB also links temporally proximate memories via shared ensemble allocation and may bias SWR participation (assembly consolidation hypothesis).
- **[[wiki/papers/lisman-memory-allocation-2018.md]]** — source for CREB as the third timescale mechanism: dual-pathway coincidence detection, allocate-to-link hypothesis with Ca²⁺ imaging confirmation, and assembly consolidation hypothesis linking CREB excitability to SWR consolidation.
- **[[wiki/concepts/information-theory.md]]** — slow W and fast M each minimize cross-entropy over different distributions (cross-environment structural regularity vs. single-environment episodic binding); the two-timescale split is formally two nested KL minimization problems with different data distributions.
- **[[wiki/concepts/predictive-coding.md]]** — the Free Energy Principle decomposes into exactly the same two-timescale structure: fast perceptual inference (minimize F w.r.t. recognition model activations, ~100ms) and slow learning (minimize F w.r.t. generative model weights), providing the principled theoretical justification for the slow-W/fast-M split.
- **[[wiki/papers/memory-gate-transcript.md]]** — SWR consolidation timeline provides mechanistic specificity: awake SWRs bookmark via local HC plasticity (fast-M tagging); sleep SWRs perform repeated compressed transfer to cortex (slow-W); temporal compression to ~100ms enables cortical STDP.
- **[[wiki/entities/boltzmann-machine.md]]** — the contrastive Hebbian rule's two phases anticipate the timescale split: positive phase (data-clamped, local Hebbian binding) is a fast-M analog; negative phase (free-running model generating from slow weights) is a W-prior analog; the two-phase structure is the historical precursor to the FEP two-timescale decomposition.
- **[[wiki/papers/boltzmann-machine-transcript.md]]** — source for contrastive Hebbian learning and two-phase training structure.
- **[[wiki/entities/reservoir-computing.md]]** — the most extreme instantiation of the W/M split: reservoir = maximally slow W (frozen random, never updated); readout = maximally fast M (one-shot linear regression); shows that a fixed random structural basis plus adaptive readout is computationally sufficient for arbitrary temporal signals.
- **[[wiki/papers/reservoir-computing-transcript.md]]** — source for the echo-state framework and the fixed-W / trained-readout architecture.
- **[[wiki/concepts/neuromodulation.md]]** — ACh (learning rate α) is the neuromodulatory mechanism that switches HC between fast-M and slow-W modes; high ACh = storage (fast M write), low ACh = retrieval (W consultation); Doya 2002 gives this biological grounding.
- **[[wiki/papers/metalearning-neuromodulation-doya-2002.md]]** — source for ACh storage/retrieval switch, DA=TD error, and the closed metalearning loop across all four neuromodulators.
- **[[wiki/concepts/meta-learning.md]]** — meta-learning is the formal name for what the two-timescale split produces: the slow loop installs a fast algorithm; the fast algorithm runs in activations; Wang et al. 2018 (PFC meta-RL) is the most explicit instantiation.
- **[[wiki/papers/pfc-meta-rl-wang-2018.md]]** — demonstrates the two-timescale split in the PFC/BG circuit with frozen-weight LSTM: slow = DA synaptic updates; fast = recurrent hidden-state RL algorithm.
- **[[wiki/concepts/working-memory.md]]** — provides a dedicated treatment of the four fast WM mechanisms (Hebbian M, LSTM hidden state, TRNN transient trajectory, STSP) and their capacity/energy/robustness trade-offs; working memory is the function the fast timescale implements.
- **[[wiki/papers/trnn-liu-2025.md]]** — source for TRNN as third fast mechanism; establishes that transient trajectory storage (no write step, no fixed point) outperforms attractor RNN on multi-item and spatial WM tasks.
- **[[wiki/papers/stsp-kozachkov-2022.md]]** — source for STSP as fourth fast mechanism; NHP PFC empirical confirmation of activity-silent WM; PS-hebb structural robustness (50% ablation) and provable stability enabling modular composition.
- **[[wiki/concepts/associative-memory.md]]** — one-shot Hebbian learning (W = YᵀY/n) is the formal fast-M write mechanism; the actual molecular substrate in CA1 is BTSP (behavioral timescale synaptic plasticity), which integrates over seconds rather than millisecond spike pairs — functionally equivalent to a single-shot Hebbian write but mechanistically distinct; modern Hopfield exponential capacity O(exp d) is what TEM-t exploits over the linear-capacity classical version.
- **[[wiki/papers/learning-fast-slow-liao-2024.md]]** — source for BTSP/STDP within-HC two-timescale hierarchy; speed-amplitude trade-off unifying both rules; adaptive replay selectivity and inhibitory plasticity as the mechanism that filters non-generalizable content from SWR consolidation.
- **[[wiki/entities/place-cells.md]]** — BTSP is the mechanism by which place cells acquire new fields in single trials; the DG competitive learning that forms place fields from grid inputs feeds into CA1 where BTSP writes the actual field in one shot.
- **[[wiki/papers/cls-mcclelland-1995.md]]** — foundational CLS paper providing the formal computational necessity argument: catastrophic interference (McCloskey & Cohen 1989) proves a monolithic system cannot do both; interleaved training (Rumelhart 1990) proves structured generalization requires a mixed diverse stream; statistical learning theory grounds why slow-W updates must be small and distributed.
- **[[wiki/papers/cls-oreilly-2011.md]]** — 2011 CLS update adding biological mechanism detail: theta-phase error-driven learning (delta-rule at 4–8 Hz inside HC); consolidation as transformation not transfer; bidirectional HC-neocortex synergy. Builds on the 1995 necessity argument with architectural specifics.
- **[[wiki/concepts/abstract-reasoning.md]]** — the W/M split is the computational implementation of model-building: slow W encodes the causal-structural world model; fast M binds new instances to it within an episode; together they enable one-shot transfer across novel tasks rather than relearning from scratch.
- **[[wiki/papers/building-machine-thinks-like-people-lake-2016.md]]** — cognitive science grounding for why two timescales are necessary: the 924h vs. 15-minute Frostbite gap is the efficiency difference between a monolithic pattern-recognizer (single slow system) and a model-builder with separate structural (W) and episodic (M) systems.
- **[[wiki/entities/basal-ganglia.md]]** — BG is the biological substrate for the SPEED slow-W writing mechanism: direct-pathway DA RL trains cortico-cortical Hebbian connections that become the permanent, BG-independent substrate for automatic skills; also the meta-RL slow-loop trainer for PFC LSTM weights.
- **[[wiki/papers/helie-ccn-bg-2013.md]]** — source for SPEED automaticity model and the three-route slow-W comparison (consolidation vs. meta-RL vs. SPEED); also TAN catastrophic interference prevention as the BG-level analog of CLS interference protection.
- **[[wiki/entities/trnn-model.md]]** — TRNN is the recommended Block 3B episodic layer — transient trajectory coding is a third fast-M mechanism complementary to Hebbian M and LSTM hidden state.
- **[[wiki/concepts/hebbian-learning.md]]** — the fast-M write is a Hebbian operation ($W = Y^\top Y / n$); BTSP and STDP are its molecular substrates at behavioral and spike timescales respectively; Hebbian instability is the formal reason fast-M writes require sparse SDR codes — unconstrained co-activation produces exponentially diverging weights.
- **[[wiki/entities/vector-hash-model.md]]** — Vector-HaSH formalizes the fast-M operation as *heteroassociation* (plastic HC↔neocortex bidirectional weights), distinct from the scaffold (fixed grid-HC circuit); the scaffold plays an intermediate developmental role between slow-W (structural extraction) and fast-M (episodic binding) — it is neither, but enables fast-M writes to be interference-free.
- **[[wiki/papers/vector-hash-chandra-2023.md]]** — source for the scaffold/heteroassociation decomposition of the fast-M system; sequence memory via shift operator as an efficient low-dimensional alternative to pairwise cortical associations.
- **[[wiki/entities/sdm-model.md]]** — SDM's fixed-**A** / modifiable-**C** decomposition is the most explicit circuit-level instantiation of the slow-W/fast-M split: the address matrix **A** (random, never updated) = slow-W analog; the contents matrix **C** (Hebbian per episode) = fast-M; this is not just a conceptual analogy but an exact correspondence with distinct synapse populations.
- **[[wiki/papers/kanerva-sdm-1993.md]]** — source for the fixed-A/variable-C architecture and its biological grounding in both HC (random granule cell connectivity = fixed address structure, CA3 synapses = content) and cerebellum (granule cell connectivity = fixed, Purkinje fiber synapses = LTD-trained).
- **[[wiki/entities/cerebellum.md]]** — cerebellar A (granule cell random connectivity, fixed) / C (parallel fiber synapses, trained via climbing fiber LTD) is a second biological realization of the slow/fast split in a motor learning circuit; confirms that the A-fixed/C-plastic decomposition is a domain-general biological design principle, not hippocampus-specific.
