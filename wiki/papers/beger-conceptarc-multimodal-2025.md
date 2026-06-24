---
title: "Do AI Models Perform Human-like Abstract Reasoning Across Modalities?"
type: paper
tags: [ARC, abstract-reasoning, shortcut-learning, multimodal, visual-reasoning, benchmark-evaluation]
created: 2026-06-24
updated: 2026-06-24
sources: [beger-conceptarc-multimodal-2025]
related: [wiki/entities/arc-agi.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/shortcut-reasoning.md, wiki/papers/conceptarc-moskvichev-2023.md, wiki/papers/shortcut-learning-geirhos-2020.md, wiki/papers/shortcut-suite-yuan-2024.md]
---

# Do AI Models Perform Human-like Abstract Reasoning Across Modalities?

**Citation:** Beger C., Yi R., Fu S., Denton K., Moskvichev A., Tsai S., Rajamanickam S. & Mitchell M. arXiv:2510.02125, 2025.

---

- **Accuracy ≠ abstraction — dual-channel evaluation required** — Beyond output-grid accuracy, models are asked to generate a natural-language rule explaining each solution. Rule-grid alignment exceeds 90% across all models and settings, validating NL rules as faithful proxies for underlying reasoning. This dual-channel methodology reveals that accuracy alone overestimates abstract reasoning capability in textual modality and underestimates it in visual modality — two directional errors that cancel out if only accuracy is reported.

- **AI shortcuts ~27–29% of correct textual solutions; humans only ~5%** — On ConceptARC textual tasks, o3 (medium effort + tools) produces correct-intended rules in 57% of cases; correct-unintended (shortcut) rules in 29%; humans: 90.3% correct-intended, 4.6% correct-unintended. AI models exploit integer color encodings, bounding-box overlap, 4/8-connectivity, and density heuristics — a "general-purpose shortcut toolbox" not specific to any concept group. The rate is worst on TopBottom3D (70.6% shortcut of correct rules) and CleanUp (52.3%).

- **Missing objectness prior** — Across all concept groups and modalities, models struggle to represent discrete objects as coherent bounded entities. Instead they apply local, pixel-level, or geometric heuristics. This is most visible in CleanUp tasks (requiring full grid reproduction after removal) and TopBottom3D (requiring 3D stacking inference), where shortcuts dominate even when other approaches fail.

- **Visual modality gap is perceptual, not conceptual** — AI visual accuracy drops to 5–29% (vs. 60–77% textual; human: 73% textual, ~91% ConceptARC), but in wrong-grid visual cases o3 still produces correct-intended rules ~28% of the time. Visual errors (wrong grid size, misplaced objects, incorrect color mappings) occur in ~49–77% of visual cases. Python tools partially compensate by enabling computer-vision libraries for grid parsing — the primary benefit of tool access in visual modality.

- **Test-time compute scaling is modality-specific** — In textual modality, increased reasoning effort improves both accuracy and rule correctness. In visual modality, more reasoning tokens alone have no significant effect; Python tool access is the effective lever. This dissociation suggests that test-time reasoning budgets are useful only when the bottleneck is reasoning, not perception.

**Limitations:** ConceptARC only (ARC-1/2 may be more shortcut-resistant; untested). No high-effort o3 condition. Manual rule classification introduces subjectivity. Pass@1 only. Human rule data incomplete (no rules collected for incorrect outputs).

---

- **[[wiki/entities/arc-agi.md]]** — ConceptARC is the ARC derivative used here; findings extend the error-type dissociation (near-miss vs. concept-failure) with rule-quality evidence and add modality × reasoning-effort interaction as a new diagnostic dimension.
- **[[wiki/concepts/abstract-reasoning.md]]** — dual-channel evaluation (accuracy + rule quality) is the operationalization of the pattern-recognition/model-building distinction at rule granularity; objectness prior identified as a specific missing ingredient.
- **[[wiki/concepts/shortcut-reasoning.md]]** — provides the ARC-domain shortcut catalogue and evidence that AI uses a domain-general shortcut toolbox (integer encodings, bounding boxes, connectivity, density) instead of concept-level abstractions.
- **[[wiki/papers/conceptarc-moskvichev-2023.md]]** — builds directly on ConceptARC; adds rule-level evaluation on top of original near-miss/concept-failure distinction; uses same human rule data from Moskvichev et al. study.
- **[[wiki/papers/shortcut-learning-geirhos-2020.md]]** — Geirhos 2020 provides the i.i.d./o.o.d. taxonomy; this paper instantiates it at the ARC concept level, showing that "correct-unintended" rules are precisely shortcut solutions that pass i.i.d. within a task but would fail across concept variations.
