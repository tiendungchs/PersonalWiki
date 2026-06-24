---
title: "LTC (Liquid Time-Constant Network)"
type: entity
tags: [continuous-time, RNN, neural-ODE, expressivity, biological-grounding, dynamical-systems, C-elegans, closed-form, CfC]
created: 2026-06-20
updated: 2026-06-24
sources: [Liquid Time-constant Networks-HasaniR-ML, Liquid Time-constant Networks, Closed-form continuous-time neural networks - Nature Machine Intelligence]
related: [wiki/papers/ltc-hasani-2021.md, wiki/papers/ltc-emergentmind-overview.md, wiki/papers/cfc-hasani-2022.md, wiki/concepts/neural-manifolds.md, wiki/concepts/neuromodulation.md, wiki/concepts/predictive-coding.md, wiki/concepts/spike-frequency-adaptation.md, wiki/entities/reservoir-computing.md, wiki/entities/trnn-model.md, wiki/concepts/working-memory.md, wiki/concepts/attention.md]
---

# LTC (Liquid Time-Constant) (Liquid Time-Constant Network)

Hasani et al. 2021 ([[wiki/papers/ltc-hasani-2021.md]]). A continuous-time RNN where each neuron's integration time constant adapts to the current input — a *liquid* τ — derived from the conductance-based cable equation of nonspiking neurons.

---

## Architecture

| Component | Description |
|---|---|
| **Core ODE** | `dx/dt = -x(t)/τ + f(x(t), I(t), t, θ)·(A - x(t))` |
| **Liquid time constant** | `τ_sys = τ / (1 + τ·f(x, I, t, θ))` — per-neuron, input-dependent |
| **Nonlinearity f** | Any differentiable activation; `f = tanh(γ_r·x + γ·I + µ)` in experiments |
| **Bias vector A** | Per-neuron equilibrium target |
| **ODE solver** | Fused explicit+implicit Euler; handles LTC's stiff equations; avoids Runge-Kutta instability for stiff systems |
| **Training** | Vanilla BPTT (not adjoint): trades O(L×T) memory for accurate gradient recovery |

**Biological origin**: The LTC (Liquid Time-Constant) equation derives from the nonspiking neuron cable equation:
- `dv/dt = -gl·v(t) + S(t)` (leaky integration; Lapicque 1907)
- `S(t) = f(v, I)·(A-v)` (steady-state synaptic current; Koch & Segev 1998)
- Combined: identical to LTC (Liquid Time-Constant) Eq. 1, with `1/τ ↔ gl`. Source: C. elegans nematode circuit models (Hasani et al. 2020; Gleeson et al. 2018).

---

## Key Results

| Task | LTC (Liquid Time-Constant) | Best baseline | Note |
|---|---|---|---|
| Gesture recognition | **69.55%** | CT-GRU 68.31% | |
| Traffic prediction (MSE) | **0.099** | LSTM 0.169 | 5–70% improvement |
| Person activity (2nd setting) | **0.882** | Latent ODE 0.846 | |
| Half-Cheetah kinematics (MSE) | **2.308** | LSTM 2.500 | |
| Sequential MNIST | 97.57% | LSTM 98.41% | LSTM wins here |

LTC wins 4/7 tasks; comparable on the remaining 3. Trajectory length is 10–1000× CT-RNN and Neural ODE under identical settings.

---

## Variants

| Variant | Key change | Solver | Notable result |
|---|---|---|---|
| **LTC** (Hasani 2021, AAAI) | Core ODE; fused Euler solver | Fused explicit+implicit Euler | 4/7 task wins vs. CT-RNN/LSTM |
| **CfC** (Hasani et al. 2022, NMI) | Analytical closed-form ODE approximation; time-continuous gating | **None** (solver-free) | 1–5 orders of magnitude speedup; matches or exceeds LTC (Liquid Time-Constant) across all benchmarks |
| **LTC-SE** (Bidollahkhani 2023) | CT-GRU update/reset gates; TF2; quantization/pruning | Configurable | Up to 8–9% accuracy gain; 10–30% less compute depth |
| **Liquid-S4** (Hasani 2022) | DPLR SSM + liquid kernel terms; causal convolutions | **None** (conv) | 87.32% LRA avg; 30% fewer params than S4 |
| **LGTC/CfGC** (Marino 2024) | Graph-coupled τ via matrix contraction; multi-agent | CfGC solver-free | Matches centralized flocking policy |

CfC and Liquid-S4 eliminate the ODE solver entirely — CfC via analytical approximation, Liquid-S4 via SSM causal convolution — making LTC (Liquid Time-Constant) principles scalable without stiff integration.

---

## CfC: Closed-form Architecture

The key mathematical result (Theorem 1, Hasani et al. 2022): the integral `∫₀ᵗ f(I(s))ds` that appears as an ODE exponent can be approximated as `f(I(t))·t` for any Lipschitz-continuous, positive, monotonically increasing, bounded `f`. The approximation error is bounded by `|x₀-A|·e^{-w_τ·t}`, which decays exponentially — the bound is sharp (tight).

**Approximate closed-form solution (scalar LTC, Eq. 2):**

$$x(t) \approx (x_0 - A)\,e^{-[w_\tau + f(I(t),\theta)]\,t}\,f(-I(t),\theta) + A$$

**Practical CfC model (Eq. 4) — resolves gradient issues via sigmoidal gating:**

$$\mathbf{x}(t) = \underbrace{\sigma(-f(\mathbf{x},\mathbf{I};\theta_f)\,\mathbf{t})}_{\text{time gate } G(t)} \odot\, g(\mathbf{x},\mathbf{I};\theta_g) + \underbrace{[1 - \sigma(-f(\mathbf{x},\mathbf{I};\theta_f)\,\mathbf{t})]}_{\text{complement gate}} \odot\, h(\mathbf{x},\mathbf{I};\theta_h)$$

- `G(t) ≈ 1` at `t=0` (dominated by `g`, the short-timescale state); `G(t) → 0` as `t → ∞` (dominated by `h`, the long-timescale attractor). The gate transition speed is controlled by `f(x,I;θ_f)` — a learned liquid time constant.
- `f`, `g`, `h` share early backbone layers, coupling the liquid time constant to both output states; separate head layers allow independent temporal and structural representations.
- Elapsed time `t` appears explicitly in the gate, giving CfC direct irregular-sampling capability: timestamps drive the gate rather than being fed as auxiliary inputs.

**Complexity:** O(K̃) vs. O(Kp) for a p-th order ODE solver (K solver sub-steps, K̃ input time steps; K ≫ K̃ on stiff dynamics, explaining the 8,752% speedup on Human Activity Recognition).

**CfC variants by use case:**

| Variant | When to use |
|---|---|
| CfC (vanilla, Eq. 4) | Sequences up to ~200 steps |
| CfC-mmRNN (CfC inside LSTM) | Long-range dependencies; prevents vanishing gradients |
| Cf-S (Eq. 3, no head split) | Maximum inference speed at slight accuracy cost |
| CfC-noGate (drop `1-σ` term) | Ablation / hyperparameter alternative to vanilla |

---

## Limitations

- **Vanishing gradients** for long-range dependencies — not a long-term WM solution without modification
- **Higher cost** than Neural ODEs for vanilla LTC/BPTT; CfC patches this with ~220× speedup
- **Stiff equations** require the fused solver in vanilla LTC; CfC variant eliminates this constraint
- **No variable-delay mechanism**: unlike TRNN's neuron recruitment, LTC (Liquid Time-Constant) has no tested mechanism for multi-second WM maintenance

---

## Comparison to Related CT Models

| Model | τ type | Stability guarantee | Trajectory expressivity | Long-term memory | Biological derivation |
|---|---|---|---|---|---|
| **Neural ODE** | Fixed (implicit in f) | None | Low (~10²) | No | Minimal |
| **CT-RNN** | Fixed scalar per neuron | None | Low–medium (~10³) | No | Leaky integrator analogy |
| **LTC** | Liquid (input-dependent) | Yes — Theorems 1 & 2 | High (~10⁴) | No | Derived from C. elegans cable equation |
| **TRNN** | Discrete-step self-inhibition | Not analytically proven | Medium (dPCA manifold) | Yes (variable delay) | C. elegans + mammalian PFC (Prefrontal Cortex) |
| **LSTM** | Gated discrete-step | No (gradient flow) | Low | Yes (long sequences) | Minimal |
| **KAN-ODE** | N/A (gradient-getter only) | None | N-dependent (N⁻⁴ scaling) | No | None |

---

## Connections

- **[[wiki/concepts/neural-manifolds.md]]** — trajectory length (arc length in PCA latent space under circular input) measures how much of the temporal trajectory manifold a CT model can sweep; LTCs sweep orders of magnitude more than CT-RNNs or Neural ODEs, establishing a fifth type of manifold structure: the expressive CT temporal manifold.
- **[[wiki/concepts/neuromodulation.md]]** — the liquid τ is a local mechanistic analog of neuromodulatory time-constant modulation: just as ACh, DA, and NA (Noradrenaline / Norepinephrine) shift neural integration timescales globally, τ_sys adapts per-neuron integration windows based on current inputs continuously.
- **[[wiki/concepts/predictive-coding.md]]** — the LTC (Liquid Time-Constant) ODE structurally resembles Friston's bilinear Dynamic Causal Models (DCMs), which are used to model fMRI time-series and have inherent causal structure; LTCs may serve as causal temporal generative models in a FEP (Free Energy Principle) framework.
- **[[wiki/entities/reservoir-computing.md]]** — reservoirs use fixed random weights producing transient echo-state dynamics; LTCs replace the random fixed W with a trained continuous-time ODE system; the fused solver makes LTCs tractable where reservoir's frozen dynamics are task-agnostic.
- **[[wiki/entities/trnn-model.md]]** — both achieve expressive temporal dynamics but via different mechanisms: TRNN (Transition RNN) via self-inhibition + sparse + hierarchical topology (discrete-step); LTC (Liquid Time-Constant) via liquid τ (continuous-time ODE); TRNN (Transition RNN) is better suited for multi-item WM and long delays; LTC (Liquid Time-Constant) for continuous-time signal modeling with stability guarantees.
- **[[wiki/concepts/working-memory.md]]** — LTC (Liquid Time-Constant) is a continuous-time WM candidate for short-to-medium timescales; the liquid τ allows each neuron to self-select its memory timescale based on input statistics, but vanishing gradients limit long-range applicability.
- **[[wiki/concepts/attention.md]]** — Liquid-S4 fuses LTC (Liquid Time-Constant) liquid kernels into the SSM DPLR framework, bridging continuous-time adaptive-memory dynamics to the attention/transformer thread; the liquid kernel encodes multi-way input correlations as an additive term on top of the SSM recurrence, achieving 87.32% LRA SOTA.
- **[[wiki/papers/ltc-hasani-2021.md]]** — primary source for core LTC; ODE derivation, theorems, benchmark results.
- **[[wiki/papers/ltc-emergentmind-overview.md]]** — broader survey covering CfC, Liquid-S4, LTC-SE, LGTC, and neuromorphic deployment.
- **[[wiki/papers/cfc-hasani-2022.md]]** — full NMI 2022 source for the closed-form approximation theorem, time-continuous gating equation, backbone architecture, and benchmark results establishing 1–5 OoM speedup.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — SFA's adaptive threshold is a mechanistic parallel to the liquid τ: both adapt a per-neuron temporal property from local history (LTC adapts integration time constant from input magnitude; SFA (Spike Frequency Adaptation) adapts firing threshold from spike history); LTC (Liquid Time-Constant) and ALIF (Adaptive Leaky Integrate-and-Fire) are complementary intrinsic adaptation mechanisms that could coexist in a single neuron model.
- **[[wiki/papers/kan-ode-koenig-2024.md]]** — KAN-ODE replaces the MLP gradient-getter in the Neural ODE framework with a KAN, achieving N⁻⁴ convergence vs. N⁻² for MLP Neural ODE; more parameter-efficient than the standard Neural ODE that LTC builds on, but lacks LTC's biological derivation, input-dependent time constant, and stability guarantees.
