---
title: "ARC Prize 2025 Technical Report — Chollet, Knoop, Kamradt & Landers 2026"
type: paper
tags: [ARC-AGI, benchmark, refinement-loop, test-time-training, evolutionary-program-synthesis, fluid-intelligence, knowledge-boundedness]
created: 2026-06-23
updated: 2026-06-23
sources: [ARC Prize 2025 Technical Report.md]
related: [wiki/entities/arc-agi.md, wiki/concepts/refinement-loops.md, wiki/concepts/meta-learning.md, wiki/concepts/information-theory.md, wiki/papers/arc-agi-3-paper.md, wiki/papers/arc-agi-overview.md]
---

# ARC Prize 2025 Technical Report — Chollet, Knoop, Kamradt & Landers 2026

**Citation:** Chollet, F., Knoop, M., Kamradt, G., & Landers, B. (2026). ARC Prize 2025: Technical Report. arXiv:2601.10904.

---

## Key Computational Insights

- **Refinement loop as 2025's defining paradigm:** All top-performing ARC-AGI-2 solutions implement a generate-verify-refine cycle. The loop operates in four distinct spaces: (1) weight space via test-time training, (2) weight space from scratch (zero-pretraining), (3) symbolic/NL program space via evolutionary synthesis, (4) natural language program space via application-layer CoT (Chain of Thought) harnesses. The unifying structure — not the implementation space — is what makes these approaches converge [[wiki/concepts/refinement-loops.md]].

- **Zero-pretraining deep learning achieves competitive performance with tiny networks:** TRM (Jolicoeur-Martineau, Paper Award 1st): 7M parameters, no pretraining, trains from scratch at test time on task examples only → 45% ARC-AGI-1, 8% ARC-AGI-2. CompressARC (Liao & Gu, Paper Award 3rd): 76K parameters, MDL-based (minimizes VAE loss with decoder regularization as a substitute for combinatorial search) → 20% ARC-AGI-1, 4% ARC-AGI-2 in ~20 minutes/puzzle on a single GPU. These results establish that per-task optimization from a random initialization can rival large pretrained models, suggesting the bottleneck for ARC-AGI is the quality of the refinement loop, not the scale of pretraining.

- **ARC-AGI-2 state-of-the-art and top methods:** Best Kaggle score: 24.03% (NVARC: builds on 2024's test-time training winner + heavy synthetic data generation). 2nd: 16.53% (ARChitects: masked-diffusion LM with recursive self-refinement and perspective-based scoring). 3rd: 12.64% (MindsAI: test-time fine-tuning + augmentation ensembles + tokenizer dropout + novel pretraining). Human performance: ~84%. Gap remains large; scale alone does not close it.

- **Application-layer harnesses significantly boost commercial models:** Gemini 3 Pro without harness: 31% at $0.81/task. Gemini 3 Pro with refinement harness (Poetiq): 54% at $31/task. Claude Opus 4.5 with same harness: comparable accuracy to Gemini 3 Pro at ~$60/task. Critical dependency: harnesses require a task-level verifier (exact grid match). Where a verifier exists, iterative application-layer refinement is currently the highest-leverage engineering lever on commercial models.

- **Knowledge-dependent reasoning ceiling confirmed with contamination evidence:** ARC-AGI reasoning performance tracks pretraining knowledge coverage, not architectural capacity. Evidence: Gemini 3 Deep Think uses correct ARC integer-to-color mappings in reasoning chains without being given any ARC-specific context in the prompt — a fingerprint of benchmark task formats in pretraining data. Extends the LRM (Large Reasoning Model) knowledge-boundedness argument ([[wiki/papers/arc-agi-3-paper.md]]) with a concrete contamination detection method.

---

## Limitations

- Survey paper covering competition results; primary technical details of individual methods remain in the cited papers and open-source repositories.
- Cannot precisely quantify the magnitude of knowledge contamination's contribution to high scores vs. genuine capability improvement.
- ARC-AGI-2 private evaluation set (120 tasks) is smaller than ARC-AGI-1 (400 tasks); variance in scores is correspondingly higher.

---

## Links

- **[[wiki/entities/arc-agi.md]]** — entity page with full benchmark version table; updated with ARC-AGI-2 competition results and harness numbers from this report
- **[[wiki/concepts/refinement-loops.md]]** — new concept page derived from this report's central theme; ML taxonomy of the four refinement loop types
- **[[wiki/concepts/meta-learning.md]]** — refinement loops are a new fast-inner-loop instantiation; zero-pretraining result is the strongest evidence yet that fast-loop test-time optimization can substitute for large slow-loop pretraining on verifiable tasks
- **[[wiki/concepts/information-theory.md]]** — CompressARC's MDL principle (minimize description length of each puzzle) connects to the Solomonoff predictor ceiling; VAE loss as a differentiable proxy for Kolmogorov complexity
- **[[wiki/papers/arc-agi-3-paper.md]]** — companion: formalizes LRM (Large Reasoning Model) knowledge-boundedness theorem and documents ARC-AGI-3 design; this report provides the 2025 empirical support for that theorem
