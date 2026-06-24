---
title: "VL-JEPA (Vision-Language JEPA)"
type: entity
tags: [jepa, vision-language, world-models, embedding-prediction, non-autoregressive, selective-decoding, self-supervised-learning]
created: 2026-06-23
updated: 2026-06-23
sources: [VL-JEPA]
related: [wiki/entities/jepa-model.md, wiki/concepts/world-models.md, wiki/concepts/energy-based-models.md, wiki/concepts/predictive-coding.md, wiki/concepts/hierarchical-representations.md, wiki/papers/vl-jepa-chen-2025.md, wiki/papers/assran-ijepa-2023.md, wiki/papers/v-jepa-2-assran-2026.md]
---

# VL-JEPA (Vision-Language JEPA)

**Multimodal JEPA architecture that extends representation-space prediction to vision-language tasks by predicting continuous text embeddings rather than generating tokens. Proposed by Meta FAIR (Chen et al. 2025); 1.6B parameters.**

---

## Architecture

| Component | Implementation | Role |
|---|---|---|
| X-Encoder | V-JEPA 2 ViT-L (frozen, 304M params) | Maps visual input (image/video frames at 256²) → visual token embeddings SV |
| Predictor | Last 8 Llama-3.2-1B layers (490M trainable, bidirectional attention) | Maps (SV, XQ) → predicted target embedding ŜY; conditioned on text query tokens |
| Y-Encoder | EmbeddingGemma-300M (trainable, ×0.05 LR) + linear head → 1536-dim | Maps textual target Y → target embedding SY; provides simplified multi-modal distribution |
| Y-Decoder | Lightweight LM (used only at inference) | Translates ŜY → readable text ŷ when triggered; not used in main training |

**Training objective:** bidirectional InfoNCE loss between prediction ŜY and target SY in the shared 1536-dim embedding space. InfoNCE decomposes into alignment (minimize distance) + uniformity (push batch embeddings apart, prevents collapse). Anti-collapse requires a trainable Y-Encoder — regression losses (L1/L2/cosine) cannot prevent collapse when Y-Encoder is unfrozen.

**Two-stage training:**
1. Query-free pretraining on image/video captions (2B image samples + video data; VL-JEPA-BASE)
2. Supervised finetuning on VQA/captioning mixture (VL-JEPA-SFT)

---

## Key Results

| Task | VL-JEPA | Best Baseline | Notes |
|---|---|---|---|
| Zero-shot video classification (avg 8 datasets) | 52.5% | 44.7% (PE-Core-G, 2.3B) | BA (Brodmann Area)SE model; 26× fewer training samples |
| Zero-shot text-to-video retrieval R@1 (avg 8) | 63.7% | 58.1% (PE-Core-G) | BA (Brodmann Area)SE model |
| WorldPrediction-WM (world modeling) | **65.7%** | 55.6% (Gemini-2.0) | SFT model; surpasses GPT-4o (52%), Claude-3.5 (53.3%) |
| GQA (compositional visual reasoning) | 61.5% | 66.6% (InternVL-Chat-13B) | SFT model, 1.6B params vs. 13B+ baselines |
| Controlled vs. VLM baseline (15M samples, CIDEr) | **14.8** | 7.1 (same-data VLM) | Embedding prediction > token prediction, controlled experiment |
| Selective decoding savings | 2.85× | — | 0.35 Hz matches 1.0 Hz uniform decoding on EgoExo4D |

---

## Limitations

- Not benchmarked on knowledge-intensive or multi-step reasoning tasks; the claim of matching VLMs holds only for perception-focused benchmarks.
- V-JEPA 2 encoder is frozen — no joint vision-language representation learning.
- SFT erodes BA (Brodmann Area)SE model's text hard-negative sensitivity (SugarCrepe++ 63.9% → 58.4%), a standard alignment tension.
- The selective decoding threshold is a hyperparameter requiring domain-specific tuning.

---

## Why Embedding Prediction Works Better

In token space, two semantically equivalent answers ("the lamp is off" / "room goes dark") are nearly orthogonal — the model must fit two disjoint high-density regions. In embedding space, the Y-Encoder maps both to nearby points, collapsing the multi-modal distribution to a single coherent mode. This simplification drives the 2× sample efficiency advantage over token-generative VLMs in controlled comparisons.

---

## Comparison to Related Models

| Model | Predicts | Anti-collapse | Tasks | Params |
|---|---|---|---|---|
| **VL-JEPA** | Text embedding SY | InfoNCE (bidirectional) | Gen + Retrieval + Class | 1.6B |
| **I-JEPA** | Visual patch embedding | EMA (Exponential Moving Average) target encoder | Image SSL only | ViT-H |
| **CLIP** | None (contrastive alignment) | InfoNCE | Retrieval + Classification | 400M–2B |
| **VLM (LLaVA-style)** | Tokens Y | — | Generation + VQA | 7B–70B+ |
| **DINO-WM** | Visual state embedding | EMA (Exponential Moving Average) | Visual planning (narrow domain) | — |

---

## Connections

- **[[wiki/entities/jepa-model.md]]** — VL-JEPA extends JEPA/I-JEPA from unimodal (image/video) to multimodal (vision-language) by adding a text Y-Encoder as the target representation source; the core prediction-in-representation-space principle is identical.
- **[[wiki/concepts/world-models.md]]** — VL-JEPA-SFT achieves SoTA on WorldPrediction-WM by matching state-change embeddings to action embeddings without language generation; empirically confirms that representation-space world modeling outperforms token-generative approaches.
- **[[wiki/concepts/energy-based-models.md]]** — VL-JEPA's training loss is InfoNCE, a contrastive EBM (Energy-Based Model) loss; the model is an LVEBM where the energy is the cosine distance between predicted and target embeddings in the shared space; InfoNCE's uniformity term is the collapse-prevention regularizer.
- **[[wiki/concepts/predictive-coding.md]]** — the embedding-prediction objective abstracts away surface linguistic variability (word choice, paraphrasing) analogously to how PC's prediction errors are computed at each hierarchical level rather than at the pixel/token level; both avoid committing to a specific surface realization of predicted content.
- **[[wiki/concepts/hierarchical-representations.md]]** — the X-encoder (visual) → Predictor → Y-encoder (semantic) pipeline implements a cross-modal hierarchical abstraction: raw pixels → visual tokens → semantic embedding; the Y-encoder specifically discards task-irrelevant surface features.
- **[[wiki/papers/vl-jepa-chen-2025.md]]** — primary source for this page.
- **[[wiki/papers/assran-ijepa-2023.md]]** — I-JEPA provides the empirical foundation; VL-JEPA inherits the EMA (Exponential Moving Average) / anti-collapse design and multi-block masking intuition, now generalized to cross-modal prediction.
- **[[wiki/papers/v-jepa-2-assran-2026.md]]** — V-JEPA 2 is the visual encoder VL-JEPA builds upon; the two papers form a stack: V-JEPA 2 provides the video world-model backbone that VL-JEPA aligns with language.
