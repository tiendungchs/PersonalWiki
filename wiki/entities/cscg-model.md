---
title: "CSCG (Clone-Structured Cognitive Graph)"
type: entity
tags: [model, hippocampus, latent-states, bayesian, aliasing, sequence-learning]
created: 2026-06-12
updated: 2026-06-12
sources: [cognitivemap]
related: [wiki/concepts/latent-states.md, wiki/entities/tem-model.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/place-cells.md, wiki/papers/whittington-cognitive-map-2022.md]
---

# CSCG — Clone-Structured Cognitive Graph

**Paper:** George et al., *Nature Communications* 2021.

Addresses the aliasing problem by giving hippocampus multiple **clone cells** per sensory observation — different clones represent the same observation at different locations. Bayesian EM infers which clone is active given the observation sequence; learned transitions define a de-aliased latent state space.

---

## Key Properties

- **Local, biologically plausible learning:** EM learning rules are local; maps can be acquired rapidly
- **De novo learning:** no prior structural knowledge assumed or used — learns each environment from scratch
- **Planning by inference:** conditions a probabilistic model on start and goal clones → infers action sequences (planning without tree search)
- **Latent state cells emerge naturally:** splitter cells, trajectory-dependent cells = clone cells for aliased observations
- **Limitation:** because latent states are inferred within HC (no cortical abstraction), it cannot generalize structure to new environments. Each map is learned independently.

---

## Comparison to TEM

| | CSCG | TEM |
|--|------|-----|
| Latent state inference | HC-local (Bayesian EM) | Cortex (slow W) → HC |
| Generalization | None — de novo | Yes — shared W across environments |
| Speed | Fast | Slower (structure learning required) |
| Bio plausibility | High (local rules) | Lower (backprop) |

The models are **complementary**: CSCG excels at novel environments; TEM excels when prior structural knowledge can transfer. A unified CSCG+TEM model (proposed, not yet implemented) combines fast local map building with cross-environment structural generalization.

---

## Connections

- **[[wiki/concepts/latent-states.md]]** — CSCG's clone cells are the HC-local implementation of latent states; each clone is a disambiguated copy of an aliased observation, and Bayesian EM over sequences infers which clone (= which latent state) is active.
- **[[wiki/entities/tem-model.md]]** — directly complementary: TEM handles structural generalization across environments; CSCG handles fast de-aliasing within a novel environment; both use multiple HC cells per observation; a unified model remains open.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — CSCG models the HC map role (novel environments); TEM models the HC memory role (familiar structure); together they cover the full dual role of HC described at the system level.
- **[[wiki/papers/whittington-cognitive-map-2022.md]]** — proposes CSCG + TEM integration as complementary systems; CSCG's de-aliasing via clone cells and TEM's cross-environment W generalization are described as filling each other's gaps.
