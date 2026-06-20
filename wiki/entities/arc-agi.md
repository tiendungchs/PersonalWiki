---
title: "ARC-AGI"
type: entity
tags: [ARC-AGI, benchmark, abstract-reasoning, fluid-intelligence, compositional-generalization, few-shot, test-time-reasoning]
created: 2026-06-19
updated: 2026-06-20
sources: [ARC-AGI-1.md, ARC-AGI-2.md, ARC-AGI-3.md, What is ARC-AGI.md, ARC-AGI-3-paper.md]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/meta-learning.md, wiki/concepts/abstract-reasoning.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/entities/tiwm-model.md, wiki/entities/mlc-model.md, wiki/papers/arc-agi-overview.md, wiki/papers/arc-agi-3-paper.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md]
---

# ARC-AGI

Benchmark suite for fluid intelligence: skill-acquisition efficiency on novel tasks given only core knowledge priors. The primary external validation target for brain-inspired abstract reasoning architectures.

**Formal definition (Chollet 2019):**
> Intelligence = skill-acquisition efficiency over a scope of tasks, with respect to priors, experience, and generalization difficulty.

---

## Benchmark Versions

| Version | Year | Challenge target | Format | SOTA vs. human |
|---|---|---|---|---|
| **ARC-AGI-1** | 2019 | Base LLMs / scale | 800 static grid puzzles; ~3 few-shot examples | o3: 87% (high compute); human: ~84% — **solved** |
| **ARC-AGI-2** | 2025 | Reasoning models / efficiency | 1000 training + 360 eval tasks; cost efficiency metric | AI: ~4%; human: ~84% — **unsolved** |
| **ARC-AGI-3** | 2026 | Agentic intelligence (full loop) | 135 interactive environments; RHAE action-efficiency scoring | AI: <1% (Opus 4.6: 0.50%); human: 100% — **open** |

---

## Core Knowledge Priors

ARC-AGI restricts to four universally accessible cognitive primitives (Spelke's Core Knowledge theory). Tasks assume no knowledge beyond these:

| Prior | Content |
|---|---|
| **Objectness** | Objects persist, move coherently, have boundaries |
| **Numbers / counting** | Small exact numerosities; more/less relations |
| **Geometry / spatial relations** | Symmetry, rotation, translation, scaling, containment |
| **Agency / intentionality** | Goal-directed agents act to achieve outcomes |

Any reasoning model using richer priors conflates developer pre-encoding with system intelligence. The prior budget is the fairness criterion for human-AI comparison.

---

## ARC-AGI-2 Capability Gaps

ARC-AGI-2 was designed to diagnose three specific failure modes of current reasoning models:

| Capability gap | What systems fail to do | Building block target |
|---|---|---|
| **Symbolic interpretation** | Assign semantic meaning to symbols beyond visual appearance; recognize that a shape *plays a role in context*, not just what it looks like | Block 3A (Transformation Inferrer) |
| **Compositional reasoning** | Apply multiple interacting rules simultaneously; single-global-rule tasks succeed, multi-rule compositions fail | Block 3C (Hierarchical grammar stack) |
| **Contextual rule application** | Apply the same rule differently depending on context; systems fixate on surface patterns rather than context-gated selection | Block 3B (WM context maintenance) |

**Scale is not enough.** Log-linear scaling of training compute is insufficient to close ARC-AGI-2. New test-time adaptation methods or novel architectures are required.

---

## LRM Knowledge-Boundedness

ARC-AGI-3 formalizes a structural constraint on current AI reasoning capability:

> LRMs can automate any domain where (1) base model training has domain knowledge coverage AND (2) an exact correctness verifier exists. Human reasoning has neither constraint.

This explains why test-time reasoning (the o3 breakthrough that solved ARC-AGI-1) does not transfer to genuinely novel domains: the fast inner loop adapts only within the pretraining distribution envelope. ARC-AGI-3 violates both conditions simultaneously — novel mechanics absent from any training corpus, no in-loop verifier — which is the mechanism behind <1% frontier AI vs. 100% human.

This is not "jagged intelligence" (inconsistency) but a principled structural limit: LRM capability is consistently and predictably bounded by training knowledge coverage, explaining why frontier models automate verifiable domains (coding, math) while failing on truly novel environments.

---

## Benchmark Contamination

ARC-AGI-1 and ARC-AGI-2 were likely compromised by a synthetic-coverage attack:
1. Prompt a model to generate ARC-format tasks.
2. Verify solutions using the exact-grid-match verifier (ARC tasks are verifiable).
3. Train on verified reasoning traces in a loop.
4. Scale to millions of synthetic tasks until the task space is densely covered.

**Evidence:** Gemini 3 Deep Think uses the correct ARC integer-to-color mapping in its reasoning chain without the prompt mentioning "ARC-AGI" or the color convention — a fingerprint of benchmark data in training distribution.

**ARC-AGI-3 mitigations:**
- Private set intentionally OOD from public set (not identically distributed)
- Inverted public/private ratio: 25 public vs. 110 private (ARC-AGI-2 was ~10:1 public-heavy)
- RHAE power-law scoring penalizes brute-force: 10× human actions = 1% score
- Official leaderboard restricted to general-purpose APIs with no task-specific harness preparation

---

## ARC-AGI-3: Agentic Intelligence

Shifts from static rule-inference to **interactive turn-based environments** where the agent must acquire all information through action. Four functional pillars evaluated:

| Pillar | What is required | Why it's new vs. ARC-AGI-2 |
|---|---|---|
| **Exploration** | Actively gather information; passive observation is insufficient | ARC-AGI-2 provides all examples upfront |
| **Modeling** | Build a generalizable world model predicting future states from observations | Inherited from prior generations |
| **Goal-Setting** | Autonomously infer win conditions — **agent is never told the objective or given instructions** | First ARC-AGI benchmark requiring autonomous objective inference |
| **Planning / Execution** | Multi-step action sequences with course-correction; no "correct action" is ever specified | Sequential planning, not single-step rule application |

**The critical novel dimension is Goal-Setting.** System prompt: *"You are playing a game. Your goal is to win."* — nothing else. The agent must determine what winning means by interacting with the environment, probing the ability to handle "unknown unknowns."

**RHAE scoring:** Per-level score = (h_{l,e}/a_{l,e})². Levels weighted linearly within environments (later levels contribute more). Per-environment cap limits maximum score to weighted fraction of levels completed — completing more levels is always rewarded over high efficiency on few. Power-law squaring: 10× human action count = 1% credit (not 10%).

**Environment format:** 64×64 grid, 16 colors, turn-based. 135 total environments: 25 public, 55 semi-private, 55 fully private. Private set is OOD from public set — inverted ratio vs. ARC-AGI-2's 10:1 public/private.

**Launch results (April 2026):** Humans: 100% solvable (verified ≥2 independent humans per environment). Frontier AI: Opus 4.6 0.50%, Gemini 3.1 Pro 0.40%, GPT-5.4 0.20%, Grok-4.20 0.10%.

Maps to the complete building-blocks architecture: Block 3D (goal generator from feedback) + Block 3B (episodic WM across steps) + Block 3A (transformation inference from state transitions) + Block 2A/2B (fast world-model binding and completion).

---

## Key Results

- **Scale vs. adaptation:** ARC-AGI-1 resisted 50,000× LLM scale-up (2019–2024); o3 solved it via test-time reasoning — empirically separating pre-training scale from in-context adaptation as the lever for fluid intelligence.
- **Efficiency criterion:** brute-force search could solve ARC-AGI given unlimited compute; this would not constitute intelligence. Intelligence = solving at human-comparable efficiency.
- **Human baseline:** All ARC-AGI-2 eval tasks solved by ≥2 humans in ≤2 attempts; calibrated IDD across public/semi-private/private splits.
- **ARC-AGI-3 launch gap:** All 135 environments human-solvable (100%, verified ≥2 independent humans); frontier AI <1% without task-specific harnesses (best: Opus 4.6 0.50%); best agent competition result (StochasticGoose, CNN+RL, preview set): 12.58% via informed action-space search rather than world-model planning. Harness-based systems: near-human on environments the harness was built for, 0% on unseen — confirming harness scores measure task-specific optimization, not general intelligence.

---

## Limitations

- Grid-based format imposes a visuo-spatial prior beyond the four Core Knowledge claims; may systematically advantage spatial-reasoning systems.
- ARC-AGI-1 is now solved; relevant mainly as historical comparator and for methods that pre-date o3.
- ARC-AGI-1 and ARC-AGI-2 appear to have been compromised by synthetic-task coverage attacks (see Benchmark Contamination section); the OOD private-set design of ARC-AGI-3 is the proposed countermeasure, but its long-term resistance remains to be validated as model capabilities advance.
- <1% frontier AI performance on ARC-AGI-3 makes it hard to diagnose which of the four pillars is the primary bottleneck; the benchmark currently lacks intermediate difficulty scaffolding for capability decomposition.

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — ARC-AGI is the primary empirical target: tasks require inferring a transformation rule and applying it to new content, demanding factorized g/x/p representations; ARC-AGI-2's three capability gaps operationalise what structural generalization gaps remain after o3.
- **[[wiki/concepts/compositional-generalization.md]]** — ARC-AGI-2 compositional reasoning gap = systematicity and localism failure from Hupkes 2020; contextual rule application gap = structural generalization under WM-gated context; together they identify the specific facet binding constraint that prevents current systems from reaching 85% on ARC-AGI-2.
- **[[wiki/concepts/meta-learning.md]]** — ARC-AGI-1's o3 solution empirically validates test-time adaptation (fast inner loop) over pre-training scale (slow outer loop) as the lever for fluid intelligence; MLC achieves human-level on compositional grammar but does not transfer to ARC-AGI grid tasks.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — ARC-AGI-2 three gaps map directly to Blocks 3A/3B/3C; ARC-AGI-3 adds Block 3D; the benchmark is the external validation target for the full 11-block decomposition.
- **[[wiki/entities/tiwm-model.md]]** — TIWM was designed for ARC-AGI Type 2 tasks; Block 3A (Transformation Inferrer) directly targets the symbolic interpretation and contextual rule application gaps in ARC-AGI-2.
- **[[wiki/concepts/latent-graph-discovery.md]]** — ARC-AGI is the primary empirical instantiation of latent edge discovery: nodes = grid states, edges = unknown transformation rules, tasks test inference from sparse (before, after) pairs; ARC-AGI-3 additionally makes the target node latent (autonomous goal inference).
- **[[wiki/entities/mlc-model.md]]** — MLC achieves 92.9–96.8% on compositional grammar few-shot tasks in language but has not been shown to transfer to ARC-AGI's visuo-spatial grid domain; MLC demonstrates the training-objective solution (episodic meta-learning) but ARC-AGI-2 requires additional architectural capabilities.
- **[[wiki/concepts/abstract-reasoning.md]]** — ARC-AGI is the primary operational benchmark for abstract reasoning; the efficiency criterion (skill-acquisition per unit experience) operationalizes the pattern recognition / model-building distinction — pattern matchers hit scale ceilings, model-builders adapt within the episode.
- **[[wiki/papers/building-machine-thinks-like-people-lake-2016.md]]** — Lake et al. 2016 provides the motivational framing that ARC-AGI operationalizes: the Frostbite challenge (924h vs. 15 minutes) is the precursor diagnostic that Chollet formalized into ARC-AGI's efficiency-based intelligence definition.
- **[[wiki/papers/arc-agi-3-paper.md]]** — primary technical paper for ARC-AGI-3; documents four-pillar agentic decomposition, RHAE scoring, human calibration (486 participants, 414 environments), LRM knowledge-boundedness theorem, benchmark contamination analysis, and launch results.
