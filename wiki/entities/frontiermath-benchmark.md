---
title: "FrontierMath Benchmark"
type: entity
tags: [benchmark, mathematical-reasoning, abstract-reasoning, latent-graph-discovery]
created: 2026-06-24
updated: 2026-06-24
sources: [FrontierMath A Benchmark for Evaluating Advanced Mathematical Reasoning in AI]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/abstract-reasoning.md, wiki/entities/arc-agi.md, wiki/papers/glazer-frontiermath-2024.md]
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

**Contrast with ARC-AGI:** ARC-AGI minimizes prior knowledge (Core Knowledge priors only, no domain expertise); FrontierMath maximizes it (deep research-level expertise required). Both yield <5% frontier AI performance — the shared bottleneck is latent structure inference, not knowledge quantity.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — FrontierMath instantiates the hardest latent graph configuration: both the edge vocabulary (applicable theorems) and the traversal path are latent, and the vocabulary has near-zero training coverage — the unknown vocabulary hardness source is maximally active.
- **[[wiki/entities/arc-agi.md]]** — parallel benchmark at the opposite prior-knowledge extreme: ARC-AGI uses minimal domain knowledge, FrontierMath uses maximal; both converge on <5% frontier AI performance, isolating latent structure inference as the shared bottleneck.
- **[[wiki/concepts/abstract-reasoning.md]]** — FrontierMath confirms the model-building gap is not modality-specific: the same <5% ceiling appears in formal mathematical reasoning as in visual grid tasks.
- **[[wiki/papers/glazer-frontiermath-2024.md]]** — source paper with full methodology, domain distribution, model results, and sample problems.
