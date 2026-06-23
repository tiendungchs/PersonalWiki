---
title: "VL-JEPA: Joint Embedding Predictive Architecture for Vision-Language — Chen et al. 2025"
type: paper
tags: [jepa, vision-language, embedding-prediction, world-models, self-supervised-learning, selective-decoding]
created: 2026-06-23
updated: 2026-06-23
sources: [VL-JEPA]
related: [wiki/entities/vl-jepa-model.md, wiki/entities/jepa-model.md, wiki/concepts/world-models.md, wiki/concepts/energy-based-models.md, wiki/papers/assran-ijepa-2023.md]
---

# VL-JEPA: Joint Embedding Predictive Architecture for Vision-Language

Chen, Shukor, Moutakanni, Chung et al. (Meta FAIR / HKUST / Sorbonne / NYU), 2025. arXiv:2512.10942.

---

## Key Computational Insights

- **Embedding-space supervision outperforms token-space supervision** in a strictly controlled comparison (same encoder, data, batch size, schedule): VL-JEPA reaches 14.8 CIDEr vs. 7.1 for a VLM baseline at 15M samples seen; 41.0% vs. 27.2% top-5 classification accuracy. The gain comes from a simplified target distribution — semantically equivalent answers map to nearby embedding points rather than disjoint token sequences.

- **Selective decoding is native to non-autoregressive JEPA**: the predictor emits a continuous semantic embedding stream; a lightweight threshold on embedding variance (agglomerative clustering with Ward distance) triggers the expensive Y-decoder only at semantic-shift events. At 0.35 Hz this matches uniform decoding at 1 Hz — 2.85× reduction in decode operations, preserving CIDEr performance on EgoExo4D.

- **World-state representation beats language-mediated reasoning on WorldPrediction-WM**: given initial+final state images, VL-JEPA-SFT selects among candidate action embeddings by cosine distance — 65.7% vs. GPT-4o 52.0%, Claude-3.5 53.3%, Gemini-2 55.6%. The model never generates text in this evaluation; pure embedding comparison suffices.

- **Single architecture unifies generation, classification, and retrieval**: CLIP-style models cannot generate; VLMs cannot retrieve. VL-JEPA's shared embedding space supports all three via the same predictor → nearest-neighbor or predictor → decoder pathway (Table 8).

- **InfoNCE in embedding space provides both alignment and collapse prevention**: the loss decomposes into a representation-alignment term (minimizes distance between prediction ŜY and target SY) and a uniformity regularization term (pushes batch embeddings apart). Anti-collapse property requires unfreezing the Y-encoder — pure regression losses (L1, L2, cosine) cannot prevent collapse with a trainable encoder.

---

## Limitations

- Evaluated on perception-focused VQA (GQA, TallyQA, POPE); not benchmarked on knowledge/reasoning-heavy tasks where generative VLMs excel (tool use, multi-step reasoning, agentic tasks).
- V-JEPA 2 vision encoder is frozen throughout; joint learning of visual and language representations is not explored.
- SFT stage partially degrades BASE model's hard-negative text sensitivity (SugarCrepe++ drops from 63.9% to 58.4%) — standard instruction-tuning/alignment tension.

---

## Links

- Entity page: [[wiki/entities/vl-jepa-model.md]]
- JEPA predecessor architecture: [[wiki/entities/jepa-model.md]]
- World models context: [[wiki/concepts/world-models.md]]
- EBM framing: [[wiki/concepts/energy-based-models.md]]
- I-JEPA empirical precursor: [[wiki/papers/assran-ijepa-2023.md]]
