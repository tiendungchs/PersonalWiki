---
title: "MS-SSM: A Multi-Scale State Space Model for Efficient Sequence Modeling"
type: paper
tags: [state-space-models, multi-scale, sequence-modeling, hierarchical-reasoning, hierarchical-representations]
created: 2026-06-27
updated: 2026-06-27
sources: []
related: [wiki/entities/ms-ssm-model.md, wiki/entities/mamba-model.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/working-memory.md]
---

# MS-SSM: A Multi-Scale State Space Model for Efficient Sequence Modeling

Karami, Behrouz, Zhong, Pascanu & Mirrokni — Google Research / Google DeepMind, 2025. arXiv:2512.23824.

---

## Key Computational Insights

- **Multi-scale decomposition via SWT** — Stationary Wavelet Transform (SWT) decomposes input into S+2 resolution streams without downsampling (preserving translation invariance); a[s][t] = (a[s−1] ∗ φ↑2^{s−1})[t], implemented as causal dilated depthwise Conv1d with dilation 2^{s−1}; each stream is fed to an independent SSM, so effective state size becomes (S+2)×N with no added inference cost
- **Scale-dependent initialization** — SSMs at coarser scales (larger s) initialize Ā eigenvalues closer to 1 (longer effective memory ~ 1/δ); fine-scale SSMs initialize closer to 0 (short memory); directly mirrors the cortical timescale gradient where low-frequency processing regions operate on longer integration windows
- **Ablation: multi-scale conv is the critical component** — removing the multi-resolution convolution drops ListOps from 63% → 38%; removing the SSM layer loses only ~0.5%; the timescale decomposition — not selective state gating — drives hierarchical reasoning gains
- **Input-dependent scale mixer** — E_t = Linear(x_t) dynamically weights the (S+2) SSM outputs; static (input-independent) mixing scores 61.28 vs. 63.04 on ListOps; non-linear SoftMax gating also worse (61.42)
- **Mamba's selective forget hurts hierarchical reasoning** — Mamba 38.02% vs. S4 59.60% on ListOps; data-dependent gating sacrifices structural pattern capture; MS-SSM (S4) at 62.83% fully restores and surpasses S4 by adding multi-scale convolutions

---

## Limitations

- Not evaluated at LLM scale for NLP; benchmarks are medium-scale (LRA, ECG, sCIFAR, ImageNet-1K)
- S is a fixed hyperparameter per task; no mechanism for adaptive scale selection
- MS-SSM (S6) on LRA average (86.73%) is worse than MS-SSM (S4) (91.89%), showing that input-dependent gating interacts poorly with non-hierarchical long-range tasks despite gaining on ListOps

---

## Related Pages

- **[[wiki/entities/ms-ssm-model.md]]** — full architecture and results
- **[[wiki/entities/mamba-model.md]]** — Mamba (key comparison baseline; selective SSM that fails on hierarchical tasks)
- **[[wiki/concepts/hierarchical-representations.md]]** — MS-SSM as sequence-domain instance of multi-timescale hierarchical processing
- **[[wiki/concepts/working-memory.md]]** — SSMs as working memory alternative to attention; scale-dependent initialization as multi-timescale memory design
