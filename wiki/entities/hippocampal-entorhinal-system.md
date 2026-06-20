---
title: "Hippocampal-Entorhinal System"
type: entity
tags: [hippocampus, entorhinal-cortex, MEC, LEC, memory, navigation, relational-inference]
created: 2026-06-09
updated: 2026-06-20 (2)
sources: [gridlikecode, t-TEM, engram-transcript, convergence-wiring-transcript, jumping-spiders-cognition, convergent-brain-structures-spatial-memory, Metalearning_and_Neuromodulation, Structure and function of the hippocampal CA3 module, The mechanisms for pattern completion and pattern separation in the hippocampus, Complementary Learning Systems, Learning Fast and Slow Single- and Many-Shot Learning in the Hippocampus, Pattern separation in the hippocampus.md]
related: [wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/path-integration.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/latent-states.md, wiki/concepts/attention.md, wiki/concepts/engrams.md, wiki/concepts/small-world-networks.md, wiki/concepts/binding-problem.md, wiki/concepts/convergent-allocentric-coding.md, wiki/concepts/neuromodulation.md, wiki/concepts/associative-memory.md, wiki/concepts/pattern-separation.md, wiki/concepts/replay.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/tem-model.md, wiki/entities/cscg-model.md, wiki/entities/htm-thousand-brains.md, wiki/entities/insect-central-complex.md, wiki/entities/arthropod-mushroom-bodies.md, wiki/entities/cephalopod-vertical-lobe.md, wiki/papers/gridlikecode-constantinescu-2016.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/engram-transcript.md, wiki/papers/150000-mini-brain-transcript.md, wiki/papers/convergence-wiring-transcript.md, wiki/papers/jumping-spiders-cognition.md, wiki/papers/metalearning-neuromodulation-doya-2002.md, wiki/papers/ca3-sammons-2023.md, wiki/papers/pattern-completion-rolls-2013.md, wiki/papers/cls-oreilly-2011.md, wiki/papers/learning-fast-slow-liao-2024.md]
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
