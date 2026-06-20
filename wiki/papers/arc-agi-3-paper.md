---
title: "ARC-AGI-3: A New Challenge for Frontier Agentic Intelligence"
type: paper
tags: [ARC-AGI, benchmark, agentic-intelligence, fluid-intelligence, abstract-reasoning, action-efficiency]
created: 2026-06-20
updated: 2026-06-20
sources: [ARC-AGI-3-paper.md]
related: [wiki/entities/arc-agi.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/meta-learning.md, wiki/papers/arc-agi-overview.md]
---

# ARC-AGI-3: A New Challenge for Frontier Agentic Intelligence

**ARC Prize Foundation, April 2026.** Introduces the interactive ARC-AGI-3 benchmark and its RHAE scoring framework. Primary source for ARC-AGI-3 design, human calibration, launch results, LRM knowledge-boundedness argument, and benchmark contamination analysis.

---

## Key Computational Insights

- **RHAE (Relative Human Action Efficiency) scoring:** Per-level score = (h_{l,e}/a_{l,e})², where h is the upper-median human action count and a is the AI action count. Squared penalty makes 10× human action count yield 1% credit (not 10%), discriminating near-human from brute-force more sharply than a linear formulation. Levels weighted linearly within each environment (level l contributes l/Σl of environment score, so later levels matter more). Per-environment cap = weighted fraction of levels completed, so completing more levels is always rewarded; high efficiency on a few levels cannot substitute for breadth. Inspired by the robotics SPL (Success weighted by Path Length) metric.

- **Four-pillar agentic decomposition — Goal-Setting as the critical gap:** Exploration (actively gather information), Modeling (build a generalizable world model from observations), Goal-Setting (autonomously infer win conditions — **the agent is never told the objective or given instructions**), Planning/Execution (multi-step action sequences with course-correction). The minimal system prompt is literally "You are playing a game. Your goal is to win." The agent must determine what winning means by interacting with the environment. This is the first ARC-AGI benchmark to require autonomous objective inference, probing the ability to handle "unknown unknowns."

- **LRM knowledge-boundedness — structural constraint on test-time reasoning:** LRMs can automate a domain only when (a) base model training has domain knowledge coverage AND (b) an exact correctness verifier exists. Human reasoning has neither constraint. This is not "jagged AI" (inconsistency) but a structural prediction: test-time reasoning (the ARC-AGI-1 breakthrough via o3) scales only within the pretraining distribution envelope. ARC-AGI-3 environments have novel mechanics absent from any training corpus and no in-loop verifier — both conditions violated simultaneously, which is the mechanism behind the <1% frontier AI score.

- **Benchmark contamination mechanism and ARC-AGI-3 response:** Static benchmarks with shared public/private distributions are attackable via: generate synthetic tasks → verify solutions via the task verifier → train on reasoning traces → repeat at scale. This can densely cover the benchmark's task space without generalization. Evidence: Gemini 3 Deep Think uses the correct ARC integer-to-color mapping in its reasoning chain without the prompt ever mentioning "ARC-AGI" or the color convention — a fingerprint of benchmark data in training distribution. ARC-AGI-3 mitigations: OOD private set (intentionally out-of-distribution from public set), inverted public/private ratio (25 public vs. 110 private, reversing ARC-AGI-2's 10:1 ratio), and official leaderboard restricted to general-purpose API calls with no task-specific harness preparation.

- **Launch gap — humans 100%, frontier AI <1%:** All 135 environments verified solvable by ≥2 independent untrained humans (April 2026). Frontier model scores on semi-private set: Anthropic Opus 4.6 (Max) 0.50%, Google Gemini 3.1 Pro Preview 0.40%, OpenAI GPT-5.4 (High) 0.20%, xAI Grok-4.20 0.10%. Best agent competition result (preview set): StochasticGoose, CNN+RL, 12.58% — via informed action-space search rather than model-based planning. Harness-based approaches show bimodal performance: near-human on environments the harness was designed for, 0% on unseen environments — confirming harness scores measure task-specific optimization, not general intelligence.

---

## Limitations

- 64×64 grid format with 16 colors remains a visuo-spatial prior beyond the stated Core Knowledge budget; spatial-reasoning systems may be systematically advantaged.
- RHAE conflates exploration cost and execution cost in a single efficiency scalar; a system that explores efficiently but executes slowly cannot be distinguished from the reverse.
- <1% frontier AI performance limits diagnostic iteration: the benchmark does not yet reveal which of the four pillars is the primary bottleneck for current systems.

---

## Links

- **[[wiki/entities/arc-agi.md]]** — entity page with benchmark version table, full ARC-AGI-3 pillar breakdown, RHAE scoring summary, and connections to building-blocks decomposition
- **[[wiki/concepts/abstract-reasoning.md]]** — Goal-Setting pillar extends the Lake et al. 2016 three-ingredient model with autonomous objective inference as a fourth required capability
- **[[wiki/concepts/meta-learning.md]]** — LRM knowledge-boundedness argument reframes the efficiency-dependency open problem: fast inner loop cannot generalize beyond training distribution coverage
- **[[wiki/papers/arc-agi-overview.md]]** — prior overview paper covering ARC-AGI-1/2 in detail; this paper is the authoritative technical document for ARC-AGI-3 design and scoring
