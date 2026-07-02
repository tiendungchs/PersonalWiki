---
title: "Hippocampal-Entorhinal System"
type: entity
tags: [hippocampus, entorhinal-cortex, MEC, LEC, memory, navigation, relational-inference]
created: 2026-06-09
updated: 2026-07-01
sources: [gridlikecode, t-TEM, engram-transcript, convergence-wiring-transcript, jumping-spiders-cognition, convergent-brain-structures-spatial-memory, Metalearning_and_Neuromodulation, Structure and function of the hippocampal CA3 module, The mechanisms for pattern completion and pattern separation in the hippocampus, Complementary Learning Systems, Learning Fast and Slow Single- and Many-Shot Learning in the Hippocampus, Pattern separation in the hippocampus.md, Neuroscience-Inspired Artificial Intelligence, High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations, courellis-hpc-abstract-inference-2024, Bio-inspired computational memory model of the Hippocampus An approach to a neuromorphic spike-based Content-Advocated Memory, nieh-hippocampal-geometry-2021, sun-hippocampal-osm-2025, A scalable reinforcement learning framework inspired by hippocampal memory mechanisms for efficient contextual and sequential decision making, inferential-reasoning-dupret-2020, dmn-20years-menon, valero-interneuron-families-2025, Interplay of hippocampus and prefrontal cortex in memory, Prefrontal-Hippocampal Interactions in Memory and Emotion, "The hippocampal–prefrontal pathway: The weak link in psychiatric disorders?", "The prefrontal cortex controls memory organization in the hippocampus"]
related: [wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/path-integration.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/latent-states.md, wiki/concepts/attention.md, wiki/concepts/engrams.md, wiki/concepts/small-world-networks.md, wiki/concepts/binding-problem.md, wiki/concepts/convergent-allocentric-coding.md, wiki/concepts/neuromodulation.md, wiki/concepts/associative-memory.md, wiki/concepts/pattern-separation.md, wiki/concepts/replay.md, wiki/concepts/continual-learning.md, wiki/concepts/phase-precession.md, wiki/concepts/prospective-coding.md, wiki/concepts/canonical-microcircuit.md, wiki/concepts/btsp.md, wiki/concepts/memory-schemas.md, wiki/concepts/network-integration-segregation.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/tem-model.md, wiki/entities/cscg-model.md, wiki/entities/htm-thousand-brains.md, wiki/entities/insect-central-complex.md, wiki/entities/arthropod-mushroom-bodies.md, wiki/entities/cephalopod-vertical-lobe.md, wiki/entities/vector-hash-model.md, wiki/entities/dnc-model.md, wiki/entities/snn.md, wiki/entities/hami-model.md, wiki/entities/default-mode-network.md, wiki/entities/nucleus-reuniens.md, wiki/entities/prefrontal-cortex.md, wiki/papers/gridlikecode-constantinescu-2016.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/engram-transcript.md, wiki/papers/150000-mini-brain-transcript.md, wiki/papers/convergence-wiring-transcript.md, wiki/papers/jumping-spiders-cognition.md, wiki/papers/metalearning-neuromodulation-doya-2002.md, wiki/papers/ca3-sammons-2023.md, wiki/papers/pattern-completion-rolls-2013.md, wiki/papers/cls-oreilly-2011.md, wiki/papers/learning-fast-slow-liao-2024.md, wiki/papers/hassabis-neuroscience-ai-2017.md, wiki/papers/spiking-tem-kawahara-2025.md, wiki/papers/vector-hash-chandra-2023.md, wiki/papers/dnc-graves-2016.md, wiki/papers/courellis-hpc-abstract-inference-2024.md, wiki/papers/spiking-cam-hippocampus-casanueva-2024.md, wiki/papers/nieh-hippocampal-geometry-2021.md, wiki/papers/sun-hippocampal-osm-2025.md, wiki/papers/hami-poursiami-2025.md, wiki/papers/inferential-reasoning-dupret-2020.md, wiki/papers/dmn-20years-menon.md, wiki/papers/valero-interneuron-families-2025.md, wiki/papers/wu-maass-btsp-2025.md, wiki/papers/preston-eichenbaum-hpc-pfc-2013.md, wiki/papers/jin-maren-hpc-pfc-emotion-2015.md, wiki/papers/spedding-jay-hpfc-psychiatric-2013.md, wiki/papers/desousa-pfc-memory-organization-hpc-2026.md]
---

# Hippocampal-Entorhinal System

The brain's relational inference engine. TEM models it as a factorized world model.

---

## Anatomy

**MEC (Medial Entorhinal Cortex):** structural coordinate system — grid cells, border cells, OVCs, head direction cells. Representations generalize across environments. = structural code g + weights W.

**LEC (Lateral Entorhinal Cortex):** sensory content — object and event representations. Environment-specific. = sensory input x.

**HC (Hippocampus):** conjunctive binding — place cells, **time cells** (fire at sequential moments within an episode, mapping the temporal axis of experience), plus latent-state variants (splitter, lap, evidence cells). Rapid one-shot episodic memory. Remaps between environments (but non-randomly: preserves grid-phase relationships). = conjunctive code p + Hebbian weights M.

```
MEC (g) ─────────────────────────────► HC (p = f(g, x))
 ▲                                             │
 └────── error correction (M retrieval) ◄──────┘ + LEC (x)
```

---

## CA3 as High-Connectivity Autoassociator

Sammons et al. 2023 ([[wiki/papers/ca3-sammons-2023.md]]) provide direct structural and functional evidence that CA3 recurrent collaterals connect at ~9–11%, ~10× above prior estimates:

| Measurement | Rate | Method |
|---|---|---|
| Structural (3D EM) | 11.2 ± 2.7% within 50 µm | ATUM-multiSEM; 7 axons, 1,062 synapses; single mouse |
| Functional (electrophysiology) | 8.8% (103/1,172 pairs) | Octuple patch-clamp; 52 mice |

Computational implications for the HC model:
- **Random connectivity is sufficient**: reciprocal pairs and disynaptic motifs occur at chance (p > 0.3). CA3 is a classical Hopfield-type autoassociator, not a specially-structured motif network.
- **c × M ≈ const**: connectivity × assembly size is the conserved product; at 8.8%, a wide range of assembly sizes supports reliable sequence replay without non-random wiring.
- **Log-normal weights**: median EPSP 0.66 mV; heavy-tailed distribution means embedded assemblies (strengthened synapses) stand clearly above background — the same structure TEM's Hebbian M implicitly relies on.

This empirically grounds the ACh-mediated retrieval mode (low ACh → CA3 Schaffer collaterals dominate → pattern completion) with a concrete connectivity rate that supports attractor dynamics.

**Spiking CAM (Content-Addressable Memory) implementation (Casanueva-Morato et al. 2024 [[wiki/papers/spiking-cam-hippocampus-casanueva-2024.md]]):** CA3 is formalized as a bidirectional spiking Content-Addressable Memory on the SpiNNaker neuromorphic platform. Two parallel STDP sub-networks (S1: cue→content, S2: content→cue) implement both forward and reverse retrieval in 6 ms. STDP LTD (Long-Term Depression) automatically forgets overwritten cue-content associations. DG (Dentate Gyrus) is modeled as a one-hot encoder on the cue, achieving maximum pattern orthogonality and enabling non-orthogonal content storage — the first spiking CAM (Content-Addressable Memory) to handle overlapping patterns.

**CA3's bidirectional function (Yassa & Stark 2011 [[wiki/papers/yassa-stark-pattern-separation-2011.md]]):** CA3 is not a pure pattern completer. Its nonlinear attractor dynamics are *bidirectional*: small Δinput (similar environments, similar cues) keeps the network in an existing attractor basin → completion; large Δinput (distinct environments) exceeds the basin boundary → the network escapes and remaps → separation. CA1 by contrast responds linearly — neither completing nor separating, passing the combined DG/CA3 + EC (Entorhinal Cortex) signal proportionally. Full transfer function account in [[wiki/concepts/pattern-separation.md]] (Transfer Functions section).

---

## BTSP: The Molecular Mechanism of Single-Shot HC Encoding

Behavioral timescale synaptic plasticity (BTSP; Bittner et al. 2017, reviewed in Liao & Losonczy 2024 [[wiki/papers/learning-fast-slow-liao-2024.md]]) is the actual single-shot learning rule in CA1 — superseding the "one-shot Hebbian LTP" shorthand used in CLS (Complementary Learning Systems) and TEM accounts.

**Mechanism:**
1. An *instructive signal* — plausibly from EC (Entorhinal Cortex) (Grienberger & Magee 2022 confirmed EC (Entorhinal Cortex) provides the causal signal) — evokes a long-lasting plateau potential in the distal apical dendrites of a CA1 pyramidal cell.
2. All synaptic inputs active within the preceding and immediately following seconds become simultaneously potentiated.
3. The potentiated weight ensemble drives the cell to fire whenever those inputs are next active — the cell's place field.

**Why BTSP, not Hebbian:** STDP operates on millisecond spike-pair coincidences; each event produces a small Δw, requiring many trials. BTSP integrates population activity over seconds, producing a large Δw in one shot. The law of large numbers makes this robust: spurious co-activation of a single synapse is statistically invisible against the mass of potentiated weights.

**First in vivo synaptic confirmation (Fan et al. 2023; Gonzalez et al. 2023):** All-optical physiology confirmed that new CA1 place field acquisition requires potentiation of CA2/3 Schaffer collateral input, and directly measured the plasticity kernel, providing the first synapse-level mechanistic evidence.

**Relationship to DG→CA3→CA1 pipeline:**
- DG (Dentate Gyrus) competitive learning creates a sparse CA3 representation (pattern separation).
- CA3 recurrent collaterals support pattern completion (autoassociative attractor).
- CA1 receives converging CA3 + EC (Entorhinal Cortex) input — EC's instructive signal drives BTSP, writing the new conjunctive code.

| Plasticity rule | Timescale | Role in HC | Single-shot? |
|---|---|---|---|
| BTSP (CA1) | Seconds | Concept acquisition — new p code in one trial | Yes |
| STDP (CA3 RC) | Milliseconds | Sequence embedding — edge weights across trials | No (many-shot) |
| Theta-phase delta rule (CA3/CA1) | 4–8 Hz | Error-driven self-correction | Continuous |

**Binary weights and content-addressable memory (Wu & Maass 2025 [[wiki/papers/wu-maass-btsp-2025.md]]):** A simple binary BTSP rule ($\Delta w_i = \pm 1$ with prob 0.5, gated by plateau) produces a high-capacity CAM matching or surpassing Hopfield networks with continuous weights, for the sparse input regime ($f_p$ ≈ 0.005) characteristic of CA1:

- **Stochastic gating parameter $f_q$ ≈ 0.005:** the probability that any CA1 neuron receives a plateau potential during a given input pattern; the 10s plasticity window duration brings plateau rate (0.0005/s) × window (10s) into this experimentally optimal range
- **Bimodal distribution:** neurons receiving plateaus for pattern **x** (set Q(**x**)) accumulate weights biased toward **x** → high weighted-sum cluster; others → low cluster; threshold between clusters → recall robust to 33% masking
- **Repulsion effect:** BTSP's LTD branch cancels shared-input weights when Q(**x_a**) ∩ Q(**x_b**) ≠ ∅ for similar patterns → memory traces pulled apart; first model reproducing human brain's documented repulsion of similar memories
- **Load balancing:** stochastic plateau gating distributes memory writes uniformly across all CA1 neurons, preventing the repeated-neuron recruitment that causes forgetting in Hebbian-based rules; memory quality is equal for items learned early and late in a 10k-item sequence

See [[wiki/concepts/btsp.md]] for the full formalism and ML design implications.

---

## Interneuron Cooperative Control of the CA1 Cognitive Map (Valero et al. 2025)

CA1 contains four GABAergic interneuron families that cooperatively shape pyramidal place field properties through division of labor [[wiki/papers/valero-interneuron-families-2025.md]]:

| Family | Target | Place field role | Time-division role |
|---|---|---|---|
| **Pvalb** | Soma/AIS perisomatic | Stability | Controls first half (EC input phase) |
| **Sst** (OLM) | Distal apical dendrites | Context generalization | Controls second half (CA3 recurrent phase) |
| **Vip** | Sst/OLM cells (disinhibitory) | Gain / MI amplifier | Boosts amplitude by releasing pyramidal apical dendrites |
| **Id2** (neurogliaform, CCK basket) | Broad multi-target | Context specificity | Controls second half alongside Sst |

**Circuit interpretation of place field phases:** as the animal enters the place field, EC input dominates (gated by Pvalb timing). Traversal progressively potentiates the place cell–OLM (Sst) synapse, weakening EC input while CA3 recurrent excitation grows. Pvalb/Sst temporal switching implements the EC→CA3 input dominance transition within a single traversal.

**VIP disinhibitory gate:** Vip → suppresses Sst/OLM → releases distal dendritic compartments → strongest place field amplitude boost of any family. This is the circuit-level implementation of a context-sensitive gain modulator: Vip activation changes encoding amplitude without altering the structural (g) code.

**Interneurons as active spatial coders:** interneuron-only CEBRA decoder matches count-matched pyramidal decoder; all four families are required for full position decoding. Inhibitory cells actively participate in the cognitive map, not merely normalize pyramidal activity.

**Circuit motif conservation:** functional coupling matrices are conserved between hippocampus and neocortex, confirming the four-family motif is a canonical circuit module (see [[wiki/concepts/canonical-microcircuit.md]]).

---

## CA1: Sparse Invertible Mapper

CA1's role is underappreciated and frequently omitted in CLS (Complementary Learning Systems) accounts (O'Reilly et al. 2011 [[wiki/papers/cls-oreilly-2011.md]]). Without CA1, catastrophic interference persists even with perfect DG (Dentate Gyrus) pattern separation:

**The CA3→EC interference problem:** CA3 produces arbitrary pattern-separated codes (novel, unrelated to anything seen before). If CA3 projected directly to EC, EC (Entorhinal Cortex) neurons — which have high overlap and participate in many memories — would need to rapidly learn associations with these novel CA3 patterns. This causes interference in EC, defeating the purpose of HC's sparse encoding.

**CA1's solution:**
| Property | Mechanism | Effect |
|---|---|---|
| **Sparse activity** | CA1 neurons participate in fewer memories than EC (Entorhinal Cortex) neurons | Less interference per new association |
| **Invertible mapping** | CA1 activity reconstructs original EC (Entorhinal Cortex) pattern during retrieval | Faithful recovery of cortical activity patterns |
| **Combinatorial code** | Novel inputs represented as recombinations of existing CA1 representational elements | Generalizes to novel input patterns without a new code from scratch |

CA1 is an active, learned binding layer — not a passive relay. Current CLS (Complementary Learning Systems) models initialize this combinatorial code artificially; how it develops during learning is an open problem. The one-shot Hebbian write mechanism ([[wiki/concepts/associative-memory.md]]) applies to CA3 recurrent collaterals; CA1's slower-developing combinatorial structure requires extended experience.

---

## DG (Dentate Gyrus) Pattern Separator: Grid→Place Transformation

DG competitive learning (Hebbian + lateral inhibition) orthogonalizes entorhinal inputs before CA3 storage — the full account (five mechanisms, capacity formula $p_\text{max} \approx k \times C_{RC}/a$, mossy fiber/perforant path encoding-recall separation, adult neurogenesis) lives at **[[wiki/concepts/pattern-separation.md]]**.

**Grid→place:** Each DG (Dentate Gyrus) granule cell learns to respond to a unique combination of co-active MEC grid cell patterns — uniquely identifying a place. In primates, the same mechanism produces *spatial view cells* (fovea ≈ 10–20° of visual angle per DG (Dentate Gyrus) combination). ACh suppresses CA3→CA3 recurrent collaterals during encoding ([[wiki/concepts/neuromodulation.md]]), neuromodulatorily reinforcing the structural mossy fiber dominance.

---

## Vector-HaSH: Resolving the Spatial/Episodic Dual Role

The long-standing question — why does HC support both spatial navigation and episodic memory? — is resolved by Vector-HaSH (Chandra et al. 2023 [[wiki/papers/vector-hash-chandra-2023.md]]) via a third hypothesis: the nominally "spatial" architecture (grid codes + HC coupling) is equally optimal for non-spatial episodic memory.

**Circuit decomposition:**

| Layer | Anatomy | Weights | Function in Vector-HaSH |
|---|---|---|---|
| Grid scaffold | MEC (M modules, K_i torus phases each) | Fixed (developmental) | Generates ⟨K⟩^M stable fixed points — content-free hash library |
| Scaffold projection | Grid→HC (random) + HC→Grid (learned once) | Fixed | Converts grid states to sparse HC attractors |
| Heteroassociation | HC ↔ neocortex | Bidirectional plastic | Attaches sensory content to scaffold states — the fast-M write |
| Shift operator | HC → MEC velocity signal | Trained | Drives grid phase transitions for sequence memory |

**Why the dual role is not a coincidence:** The grid scaffold is domain-agnostic by construction — its invariance across all tasks is precisely what makes it a reusable hash index. Spatial navigation exploits the metric/ordered property (adjacent phases = adjacent locations; velocity updates phase continuously). Episodic sequence memory exploits the same shift mechanism driven by HC state rather than self-motion. Memory palace is a direct consequence: a learned spatial scaffold is accessible from spatial cues, and heteroassociation overlays any content on it.

**Key difference from TEM:** TEM explains cross-environment structural generalization (W transfers across environments; M is per-environment). Vector-HaSH explains high-capacity item + sequence memory within the same circuit, by keeping the scaffold fixed and making the heteroassociative layer do all the learning. The two models are complementary — Vector-HaSH specifies how the scaffold generates fixed points; TEM specifies how the structural code enables generalization.

**Graceful tradeoff vs. Hopfield cliff:** Because scaffold fixed points are generated independently of content, adding the N+1th item does not affect items 1…N. Capacity degrades gracefully: more items → lower fidelity per item, but no catastrophic erasure. This is the circuit-level mechanism for why HC can accumulate memories over a lifetime.

---

## Dual Role: Map vs. Memory

Long-standing debate: does HC implement a relational map (SR, CSCG view) or episodic memories binding cortical representations (TEM/SMP view)?

**Resolution (Whittington 2022):** both, depending on experience:

| Regime | Condition | HC role |
|--------|-----------|---------|
| **Map** | Novel environment; no prior cortical model applies | HC builds relational graph de novo (CSCG-style) |
| **Memory** | Familiar structure type; cortex has learned the structure | HC binds cortical abstractions to content (TEM-style) |

With increasing experience in an environment type, there is a predicted transition from HC-as-map to HC-as-memory, tied to the behavioral ability to generalize.

---

## Spatial Bias: Cognitive Map Theory vs. Relational Theory

Kumaran & Maguire 2005 ([[wiki/papers/kumaran-maguire-2005-hippocampus.md]]) provide the clearest direct test of the cognitive map vs. relational debate in humans, using a factorial design that controls for relational complexity.

**Paradigm:** Two tasks matched on difficulty, reaction time, relational demands, and graph topology — same 14 friends as nodes; edges differ:
- *Spatial relational:* navigate London street network between friends' homes (fewest road segments)
- *Social relational:* navigate the same friends' social network using acquaintance connections (fewest intermediaries)

Both are formally identical directed graphs. The social task was not significantly different from the spatial task on any of eight behavioral parameters, including task difficulty, reaction time, episodic memory use, and imagery.

**fMRI factorial result (domain: spatial/social × task: relational/nonrelational):**

| Condition | HC activation? | Regions activated |
|---|---|---|
| Spatial relational | **Yes** (bilateral) | HC, PHG, RSC, PPC |
| Social relational | **No** — not even vs. low-level baseline | mPFC, insula, STS, TPJ, temporal poles |
| Spatial nonrelational | No | PHG, RSC, PPC |
| Social nonrelational | No | (below threshold) |

**Key finding:** Only one region showed a significant domain × task interaction: right posterior hippocampus (peak: 30, −36, −3; z = 4.28). PHG/RSC/PPC activate for spatial processing *regardless* of task type — they are the spatial-context substrate. HC uniquely requires **spatial + relational together**; neither alone suffices.

**Social network drives social brain, not HC:** mPFC, STS, TPJ, insula, temporal poles — the mentalizing / theory-of-mind network — carry the social relational computation. These regions and HC are completely dissociated in this paradigm.

**Reconciliation with non-spatial HC evidence:** Later studies show HC participating in non-spatial abstract inference — Dupret 2020 (sensory preconditioning sequences), Bernardi 2020 (abstract context CCGP), Courellis 2024 (multi-variable abstraction). The common thread: those tasks share **temporal-sequential or metric structure** with navigation — pairs learned in ordered trials, contexts alternating over time, sequences of events. Social graph traversal lacks this structure: edges are declarative (A knows B), not metric (A is N steps from B). The pattern:

| Relational structure | HC engaged? | Examples |
|---|---|---|
| Metric/spatial | Yes | Navigation, place cells, path integration |
| Temporal-sequential | Yes | Sensory preconditioning (Dupret 2020), context learning (Bernardi 2020) |
| Declarative associative (no metric/temporal embedding) | **No** | Social network traversal (Kumaran & Maguire 2005) |

**Design implication:** The HC analog in a reasoning model handles **metric or temporal-sequential relational graphs**. Purely declarative associative schemas (social networks, logical propositions without temporal ordering, family trees) are the domain of the mPFC/social-brain circuit.

---

## Hippocampal Indexing Theory (TEM-t)

TEM-t [[wiki/papers/t-tem-whittington-2022.md]] instantiates hippocampal indexing theory (Teyler & Rudy 2007): HC provides an *index* binding cortical representations across disparate brain areas. Memory neurons in HC link `g̃` (MEC), `x̃` (LEC), and any number of additional cortical regions `c̃`. Each new region adds only n_c feature neurons; HC memory neuron count stays fixed. Any cortical subset can reinstate the others via the HC index. This explains why hippocampal damage disrupts multimodal binding without destroying individual cortical memories.

---

## Beyond HC-ERH: Conceptual Grid Network

Constantinescu et al. 2016 ([[wiki/papers/gridlikecode-constantinescu-2016.md]]) show that abstract-space grid signals extend well beyond the classical hippocampal-entorhinal boundary into vmPFC, OFC, PCC, RSC, LPC, and TPJ — the default mode network. The vmPFC is the *strongest* region (peak Z=4.09), not the ERH. Implications:

- The structural-coding system is cortex-wide, not MEC-local.
- vmPFC's established role in value, memory, and conceptual generalization tasks suggests it may be where structural codes get applied to decision-making, not just maintained.
- This motivates incorporating prefrontal/DMN components into any model of structural generalization, beyond the MEC-HC core.

**Contrast with declarative (non-metric) relational structure:** Kumaran & Maguire 2005 [[wiki/papers/kumaran-maguire-2005-hippocampus.md]] show HC/MEC engagement is not domain-general in the way the DMN extension above might suggest — a matched-difficulty social-acquaintance graph (same nodes, no metric/path-integrable edges) recruits mPFC/STS/TPJ instead, with zero HC/MEC activation. The structural-code network (MEC-HC-vmPFC/DMN) appears scoped to metric or temporally-ordered relational structure specifically, not declarative structure in general. See [[wiki/queries/mec-abstract-codes-vs-declarative-rules.md]] for the full resolution and the separate PFC rule-hierarchy system this implies.

**HC-DMN coupling for episodic integration (Menon 2024 [[wiki/papers/dmn-20years-menon.md]]):** Individual DMN nodes track distinct aspects of episodic memories — hippocampus tracks encoding/retrieval success; PCC/mPFC track value- and emotion-laden features; RSC bridges spatial context with autobiographical memory. This functional division is consistent with hippocampal indexing theory but extends the indexed regions beyond LEC/MEC to the full DMN: HC provides the binding index; DMN cortical nodes hold the semantic and contextual dimensions that HC alone cannot represent. For reasoning models, this implies that the HC-DMN circuit together forms the full episodic integration system.

---

## Brain-Wide Engram Complex

A 2022 Nature Communications study (tissue clearing) found a single fear memory distributed across hippocampus, amygdala, thalamus, hypothalamus, and brainstem — well beyond the canonical HC-amygdala-cortex triad:

| Region | Encoded aspect |
|--------|---------------|
| Hippocampus | Spatial context |
| Amygdala | Emotional valence |
| Cortex | Sensory experience |
| Thalamus/hypothalamus/brainstem | (partially characterized) |

Each region holds one piece; HC indexes them. This extends hippocampal indexing theory from a two-region (MEC/LEC) to a whole-brain binding claim — the architecture in [[wiki/concepts/attention.md]] (HC memory neurons binding N cortical inputs) is not an abstraction but a biological description of actual engram organization.

---

## HC Bootstraps Cortical Structure Learning

HC de-aliases the state space first → provides clean (latent state, next state) sequences to cortex → cortex slowly extracts shared structural regularities across HC episodes. Without HC de-aliasing, cortex receives contradictory training signal from aliased observations. HC fast binding is not just for recall — it makes slow cortical learning tractable.

---

## Cortical Columns as HC Formation Copies (TBT)

Thousand Brains Theory [[wiki/entities/htm-thousand-brains.md]] proposes the HC formation as the evolutionary template for every cortical column. Each of the ~150,000 neocortical columns recapitulates MEC/LEC/HC as L6/L4/L2-3:

| HC formation | Cortical column (TBT) |
|---|---|
| MEC (g, path integration) | L6 (grid-like, efference copy from L5) |
| LEC (x, sensory) | L4 |
| HC (p, binding) | L2-3 (+ lateral consensus voting) |

The L5→L6 efference copy loop is absent from the HC formation: HC receives "where" from MEC; cortical columns generate "where" from their own motor predictions. If TBT (Thousand Brains Theory) is correct, the HC circuit is not a specialized memory module but the universal cortical unit — instantiated at scale across the entire neocortex.

---

## HC as Network Hub

The brain's connectivity is small-world ([[wiki/concepts/small-world-networks.md]]): most regions are locally clustered, but a small number of hub nodes have disproportionately many long-range connections (heavy-tailed degree distribution). HC is one of these hubs — its anatomical connectivity spans MEC, LEC, prefrontal cortex, amygdala, thalamus, hypothalamus, brainstem, and sensory cortices. This is the structural ground for hippocampal indexing theory:

- **Why HC can bind N cortical inputs:** hub topology gives HC axonal reach to all of them without requiring each pair to connect directly.
- **Why HC damage causes global amnesia:** removing a high-degree hub severs many cross-regional paths simultaneously; non-hub cortical lesions cause narrow deficits because alternative paths remain.
- **Why HC is the two-timescale bottleneck:** only a hub with cross-regional reach can aggregate (state, next-state) pairs from all cortical subspaces and provide the clean structural training signal that slow W learning requires.

The vmPFC and the broader default mode network (PCC, TPJ, RSC, LPC) also function as hubs — consistent with Constantinescu 2016 finding the strongest grid-code signal in vmPFC rather than MEC: abstract structural codes concentrate in hub nodes, not in local processing modules.

---

## MECII vs. MECIII Functional Dissociation

Spiking TEM ([[wiki/papers/spiking-tem-kawahara-2025.md]]) provides a mechanistic account of why MECII and MECIII serve distinct temporal coding roles — a distinction that is implicit in the anatomy but unresolved in TEM 2020:

| Layer | Temporal mode | Functional role | Mechanism |
|---|---|---|---|
| **MECII** | Phase-precessing | Current state + look-ahead (t, t+1, ...) encoder | Neuromodulatory gain G drives spike-phase advance |
| **MECIII** | Phase-locked | Predicted next state (t+1) encoder | Theta inhibitory input stabilizes phase; MECIII neurons have highest gridness at position t+1 |

**Mapping to TEM architecture:** MECIII implements the generative model (predict future from current latent state); MECII implements the inference model output (current structural code). The G + theta_MECIII combination that produces this dissociation is the biological realization of the TEM generative/inference split.

**Control experiment:** removing G → both layers lock (no look-ahead); removing theta_MECIII → both precess. The biological MECII/MECIII split requires *both* mechanisms simultaneously — a concrete architectural constraint for any spiking implementation of TEM.

See [[wiki/concepts/phase-precession.md]] for the full formalism.

---

## Theta-Phase Encoding/Retrieval Oscillation

The theta rhythm (4–8 Hz) creates a constant fine-grained alternation: retrieval sub-phase (CA3 dominant → expectation) and encoding sub-phase (EC dominant → outcome). The delta between phases drives contrastive Hebbian weight updates — HC continuously corrects its own retrieval errors at theta frequency, not just writes Hebbianly. Full account in [[wiki/concepts/replay.md]] and [[wiki/concepts/two-learning-timescales.md]].

ACh sets the coarser mode bias; theta oscillates *within* that bias — the two mechanisms are complementary, not redundant.

---

## Cholinergic Control of HC Mode

High ACh (novelty/task demand) → storage mode: suppresses CA3→CA1 Schaffer collaterals, enables LEC→CA1 direct encoding. Low ACh → retrieval mode: restores CA3 pattern completion, de-emphasizes LEC input. Full account in [[wiki/concepts/neuromodulation.md]] (ACh/HC section). This is the neural implementation of the fast-M/slow-W switch — see [[wiki/concepts/two-learning-timescales.md]] (cholinergic gating section).

---

## Convergent Allocentric Systems

The HC formation is one of at least 5–6 independent evolutionary derivations of allocentric world modeling [[wiki/concepts/convergent-allocentric-coding.md]]. Among arthropods alone, both mushroom bodies (contextual binding) and the central complex (heading + path integration) implement complementary aspects of what the HC formation handles in a single system — suggesting the vertebrate HC formation is a more integrated version of functions distributed across two arthropod structures.

See individual pages: [[wiki/entities/insect-central-complex.md]], [[wiki/entities/arthropod-mushroom-bodies.md]], [[wiki/entities/cephalopod-vertical-lobe.md]], [[wiki/entities/crustacean-hemiellipsoid-bodies.md]], [[wiki/entities/polychaete-mushroom-bodies.md]].

---

## Mushroom Bodies as Convergent HC-Like System

Jumping spider mushroom bodies represent an independent evolutionary derivation of the HC computation [[wiki/papers/jumping-spiders-cognition.md]] [[wiki/entities/arthropod-mushroom-bodies.md]]:

| Feature | Vertebrate HC formation | Spider mushroom body |
|---|---|---|
| Allocentric place cells | Yes (HC) | (tentative) Yes — *H. dossenus* electrophysiology |
| Structural coordinate code | MEC grid cells | (tentative) Grid-like co-location |
| Cross-modal binding zone | MEC + LEC convergence in HC | Visual + vibrational convergence zone |
| Evolutionary age | ~400 Mya vertebrate split | ~400 Mya arthropod-vertebrate split |
| Neuron budget | ~10⁸–10⁹ (rodent) | <500,000 (full spider brain) |

**Implication:** the computation (allocentric spatial coding + multi-modal binding [[wiki/concepts/binding-problem.md]]) is the evolutionarily conserved target, not the anatomy. The minimal substrate — <500k neurons total — sets a practical lower bound on the architectural requirements for abstract spatial reasoning.

---

## HC as General Geometric Organizer of Learned Knowledge

Nieh et al. 2021 ([[wiki/papers/nieh-hippocampal-geometry-2021.md]]) identify a unifying principle behind spatial maps, latent-state encoding, and declarative memory: HC performs a **general computation** — mapping learned knowledge onto a task-specific low-dimensional manifold with geometric structure.

**Key results (dorsal CA1, n=7 mice, evidence accumulation VR task):**

| Finding | Detail |
|---|---|
| Joint encoding | ~29% of CA1 neurons have 2D firing fields in joint (position × evidence) space; significantly more mutual information than either variable alone |
| Manifold dimensionality | ~5.4D [4.8, 6.0] nonlinear manifold in ~450D neural state space (MIND); scales with task complexity |
| Gradient structure | Position and evidence appear as smooth orthogonal gradients in the embedding |
| Sensory vs. neural | Visual manifold: luminance gradient, no evidence; neural manifold: evidence but less luminance — HC adds learned/integrated knowledge |
| Cross-animal sharing | ~69–75% of manifold geometry shared across animals after SO(5) rotation — geometry is task-specific, not animal-specific |

**Implications for the TEM factorization:** TEM's clean g/x/p split assumes structural code and sensory content are factorized. Evidence cells challenge this: the abstract variable (accumulated evidence) is jointly encoded with position in individual neurons, not segregated into a separate module. The manifold provides a unified geometric space; factorization is a property of the *dimensions* of that manifold (orthogonal gradients), not of separate cell populations. HC builds one manifold; factorization emerges as orthogonality within it.

**Why not two separate modules:** An alternative hypothesis (context-specific place cells) predicts reliable place cell sequences per trial. Instead, trial-by-trial neural sequences differ because the evidence trajectory differed — consistent only with joint encoding in a shared manifold.

---

## HPC as Persistent Abstract-State Maintainer

Bernardi et al. 2020 ([[wiki/papers/geometry-abstraction-bernardi-2020.md]]) record HPC and PFC (Prefrontal Cortex) simultaneously during a serial reversal-learning task with an uncued hidden variable (context):

| Brain area | Pre-stimulus context CCGP (Cross-Condition Generalization Performance) | Decision-epoch context CCGP (Cross-Condition Generalization Performance) | Post-decision |
|---|---|---|---|
| **HPC** | High (abstract) | **Maintained** | High |
| DLPFC | High | **Drops to chance** | Recovers |
| ACC (Anterior Cingulate Cortex) | High | Weak | Recovers |

**HPC is not merely a pattern completer for episodic content — it persistently maintains abstract latent-state representations that PFC (Prefrontal Cortex) uses for action selection.** The conjunctive code p = f(g, x) satisfies the CCGP (Cross-Condition Generalization Performance) criterion: the coding direction for context is parallel across all stimulus-context combinations, enabling zero-shot generalization when context structure is familiar from prior experience.

DLPFC loses context abstraction during the decision epoch because context must be non-linearly combined with stimulus identity to select the correct action — a computational cost that HPC avoids by not computing the action itself. CCGP (Cross-Condition Generalization Performance) for context correlates with behavioral accuracy (error trials → reduced CCGP (Cross-Condition Generalization Performance), unchanged traditional decoding). See [[wiki/concepts/representational-geometry.md]] for the full CCGP (Cross-Condition Generalization Performance)/SD/PS framework.

**Human single-unit evidence (Courellis et al. 2024; [[wiki/papers/courellis-hpc-abstract-inference-2024.md]]).** Human recordings in 17 epilepsy patients (2,694 neurons across HC, amygdala, vmPFC, dACC, pre-SMA, VTC) confirm HC specificity and add three mechanistic findings:

1. **Sparsification co-occurs with abstraction.** HC firing rates drop ~60% (3.37 → 1.36 Hz) during inference-capable sessions. Context centroid separation is the lone variable that *increases* against this trend; the sparser background isolates the context coding direction as the dominant variance axis. Individual neurons become more consistent in context modulation direction across stimuli (increased PS). Dynamic SDR (Sparse Distributed Representations) analog: activity sparsification and representational abstraction are co-emergent.

2. **Trial-level CCGP (Cross-Condition Generalization Performance) tracks behavior.** Context CCGP (Cross-Condition Generalization Performance) (not raw decoding accuracy) predicts trial-by-trial inference success; error trials → CCGP (Cross-Condition Generalization Performance) drops to inference-absent levels while standard decoding stays above chance.

3. **Verbal instruction equivalence.** A 5-minute description of the latent context structure produces geometrically identical HC representations to trial-and-error discovery — the abstract format is channel-independent.

---

## DNC (Differentiable Neural Computer) as an Engineered HC/PFC Implementation

The Differentiable Neural Computer (DNC; Graves et al. 2016 [[wiki/papers/dnc-graves-2016.md]]) is the most explicit engineered implementation of HC computational function in the ML literature. Its three core mechanisms map directly onto three HC subsystem functions:

| DNC (Differentiable Neural Computer) mechanism | HC analog | Functional role |
|---|---|---|
| **Content-based lookup** (cosine similarity over memory rows) | CA3/CA1 associative LTP (Long-Term Potentiation) — pattern completion from partial cue | Retrieve episode-specific content from a partial key; soft attention = energy minimization approximation |
| **Temporal link matrix** L[i,j] (tracks write order) | Temporal context model (Howard & Kahana 2002) — free-recall order | Recover write-order sequences; forward/backward reads traverse the stored sequence without STDP accumulation |
| **Dynamic memory allocation** (usage vector u; free gates) | DG (Dentate Gyrus) neurogenesis + representational sparsity | Allocate new locations for new inputs; free locations after use; prevent interference between stored episodes |

**Controller = PFC, memory = HC:**

The DNC (Differentiable Neural Computer) controller (LSTM) learns global regularities across episodes — analogous to slow-W PFC/cortical learning. The memory matrix M stores episode-specific variables (instance-graph edges, goal constraints, graph triples) and is reset between episodes — analogous to HC's fast-M episodic role. This mapping is not metaphorical: the *information-theoretic* separation is identical. Controller weights encode what the agent *knows across experience*; memory contents encode what the agent *saw in this episode*.

**Prospective planning as emergent write-then-read:**

In Mini-SHRDLU, the DNC (Differentiable Neural Computer) writes goal constraints to memory at goal-presentation time (many steps before execution) and later reads them out selectively. A decoder applied to those memory contents predicts the first action with 89% accuracy at write time — 5× chance. This mirrors hippocampal preplay at spatial choice points: HC activates future-trajectory representations *before* the animal moves. In both cases, the system commits its plan to a readable memory medium in advance of execution, not in the weight trace of hidden unit dynamics.

**What DNC (Differentiable Neural Computer) does not implement:**

DNC lacks the slow-W structural generalization that MEC/cortex provides. The controller LSTM must re-derive meta-graph rules from scratch for each environment family — it cannot transfer the relational structure of graph traversal to a new graph format without retraining. TEM addresses exactly this gap via the factorized g/x/p code. The ideal architecture combines DNC's external read-write memory (fast M, unbounded capacity, one-shot writes) with TEM's factorized structural code (slow W, cross-environment meta-graph generalization) — a combination neither model achieves alone.

---

## Hippocampal Preplay and Simulation-Based Planning

At spatial choice points (T-junctions, maze forks), hippocampal SWR (Sharp Wave Ripple) events activate sequential representations of candidate future paths *before* the animal moves — preplay rather than retrospective replay. Activated sequences resemble those recorded during subsequent actual navigation.

| Event | Neural signature | Computational role |
|---|---|---|
| Animal pauses at choice point | Theta suppression; SWR (Sharp Wave Ripple) onset | Switch from active navigation to internal simulation |
| HC preplay SWR (Sharp Wave Ripple) | Sequential place cell activation, ~10–20× time-compressed | Forward rollout along a candidate trajectory |
| OFC (Orbitofrontal Cortex) / striatum activity | Value modulation correlated with replayed trajectory content | Evaluate simulated outcome |
| Action selection | Post-SWR; committed navigation | Execute highest-value simulated path |

**HC as active generative world model:** Preplay reveals HC as a forward simulator, not merely a memory retrieval system. PFC (Prefrontal Cortex) sets the goal (which destination is relevant?); HC generates candidate state sequences; OFC/striatum evaluates outcomes. This PFC-queries-HC architecture parallels the Differential Neural Computer (DNC): a neural network controller reads/writes an external content-addressable memory matrix — HC is the memory matrix; PFC (Prefrontal Cortex) is the controller.

**AI analog:** Model-based RL (Dyna algorithm), Monte Carlo tree search (AlphaGo), and deep generative models for trajectory simulation all implement the same decomposition. HC preplay provides biological evidence that this controller-model separation is not an engineering choice but an evolved architectural solution to the planning problem.

**Compositional simulation:** Human imagination assembles novel scenarios by recombining familiar elements — never-experienced trajectories from remembered components. HC's generative role requires combinatorial assembly across episodic memories, not just verbatim replay. This is the fast-M analog of compositional generalization: systematic recombination operating in the HC simulation regime rather than the slow-W structural extraction regime, and is why compositional representations in HC are a prerequisite for human-like planning.

---

## vmPFC→MEC→dCA1 Top-Down Circuit for Memory Organization (De Sousa et al. 2026)

While the canonical HC-PFC circuit runs HC→PFC (providing episodic content to PFC), a parallel direct descending circuit runs vmPFC→MEC→dCA1, exerting top-down control over what gets encoded in HC in the first place.

**Anatomy of the descending pathway:**

| Segment | Cell type | Layer | Evidence |
|---|---|---|---|
| vmPFC neurons | Excitatory (GAD67−) | Deep layers of PL + ILA | Retrograde CTB + confocal |
| vmPFC→MEC terminals | Glutamatergic | MEC layers II, III, V (II: 25%, III: 23%, V: 48%) | Intersectional viral + anterograde transsynaptic |
| MEC→dCA1 projection | Temporoammonic | CA1 stratum lacunosum moleculare (SLM) | Anterograde transsynaptic; mCherry in SLM + DG mol. layer |
| NGF/NDNF+ cells | GABAergic interneuron | CA1 SLM | RNAscope for NDNF; c-Fos correlation with MEC activity |

**Functional logic:** vmPFC high activity → MEC high activity → NGF/NDNF+ cells active in SLM → gate EC and CA3 inputs to CA1 pyramidal neurons via SLM inhibition → low dCA1 ensemble overlap → memory separation. Inhibiting any step in this chain releases the gate and allows integration.

**What the NGF cells do:** NGF (neurogliaform/NDNF+) cells in CA1 SLM are proposed to modulate the relative balance of EC (temporoammonic) vs. CA3 (Schaffer) inputs to CA1 pyramidal cells. Their activity correlates positively with MEC c-Fos (r > 0, control mice); when vmPFC→MEC is inhibited, both MEC and NGF c-Fos decrease together; direct NDNF cell inhibition replicates the increased-overlap phenotype. This makes NGF cells a fourth interneuron type with a distinct role in ensemble overlap control — complementing the Pvalb/Sst/Vip/Id2 families characterized by Valero et al. 2025.

**vmPFC activity pattern during context learning:**

| Condition | vmPFC activity | vmPFC→MEC projecting neurons | dCA1 overlap | Memory outcome |
|---|---|---|---|---|
| Same context, 5h | Decreased | Decreased | High | Integration (local mechanism) |
| Same context, 7d | Decreased | Decreased | High | Integration (vmPFC permits) |
| Different contexts, 5h | Decreased | Decreased | High | Integration (temporal proximity dominates) |
| Different contexts, 7d | **Increased** | **Maintained** | Low | Separation (vmPFC→MEC active) |

The vmPFC effect is only present at the 7-day interval — systems consolidation must first transfer the prior-memory representation to vmPFC before the descending circuit becomes operational.

**Top-down memory allocation:** vmPFC→MEC projections bias co-allocation of prior-memory engram cells. Under inhibition of vmPFC→MEC, prior-context A neurons rise from ~15% to ~27% of the top-10%-active population encoding context B — matching the same-context-revisit distribution. This is a novel allocation mechanism that supplements CREB excitability competition, operating at cross-session (7-day+) timescales.

**Contextual specificity:** The pathway is selective — vmPFC→MEC inhibition increases overlap between two contexts but not between a context and a home-cage event, or between two different HC-dependent tasks (social transmission of food preference vs. context). Top-down integration control is content-sensitive, not a global gain change.

**LEC arm (separate function):** vmPFC→LEC inhibition produces memory generalization (elevated freezing in novel context C), suggesting the LEC pathway has a complementary role in context-boundary control rather than overlap regulation per se.

**Architectural implication:** The HC-MEC system is not just an afferent to PFC — it receives a direct descending control signal from vmPFC that shapes what gets stored in HC. Any model treating HC as a purely bottom-up episodic encoder misses this top-down schema-integration gate. The canonical architecture must include a vmPFC→MEC channel that controls the HC encoding mode based on consolidated prior knowledge.

---

## HC-PFC Communication: Encoding vs. Retrieval Dissociation

Sigurdsson & Duvarci 2016 ([[wiki/papers/hpc-pfc-interactions-sigurdsson-2016.md]]) synthesize the electrophysiological evidence linking theta/gamma synchrony to the distinct phases of spatial WM:

| Phase | Synchrony band | Circuit | Functional role |
|-------|---------------|---------|----------------|
| **Sample/encoding** | Gamma (30–80 Hz) | vHPC → mPFC direct glutamatergic monosynaptic | Transmits spatial content to PFC; silencing this input abolishes gamma sync and goal-specific PFC coding |
| **Choice/retrieval** | Theta (4–12 Hz) | Indirect (NR thalamus + dHPC relay) | Accumulates HC content into decision; unaffected by silencing direct vHPC terminals |

**Key finding (optogenetics):** Spellman et al. 2015 silenced vHPC axon terminals in mPFC with millisecond precision. Impairments: encoding (sample phase) and gamma synchrony. Unaffected: theta synchrony and the choice phase. This dissociates the two synchrony carriers at the circuit level.

**Phase locking as information channel:** PFC neurons phase-locked to hippocampal theta show stronger spatial tuning — the degree of theta phase-locking predicts behavioral performance. Synchrony is not epiphenomenal; it is the carrier of spatial information from HC to PFC.

**Anatomical substrate:** vHPC → mPFC (monosynaptic, glutamatergic); ACC → dHPC CA1/CA3 (reverse monosynaptic, causally required for memory retrieval). NR thalamus is reciprocally connected to both structures and is the main candidate for coordinating theta synchrony between dHPC and mPFC.

**Division of labor:** HC provides episodic/spatial content (sample phase) → PFC accumulates and decides (choice phase). This maps onto the HC one-step look-ahead / mPFC outcome translation split from Dupret 2020 ([[wiki/concepts/prospective-coding.md]]).

---

## H-PFC Pathway: Stress Vulnerability and Task-Demand Scaling

Two properties of the vHPC→mPFC pathway underappreciated in computational accounts (Spedding & Jay 2013 [[wiki/papers/spedding-jay-hpfc-psychiatric-2013.md]]):

**Stress sensitivity:** Acute and chronic stress specifically disrupt LTP induction in the H-PFC pathway. Molecular substrates: stress downregulates MEK/MAPK signaling and BDNF levels; antidepressants, glucocorticoid receptor antagonists, and clozapine each restore LTP and WM performance. Chronic stress additionally causes mPFC neuron atrophy. This identifies the H-PFC pathway as the stress-sensitive bottleneck of the corticolimbic network — failure here produces WM deficits and emotional regulation disruption simultaneously, because the same pathway serves both (via PL fear-expression vs. IL fear-inhibition arms; see HPC-Amygdala-mPFC Tripartite Motivational Circuit above). For a reasoning model: the HC→PFC channel is the highest-risk single point of failure under resource constraints or noise.

**Task-demand theta scaling:** PFC neurons with the highest task-related firing rate show the strongest coupling to hippocampal theta — synchrony preferentially recruits the most engaged PFC ensembles rather than broadcasting uniformly. This parallels LC-NA gating of whole-brain integration ([[wiki/concepts/network-integration-segregation.md]]): cognitive demand upregulates HC-PFC channel gain, concentrating HC input onto the most active PFC assembly. Design implication: HC-PFC coupling strength should be conditioned on PFC engagement level, not set as a global constant.

---

## Prospective Code for Non-Spatial Inference (Dupret et al. 2020)

Hassabis et al. 2017 documented HC preplay at spatial choice points. Dupret et al. 2020 ([[wiki/papers/inferential-reasoning-dupret-2020.md]]) demonstrate the same prospective coding in a purely cognitive domain, using a **sensory preconditioning** paradigm:

- **Stage 1:** X (auditory) → Y (visual) paired, no reward
- **Stage 2:** Y → Z (reward or neutral) conditioned
- **Stage 3:** X presented alone; inference test (X was never paired with Z)

**Prospective code result (human fMRI + mouse CA1 electrophysiology, RSA):**

$$\text{RSM}_{within}(X_n, Y_n) > \text{RSM}_{cross}(X_n, Y_{m \neq n})$$

During correct inference, CA1 activity when X_n is shown is more similar to Y_n's representation than to cross-set visual cues — a representational look-ahead to the expected next element. Critically, the X→Y temporal spike order is preserved in CA1 ensembles even though Y is absent, confirming the code reproduces the original temporal statistics of the pairing.

| Result | Species | Method |
|--------|---------|--------|
| HC BOLD higher on correct vs. incorrect inference | Humans | 7T fMRI |
| RSM_within > RSM_cross during correct inference | Both | RSA (voxels/neurons) |
| X→Y spike order preserved | Mice | CA1 ensemble electrophysiology |
| dCA1 silencing impairs inference, not conditioning | Mice | Optogenetics (ArchT) |

**Division of mnemonic labor:** HC represents Y (the intermediary step) but **not** Z (the inferred outcome). Z is represented in mPFC and dopaminergic midbrain (identified by RSA searchlight across the whole imaged brain). This dissociation implies:
1. HC = one-step prospective predictor (X→Y)
2. mPFC/midbrain = outcome translator (Y→Z or direct X→Z from SWR (Sharp Wave Ripple) shortcuts)

**SWR shortcuts (rest/sleep):** During awake rest between inference trials, SWRs increasingly co-activate cell triplets (X, Y, Z) for rewarded pairs. With experience, X-Z doublets emerge in SWRs **without Y activity** — a cached direct link for an unobserved relationship. Reverse firing (Z before X in awake SWRs for rewarded pairs) suggests credit assignment broadcasting reward credit backward through the inferred chain. See [[wiki/concepts/replay.md]] for the full SWR (Sharp Wave Ripple) shortcut account.

**ML relevance:** This is direct evidence that the HC recall module must be paired with a downstream outcome-translation module for any inference task. A single HC-like module is insufficient to represent the full inferred chain; the division is functional, not merely anatomical.

---

## OSM: CA1 Builds a Latent State Machine During Learning (Sun et al. 2025)

Sun et al. 2025 ([[wiki/papers/sun-hippocampal-osm-2025.md]]) characterize how CA1 representations evolve across weeks of training, providing the first longitudinal account of cognitive map formation in an ambiguous-environment task.

**Task:** 2ACDC — two virtual linear tracks sharing identical visual cues except for a brief indicator region; reward location depends on which indicator was seen. Requires both short-term (indicator → reward) and long-term (track structure) memory.

**OSM formation:** CA1 undergoes progressive decorrelation — population vectors for visually identical track segments orthogonalize over days. The specific decorrelation order (off-diagonal → pre-R2 → pre-R1) is stereotyped across animals and matches CSCG (Baum-Welch EM) uniquely among all models tested. Beginning and end of track remain correlated throughout, consistent with no disambiguating information being available there.

**Two-timescale structure within CA1:** the state machine scaffold (slow, ~weeks) is preserved when new cue pairs are introduced; only the indicator-region mapping updates rapidly (~days, 147 vs. 483 trials). Structural learning and sensory binding operate on different timescales even within a single hippocampal subfield.

**What this adds to the HC model:**
- CA1 is not a passive relay of CA3 representations — it actively constructs orthogonalized state representations during learning.
- The HC fast-M store ([[wiki/concepts/two-learning-timescales.md]]) has internal two-timescale structure: state structure (slow) vs. state-to-cue mapping (fast).
- The algorithm matching hippocampal learning dynamics is Bayesian EM (Expectation Maximization) over discrete hidden states (CSCG), not gradient descent — a constraint on what biological plasticity rules must collectively approximate.

---

## Ventral/Dorsal HC Gradient: Schema Context vs. Episodic Specificity

Preston & Eichenbaum (2013) ([[wiki/papers/preston-eichenbaum-hpc-pfc-2013.md]]) provide behavioral evidence for a functional gradient along the HC longitudinal axis that parallels the latent-state geometry findings:

| Division | Rodent | Human | Functional role |
|---|---|---|---|
| **Ventral** | Ventral HC | Anterior HC | Gradual acquisition of generalized context representations; distinguishes *which context* events belong to; projects directly to mPFC |
| **Dorsal** | Dorsal HC | Posterior HC | Encodes specific events at specific places within a context; receives mPFC schema-selection input via perirhinal/LEC |

**Circuit consequence:** Ventral HC sends context-generalized signals to mPFC → mPFC selects the appropriate schema/rule → mPFC projects back via perirhinal cortex and LEC to gate what dorsal HC retrieves. When mPFC is inactivated, dorsal HC neurons indiscriminately fire to both appropriate and inappropriate object-reward associations — the dorsal HC can retrieve memories without mPFC input, but cannot be context-appropriately gated.

**Link to schema formation:** Transitive inference (A-B + B-C → A-C) and food-location schema tasks engage both divisions: ventral HC generalizes the schema context; dorsal HC retrieves the specific A-C association within that context. HC lesions block inferential expression even when individual pairs (A-B, B-C) are independently learned — the integration of overlapping associations into a schematic network requires HC, not just individual associative storage.

See **[[wiki/concepts/memory-schemas.md]]** for the full HC-mPFC division of labor across learning, consolidation, and expression stages.

---

## HPC-Amygdala-mPFC Tripartite Motivational Circuit

The HPC-mPFC connection is not a two-node system. **Ventral HC (VH) neurons that project to mPFC also simultaneously project to the amygdala** — a dual-projection architecture that places the VH as the switcher for the entire HC-amygdala-mPFC loop (Jin & Maren 2015; [[wiki/papers/jin-maren-hpc-pfc-emotion-2015.md]]).

**Circuit logic:**

| VH output | Target | Effect |
|---|---|---|
| VH context signal → PL (prelimbic) | mPFC | Drives fear expression via PL→amygdala BLA projection |
| VH context signal → IL (infralimbic) | mPFC | Drives fear inhibition via IL→amygdala ITC cells |
| VH dual-projection neurons | mPFC + amygdala simultaneously | VH gates *which* mPFC arm wins by simultaneously priming the amygdala to receive that arm's output |

**Fear renewal** (fear returning outside extinction context): VH-mPFC disconnection abolishes fear renewal. The VH context signal is the switch that determines whether the PL (fear) or IL (extinction/safety) arm of the mPFC-amygdala reciprocal circuit wins retrieval.

**Extinction memory is context-bound — not erasure:** fear and extinction memories coexist as competing schemas; HPC-dependent context gating selects which is expressed. Chronic stress blocks VH-evoked LTP in mPFC → impairs extinction encoding. BDNF in the VH-IL pathway and histone acetylation in the HPC-IL network are molecular substrates of extinction memory formation.

**NAcc as the motivational convergence zone:** the nucleus accumbens (NAcc) receives convergent inputs from all three nodes — PFC (cognitive rule), HPC (contextual state), amygdala (emotional/motivational valence). NAcc integrates these three signals to produce goal-directed action selection. This makes NAcc the downstream hub where:
- HC provides *where/when am I* (context)
- Amygdala provides *how much does this matter* (emotional salience)
- PFC provides *what rule applies here* (schema/goal)

**Design implication for a reasoning model:** the context-encoding module (HC analog) should not only route to the schema-selector (PFC analog) but simultaneously gate the motivational/valuation module (amygdala/NAcc analog). This motivational gating determines *priority* — which schema is relevant given current goal-relevance — not just which schema matches the context. Motivation is a first-class input to schema selection, not a downstream consequence of it. The RE (nucleus reuniens) provides the complementary top-down channel: PFC goal signal → RE → HC, biasing HC toward goal-relevant forward simulation.

---

## Connections

- **[[wiki/concepts/factorized-representations.md]]** — the MEC/LEC/HC anatomy is the factorized architecture made concrete: MEC = structural code `g`, LEC = sensory input `x`, HC = conjunctive code `p`; understanding the anatomy grounds the abstraction.
- **[[wiki/concepts/two-learning-timescales.md]]** — HC = fast M (Hebbian, episodic); MEC/cortex = slow W (structural); the dual map/memory role of HC is a direct consequence of which timescale dominates at different stages of learning.
- **[[wiki/entities/grid-cells.md]]** — grid cells in MEC are the cellular implementation of the structural code `g`; they make the MEC subsystem concrete.
- **[[wiki/entities/place-cells.md]]** — place cells in HC are the cellular implementation of the conjunctive code `p`; their remapping and latent-state variants make the HC subsystem concrete.
- **[[wiki/entities/tem-model.md]]** — TEM is a computational model *of* this system; understanding TEM's g/x/p/W/M architecture requires mapping it onto the biological anatomy here.
- **[[wiki/entities/cscg-model.md]]** — CSCG models the HC component specifically in the novel-environment/map regime; together with TEM it covers both roles of HC across the experience axis.
- **[[wiki/papers/gridlikecode-constantinescu-2016.md]]** — demonstrates that the structural-coding network extends beyond MEC-HC into vmPFC and default mode network during abstract cognition; motivates expanding the canonical anatomy.
- **[[wiki/concepts/attention.md]]** — transformer self-attention is a formal model of HC memory retrieval; TEM-t instantiates hippocampal indexing theory and provides a mechanistic account of place cell remapping.
- **[[wiki/papers/t-tem-whittington-2022.md]]** — source for hippocampal indexing theory instantiation; formalizes how HC binds N cortical inputs with fixed memory neuron count.
- **[[wiki/concepts/engrams.md]]** — brain-wide engram complex provides the empirical grounding for HC indexing theory; each brain region encodes a different memory aspect that HC's index binds together.
- **[[wiki/papers/engram-transcript.md]]** — source for brain-wide engram data, DG (Dentate Gyrus) sparsity, excitability competition mechanism.
- **[[wiki/entities/htm-thousand-brains.md]]** — TBT (Thousand Brains Theory) proposes the HC formation as evolutionary template for every cortical column; each column recapitulates MEC/LEC/HC as L6/L4/L2-3 with an added L5 efference copy loop, reframing HC from a specialized memory module to the universal cortical circuit unit.
- **[[wiki/papers/150000-mini-brain-transcript.md]]** — source for TBT's evolutionary claim and cortical layer correspondence table.
- **[[wiki/concepts/small-world-networks.md]]** — HC's hub status in the brain's small-world network is the anatomical explanation for why it can bind distributed cortical representations: hub connectivity enables cross-regional indexing without requiring direct cortex-cortex links for every pair.
- **[[wiki/papers/convergence-wiring-transcript.md]]** — source for small-world topology, hub nodes, and wiring cost arguments.
- **[[wiki/concepts/binding-problem.md]]** — the HC formation's core function is multi-modal binding (MEC + LEC → HC conjunctive code); mushroom body convergent evolution confirms cross-modal binding as the conserved computation — independent of hippocampal anatomy.
- **[[wiki/concepts/representational-geometry.md]]** — HPC satisfies the CCGP (Cross-Condition Generalization Performance) criterion for abstract representation of the hidden context variable throughout the decision epoch; this provides the geometric operationalization of "HC maintains the latent state" in measurable terms.
- **[[wiki/papers/geometry-abstraction-bernardi-2020.md]]** — source for the HPC vs. DLPFC temporal CCGP (Cross-Condition Generalization Performance) dynamics; empirically establishes HPC as the persistent abstract-state maintainer and demonstrates that CCGP (Cross-Condition Generalization Performance) (not traditional decoding) tracks behavioral accuracy.
- **[[wiki/papers/jumping-spiders-cognition.md]]** — source for mushroom body convergent evolution; allocentric place cells and grid-like coding achieved without hippocampus in <500k neurons, setting a lower bound on the minimal substrate for HC-equivalent computation.
- **[[wiki/concepts/convergent-allocentric-coding.md]]** — master comparative table across all convergent systems; HC formation is the highest-complexity, highest-generalization entry; the comparison table makes explicit what each system adds over the basic motif.
- **[[wiki/entities/insect-central-complex.md]]** — the cleanest mechanistically characterized convergent system; CX (Central Complex) heading ring + path integrator + goal vector ≈ the MEC-like (structural coordinates) component of what HC formation does, without the HC's cross-environment W generalization.
- **[[wiki/concepts/neuromodulation.md]]** — ACh (learning rate α in Doya 2002) directly gates HC between storage and retrieval modes; this is the biological signal that schedules the fast-M/slow-W transition and grounds the surprise-gated write (Block 2C) in cholinergic neuromodulation.
- **[[wiki/papers/metalearning-neuromodulation-doya-2002.md]]** — source for ACh storage/retrieval switch; basal ganglia actor-critic model; four-neuromodulator metalearning framework.
- **[[wiki/concepts/associative-memory.md]]** — CA3's ~9-11% recurrent connectivity (Sammons 2023) directly instantiates the Hopfield autoassociative model; log-normal weights and random connectivity are the biological mechanisms behind pattern completion.
- **[[wiki/papers/ca3-sammons-2023.md]]** — source for CA3 connectivity rates, c × M ≈ const relationship, log-normal EPSP distribution, and inhibitory STDP balancing.
- **[[wiki/papers/pattern-completion-rolls-2013.md]]** — source for DG (Dentate Gyrus) competitive learning theory, grid→place transformation, mossy fiber/perforant path encoding-recall separation, and p_max = k × C_RC / a storage capacity formula.
- **[[wiki/concepts/replay.md]]** — theta-phase oscillation is the fine-grained mechanism controlling when HC replays (retrieval sub-phase) versus encodes (encoding sub-phase); SWR (Sharp Wave Ripple) replay during sleep is the offline extension of the same encoding/retrieval alternation into consolidated consolidation.
- **[[wiki/papers/cls-oreilly-2011.md]]** — source for CA1 invertible mapper role, theta-phase error-driven learning, consolidation-as-transformation, and bidirectional HC-neocortex synergy; foundational CLS (Complementary Learning Systems) review establishing the biological two-timescale architecture.
- **[[wiki/papers/learning-fast-slow-liao-2024.md]]** — source for BTSP mechanism in CA1; EC (Entorhinal Cortex) as instructive signal source for plateau potentials; BTSP+STDP within-HC two-timescale hierarchy; adaptive replay selectivity and inhibitory plasticity as structural filtering mechanism.
- **[[wiki/concepts/btsp.md]]** — dedicated concept page: binary BTSP rule, bimodal distribution mechanism, stochastic gating parameter $f_q$, repulsion effect, capacity analysis, and ML design implications for episodic memory systems.
- **[[wiki/papers/wu-maass-btsp-2025.md]]** — primary source for the binary BTSP model; establishes that binary weights achieve Hopfield-equivalent CAM performance at sparse input densities; first learning-based model of the human memory repulsion effect.
- **[[wiki/papers/hpc-pfc-interactions-sigurdsson-2016.md]]** — source for the theta/gamma encoding/retrieval dissociation; causal optogenetic evidence that direct vHPC→mPFC input drives gamma synchrony during encoding but not theta during retrieval; NR thalamus as indirect theta relay.
- **[[wiki/papers/yassa-stark-pattern-separation-2011.md]]** — source for CA3 bidirectional transfer function (completion for small Δinput, separation for large Δinput) and CA1 linear response; multi-species convergent validation of the DG→CA3→CA1 three-zone model.
- **[[wiki/concepts/continual-learning.md]]** — HC's CLS (Complementary Learning Systems) architecture is the primary biological solution to catastrophic forgetting: DG (Dentate Gyrus) sparsity orthogonalizes stored patterns, preventing interference; SWR (Sharp Wave Ripple) replay drives neocortical consolidation; HC preplay extends the fast-M simulation function beyond retrospective recall to prospective planning without requiring new slow-W updates.
- **[[wiki/papers/hassabis-neuroscience-ai-2017.md]]** — source for HC preplay as internal forward simulation at choice points; PFC-controller/HC-world-model architecture for simulation-based planning; experience replay in DQN as a "primitive hippocampus" implementing complementary learning in silico.
- **[[wiki/concepts/phase-precession.md]]** — MECII phase precession and MECIII phase locking are two expressions of theta-phase organization; MECIII's predictive role maps directly onto TEM's generative model; the G + theta_MECIII mechanism is the concrete biological implementation of the generative/inference split.
- **[[wiki/papers/spiking-tem-kawahara-2025.md]]** — source for MECII/MECIII functional dissociation; establishes that neuromodulatory gain G and theta inhibition together control which temporal coding mode each MEC layer adopts.
- **[[wiki/entities/vector-hash-model.md]]** — Vector-HaSH instantiates the MEC-HC circuit as a scaffold/heteroassociation split; resolves the spatial/episodic dual role by showing that the same grid scaffold is optimal for both via the shift operator; the model makes the "graceful capacity-detail tradeoff" a circuit-level prediction.
- **[[wiki/papers/vector-hash-chandra-2023.md]]** — source for the Vector-HaSH circuit model, memory palace account, and formal argument that grid codes are domain-general rather than spatially specific.
- **[[wiki/entities/dnc-model.md]]** — DNC (Differentiable Neural Computer) instantiates the PFC-queries-HC architecture as a fully differentiable system: controller=PFC (slow W), memory matrix=HC (fast M), content lookup=CA3 pattern completion, temporal links=temporal context model, allocation=DG neurogenesis; the clearest engineered instantiation of HC computation in ML; what DNC (Differentiable Neural Computer) lacks (structural W generalization) is exactly what TEM provides.
- **[[wiki/papers/dnc-graves-2016.md]]** — source: three-mechanism HC mapping (content lookup/temporal links/allocation); Mini-SHRDLU prospective planning (89% first-action decode at goal-write time); graph traversal necessity of external memory (LSTM: 37%, DNC: 98.8%).
- **[[wiki/papers/courellis-hpc-abstract-inference-2024.md]]** — human single-unit confirmation that HC is the only region achieving simultaneous multi-variable abstraction across 6 brain areas (including amygdala as negative control); sparsification (60% firing-rate decrease) co-occurs with abstract representation emergence; verbal instruction equivalence establishes the abstract format is channel-independent.
- **[[wiki/papers/spiking-cam-hippocampus-casanueva-2024.md]]** — first functional SNN implementation of CA3 as a bidirectional CAM; dual STDP sub-networks (S1: cue→content, S2: content→cue) operationalize the autoassociative and reverse-lookup functions; DG (Dentate Gyrus) one-hot encoder grounds the pattern-separation prerequisite in a concrete architectural choice.
- **[[wiki/entities/snn.md]]** — CA3-CAM demonstrates that STDP is sufficient for content-addressable storage and retrieval in a full spiking architecture; the SpiNNaker deployment validates neuromorphic feasibility of HC-inspired memory circuits.
- **[[wiki/papers/nieh-hippocampal-geometry-2021.md]]** — source for HC as general geometric organizer: ~5.4D joint manifold, ~29% joint-encoding CA1 neurons, orthogonal gradients for physical and abstract variables, ~70% cross-animal geometry sharing; challenges strict g/x/p factorization for learned abstract variables.
- **[[wiki/papers/sun-hippocampal-osm-2025.md]]** — source for OSM learning dynamics in CA1: progressive decorrelation trajectory, CSCG as the uniquely matching algorithm, two-timescale structure within CA1, and state cells as a continuum; the most direct evidence that HC actively implements latent-state inference via a process consistent with Bayesian EM.
- **[[wiki/entities/hami-model.md]]** — the most complete RL-level operationalization of the hippocampal processing pipeline: separate LEC (event) and MEC (context) encoders feed a CA3-inspired conjunctive symbolic indexing module, with CA1-inspired temporal integration and PFC-style action selection; confirms that the LEC/MEC anatomical split translates into a useful inductive bias for context-dependent sequential RL.
- **[[wiki/concepts/prospective-coding.md]]** — the dedicated concept page for the look-ahead mechanism; the inference-version (X→Y in association space) and spatial preplay version are the same CA1 operation; optogenetic causal necessity and RSA operationalization live there.
- **[[wiki/papers/inferential-reasoning-dupret-2020.md]]** — primary source for the prospective code during inference, SWR (Sharp Wave Ripple) shortcut construction, and the HC-vs-mPFC/midbrain division of mnemonic labor; the most direct mechanistic evidence that HC implements one-step look-ahead rather than full-chain inference.
- **[[wiki/entities/default-mode-network.md]]** — DMN cortical nodes (PCC, RSC, mPFC) are downstream recipients of HC episodic codes and the site of the strongest abstract grid signals; HC-DMN coupling is the full episodic integration circuit, with HC as indexing hub and DMN as the semantic/contextual layer holding what the index binds.
- **[[wiki/papers/valero-interneuron-families-2025.md]]** — four GABAergic families (Pvalb/Sst/Vip/Id2) cooperatively implement the CA1 cognitive map through division of labor; VIP disinhibitory gate provides context-sensitive gain modulation; circuit motifs conserved across hippocampus and neocortex.
- **[[wiki/concepts/canonical-microcircuit.md]]** — the four-family interneuron dissociation in CA1 is the hippocampal instance of the canonical circuit's inhibitory dissociation; conservation across regions supports treating it as a universal circuit module.
- **[[wiki/concepts/memory-schemas.md]]** — ventral/anterior HC sends generalized context representations to mPFC to initiate schema selection; dorsal/posterior HC retrieves specific events under mPFC schema-gating; time cells provide the temporal axis that schemas require to order episodes into organized networks; HC lesions block schematic inference (A-C) even when individual associations (A-B, B-C) are learned; fear/extinction coexistence is the biological instance of competing schemas selected by context.
- **[[wiki/papers/preston-eichenbaum-hpc-pfc-2013.md]]** — source for the ventral/dorsal HC functional gradient, time cells, schema formation via overlapping associations, and the bidirectional HC↔mPFC circuit model; provides behavioral evidence that HC integrates overlapping pairs into schematic organizations that support transitive inference.
- **[[wiki/entities/nucleus-reuniens.md]]** — RE (nucleus reuniens) is the indirect mPFC→HC relay; single RE neurons fan out simultaneously to HC and mPFC; mPFC→RE→sHPC pathway causally required for goal-directed future path representation and spatial WM; RE stimulation modulates plasticity in both targets — an active gain-controller, not a passive relay.
- **[[wiki/papers/jin-maren-hpc-pfc-emotion-2015.md]]** — primary source for the HPC-amygdala-mPFC tripartite circuit; VH dual-projecting neurons; context-bound extinction; NAcc as motivational convergence zone (HC context + amygdala valence + PFC rule → goal-directed action); RE anatomy and functional evidence.
- **[[wiki/papers/spedding-jay-hpfc-psychiatric-2013.md]]** — source for H-PFC pathway stress vulnerability (stress → MEK/MAPK + BDNF disruption → LTP failure → WM impairment + mPFC neuron atrophy) and task-demand theta scaling (highest task-active PFC neurons show strongest HC-theta coupling); D1 dopamine regulation of H-PFC LTP and interneuron-mediated inhibitory mechanism.
- **[[wiki/papers/kumaran-maguire-2005-hippocampus.md]]** — primary source for HC spatial bias; factorial fMRI design directly refutes the relational theory's domain-generality prediction; defines the boundary conditions of "HC as relational inference engine" as metric or temporal-sequential structure specifically, not amodal associative networks.
- **[[wiki/papers/desousa-pfc-memory-organization-hpc-2026.md]]** — source for the vmPFC→MEC→dCA1 SLM descending circuit; establishes NGF/NDNF+ cells in CA1 SLM as the interneuron population through which vmPFC controls ensemble overlap; demonstrates top-down memory allocation bias; characterizes the time-gate (~7 days) and content-specificity of the circuit.
- **[[wiki/entities/prefrontal-cortex.md]]** — vmPFC is the origin of the descending circuit described in the vmPFC→MEC section above; vmPFC schema consolidation (~7 days via systems consolidation) is the prerequisite for the descending signal to become operational; the bidirectional HC↔vmPFC relationship (HC→vmPFC for episodic content; vmPFC→MEC→HC for schema-guided encoding control) must be understood together.
- **[[wiki/concepts/memory-schemas.md]]** — the vmPFC→MEC→dCA1 circuit is the biological implementation of schema-guided assimilation/accommodation in HC; MEC is the relay between vmPFC's schema representation and HC's encoding machinery.
- **[[wiki/concepts/engrams.md]]** — the vmPFC→MEC top-down circuit controls which prior-memory engram cells are co-allocated during new encoding; this is an experience-gated allocation mechanism that supplements CREB excitability competition and operates at 7-day+ timescales.
- **[[wiki/concepts/pattern-separation.md]]** — NGF/NDNF+ cells in CA1 SLM are the effectors of the top-down separation/integration control; they extend the regulatory hierarchy (ACh→global mode; NA→DG gain; vmPFC→MEC→NGF→CA1 overlap) to include a cortical schema-level layer.
