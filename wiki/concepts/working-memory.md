---
title: "Working Memory"
type: concept
tags: [working-memory, transient-trajectory, attractor, RNN, PFC, delay-period, recurrent-networks, STSP, activity-silent]
created: 2026-06-19
updated: 2026-06-23
sources: [Recurrent neural networks with transient trajectory explain working memory encoding mechanisms, PFC_as_a_meta_RL_system, PBWM_oreilly_frank_2006, Robust and brain-like working memory through short-term synaptic plasticity, transformer_wm_limit, The role of prefrontal cortex in cognitive control and executive function, Exploring the cognitive and motor functions of the basal ganglia an integrative review of computational cognitive neuroscience models, Spike frequency adaptation bridging neural models and neuromorphic applications, Hybrid computing using a neural network with dynamic external memory, maass-lsm-2002]
related: [wiki/concepts/two-learning-timescales.md, wiki/concepts/meta-learning.md, wiki/concepts/neural-manifolds.md, wiki/concepts/neuromodulation.md, wiki/concepts/binding-problem.md, wiki/concepts/attention.md, wiki/concepts/cognitive-control.md, wiki/concepts/associative-memory.md, wiki/concepts/spike-frequency-adaptation.md, wiki/concepts/sequence-memory.md, wiki/entities/reservoir-computing.md, wiki/entities/prefrontal-cortex.md, wiki/entities/basal-ganglia.md, wiki/entities/trnn-model.md, wiki/entities/dnc-model.md, wiki/papers/trnn-liu-2025.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/pbwm-oreilly-frank-2006.md, wiki/papers/stsp-kozachkov-2022.md, wiki/papers/transformer-wm-limit-gong-2024.md, wiki/papers/pfc-cognitive-control-friedman-2021.md, wiki/papers/helie-ccn-bg-2013.md, wiki/papers/bogacz-gurney-bg-msprt-2007.md, wiki/papers/sfa-ganguly-2024.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/papers/long-sequence-hopfield-chaudhry-2023.md, wiki/papers/dnc-graves-2016.md, wiki/entities/gwt-model.md, wiki/papers/gnw-mashour-2020.md, wiki/papers/maass-lsm-2002.md]
---

# Working Memory

**WM is the capacity to hold a limited set of task-relevant information in an accessible state for seconds, bridging perception and action across a delay. The mechanistic question is whether this bridge is implemented by persistent neural attractors or by dynamic transient trajectories.**

---

## The Central Debate

| Theory | Mechanism | Evidence for | Evidence against |
|---|---|---|---|
| **Attractor / persistent activity** | Recurrent excitation holds activity at fixed point during delay | Early single-unit recordings (Fuster 1971; Goldman-Rakic); bump attractor models of spatial WM | Majority of recorded PFC neurons show transient, not persistent, delay activity (Stokes 2013; Shafi 2007) |
| **Transient trajectory** | Sequential neuron chain tiles the delay period; memory in trajectory path, not a point | Brain-wide activity waves in mice (Huang et al. 2023); TRNN outperforms vanilla RNN on all WM tasks | Trajectory must reach correct state at test time despite variable trajectory duration |
| **Population / stable subspace** | Trajectory varies but projects stably onto a low-D subspace | Murray 2017 (stable subspace coexisting with dynamics) | Does not specify encoding mechanism, only observation |
| **Activity-silent (STSP)** | Short-term synaptic plasticity holds traces in modified synaptic efficacy; spikes "ping" the synaptic state during readout | Mongillo 2008; Masse 2019; **Kozachkov 2022: NHP PFC decoder drops to chance during delay — STSP-RNN matches; attractor-RNN does not** | Synaptic state timescale (~200ms calcium decay) limits unaided bridge duration; spatial hold-and-go tasks show persistent spiking (motor inhibition, not pure WM) |
| **Oscillatory / phase coding** | Items encoded in distinct gamma cycles nested in theta | Lisman & Idiart 1995 (7±2 → 7 gamma subcycles) | Unclear how phase codes generalize to abstract non-temporal content |

**Liu et al. 2025 verdict (model-design angle):** TRNN with transient trajectory encoding outperforms attractor-based vanilla RNN on every evaluated WM task, providing direct model-level evidence for the transient theory.

---

## BG Gating: Three Competing Architectures

Helie et al. 2013 identify that CCN models of BG-WM interaction fall into three computationally distinct architectures with different lesion predictions:

| Architecture | Representative models | BG role | Key prediction |
|---|---|---|---|
| **Thalamo-cortical gate** | Monchi et al.; FROST (Ashby et al.) | BG releases thalamus from GPi inhibition → opens thalamo-cortical reverberation loop | Thalamic lesion abolishes WM maintenance |
| **Cortico-cortical gate** | Frank et al. / PBWM; Moustafa & Maida | BG opens an intra-PFC reverberating loop; BG not needed once loop is open | Thalamic lesion does not abolish maintenance; BG lesion impairs gating only |
| **BG-in-loop** | Schroll et al. | BG is a node inside the maintenance loop, not a gate; learned dopamine RL determines what is maintained | BG lesion directly impairs maintenance, not only gating; BG always active during delay period |

PBWM (the wiki's primary account) corresponds to architecture (b). Architecture (c) is the outlier: BG participation is not optional after latch — the loop literally passes through striatum. Neuroimaging cannot cleanly distinguish (b) from (c) because both predict BG activation during WM tasks; the diagnostic is whether BG-lesioned subjects can maintain content once it has been gated in.

A reasoning model needs this distinction resolved: in (b), the BG-PFC gate can be fully abstracted as a switch that sets initial state; in (c), the BG must participate in every maintenance cycle, making it unsuitable as a purely cognitive-level abstraction.

**MSPRT: the gating criterion.** Independently of which architecture is correct, Bogacz & Gurney 2007 establish what the BG *optimizes* when it gates: the Multihypothesis Sequential Probability Ratio Test (MSPRT). The BG output = −ln P(H_i | evidence), and the gate opens when this drops below threshold — Bayesian log-posterior selection, not simple salience thresholding. For WM gating specifically, this means the BG computes a global normalization term S(T) = ln(Σ_j exp(salience_j)) over all candidate WM updates and selects the one with highest posterior. The three-architecture debate concerns *where and when* the gate operates; MSPRT specifies *the objective function* by which it selects.

---

## TRNN Architecture

Full architecture details, capacity tables, and variable delay mechanism: **[[wiki/entities/trnn-model.md]]**.

Three modifications to a vanilla RNN produce high-TI transient dynamics: (1) **self-inhibition** — prevents sustained firing, forces sequential chain propagation; (2) **sparse connections** — reduces attractor-forming strong recurrence; (3) **hierarchical topology** (sensory → association → motor) — critical for high TI; removing it degrades TI dramatically even with the other two.

**Key results:** transient coding achieves higher multi-item capacity AND lower metabolic cost simultaneously. WM duration is **neuron-count limited** — longer delays recruit additional neurons, paralleling the 7±2 slot limit. TRNN outperforms vanilla attractor RNN on multi-item capacity, spatial WM, and distractor robustness across every evaluated task.

---

## Fast WM Mechanisms

| Mechanism | Storage medium | Write step? | Capacity constraint | Structural robustness |
|---|---|---|---|---|
| **Hebbian M (TEM/HC)** | Synaptic weight matrix M | Explicit Hebbian write each timestep | O(N/log N) linear; O(exp d) modern Hopfield | Not measured (cross-trial mechanism) |
| **LSTM hidden state (PFC meta-RL)** | Recurrent activation vector h_t | Implicit (gated accumulation) | ≈ hidden dimension; no slot limit | High (LSTM most robust to process noise) |
| **Transient trajectory (TRNN)** | Sequential neuron firing chain | None — dynamics propagate by self-inhibition | Scales with neuron count N (neuron-count limited) | Not measured |
| **STSP / PS-hebb (PFC activity-silent)** | Transiently modified synaptic efficacy (calcium dynamics) | None — spikes automatically drive calcium update | Not established; bounded by calcium decay timescale (~200ms) | High: 50% synapse ablation with minimal loss; fixed-synapse fails at 10–20% |
| **SFA / adaptive threshold (LSNN)** | Adaptive spiking threshold $a_j(t)$ — leaky trace of spike history in the threshold variable | None — each spike increments threshold; trace decays with $\tau_a$ | Scales with $\tau_a$; DEXAT two-timescale ($\tau_{b1}$=30ms, $\tau_{b2}$=300ms) achieves 1200ms WM more efficiently than single matched $\tau_a$ | Not measured; intrinsic — independent of synaptic structure |
| **External augmented memory (DNC)** | N×W external memory matrix M; accessed via soft attention read/write heads | Explicit soft write via attention weighting + erase/add vectors | N locations (expandable without retraining; behavior size-independent) | Not measured; architecture-level, not neuron-level mechanism |
| **GNW ignition (active broadcast)** | Globally sustained firing across PFC-parietal hub network (GNW neurons, layer II/III + V) | Implicit threshold: feedforward input to PFC above threshold triggers NMDA-mediated self-sustaining recurrent loop | 1 conscious object at a time (serial bottleneck); multiple items require sequential ignition cycles | Not measured at model level; disrupted by NMDA antagonists (ketamine) or frontal-parietal disconnection |

These six are the fast-timescale mechanisms identified across the wiki's brain-region coverage. SFA is unique in being entirely intrinsic — the memory trace lives in the neuron's own threshold variable, not in synaptic weights or activation state. 20–40% of excitatory neocortical neurons exhibit SFA by default (Allen Institute data). Short-Term Synaptic Plasticity (STSP) is uniquely characterized by: (a) storage in synaptic state rather than neural state, (b) brain-likeness confirmed via NHP PFC comparison, and (c) provable stability in the PS-hebb variant.

---

## STSP: Structural Robustness and Dual-Mode Operation

Key properties not present in the other three mechanisms:

- **Structural robustness:** PS-hebb tolerates 50% random synapse ablation; fixed-synapse attractor models degrade severely at 10–20%. Biological relevance: dendritic synapse turnover is ~40% every 5 days in sensory cortex — WM circuits must function despite continuous synaptic remodeling.
- **Dual-mode operation:** Sparse spiking during *maintenance* (WM content held in synaptic weights); burst spiking during *readout* (spikes "ping" the synaptic state to extract and route information). Explains the task-dependency of delay-period spiking: spatial delayed-response tasks (known response, inhibit it = motor state) show persistent spiking; delayed match-to-sample tasks (response unknown until test = pure WM) show sparse spiking.
- **Modularity:** PS-hebb's provable continuous-time stability means STSP modules can be linked with other stable modules without destabilizing the combined system. Fixed-synapse attractors lack this property — whole-network retraining is required when new modules are added.

Anti-Hebbian excitatory rule: reduces synaptic weight when presynaptic and postsynaptic activity are correlated → prevents runaway reinforcement. Purely Hebbian STSP is unstable. The anti-Hebbian rule is the critical design choice, not STSP generically.

---

## Transformer WM Capacity Limit

Gong & Zhang 2024 (NeurIPS workshop) give a mechanistic account of why transformer-based models fail N-back tasks as N increases — not a context-length problem, but an attention entropy problem.

**Learned strategy:** Causal transformers solve N-back by learning to concentrate attention on position i−N. Attention maps evolve from uniform to a diagonal stripe at the N-back lag over training. This strategy is both the solution and the bottleneck.

**Bottleneck metric — total attention entropy:**

$$H_N = \sum_{i=1}^{T} H(A_{i,:}), \quad H(A_{i,:}) = -\sum_{j \leq i} A_{i,j} \log A_{i,j}$$

As N grows, more preceding positions compete in the causal softmax, dispersing attention mass away from i−N → H_N rises → accuracy drops logarithmically.

| Finding | Detail |
|---|---|
| Entropy-accuracy relationship | H_N increases with N; test accuracy decreases monotonically with H_N |
| Accuracy decline | Logarithmic with N for 1L-1H; mitigated but not eliminated by more layers/heads |
| Context length irrelevance | 24-char sequences << context window; failure is architectural, not a storage limit |
| Later positions worse | Attention is more dispersed at later positions (more competitors) → worse accuracy |

**Executive attention theory parallel:** Human WM limits are due to executive attention resource scarcity (Engle et al.), not storage per se. Transformers show the same structure: the softmax normalization is the "resource" that is divided among all preceding positions, making concentration at a specific lag increasingly costly as N grows.

**Design implication for reasoning models:** Any architecture relying on global softmax attention to maintain a specific past item across N intervening steps will face this entropy tax. Mitigations:
1. Dedicated WM module (TRNN, STSP) that holds selected information outside the attention budget
2. State-space models (selective state updates without full-sequence softmax competition)
3. Hard sparse attention (top-k selection without softmax mass conservation)

---

## WM Updating as a CC Component (Friedman & Robbins 2021)

Friedman & Robbins (2021) clarify the functional distinction within dlPFC WM contributions:

| Sub-function | PFC subregion | What it does | Distinct from |
|---|---|---|---|
| **Maintenance** | Broad dlPFC; also parietal, perirhinal | Hold information in accessible state during delay | Can be done without dlPFC — other regions contribute |
| **Interference resistance** | dlPFC specifically | Shield WM content from distractor intrusion | Maintenance per se; dlPFC lesions selectively impair distractor-rich WM, not pure delay |
| **Updating / monitoring** | Mid-dorsal PFC (BA-9/46) | Continuously tag, add, and remove items; n-back monitoring | Passive maintenance; updating requires executive attention |
| **Manipulation** | Inferior parietal | Reorder and operate on WM contents | Storage; parietal damage impairs mental arithmetic/rotation without impairing raw WM capacity |

WM *updating* is the second of three dissociable CC components (after response inhibition, before mental set-shifting). It shares variance with response inhibition (r ≈ 0.42–0.63 between latent factors) but also carries specific variance not explained by the common CC factor. Implication: a reasoning model needs a dedicated updating mechanism (Block 3B), not just a passive buffer — the buffer must actively expunge stale content.

---

## GNW: Active vs. Activity-Silent Distinction

Mashour et al. (2020) establish the mechanistic difference between WM as *store* and WM as *workspace*:

- **Activity-silent items** (STSP, synaptic traces): bridge delays but **cannot be transformed** — MEG decoding (Trübutschek et al. 2017) shows decodable information is present but produces no ignition signature; mental rotation and sequence navigation fail on silent items
- **GNW-active items** (globally sustained firing in PFC-parietal hub): can be mentally rotated, sequenced, and reasoned over; Trübutschek et al. 2019 confirms that whenever WM content must be transformed, active firing reemerges

The ignition threshold is the WM entry gate: when feedforward input to PFC is strong enough, NMDA-gated recurrent loops self-sustain and broadcast the representation globally to all specialized processors.

**Design implication:** A reasoning model's hub module must maintain representations in an active broadcast state for any downstream transformation step. Storage mechanisms (STSP, SFA, DNC memory) support the *buffer*; GNW ignition supports the *workspace*. A model relying solely on activity-silent storage for multi-step reasoning will fail when chained transformations are required — each step must reinstate the intermediate result into active broadcast before the next step can apply.

---

## Relationship to Abstract Reasoning

WM is prerequisite for:
- Multi-step transformation chains (hold intermediate result while applying next rule)
- Context maintenance across episodes (meta-RL, Block 3B)
- Binding problem solutions that require maintaining multiple slots simultaneously

TRNN's superior multi-item capacity (compared to attractor models with same parameter count) makes it the better candidate for WM in a reasoning model. Spatial WM advantage is also relevant: if abstract reasoning is graph navigation (see [[wiki/concepts/latent-graph-discovery.md]]), the agent must maintain the current graph position across delay periods while processing sensory input.

Transformer-based architectures have a specific WM liability: even within context length, their ability to retrieve an item from N steps back degrades logarithmically with N due to attention entropy (Gong & Zhang 2024). This is separate from compositional generalization failure (Hupkes 2020). The implication is that a reasoning model with a pure transformer backbone will fail not because it "forgets" (the KV cache holds everything) but because it cannot concentrate attention reliably — arguing for a dedicated non-attention WM module running in parallel.

---

## Open Problems

- Can TRNN's transient-trajectory fast mechanism be composed with TEM's Hebbian-M fast mechanism? (Transient activity as pointer to stored Hebbian content)
- What prevents trajectory divergence in longer delays without explicit end-of-delay signal? (TRNN uses fixed-length training)
- Does the neuron-recruitment capacity model predict the 7±2 limit quantitatively, or only qualitatively?
- Are the TRNN's three modifications sufficient for abstract (non-sensory) WM, or does symbolic content require additional structure?
- LSM Theorem 1 proves that any fading-memory filter is computable from transient liquid states, provided SP holds. The open question for WM in reasoning tasks: does the Separation Property of neocortical circuits hold for abstract (relational) inputs, or is SP guaranteed only for sensory inputs matched to evolutionary circuit priors?
- Can STSP and TRNN be combined? STSP provides structural robustness + activity-silent bridging; TRNN provides high multi-item capacity. A combined model could alternate between silent (STSP) and active (trajectory) phases.
- What is the read-out mechanism in STSP networks? "Spiking pings synaptic state" is the informal account — the mechanistic details of how a burst at test time selectively reads the correct synaptic pattern are unspecified.
- Can auxiliary WM modules (TRNN/STSP) be coupled to a transformer backbone to overcome the N-back attention entropy limit? The transformer's global softmax competes over all positions; the WM module would maintain selected items outside that budget — what is the interface mechanism?
- Is the attention entropy limit the same phenomenon as the localism gap in compositional generalization (Hupkes 2020)? Both trace to global softmax receptive field; N-back reveals a temporal version of the same bottleneck.

---

## Connections

- **[[wiki/concepts/two-learning-timescales.md]]** — TRNN adds a third fast-timescale WM mechanism (transient activity chain) to the two already in the wiki (Hebbian M and LSTM hidden state); transient trajectory differs from both in having no explicit write step and storing memory in propagation dynamics.
- **[[wiki/concepts/meta-learning.md]]** — PFC LSTM (Wang et al. 2018) is the slow-outer/fast-inner meta-RL instantiation of WM; TRNN provides a complementary mechanism with higher empirical capacity but without the full RL-in-activations capability of the LSTM.
- **[[wiki/concepts/neural-manifolds.md]]** — dPCA on TRNN delay-period activity reveals a low-dimensional trajectory manifold where stimulus-dependent components remain separated throughout the entire delay; trajectory velocity is constant (memory is in the path, not a fixed point), adding a new manifold signature to the concept page.
- **[[wiki/concepts/neuromodulation.md]]** — D1/D2 dopamine gating of DLPFC activity (stability/flexibility) maps onto TRNN's self-inhibition coefficient γ: high D1 = low γ (less self-inhibition, more persistence); high D2 = high γ (strong self-inhibition, faster trajectory); the γ parameter is the neuromodulatory dial.
- **[[wiki/concepts/binding-problem.md]]** — multi-item WM requires binding multiple representations to independent temporal slots; TRNN's neuron-count-limited capacity formalizes this as temporal multiplexing rather than attractor coexistence.
- **[[wiki/entities/reservoir-computing.md]]** — reservoirs have naturally high TI (transient dynamics, spectral radius < 1); Barak 2013 showed reservoir already outperforms pure attractor vanilla RNN on delay tasks; TRNN adds learned hierarchical structure to the reservoir's inherently transient dynamics.
- **[[wiki/papers/maass-lsm-2002.md]]** — Theorem 1 is the formal proof that transient dynamics alone can implement any fading-memory computation (via SP+AP); readout equivalence classes are the specific mechanism by which stable WM output emerges from variable liquid states; dynamic synapse results establish that short-term synaptic plasticity is computationally required for >30ms fading memory, directly grounding the STSP mechanism.
- **[[wiki/entities/trnn-model.md]]** — TRNN entity page: full architecture (three modifications + TI metric), capacity and energy tables, variable delay mechanism, and comparison to other WM mechanisms.
- **[[wiki/papers/trnn-liu-2025.md]]** — primary source for TRNN; Liu et al. 2025.
- **[[wiki/papers/pfc-meta-rl-wang-2018.md]]** — Wang et al. 2018; LSTM-based WM (hidden-state mechanism) for comparison.
- **[[wiki/papers/pbwm-oreilly-frank-2006.md]]** — PBWM; BG-gated stripe-based WM as a third biological instantiation (dynamic variable binding into independent slots via BG gating, distinct from both attractor and transient trajectory).
- **[[wiki/papers/stsp-kozachkov-2022.md]]** — Kozachkov et al. 2022; source for STSP as 4th mechanism; NHP PFC empirical validation; PS-hebb robustness and stability results.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — SFA adds a 5th fast WM mechanism: the adaptive threshold $a_j(t)$ is a leaky trace of spike history stored in the threshold variable itself; $\tau_a$ sets the WM duration; DEXAT's two-timescale composition (fast $\tau_{b1}$ + slow $\tau_{b2}$) shows the same multi-timescale superiority principle already established for CLS.
- **[[wiki/papers/sfa-ganguly-2024.md]]** — Ganguly et al. 2024 review; source for ALIF/DEXAT/LSNN benchmarks (93.7% SMNIST, 95% STORE-RECALL at 1200ms); 20–40% neocortical SFA prevalence; e-prop biologically plausible alternative to BPTT.
- **[[wiki/concepts/cognitive-control.md]]** — WM updating is the second of three dissociable CC components; the active maintenance of goals in dlPFC is itself the mechanism of cognitive control (not just a side-effect), linking WM directly to top-down bias and response inhibition.
- **[[wiki/concepts/attention.md]]** — transformer self-attention is both WM's implementation mechanism (attending to past items) and its capacity bottleneck (softmax mass divided among all preceding positions); the localism gap in compositional generalization and the N-back entropy limit are two distinct failure modes of the same global-receptive-field property.
- **[[wiki/concepts/associative-memory.md]]** — the classical attractor theory of WM (Fuster, Goldman-Rakic) is a Hopfield network held at a stored pattern; the attractor vs. transient-trajectory debate is whether WM uses Hopfield fixed points or dynamic trajectory paths; Hopfield capacity (~0.14N) predicts the slot limit and the failure mode under pattern interference.
- **[[wiki/papers/transformer-wm-limit-gong-2024.md]]** — Gong & Zhang 2024; mechanistic account of transformer WM limits via attention entropy; executive attention theory parallel; design implication for hybrid architectures.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — Block 3B (WM/context maintenance) bridge should prefer TRNN over vanilla LSTM based on capacity and spatial navigation evidence; STSP could supplement Block 3B for within-trial structural robustness; Gong & Zhang 2024 confirms that a pure-transformer Block 3B will fail on N-back-style context retrieval regardless of context length.
- **[[wiki/entities/prefrontal-cortex.md]]** — dlPFC is the primary biological substrate for WM interference resistance and updating; transient delay-period activity (majority of dlPFC neurons are non-persistent) is consistent with TRNN over attractor models; the hierarchical PFC gradient grounds the multi-level WM context stack in Block 3C.
- **[[wiki/entities/basal-ganglia.md]]** — BG gating is the biological mechanism that controls which PFC WM slots are updated vs. held; the three-architecture debate (thalamo-cortical/cortico-cortical/BG-in-loop) determines how abstractly the BG gate can be treated in a model; MSPRT specifies the selection criterion independently of architecture.
- **[[wiki/concepts/sequence-memory.md]]** — sequence memory (DenseNet) propels the network through a stored ordered trajectory; MixedNet's fast/slow synapse split (stay vs. transition) parallels the WM maintenance/readout distinction; the two mechanisms differ in function (hold vs. propel) but share dual-timescale synaptic dynamics and the same CBGT biological substrate.
- **[[wiki/papers/long-sequence-hopfield-chaudhry-2023.md]]** — MixedNet variable-timing architecture is relevant to WM's temporal gating function: $\lambda$ parameter controlling transition speed corresponds to the deliberate-pause mechanism (hyperdirect Hold); the fast/slow synapse split maps onto AMPA/NMDA timescales used in WM models.
- **[[wiki/papers/helie-ccn-bg-2013.md]]** — source for the BG-WM three-architecture debate; COVIS dual-system categorization as a WM-gating context (BG gates rule switching in hypothesis-testing system); also source for BG gating-vs-maintenance architectural distinction.
- **[[wiki/papers/bogacz-gurney-bg-msprt-2007.md]]** — specifies the Bayesian selection objective (MSPRT) for BG gating: the gating criterion is log-posterior over candidate WM updates, with normalization provided by the STN-GP log-softmax subsystem; specifies Block 3D's selection module design requirement independently of the three-architecture debate.
- **[[wiki/entities/dnc-model.md]]** — DNC external memory is the 6th fast WM mechanism: N×W matrix accessed by soft attention; uniquely provides unlimited expandable capacity without modifying any weight, making it the only mechanism where WM capacity can be grown at test time; also the only mechanism with bidirectional read-modify-write (erase + add vectors per location), enabling prospective planning via write-before-execute.
- **[[wiki/papers/dnc-graves-2016.md]]** — source: DNC architecture; Mini-SHRDLU planning decode (89% first-action accuracy at goal-write time); graph traversal LSTM vs. DNC empirical gap (37% vs. 98.8%) establishing necessity of external read-write memory for structured reasoning.
- **[[wiki/entities/gwt-model.md]]** — GNW ignition is the 7th fast WM mechanism and the only one enabling mental transformation; activity-silent STSP items are stores — they cannot be mentally rotated, sequenced, or reasoned over until reinstated into GNW active firing (Trübutschek et al. 2017, 2019).
- **[[wiki/papers/gnw-mashour-2020.md]]** — source for the active vs. activity-silent WM distinction; AMPA/NMDA feedforward/feedback dissociation; dynamic state repertoire collapse under anesthesia as the GNW operational indicator.
