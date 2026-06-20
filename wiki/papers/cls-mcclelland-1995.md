---
title: "Why There Are Complementary Learning Systems in the Hippocampus and Neocortex — McClelland, McNaughton & O'Reilly 1995"
type: paper
tags: [complementary-learning-systems, catastrophic-interference, interleaved-learning, memory-consolidation, replay]
created: 2026-06-20
updated: 2026-06-20
sources: [Complementary learning systems Why - Claude summary]
related: [wiki/concepts/two-learning-timescales.md, wiki/concepts/replay.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/papers/cls-oreilly-2011.md]
---

# Why There Are Complementary Learning Systems in the Hippocampus and Neocortex — McClelland, McNaughton & O'Reilly 1995

McClelland, J. L., McNaughton, B. L., & O'Reilly, R. C. (1995). *Psychological Review*, 102(3), 419–457.

**Foundational CLS paper.** The 2011 O'Reilly et al. update ([[wiki/papers/cls-oreilly-2011.md]]) extends the biological mechanism; this paper provides the formal computational necessity argument.

---

## Key Computational Insights

- **Catastrophic interference is the formal proof of necessity:** McCloskey & Cohen (1989) showed that intensively training a network on list B after list A erased ~100% of A — far worse than human forgetting. A single network cannot rapidly store new content without overwriting shared weights encoding prior structure.
- **Interleaved learning is the mechanism for structured knowledge extraction:** Rumelhart's (1990) semantic network reproduced the coarse-to-fine child developmental trajectory (plant/animal → bird/fish → robin/canary) *only* under interleaved training. Focused training on any subset destroys this. HC replay delivers the interleaved stream cortex needs.
- **Statistical learning theory grounds the slow-W timescale:** Discovering population-level regularities requires averaging over many diverse samples with small gradient steps. Large focused updates overfit to single-episode surface statistics; this is the mathematical reason slow-W updates must be small and distributed across environments — not just a biological constraint.
- **HC as teacher:** HC stores episodes one-shot, then replays them during sleep to give cortex an interleaved diet of old and new experiences. Consolidation takes 15+ years because cortex must interleave each new episode with thousands of prior ones before the structural regularity becomes stable.
- **Quasi-regular domains — gist/detail dissociation:** Real-world facts mix shared structure (absorbed by cortex relatively quickly) with idiosyncratic details (requiring more HC replays; lost if HC decay outpaces consolidation). Memory becomes schematic over time because structure is durable while arbitrary detail is not.

## Limitations

- Networks are simple (no CA3, no DG pattern separation); biological mechanisms are a "black box" trace.
- Two-compartment retrograde amnesia model is a parameterized fit, not a mechanistic derivation.
- Predates modern deep learning; catastrophic interference in overparameterized networks behaves differently.

## Links

- [[wiki/concepts/two-learning-timescales.md]] — catastrophic interference is the formal derivation of why two timescales are necessary
- [[wiki/concepts/replay.md]] — interleaved HC replay is the biological mechanism delivering the diverse stream cortex needs for slow learning
- [[wiki/concepts/structural-generalization.md]] — interleaved training = mechanism by which slow-W avoids catastrophic interference while extracting shared structure
- [[wiki/concepts/compositional-generalization.md]] — MLC episodic meta-training is the computational analog of interleaved HC replay
