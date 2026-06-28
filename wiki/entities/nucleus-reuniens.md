---
title: "Nucleus Reuniens (RE)"
type: entity
tags: [thalamus, nucleus-reuniens, hippocampus, prefrontal-cortex, working-memory, relay, goal-directed, motivation]
created: 2026-06-27
updated: 2026-06-27
sources: [Prefrontal-Hippocampal Interactions in Memory and Emotion]
related: [wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/prefrontal-cortex.md, wiki/concepts/working-memory.md, wiki/concepts/prospective-coding.md, wiki/concepts/memory-schemas.md, wiki/papers/jin-maren-hpc-pfc-emotion-2015.md]
---

# Nucleus Reuniens (RE)

Midline thalamic nucleus that provides the primary indirect relay between mPFC and HC, converting the direct HC→mPFC channel into a fully bidirectional loop.

---

## Anatomy

| Connection | Direction | Notes |
|---|---|---|
| mPFC → RE | Afferent | Dense projection from prelimbic/infralimbic cortices |
| RE → HPC | Efferent | Dense projection to dorsal and ventral HC |
| RE → mPFC | Efferent (reverse) | Collateral projection — same RE neurons project to both targets |
| HPC → RE | Afferent | HPC also sends input back, completing the loop |

**Key anatomical fact:** single RE neurons send collateral axons to both HC *and* mPFC simultaneously. RE is therefore not a sequential relay (mPFC→RE→HC) but a **fan-out hub**: one signal in, simultaneous modulation of both downstream targets.

---

## Functional Properties

| Function | Evidence | Key reference |
|---|---|---|
| Spatial WM coordination | RE lesions impair radial arm maze and DNMTP tasks dependent on both HC and mPFC | Porter et al. 2000; Hembrook et al. 2012 |
| Future path representation | mPFC→RE→sHPC pathway required for representing future trajectory during goal-directed navigation | Ito et al. 2015 |
| Bilateral plasticity modulation | RE stimulation produces strong excitatory effects on *both* HC and PFC neurons; modulates LTP/LTD in both | Di Prisco & Vertes 2006 |
| Long-range cortical coordination | RE neurons are glutamatergic; proposed as key relay for coordinating distant cortical regions during navigation | Griffin 2015 |

- **RE is computationally active**, not a passive wire: RE stimulation modulates synaptic plasticity in both HC and mPFC, meaning RE participates in the computation rather than merely transmitting signals.
- **DNMTP task** (delayed non-match to position) — a standard HC-mPFC spatial WM paradigm — is disrupted by RE inactivation, confirming that indirect mPFC→RE→HC loop is required even when the direct HC→mPFC pathway is intact.

---

## Mapping to Model Components

| RE property | Design implication |
|---|---|
| Single neurons fan out to both HC and mPFC | A relay module between the HC-like fast-M store and the PFC-like controller should broadcast its signal to both simultaneously, not sequentially |
| RE stimulation modulates plasticity in both targets | The relay is a *gain controller*, not just a router — it can up- or down-regulate learning in either target |
| mPFC→RE→sHPC for future path representation | Prospective planning requires the PFC controller to reach into the HC memory system via this relay; direct HC→PFC channel is insufficient for goal-directed forward planning |
| RE inactivation impairs WM | The relay is causally necessary for WM — it cannot be abstracted away as an epiphenomenal anatomical detour |

---

## Connection to Motivation

The mPFC→RE→sHPC pathway supports **goal-directed future path representation** (Ito et al. 2015) — the brain encodes which path to take *before* executing it. This is prospective planning driven by motivational context: the mPFC (which holds goal representations) sends the goal signal via RE to HC, causing HC to preactivate future trajectory representations aligned with that goal. RE is the anatomical substrate through which the PFC's motivational/goal signal reaches the HC planning engine.

This links to the NAcc (nucleus accumbens) convergence architecture: HC (context) + amygdala (emotional valence) + PFC (goal/rule) all converge on NAcc for motivationally-driven action selection. RE is the complementary top-down channel: PFC → RE → HC, biasing HC toward goal-relevant forward simulation.

---

## Connections

- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — RE is the indirect relay for the mPFC→HC direction; single RE neurons fan out to both HC and mPFC, making RE the circuit element that converts unidirectional HC→mPFC into a closed bidirectional loop; RE modulates HC plasticity
- **[[wiki/entities/prefrontal-cortex.md]]** — mPFC is the primary driver of RE; mPFC goal representations reach HC via the mPFC→RE→HC pathway, enabling goal-directed prospective planning that would be impossible via the direct HC→mPFC-only channel
- **[[wiki/concepts/working-memory.md]]** — RE lesions disrupt spatial WM tasks requiring both HC and mPFC; indirect mPFC→RE→HC loop is a causally necessary WM coordination mechanism complementing the direct vHPC→mPFC gamma channel (Sigurdsson 2016)
- **[[wiki/concepts/prospective-coding.md]]** — mPFC→RE→sHPC pathway is the top-down control channel for goal-directed HC preplay; PFC goal signal reaches HC via RE to bias which future trajectory HC preactivates
- **[[wiki/concepts/memory-schemas.md]]** — RE relay enables mPFC schema selection to propagate back into HC, biasing which specific memory within the selected schema is retrieved; the mPFC→RE→dorsal HC route is the return arm of the ventral HC→mPFC→RE→dorsal HC schema-gating loop
- **[[wiki/papers/jin-maren-hpc-pfc-emotion-2015.md]]** — primary source for RE anatomy, functional evidence, and design implications
