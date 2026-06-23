---
title: "Representational Geometry"
type: concept
tags: [representational-geometry, abstraction, CCGP, shattering-dimensionality, mixed-selectivity, neural-population]
created: 2026-06-21
updated: 2026-06-22
sources: [geometry-of-abstraction-bernardi-2020]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/factorized-representations.md, wiki/concepts/latent-states.md, wiki/concepts/neural-manifolds.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/prefrontal-cortex.md, wiki/papers/geometry-abstraction-bernardi-2020.md, wiki/papers/raccah-pfc-consciousness-2021.md]
---

# Representational Geometry

**The geometric arrangement of neural population activity in firing-rate space — not just what information is encoded, but how — determines what generalizations to novel conditions are possible and what responses a linear readout can generate.**

---

## Core Metrics

| Metric | Definition | High value means |
|---|---|---|
| **CCGP** | Linear decoder accuracy on held-out conditions (cross-condition generalization performance) | Variable is **abstract**: generalizes to novel conditions |
| **Shattering Dimensionality (SD)** | Fraction of all balanced dichotomies linearly separable | High behavioral flexibility: many distinct linear responses available |
| **Parallelism Score (PS)** | Max avg cosine between coding directions across condition pairings | Coding directions parallel across conditions — prerequisite for high CCGP |

**Key relationship:** PS predicts CCGP. CCGP and SD are inversely related for purely disentangled representations — but *not* for the geometry observed biologically.

---

## Abstraction Operationalized

A variable is **abstract** (high CCGP) when its coding direction in firing-rate space is parallel across all groupings of conditions. The linear hyperplane that separates the variable in one subset of conditions transfers to a disjoint subset.

Two failure modes — decodable but not abstract:
1. **Random geometry** — each condition at a random location → SD maximal, CCGP at chance
2. **Rotating directions** — variable decodable within condition sets but coding axes rotate between them → high accuracy, low CCGP

---

## The CCGP/SD Duality

| Geometry | CCGP | SD | Biological? |
|---|---|---|---|
| Random | ~chance | ~maximal | Unlearned |
| Perfectly disentangled | High | Low (XOR unseparable) | No |
| **Observed: HPC/DLPFC/ACC** | **High (context, value, action)** | **Near-maximal** | **Yes** |

Pure disentanglement limits SD because XOR dichotomies are unseparable. A small distortion from perfect factorization recovers near-maximal SD without sacrificing high CCGP for the key variables.

**Design implication:** don't aim for maximum disentanglement; aim for the CCGP/SD balance. These are not mutually exclusive if the geometry is right.

---

## Mixed Selectivity as Substrate

HPC/DLPFC/ACC neurons predominantly show mixed selectivity. This is not a problem: a *rotated* factorized code (linear mixed selectivity) has identical CCGP to a pure-selective code. The distortion that recovers SD can be layered on top of any rotation. Population geometry — not individual tuning purity — determines abstraction. Single-neuron analysis misses this entirely.

**Behavioral correlate — iES elicitation gradient:** The near-zero elicitation rate of conscious effects following intracranial electrical stimulation (iES) of lateral PFC (Raccah et al. 2021, [[wiki/papers/raccah-pfc-consciousness-2021.md]]) is the expected consequence of dense, non-topographic PFC codes: disrupting a local iES patch does not perturb the population representation because it is distributed across a large circuit. Unimodal sensory regions (sparse, topographic codes) reach ~67% elicitation because patch disruption directly distorts the local feature representation. The PFC–sensory gradient in iES responsiveness is thus a *in vivo* validation of the representational geometry dissociation: local perturbation power decays as code density increases.

---

## Temporal Dynamics (HPC vs. PFC)

| Phase | HPC context CCGP | DLPFC context CCGP |
|---|---|---|
| Pre-stimulus | High | High |
| **Decision epoch** | **Maintained** | **Drops to chance** |
| Pre-next-stimulus | High | Recovers |

HPC holds the abstract context state persistently. DLPFC temporarily loses context abstraction when context is non-linearly combined with stimulus identity to compute the action — this is the computational cost of using an abstract variable for a concrete decision. CCGP for context correlates with behavioral accuracy; traditional decoding does not.

---

## Reasoning Model Implications

1. Latent/context variables should be encoded abstractly — parallel coding directions enable zero-shot transfer when the structure is familiar.
2. Preserve both CCGP and SD: over-disentangling limits the number of possible downstream responses.
3. Mixed selectivity is sufficient — population geometry is what matters.
4. Abstraction may dissolve temporarily during action computation — this is functional, not a failure.

---

## Open Problems

1. What training objective optimally produces the CCGP/SD balance? (Both backprop and DQN develop it spontaneously when the output requires abstract-variable classification.)
2. What determines which variables become abstract — behavioral relevance, temporal statistics, or the training objective?
3. Does the CCGP/SD duality scale to many simultaneously abstract variables?

---

## Connections

- **[[wiki/concepts/abstract-reasoning.md]]** — CCGP is the neural-population operational definition of abstraction, complementing Lake et al.'s computational/behavioral definition; a representation is abstract when it supports cross-condition generalization in the same sense that abstract reasoning supports novel-instance transfer.
- **[[wiki/concepts/factorized-representations.md]]** — disentanglement is a limiting case achieving high CCGP at the cost of low SD; the biology achieves the CCGP/SD balance via a distorted factorized geometry; the reasoning model design target is not maximum disentanglement but this balance.
- **[[wiki/concepts/latent-states.md]]** — context is the canonical abstract latent variable; CCGP operationalizes what "abstractly represented latent state" means at the population level vs. mere decodability.
- **[[wiki/concepts/neural-manifolds.md]]** — representational geometry adds a sixth manifold type: the configuration of coding-direction parallelism and SD in firing-rate space; high CCGP requires the manifold to have parallel structure for the abstract variable across condition subsets.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — HPC is the persistent abstract-state maintainer; it keeps context in abstract format through the decision epoch where PFC temporarily loses it; HPC provides the stable abstract context that PFC uses (destructively) for action computation.
- **[[wiki/entities/prefrontal-cortex.md]]** — DLPFC achieves high CCGP for context pre-stimulus but loses it during the decision epoch (non-linear mixing with stimulus identity); the same population that maintains the abstract context is also the one that computes the action from it.
- **[[wiki/papers/geometry-abstraction-bernardi-2020.md]]** — primary source; introduces CCGP, SD, PS; records HPC/DLPFC/ACC in monkeys performing serial reversal learning; demonstrates CCGP/SD coexistence and correlation with behavior; replicates geometry in DQN networks trained on the same task.
- **[[wiki/papers/raccah-pfc-consciousness-2021.md]]** — iES elicitation gradient (near-zero in lateral PFC, ~67% in unimodal) is a behavioral in vivo validation of the dense-vs-sparse representational geometry dissociation: local perturbation power decays with code density as predicted by mixed-selectivity distributed codes.
