---
title: "Vector-HaSH (Vector Hippocampal Scaffolded Heteroassociative Memory)"
type: entity
tags: [associative-memory, episodic-memory, hippocampus, grid-cells, factorized-representations, capacity, continual-learning]
created: 2026-06-22
updated: 2026-06-22
sources: [High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations]
related: [wiki/concepts/associative-memory.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/continual-learning.md, wiki/entities/grid-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/place-cells.md, wiki/papers/vector-hash-chandra-2023.md, wiki/papers/podlaski-context-modular-memory-2025.md, wiki/papers/hopfield-networks-crouse-2022.md]
---

# Vector-HaSH

**Neocortical-entorhinal-hippocampal circuit model that achieves exponential-capacity content-addressable memory and high-capacity sequential episodic memory by factorizing the generation of error-correcting fixed points from content storage.**

Chandra, Sharma, Chaudhuri & Fiete, bioRxiv 2023.

---

## Architecture

| Component | Biology | Weights | Function |
|---|---|---|---|
| **Grid scaffold** | MEC grid modules (M modules, each K_i states on 2D torus) | Fixed (invariant across tasks) | Generates exponential fixed-point library |
| **Grid→HC projection** | MEC→HC | Random, fixed | Maps each grid state to a sparse HC pattern (hash) |
| **HC→Grid projection** | HC→MEC | Learned once (early development), then fixed | Closes the scaffold loop; supports error correction |
| **Heteroassociative layer** | HC↔neocortex | Bidirectional plastic | Attaches sensory content to scaffold fixed points |
| **Shift operator** | HC→MEC velocity signal | Trained | Implements grid-phase transitions for sequence memory |

**Scaffold capacity:** M modules × coprime K_i states → ∏_i K_i ≈ ⟨K⟩^M distinct stable fixed points. Required HC neurons: O(M) — logarithmic in capacity.

---

## Key Results

| Property | Vector-HaSH | Hopfield (standard) | Hopfield (modern) |
|---|---|---|---|
| Capacity (items) | ⟨K⟩^M (exponential in modules) | ~0.14N | O(exp d) but exponential neurons needed for circuit impl. |
| Memory cliff | None — graceful tradeoff | Hard cliff at ~0.14N | Cliff at linear threshold |
| Sequence memory | Efficient (shift on M-dim grid space) | O(N) max steps | Not addressed |
| Catastrophic forgetting | Absent (scaffold space exponentially large) | Present | Present |
| Biological plausibility | High (uses known grid-HC anatomy) | Low | Low |

**Strong generalization:** scaffold needs only O(MK_max) training examples (traversal of a metric region of grid space) to support access to all ⟨K⟩^M fixed points. Random fixed patterns require exponentially many examples for the same result — the ordered torus topology is the essential ingredient.

---

## Three Memory Types

| Memory type | Mechanism | Biological analog |
|---|---|---|
| **Item memory** | Partial cortical cue → HC pattern completion → scaffold fixed point → full cortical reconstruction | Cue-driven episodic recall |
| **Spatial memory** | Self-motion updates grid phase via sensorimotor velocity input → HC encodes current location | Place cell navigation |
| **Sequence (episodic) memory** | HC state drives shift operator on grid scaffold → next scaffold state → next content heteroassociated | Episodic narrative recall |

**Memory palace:** previously learned spatial scaffold (location-landmark heteroassociations) is reused for non-spatial content; spatially-triggered HC states cue arbitrary new cortical items associated to those states. First circuit model of method-of-loci mnemonics.

---

## Limitations

- HC modeled as a uniform population; CA1/CA3/DG subregional roles not distinguished
- Scaffold formation (developmental establishment of fixed grid-HC connections) not modeled
- No theta oscillations, spiking, or neuromodulatory gating
- New relational structure (new graph topology beyond existing scaffold phases) requires scaffold extension — not modeled

---

## Comparison to Related Models

| Model | Mechanism | Scaffold | Sequence memory | Generalization |
|---|---|---|---|---|
| Hopfield | Synaptic energy minimization | No (content in weights) | No | No |
| Context-Modular Hopfield (Podlaski 2025) | Neuronal/synaptic gating | No | No | Contextual |
| TEM (Whittington 2020) | g/x/p factorization + Hebbian M | Yes (grid g) | Via path integration | Cross-environment |
| **Vector-HaSH** | Scaffold/content factorization | Yes (grid scaffold) | Via shift operator | Cross-domain scaffold reuse |

**Relationship to TEM:** TEM's W/g (structural) and M/p (episodic binding) factorization is the same architectural principle, with TEM additionally specifying inference (g estimation from x sequences) and Vector-HaSH additionally specifying the fixed-point generation mechanism. They are complementary formulations of the same biological circuit.

---

## Connections

- **[[wiki/concepts/associative-memory.md]]** — Vector-HaSH is the principled solution to the Hopfield memory cliff: factorizing attractor dynamics from content storage eliminates interference between scaffold fixed points and new content.
- **[[wiki/concepts/factorized-representations.md]]** — extends the TEM g/x factorization to episodic memory; the scaffold/content split is a second orthogonal factorization axis — scaffold (fixed) vs. content (plastic).
- **[[wiki/entities/grid-cells.md]]** — grid modules are the physical scaffold; their torus topology, invariance across tasks, and coprime-scale exponential combinatorics are the properties that give Vector-HaSH its capacity.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — provides the circuit anatomy (MEC scaffold + HC heteroassociative + neocortex content layers) that Vector-HaSH instantiates as a computational model.
- **[[wiki/concepts/continual-learning.md]]** — exponential scaffold space is the formal mechanism: new memories claim unused scaffold states rather than overwriting old attractor basins, giving catastrophic-forgetting avoidance without explicit importance-weighting.
- **[[wiki/concepts/two-learning-timescales.md]]** — heteroassociation (plastic HC-cortex weights) is the fast-M operation; the scaffold (fixed grid-HC weights) is a developmental intermediate-timescale structure that precedes and enables fast-M writes.
- **[[wiki/papers/vector-hash-chandra-2023.md]]** — primary source.
- **[[wiki/papers/podlaski-context-modular-memory-2025.md]]** — complementary approach to exceeding the Hopfield cliff via contextual neuronal/synaptic gating; both achieve high capacity through a secondary structure (gating mask vs. scaffold) rather than synaptic weight changes alone.
- **[[wiki/papers/hopfield-networks-crouse-2022.md]]** — baseline for the memory cliff problem Vector-HaSH solves; the classical 0.14N capacity bound and cliff shape are the target to beat.
