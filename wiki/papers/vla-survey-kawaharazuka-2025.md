---
title: "Vision-Language-Action Models for Robotics: A Review Towards Real-World Applications"
type: paper
tags: [vla, robotics, world-models, hierarchical-control, latent-action, embodied-ai]
created: 2026-06-23
updated: 2026-06-23
sources: [Vision-Language-Action Models for Robotics A Review Towards Real-World Applications]
related: [wiki/concepts/world-models.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/predictive-coding.md, wiki/concepts/abstract-reasoning.md]
---

# VLA Survey — Kawaharazuka et al. 2025

**Citation:** Kawaharazuka, Oh, Yamada, Posner, Zhu. "Vision-Language-Action Models for Robotics: A Review Towards Real-World Applications." IEEE Access (2025).

---

## Key Computational Insights

- **Hierarchical policy as multi-level meta-graph** — RT-H, π₀.₅, GR00T N1 all separate a high-level symbolic layer (predicts "language motions" or FAST discrete tokens) from a low-level continuous controller (flow matching / diffusion). Switching between levels via a single input-prompt token shows that the same network can operate in two computational modes. Empirically, this separation improves long-horizon task performance — the closest working instantiation of the nested W hierarchy in [[wiki/concepts/latent-graph-discovery.md]].

- **LAPA: vocabulary co-discovery from video** — Latent Action Pre-training from Videos (LAPA) learns a discrete action codebook without labels: a VQ-VAE is applied to the *difference* between frame embeddings at t and t+H; the codebook is learned jointly with a world model that reconstructs frame_{t+H} from frame_t + the latent code. The resulting discrete tokens are the action vocabulary for a downstream VLA. This is a concrete partial solution to Gap 3 (vocabulary co-discovery): the alphabet is discovered alongside graph structure, though domain-specific to egocentric manipulation video.

- **World models for embodied planning** — UniPi generates video sequences via diffusion then uses an Inverse Dynamics Model to recover actions; GR-1 jointly predicts future frames and actions; LUMOS performs imitation learning in world-model latent space via RL with an expert-deviation intrinsic reward. All instantiate predictive coding applied to motor planning: the forward model predicts sensory consequences, the inverse model or policy recovers the action.

- **Chain-of-thought in embodied settings (ECoT)** — ECoT autoregressively generates task descriptions → subtasks → object positions before the action token sequence. This intermediate reasoning chain markedly improves planning — direct support for the multi-step latent-space reasoning open problem (VL-JEPA open problem on latent-space chain, open-problems.md).

- **Embodiment-agnostic latent representations** — LangToMo, ATM, AVDC predict optical flow or feature-point trajectories rather than explicit robot actions. Because flow is embodiment-agnostic, these models leverage human demonstration videos without action-space alignment — same insight as the latent-state approach in [[wiki/concepts/latent-states.md]].

---

## Limitations (as source)

- Engineering survey, not a theoretical contribution; all insights are implementations, not formal analyses.
- Hierarchical architectures and LAPA are demonstrated in manipulation/locomotion contexts only; transfer to abstract (non-physical) reasoning is unverified.
- No evaluation against the wiki's core diagnostic criteria (ARC-AGI, structural generalization benchmarks).

---

## Links to Concept / Entity Pages

- [[wiki/concepts/world-models.md]] — VLA world models (UniPi, LAPA, GR-1) add embodied instantiations to the table
- [[wiki/concepts/hierarchical-representations.md]] — hierarchical VLA adds an engineering-scale instantiation of multi-level symbolic + continuous hierarchy
- [[wiki/concepts/latent-graph-discovery.md]] — LAPA partially addresses vocabulary co-discovery (Gap 3)
- [[wiki/concepts/predictive-coding.md]] — embodied predictive coding: action as minimization of prediction error over future sensory states
- [[wiki/concepts/abstract-reasoning.md]] — ECoT as embodied chain-of-thought; intermediate representations before action generation
