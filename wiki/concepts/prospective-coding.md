---
title: "Prospective Coding"
type: concept
tags: [prospective-code, hippocampus, inference, look-ahead, sequence-memory, preplay, relational-inference]
created: 2026-06-23
updated: 2026-06-28
sources: [neuronal-computation-inferential-reasoning]
related: [wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/place-cells.md, wiki/concepts/replay.md, wiki/concepts/sequence-memory.md, wiki/concepts/latent-states.md, wiki/concepts/associative-memory.md, wiki/concepts/temporal-context.md, wiki/papers/inferential-reasoning-dupret-2020.md, wiki/papers/hassabis-neuroscience-ai-2017.md, wiki/entities/default-mode-network.md, wiki/papers/gusnard-2001-mpfc-default-mode.md, wiki/papers/spatial-learning-pfc-martinet-2011.md, wiki/entities/prefrontal-cortex.md, wiki/entities/spacetime-attractor.md, wiki/concepts/planning-as-inference.md, wiki/papers/mechanistic-planning-pfc-jensen-2026.md, wiki/papers/tcm-mtl-howard-2005.md]
---

# Prospective Coding

**CA1 represents the expected next element in a learned sequence when cued with the current element — a look-ahead mechanism that operates over both spatial trajectories and mnemonic associations.**

---

## Two Manifestations

| Domain | Trigger | Predicted content | Method |
|--------|---------|-------------------|--------|
| **Spatial** | Animal pauses at a choice point | Place cell sequences for candidate future paths | SWR (Sharp Wave Ripple) decoding; UMAP manifold projection |
| **Cognitive / inferential** | Cue X presented (no Y visible) | CA1 activity resembles Y (the cue learned to follow X) | RSA across fMRI voxels (humans) and CA1 ensembles (mice) |

Both are instances of the same operation: given the current representational state, CA1 outputs a prediction of the next state without the next state being sensorially present.

---

## Operationalization (Dupret et al. 2020)

In the sensory preconditioning paradigm (X→Y learned; Y→Z conditioned; X tested alone):

$$\text{RSM}_{within}(X_n, Y_n) > \text{RSM}_{cross}(X_n, Y_m), \quad m \neq n$$

where RSM is the Pearson correlation of population vectors. Significance confirmed by:
1. One-sided Wilcoxon signed-rank test across recording days
2. Permutation test (10,000 shuffles of auditory cue identity)

Additionally, when X_n is presented, X-tuned neurons fire **before** Y-tuned neurons — preserving the original X→Y temporal order. This is the non-spatial analog of spatial phase precession: a compressed temporal sequence encoding the learned association rather than the spatial trajectory.

---

## Evidence / Instantiations

| Study | Species | Domain | Key finding |
|-------|---------|--------|------------|
| Dupret et al. 2020 | Mice (CA1 ensemble) + Humans (7T fMRI) | Sensory preconditioning (X→Y→Z) | RSA: CA1 represents Y when X shown; temporal order X→Y preserved; dCA1 optogenetic silencing blocks inference |
| Hassabis et al. 2017 review | Multiple | Spatial navigation | HC SWR (Sharp Wave Ripple) at choice points activates sequential place cell representations of candidate future paths (preplay) |
| Nieh et al. 2021 | Mice (CA1) | Evidence accumulation | CA1 jointly encodes current position and future-relevant latent variable (evidence) in a 5.4D manifold |
| Martinet et al. 2011 | Simulated rat + real PFC recordings | Goal-directed navigation (Tolman maze) | PFC σ-type neurons show left-skewed asymmetric tuning curves; ranked pre-execution firing predicts serial order of planned trajectories; anticipatory discharge ~75 ms ahead of visited column; validated against medial PFC pyramidal cell recordings |

---

## What HC Does NOT Predict

A critical asymmetry from Dupret et al. 2020: the hippocampus generates the look-ahead step **X→Y** but does **not** represent the inferred outcome **Z** during inference. Z is represented in mPFC and dopaminergic midbrain. This implies prospective coding in HC is a one-step predictor, not a full chain simulator — the chain completion (Y→Z) must happen downstream.

This is analogous to the DNC (Differentiable Neural Computer) / preplay architecture: HC produces the sequence or prediction; a controller (PFC/mPFC) evaluates and translates it into a goal representation.

---

## PFC Prospective Coding: Multi-Step Trajectory Representation

Martinet et al. 2011 ([[wiki/papers/spatial-learning-pfc-martinet-2011.md]]) identify a functionally distinct prospective code in PFC that differs from the one-step HC look-ahead:

| Feature | HC (CA1) | PFC (σ-type neurons) |
|---------|----------|---------------------|
| Trigger | Cue X → predict Y | Goal-directed trajectory planning phase |
| Steps ahead | 1 (X→Y only) | Full planned trajectory (N steps) |
| Tuning curve shape | Symmetric | Asymmetric (left-skewed; negative skew increases linearly with path distance from start) |
| Temporal anticipation | ~one sequence item | ~75 ms ahead of the actually visited column |
| Sequence order content | Encodes expected next item | Ranked pre-execution firing predicts serial order of entire planned path |
| Source in model | CA3 pattern completion → CA1 | φ-projection forward propagation through topological column network |

**Sequence order coding:** before the animal executes a planned trajectory, the ranked discharge frequencies of σ neurons predict the serial order of the states to be visited. This pre-execution ordering is maintained not just at time 0 (start of trajectory) but at every time t — the ranking continuously predicts the remaining order of future states. Validated against Averbeck et al. (2006) monkey PFC recordings of sequential drawing tasks.

**Design implication:** HC prospective coding and PFC prospective coding are hierarchically related. HC generates a one-step look-ahead from the current state; PFC maintains the full planned trajectory representation and uses it to propagate the motor-command sequence forward. A reasoning model needs both: a one-step HC-like predictor for online inference, and a PFC-like trajectory representation for multi-step planning.

---

## STA: Simultaneous Full-Trajectory Prospective Code

Jensen et al. 2026 [[wiki/papers/mechanistic-planning-pfc-jensen-2026.md]] provide the mechanistic model for PFC multi-step prospective coding. The Spacetime Attractor (STA) extends the Martinet σ-neuron account into a full circuit theory:

| Feature | HC CA1 (Dupret 2020) | PFC σ-neurons (Martinet 2011) | STA (Jensen 2026) |
|---|---|---|---|
| Steps represented | 1 (X→Y) | Full trajectory (ranked) | T simultaneous subspaces |
| Mechanism | CA3 pattern completion | Spreading activation | Attractor dynamics |
| Goal-dependence | Not modeled | Distance-to-goal firing rate | Reward input per subspace |
| Updating during execution | N/A | Recalculated | Conveyor belt (subspace shift) |

"Conveyor belt dynamics" (validated in El-Gaby et al. 2023 PFC recordings): as each action is taken, the δ=k representation shifts to δ=k−1, so the δ=1 subspace always encodes the immediate next step without replanning. This is the mechanistic bridge between prospective coding (hold a representation of the future) and planning (infer the optimal future).

---

## Relationship to SWR (Sharp Wave Ripple) Shortcuts

Prospective coding (online, during X presentation) and SWR (Sharp Wave Ripple) shortcuts (offline, during rest) are complementary mechanisms for the same inference problem:

| Mechanism | When | Compute mode | What gets built |
|-----------|------|--------------|-----------------|
| Prospective code | At inference time, triggered by X | Online look-ahead | Temporary X→Y prediction (each trial) |
| SWR (Sharp Wave Ripple) shortcut | During awake rest / sleep | Offline caching | Persistent X→Z link in co-activation statistics |

With extended experience, SWR (Sharp Wave Ripple) shortcuts may reduce reliance on online prospective code — the brain caches the inference result rather than recomputing it each trial.

---

## Retrospective Counterpart: TCM's Leaky Integrator

Prospective coding has a mirror image — **retrospective coding**, where an EC "place" cell's firing depends on the *history* of movements leading to the current location. The Temporal Context Model (Howard et al. 2005 [[wiki/papers/tcm-mtl-howard-2005.md]]) derives both from a single leaky integrator `t_i = ρ_i t_{i-1} + β t_iᴵᴺ` fed velocity input:

- **Retrospective / trajectory coding falls out for free** — the drifting context carries a decaying trace of prior head directions, so two visits to the same spot with different approach paths (W-maze steps 6 vs. 12) evoke different codes. Robust in the model.
- **Prospective coding is fragile in a purely retrospective model** — TCM's cells only "predict" the upcoming turn because head direction begins changing just before the choice point; genuine future-content prediction requires HC→EC feedback the drift equation lacks. This localizes prospective coding to *deep* EC (hippocampal-recipient) layers, exactly where Frank et al. 2000 observed it.

**Design reading:** retrospection is cheap (any leaky recurrent state gives it); prospection is expensive (needs a learned forward model). A reasoning model gets a trajectory/episode index almost for free but must add explicit look-ahead machinery for planning.

---

## Open Problems

- **Multi-hop depth** — does prospective coding extend beyond one step (X→Y) to two steps (X→Y→Z directly in HC)? Current evidence says no; HC stops at Y. Whether longer chains are possible with different task designs is unknown.
- **Generation mechanism** — is the prospective code generated by CA3 pattern completion triggering CA1 via Schaffer collaterals, or by a direct EC (Entorhinal Cortex) recall signal? The optogenetic result shows CA1 is necessary, but the upstream source of the Y representation is not isolated.
- **Online vs. cached inference** — as SWR (Sharp Wave Ripple) shortcuts accumulate, does the brain shift from prospective coding (X→Y each trial) to direct X→Z retrieval? If so, this would predict reduced CA1 prospective RSA signal in well-trained animals — testable but not yet measured.

---

## Connections

- **[[wiki/concepts/temporal-context.md]]** — TCM's leaky-integrator context is the retrospective counterpart to prospective coding: it derives trajectory/retrospective EC coding analytically and shows prospective coding is fragile without HC→EC feedback, explaining why prospection concentrates in deep (hippocampal-recipient) EC layers.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — prospective coding is a core CA1 function; the inference version (X→Y in cognitive space) generalizes the spatial preplay already documented at choice points; both require CA1 causal activity.
- **[[wiki/entities/place-cells.md]]** — spatial preplay is the original instance of prospective coding; place cell sequential activation at choice points and the X→Y sequential firing during inference are the same computational operation in different domains.
- **[[wiki/concepts/replay.md]]** — SWR (Sharp Wave Ripple) shortcuts (offline) are the cached complement to the online prospective code; both serve inference, but one is computed on-the-fly while the other is pre-built during rest.
- **[[wiki/concepts/sequence-memory.md]]** — prospective coding requires memory for the temporal order of X→Y; asymmetric Hopfield / STDP-learned edge weights provide the forward direction that drives look-ahead.
- **[[wiki/concepts/latent-states.md]]** — the expected next cue Y functions as a latent state: it is not sensorially present but is inferred from context; prospective coding is the mechanism by which that latent state is instantiated in CA1 activity.
- **[[wiki/concepts/associative-memory.md]]** — prospective coding is content-addressable lookup in a directed (asymmetric) associative store: X → retrieve Y; the asymmetry (X triggers Y but not vice versa during inference) reflects the temporal order encoded by STDP.
- **[[wiki/papers/inferential-reasoning-dupret-2020.md]]** — primary source for the cognitive / non-spatial version of prospective coding; provides both the RSA operationalization and the optogenetic causal proof.
- **[[wiki/papers/hassabis-neuroscience-ai-2017.md]]** — source for the spatial version (HC preplay at choice points); motivates the unified account of prospective coding across spatial and non-spatial domains.
- **[[wiki/entities/default-mode-network.md]]** — the dMPFC default-state simulation (narrative/autobiographical self; continuous behavioral rehearsal) is the temporal self-model within which HC prospective codes are interpreted and grounded; dMPFC provides the "who/when/where" context that translates a bare X→Y look-ahead into a personally relevant goal prediction.
- **[[wiki/papers/gusnard-2001-mpfc-default-mode.md]]** — establishes dMPFC (BA 8/9/10) as the seat of ongoing behavioral simulation at rest; the spontaneous inner rehearsal maintained by dMPFC is the macro-timescale complement to HC's online one-step prospective code — two levels of the same planning hierarchy.
- **[[wiki/papers/spatial-learning-pfc-martinet-2011.md]]** — source for PFC prospective coding (σ-type neurons): asymmetric left-skewed tuning curves, sequence order coding, ~75 ms anticipatory discharge, trajectory representation extending HC one-step look-ahead to the full planned path.
- **[[wiki/entities/prefrontal-cortex.md]]** — PFC hosts both the topological planning mechanism (spreading activation) and the prospective-code output (σ-type neurons) that reads out the planned trajectory in temporal order; HC prospective coding and PFC prospective coding are hierarchically related, not equivalent.
- **[[wiki/entities/spacetime-attractor.md]]** — STA is the mechanistic circuit model for PFC's full-trajectory prospective code: T simultaneous subspaces replace the ranked σ-neuron array; conveyor belt dynamics execute the plan; attractor inference replaces spreading activation.
- **[[wiki/concepts/planning-as-inference.md]]** — planning as inference is the algorithmic framing of what prospective coding achieves at the multi-step level: the simultaneous T-step representation is the fixed point of the STA's attractor dynamics, not a sequential computation.
- **[[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]]** — prospective coding is the mechanism that makes each candidate reasoning sequence simulable: the one-step CA1 look-ahead (→ PFC/STA multi-step trajectory) is the generator whose sampled chains the Strategist rolls forward and scores against the goal in the reasoning refinement loop.
