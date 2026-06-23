---
title: "Theories of Error Back-Propagation in the Brain — Whittington & Bogacz, Trends in Cognitive Sciences 2019"
type: paper
tags: [credit-assignment, backpropagation, predictive-coding, dendritic-error, contrastive-learning, hebbian-learning, biologically-plausible-learning, equilibrium-propagation, stdp]
created: 2026-06-23
updated: 2026-06-23
sources: [Theories of Error Back-Propagation in the Brain]
related: [wiki/concepts/credit-assignment.md, wiki/concepts/predictive-coding.md, wiki/concepts/hebbian-learning.md, wiki/concepts/dendritic-computation.md, wiki/papers/whittington-bogacz-pc-backprop-2017.md, wiki/papers/bartunov-scalability-bio-dl-2018.md, wiki/entities/boltzmann-machine.md]
---

# Whittington & Bogacz 2019 — Theories of Error Back-Propagation in the Brain

Whittington JCR & Bogacz R. *Trends in Cognitive Sciences* 23(3):235–250 (2019).

Review surveying four biologically plausible backprop theories, classifying them into two functional classes, and unifying all under the equilibrium propagation framework.

---

## Key Computational Insights

- **Two model classes.** Temporal-error models (contrastive learning, continuous update) encode errors in neural activity differences *across time*. Explicit-error models (predictive coding, dendritic error) encode errors in *dedicated neuron populations*. The class determines whether a phase-control signal is required, which STDP variant implements the rule, and what experimental predictions arise about neural responses to prediction violations.

- **Continuous update model → asymmetric STDP.** When output neurons shift continuously toward target values, the weight rule is Δw ∝ x_pre × (dx_post/dt). This is implemented by asymmetric STDP: a presynaptic spike during *rising* postsynaptic activity → net LTP; during *falling* activity → net LTD. Establishes the cleanest known correspondence between a STDP form and a specific credit assignment mechanism.

- **Predictive coding → symmetric STDP.** The PC weight rule (Δw ∝ ε · x_pre) is implemented by symmetric STDP: weights increase when pre- and post-synaptic co-activity exceeds baseline (regardless of spike order) and decrease when postsynaptic activity is low. Vogels et al. (2011) demonstrated this plasticity form in inhibitory synapses.

- **Equilibrium propagation as formal unifier.** All four models are energy-based; network dynamics converge to an energy minimum before weights update. Temporal-error models minimize Hopfield energy; explicit-error models minimize free energy (ELBO). The equilibrium propagation framework (Scellier & Bengio 2017) derives the correct weight update rule for *any* network with a defined energy function — making it a universal schema for biologically plausible learning that predicts plasticity from anatomy.

- **Tradeoffs between classes.** Temporal-error: require a phase-control signal (which phase: prediction vs. target) but have unconstrained connectivity and no pre-training needs. Explicit-error: autonomous (no phase signal needed) but require 1:1 error–value node pairing (no anatomical counterpart) and the dendritic variant needs inhibitory interneuron pre-training. Predictive coding propagates information through 2L−1 synapses (slow prediction); dendritic error propagates through L−1 (fast prediction but slow training).

- **Integration hypothesis.** Temporal-error models suit primary sensory areas where the next sensory frame reliably arrives (target presence guaranteed); explicit-error models suit supervised tasks where target timing is uncertain. PC may describe subcortical circuits (cerebellum, BG) where pyramidal cells are absent — apical dendritic computations are unavailable, but error-node circuits remain viable.

---

## Limitations

- All four models validated only at MNIST scale (~1.7–3% error); scalability to ImageNet undemonstrated — see [[wiki/papers/bartunov-scalability-bio-dl-2018.md]] for the empirical gap.
- Models handle static input–target pairs only; temporal sequence learning is listed as an outstanding question.
- Weight symmetry assumed in all four models; bidirectional brain connections are not symmetric transposes — robustness without symmetry remains open.
- Dendritic error model requires pre-training of inhibitory interneurons (Martinotti cells) before feedforward learning can begin.

---

## Links

- **[[wiki/concepts/credit-assignment.md]]** — continuous update model added to taxonomy table; temporal-error vs. explicit-error classification and model comparison table added from this review; equilibrium propagation framework developed.
- **[[wiki/concepts/predictive-coding.md]]** — PC is the primary explicit-error model; theta oscillation phase-coordination for contrastive learning and the temporal-error context for the contrastive Hebbian precursor section added from this review.
- **[[wiki/concepts/hebbian-learning.md]]** — STDP form ↔ model class correspondence: asymmetric STDP = continuous update (temporal-error); symmetric STDP = PC (explicit-error).
- **[[wiki/concepts/dendritic-computation.md]]** — Martinotti cells as the specific interneuron type implementing local error prediction in the dendritic error model.
- **[[wiki/papers/whittington-bogacz-pc-backprop-2017.md]]** — predecessor paper by same authors; formal derivation of PC ≈ backprop at energy minimum; this review extends the comparison to all four model classes.
- **[[wiki/papers/bartunov-scalability-bio-dl-2018.md]]** — the scalability gap flagged in this review's outstanding questions is empirically quantified by Bartunov et al. 2018.
- **[[wiki/entities/boltzmann-machine.md]]** — contrastive learning (temporal-error) is a generalization of the Boltzmann machine's two-phase contrastive Hebbian rule; equilibrium propagation formalizes what was implicit in the Boltzmann training procedure.
