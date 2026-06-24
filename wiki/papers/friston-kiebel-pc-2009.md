---
title: "Predictive Coding under the Free-Energy Principle — Friston & Kiebel 2009"
type: paper
tags: [predictive-coding, free-energy-principle, generative-model, attractor, temporal-hierarchy, perceptual-categorization]
created: 2026-06-23
updated: 2026-06-23
sources: [Predictive coding under the free-energy principle]
related: [wiki/concepts/predictive-coding.md, wiki/concepts/neural-manifolds.md, wiki/concepts/latent-states.md, wiki/papers/friston-free-energy-2009.md, wiki/papers/bastos-canonical-microcircuit-2012.md]
---

# Predictive Coding under the Free-Energy Principle — Friston & Kiebel 2009

**Friston, K. & Kiebel, S. (2009). Predictive coding under the free-energy principle. *Phil. Trans. R. Soc. B*, 364, 1211–1221.**

---

- **Generalized coordinates of motion** — sensory data and hidden states are encoded as full Taylor series of temporal derivatives (y, y′, y″, …), representing entire trajectories rather than snapshots; this allows Bayesian deconvolution of temporal sequences without buffering or replay.
- **Hierarchical dynamical models** — causal states v(t) link levels; hidden states x(t) mediate temporal memory within a level; higher-level output enters lower-level dynamics via nonlinear coupling functions, inducing empirical priors on temporal structure at every timescale.
- **Coupled attractor hierarchy** — the concrete generative model is hierarchically coupled dynamical systems (Lorenz attractors); higher-level attractor state provides control parameters that parametrically reshape the lower attractor's manifold, switching it between fixed-point, quasi-periodic, and chaotic regimes — each corresponding to a distinct perceptual category.
- **Structural vs. dynamical priors** — top-down connections supply structural priors (reshape which manifold is active → determine *which* category); intrinsic connections supply dynamical priors (temporal flow within the current manifold → *where* in the sequence); simulated lesions confirm both are necessary; neither alone supports veridical perception.
- **Perceptual categorization as higher-attractor localization** — Bayesian deconvolution of the full sensory trajectory maps it to a point in the higher attractor's state space; three birdsong categories resolved to non-overlapping 90% CI regions after ~600 ms; abstract categorization is the natural endpoint of hierarchical PC (Predictive Coding) inference, not a separate classification step.

**Limitations:** attractor model is a toy (Lorenz system); how the correct attractor structure is *learned* from data rather than hand-specified is not addressed; extension to non-autonomous (externally driven) hierarchies and to abstract non-physical transformation spaces is left open.

---

- [[wiki/concepts/predictive-coding.md]] — temporal extension of hierarchical PC: generalized coordinates, coupled attractor generative models, structural/dynamical prior distinction, and perceptual categorization as higher-attractor localization.
- [[wiki/concepts/latent-states.md]] — higher attractor state = latent category; perceptual categorization is latent-state inference via Bayesian deconvolution of the full sensory trajectory.
- [[wiki/concepts/neural-manifolds.md]] — attractor manifolds are the generative substrate of temporal trajectory manifolds; higher attractor parametrically controls lower manifold shape (structural priors); intrinsic connections maintain temporal flow within it (dynamical priors).
- [[wiki/papers/friston-free-energy-2009.md]] — companion Friston 2009 paper covering active inference and three-tier representation; this paper extends the same FEP (Free Energy Principle) framework to temporal sequences and attractor-based generative models.
- [[wiki/papers/bastos-canonical-microcircuit-2012.md]] — provides the laminar-to-computational mapping that implements the two-population error/state unit architecture described here.
