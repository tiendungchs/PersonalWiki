---
title: "Representational Geometry"
type: concept
tags: [representational-geometry, abstraction, CCGP (Cross-Condition Generalization Performance), shattering-dimensionality, mixed-selectivity, neural-population]
created: 2026-06-21
updated: 2026-06-27
sources: [geometry-of-abstraction-bernardi-2020, courellis-hpc-abstract-inference-2024, nieh-hippocampal-geometry-2021, Dendrites endow artificial neural networks with accurate, robust and parameter-efficient learning]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/factorized-representations.md, wiki/concepts/latent-states.md, wiki/concepts/neural-manifolds.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/prefrontal-cortex.md, wiki/concepts/dendritic-computation.md, wiki/papers/pfc-categories-concepts-miller-2002.md, wiki/papers/geometry-abstraction-bernardi-2020.md, wiki/papers/raccah-pfc-consciousness-2021.md, wiki/papers/courellis-hpc-abstract-inference-2024.md, wiki/papers/nieh-hippocampal-geometry-2021.md, wiki/papers/chavlis-dann-2025.md]
---

# Representational Geometry

**The geometric arrangement of neural population activity in firing-rate space — not just what information is encoded, but how — determines what generalizations to novel conditions are possible and what responses a linear readout can generate.**

---

## Core Metrics

| Metric | Definition | High value means |
|---|---|---|
| **CCGP** | Linear decoder accuracy on held-out conditions (cross-condition generalization performance) | Variable is **abstract**: generalizes to novel conditions |
| **Shattering Dimensionality (SD)** | Fraction of all balanced dichotomies linearly separable | High behavioral flexibility: many distinct linear responses available |
| **Parallelism Score (PS)** | Max avg cosine between coding directions across condition pairings | Coding directions parallel across conditions — prerequisite for high CCGP (Cross-Condition Generalization Performance) |

**Key relationship:** PS predicts CCGP (Cross-Condition Generalization Performance). CCGP (Cross-Condition Generalization Performance) and SD (Shattering Dimensionality) are inversely related for purely disentangled representations — but *not* for the geometry observed biologically.

---

## Abstraction Operationalized

A variable is **abstract** (high CCGP (Cross-Condition Generalization Performance)) when its coding direction in firing-rate space is parallel across all groupings of conditions. The linear hyperplane that separates the variable in one subset of conditions transfers to a disjoint subset.

Two failure modes — decodable but not abstract:
1. **Random geometry** — each condition at a random location → SD (Shattering Dimensionality) maximal, CCGP (Cross-Condition Generalization Performance) at chance
2. **Rotating directions** — variable decodable within condition sets but coding axes rotate between them → high accuracy, low CCGP (Cross-Condition Generalization Performance)

---

## The CCGP (Cross-Condition Generalization Performance)/SD Duality

| Geometry | CCGP (Cross-Condition Generalization Performance) | SD (Shattering Dimensionality) | Biological? |
|---|---|---|---|
| Random | ~chance | ~maximal | Unlearned |
| Perfectly disentangled | High | Low (XOR unseparable) | No |
| **Observed: HPC/DLPFC/ACC** | **High (context, value, action)** | **Near-maximal** | **Yes** |

Pure disentanglement limits SD (Shattering Dimensionality) because XOR dichotomies are unseparable. A small distortion from perfect factorization recovers near-maximal SD (Shattering Dimensionality) without sacrificing high CCGP (Cross-Condition Generalization Performance) for the key variables.

**Design implication:** don't aim for maximum disentanglement; aim for the CCGP (Cross-Condition Generalization Performance)/SD balance. These are not mutually exclusive if the geometry is right.

---

## Mixed Selectivity as Substrate

HPC/DLPFC/ACC neurons predominantly show mixed selectivity. This is not a problem: a *rotated* factorized code (linear mixed selectivity) has identical CCGP (Cross-Condition Generalization Performance) to a pure-selective code.

**Empirical origin (Miller, Freedman & Wallis 2002).** The mixed-selectivity concept originates in lateral PFC single-unit recordings: ~44–50% of neurons showed *nonlinear conjunctive* tuning for learned object×saccade associations (Asaad et al. 1998) — activity to a given object–saccade combination could not be predicted from the neuron's response to the components. This nonlinear (XOR-like) conjunction is precisely what supplies high shattering dimensionality; the later CCGP/SD framework (Bernardi et al. 2020) is the population-geometry formalization of what these conjunctive single-neuron findings first described qualitatively. The same PFC recordings showed sharp-boundary *category* tuning (dog-like cats coded like prototype cats), the abstraction (high-CCGP) counterpart to conjunctive (high-SD) coding — both geometries coexist in the same region. The distortion that recovers SD (Shattering Dimensionality) can be layered on top of any rotation. Population geometry — not individual tuning purity — determines abstraction. Single-neuron analysis misses this entirely.

**ML validation (dANN, Chavlis & Poirazi 2025):** Dendritic ANNs trained on standard image classification via backprop spontaneously develop mixed-selectivity nodes (high entropy, multi-class responses) whereas vanilla ANNs develop class-specific nodes. Neither architecture is explicitly trained toward either geometry — the representational outcome follows from structural connectivity alone. This confirms that mixed selectivity is not a training artifact but can be induced by architectural constraints, and that it co-occurs with efficiency gains (1–3 OoM fewer parameters to reach same accuracy).

**Behavioral correlate — iES elicitation gradient:** The near-zero elicitation rate of conscious effects following intracranial electrical stimulation (iES) of lateral PFC (Prefrontal Cortex) (Raccah et al. 2021, [[wiki/papers/raccah-pfc-consciousness-2021.md]]) is the expected consequence of dense, non-topographic PFC (Prefrontal Cortex) codes: disrupting a local iES patch does not perturb the population representation because it is distributed across a large circuit. Unimodal sensory regions (sparse, topographic codes) reach ~67% elicitation because patch disruption directly distorts the local feature representation. The PFC–sensory gradient in iES responsiveness is thus a *in vivo* validation of the representational geometry dissociation: local perturbation power decays as code density increases.

---

## Human Validation: Multi-Area Specificity and Sparsification

Courellis et al. 2024 ([[wiki/papers/courellis-hpc-abstract-inference-2024.md]]) extends CCGP (Cross-Condition Generalization Performance)/PS to human single-unit recordings (17 epilepsy patients, 2,694 neurons; reversal learning with uncued latent context; areas: HC, amygdala, vmPFC, dACC, pre-SMA, VTC).

**Multi-area specificity.** Only HC simultaneously achieves high CCGP (Cross-Condition Generalization Performance) for both latent context and stimulus identity. Amygdala, vmPFC, dACC, pre-SMA, and VTC can abstract at most one variable — none achieves joint disentanglement. This extends the Bernardi et al. 2020 result to include amygdala as a negative control.

| Area | Context abstract? | Stim pair abstract? | Both simultaneously? |
|---|---|---|---|
| **HC** | **Yes** | **Yes** | **Yes (inference-present sessions)** |
| Amygdala | Some variables | Partial | No |
| vmPFC, dACC, pre-SMA | Limited | Limited | No |
| VTC | No | Yes | No |

**Sparsification as mechanism.** HC firing rates drop ~60% (3.37 → 1.36 Hz) in inference-capable sessions. Context centroid separation is the lone variable whose separation *increases* against this overall decrease; the sparser background suppresses noise along non-context axes, making the context coding direction dominant. Individual neurons become more consistent in their context modulation direction across stimuli (increased PS). Variance reduction is fully explained by the firing-rate decrease (Fano factors unchanged) — no separate precision increase occurs.

**Verbal instruction → same geometry within minutes.** Patients receiving a 5-minute verbal description of the latent context structure develop geometrically identical HC representations to those who learned by trial-and-error. The abstract format is channel-independent.

**Design implication:** the abstract-state maintainer in a reasoning model should exhibit sparsification co-occurring with abstraction — lower overall activity isolates the structural coding direction, consistent with the SDR (Sparse Distributed Representations) prescription for interference-resistant coding.

---

## Temporal Dynamics (HPC vs. PFC)

| Phase | HPC context CCGP (Cross-Condition Generalization Performance) | DLPFC context CCGP (Cross-Condition Generalization Performance) |
|---|---|---|
| Pre-stimulus | High | High |
| **Decision epoch** | **Maintained** | **Drops to chance** |
| Pre-next-stimulus | High | Recovers |

HPC holds the abstract context state persistently. DLPFC temporarily loses context abstraction when context is non-linearly combined with stimulus identity to compute the action — this is the computational cost of using an abstract variable for a concrete decision. CCGP (Cross-Condition Generalization Performance) for context correlates with behavioral accuracy; traditional decoding does not.

---

## Reasoning Model Implications

1. Latent/context variables should be encoded abstractly — parallel coding directions enable zero-shot transfer when the structure is familiar.
2. Preserve both CCGP (Cross-Condition Generalization Performance) and SD: over-disentangling limits the number of possible downstream responses.
3. Mixed selectivity is sufficient — population geometry is what matters.
4. Abstraction may dissolve temporarily during action computation — this is functional, not a failure.

---

## Open Problems

1. What training objective optimally produces the CCGP (Cross-Condition Generalization Performance)/SD balance? (Both backprop and DQN develop it spontaneously when the output requires abstract-variable classification.)
2. What determines which variables become abstract — behavioral relevance, temporal statistics, or the training objective?
3. Does the CCGP (Cross-Condition Generalization Performance)/SD duality scale to many simultaneously abstract variables?

---

## Manifold Gradient Organization as Continuous CCGP (Cross-Condition Generalization Performance) Analog

Nieh et al. 2021 ([[wiki/papers/nieh-hippocampal-geometry-2021.md]]) show that when a continuous abstract variable (accumulated evidence) is represented in HC, it appears as a smooth gradient in the neural manifold that is **orthogonal to** and **consistent across** all values of the physical variable (position). This is the continuous-variable analog of the CCGP (Cross-Condition Generalization Performance) criterion: instead of parallel coding directions across discrete condition sets, the abstract variable's coding axis is orthogonal to and independent of the physical variable throughout the manifold. Both criteria operationalize the same underlying requirement — that abstract variables occupy an independent dimension in representational space.

---

## Connections

- **[[wiki/concepts/abstract-reasoning.md]]** — CCGP (Cross-Condition Generalization Performance) is the neural-population operational definition of abstraction, complementing Lake et al.'s computational/behavioral definition; a representation is abstract when it supports cross-condition generalization in the same sense that abstract reasoning supports novel-instance transfer.
- **[[wiki/concepts/factorized-representations.md]]** — disentanglement is a limiting case achieving high CCGP (Cross-Condition Generalization Performance) at the cost of low SD; the biology achieves the CCGP (Cross-Condition Generalization Performance)/SD balance via a distorted factorized geometry; the reasoning model design target is not maximum disentanglement but this balance.
- **[[wiki/concepts/latent-states.md]]** — context is the canonical abstract latent variable; CCGP (Cross-Condition Generalization Performance) operationalizes what "abstractly represented latent state" means at the population level vs. mere decodability.
- **[[wiki/concepts/neural-manifolds.md]]** — representational geometry adds a sixth manifold type: the configuration of coding-direction parallelism and SD (Shattering Dimensionality) in firing-rate space; high CCGP (Cross-Condition Generalization Performance) requires the manifold to have parallel structure for the abstract variable across condition subsets.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — HPC is the persistent abstract-state maintainer; it keeps context in abstract format through the decision epoch where PFC (Prefrontal Cortex) temporarily loses it; HPC provides the stable abstract context that PFC (Prefrontal Cortex) uses (destructively) for action computation.
- **[[wiki/entities/prefrontal-cortex.md]]** — DLPFC achieves high CCGP (Cross-Condition Generalization Performance) for context pre-stimulus but loses it during the decision epoch (non-linear mixing with stimulus identity); the same population that maintains the abstract context is also the one that computes the action from it.
- **[[wiki/papers/pfc-categories-concepts-miller-2002.md]]** — the empirical origin of mixed selectivity: nonlinear conjunctive object×saccade tuning (Asaad et al. 1998) is the single-neuron precursor to high shattering dimensionality; sharp-boundary category tuning is the precursor to high CCGP; both coexist in lateral PFC, prefiguring the CCGP/SD duality.
- **[[wiki/papers/geometry-abstraction-bernardi-2020.md]]** — primary source; introduces CCGP (Cross-Condition Generalization Performance), SD, PS; records HPC/DLPFC/ACC in monkeys performing serial reversal learning; demonstrates CCGP (Cross-Condition Generalization Performance)/SD coexistence and correlation with behavior; replicates geometry in DQN networks trained on the same task.
- **[[wiki/papers/raccah-pfc-consciousness-2021.md]]** — iES elicitation gradient (near-zero in lateral PFC, ~67% in unimodal) is a behavioral in vivo validation of the dense-vs-sparse representational geometry dissociation: local perturbation power decays with code density as predicted by mixed-selectivity distributed codes.
- **[[wiki/papers/courellis-hpc-abstract-inference-2024.md]]** — human single-unit replication of CCGP (Cross-Condition Generalization Performance)/PS in 6 brain areas; establishes HC as the only region achieving simultaneous multi-variable abstraction (amygdala included as negative control); introduces sparsification (60% firing-rate decrease) as the mechanism co-occurring with abstract representation emergence.
- **[[wiki/papers/nieh-hippocampal-geometry-2021.md]]** — demonstrates gradient manifold organization as the continuous analog of CCGP (Cross-Condition Generalization Performance): evidence coding axis is orthogonal to and consistent across all position values in the CA1 neural manifold, satisfying the parallelism criterion for a continuous abstract variable.
- **[[wiki/concepts/dendritic-computation.md]]** — dANN structured sparsity (dendritic connectivity) induces mixed-selectivity nodes without explicit training pressure, providing a concrete architectural mechanism for producing the mixed-selectivity geometry associated with high CCGP (Cross-Condition Generalization Performance)/SD balance.
- **[[wiki/papers/chavlis-dann-2025.md]]** — ML-side validation that mixed selectivity emerges from structured bio-inspired connectivity, and co-occurs with parameter efficiency — bridging the biological mixed-selectivity finding to a concrete ML architecture choice.
