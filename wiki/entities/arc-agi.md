---
title: "ARC-AGI"
type: entity
tags: [ARC-AGI, benchmark, abstract-reasoning, fluid-intelligence, compositional-generalization, few-shot, test-time-reasoning]
created: 2026-06-19
updated: 2026-07-08
sources: [ARC-AGI-1.md, ARC-AGI-2.md, ARC-AGI-3.md, What is ARC-AGI.md, ARC-AGI-3-paper.md, The ConceptARC Benchmark, ARC Prize 2025 Technical Report.md, choi-intelligence-density-2026, beger-conceptarc-multimodal-2025, ARC Prize 2024 Technical Report.md, ARC-AGI-2 A New Challenge for Frontier AI Reasoning Systems.md, Understanding and Benchmarking Artificial Intelligence o3 of OpenAI Is Not AGI.md, ARC Prize 2026 overview.md, ARC Prize 2026 rules.md, ARC Prize 2026 data.md, ARC Prize 2026 leaderboard.md, ARC-AGI v2 Leaderboard.md]
related: [wiki/concepts/core-knowledge.md, wiki/papers/spelke-kinzler-core-knowledge-2007.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/meta-learning.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/refinement-loops.md, wiki/concepts/shortcut-reasoning.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/entities/mlc-model.md, wiki/entities/frontiermath-benchmark.md, wiki/papers/arc-agi-overview.md, wiki/papers/arc-agi-3-paper.md, wiki/papers/arc-prize-2025-technical-report.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md, wiki/papers/conceptarc-moskvichev-2023.md, wiki/papers/shortcut-learning-geirhos-2020.md, wiki/papers/choi-intelligence-density-2026.md, wiki/papers/beger-conceptarc-multimodal-2025.md, wiki/papers/arc-prize-2024-technical-report.md, wiki/papers/arc-agi-2-paper.md, wiki/papers/o3-not-agi.md, wiki/entities/baba-is-ai.md]
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
| **ARC-AGI-2** | 2025 | Reasoning models / efficiency | 1000 training + 360 eval tasks; cost efficiency metric | AI (verified/reproducible): 24% open Kaggle · 54% audited harness ($31/task); frontier labs self-report ≤85% (closed, unverified); human: ~84% — **efficiency gap open** |
| **ARC-AGI-3** | 2026 | Agentic intelligence (full loop) | 135 interactive environments; RHAE action-efficiency scoring | AI: <1% (Opus 4.6: 0.50%); human: 100% — **open** |

---

## Core Knowledge Priors

ARC-AGI restricts to four universally accessible cognitive primitives (Spelke's Core Knowledge theory; [[wiki/concepts/core-knowledge.md]], [[wiki/papers/spelke-kinzler-core-knowledge-2007.md]]). Tasks assume no knowledge beyond these:

| Prior | Content |
|---|---|
| **Objectness** | Objects persist, move coherently, have boundaries |
| **Numbers / counting** | Small exact numerosities; more/less relations |
| **Geometry / spatial relations** | Symmetry, rotation, translation, scaling, containment |
| **Agency / intentionality** | Goal-directed agents act to achieve outcomes |

Any reasoning model using richer priors conflates developer pre-encoding with system intelligence. The prior budget is the fairness criterion for human-AI comparison.

---

## ConceptARC: Concept-Level Diagnostic

ConceptARC (Moskvichev et al. 2023 [[wiki/papers/conceptarc-moskvichev-2023.md]]) decomposes the Core Knowledge vocabulary into 16 independently testable concept groups (10 tasks × 3 test inputs = 30 evaluation points each). High performance across all 30 variations within a group is the evidence standard for genuine concept abstraction rather than task-specific shortcut.

**16 concept groups (organized by prior):**

| Prior | Concepts |
|---|---|
| **Objectness** | Copy, Extract Objects, Clean Up, Complete Shape, Move to Boundary |
| **Numerosity** | Count, Order |
| **Geometry / topology** | Above/Below, Center, Extend to Boundary, Filled/Not Filled, Horizontal/Vertical, Inside/Outside, Same/Different, Top/Bottom 2D, Top/Bottom 3D |

**Performance across concept groups:**

| Solver | Accuracy range | Concepts >80% |
|---|---|---|
| Humans | 83–97% | 16 / 16 |
| ARC-Kaggle 1st place | 23–77% | 0 / 16 |
| ARC-Kaggle 2nd place | 3–57% | 0 / 16 |
| GPT-4 | 3–33% | 0 / 16 |

**Error type dissociation:** Human errors are *near-misses* (concept grasped, execution wrong). Machine errors indicate the concept was not grasped — outputs are not interpretable as rule applications. This qualitative distinction cannot be captured by accuracy alone and is the behavioral marker distinguishing model-building from pattern matching.

**Concept-level difficulty profile:** highest program scores on spatial-relational concepts (Extend to Boundary 77%, Filled/Not Filled 73%, Count 60%); lowest on compositional transformation concepts (Copy 23%, Order 27%, Move to Boundary 37%) — confirming that spatial heuristics are easier to program than abstract operation generalization.

**Rule-level evaluation (Beger et al. 2025)** extends the near-miss/concept-failure dissociation to frontier models by requiring both an output grid *and* a natural-language rule per task. Rule-grid alignment exceeds 90%, validating NL rules as faithful reasoning proxies.

*Modality × accuracy results (ConceptARC, best setting = medium effort + Python tools):*

| Model | Textual accuracy | Visual accuracy | Human (textual ref.) |
|---|---|---|---|
| o3 | 75.6% | **29.2%** | ~73% (pass@1) |
| o4-mini | 77.7% | 25.0% | — |
| Gemini 2.5 Pro | 60.4% | 5.8% | — |
| Claude Sonnet 4 | 55.0% | 6.9% | — |

*Shortcut rate (correct-unintended rules as % of correct outputs, textual):* o3 ~29%, Gemini ~22%, Claude ~5%; humans ~4.6%.

*Visual gap mechanism:* models form correct-intended rules in ~28% of wrong-grid visual cases (o3) — the bottleneck is perceptual (grid dimension recognition, object placement) not conceptual. Python tools compensate by enabling computer-vision libraries; more reasoning tokens alone have no significant visual effect.

*Missing objectness prior:* models systematically lack Spelke's objectness prior, defaulting to pixel/color/connectivity shortcuts — see [[wiki/concepts/shortcut-reasoning.md]].

---

## ARC-AGI-2 Competition Results (2025)

Top Kaggle score: **24.03%** (NVARC), human: ~84%. All top entries exploit refinement loops [[wiki/concepts/refinement-loops.md]].

| Place | Team | Score | Core method |
|---|---|---|---|
| 1st | NVARC | 24.03% | Test-time training (extends 2024 winner) + heavy synthetic data generation |
| 2nd | ARChitects | 16.53% | Masked-diffusion LM with 2D spatial awareness + recursive self-refinement |
| 3rd | MindsAI | 12.64% | TTT (Test-Time Training)pipeline: augmentation ensembles + tokenizer dropout + novel pretraining |

**Paper award highlights:**
- **TRM (Jolicoeur-Martineau):** 7M-parameter network, no pretraining, trains from scratch at test time → 45% ARC-AGI-1, 8% ARC-AGI-2. Recursive latent-answer architecture updates a hidden state z and answer y iteratively.
- **CompressARC (Liao & Gu):** 76K parameters, MDL-based (minimizes description length of each puzzle via VAE loss) → 20% ARC-AGI-1, 4% ARC-AGI-2 in ~20 minutes/puzzle on a single GPU.
- **SOAR (Pourcel, Colas, Oudeyer):** self-improving evolutionary program synthesis, fine-tunes LLM on its own search traces, improves ARC-AGI-1 performance by up to 52%.

**Application-layer harnesses on commercial models (ARC-Prize-verified):**
- Gemini 3 Pro: 31% ($0.81/task) → 54% ($31/task) with refinement harness.
- Claude Opus 4.5: comparable accuracy to Gemini 3 Pro at ~$60/task.
- Key dependency: harnesses require a task-level verifier (exact grid match).

**Frontier model self-reports (unverified):** public leaderboards (llm-stats, Jul 2026) list closed models far above the verified competition frontier — GPT-5.5 85.0%, Gemini 3.1 Pro 77.1%, GPT-5.4 73.3%, Claude Opus 4.6 68.8%, Claude Sonnet 4.6 58.3%; older systems sit near the verified range (o3 6.5%, Grok-4 15.9%). These are **self-reported on closed-source models with no reproducible harness or independent audit** — burden of proof is on the labs; treat as unconfirmed until model + data are released. The ARC Prize's own verified frontier is 24% (open Kaggle) to 54% (audited harness), and it flags that high closed-model scores may partly reflect knowledge coverage on the shared public/private distribution.

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

## LRM (Large Reasoning Model) Knowledge-Boundedness

ARC-AGI-3 formalizes a structural constraint on current AI reasoning capability:

> LRMs can automate any domain where (1) base model training has domain knowledge coverage AND (2) an exact correctness verifier exists. Human reasoning has neither constraint.

This explains why test-time reasoning (the o3 breakthrough that solved ARC-AGI-1) does not transfer to genuinely novel domains: the fast inner loop adapts only within the pretraining distribution envelope. ARC-AGI-3 violates both conditions simultaneously — novel mechanics absent from any training corpus, no in-loop verifier — which is the mechanism behind <1% frontier AI vs. 100% human.

This is not "jagged intelligence" (inconsistency) but a principled structural limit: LRM (Large Reasoning Model) capability is consistently and predictably bounded by training knowledge coverage, explaining why frontier models automate verifiable domains (coding, math) while failing on truly novel environments.

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

## ARC Prize 2026 Competition (Kaggle ARC-AGI-3)

Featured code competition running the ARC-AGI-3 benchmark. Timeline: start 2026-03-25 → milestone 1 2026-06-30, milestone 2 2026-09-30 → entry/merger deadline 2026-10-26 → final submission 2026-11-02 → winners 2026-12-04. **$850K total:** $150K progress ($75K final leaderboard + $75K over two milestone checkpoints) + **$700K bonus, unlocked only if a team reaches 100% accuracy** (split among the top-5 100%-scorers). Winning system, model, and weights must be open-sourced (CC-BY 4.0 / OSI open-source-AI checklist).

**Interaction protocol:** agent receives JSON **frames** (grid state + metadata), replies with actions; each game has multiple **levels**; state ∈ {`NOT_FINISHED`, `WIN`, `GAME_OVER`}. Action vocabulary (≤7): `RESET`; `ACTION1`–`ACTION5` simple (move/interact); `ACTION6` complex requiring `(x,y)` coordinates; `ACTION7` extra simple. Per-game action semantics are undefined — discovered only by exploration (operationalizes the Exploration + Goal-Setting pillars).

**Agent API:** two methods — `is_done(frames, latest_frame)` and `choose_action(frames, latest_frame)`; a **Swarm** runs many agent instances across games in parallel. Toolkit: `arc-agi` + `ARC-AGI-3-Agents` repos.

**Scoring (concrete RHAE form):** per-level = `min(h/a, 1.0)²` (human/agent action-count ratio, capped at 1 then squared — a raw 0.5 → 0.25); per-game = level-index-weighted average (later levels weigh more); total = mean over games; range 0–100%. Set sizes: 25 public games shipped; private competition set = **110 games** (55 → public leaderboard, 55 → private leaderboard), OOD from the public set — consistent with the 25/55/55 split above.

**Compute envelope:** Kaggle notebook ≤9 h CPU or GPU, internet disabled, freely-available external/pretrained models allowed; RTX 6000 (`g4-standard-48`) pool added. ≤1 submission/day, ≤2 final submissions.

**Public leaderboard (≈50% of test data, 2026-07; 8,838 entrants / 1,556 teams):** submitted purpose-built agents *vastly* exceed the frontier-API launch numbers (<1%) — top: Van-Phuc Huynh 1.40, Felix S. 1.32, Ravi's Agi 1.31, JohnLussier 1.30, Tufa Labs 1.21; ~32 teams score > 1.00.
- (tentative) Displayed scores exceed the 1.0 (=100%) cap the methodology text implies, so the leaderboard aggregate is on a different scale than the per-game-averaged 0–100% metric — reconcile against the official methodology page before citing.
- The gap is not a contamination signal but a **harness signal**: leaderboard entries are hand-built agents doing test-time search over the action space on games close to the public set (cf. StochasticGoose CNN+RL 12.58%), *not* general-purpose APIs. Reinforces the existing finding that harness scores measure task-specific optimization, not general fluid intelligence — the official leaderboard restricts general-purpose entries precisely to separate the two.

---

## Key Results

- **Scale vs. adaptation:** ARC-AGI-1 resisted 50,000× LLM scale-up (2019–2024); o3 solved it via test-time reasoning — empirically separating pre-training scale from in-context adaptation as the lever for fluid intelligence.
- **Efficiency criterion:** brute-force search could solve ARC-AGI given unlimited compute; this would not constitute intelligence. Intelligence = solving at human-comparable efficiency.
- **Human baseline:** All ARC-AGI-2 eval tasks solved by ≥2 humans in ≤2 attempts; calibrated IDD across public/semi-private/private splits.
- **ARC-AGI-2 human calibration:** 407 participants, 13,405 attempts, 62% overall solve rate, 2.3 min median time; no correlation with demographic factors (age, education, domain background) — tasks measure reasoning, not domain skill.
- **ARC-AGI-3 launch gap:** All 135 environments human-solvable (100%, verified ≥2 independent humans); frontier AI <1% without task-specific harnesses (best: Opus 4.6 0.50%); best agent competition result (StochasticGoose, CNN+RL, preview set): 12.58% via informed action-space search rather than world-model planning. Harness-based systems: near-human on environments the harness was built for, 0% on unseen — confirming harness scores measure task-specific optimization, not general intelligence.

---

## Limitations

- Grid-based format imposes a visuo-spatial prior beyond the four Core Knowledge claims; may systematically advantage spatial-reasoning systems.
- ARC-AGI-1 is now solved; relevant mainly as historical comparator and for methods that pre-date o3.
- ARC-AGI-1 and ARC-AGI-2 appear to have been compromised by synthetic-task coverage attacks (see Benchmark Contamination section); the OOD private-set design of ARC-AGI-3 is the proposed countermeasure, but its long-term resistance remains to be validated as model capabilities advance.
- <1% frontier AI performance on ARC-AGI-3 makes it hard to diagnose which of the four pillars is the primary bottleneck; the benchmark currently lacks intermediate difficulty scaffolding for capability decomposition.
- The persistent frontier-AI gap is not unique to visual grid tasks: FrontierMath ([[wiki/entities/frontiermath-benchmark.md]]) shows the same shortfall in research-level mathematics (<2%) from the opposite design direction (maximal domain knowledge vs. ARC-AGI's minimal-knowledge constraint), isolating latent structure inference as the shared bottleneck.
- ARC-AGI tasks permit only **exploitation** (solution search within a fixed, known representation space — integer colors, grid format, predefined action vocabulary); real-world problems additionally require **exploration** (constructing the representation itself). Unrestricted candidate trialling before submission is structurally inapplicable to most real-world domains where ≤1 attempt is permitted.

---

## Connections

- **[[wiki/concepts/core-knowledge.md]]** — ARC-AGI's four priors (objectness, number, geometry, agency) are Spelke's core-knowledge systems; restricting the prior budget to these is Chollet's fairness criterion, and the missing objectness system is the primary source of ARC shortcuts.
- **[[wiki/papers/spelke-kinzler-core-knowledge-2007.md]]** — primary developmental-science source for the Core Knowledge Priors that define ARC-AGI's fair prior budget.
- **[[wiki/concepts/refinement-loops.md]]** — refinement loops are the dominant technical driver of ARC-AGI-2 progress; the benchmark's exact-match verifier is what makes iterative generate-verify-refine cycles tractable; ARC-AGI-3's removal of the in-loop verifier is precisely what is expected to break current refinement-loop approaches.
- **[[wiki/concepts/structural-generalization.md]]** — ARC-AGI is the primary empirical target: tasks require inferring a transformation rule and applying it to new content, demanding factorized g/x/p representations; ARC-AGI-2's three capability gaps operationalise what structural generalization gaps remain after o3.
- **[[wiki/concepts/compositional-generalization.md]]** — ARC-AGI-2 compositional reasoning gap = systematicity and localism failure from Hupkes 2020; contextual rule application gap = structural generalization under WM-gated context; together they identify the specific facet binding constraint that prevents current systems from reaching 85% on ARC-AGI-2.
- **[[wiki/concepts/meta-learning.md]]** — ARC-AGI-1's o3 solution empirically validates test-time adaptation (fast inner loop) over pre-training scale (slow outer loop) as the lever for fluid intelligence; MLC (Meta-Learning as Compositional) achieves human-level on compositional grammar but does not transfer to ARC-AGI grid tasks.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — ARC-AGI-2 three gaps map directly to Blocks 3A/3B/3C; ARC-AGI-3 adds Block 3D; the benchmark is the external validation target for the full 11-block decomposition.
- **[[wiki/concepts/latent-graph-discovery.md]]** — ARC-AGI is the primary empirical instantiation of latent edge discovery: nodes = grid states, edges = unknown transformation rules, tasks test inference from sparse (before, after) pairs; ARC-AGI-3 additionally makes the target node latent (autonomous goal inference).
- **[[wiki/entities/mlc-model.md]]** — MLC (Meta-Learning as Compositional) achieves 92.9–96.8% on compositional grammar few-shot tasks in language but has not been shown to transfer to ARC-AGI's visuo-spatial grid domain; MLC (Meta-Learning as Compositional) demonstrates the training-objective solution (episodic meta-learning) but ARC-AGI-2 requires additional architectural capabilities.
- **[[wiki/concepts/abstract-reasoning.md]]** — ARC-AGI is the primary operational benchmark for abstract reasoning; the efficiency criterion (skill-acquisition per unit experience) operationalizes the pattern recognition / model-building distinction — pattern matchers hit scale ceilings, model-builders adapt within the episode.
- **[[wiki/papers/pgm-barrett-2018.md]]** — PGM (Progressive Generalization Matrix) (ICML 2018) is the controlled visual-relational precursor benchmark: the same interpolation/extrapolation/held-out distinction was established there, and the composition-decomposition asymmetry in WReN generalisation foreshadows the three capability gaps that ARC-AGI-2 (2025) identified at larger scale.
- **[[wiki/papers/building-machine-thinks-like-people-lake-2016.md]]** — Lake et al. 2016 provides the motivational framing that ARC-AGI operationalizes: the Frostbite challenge (924h vs. 15 minutes) is the precursor diagnostic that Chollet formalized into ARC-AGI's efficiency-based intelligence definition.
- **[[wiki/papers/arc-agi-3-paper.md]]** — primary technical paper for ARC-AGI-3; documents four-pillar agentic decomposition, RHAE scoring, human calibration (486 participants, 414 environments), LRM (Large Reasoning Model) knowledge-boundedness theorem, benchmark contamination analysis, and launch results.
- **[[wiki/papers/conceptarc-moskvichev-2023.md]]** — decomposes the ARC Core Knowledge vocabulary into 16 independently testable concept groups; within-concept generalization scores and near-miss vs. concept-failure error dissociation provide the most granular behavioral diagnostic of what AI systems fail to grasp in the ARC domain.
- **[[wiki/papers/beger-conceptarc-multimodal-2025.md]]** — extends ConceptARC evaluation with rule-level analysis on frontier reasoning models; reveals accuracy overestimates textual abstraction (~29% shortcut rate vs. ~5% human) and underestimates visual abstraction (~28% correct-intended rules in wrong-grid visual cases); identifies missing objectness prior as the primary shortcut driver.
- **[[wiki/concepts/shortcut-reasoning.md]]** — the ARC shortcut catalogue (integer color encodings, bounding boxes, connectivity, density) operationalizes why AI models score above chance without genuine concept abstraction; shortcut-resistance requires the intended-solution regime that ARC-AGI is designed to demand.
- **[[wiki/papers/shortcut-learning-geirhos-2020.md]]** — provides the theoretical framing for why ARC-AGI-2/3 are hard: each version is designed as an o.o.d. benchmark where shortcut solutions (which pass i.i.d. tests) fail; the benchmark contamination problem (ARC-AGI-1/2 coverage attacks) is precisely the synthetic-data route by which shortcut solutions are manufactured at scale.
- **[[wiki/papers/choi-intelligence-density-2026.md]]** — Choi's Intelligence Density $\mathcal{I}$ and Chollet's skill-acquisition efficiency share the core generalisation-not-memorisation criterion; Proposition 2 establishes $\Upsilon$ (Legg-Hutter) is monotonically increasing in $\mathcal{I}$, formally unifying Chollet's, Legg-Hutter's, and Choi's intelligence measures.
- **[[wiki/entities/frontiermath-benchmark.md]]** — parallel benchmark at the opposite prior-knowledge extreme: FrontierMath requires maximal domain expertise (research mathematics) where ARC-AGI requires minimal (Core Knowledge priors); both remain far below human under reproducible evaluation (FrontierMath <2%; verified ARC-AGI-2 24–54%), confirming that the shared bottleneck is latent structure inference, not knowledge quantity.
- **[[wiki/papers/arc-prize-2024-technical-report.md]]** — 2024 competition report establishing TTT (Test-Time Training)as the breakthrough paradigm; documents the three disjoint solution families and ensemble necessity that motivated the refinement-loop taxonomy.
- **[[wiki/papers/arc-agi-2-paper.md]]** — primary source for ARC-AGI-2 design rationale: compositional generalization focus, brute-force resistance, human calibration methodology, and SOTA collapse from ARC-AGI-1.
- **[[wiki/papers/o3-not-agi.md]]** — formalizes the exploitation/exploration gap: ARC-AGI permits only exploitation of a fixed representation space; real-world problems require exploration; unrestricted trialling is structurally inapplicable beyond closed verifiable domains.
- **[[wiki/entities/baba-is-ai.md]]** — orthogonal-axis sister benchmark: ARC-AGI holds topology static and makes edges latent, while Baba Is AI makes edges observable but non-stationary and agent-editable; together they separate latent-edge discovery from non-stationary-topology (hardness source 6).
