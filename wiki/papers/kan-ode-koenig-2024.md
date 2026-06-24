---
title: "KAN-ODEs: Kolmogorov-Arnold Network Ordinary Differential Equations for Learning Dynamical Systems and Hidden Physics"
type: paper
tags: [neural-ODE, KAN, continuous-time, dynamical-systems, symbolic-regression, parameter-efficiency]
created: 2026-06-24
updated: 2026-06-24
sources: [KAN-ODEs Kolmogorov-Arnold Network Ordinary Differential Equations for Learning Dynamical Systems and Hidden Physics]
related: [wiki/entities/ltc-model.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/concepts/latent-states.md]
---

# KAN-ODEs (Koenig et al. 2024, MIT)

Koenig B.C., Kim S., Deng S. — Department of Mechanical Engineering, MIT. arXiv:2407.04192.

---

## Key Computational Insights

- **Architecture**: KAN replaces the MLP gradient-getter in Neural ODEs: `du/dt = KAN(u(t), θ)`. Solved forward with a standard ODE integrator (Tsit5 Runge-Kutta); trained via adjoint sensitivity method (memory-efficient backprop through the ODE solver).
- **Basis functions**: Gaussian RBF per activation edge + Swish residual (`b(x) = x·sigmoid(x)`); inputs normalized to [−1, 1] per layer. Grid size N controls expressivity; parameter count per layer = `input_dim × N × output_dim` (RBF path) + `input_dim × output_dim` (residual path).
- **N⁻⁴ scaling**: KAN-ODE achieves 4th-order convergence in loss vs. parameter count; MLP Neural ODE achieves N⁻² (2nd order). Empirically: 240-param KAN-ODE → 8.3×10⁻⁷ MSE; 252-param MLP Neural ODE → 3×10⁻⁵ MSE (Lotka-Volterra, same epoch budget) — ~36× better accuracy at matched size.
- **Symbolic regression**: Trained KAN activations can be post-processed via SymbolicRegression.jl to recover governing equations. Fisher-KPP: single [1,1,5] KAN learns unknown reaction term; symbolic regression returns `0.995u(1.002−u)`, matching true `ru(1−u)` with r=1.0 to <1% error.
- **Modular submodel**: KAN-ODE can act as a source-term module inside a larger PDE solver (`∂u/∂t = D∂²u/∂x² + KAN(u, θ)`), isolating the unknown component while known physics is handled analytically.

## Limitations

- ~3× slower per-epoch than MLP Neural ODE at comparable size (RBF evaluation cost); compensated by faster convergence requiring fewer epochs.
- No biological grounding; KAT (Kolmogorov-Arnold Theorem) is a mathematical result, not a neuroscience claim.
- No recurrent memory: KAN-ODE is a gradient-getter, not a sequence model — same limitation as standard Neural ODEs for long-range dependencies.

## Connections

- **[[wiki/entities/ltc-model.md]]** — LTC and KAN-ODE both use ODE frameworks for continuous-time dynamics; KAN-ODE is more parameter-efficient (N⁻⁴ vs. N⁻² scaling) but lacks LTC's biological derivation, input-dependent time constants, and stability guarantees.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — KAN-ODE is listed as an available ML tool for Block 1B (Path Integration Update, `dg/dt = f(g, v)`); this paper provides the empirical validation of its efficiency advantage over MLP Neural ODEs.
- **[[wiki/concepts/latent-states.md]]** — symbolic regression over trained KAN activations recovers latent governing equations from trajectory data, instantiating one approach to identifying latent dynamical structure from observations.
