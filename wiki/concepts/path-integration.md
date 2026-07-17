---
title: "Path Integration"
type: concept
tags: [path-integration, navigation, recurrent-networks, compression, graph-traversal]
created: 2026-06-09
updated: 2026-07-16
sources: [t-TEM, reservoir-computing-transcript, landmark-orientation, Vector Symbolic Algebras for the Abstraction and Reasoning Corpus.md]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/successor-representation.md, wiki/concepts/temporal-context.md, wiki/concepts/attention.md, wiki/entities/grid-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/htm-thousand-brains.md, wiki/entities/reservoir-computing.md, wiki/entities/insect-central-complex.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/150000-mini-brain-transcript.md, wiki/papers/reservoir-computing-transcript.md, wiki/papers/seelig-jayaraman-2015.md, wiki/concepts/ring-attractor.md, wiki/papers/acann-li-chu-wu-2024.md, wiki/entities/vsa-model.md, wiki/papers/joffe-vsa-arc-2025.md, wiki/papers/tcm-mtl-howard-2005.md, wiki/queries/operator-collapse-in-fused-structural-codes.md]
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

## Leaky vs. Perfect Integration: The ρ Knob

Path integration is usually framed as *exact* accumulation. The Temporal Context Model (Howard et al. 2005 [[wiki/papers/tcm-mtl-howard-2005.md]]) shows the biologically important regime is the **leaky** one. Write the integrator as `p_i = ρ p_{i-1} + v_i`:

| ρ | Representation | Behavior |
|---|---|---|
| 0 | Pure head direction (`p_i = v_i`) | No memory of past movements |
| 1 | Perfect path integrator | Exact metric position; cannot distinguish episodes at the same place |
| **0 < ρ < 1** | **Trajectory code** (weighted sum over recent movements) | History-dependent — *retrospective/trajectory coding* |

Only intermediate ρ reproduces the entorhinal place code's history-dependence (Frank et al. 2000 W-maze): two visits to the same location with different approach histories evoke different codes. A *leaky* integrator is therefore functionally superior to a perfect one for episodic disambiguation — it doubles as a place code and an episode index. TEM later replaces the scalar ρ with a learned, action-conditioned transition operator `W`, upgrading the leaky trace into a factorized structural code.

---

## Biological Substrate

**CANNs (Continuous Attractor Neural Networks):** recurrently connected neurons whose activity bump shifts with velocity input. Supported by ring attractors in fly brain, toroidal manifolds in rodent grid cells. Limitation: weights must be hand-tuned, not learned.

**VCOs (Velocity-Coupled Oscillators):** path integration via interference between theta oscillations and velocity-dependent dendritic oscillations. Grid cells = sum of three VCOs at 60° angles.

**Learned RNNs:** when trained to predict spatial coordinates or place cells, RNNs and LSTMs spontaneously develop grid-like representations — the geometry emerges from the path integration objective, not supervision.

**Unification:** CANN, VCO, and SR (Successor Representation) eigenvector addition are the same mathematical structure — same eigenvectors (grid codes), differing only in how eigenvalues update per action ([[wiki/concepts/successor-representation.md]]).

---

## CX (Central Complex) Path Integration: Direct In-Vivo Confirmation

Seelig & Jayaraman 2015 [[wiki/papers/seelig-jayaraman-2015.md]] provide the best-characterized biological path integrator in any animal — the *Drosophila* central complex [[wiki/entities/insect-central-complex.md]]:

- **P-EN neurons** receive angular velocity signals from the noduli (optic flow + speed) and asymmetrically drive the E-PG activity bump to shift proportional to rotation — directly implementing `g_{t+1} = g_t + ω Δt` for heading angle.
- **Error accumulation:** in complete darkness, bump tracking of walking rotation degrades progressively over time — the expected signature of integrating noisy velocity without corrective feedback.
- **Landmark correction:** ring neuron visual input anchors the bump to scene structure, resetting accumulated drift — the prediction-correction cycle realized at circuit level.
- **Self-contained substrate:** unlike the mammalian head direction system (which requires anterodorsal thalamus, presubiculum, retrosplenial cortex, and MEC), the CX (Central Complex) path integrator is largely self-contained, providing a minimal circuit for direct study and ML implementation.

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

## SSPs as Distributed Path Integration

Spatial Semantic Pointers (SSPs, Eliasmith lab) implement path integration in a fixed-width distributed representation via fractional binding:

$$\phi(\mathbf{x}) = \mathcal{F}^{-1}\left\{e^{i\Theta \mathbf{x}/l}\right\}$$

**The key path-integration property:** binding = addition in feature space.

$$\phi(\mathbf{x}) \circledast \phi(\mathbf{d}) = \phi(\mathbf{x} + \mathbf{d})$$

Each integration step (displacement $\mathbf{d}$) = one circular convolution. Inversion = negation: $\phi(\mathbf{x})^{-1} = \phi(-\mathbf{x})$ enables reverse traversal. The accumulated vector is the position estimate — no separate integrator module.

Specific choices of phase matrix $\Theta$ produce hexagonal grid-cell-like periodicity — an emergent property of the fractional binding structure, not a separately imposed constraint. SSPs are directly composable with HRR (Holographic Reduced Representations) slot-filler binding ([[wiki/entities/vsa-model.md]]), and unlike CANN/VCO implementations, $\Theta$ can be learned end-to-end.

---

## Connections

- **[[wiki/concepts/temporal-context.md]]** — TCM's contextual-drift equation is leaky path integration with a single scalar decay ρ; feeding velocity as input reproduces the entorhinal place code, and intermediate ρ yields the trajectory/retrospective coding a perfect integrator cannot — the minimal precursor to TEM's learned W.
- **[[wiki/concepts/structural-generalization.md]]** — path integration provides path-consistency (ingredient 3 of structural generalization) and compression: shared action-transition rules W are learned, not per-edge transitions.
- **[[wiki/concepts/factorized-representations.md]]** — path integration operates exclusively on the structural code `g`; it is the update rule for the MEC/W subsystem and does not affect sensory code x.
- **[[wiki/concepts/successor-representation.md]]** — mathematically unified: SR (Successor Representation) eigenvectors are grid codes (the same plane-wave basis used by CANNs/VCOs); SR (Successor Representation) propagation and path integration are the same computation viewed from RL theory vs. navigation theory.
- **[[wiki/entities/grid-cells.md]]** — grid cells are the biological substrate for path integration; their periodic structure is the solution to the path-consistency constraint and emerges in TEM purely from this objective.
- **[[wiki/concepts/attention.md]]** — path integration is the recurrent positional encoding generator in the transformer view; `g_{t+1} = σ(g_t W_a)` is exactly `e_{t+1} = σ(e_t W_a)` in TEM-t's position encoder.
- **[[wiki/papers/t-tem-whittington-2022.md]]** — establishes path integration = learned recurrent positional encoding; provides the implication for non-spatial domains.
- **[[wiki/entities/htm-thousand-brains.md]]** — proposes L6 grid-like path integration via efference copy (L5→L6) as universal across all cortical columns; hierarchical columns then path-integrate over abstract reference frames using identical machinery, making abstract reasoning a direct extension of the spatial mechanism.
- **[[wiki/papers/150000-mini-brain-transcript.md]]** — source for the TBT (Thousand Brains Theory) account of columnar path integration and hierarchical abstraction via abstract reference frames.
- **[[wiki/entities/reservoir-computing.md]]** — reservoir dynamics maintain a fading echo trace of past inputs, analogous to path integration's temporal trace of past traversals; the key contrast: reservoir traces are random projections with no structured transition rules, while TEM's path integration integrates structured W transitions, enabling cross-environment compression that reservoirs cannot provide.
- **[[wiki/papers/reservoir-computing-transcript.md]]** — source for echo-state dynamics as fading temporal memory.
- **[[wiki/entities/insect-central-complex.md]]** — P-EN neurons implement path integration in the Drosophila CX; bump-shift mechanism via asymmetric velocity drive is the best-characterized biological path integrator in any identified circuit.
- **[[wiki/papers/seelig-jayaraman-2015.md]]** — primary source for direct in vivo confirmation of drift accumulation and landmark-correction cycle in CX (Central Complex) path integration.
- **[[wiki/concepts/latent-graph-discovery.md]]** — path integration solves the path-consistency requirement of latent graph discovery: the structural code g must commute (reach the same meta-graph position via any traversal path), which path integration enforces by accumulating edge transitions rather than memorizing node addresses.
- **[[wiki/concepts/ring-attractor.md]]** — ring attractor is the biological implementation substrate for CANN-based path integration; the bump-shift mechanism (P-EN asymmetric velocity drive) implements g_{t+1} = f(g_t, a_t) on a circular manifold; A-CANN extends the static-bump path integrator to traveling-wave and anticipative modes via SFA (Spike Frequency Adaptation) adaptation.
- **[[wiki/papers/acann-li-chu-wu-2024.md]]** — provides the first full analytical phase diagram for CANN path integration: traveling-wave mode (bump precedes true position by constant t_ant), anticipative tracking, and oscillatory theta modes emerge from a single network; adaptation strength m and input strength α are the two control parameters that determine which path-integration regime operates.
- **[[wiki/entities/vsa-model.md]]** — SSPs implement distributed path integration via fractional binding: φ(x) ⊛ φ(d) = φ(x+d) makes each step a circular convolution; specific phase matrices produce hexagonal grid-cell-like periodicity linking SSP encoding to the MEC substrate; unlike CANN/VCO, Θ is differentiable and can be learned end-to-end.
- **[[wiki/papers/joffe-vsa-arc-2025.md]]** — applies SSPs to ARC-AGI spatial reasoning: object centre representations encoded as SSPs so spatial similarity queries reduce to dot-product similarity, demonstrating the differentiable path integration property in a practical neuro-symbolic solver.
- **[[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]]** — recasts reasoning as path integration over an *operator* graph whose edges and destination are latent; path integration is the Navigator half of the coupled loop, supplying `g` and the reverse/generative forward model that simulates candidate reasoning steps.
- **[[wiki/queries/operator-collapse-in-fused-structural-codes.md]]** — a path integrator cannot be debugged apart from the code it integrates: fed a common-mode-dominated, ~5-dimensional code, the learned operator shrinks to a 0.11 rad rotation (cos-to-identity 0.98) while keeping *correct* direction structure (opposite pairs at cos −1.000). The near-identity operator is a faithful readout of encoder geometry, not an operator failure — and the brain avoids it by making the collapse unrepresentable (torus phases, velocity-only drive) rather than by penalizing it.
