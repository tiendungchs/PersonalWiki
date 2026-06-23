---
title: "An Introduction to Vision-Language Modeling — Bordes et al., Meta AI 2024"
type: paper
tags: [vision-language, contrastive-learning, masking, generative-models, vlm, evaluation, compositional-reasoning]
created: 2026-06-23
updated: 2026-06-23
sources: [An Introduction to Vision-Language Modeling]
related: [wiki/entities/vl-jepa-model.md, wiki/entities/jepa-model.md, wiki/concepts/energy-based-models.md, wiki/concepts/binding-problem.md, wiki/concepts/compositional-generalization.md, wiki/concepts/world-models.md, wiki/concepts/information-theory.md]
---

# An Introduction to Vision-Language Modeling — Bordes et al. 2024

Bordes, Pang, Ajay, Li, Bardes, et al. (Meta AI / CMU / UC Berkeley / U Toronto). arXiv 2405.17247.

---

## Key Computational Insights

- **Rate-distortion unification of VLM objectives:** VLM training can be written as `min_θ I(f(X);Z) + β·H(X|Z)`. Contrastive loss = compression without reconstruction (scores equivalence of representations; entropy bottleneck bounded by amount masked; distortion via cosine similarity). Masking loss = compression with reconstruction (log q(z) bounds rate; log q(x|z) bounds distortion via auto-encoding). The *data transformation* (augmentation, masking, modality choice) determines the rate; the *loss form* (contrastive vs. reconstructive) determines the distortion metric. This unifies all four VLM families under one objective.

- **Four VLM family taxonomy:** (1) Contrastive (CLIP, SigLIP) — shared embedding space, InfoNCE, zero-shot transfer; (2) Masking (FLAVA, MaskVLM) — cross-modal reconstruction; (3) Generative (CoCa, Chameleon, Stable Diffusion) — token or pixel generation; (4) Pretrained backbone (Frozen, BLIP-2, MiniGPT, LLaVA) — frozen LLM + learned visual projector/Q-Former. Families are not mutually exclusive; most recent models mix objectives.

- **Analysis-by-synthesis advantage on compositional tasks:** Generative classifiers (p(c|x) via Bayes from learned p(x|c)) outperform discriminative models (CLIP) on Winoground and have better shape bias; align more with human judgment; can be jointly adapted at test time using unlabeled examples. Cost: inference is expensive (hundreds of network evaluations per image for diffusion models).

- **VLM compositional failures persist at scale:** Winoground (word-order near-chance), ARO (relation/attribute/order swap tasks), PUG (spatial relations at random chance). Scale and contrastive pretraining do not solve relational/compositional binding.

- **Cross-modal grounding failures:** VLMs fail on spatial relations (left/right), negation, counting, attribute binding — capabilities that require inferring relational structure, not just co-occurrence statistics.

---

## Limitations

- Survey-level: no primary empirical results; coverage is selective, not exhaustive.
- Focus is 2D static images (and video as extension); does not address structured or 3D scene understanding.
- Evaluation section reveals benchmark fragility (language priors solvable blind; Winoground argmax bug inflates scores).

---

## Links to Concept / Entity Pages

- [[wiki/concepts/energy-based-models.md]] — §2.3.3 derives the rate-distortion unification; contrastive = compression without reconstruction; non-contrastive JEPA fits as a third training family
- [[wiki/concepts/compositional-generalization.md]] — §4.1.6–4.1.8: Winoground, ARO, PUG add a fourth evidence domain showing that VLM scale does not fix composition/localism
- [[wiki/concepts/binding-problem.md]] — CLIP's shared embedding space as cross-modal binding mechanism; ARO/Winoground failures as the evidence that contrastive binding is shallow (co-occurrence, not relational structure)
- [[wiki/entities/vl-jepa-model.md]] — VL-JEPA is a pretrained-backbone VLM (family 4) using InfoNCE (family 1 objective) but predicting embeddings not aligning unimodal encoders; places VL-JEPA precisely in the taxonomy
- [[wiki/concepts/world-models.md]] — generative VLMs (Chameleon, Stable Diffusion) learn an implicit joint distribution over text and images; generative classifiers perform analysis-by-synthesis at inference time — the closest current analog to a VLM world model
