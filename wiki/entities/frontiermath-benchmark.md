---
title: "FrontierMath Benchmark"
type: entity
tags: [benchmark, mathematical-reasoning, abstract-reasoning, latent-graph-discovery]
created: 2026-06-24
updated: 2026-07-02
sources: [FrontierMath A Benchmark for Evaluating Advanced Mathematical Reasoning in AI]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/abstract-reasoning.md, wiki/entities/arc-agi.md, wiki/papers/glazer-frontiermath-2024.md, wiki/papers/math-reasoning-survey-2026.md, wiki/queries/brain-inspired-vs-solver-approach.md]
---

# FrontierMath Benchmark

500+ original, expert-vetted mathematics problems at research level. All SOTA models score <2%. Designed to resist data contamination via original, unpublished problems with automated verification.

**Provenance:** Glazer et al., Epoch AI, 2024 (arXiv:2411.04872). 60+ mathematicians from 15+ countries; endorsed by Tao, Gowers, Borcherds.

---

## Domain Distribution

| Field | Share |
|---|---|
| Number theory | 17.8% |
| Combinatorics | 15.8% |
| Group theory | 8.9% |
| Probability | 5.1% |
| Algebraic geometry | 4.8% |
| Linear algebra | 4.8% |

200+ distinct solution techniques; most technique pairs co-occur in ≤3 problems — high structural uniqueness per problem. 13% of problems combine number theory + combinatorics.

---

## Problem Creation Requirements

| Requirement | Criterion |
|---|---|
| **Originality** | Novel adaptation; source concepts obscured |
| **Auto-verifiability** | Integer or SymPy-computable answer; solution script runs <1 min |
| **Guessproofness** | <1% blind-guess probability; large, non-obvious numerical answers |
| **Computational tractability** | Verification script on standard hardware <60 s |

---

## Difficulty Axes (3-dimensional, weakly correlated)

| Axis | Range | What it measures |
|---|---|---|
| **Background** | 1–5 (HS → research) | Prerequisite domain depth |
| **Creativity** | Hours | Time to identify key insight |
| **Execution** | Hours | Time to compute answer given insight |

---

## Limitations

- No proof generation: restricted to numerically verifiable answers; proof construction (the bulk of mathematical research) cannot be tested.
- ~10% estimated critical error rate; difficulty ratings inconsistently calibrated across reviewers.
- <2% ceiling provides insufficient variance to rank current models.
- Timescale mismatch: problems require hours; real research spans weeks to years.

---

## Latent Graph Discovery Framing

FrontierMath instantiates latent graph discovery where both the edge vocabulary and path are unknown — the maximally hard configuration:

| Graph element | FrontierMath instantiation |
|---|---|
| **Nodes** | Mathematical objects / intermediate results |
| **Edges** | Applicable theorems and proof steps |
| **Meta-graph** | Domain theorem network (Chebotarev, Coxeter groups, p-adic theory…) |
| **Instance-graph** | Specific proof/computation path for one problem |
| **Latent** | Applicable edge labels (which theorems) + path sequence + vocabulary coverage |

**Hardness source mapping** (see [[wiki/concepts/latent-graph-discovery.md]]):

| Hardness source | FrontierMath manifestation |
|---|---|
| **Two-level entanglement** | Cannot separate "which theorems apply" (meta) from "what is the solution path" (instance) — domain knowledge and problem structure co-vary in every problem statement |
| **Unknown vocabulary** | Research-level techniques have near-zero training coverage; Tao: "a dozen relevant papers" per problem area — the action alphabet is effectively empty at test time |
| **Observation aliasing** | Problem statement (numerical computation request) gives no cue to the required proof path; surface structure is nearly uncorrelated with latent graph topology |
| **Spurious edge covariate shift** | Pretraining statistics create false edges: standard templates and identities learned as shortcuts fail when the problem requires a non-standard technique |

**Contrast with ARC-AGI:** ARC-AGI minimizes prior knowledge (Core Knowledge priors only, no domain expertise); FrontierMath maximizes it (deep research-level expertise required). Both remain far below human under reproducible evaluation (FrontierMath <2%; verified ARC-AGI-2 24–54%, with unverified ≤85% closed-model self-reports) — the shared bottleneck is latent structure inference, not knowledge quantity.

**Tier-4 = where the solver approach ceilings.** The 2026 math-reasoning survey ([[wiki/papers/math-reasoning-survey-2026.md]]) shows the LLM-generator + external-verifier stack solving most of mathematics *except* Tier-4, the tier requiring *novel ideas* rather than application of standard techniques. Solvers stay single-digit on Tier-4; the strongest agentic workbench (AI co-mathematician, 2026) reaches only 48%. This is the empirical signature of Tao's *"discovery modulo expertise"* ceiling: the stack traverses a *known* theorem graph well but cannot *extend the vocabulary* with a genuinely new technique. FrontierMath is thus the benchmark where the solver approach's externalization of the vocabulary (mathlib, DSLs) stops paying off — precisely the unknown-vocabulary hardness source an internal world model must target. See [[wiki/queries/brain-inspired-vs-solver-approach.md]].

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — FrontierMath instantiates the hardest latent graph configuration: both the edge vocabulary (applicable theorems) and the traversal path are latent, and the vocabulary has near-zero training coverage — the unknown vocabulary hardness source is maximally active.
- **[[wiki/entities/arc-agi.md]]** — parallel benchmark at the opposite prior-knowledge extreme: ARC-AGI uses minimal domain knowledge, FrontierMath uses maximal; both stay far below human under reproducible evaluation (FrontierMath <2%; verified ARC-AGI-2 24–54%), isolating latent structure inference as the shared bottleneck.
- **[[wiki/concepts/abstract-reasoning.md]]** — FrontierMath confirms the model-building gap is not modality-specific: a persistent below-human gap appears in formal mathematical reasoning (<2%) as in visual grid tasks (verified ARC-AGI-2 24–54%).
- **[[wiki/papers/glazer-frontiermath-2024.md]]** — source paper with full methodology, domain distribution, model results, and sample problems.
- **[[wiki/papers/math-reasoning-survey-2026.md]]** — situates FrontierMath among the solver-era benchmarks and supplies the Tier-4 ceiling data (co-mathematician 48%; solvers single-digit) and Tao's "discovery modulo expertise" framing.
- **[[wiki/queries/brain-inspired-vs-solver-approach.md]]** — FrontierMath Tier-4 is the seam where the solver stack's externalized vocabulary stops working and internal vocabulary co-discovery becomes necessary.
