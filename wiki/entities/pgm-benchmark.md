---
title: "PGM (Procedurally Generated Matrices)"
type: entity
tags: [benchmark, abstract-reasoning, visual-reasoning, generalisation, raven-style]
created: 2026-06-23
updated: 2026-06-23
sources: [raven]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/structural-generalization.md, wiki/entities/arc-agi.md, wiki/papers/pgm-barrett-2018.md]
---

# PGM (Progressive Generalization Matrix) — Procedurally Generated Matrices

Barrett et al. (DeepMind), ICML 2018. The "RAVEN-style" visual abstract reasoning benchmark in this wiki's domain taxonomy. Inspired by Raven's Progressive Matrices (human IQ test, Raven 1938), PGM (Progressive Generalization Matrix) operationalizes abstract reasoning with explicit symbolic semantics, enabling controlled generalisation experiments unavailable in hand-authored test sets.

---

## Benchmark Structure

| Property | Value |
|---|---|
| Format | 3×3 matrix of images; select 1 of 8 candidates to complete the matrix |
| Panel size | 80×80 pixels |
| Scale | 1.2M train / 20K validation / 200K test |
| Primitive space | relation × object × attribute triples: R={progression, XOR, OR, AND, consistent union} × O={shape, line} × A={size, type, colour, position, number} |
| Complexity | 1–4 triples per puzzle; distracting attribute values optional |

---

## Generalisation Regimes

Eight train/test splits probe distinct failure modes:

| Regime | What varies | WReN (no aux) | WReN (meta-targets) |
|---|---|---|---|
| Neutral | Pixel-level splits only | 62.6% | 76.9% |
| Interpolation | Attribute values: even→odd split | 64.4% | 67.4% |
| Held-out Attribute Pairs | Novel (a₁,a₂) pairings | 27.2% | 51.7% |
| Held-out Triple Pairs | Novel (t₁,t₂) co-occurrences | 41.9% | 56.3% |
| Held-out Triples | Genuinely novel (r,o,a) primitives | 19.0% | 20.1% |
| Held-out shape-colour | Novel attribute assignment | 12.5% | 13.0% |
| Held-out line-type | Novel attribute assignment | 14.4% | 16.4% |
| Extrapolation | Attribute values outside training range | 17.2% | 15.5% |

Chance = 12.5%. Human performance (with practice) >80%.

---

## Key Findings

- **Relation architecture is necessary:** WReN (Relation Network scoring each candidate independently against all context panels) achieves 62.6% vs. ResNet-50 at 42% and CNN-MLP at 33%. Relational structure, not depth, is the discriminating factor.
- **Composition-decomposition asymmetry:** recombination of familiar triples into novel combinations succeeds well above chance (held-out pair regimes); genuinely novel primitives collapse near chance (held-out triple, extrapolation). A model can combine known packages without decomposing their meaning from constituents.
- **Symbolic meta-targets:** training to predict a 12-bit (relation/object/attribute) binary label improves recombination regimes strongly (+14–25%) but not novel-primitive regimes (+1%). Discrete symbolic pressure on *known* relations improves how they compose; it cannot supply meanings for unseen primitives.
- **Relation type is the binding constraint:** prediction accuracy on relation meta-target (correct vs. incorrect) produces 86.8% vs. 32.1% task accuracy — dominating attribute-type (79.5%/49.0%) and shape-type (78.2%/62.2%) effects.

---

## Comparison with ARC-AGI

| Property | PGM (Progressive Generalization Matrix) | ARC-AGI-2 |
|---|---|---|
| Rule vocabulary | Finite, explicit (r,o,a) triples | Open-ended; any Core Knowledge rule |
| Max rule depth | Single 3×3 matrix | Multi-step, compositional |
| Naturalness | Procedurally rendered shapes | Hand-authored novel patterns |
| AI SOTA | ~77% (meta-target WReN) | ~4% |

PGM provides a controlled taxonomy of generalisation failure; ARC-AGI tests open-ended generalisation. PGM's composition-decomposition finding directly predicts ARC-AGI failure: known-primitive recombination ≠ novel-primitive extension.

---

## Connections

- **[[wiki/concepts/abstract-reasoning.md]]** — the PGM (Progressive Generalization Matrix) composition-decomposition asymmetry is the clearest empirical instantiation of the Lake et al. compositionality gap at the visual-relational level; the meta-target result supports the factorized-representation design requirement.
- **[[wiki/concepts/compositional-generalization.md]]** — held-out triple and extrapolation results quantify exactly where the WReN model's compositional competence ends: it recombines known packages but cannot decompose primitives into constituents.
- **[[wiki/entities/arc-agi.md]]** — PGM (Progressive Generalization Matrix) is the controlled predecessor; ARC-AGI extends to open-ended Core Knowledge domains; the two benchmarks together map the decomposition-to-generalization spectrum.
- **[[wiki/papers/pgm-barrett-2018.md]]** — source paper with full dataset statistics, architecture details, and generalisation regime results.
