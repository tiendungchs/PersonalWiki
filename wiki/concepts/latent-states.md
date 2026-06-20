---
title: "Latent States"
type: concept
tags: [latent-states, aliasing, sequence-learning, abstract-reasoning, hippocampus]
created: 2026-06-12
updated: 2026-06-19
sources: [cognitivemap, PFC_as_a_meta_RL_system]
related: [wiki/concepts/structural-generalization.md, wiki/concepts/path-integration.md, wiki/concepts/factorized-representations.md, wiki/concepts/predictive-coding.md, wiki/concepts/meta-learning.md, wiki/entities/cscg-model.md, wiki/entities/tem-model.md, wiki/entities/place-cells.md, wiki/entities/prefrontal-cortex.md, wiki/papers/pfc-meta-rl-wang-2018.md, wiki/papers/whittington-cognitive-map-2022.md]
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
| Tower accumulation | Cue evidence difference | **Evidence cells**: 2D fields in (position × evidence) space |
| Two-room task | Global spatial context | Grid code separates after animal learns rooms are connected |

TEM reproduces all four cell types without being designed to — they fall out of the objective of predicting futures accurately and fast across structured environments.

**Crucially:** TEM simultaneously learns spatial (place) cells and non-spatial (latent) cells because *both* are needed for full generalization — spatial structure generalizes across spatial tasks; task structure generalizes across task instances.

---

## How the Brain Builds Latent States

**CSCG** ([[wiki/entities/cscg-model.md]]): hippocampus maintains multiple clone cells per sensory observation; Bayesian EM infers which clone is active given the sequence; learned transitions define the de-aliased state space. Fast and local, but no cross-environment generalization.

**TEM** ([[wiki/entities/tem-model.md]]): path-integrating `g` module naturally assigns distinct structural codes to states with different sensory futures; hippocampal `p` = conjunction of `g` and `x`. Generalizes across environments via shared slow weights W.

**PFC meta-RL** ([[wiki/concepts/meta-learning.md]], [[wiki/papers/pfc-meta-rl-wang-2018.md]]): LSTM hidden state clusters by task latent state (which cue is rewarded, which arm is better) before any observation in a trial (Fig. 4c). This is within-episode latent-state inference via recurrent dynamics — complementary to HC's cross-episode latent-state representations. PFC tracks *task* latent states; HC tracks *spatial/structural* latent states.

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
- **[[wiki/concepts/predictive-coding.md]]** — latent causes z in the Free Energy Principle are exactly latent states: unobservable variables inferred from observation sequences; the FEP recognition model `q(z|o_{1:t})` is the abstract description of what TEM's inference path and CSCG's clone-cell mechanism both implement.
- **[[wiki/concepts/meta-learning.md]]** — PFC meta-RL's LSTM hidden state is the within-episode latent-state tracker; DA-trained recurrent dynamics maintain and update task latent states (which cue rewarded, what the transition structure is) purely in activation space.
- **[[wiki/papers/pfc-meta-rl-wang-2018.md]]** — Fig. 4c: LSTM activation space clusters by task latent state prior to any trial observation, demonstrating that PFC recurrent dynamics represent latent states as an emergent property of meta-RL training.
- **[[wiki/entities/prefrontal-cortex.md]]** — PFC is the biological substrate for within-episode latent-state tracking; dlPFC WM interference resistance and the LSTM hidden state are both mechanisms for maintaining latent-state estimates across a delay; ACC unsigned PE drives updates when the latent state must change.
- **[[wiki/papers/whittington-cognitive-map-2022.md]]** — primary source for the latent-states account of all non-spatial HC cells (splitter, lap, evidence cells); latent-states.md distills the core unification argument from this paper.
