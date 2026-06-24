---
title: "Language Modeling Is Compression — Delétang et al., DeepMind 2023"
type: paper
tags: [compression, information-theory, language-models, scaling-laws, in-context-learning, solomonoff]
created: 2026-06-21
updated: 2026-06-21
sources: [Language Modeling Is Compression]
related: [wiki/concepts/information-theory.md, wiki/concepts/predictive-coding.md, wiki/concepts/meta-learning.md, wiki/concepts/attention.md]
---

# Language Modeling Is Compression — Delétang et al., DeepMind 2023

**Citation:** Delétang G., Ruoss A., Duquenne P.-A., Catt E., Genewein T., Mattern C., Grau-Moya J., Wenliang L.K., Aitchison M., Orseau L., Hutter M., Veness J. *Language Modeling Is Compression.* arXiv:2309.10668, 2023. DeepMind.

---

## Key Computational Insights

- **Log-loss = lossless compression rate (formal identity):** Via arithmetic coding, minimizing cross-entropy training loss is identical to minimizing lossless compression rate. The log-loss objective for LLMs, the accuracy term in FEP, and lossless compression are three names for the same operation.
- **Solomonoff predictor as the theoretical ceiling:** Optimal universal lossless compression recovers the Solomonoff predictor — a Bayesian mixture over all computable programs weighted 2^(−|program|). Predicting optimally ≡ compressing optimally ≡ Solomonoff induction. Current LLMs are parameter-bounded, training-distribution-limited approximations to this ideal; the gap defines the formal limit of current AI on novel abstract reasoning domains.
- **Cross-modal generalization as evidence for abstract structure:** Chinchilla 70B (text-trained only) compresses ImageNet patches to 43.4% (vs. PNG 58.5%) and LibriSpeech to 16.4% (vs. FLAC 30.3%). Large-scale prediction training extracts modality-agnostic statistical structure — compression performance is a direct measure of generalization.
- **Scaling law twist — optimal model size is dataset-bounded:** Adjusted compression rate (model bytes + compressed bytes) has a critical point: beyond the optimal model size for a given dataset, additional parameters increase the net compressed footprint. The Chinchilla compute-optimal scaling laws follow as a compression theorem corollary.
- **Tokenization as lossless pre-compression:** Tokenizers reduce sequence length (more information per context token) at the cost of a larger vocabulary (harder per-step prediction). The two effects cancel exactly in theory. In practice small models benefit from larger vocabularies; large models do not. Tokenizer choice determines information density in the in-context WM window.

## Limitations

- Adjusted compression is evaluated on 1 GB datasets — too small for billion-parameter model costs to amortize; the "large models are poor adjusted compressors" finding is dataset-size-dependent.
- Arithmetic coding is used only for evaluation, not during training; the compression equivalence is analytical and does not change the training loop.
- Cross-modal results use 2048-byte chunks with no inter-chunk context — underestimates true compression potential of long-context models.

## Related Pages

- [[wiki/concepts/information-theory.md]] — compression-prediction equivalence; Solomonoff predictor; scaling law twist; tokenization as pre-compression
- [[wiki/concepts/predictive-coding.md]] — FEP (Free Energy Principle) accuracy term = cross-entropy = compression rate; FEP (Free Energy Principle) minimization is compression minimization
- [[wiki/concepts/meta-learning.md]] — in-context learning = in-context compression; frozen slow-W is a compression prior; fast inner loop adapts without gradient updates
- [[wiki/concepts/attention.md]] — context length is the compression window; tokenization shapes effective WM capacity
