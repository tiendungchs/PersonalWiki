---
title: "Latent States"
type: concept
tags: [latent-states, aliasing, sequence-learning, abstract-reasoning, hippocampus]
created: 2026-06-12
updated: 2026-06-23
sources: [cognitivemap, PFC_as_a_meta_RL_system, courellis-hpc-abstract-inference-2024, nieh-hippocampal-geometry-2021, sun-hippocampal-osm-2025]
related: [wiki/concepts/structural-generalization.md, wiki/concepts/path-integration.md, wiki/concepts/factorized-representations.md, wiki/concepts/predictive-coding.md, wiki/concepts/meta-learning.md, wiki/entities/cscg-model.md, wiki/entities/tem-model.md, wiki/entities/place-cells.md, wiki/entities/prefrontal-cortex.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/whittington-cognitive-map-2022.md, wiki/concepts/representational-geometry.md, wiki/papers/geometry-abstraction-bernardi-2020.md, wiki/papers/courellis-hpc-abstract-inference-2024.md, wiki/papers/nieh-hippocampal-geometry-2021.md, wiki/concepts/neural-manifolds.md, wiki/papers/friston-kiebel-pc-2009.md, wiki/papers/sun-hippocampal-osm-2025.md]
---

# Latent States

**States that cannot be determined from the current observation alone; must be inferred from the history of observations and actions.**

The sensory world is **aliased**: the same observation occurs in multiple states with different futures. A complete cognitive map must represent the hidden dimensions that disambiguate these states.

---

## The Aliasing Problem and Its Solution

A maze trunk looks identical whether the animal is on a left-turn trial or a right-turn trial — but the correct action differs. Individual observations are insufficient. **Sequences** solve this: two states with the same current observation will have different past/future neighbors, so sequential context uniquely identifies the latent state.

---

## Neural Evidence — All One Principle

Apparently diverse hippocampal cell types are unified: *all* are latent state representations, tracking whichever task-relevant hidden variable disambiguates futures.

| Task | Latent variable | Cell type |
|------|----------------|-----------|
| T-maze alternation | Current trial direction (L/R) | **Splitter cells**: same physical location, fires differently per upcoming turn |
| 4-lap reward task | Lap number | **Lap-specific cells**: same location, different lap |
| Tower accumulation | Cue evidence difference | **Evidence cells**: 2D firing fields in joint (position × evidence) space; ~29% of CA1 neurons, ~1.7 fields/cell; population manifold ~5.4D (Nieh et al. 2021) |
| Two-room task | Global spatial context | Grid code separates after animal learns rooms are connected |
| 2ACDC linear tracks | Current trial type (near/far reward) | **State cells**: place-like → splitter continuum; full orthogonalization over days of training (Sun et al. 2025) |

TEM reproduces all four cell types without being designed to — they fall out of the objective of predicting futures accurately and fast across structured environments.

**Crucially:** TEM simultaneously learns spatial (place) cells and non-spatial (latent) cells because *both* are needed for full generalization — spatial structure generalizes across spatial tasks; task structure generalizes across task instances.

---

## How the Brain Builds Latent States

**CSCG** ([[wiki/entities/cscg-model.md]]): hippocampus maintains multiple clone cells per sensory observation; Bayesian EM (Expectation Maximization) infers which clone is active given the sequence; learned transitions define the de-aliased state space. Fast and local, but no cross-environment generalization.

**TEM** ([[wiki/entities/tem-model.md]]): path-integrating `g` module naturally assigns distinct structural codes to states with different sensory futures; hippocampal `p` = conjunction of `g` and `x`. Generalizes across environments via shared slow weights W.

**PFC meta-RL** ([[wiki/concepts/meta-learning.md]], [[wiki/papers/pfc-meta-rl-wang-2018.md]]): LSTM hidden state clusters by task latent state (which cue is rewarded, which arm is better) before any observation in a trial (Fig. 4c). This is within-episode latent-state inference via recurrent dynamics — complementary to HC's cross-episode latent-state representations. PFC (Prefrontal Cortex) tracks *task* latent states; HC tracks *spatial/structural* latent states.

**Hierarchical PC (Predictive Coding) attractor models** ([[wiki/papers/friston-kiebel-pc-2009.md]]): the higher-level attractor's state space encodes latent categories; Bayesian deconvolution of the full sensory trajectory (in generalized coordinates) maps to a point in this space — achieving perceptual categorization as latent-state inference. Three distinct song categories resolve to non-overlapping 90% CI regions in the higher attractor's state space after ~600 ms. The category is not a label added by a separate classifier; it is the location in the higher-level state space that the PC (Predictive Coding) inference converges to. This is the FEP-derived mechanistic account of how temporal sensory sequences map to abstract latent categories without a separate recognition module.

---

## OSM: How Latent States Are Learned In Vivo (Sun et al. 2025)

Sun et al. 2025 ([[wiki/papers/sun-hippocampal-osm-2025.md]]) provide the first detailed account of how latent state representations emerge in CA1 *during learning*, not merely how they look in experts.

**The OSM (Orthogonalized State Machine):** the learned representation resembles a finite state machine whose nodes are latent task states rather than sensory features. Identical visual inputs map to different nodes when the animal is in different positions in the hidden task structure (e.g., "about to reach near reward on near trial" vs. "about to pass near reward on far trial").

**Learning trajectory:**
1. **Early:** neural representations primarily track sensory features; similar grey regions activate similar populations; indicator cue creates partial separation.
2. **Middle:** within-track decorrelation first — the four grey regions of a single track begin to separate; the animal learns the sequential structure.
3. **Late:** across-track decorrelation — corresponding locations on the two tracks orthogonalize in a specific order: pre-R2 before pre-R1. The beginning and end of the track (after reward, before next cue) remain correlated throughout — consistent with no latent state information being available there.

**CSCG as the algorithm:** only CSCG (Baum-Welch EM (Expectation Maximization) over discrete clone states) replicates this trajectory, not gradient descent models. The Bayesian EM (Expectation Maximization) objective — which maximizes the probability of the observed sensory sequence under a hidden state model — drives the correct decorrelation order; pure prediction accuracy does not.

**Two-timescale structure within HC:** once the OSM is built (slow), new sensory-to-state mappings are acquired rapidly (fast). New indicator cues are learned in 147 vs. 483 trials because the state structure is preserved — only the indicator mapping updates.

**State cells are not a type; they are a state:** individual CA1 neurons transition dynamically between place-like and splitter-like profiles across days. The population orthogonalization is driven by neurons progressively acquiring state-specific responses — not by dedicated cell types appearing de novo.

---

## Context as Abstract Latent Variable: The CCGP (Cross-Condition Generalization Performance) Criterion

Bernardi et al. 2020 ([[wiki/papers/geometry-abstraction-bernardi-2020.md]]) operationalize latent-state representation as a geometry problem: context is in **abstract format** when a linear decoder trained on a subset of task conditions generalizes to held-out conditions (CCGP >> chance), i.e., the coding direction for context is parallel across condition groupings.

Key findings for latent-state architecture:
- **HPC** represents context in abstract format before *and after* the decision epoch — the persistent abstract latent-state store.
- **DLPFC** loses context abstraction during the decision (context non-linearly mixed with stimulus identity for action computation), recovering it before the next trial.
- **Behavior correlation:** CCGP (Cross-Condition Generalization Performance) for context drops on error trials; traditional decoding accuracy does not — the latent state must be in abstract format, not just decodable, to support flexible behavior.

This adds a precision that CSCG/TEM/PFC-meta-RL accounts lack: they specify *what* latent states are; CCGP (Cross-Condition Generalization Performance) specifies the *geometric criterion* the representation must satisfy to generalize to novel contexts.

**Human replication (Courellis et al. 2024; [[wiki/papers/courellis-hpc-abstract-inference-2024.md]]).** Human single-unit recordings in 6 areas (HC, amygdala, vmPFC, dACC, pre-SMA, VTC; 17 epilepsy patients; reversal learning) confirm HC-exclusive multi-variable abstraction: only HC simultaneously achieves high CCGP (Cross-Condition Generalization Performance) for both latent context and stimulus identity. Amygdala and prefrontal regions can abstract individual variables but never both together. Key addition: verbal instruction (5 minutes) produces geometrically identical HC representations to trial-and-error learning — the abstract format is a property of the representation, not the learning pathway. Context CCGP (Cross-Condition Generalization Performance) (not raw decoding accuracy) tracks trial-by-trial inference success, confirming abstract format as the behavioral prerequisite.

---

## Manifold as the Geometric Substrate

Nieh et al. 2021 ([[wiki/papers/nieh-hippocampal-geometry-2021.md]]) provides the first direct evidence that the expanded cognitive map has a concrete geometric substrate in CA1 population dynamics:

- **~5.4D neural manifold:** nonlinear (MIND algorithm), embedded in ~450D state space; PCA requires 40 PCs to match 5 latent dimensions; dimensionality tracks task complexity (simpler control task: ~4.2D).
- **Joint encoding as manifold tiling:** individual CA1 neurons (~29%) have localized 2D firing fields in E×Y space, tiling the manifold surface with gradients for both position (physical) and evidence (abstract).
- **Sensory vs. neural manifold dissociation:** applying MIND to the raw visual input yields a luminance gradient but no evidence gradient; the neural manifold adds the evidence axis that sensation cannot provide — the manifold encodes learned knowledge.
- **Task-specific, not animal-specific geometry:** ~70% of manifold structure is shared across animals after SO(5) hyperalignment rotation — HC converges on a canonical geometric representation of the task, not idiosyncratic activation patterns.

This operationalizes the expanded cognitive map as a measurable object: HC manifold dimensionality ≈ number of task-relevant variables that must be jointly tracked. The CCGP (Cross-Condition Generalization Performance) abstraction criterion ([[wiki/concepts/representational-geometry.md]]) and the manifold gradient criterion are complementary: CCGP (Cross-Condition Generalization Performance) tests parallelism for discrete conditions; the gradient test checks continuous-variable ordering on the manifold.

---

## Implication for Reasoning Models

Any system claiming to handle abstract tasks must maintain **running hidden state** across an episode — not just process the current frame. The latent state is the task-relevant context accumulated from the sequence so far. Feedforward single-frame architectures (CNNs, single-step transformers) cannot do this.

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — aliased observations expose incomplete structural representations; latent states *complete* the graph by adding hidden task dimensions, making full generalization possible.
- **[[wiki/concepts/path-integration.md]]** — path integration over extended sequences is what produces distinct `g` codes for aliased states; the history of transitions, not just the current observation, defines the latent state.
- **[[wiki/concepts/factorized-representations.md]]** — latent states are additional dimensions of the structural code `g`, not a separate mechanism; the graph is simply expanded to include non-spatial axes.
- **[[wiki/entities/cscg-model.md]]** — CSCG's clone cells are the HC-local implementation of latent states: each clone corresponds to one disambiguated copy of an aliased observation.
- **[[wiki/entities/tem-model.md]]** — TEM develops latent state codes without supervision when the graph topology includes non-spatial task dimensions; the same path-integration objective generates both spatial and non-spatial representations.
- **[[wiki/concepts/predictive-coding.md]]** — latent causes z in the Free Energy Principle are exactly latent states: unobservable variables inferred from observation sequences; the FEP (Free Energy Principle) recognition model `q(z|o_{1:t})` is the abstract description of what TEM's inference path and CSCG's clone-cell mechanism both implement.
- **[[wiki/concepts/meta-learning.md]]** — PFC (Prefrontal Cortex) meta-RL's LSTM hidden state is the within-episode latent-state tracker; DA-trained recurrent dynamics maintain and update task latent states (which cue rewarded, what the transition structure is) purely in activation space.
- **[[wiki/papers/pfc-meta-rl-wang-2018.md]]** — Fig. 4c: LSTM activation space clusters by task latent state prior to any trial observation, demonstrating that PFC (Prefrontal Cortex) recurrent dynamics represent latent states as an emergent property of meta-RL training.
- **[[wiki/entities/prefrontal-cortex.md]]** — PFC (Prefrontal Cortex) is the biological substrate for within-episode latent-state tracking; dlPFC WM interference resistance and the LSTM hidden state are both mechanisms for maintaining latent-state estimates across a delay; ACC (Anterior Cingulate Cortex) unsigned PE drives updates when the latent state must change.
- **[[wiki/papers/whittington-cognitive-map-2022.md]]** — primary source for the latent-states account of all non-spatial HC cells (splitter, lap, evidence cells); latent-states.md distills the core unification argument from this paper.
- **[[wiki/concepts/representational-geometry.md]]** — CCGP (Cross-Condition Generalization Performance) provides the geometric criterion that distinguishes an abstract latent state (coding direction parallel across conditions) from a merely decodable one; HPC satisfies this for context persistently; DLPFC temporarily loses it during action computation.
- **[[wiki/papers/geometry-abstraction-bernardi-2020.md]]** — empirical source for the CCGP (Cross-Condition Generalization Performance)/context finding; serial reversal-learning task; HPC vs. DLPFC temporal dynamics; correlation with behavioral accuracy on error trials.
- **[[wiki/papers/courellis-hpc-abstract-inference-2024.md]]** — human single-unit replication; adds amygdala, vmPFC, dACC, pre-SMA, and VTC as negative controls; establishes HC-exclusive multi-variable abstraction; verbal instruction equivalence confirms abstract format is channel-independent.
- **[[wiki/papers/nieh-hippocampal-geometry-2021.md]]** — primary source for the manifold substrate of evidence cells: ~5.4D nonlinear manifold, ~29% joint-encoding CA1 neurons, and ~70% cross-animal geometry sharing confirm that the expanded cognitive map is a real measurable geometric object.
- **[[wiki/concepts/neural-manifolds.md]]** — the task-plastic HC manifold (type 2) is the geometric substrate within which latent-state firing fields are organized; MIND quantifies its dimensionality and structure.
- **[[wiki/papers/friston-kiebel-pc-2009.md]]** — higher-level PC (Predictive Coding) attractor state = latent category; Bayesian deconvolution of the full sensory trajectory maps to a point in the higher attractor's state space — the FEP-derived mechanistic account of how temporal sequences map to abstract latent categories without a separate recognition module.
- **[[wiki/papers/sun-hippocampal-osm-2025.md]]** — first longitudinal account of latent state formation in CA1 during learning; introduces the OSM concept; demonstrates that Bayesian EM (Expectation Maximization) (CSCG) uniquely matches both the final orthogonalized representations and the specific decorrelation trajectory, making it the strongest algorithmic constraint on how latent states are learned in the hippocampus.
- **[[wiki/concepts/prospective-coding.md]]** — the expected next cue Y that CA1 represents during inference (X→Y) is a latent state: not sensorially present but inferred from context; prospective coding is the online read-out mechanism by which a latent state is instantiated in CA1 activity given a cue.
