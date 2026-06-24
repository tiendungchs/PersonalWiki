---
title: "TIWM (Transformation-Inferring World Model)"
type: entity
tags: [model-design, abstract-reasoning, rule-generalization, arc-agi, factorized-representations, inverse-path-integration]
created: 2026-06-20
updated: 2026-06-20
sources: []
related: [wiki/entities/tem-model.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/path-integration.md, wiki/concepts/ring-attractor.md, wiki/entities/htm-thousand-brains.md, wiki/entities/cscg-model.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/entities/arc-agi.md, wiki/concepts/meta-learning.md, wiki/queries/building-blocks-mec-hc-pfc.md]
---

# TIWM (Transformation-Inferring World Model)

**(brainstorm) Proposed architecture for latent-edge discovery (Type 2 latent graph tasks).**

Extends TEM by adding an Inverse Path Integrator: instead of `(g_in, a) → g_out` (TEM forward), TIWM solves `{(g_in_i, g_out_i)} → a` — inferring the latent transformation rule from before/after observation pairs.

---

## Architecture

| Module | Input → Output | Brain analog |
|---|---|---|
| **Encoder** | `x_obs → (g, x)` | MEC grid cells (g) / sensory cortex (x) |
| **Transformation Inferrer** | `{Δg_i = g_out_i − g_in_i}` → `p(a)` | TBT (Thousand Brains Theory) efference copy: L6 predict vs. L4 actual |
| **Slow W** | Meta-graph: shared transformation vocabulary | MEC long-term plasticity |
| **Forward Predictor** | `(g_in, a) → g_out` | MEC path integration (TEM mode) |
| **Fast M** | Hebbian binding within episode | HC LTP (Long-Term Potentiation) |
| **Decoder** | `g_out → x_out` via M | HC → LEC |

**Transformation Inferrer:** cross-attention from Δg vectors to W columns; posterior `p(a | Δg_1,…,Δg_k)` sharpens with more examples (k≥3 → unique consistent transformation). Cyclic rules (rotation, reflection): ring attractor in transformation space prevents drift under ambiguous evidence.

W is used bidirectionally: forward for prediction (TEM mode), inverse for transformation inference. This is the single functional extension over TEM — everything else is preserved.

---

## Handling the Four Sources of Hardness

| Hardness source | TIWM response |
|---|---|
| Two-level entanglement | W (slow) = transformation vocabulary across tasks; a (fast, inferred) = instance rule |
| Unknown vocabulary | W learned from task distribution — discovers transformation types during training |
| Observation aliasing | Factorized encoder: path-consistent g disambiguates same-appearance states |
| Simultaneity | Simplified: infer a from examples first, then apply; iterative joint inference not yet implemented |

---

## Limitations

1. **Encoder bottleneck:** factorized g/x embedding from raw pixels is unsolved — not part of TEM or CSCG.
2. **Closed vocabulary:** cannot invent transformation types absent from the W training distribution.
3. **Flat hierarchy:** compositional transformation chains (rule A then rule B) require a two-level graph structure not implemented.
4. **Cold-start:** W is uninformative in a novel domain — falls back to exhaustive search over the prior.

---

## Comparison to Related Models

| Model | Scope | TIWM vs. |
|---|---|---|
| TEM | Navigates known graph with given actions | TIWM adds inverse: infers unknown action from state transitions |
| CSCG | De-aliases observations via clone cells | Candidate encoder de-aliasing layer for TIWM (proposed) |
| MLC (Meta-Learning as Compositional) | Meta-learns transformation rules over 100K grammars | TIWM is the within-episode inference mechanism MLC (Meta-Learning as Compositional) trains toward |

---

## Connections

- **[[wiki/entities/tem-model.md]]** — TIWM preserves the full TEM architecture (g/x/p, W, M) and adds the Transformation Inferrer as the single new module that makes edge labels latent rather than given.
- **[[wiki/concepts/path-integration.md]]** — the Transformation Inferrer runs path integration backwards: instead of `(g, a) → g'`, it solves `(g, g') → a` via attention over the W vocabulary.
- **[[wiki/concepts/factorized-representations.md]]** — g/x factorization is a prerequisite: Δg vectors only carry structural signal if g is disentangled from x content.
- **[[wiki/concepts/two-learning-timescales.md]]** — W (slow) is the shared transformation vocabulary; M (fast) binds episode-specific content; the same W/M split as TEM, now used for both forward and inverse inference.
- **[[wiki/concepts/ring-attractor.md]]** — cyclic transformation spaces (rotation, reflection) map to a ring attractor in the Transformation Inferrer; ring dynamics concentrate ambiguous posteriors without drift.
- **[[wiki/entities/htm-thousand-brains.md]]** — the Transformation Inferrer generalizes the TBT (Thousand Brains Theory) efference copy: TBT (Thousand Brains Theory) infers motor actions from predicted vs. actual state; TIWM extends this to abstract transformations.
- **[[wiki/concepts/latent-graph-discovery.md]]** — TIWM is the primary architectural proposal for latent-edge discovery (Type 2): the Transformation Inferrer is the mechanism for recovering hidden edge labels from sparse observation pairs.
- **[[wiki/entities/arc-agi.md]]** — TIWM targets ARC-AGI Type 2 tasks; Block 3A (Transformation Inferrer) addresses the symbolic-interpretation and contextual rule application gaps in ARC-AGI-2.
- **[[wiki/entities/cscg-model.md]]** — CSCG's clone-cell mechanism is the proposed de-aliasing layer for the TIWM encoder.
- **[[wiki/concepts/meta-learning.md]]** — the Transformation Inferrer is the fast within-episode algorithm that PFC (Prefrontal Cortex) meta-RL would train: the latent variable is the task rule, inferred from few examples.
- **[[wiki/concepts/structural-generalization.md]]** — TIWM extends structural generalization beyond TEM: where TEM requires given actions, TIWM additionally recovers the action identity, addressing ARC-AGI-2's symbolic-interpretation gap.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — Block 3A in the 11-block decomposition; the Transformation Inferrer is described there with set-attention implementation detail.
