---
title: "ARC-AGI-2: A New Challenge for Frontier AI Reasoning Systems"
type: paper
tags: [ARC-AGI, benchmark, compositional-generalization, human-calibration, abstract-reasoning]
created: 2026-06-24
updated: 2026-07-02
sources: [ARC-AGI-2 A New Challenge for Frontier AI Reasoning Systems.md]
related: [wiki/entities/arc-agi.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md]
---

# ARC-AGI-2: A New Challenge for Frontier AI Reasoning Systems

Chollet, Kamradt, Knoop — ARC Prize Foundation, 2025. Design paper and launch report for ARC-AGI-2.

---

**Key computational insights:**

- **Compositional generalization as core design principle:** ARC-AGI-2 tasks require multi-rule, multi-step, and contextual reasoning where later steps depend on prior execution; in-context symbol definition tasks (roles assigned by context, not appearance) specifically target the failure modes of frontier reasoning models.
- **Human calibration methodology:** 407 participants, 13,405 task attempts, 62% overall solve rate, 2.7 min average (2.3 min median) completion time; solve rate shows no correlation with demographic factors (age, education, domain background), validating Core Knowledge tasks as measuring reasoning rather than domain skill.
- **Brute-force resistance by design:** tasks use larger grids, more objects, and higher information content per task to resist exhaustive program search — explicitly addressing the ~49% of ARC-AGI-1 that was solvable by 2020 brute-force methods.
- **Unified difficulty distribution:** public/semi-private/private splits calibrated to within ±1% mean human accuracy, preventing ARC-AGI-1's inconsistent split difficulty and reducing leaderboard overfitting incentives.
- **SOTA collapse as empirical validation:** o3-mini (high) fell from 34.5% (ARC-AGI-1) to 3.0% (ARC-AGI-2); ARChitects champion method collapsed from 56% to 2.5% — ~20-fold drop confirms ARC-AGI-1 was near saturation for the methods available in 2024. (Both are the benchmark's early-2025 launch state; by end-2025 the verified frontier had risen to 24% open Kaggle / 54% audited harness, with closed labs self-reporting ≤85% — see [[wiki/papers/arc-prize-2025-technical-report.md]].)

**Limitations:** human calibration treats accuracy as the only behavioral measure; Beger et al. 2025 subsequently showed that rule-quality evaluation (not just accuracy) is necessary to distinguish genuine abstraction from shortcuts.

**Links:** [[wiki/entities/arc-agi.md]] — version history, capability gaps taxonomy, and ARC-AGI-2 competition results; [[wiki/concepts/compositional-generalization.md]] — the target capability ARC-AGI-2 is designed to test.
