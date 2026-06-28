---
title: "Mamba (Selective SSM)"
type: entity
tags: [state-space-model, selective-scan, sequence-modeling, recurrent, SSM]
created: 2026-06-27
updated: 2026-06-27
sources: [MS-SSM A Multi-Scale State Space Model for Efficient Sequence Modeling]
related: [wiki/entities/s4-model.md, wiki/entities/ms-ssm-model.md, wiki/concepts/working-memory.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/attention.md]
---

# Mamba (Selective SSM)

Gu & Dao 2023. Selective state-space model with input-dependent gating (S6 block); currently the dominant SSM baseline.

---

## Architecture

| Component | Description |
|---|---|
| **S6 block** | Selective SSM: B_t = Linear_B(x_t), C_t = Linear_C(x_t), Δ_t = Softplus(Linear_Δ(x_t)); parameters vary per token, breaking LTI constraint |
| **Associative scan** | Replaces convolutional formulation with parallel prefix scan for O(L log L) parallel training; enables input-dependent parameters |
| **Hardware-aware impl** | Kernel fusion + tiling on CUDA; avoids materializing O(LN) expanded state in HBM; practical training speed comparable to transformers |
| **Gating mechanism** | Input-dependent selective forget: Δ_t controls effective decay rate per token; analogous to LSTM forget gate but on continuous-time dynamics |

Linear inference complexity O(N) per step vs. O(L²) for transformers.

---

## Key Results

| Benchmark | Score | Notes |
|---|---|---|
| ListOps (LRA) | 38.02% | Far below S4 (59.60%); selective gating trades structural capture for context-selectivity |
| LRA average | 72.30% | Well below S4 (91.38%) and S5 (92.52%) |
| sCIFAR | 90.1% | Competitive with SSMs |
| ImageNet-1K | 80.5% | On par with S4D (80.4%) |
| Language modeling | Strong | Primary target; outperforms transformers at scale on perplexity |

**Critical failure mode:** Mamba collapses on hierarchical reasoning (ListOps) — 2× below S4, 5× below H-Transformer-1D. The selective forget mechanism trades away the structured sequence capture that fixed-parameter SSMs preserve.

---

## Limitations

- Selective gating significantly hurts hierarchical/structured reasoning tasks vs. fixed-parameter SSMs (S4, S5)
- Loses convolutional interpretation → cannot use FFT-based parallelism; relies entirely on associative scan
- Input-dependent parameters increase expressivity but reduce ability to capture fixed structural patterns across diverse sequence positions

---

## Comparison to Related SSMs

| Model | Parameters | Training | ListOps | LRA avg |
|---|---|---|---|---|
| S4 | Fixed (A diagonal) | Convolutional / scan | 59.60 | 91.38 |
| S4D | Fixed (diagonal) | Convolutional | 60.52 | — |
| S5 | Fixed (MIMO) | Associative scan | 62.15 | 92.52 |
| **Mamba (S6)** | Input-dependent | Associative scan | 38.02 | 72.30 |
| Griffin | Input-dep. + local attn | Scan | 32.34 | 68.47 |
| MS-SSM (S4+SWT) | Fixed + multi-scale | Conv + scan | 62.83 | 91.89 |

---

## Connections

- **[[wiki/entities/s4-model.md]]** — S4 is the direct predecessor: Mamba replaces S4's fixed LTI (A,B,C constant across tokens) with input-dependent B_t/C_t/Δ_t; this gains token-level selectivity but loses the structured long-range capture that HiPPO initialization provides (ListOps 38% vs. S4 60%)
- **[[wiki/entities/ms-ssm-model.md]]** — MS-SSM adds multi-scale SWT decomposition to both S4 and S6 blocks; on ListOps the S6 variant recovers from 38% → 63%, showing that multi-scale convolution compensates for selective gating's structural blindness
- **[[wiki/concepts/working-memory.md]]** — Mamba's selective gating is the SSM analog of an attention-based WM gate: Δ_t controls per-token decay, allowing selective retention; but this comes at the cost of structural pattern capture identified in the LRA ablations
- **[[wiki/concepts/hierarchical-representations.md]]** — Mamba's failure on ListOps (hierarchical reasoning) vs. S4 reveals that input-dependent selective forget is a poor inductive bias for hierarchical structure; fixed-parameter SSMs with multi-scale decomposition outperform
- **[[wiki/concepts/attention.md]]** — Mamba was designed as an attention-free alternative that achieves comparable language modeling performance; its selective scan is functionally analogous to content-based attention gating but operates in O(L) rather than O(L²)
