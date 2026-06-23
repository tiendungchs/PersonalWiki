---
title: "BYOL: Bootstrap Your Own Latent — A New Approach to Self-Supervised Learning"
type: paper
tags: [self-supervised-learning, representation-learning, non-contrastive, ema-target]
created: 2026-06-23
updated: 2026-06-23
sources: [BYOL]
related: [wiki/concepts/energy-based-models.md, wiki/concepts/world-models.md, wiki/entities/dinov2-model.md]
---

# BYOL — Grill, Strub, Altché et al. (DeepMind, NeurIPS 2020)

**Citation:** Grill J-B, Strub F, Altché F, et al. Bootstrap Your Own Latent: A New Approach to Self-Supervised Learning. *NeurIPS 2020*.

---

## Key Computational Insights

- **Non-contrastive SSL without negatives:** online network learns to predict the target network's representation of a differently-augmented view of the same image; no negative pairs, no contrastive loss, no memory bank required.
- **EMA target as stable bootstrap:** target weights ξ = EMA(θ) with τ ∈ [0.996 → 1.0]; slow-moving average ensures prediction targets change gradually, preventing training instability from hard target copies (τ=0 collapses; τ=1 produces a fixed random network with no iterative improvement).
- **Asymmetric predictor prevents collapse:** the online branch alone has an extra MLP qθ; both EMA target AND predictor are jointly necessary — removing either causes collapse to ~0% accuracy. The predictor needs to be kept near-optimal relative to the current target; EMA's smoothing serves this role by ensuring the predictor is not chasing a rapidly moving target.
- **Collapse avoidance mechanism (theoretical):** with an optimal predictor, the loss gradient equals the expected conditional variance Var(z'ξ | zθ); constant zθ cannot decrease this variance, so collapsed constant representations are (hypothesized) unstable equilibria. Full proof remains elusive — the argument assumes optimal predictor and no normalization.
- **Augmentation robustness via representational pressure:** because the online must predict *whatever the target captured*, not merely what distinguishes between images, BYOL retains more information under augmentation removal (−9.1 pts removing color vs. −22.2 pts for SimCLR); this generalizes the pressure from discrimination to full information retention.

---

## Limitations

- Batch normalization in the encoder creates implicit negative pairs; BYOL's collapse avoidance partially relies on BN statistics rather than the EMA+predictor mechanism alone (acknowledged in ablation §5 footnote 7).
- Augmentation design is still required per modality; automating augmentation search across domains (video, audio, text) is left as future work.
- 74.3% ImageNet linear probe with ResNet-50 — competitive at publication but now well below DINO/JEPA-family results achieved with the same or fewer parameters.

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — BYOL is a non-contrastive EBM trained via representation-space bootstrapping; the EMA target + asymmetric predictor is the design pattern that preceded and directly inspired the EMA teacher-student architecture in DINO, DINOv2, and the JEPA family.
- **[[wiki/concepts/world-models.md]]** — BYOL's representation-space prediction objective (predict target's latent from online's latent) is the same paradigm as JEPA world models; BYOL demonstrates that prediction in latent space without pixel reconstruction produces transferable representations.
- **[[wiki/entities/dinov2-model.md]]** — DINOv2's EMA teacher (momentum 0.994 → 1.0), stop-gradient on the teacher, and asymmetric student-only projector head are direct architectural descendants of BYOL's design.
