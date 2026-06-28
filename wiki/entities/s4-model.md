---
title: "S4 (Structured State Space Sequence Model)"
type: entity
tags: [state-space-model, sequence-modeling, long-range-dependencies, HiPPO, SSM, continuous-time, recurrent, convolutional]
created: 2026-06-27
updated: 2026-06-27
sources: [SSM]
related: [wiki/papers/s4-gu-2022.md, wiki/entities/ms-ssm-model.md, wiki/entities/mamba-model.md, wiki/entities/ltc-model.md, wiki/concepts/working-memory.md, wiki/concepts/sequence-memory.md, wiki/concepts/temporal-coding.md]
---

# S4 (Structured State Space Sequence Model)

Gu, Goel & Ré — Stanford University 2022. A sequence model built on the classical SSM x'(t) = Ax(t) + Bu(t), y(t) = Cx(t) + Du(t), made computationally tractable via the NPLR parameterization of the HiPPO matrix.

---

## Architecture

| Component | Description |
|---|---|
| **SSM equations** | x'(t) = Ax(t) + Bu(t); y(t) = Cx(t) + Du(t); A ∈ R^{N×N}, B/C ∈ R^N |
| **HiPPO matrix** | A_{nk} = −(2n+1)^{1/2}(2k+1)^{1/2} for n>k; initializes SSM to memorize input history via Legendre polynomial projections |
| **NPLR decomposition** | A = V(Λ − PQ*)V*; V unitary, Λ diagonal, P/Q ∈ R^{N×r} (r=1 for HiPPO-LegS); reduces to DPLR form over ℂ |
| **Convolutional mode** | SSM kernel K ∈ R^L computed via truncated generating function + Cauchy kernel evaluation at roots of unity + iFFT; O(Ñ+L) training |
| **Recurrent mode** | Discretized via bilinear method; x_k = Āx_{k-1} + B̄u_k; Ā^{-1} is also DPLR; O(N) per step inference |
| **Dual-mode switching** | Convolutional for parallel training; recurrent for autoregressive generation (60× faster than Transformer) |
| **Deep S4 layer** | H independent SSMs (one per feature); position-wise linear mixing; nonlinear activations between layers; total O(H²)+O(HN) params per layer |

Trainable parameters per SSM: 5N (Λ, P, Q, B, C ∈ ℂ^N).

---

## Key Results

| Benchmark | S4 | Best prior |
|---|---|---|
| LRA average | **86.09%** | 59.37% (Luna-256) |
| Path-X (length 16,384) | **96.35%** | 50% (all prior work) |
| Pathfinder | **94.20%** | 77.80% (FNet) |
| sCIFAR (sequential) | **91.13%** | 74.4% (best non-SSM RNN) |
| SC10 raw speech | **98.32%** | 96.25% (WaveGAN-D) |
| WikiText-103 (perplexity) | 20.95 (−0.44 vs. Transformer) | — |
| Training speed vs. LSSL | up to 30× faster | — |
| Memory vs. LSSL | up to 400× less | — |

---

## Ablation: HiPPO Importance

| Initialization | sCIFAR val (100K params) |
|---|---|
| Random Gaussian A | ~60–65% |
| Random diagonal A | ~70–75% |
| HiPPO (full S4) | **84.27%** |

S4's effectiveness comes from HiPPO initialization, not the NPLR algorithm. Random NPLR performs similarly to random Gaussian.

---

## Limitations

- **Fixed LTI**: A, B, C are sequence-position–independent; cannot selectively attend to specific tokens (Mamba adds per-token gating at the cost of hierarchical reasoning)
- **Complex arithmetic**: NPLR requires working over ℂ; eigenvalue stability requires the S4D fix (Λ − PP* instead of Λ − PQ*)
- **Not NLP-optimized**: closes gap to Transformer on WikiText-103 but does not surpass it; Mamba surpasses Transformers at LM scale
- **Sequence tasks only**: not benchmarked at LLM pretraining scale in original paper

---

## Comparison Table

| Model | Gating | Long-range | ListOps | LRA avg | Inference |
|---|---|---|---|---|---|
| **S4** | None (LTI) | HiPPO | **59.60** | **91.38** | O(N) |
| S4D | None (diagonal) | HiPPO | 60.47 | — | O(N) |
| LSSL | None (LTI) | HiPPO | — | — | O(N²) |
| Mamba (S6) | Input-dep. | — | 38.02 | 72.30 | O(N) |
| MS-SSM (S4+SWT) | None | HiPPO + multi-scale | **62.83** | **91.89** | O(N) |
| Liquid-S4 | Liquid kernel | HiPPO + liquid | — | **87.32** | O(N) |
| Transformer | Attention | — | 36.37 | 53.66 | O(L²) |

---

## Connections

- **[[wiki/entities/ms-ssm-model.md]]** — MS-SSM uses S4 as the base SSM backbone (MS-SSM (S4) variant) and adds SWT multi-scale decomposition, improving LRA average from 91.38% → 91.89% and ListOps from 59.60% → 62.83%
- **[[wiki/entities/mamba-model.md]]** — Mamba replaces S4's fixed LTI matrices with input-dependent selective gating (S6); gains token-level adaptivity but collapses on hierarchical reasoning (ListOps 38% vs. S4 60%)
- **[[wiki/entities/ltc-model.md]]** — Liquid-S4 variant injects LTC liquid kernel terms into S4's DPLR SSM, achieving 87.32% LRA average with 30% fewer parameters; both models share the O(N) per-step recurrent representation
- **[[wiki/concepts/working-memory.md]]** — S4's latent state x(t) ∈ R^N is a structured fading-memory WM: HiPPO ensures x(t) tracks the full history of u(t) via Legendre polynomial projections, implementing a principled multi-timescale memory buffer
- **[[wiki/concepts/sequence-memory.md]]** — S4 implements linear recurrent sequence memory; the convolutional kernel K encodes the entire sequence impulse response and can be visualized as learned spatiotemporal filters (Path-X filters span full 16,384 context)
- **[[wiki/concepts/temporal-coding.md]]** — continuous-time SSM formulation naturally handles irregular sampling via step size Δ; S4 adapts to 0.5× speech sampling rate at test time without retraining, demonstrating that temporal structure is encoded in the dynamics rather than the positional index
