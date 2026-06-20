---
title: "Path Integration"
type: concept
tags: [path-integration, navigation, recurrent-networks, compression, graph-traversal]
created: 2026-06-09
updated: 2026-06-13
sources: [t-TEM, reservoir-computing-transcript, landmark-orientation]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/successor-representation.md, wiki/concepts/attention.md, wiki/entities/grid-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/htm-thousand-brains.md, wiki/entities/reservoir-computing.md, wiki/entities/insect-central-complex.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/150000-mini-brain-transcript.md, wiki/papers/reservoir-computing-transcript.md, wiki/papers/seelig-jayaraman-2015.md]
---

# Path Integration

**Update an internal position estimate by integrating a sequence of actions or transitions — without requiring external landmarks at each step.**

In TEM, path integration is how the structural code `g` is maintained and updated as the agent traverses a graph. Generalized from physical space to arbitrary relational domains.

---

## From Space to Graphs

Physical space: accumulate self-motion vectors (head direction + speed) → track position. Grid cells are the neural substrate — their regular periodic fields update continuously with movement.

Abstract domains: replace movement vectors with relation labels. `Parent + Sibling + Niece = 0` is the abstract analog of `N + E + S + W = 0`. The same mechanism works: path integrate over relation types rather than movement directions.

TEM's update rule: `g_{t+1} = f(W g_t + B a_t)`, where a_t is the action/relation and W is shared across all environments.

---

## Path Integration as Compression

Without path integration, every edge must be stored explicitly — O(E) memory, and new nodes require new edges.

With path integration, only the *rules of traversal* are needed — O(relation types). New nodes are handled automatically because the same rules apply everywhere. For graphs that admit consistent action labels (same relation has the same structural effect at every node), this provides a combinatorially compressed, generalizable representation. Not all graphs qualify — social networks with generic relationships cannot be path-integrated.

---

## Biological Substrate

**CANNs (Continuous Attractor Neural Networks):** recurrently connected neurons whose activity bump shifts with velocity input. Supported by ring attractors in fly brain, toroidal manifolds in rodent grid cells. Limitation: weights must be hand-tuned, not learned.

**VCOs (Velocity-Coupled Oscillators):** path integration via interference between theta oscillations and velocity-dependent dendritic oscillations. Grid cells = sum of three VCOs at 60° angles.

**Learned RNNs:** when trained to predict spatial coordinates or place cells, RNNs and LSTMs spontaneously develop grid-like representations — the geometry emerges from the path integration objective, not supervision.

**Unification:** CANN, VCO, and SR eigenvector addition are the same mathematical structure — same eigenvectors (grid codes), differing only in how eigenvalues update per action ([[wiki/concepts/successor-representation.md]]).

---

## CX Path Integration: Direct In-Vivo Confirmation

Seelig & Jayaraman 2015 [[wiki/papers/seelig-jayaraman-2015.md]] provide the best-characterized biological path integrator in any animal — the *Drosophila* central complex [[wiki/entities/insect-central-complex.md]]:

- **P-EN neurons** receive angular velocity signals from the noduli (optic flow + speed) and asymmetrically drive the E-PG activity bump to shift proportional to rotation — directly implementing `g_{t+1} = g_t + ω Δt` for heading angle.
- **Error accumulation:** in complete darkness, bump tracking of walking rotation degrades progressively over time — the expected signature of integrating noisy velocity without corrective feedback.
- **Landmark correction:** ring neuron visual input anchors the bump to scene structure, resetting accumulated drift — the prediction-correction cycle realized at circuit level.
- **Self-contained substrate:** unlike the mammalian head direction system (which requires anterodorsal thalamus, presubiculum, retrosplenial cortex, and MEC), the CX path integrator is largely self-contained, providing a minimal circuit for direct study and ML implementation.

This is the most direct experimental confirmation of path integration by identified, connected neurons in any behaving animal.

---

## As Learned Positional Encodings

TEM-t [[wiki/papers/t-tem-whittington-2022.md]] reveals that `g_{t+1} = σ(g_t W_a)` is formally a recurrently generated positional encoding in a transformer. Standard transformers use fixed sinusoidal encodings — they assume Euclidean sequence order and cannot represent non-linear relational structure.

Path integration generalizes this: `W_a` encodes the relational structure of the domain (N/S/E/W topology for space; parent/child/sibling for kinship; grammar rules for language). Position is then *inferred on-the-fly* from the sequence of relations, not read off a fixed index.

**Implication:** a reasoning model for abstract domains needs path-integrating positional encodings that capture domain-specific transition structure, not sinusoidal order encodings.

---

## Universal Cortical Primitive (TBT)

Thousand Brains Theory [[wiki/entities/htm-thousand-brains.md]] proposes that L6 neurons perform grid-like path integration in *every* cortical column, not just MEC. The update signal is the efference copy from the column's L5 motor outputs — the column feeds its own predicted actions back into the path integrator, tracking position in its reference frame without a dedicated MEC input.

**Implication for hierarchy:** as L5 outputs of lower columns feed into L4 of higher columns, higher columns path-integrate over increasingly abstract reference frames (sensory features → objects → phonemes → words → concepts). Path integration over abstract domains is not an extension of the spatial mechanism; it is the same mechanism at different hierarchy levels. TEM's `g_{t+1} = f(W g_t + B a_t)` running at every level of a cortical hierarchy is TBT's account of abstract reasoning.

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — path integration provides path-consistency (ingredient 3 of structural generalization) and compression: shared action-transition rules W are learned, not per-edge transitions.
- **[[wiki/concepts/factorized-representations.md]]** — path integration operates exclusively on the structural code `g`; it is the update rule for the MEC/W subsystem and does not affect sensory code x.
- **[[wiki/concepts/successor-representation.md]]** — mathematically unified: SR eigenvectors are grid codes (the same plane-wave basis used by CANNs/VCOs); SR propagation and path integration are the same computation viewed from RL theory vs. navigation theory.
- **[[wiki/entities/grid-cells.md]]** — grid cells are the biological substrate for path integration; their periodic structure is the solution to the path-consistency constraint and emerges in TEM purely from this objective.
- **[[wiki/concepts/attention.md]]** — path integration is the recurrent positional encoding generator in the transformer view; `g_{t+1} = σ(g_t W_a)` is exactly `e_{t+1} = σ(e_t W_a)` in TEM-t's position encoder.
- **[[wiki/papers/t-tem-whittington-2022.md]]** — establishes path integration = learned recurrent positional encoding; provides the implication for non-spatial domains.
- **[[wiki/entities/htm-thousand-brains.md]]** — proposes L6 grid-like path integration via efference copy (L5→L6) as universal across all cortical columns; hierarchical columns then path-integrate over abstract reference frames using identical machinery, making abstract reasoning a direct extension of the spatial mechanism.
- **[[wiki/papers/150000-mini-brain-transcript.md]]** — source for the TBT account of columnar path integration and hierarchical abstraction via abstract reference frames.
- **[[wiki/entities/reservoir-computing.md]]** — reservoir dynamics maintain a fading echo trace of past inputs, analogous to path integration's temporal trace of past traversals; the key contrast: reservoir traces are random projections with no structured transition rules, while TEM's path integration integrates structured W transitions, enabling cross-environment compression that reservoirs cannot provide.
- **[[wiki/papers/reservoir-computing-transcript.md]]** — source for echo-state dynamics as fading temporal memory.
- **[[wiki/entities/insect-central-complex.md]]** — P-EN neurons implement path integration in the Drosophila CX; bump-shift mechanism via asymmetric velocity drive is the best-characterized biological path integrator in any identified circuit.
- **[[wiki/papers/seelig-jayaraman-2015.md]]** — primary source for direct in vivo confirmation of drift accumulation and landmark-correction cycle in CX path integration.
- **[[wiki/concepts/latent-graph-discovery.md]]** — path integration solves the path-consistency requirement of latent graph discovery: the structural code g must commute (reach the same meta-graph position via any traversal path), which path integration enforces by accumulating edge transitions rather than memorizing node addresses.
