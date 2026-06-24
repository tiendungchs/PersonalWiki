---
title: "Liquid Time-Constant Networks — Hasani et al., AAAI 2021"
type: paper
tags: [continuous-time, RNN, neural-ODE, expressivity, biological-grounding, dynamical-systems]
created: 2026-06-20
updated: 2026-06-20
sources: [Liquid Time-constant Networks-HasaniR-ML]
related: [wiki/entities/ltc-model.md, wiki/concepts/neural-manifolds.md, wiki/concepts/neuromodulation.md, wiki/concepts/predictive-coding.md, wiki/entities/reservoir-computing.md, wiki/entities/trnn-model.md]
---

# Liquid Time-Constant Networks — Hasani et al., AAAI 2021

Hasani, Lechner, Amini, Rus & Grosu. *The Thirty-Fifth AAAI Conference on Artificial Intelligence*, 2021. MIT / IST Austria / TU Wien.

- **Biologically derived ODE**: LTC (Liquid Time-Constant) equation `dx/dt = -x(t)/τ + f(x,I,t,θ)·(A-x)` is derived from the conductance-based cable equation for nonspiking neurons — specifically C. elegans circuit models, not merely analogically inspired. The same mathematical form governs synaptic current summation: `dv/dt = -gl·v + f(v,I)·(A-v)`, where `1/τ ↔ gl` (leakage conductance).
- **Input-dependent liquid time constant**: The effective time constant becomes `τ_sys = τ / (1 + τ·f(x,I,t,θ))` — each neuron self-modulates its integration window based on what is currently arriving. This is mechanistically equivalent to synaptic conductance modulation, not merely analogous.
- **Provably bounded stability** (Theorems 1 & 2): Both `τ_sys` and hidden state `x(t)` are bounded for unbounded inputs. CT-RNNs and Neural ODEs lack this guarantee; LTCs are unconditionally stable.
- **Superior trajectory length expressivity** (Theorems 4 & 5): Trajectory length — arc length of hidden activations in PCA latent space, measured against a circular input `{sin(t), cos(t)}` — is orders of magnitude larger for LTCs than CT-RNNs or Neural ODEs across activation functions, widths, depths, and ODE solvers. Lower bounds proven for all three CT families.
- **DCM structural resemblance**: LTC (Liquid Time-Constant) semantics resemble Friston's bilinear Dynamic Causal Models (`dx/dt = (A + I(t)B)x + CI`), used to model fMRI time-series. ODE structure inherently possesses causal ordering — LTCs are a candidate class of causal temporal generative models.

**Limitations:** vanishing gradients for long-range temporal dependencies; elevated time/memory cost vs. Neural ODEs; BPTT requires O(L×T) memory for accurate gradients (adjoint method gives constant memory but sacrifices backward-pass accuracy due to trajectory forgetting).

→ Entity page: [[wiki/entities/ltc-model.md]] · Trajectory length: [[wiki/concepts/neural-manifolds.md]] · Liquid τ as neuromodulation analog: [[wiki/concepts/neuromodulation.md]] · DCM/PC connection: [[wiki/concepts/predictive-coding.md]]
