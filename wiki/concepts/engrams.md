---
title: "Engrams"
type: concept
tags: [engrams, memory, sparse-coding, excitability, memory-linkage, hippocampus, CREB, memory-allocation]
created: 2026-06-12
updated: 2026-06-21
sources: [engram-transcript, memory-gate-transcript, sparse_representations, lisman-memory-allocation-2018]
related: [wiki/concepts/two-learning-timescales.md, wiki/concepts/replay.md, wiki/concepts/structural-generalization.md, wiki/concepts/associative-memory.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/hebbian-learning.md, wiki/concepts/spike-frequency-adaptation.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/papers/engram-transcript.md, wiki/papers/memory-gate-transcript.md, wiki/papers/hopfield-networks-crouse-2022.md, wiki/papers/podlaski-context-modular-memory-2025.md, wiki/papers/ahmad-hawkins-sdr-2016.md, wiki/papers/lisman-memory-allocation-2018.md]
---

# Engrams

**A sparse ensemble of neurons whose synaptic weights are modified by a learning experience — the physical substrate of a memory. Activation of engram neurons is both necessary and sufficient for recall.**

---

## Sparsity and Allocation

| Brain region | Engram fraction |
|-------------|----------------|
| Dentate gyrus (HC) | 2–6% |
| Lateral amygdala | 10–20% |

Sparsity is **homeostically conserved** — it does not increase with stimulus intensity or change with memory valence. Mechanism: **excitability competition**. At any moment, neurons vary in intrinsic excitability (proximity to firing threshold). During a learning event, the most excitable cells suppress their neighbors via inhibitory interneurons (lateral inhibition) and win allocation to the engram. Blocking interneurons expands engram size; artificially elevating excitability pre-training predictably recruits those cells.

**Molecular basis — CREB:** The transcription factor CREB (cAMP-responsive element-binding protein) is the specific molecular driver that elevates intrinsic excitability. CREB phosphorylation reduces K⁺ conductance → smaller after-hyperpolarization (AHP) → more action potentials per current pulse. Crucially, CREB is activated by two convergent pathways that together act as a **coincidence detector for engram eligibility**: (1) somatic action potentials → voltage-gated Ca²⁺ → CaMKIV → CREB; (2) dendritic LTP → CaMKII → ERK diffusion to soma → CREB. Both gates must fire for strong CREB activation, ensuring only cells with simultaneous dendritic plasticity and somatic spiking are tagged. This excitability increase is **non-homeostatic** — more activity during learning → more excitability, not less — and is transient (~5–24h), making it a temporary allocation tag rather than the long-term memory store itself.

**Why sparse?** Sparse distributed codes maximize storage capacity and minimize interference between memories. The homeostatic constraint is computationally necessary, not coincidental. Ahmad & Hawkins 2016 [[wiki/papers/ahmad-hawkins-sdr-2016.md]] formally derives the scaling law: for $n > 2000$ and $a/n < 5\%$, false positive probability drops faster than exponentially — the 2–6% DG and ~10–20% amygdala sparsity fractions sit squarely in the regime where dendritic recognition achieves $P(\text{FP}) < 10^{-27}$ with just 30 synapses per segment. Relaxing sparsity raises error superexponentially, making homeostatic enforcement computationally mandatory [[wiki/concepts/sparse-distributed-representations.md]].

**Optimal neuronal gating (Podlaski et al. 2025):** The context-modular Hopfield model formally derives the *optimal active fraction* for a network storing $s$ contextually organized memory groups: $a_\text{opt} \approx (\sqrt{2s-1} - 1)/(s-1)$. For $s=10$–$100$ contexts this yields $a \approx 0.2$–$0.3$ — exactly the 20–30% engram fractions observed in amygdala and HC. This provides a capacity-theoretic proof that the sparse engram fraction is not merely a wiring constraint but the *computationally optimal allocation ratio for the number of contextually organized memories*. Silencing allocated neurons decreases memory expression; artificially elevating pre-training excitability biases allocation — both predictions that follow from the neuronal gating model.

---

## Memory Linkage via Overlap

Two mechanisms link engrams by creating overlapping neuron populations:

1. **Temporal co-encoding — allocate-to-link hypothesis:** CREB-mediated excitability increase persists ~5–24h post-encoding. If a second memory forms within this window, the same CREB-elevated cells preferentially win allocation again → shared engram neurons → behavioral linking. Ca²⁺ imaging of CA1 confirms greater ensemble overlap for contexts explored 5h apart vs. 7d apart. The shared ensemble is **necessary for associative transfer but not for individual recall**: silencing it blocks fear transfer from one context to another while leaving memory for each context intact (Yokose et al. 2017). This is the mechanism behind the "temporal contiguity → associative memory" observation — it is cellular and molecular, not merely statistical.
2. **Co-retrieval:** repeatedly reactivating two non-overlapping engrams simultaneously causes them to merge a shared neuron pool. This shared pool encodes the *link between memories*, not their content — silencing it blocks associative recall while leaving individual memories intact. This is the physical mechanism for building abstract concepts from episodic experience.

---

## SWR-Driven Engram Selection for Replay

Sharp wave ripples apply the same E/I competition mechanism to *replay selection* that excitability competition applies to *encoding allocation*:

- **At encoding:** most excitable cells win allocation via lateral inhibition → engram formed
- **At replay (SWR):** CA3→CA1 excitatory wave primes all engram cells; inhibitory interneurons force competition → strongest engram wins and gets replayed

Awake SWRs (during pauses after rewards) select the winning engram and trigger local HC plasticity that tags those patterns for sleep re-expression. Sleep SWRs then repeatedly replay the bookmarked engram and transfer it to cortex [[wiki/concepts/replay.md]]. The same biological primitive — winner-take-most E/I competition — thus governs both memory allocation and memory selection.

**Assembly consolidation hypothesis:** CREB-elevated excitability in engram cells may create a second selection pressure: higher excitability → lower threshold for the CA3→CA1 wave to recruit those cells into SWRs → more replay events → stronger selective consolidation for recently-potentiated cells. If correct, CREB serves a dual function: allocating cells at encoding *and* biasing their survival through the awake→sleep consolidation bottleneck. Not yet directly tested; built on (a) confirmed CREB excitability effects and (b) SWR disruption → memory deficits.

---

## Brain-Wide Engram Complex

A single fear memory (2022 Nature Communications) distributes across hippocampus, amygdala, thalamus, hypothalamus, and brainstem — each region encoding a different aspect:

| Region | Encoded aspect |
|--------|---------------|
| Hippocampus | Spatial context |
| Amygdala | Emotional valence |
| Cortex | Sensory experience |
| Thalamus/hypothalamus/brainstem | (partially characterized) |

Memory is not localized — it is a distributed puzzle, with HC as the index binding the pieces ([[wiki/entities/hippocampal-entorhinal-system.md]]).

---

## Connections to TEM Architecture

| Engram biology | TEM / computational analog |
|----------------|---------------------------|
| Engram neurons | Cells written to fast M (Hebbian) |
| Excitability competition (CREB-mediated) → sparse firing | Softmax in TEM-t; sparse p codes |
| CREB ~5–24h excitability tag | No analog in current TEM — would require an eligibility trace on engram cells across write events |
| 6h temporal linkage window | M interference between close-in-time environments |
| Co-retrieval engram merging | Offline GVC binding during replay |
| Brain-wide complex | HC indexing of distributed cortical representations |

---

## Connections

- **[[wiki/concepts/two-learning-timescales.md]]** — engrams are the cellular instantiation of fast M: excitability competition is the biological mechanism that produces the sparsity TEM's Hebbian update assumes, and the 6h linkage window is a temporal interference property absent from TEM's idealized formulation.
- **[[wiki/concepts/replay.md]]** — co-retrieval (repeated offline co-activation of two engrams) is the engram-level mechanism of the same process as GVC binding during replay: forming new compositional representations by co-activating existing memory traces offline.
- **[[wiki/concepts/structural-generalization.md]]** — engram overlap via co-retrieval is the physical substrate for abstract concept formation: as many episodic memories share overlapping engram neurons, those shared cells encode the abstract structure common to all episodes.
- **[[wiki/entities/place-cells.md]]** — hippocampal engram cells are place cells; the DG 2–6% sparsity is the same constraint as sparse place cell coding, and the causal necessity/sufficiency of engram activation matches TEM's account of p-cell retrieval driving prediction.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — the brain-wide engram complex instantiates hippocampal indexing theory: HC holds the binding index for distributed cortical/subcortical engram components, explaining why hippocampal damage disrupts memory without erasing individual cortical traces.
- **[[wiki/papers/memory-gate-transcript.md]]** — SWR-driven replay selection uses the same E/I competition as engram allocation; awake SWRs tag winning engrams for priority sleep consolidation via local HC plasticity.
- **[[wiki/concepts/associative-memory.md]]** — CA3 recurrent Schaffer collaterals + LTP implement biological associative memory; engram pattern completion (partial cue → full episode) is Hopfield fixed-point convergence; spurious attractors map to engram interference when engram density exceeds ~0.14N, linking formal capacity limits to the 6h temporal linkage window.
- **[[wiki/papers/podlaski-context-modular-memory-2025.md]]** — context-modular Hopfield derivation shows that excitability competition producing 20–30% active engram fractions is the optimal neuronal gating ratio for $s=10$–$100$ contextually distinct memory groups; provides a capacity-theoretic proof that sparse engram allocation is computationally optimal, not merely a resource constraint.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — SDR scaling laws give the per-segment mathematical ground for why engram sparsity is homeostically conserved: the scaling laws show that relaxing sparsity raises false positive rates superexponentially, making the 2–6% DG fraction not merely adaptive but computationally mandatory.
- **[[wiki/papers/ahmad-hawkins-sdr-2016.md]]** — derives the false positive hypergeometric formula applied to sparse neuronal populations; the DG engram sparsity sits in the regime ($n > 2000$, $a/n < 5\%$) where the laws guarantee near-zero dendritic recognition error.
- **[[wiki/concepts/hebbian-learning.md]]** — Hebb's cell assembly theory is the conceptual precursor to the engram: repeated co-firing of neurons establishes auto-associated assemblies that reconstitute from partial cues; excitability competition is the mechanism that determines which neurons participate in the Hebbian write and enforces the sparsity that keeps assemblies distinct.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — CREB-mediated AHP reduction (K⁺ conductance decrease) is mechanistically opposed to SFA-mediated AHP buildup (K⁺ channel activation): SFA suppresses chronically active neurons via a rising threshold; CREB tags plasticity-eligible neurons by lowering their threshold — both act at the same K⁺ channel family in opposite directions, setting each neuron's effective excitability in a learning context.
- **[[wiki/papers/lisman-memory-allocation-2018.md]]** — primary source for CREB as the molecular mechanism of excitability-based engram allocation, the dual-pathway coincidence detection (somatic CaMKIV + dendritic ERK), the allocate-to-link hypothesis (Ca²⁺ imaging confirmation of ensemble overlap at 5h vs. 7d), and the assembly consolidation hypothesis (SWR participation bias).
