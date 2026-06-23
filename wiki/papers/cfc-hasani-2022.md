---
title: "Closed-form Continuous-time Neural Networks — Hasani et al., Nature Machine Intelligence 2022"
type: paper
tags: [continuous-time, RNN, closed-form, LTC, CfC, neural-ODE, time-series, gating, sequence-modeling]
created: 2026-06-23
updated: 2026-06-23
sources: [Closed-form continuous-time neural networks - Nature Machine Intelligence]
related: [wiki/entities/ltc-model.md, wiki/papers/ltc-hasani-2021.md, wiki/papers/ltc-emergentmind-overview.md, wiki/concepts/working-memory.md, wiki/concepts/predictive-coding.md, wiki/concepts/attention.md]
---

# Closed-form Continuous-time Neural Networks — Hasani et al., NMI 2022

Hasani, Lechner, Amini et al., *Nature Machine Intelligence* 4, 1112–1119 (2022). Derives a provably tight closed-form approximation of the LTC ODE, eliminating the need for numerical differential equation solvers while preserving expressivity.

---

- The integral `∫₀ᵗ f(I(s))ds` that appears as an exponent in LTC dynamics can be approximated as `f(I(t))·t`; the error is bounded by `|x₀-A|·e^{-w_τ·t}` — decaying exponentially, so the approximation improves over time (sharpness result: bound is tight).
- This yields a closed-form hidden-state formula (Theorem 1): `x(t) ≈ (x₀-A)·e^{-[w_τ + f(I(t),θ)]t}·f(-I(t),θ) + A`, eliminating the ODE solver and reducing per-step complexity from `O(Kp)` (p-th order solver, K solver steps) to `O(K̃)` (number of input time steps, typically 1–3 orders of magnitude smaller).
- The practical CfC model replaces exponential decay with a sigmoidal time gate: `x(t) = σ(-f(x,I;θ_f)t)⊙g(x,I;θ_g) + [1-σ(-f(x,I;θ_f)t)]⊙h(x,I;θ_h)` — a smooth interpolation between two learned states (`g`, `h`) controlled by elapsed time and a learned liquid time constant; backbone layers shared among `f`, `g`, `h` couple time constant to state nonlinearity.
- Speedup is 1–5 orders of magnitude over ODE-based counterparts in training and inference; CfC matches or exceeds LTC accuracy across human activity recognition (8,752% speedup over Latent-ODE-ODE), physical dynamics (Walker2D, outperforms transformers by 18%), irregular MNIST (98.09%), and autonomous lane-keeping (parameter-efficient: ~4,000 RNN params).
- Time appears explicitly in the gate formula (`t` multiplies the learned time-constant network `f(x,I;θ_f)`), enabling native handling of irregularly sampled time series without timestamps-as-inputs heuristics; equidistant sampling is handled by uniform `t` sampling within a hyperparameter range `[a,b]`.

**Limitations:** CfC only approximates the LTC ODE (does not form a bijection), making it unsuitable for normalizing flows. Vanishing gradients persist for long sequences — CfC-mmRNN (CfC hidden state inside an LSTM) patches this at the cost of the mixed-memory overhead. Causal inference from the learned dynamics may be less tractable than from explicit ODE representations.

→ Entity: [[wiki/entities/ltc-model.md]] · Original AAAI paper: [[wiki/papers/ltc-hasani-2021.md]] · Survey of variants: [[wiki/papers/ltc-emergentmind-overview.md]]
