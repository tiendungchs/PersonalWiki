---
title: "Structural Generalization"
type: concept
tags: [structural-generalization, abstract-reasoning, relational-memory, graph-theory]
created: 2026-06-09
updated: 2026-06-22
sources: [gridlikecode, Compositionality_decomposed, Human-like_systematic_generalization, ARC-AGI-1.md, ARC-AGI-2.md, ARC-AGI-3.md, What is ARC-AGI.md, building_machine_that_thinks_like_people, raven, The ConceptARC Benchmark]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/factorized-representations.md, wiki/concepts/latent-states.md, wiki/concepts/path-integration.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/neural-manifolds.md, wiki/concepts/compositional-generalization.md, wiki/concepts/successor-representation.md, wiki/concepts/abstract-reasoning.md, wiki/entities/tem-model.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/htm-thousand-brains.md, wiki/papers/gridlikecode-constantinescu-2016.md, wiki/papers/150000-mini-brain-transcript.md, wiki/papers/compositionality-decomposed-hupkes-2020.md, wiki/entities/mlc-model.md, wiki/papers/mlc-lake-baroni-2023.md, wiki/concepts/meta-learning.md, wiki/entities/arc-agi.md, wiki/papers/arc-agi-overview.md, wiki/papers/cls-mcclelland-1995.md, wiki/entities/tiwm-model.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md, wiki/papers/pgm-barrett-2018.md, wiki/papers/conceptarc-moskvichev-2023.md]
---

# Structural Generalization

**Extract the relational skeleton of a domain and immediately apply it to new instances with different surface content — enabling inference about unobserved relationships after minimal exposure.**

This is the central target capability. Every other concept in this wiki is either a mechanism for achieving it or a constraint it imposes on architecture.

---

## The Graph Formalization

Any relational domain maps to a directed labeled graph:

| Domain | Nodes | Edge types |
|--------|-------|-----------|
| Physical space | Locations | N, S, E, W |
| Family tree | Persons | parent, child, sibling |
| Bird morphology | Configs | neck+, leg−, … |
| T-maze + trial | Physical × L/R | move + trial-progress |

Structure = the graph. Content = sensory labels on nodes. Structural generalization = learning graphs in general, not specific graphs. A new family with the same tree topology requires zero relearning of the relational rules.

**Why graphs over lookup tables:** A lookup table stores (state → value) pairs; it cannot plan novel paths or generalize to new instances. A graph stores (state → relation → state); it enables path-planned inference and zero-shot transfer.

---

## Why Periodic Representations Are Necessary

Generalizing with graphs requires assigning representations uniformly across all positions — graph matching (finding the isomorphism) is NP-hard. Periodic representations (grid cells) solve this: all positions are treated equivalently, so the structural code can be shifted/rotated to register any new environment without NP-hard matching. Place cells remap (environment-specific); grid cells realign (structure-preserving). This is the computational reason why MEC generalizes and HC doesn't.

---

## Minimal Ingredients

From TEM, the minimum required for structural generalization:

1. **Factorized latent space** — structural variables separate from sensory; entangling them corrupts transfer
2. **Path-consistent structural code** — same abstract position always produces the same code regardless of path taken ([[wiki/concepts/path-integration.md]])
3. **Fast binding** — rapidly associates structural positions with current sensory content (Hebbian M)
4. **Slow structure learning** — extracts shared transition rules across many environments (backprop on W)
5. **Attractor-based correction** — sensory cues re-localize in structural space when path integration drifts

---

## Why Standard Deep Learning Fails

Transformers and CNNs conflate structure and content in monolithic weights. When content changes, there is no factorized structural code to transfer — the model must relearn from scratch. This is an architectural failure, not a data problem: GPT-class models fail ARC-AGI systematically despite massive training because the benchmark requires recognizing a transformation rule and applying it to new grids, which demands factorized representations.

**Catastrophic interference gives the formal argument ([[wiki/papers/cls-mcclelland-1995.md]]):** standard training without the fast/slow split forces the monolithic weight system to rapidly absorb each new episode, overwriting prior structure. The slow-W system in TEM avoids this because: (a) new episodic content is routed through fast M, never touching W; (b) W updates are averaged across many diverse environments simultaneously — the computational equivalent of interleaved training. This makes structural failure not an optimization problem but an architectural necessity.

Hupkes et al. 2020 ([[wiki/papers/compositionality-decomposed-hupkes-2020.md]]) operationalises this failure into five independently measurable facets (see [[wiki/concepts/compositional-generalization.md]]): even on controlled artificial data designed to *require* compositional solutions, transformers achieve only 72% systematicity, 50% productivity, and 54% localism — despite 92% task accuracy. High task accuracy hides fundamental architectural failure because models learn *function-pair chunks* rather than atomic primitives. This confirms the structural claim: failure is not a data problem.

Lake & Baroni 2023 ([[wiki/papers/mlc-lake-baroni-2023.md]]) provide the positive case: the *same* transformer architecture, when trained via episodic meta-learning (100K episodes, different grammar per episode), achieves 92.9–96.8% systematicity on the few-shot instruction task. GPT-4 (standard pre-training) achieves only 58% and collapses to 14% under input permutation. The critical variable is **training objective, not architecture** — episodic meta-learning forces the slow loop to extract abstract rule-learning capacity rather than surface co-occurrence statistics. This refines the architectural-failure claim: transformers fail structural generalization under standard training; they can succeed under episodic training that enforces the W/M split via curriculum.

**ARC-AGI as the empirical progression benchmark ([[wiki/entities/arc-agi.md]]):** ARC-AGI-1 (800 tasks, ~3 few-shot examples per grid puzzle) resisted 50,000× LLM scale-up from 2019–2024, then was solved by o3 via test-time reasoning — validating fast within-episode adaptation as the structural-generalization lever, not pre-training scale. ARC-AGI-2 (2025) remains unsolved (~4% AI vs. ~84% human) and identifies three remaining architectural deficits more precisely than PCFG SET:

| ARC-AGI-2 gap | Precise failure | Required block |
|---|---|---|
| Symbolic interpretation | Systems cannot assign semantic roles to symbols beyond visual pattern matching | Block 3A (Transformation Inferrer) |
| Compositional reasoning | Systems handle single global rules but fail when two or more rules must interact simultaneously | Block 3C (Hierarchical grammar stack) |
| Contextual rule application | Systems fixate on surface patterns rather than context-gated selection of the correct rule | Block 3B (WM context maintenance) |

These gaps confirm that scale-based approaches cannot close the structural generalization deficit — the three blocks above are architectural requirements, not data requirements.

**PGM as the controlled visual-relational precursor ([[wiki/papers/pgm-barrett-2018.md]]):** Barrett et al. 2018 provided a finer generalisation taxonomy for relational reasoning eight years before ARC-AGI-2: interpolation vs. extrapolation vs. held-out triple-pairs vs. held-out individual triples. The pattern matches: WReN recombines familiar relational primitives into novel combinations (held-out pairs, above chance) but fails on genuinely novel primitives and out-of-distribution attribute ranges (near chance). This confirms the structural claim at a controlled, smaller scale: models absorb composition statistics over known primitives rather than encoding atomic relational meanings, and the failure is fundamental — auxiliary symbolic training helps compose what is known but cannot supply meanings for genuinely unseen components.

**ConceptARC as primitive-level evidence ([[wiki/papers/conceptarc-moskvichev-2023.md]]):** Moskvichev et al. 2023 extend the failure diagnosis to the within-concept level: 16 Core Knowledge concept groups (Copy, Count, Order, Inside/Outside, etc.), each tested across 10 task variations, show that no program exceeds 80% on any concept while humans achieve 83–97% on all 16. Structural generalization fails at the level of individual concept abstractions, not only at the rule-composition level: even a single concept like "Copy" cannot be generalized across variations by heuristic search, confirming that the manifold failure reaches down to the most primitive elements of the Core Knowledge vocabulary.

---

## Cognitive Map Connection

"Cognitive map" (Tolman, 1948) names the same concept at the behavioral level: an internal relational model affording flexible behavior and shortcuts. The computational implementation is a factorized world model with a graph-structured latent space. "Learning so you don't have to learn" — acquire structural knowledge ahead of time to minimize online computation when facing new instances.

---

## Empirical Grounding — Abstract Grid Codes in Humans

Constantinescu et al. 2016 ([[wiki/papers/gridlikecode-constantinescu-2016.md]]) provide direct fMRI evidence: humans navigating a 2D abstract conceptual space (bird morphology) show the same hexagonal BOLD signal as during spatial navigation, in vmPFC and entorhinal cortex. Key constraints this places on any reasoning model:

1. **The structural code must be periodic/hexagonal in 2D** — not arbitrary or learned-from-scratch per domain.
2. **The code must be stable over time** (days to weeks) — it is a durable internal representation, not a transient working-memory state.
3. **The structural code must be implicitly acquired** — subjects showed grid signals without conscious spatial framing of the abstract task.
4. **vmPFC and the default mode network are part of the structural-coding system** — not just MEC/HC; the circuit extends into prefrontal and posterior cortices.

---

## Architecture Determines Feasibility

The neural manifold constraint ([[wiki/concepts/neural-manifolds.md]]) sharpens the minimal ingredients list from an *efficiency* argument to a *structural-reachability* argument.

A training objective can only converge on patterns reachable within the model's intrinsic manifold. If abstract relational patterns lie outside, no training signal will produce reliable generalization — regardless of data, gradient steps, or architecture scale.

**Each ingredient reframed:**
- **Ingredient 1 (factorized latent space):** without factorization, relational transfer is not just hard — the target is outside the manifold by construction; no training reaches it.
- **Ingredient 4 (slow structure learning):** only useful if the slow system's architecture places abstract patterns inside its reachable manifold.

**Why standard deep learning fails ARC-AGI:** transformers don't fail due to data or training — their monolithic architecture places abstract relational generalization outside their intrinsic manifold. More training cannot cross that boundary.

**Convergent anatomical evidence (TBT):** Thousand Brains Theory [[wiki/entities/htm-thousand-brains.md]] proposes that every cortical column runs the factorized world-model circuit. If correct, structural generalization is not a specialization of MEC/HC but the organizing principle of the entire neocortex — evolution already solved the manifold problem by building factorized world models into 150,000 columns. This reframes the feasibility argument from "you must add this ingredient" to "biology does this universally."

---

## Connections

- **[[wiki/concepts/factorized-representations.md]]** — factorization IS the mechanism that makes structural generalization possible; entangling structure and content in the same weights blocks transfer. Every ingredient of structural generalization requires factorization.
- **[[wiki/concepts/path-integration.md]]** — provides path-consistency (ingredient 3): the structural code `g` must return to the same state regardless of which path was taken to a node, which requires integrating transitions rather than memorizing node identities.
- **[[wiki/concepts/latent-states.md]]** — full generalization demands an *expanded* graph including all task-relevant hidden dimensions; aliased observations (same observation, different futures) expose incomplete structural representations and block generalization.
- **[[wiki/concepts/two-learning-timescales.md]]** — structural generalization is the goal of the slow W system; fast M handles per-environment content binding. Neither alone suffices.
- **[[wiki/entities/tem-model.md]]** — TEM is the reference proof-of-concept: it demonstrates zero-shot structural generalization with the factorized g/x/p architecture.
- **[[wiki/entities/grid-cells.md]]** — grid cells implement the periodic structural code that makes graph-matching tractable; their environment-invariance is the biological signature of structural generalization.
- **[[wiki/entities/place-cells.md]]** — place cell remapping while preserving grid-phase relationships is the empirical evidence that the factorized split holds: x changes, g is preserved.
- **[[wiki/papers/gridlikecode-constantinescu-2016.md]]** — direct empirical grounding: human fMRI shows grid codes organize abstract 2D conceptual spaces, confirming the grid-as-structural-code hypothesis extends beyond spatial domains.
- **[[wiki/concepts/neural-manifolds.md]]** — intrinsic dynamics reframes each minimum ingredient from an efficiency argument to a feasibility argument: without the ingredient, the target generalization lies outside the model's reachable manifold, making more training useless rather than merely insufficient.
- **[[wiki/entities/htm-thousand-brains.md]]** — TBT (Thousand Brains Theory) proposes the factorized g/x/p circuit is universal across all ~150,000 cortical columns; if correct, structural generalization is the organizing principle of the entire neocortex — convergent anatomical evidence that strengthens the feasibility argument.
- **[[wiki/papers/150000-mini-brain-transcript.md]]** — source for TBT's universal columnar architecture claim and the evolutionary grounding of the feasibility argument.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the unified problem formulation of which structural generalization is the meta-graph component: structural generalization = learning W (the meta-graph transition structure) across environments so that any new instance-graph with the same topology costs only an M update.
- **[[wiki/concepts/compositional-generalization.md]]** — complementary capability: structural generalization transfers graph topology, compositional generalization recombines operations; the five Hupkes et al. facets operationalise precisely how standard transformers fail on both simultaneously despite high task accuracy.
- **[[wiki/papers/compositionality-decomposed-hupkes-2020.md]]** — empirical grounding for the "architectural failure not data problem" claim: PCFG SET tests show transformers fail systematicity (0.72), productivity (0.50), localism (0.54) even when the data is designed to require compositional solutions.
- **[[wiki/entities/mlc-model.md]]** — MLC (Meta-Learning as Compositional) refines the failure claim: the same transformer with episodic meta-training achieves 92.9–96.8% — training objective, not architecture, is the critical variable for structural transfer.
- **[[wiki/concepts/meta-learning.md]]** — episodic meta-learning is the training-side mechanism that enforces structural generalization; the slow loop learns rule-learning capacity rather than rule instances, implementing the W/M principle through curriculum design rather than explicit factorization.
- **[[wiki/entities/arc-agi.md]]** — ARC-AGI is the primary empirical target: ARC-AGI-1 (solved by o3 via test-time reasoning) validated fast adaptation over scale; ARC-AGI-2's three capability gaps (symbolic interpretation, compositional reasoning, contextual rule application) operationalise exactly which architectural ingredients (Blocks 3A/3B/3C) remain missing.
- **[[wiki/papers/arc-agi-overview.md]]** — source for benchmark structure, Chollet's formal intelligence definition, o3 breakthrough, and ARC-AGI-2 capability gap taxonomy.
- **[[wiki/papers/cls-mcclelland-1995.md]]** — provides the formal proof that the W/M split is computationally necessary: catastrophic interference in monolithic networks demonstrates that rapid new-episode storage is architecturally incompatible with preserving shared structural knowledge; TEM's W/M factorization is the direct solution.
- **[[wiki/concepts/successor-representation.md]]** — SR (Successor Representation) provides the RL-theoretic derivation of why periodic grid codes enable structural generalization: T^n shares eigenvectors with S, so the same grid code supports multi-step planning and cross-environment inference at no additional representational cost.
- **[[wiki/entities/tiwm-model.md]]** — TIWM is the primary architectural proposal targeting the symbolic-interpretation gap identified on this page (ARC-AGI Block 3A); the Inverse Path Integrator extends structural codes to support transformation inference — the missing capability beyond the five minimum ingredients.
- **[[wiki/papers/pgm-barrett-2018.md]]** — PGM (Progressive Generalization Matrix) is the controlled visual-relational precursor to ARC-AGI: its eight generalisation regimes (interpolation/extrapolation/held-out triples/held-out pairs) establish that structural generalisation failure is a composition-decomposition problem, not a data or scale problem — confirming the architectural-failure claim at a smaller, fully interpretable scale.
- **[[wiki/concepts/abstract-reasoning.md]]** — structural generalization is the architectural implementation of abstract reasoning: the factorized g/x/p split provides the causal-structural model that supports one-shot transfer, goal repurposing, and counterfactual inference across novel instances.
- **[[wiki/papers/building-machine-thinks-like-people-lake-2016.md]]** — primary motivational source; the Frostbite 924h vs. 15-minute efficiency gap is the empirical grounding for why structural generalization is the central target; BPL demonstrates that causal+compositional representations solve the Characters Challenge from a single example.
- **[[wiki/papers/conceptarc-moskvichev-2023.md]]** — within-concept generalization failure across 16 Core Knowledge concepts confirms that structural generalization failure operates at the primitive abstraction level: no program exceeds 80% on any concept (humans 83–97% on all 16), and the near-miss vs. concept-failure error dissociation shows that the manifold failure reaches individual concept representations, not only multi-rule compositions.
- **[[wiki/concepts/shortcut-reasoning.md]]** — shortcut solutions are the failure mode of structural generalization: a system that has not extracted transferable relational structure W exploits i.i.d. correlates instead; the discriminative/generative asymmetry in shortcut resistance directly reflects whether a system learned structural generalization or distribution-specific features.
