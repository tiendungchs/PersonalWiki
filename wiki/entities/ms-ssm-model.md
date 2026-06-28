---
title: "MS-SSM (Multi-Scale State Space Model)"
type: entity
tags: [state-space-model, multi-scale, sequence-modeling, hierarchical-reasoning, SSM]
created: 2026-06-27
updated: 2026-06-28
sources: [MS-SSM A Multi-Scale State Space Model for Efficient Sequence Modeling]
related: [wiki/papers/ms-ssm-karami-2025.md, wiki/entities/s4-model.md, wiki/entities/mamba-model.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/working-memory.md, wiki/concepts/predictive-coding.md, wiki/concepts/temporal-multiplexing.md]
---

# MS-SSM (Multi-Scale State Space Model)

Karami, Behrouz, Zhong, Pascanu & Mirrokni — Google Research / DeepMind 2025.

---

## Architecture

| Component | Description |
|---|---|
| **SWT decomposition** | Stationary Wavelet Transform with learned filters; produces S+1 detail streams d^s and one approximation a^S; implemented as causal dilated Conv1d(dilation=2^{s−1}) per scale; no downsampling → translation-invariant |
| **SSM array** | S+2 independent SSMs in parallel: one per wavelet scale s ∈ {1,…,S}, one for original signal x_t, one for final approximation a^S; effective state = (S+2)×N |
| **Scale-dependent init** | diag(Ā^s) initialized in (e^{−Δ₀N(S+1−s)}, e^{−NΔ₀(S−s)}]; coarse scales (large s) → eigenvalues near 1 → long memory; fine scales → eigenvalues near 0 → short memory |
| **Input-dependent gating** | B_t^s, C_t^s, Δ_t^s all conditioned on raw input x_t (not on scale representation x̂^s_t); empirically more effective |
| **Scale mixer** | z_t = E_t · y_t where E_t = Linear(x_t); input-dependent linear projection; significantly beats static mixing |

---

## Key Results

| Benchmark | MS-SSM (S4) | MS-SSM (S6) | Best baseline |
|---|---|---|---|
| ListOps (hierarchical) | 62.83% | **63.04%** | S4: 59.60% |
| LRA average | **91.89%** | 86.73% | S5: 92.52% |
| sCIFAR (pixel sequence) | 90.3% | **93.3%** | MultiResNet: 93.1% |
| ImageNet-1K | 79.7% | **81.3%** | Mamba: 80.5% |
| PTB-XL ECG (AUROC) | **0.939** | **0.939** | S4: 0.938 |

MS-SSM (S6) achieves 2× Mamba accuracy on ListOps (63% vs. 38%) without increased parameter count or inference cost.

---

## Ablation Summary

| Variant | PTB-XL | ListOps |
|---|---|---|
| MS-SSM (S6) — full | 0.939 | 63.04 |
| Remove multi-scale conv | 0.916 | 37.98 |
| Remove SSM | 0.936 | 62.59 |
| Input-independent scale mixer | 0.932 | 61.28 |

**Critical finding:** multi-scale convolution contributes ~25 pp on ListOps; SSM contributes ~0.5 pp. The timescale decomposition is the key mechanism, not selective gating.

---

## Limitations

- Not evaluated at LLM scale for NLP
- Scale count S fixed per task; no adaptive selection
- S6 variant underperforms S4 on LRA average despite winning on ListOps — input-dependent gating interacts poorly with non-hierarchical long-range tasks
- Relies on SWT, which increases parameter count by O(KS) and computation by O(LKS) — small overhead but grows with number of scales

---

## Comparison Table

| Model | Gating | Multi-scale | ListOps | LRA avg |
|---|---|---|---|---|
| S4 | No | No | 59.60 | 91.38 |
| Mamba | Input-dep. | No | 38.02 | 72.30 |
| Griffin | Input-dep. | No | 32.34 | 68.47 |
| **MS-SSM (S4)** | No | SWT | **62.83** | **91.89** |
| **MS-SSM (S6)** | Input-dep. | SWT | **63.04** | 86.73 |

---

## Connections

- **[[wiki/concepts/hierarchical-representations.md]]** — MS-SSM is the sequence-domain instantiation of multi-timescale hierarchical processing: SWT decomposes input into S+2 resolution streams, each with an SSM initialized to its appropriate timescale; confirms that explicit timescale separation (not just gating) is the effective inductive bias for hierarchical reasoning
- **[[wiki/entities/mamba-model.md]]** — Mamba is the primary SSM baseline; MS-SSM shows that adding multi-scale convolutions to Mamba's S6 block recovers the hierarchical reasoning performance that selective gating lost (38% → 63% on ListOps)
- **[[wiki/concepts/working-memory.md]]** — scale-dependent initialization is a principled design for multi-timescale WM: coarse scales act as long-range memory (Ā ≈ 1), fine scales as short-range buffers; the SSM array implements a structured multi-timescale fading memory
- **[[wiki/concepts/predictive-coding.md]]** — scale-dependent SSM array mirrors the cortical hierarchy's multi-timescale predictive structure: lower-frequency regions integrate over longer windows, higher-frequency regions process fine-grained details; Caucheteux et al. (2023) evidence cited in paper for brain hierarchical prediction at multiple timescales
- **[[wiki/entities/s4-model.md]]** — S4 is the base SSM that MS-SSM (S4) variant uses; MS-SSM adds SWT decomposition on top of S4's fixed LTI dynamics to recover hierarchical reasoning without selective gating
- **[[wiki/papers/ms-ssm-karami-2025.md]]** — paper stub with full citation and key insights
- **[[wiki/concepts/temporal-multiplexing.md]]** — temporal multiplexing establishes that the brain runs 6 parallel asynchronous streams at distinct intrinsic timescales; MS-SSM operationalizes this principle in ML via SWT decomposition + parallel SSM array with scale-dependent initialization, confirming that explicit multi-timescale structure (not selective gating) is the effective inductive bias for hierarchical reasoning tasks.
