---
title: "Hippocampal-Entorhinal System"
type: entity
tags: [hippocampus, entorhinal-cortex, MEC, LEC, memory, navigation, relational-inference]
created: 2026-06-09
updated: 2026-06-22
sources: [gridlikecode, t-TEM, engram-transcript, convergence-wiring-transcript, jumping-spiders-cognition, convergent-brain-structures-spatial-memory, Metalearning_and_Neuromodulation, Structure and function of the hippocampal CA3 module, The mechanisms for pattern completion and pattern separation in the hippocampus, Complementary Learning Systems, Learning Fast and Slow Single- and Many-Shot Learning in the Hippocampus, Pattern separation in the hippocampus.md, Neuroscience-Inspired Artificial Intelligence, High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations]
related: [wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/path-integration.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/latent-states.md, wiki/concepts/attention.md, wiki/concepts/engrams.md, wiki/concepts/small-world-networks.md, wiki/concepts/binding-problem.md, wiki/concepts/convergent-allocentric-coding.md, wiki/concepts/neuromodulation.md, wiki/concepts/associative-memory.md, wiki/concepts/pattern-separation.md, wiki/concepts/replay.md, wiki/concepts/continual-learning.md, wiki/concepts/phase-precession.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/tem-model.md, wiki/entities/cscg-model.md, wiki/entities/htm-thousand-brains.md, wiki/entities/insect-central-complex.md, wiki/entities/arthropod-mushroom-bodies.md, wiki/entities/cephalopod-vertical-lobe.md, wiki/entities/vector-hash-model.md, wiki/entities/dnc-model.md, wiki/papers/gridlikecode-constantinescu-2016.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/engram-transcript.md, wiki/papers/150000-mini-brain-transcript.md, wiki/papers/convergence-wiring-transcript.md, wiki/papers/jumping-spiders-cognition.md, wiki/papers/metalearning-neuromodulation-doya-2002.md, wiki/papers/ca3-sammons-2023.md, wiki/papers/pattern-completion-rolls-2013.md, wiki/papers/cls-oreilly-2011.md, wiki/papers/learning-fast-slow-liao-2024.md, wiki/papers/hassabis-neuroscience-ai-2017.md, wiki/papers/spiking-tem-kawahara-2025.md, wiki/papers/vector-hash-chandra-2023.md, wiki/papers/dnc-graves-2016.md]
---

# Hippocampal-Entorhinal System

The brain's relational inference engine. TEM models it as a factorized world model.

---

## Anatomy

**MEC (Medial Entorhinal Cortex):** structural coordinate system — grid cells, border cells, OVCs, head direction cells. Representations generalize across environments. = structural code g + weights W.

**LEC (Lateral Entorhinal Cortex):** sensory content — object and event representations. Environment-specific. = sensory input x.

**HC (Hippocampus):** conjunctive binding — place cells, plus latent-state variants (splitter, lap, evidence cells). Rapid one-shot episodic memory. Remaps between environments (but non-randomly: preserves grid-phase relationships). = conjunctive code p + Hebbian weights M.

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

**CA3's bidirectional function (Yassa & Stark 2011 [[wiki/papers/yassa-stark-pattern-separation-2011.md]]):** CA3 is not a pure pattern completer. Its nonlinear attractor dynamics are *bidirectional*: small Δinput (similar environments, similar cues) keeps the network in an existing attractor basin → completion; large Δinput (distinct environments) exceeds the basin boundary → the network escapes and remaps → separation. CA1 by contrast responds linearly — neither completing nor separating, passing the combined DG/CA3 + EC signal proportionally. Full transfer function account in [[wiki/concepts/pattern-separation.md]] (Transfer Functions section).

---

## BTSP: The Molecular Mechanism of Single-Shot HC Encoding

Behavioral timescale synaptic plasticity (BTSP; Bittner et al. 2017, reviewed in Liao & Losonczy 2024 [[wiki/papers/learning-fast-slow-liao-2024.md]]) is the actual single-shot learning rule in CA1 — superseding the "one-shot Hebbian LTP" shorthand used in CLS and TEM accounts.

**Mechanism:**
1. An *instructive signal* — plausibly from EC (Grienberger & Magee 2022 confirmed EC provides the causal signal) — evokes a long-lasting plateau potential in the distal apical dendrites of a CA1 pyramidal cell.
2. All synaptic inputs active within the preceding and immediately following seconds become simultaneously potentiated.
3. The potentiated weight ensemble drives the cell to fire whenever those inputs are next active — the cell's place field.

**Why BTSP, not Hebbian:** STDP operates on millisecond spike-pair coincidences; each event produces a small Δw, requiring many trials. BTSP integrates population activity over seconds, producing a large Δw in one shot. The law of large numbers makes this robust: spurious co-activation of a single synapse is statistically invisible against the mass of potentiated weights.

**First in vivo synaptic confirmation (Fan et al. 2023; Gonzalez et al. 2023):** All-optical physiology confirmed that new CA1 place field acquisition requires potentiation of CA2/3 Schaffer collateral input, and directly measured the plasticity kernel, providing the first synapse-level mechanistic evidence.

**Relationship to DG→CA3→CA1 pipeline:**
- DG competitive learning creates a sparse CA3 representation (pattern separation).
- CA3 recurrent collaterals support pattern completion (autoassociative attractor).
- CA1 receives converging CA3 + EC input — EC's instructive signal drives BTSP, writing the new conjunctive code.

| Plasticity rule | Timescale | Role in HC | Single-shot? |
|---|---|---|---|
| BTSP (CA1) | Seconds | Concept acquisition — new p code in one trial | Yes |
| STDP (CA3 RC) | Milliseconds | Sequence embedding — edge weights across trials | No (many-shot) |
| Theta-phase delta rule (CA3/CA1) | 4–8 Hz | Error-driven self-correction | Continuous |

---

## CA1: Sparse Invertible Mapper

CA1's role is underappreciated and frequently omitted in CLS accounts (O'Reilly et al. 2011 [[wiki/papers/cls-oreilly-2011.md]]). Without CA1, catastrophic interference persists even with perfect DG pattern separation:

**The CA3→EC interference problem:** CA3 produces arbitrary pattern-separated codes (novel, unrelated to anything seen before). If CA3 projected directly to EC, EC neurons — which have high overlap and participate in many memories — would need to rapidly learn associations with these novel CA3 patterns. This causes interference in EC, defeating the purpose of HC's sparse encoding.

**CA1's solution:**
| Property | Mechanism | Effect |
|---|---|---|
| **Sparse activity** | CA1 neurons participate in fewer memories than EC neurons | Less interference per new association |
| **Invertible mapping** | CA1 activity reconstructs original EC pattern during retrieval | Faithful recovery of cortical activity patterns |
| **Combinatorial code** | Novel inputs represented as recombinations of existing CA1 representational elements | Generalizes to novel input patterns without a new code from scratch |

CA1 is an active, learned binding layer — not a passive relay. Current CLS models initialize this combinatorial code artificially; how it develops during learning is an open problem. The one-shot Hebbian write mechanism ([[wiki/concepts/associative-memory.md]]) applies to CA3 recurrent collaterals; CA1's slower-developing combinatorial structure requires extended experience.

---

## DG Pattern Separator: Grid→Place Transformation

DG competitive learning (Hebbian + lateral inhibition) orthogonalizes entorhinal inputs before CA3 storage — the full account (five mechanisms, capacity formula $p_\text{max} \approx k \times C_{RC}/a$, mossy fiber/perforant path encoding-recall separation, adult neurogenesis) lives at **[[wiki/concepts/pattern-separation.md]]**.

**Grid→place:** Each DG granule cell learns to respond to a unique combination of co-active MEC grid cell patterns — uniquely identifying a place. In primates, the same mechanism produces *spatial view cells* (fovea ≈ 10–20° of visual angle per DG combination). ACh suppresses CA3→CA3 recurrent collaterals during encoding ([[wiki/concepts/neuromodulation.md]]), neuromodulatorily reinforcing the structural mossy fiber dominance.

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

## Hippocampal Indexing Theory (TEM-t)

TEM-t [[wiki/papers/t-tem-whittington-2022.md]] instantiates hippocampal indexing theory (Teyler & Rudy 2007): HC provides an *index* binding cortical representations across disparate brain areas. Memory neurons in HC link `g̃` (MEC), `x̃` (LEC), and any number of additional cortical regions `c̃`. Each new region adds only n_c feature neurons; HC memory neuron count stays fixed. Any cortical subset can reinstate the others via the HC index. This explains why hippocampal damage disrupts multimodal binding without destroying individual cortical memories.

---

## Beyond HC-ERH: Conceptual Grid Network

Constantinescu et al. 2016 ([[wiki/papers/gridlikecode-constantinescu-2016.md]]) show that abstract-space grid signals extend well beyond the classical hippocampal-entorhinal boundary into vmPFC, OFC, PCC, RSC, LPC, and TPJ — the default mode network. The vmPFC is the *strongest* region (peak Z=4.09), not the ERH. Implications:

- The structural-coding system is cortex-wide, not MEC-local.
- vmPFC's established role in value, memory, and conceptual generalization tasks suggests it may be where structural codes get applied to decision-making, not just maintained.
- This motivates incorporating prefrontal/DMN components into any model of structural generalization, beyond the MEC-HC core.

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

The L5→L6 efference copy loop is absent from the HC formation: HC receives "where" from MEC; cortical columns generate "where" from their own motor predictions. If TBT is correct, the HC circuit is not a specialized memory module but the universal cortical unit — instantiated at scale across the entire neocortex.

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

## HPC as Persistent Abstract-State Maintainer

Bernardi et al. 2020 ([[wiki/papers/geometry-abstraction-bernardi-2020.md]]) record HPC and PFC simultaneously during a serial reversal-learning task with an uncued hidden variable (context):

| Brain area | Pre-stimulus context CCGP | Decision-epoch context CCGP | Post-decision |
|---|---|---|---|
| **HPC** | High (abstract) | **Maintained** | High |
| DLPFC | High | **Drops to chance** | Recovers |
| ACC | High | Weak | Recovers |

**HPC is not merely a pattern completer for episodic content — it persistently maintains abstract latent-state representations that PFC uses for action selection.** The conjunctive code p = f(g, x) satisfies the CCGP criterion: the coding direction for context is parallel across all stimulus-context combinations, enabling zero-shot generalization when context structure is familiar from prior experience.

DLPFC loses context abstraction during the decision epoch because context must be non-linearly combined with stimulus identity to select the correct action — a computational cost that HPC avoids by not computing the action itself. CCGP for context correlates with behavioral accuracy (error trials → reduced CCGP, unchanged traditional decoding). See [[wiki/concepts/representational-geometry.md]] for the full CCGP/SD/PS framework.

---

## DNC as an Engineered HC/PFC Implementation

The Differentiable Neural Computer (DNC; Graves et al. 2016 [[wiki/papers/dnc-graves-2016.md]]) is the most explicit engineered implementation of HC computational function in the ML literature. Its three core mechanisms map directly onto three HC subsystem functions:

| DNC mechanism | HC analog | Functional role |
|---|---|---|
| **Content-based lookup** (cosine similarity over memory rows) | CA3/CA1 associative LTP — pattern completion from partial cue | Retrieve episode-specific content from a partial key; soft attention = energy minimization approximation |
| **Temporal link matrix** L[i,j] (tracks write order) | Temporal context model (Howard & Kahana 2002) — free-recall order | Recover write-order sequences; forward/backward reads traverse the stored sequence without STDP accumulation |
| **Dynamic memory allocation** (usage vector u; free gates) | DG neurogenesis + representational sparsity | Allocate new locations for new inputs; free locations after use; prevent interference between stored episodes |

**Controller = PFC, memory = HC:**

The DNC controller (LSTM) learns global regularities across episodes — analogous to slow-W PFC/cortical learning. The memory matrix M stores episode-specific variables (instance-graph edges, goal constraints, graph triples) and is reset between episodes — analogous to HC's fast-M episodic role. This mapping is not metaphorical: the *information-theoretic* separation is identical. Controller weights encode what the agent *knows across experience*; memory contents encode what the agent *saw in this episode*.

**Prospective planning as emergent write-then-read:**

In Mini-SHRDLU, the DNC writes goal constraints to memory at goal-presentation time (many steps before execution) and later reads them out selectively. A decoder applied to those memory contents predicts the first action with 89% accuracy at write time — 5× chance. This mirrors hippocampal preplay at spatial choice points: HC activates future-trajectory representations *before* the animal moves. In both cases, the system commits its plan to a readable memory medium in advance of execution, not in the weight trace of hidden unit dynamics.

**What DNC does not implement:**

DNC lacks the slow-W structural generalization that MEC/cortex provides. The controller LSTM must re-derive meta-graph rules from scratch for each environment family — it cannot transfer the relational structure of graph traversal to a new graph format without retraining. TEM addresses exactly this gap via the factorized g/x/p code. The ideal architecture combines DNC's external read-write memory (fast M, unbounded capacity, one-shot writes) with TEM's factorized structural code (slow W, cross-environment meta-graph generalization) — a combination neither model achieves alone.

---

## Hippocampal Preplay and Simulation-Based Planning

At spatial choice points (T-junctions, maze forks), hippocampal SWR events activate sequential representations of candidate future paths *before* the animal moves — preplay rather than retrospective replay. Activated sequences resemble those recorded during subsequent actual navigation.

| Event | Neural signature | Computational role |
|---|---|---|
| Animal pauses at choice point | Theta suppression; SWR onset | Switch from active navigation to internal simulation |
| HC preplay SWR | Sequential place cell activation, ~10–20× time-compressed | Forward rollout along a candidate trajectory |
| OFC / striatum activity | Value modulation correlated with replayed trajectory content | Evaluate simulated outcome |
| Action selection | Post-SWR; committed navigation | Execute highest-value simulated path |

**HC as active generative world model:** Preplay reveals HC as a forward simulator, not merely a memory retrieval system. PFC sets the goal (which destination is relevant?); HC generates candidate state sequences; OFC/striatum evaluates outcomes. This PFC-queries-HC architecture parallels the Differential Neural Computer (DNC): a neural network controller reads/writes an external content-addressable memory matrix — HC is the memory matrix; PFC is the controller.

**AI analog:** Model-based RL (Dyna algorithm), Monte Carlo tree search (AlphaGo), and deep generative models for trajectory simulation all implement the same decomposition. HC preplay provides biological evidence that this controller-model separation is not an engineering choice but an evolved architectural solution to the planning problem.

**Compositional simulation:** Human imagination assembles novel scenarios by recombining familiar elements — never-experienced trajectories from remembered components. HC's generative role requires combinatorial assembly across episodic memories, not just verbatim replay. This is the fast-M analog of compositional generalization: systematic recombination operating in the HC simulation regime rather than the slow-W structural extraction regime, and is why compositional representations in HC are a prerequisite for human-like planning.

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
- **[[wiki/papers/engram-transcript.md]]** — source for brain-wide engram data, DG sparsity, excitability competition mechanism.
- **[[wiki/entities/htm-thousand-brains.md]]** — TBT proposes the HC formation as evolutionary template for every cortical column; each column recapitulates MEC/LEC/HC as L6/L4/L2-3 with an added L5 efference copy loop, reframing HC from a specialized memory module to the universal cortical circuit unit.
- **[[wiki/papers/150000-mini-brain-transcript.md]]** — source for TBT's evolutionary claim and cortical layer correspondence table.
- **[[wiki/concepts/small-world-networks.md]]** — HC's hub status in the brain's small-world network is the anatomical explanation for why it can bind distributed cortical representations: hub connectivity enables cross-regional indexing without requiring direct cortex-cortex links for every pair.
- **[[wiki/papers/convergence-wiring-transcript.md]]** — source for small-world topology, hub nodes, and wiring cost arguments.
- **[[wiki/concepts/binding-problem.md]]** — the HC formation's core function is multi-modal binding (MEC + LEC → HC conjunctive code); mushroom body convergent evolution confirms cross-modal binding as the conserved computation — independent of hippocampal anatomy.
- **[[wiki/concepts/representational-geometry.md]]** — HPC satisfies the CCGP criterion for abstract representation of the hidden context variable throughout the decision epoch; this provides the geometric operationalization of "HC maintains the latent state" in measurable terms.
- **[[wiki/papers/geometry-abstraction-bernardi-2020.md]]** — source for the HPC vs. DLPFC temporal CCGP dynamics; empirically establishes HPC as the persistent abstract-state maintainer and demonstrates that CCGP (not traditional decoding) tracks behavioral accuracy.
- **[[wiki/papers/jumping-spiders-cognition.md]]** — source for mushroom body convergent evolution; allocentric place cells and grid-like coding achieved without hippocampus in <500k neurons, setting a lower bound on the minimal substrate for HC-equivalent computation.
- **[[wiki/concepts/convergent-allocentric-coding.md]]** — master comparative table across all convergent systems; HC formation is the highest-complexity, highest-generalization entry; the comparison table makes explicit what each system adds over the basic motif.
- **[[wiki/entities/insect-central-complex.md]]** — the cleanest mechanistically characterized convergent system; CX heading ring + path integrator + goal vector ≈ the MEC-like (structural coordinates) component of what HC formation does, without the HC's cross-environment W generalization.
- **[[wiki/concepts/neuromodulation.md]]** — ACh (learning rate α in Doya 2002) directly gates HC between storage and retrieval modes; this is the biological signal that schedules the fast-M/slow-W transition and grounds the surprise-gated write (Block 2C) in cholinergic neuromodulation.
- **[[wiki/papers/metalearning-neuromodulation-doya-2002.md]]** — source for ACh storage/retrieval switch; basal ganglia actor-critic model; four-neuromodulator metalearning framework.
- **[[wiki/concepts/associative-memory.md]]** — CA3's ~9-11% recurrent connectivity (Sammons 2023) directly instantiates the Hopfield autoassociative model; log-normal weights and random connectivity are the biological mechanisms behind pattern completion.
- **[[wiki/papers/ca3-sammons-2023.md]]** — source for CA3 connectivity rates, c × M ≈ const relationship, log-normal EPSP distribution, and inhibitory STDP balancing.
- **[[wiki/papers/pattern-completion-rolls-2013.md]]** — source for DG competitive learning theory, grid→place transformation, mossy fiber/perforant path encoding-recall separation, and p_max = k × C_RC / a storage capacity formula.
- **[[wiki/concepts/replay.md]]** — theta-phase oscillation is the fine-grained mechanism controlling when HC replays (retrieval sub-phase) versus encodes (encoding sub-phase); SWR replay during sleep is the offline extension of the same encoding/retrieval alternation into consolidated consolidation.
- **[[wiki/papers/cls-oreilly-2011.md]]** — source for CA1 invertible mapper role, theta-phase error-driven learning, consolidation-as-transformation, and bidirectional HC-neocortex synergy; foundational CLS review establishing the biological two-timescale architecture.
- **[[wiki/papers/learning-fast-slow-liao-2024.md]]** — source for BTSP mechanism in CA1; EC as instructive signal source for plateau potentials; BTSP+STDP within-HC two-timescale hierarchy; adaptive replay selectivity and inhibitory plasticity as structural filtering mechanism.
- **[[wiki/papers/yassa-stark-pattern-separation-2011.md]]** — source for CA3 bidirectional transfer function (completion for small Δinput, separation for large Δinput) and CA1 linear response; multi-species convergent validation of the DG→CA3→CA1 three-zone model.
- **[[wiki/concepts/continual-learning.md]]** — HC's CLS architecture is the primary biological solution to catastrophic forgetting: DG sparsity orthogonalizes stored patterns, preventing interference; SWR replay drives neocortical consolidation; HC preplay extends the fast-M simulation function beyond retrospective recall to prospective planning without requiring new slow-W updates.
- **[[wiki/papers/hassabis-neuroscience-ai-2017.md]]** — source for HC preplay as internal forward simulation at choice points; PFC-controller/HC-world-model architecture for simulation-based planning; experience replay in DQN as a "primitive hippocampus" implementing complementary learning in silico.
- **[[wiki/concepts/phase-precession.md]]** — MECII phase precession and MECIII phase locking are two expressions of theta-phase organization; MECIII's predictive role maps directly onto TEM's generative model; the G + theta_MECIII mechanism is the concrete biological implementation of the generative/inference split.
- **[[wiki/papers/spiking-tem-kawahara-2025.md]]** — source for MECII/MECIII functional dissociation; establishes that neuromodulatory gain G and theta inhibition together control which temporal coding mode each MEC layer adopts.
- **[[wiki/entities/vector-hash-model.md]]** — Vector-HaSH instantiates the MEC-HC circuit as a scaffold/heteroassociation split; resolves the spatial/episodic dual role by showing that the same grid scaffold is optimal for both via the shift operator; the model makes the "graceful capacity-detail tradeoff" a circuit-level prediction.
- **[[wiki/papers/vector-hash-chandra-2023.md]]** — source for the Vector-HaSH circuit model, memory palace account, and formal argument that grid codes are domain-general rather than spatially specific.
- **[[wiki/entities/dnc-model.md]]** — DNC instantiates the PFC-queries-HC architecture as a fully differentiable system: controller=PFC (slow W), memory matrix=HC (fast M), content lookup=CA3 pattern completion, temporal links=temporal context model, allocation=DG neurogenesis; the clearest engineered instantiation of HC computation in ML; what DNC lacks (structural W generalization) is exactly what TEM provides.
- **[[wiki/papers/dnc-graves-2016.md]]** — source: three-mechanism HC mapping (content lookup/temporal links/allocation); Mini-SHRDLU prospective planning (89% first-action decode at goal-write time); graph traversal necessity of external memory (LSTM: 37%, DNC: 98.8%).
