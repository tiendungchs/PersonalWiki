---
title: "Emergent Linear Representations in World Models of Self-Supervised Sequence Models"
type: paper
tags: [world-models, mechanistic-interpretability, linear-representation-hypothesis, othello-gpt, emergence, activation-steering, latent-graph-discovery]
created: 2026-07-09
updated: 2026-07-09
sources: [Emergent Linear Representations in World Models of Self-Supervised Sequence Models]
related: [wiki/concepts/world-models.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/representational-geometry.md, wiki/concepts/refinement-loops.md, wiki/entities/transformer-model.md, wiki/queries/central-framing-epistemic-audit.md]
---

# Emergent Linear Representations in World Models of Self-Supervised Sequence Models

**Nanda, Lee & Wattenberg, 2023 (arXiv:2309.00941).** Builds on Li et al. 2023 (OthelloGPT): an 8-layer GPT trained *only* to predict legal Othello moves from move sequences — never given the board or rules — spontaneously builds an internal board-state world model.

## Key computational insights

- **A world model / state-graph emerges spontaneously from pure next-token SSL.** The board (a relational state graph) is never supplied; predicting legal moves is sufficient pressure to construct an explicit internal model of it. Direct ML evidence that the "map" is a *natural attractor* of self-supervised sequence learning, not an imposed metaphor.
- **The world model is *linear* — once probed in the right basis.** Li et al. concluded the code was *non-linear* (linear probe on {Black, White, Empty} ≈ 75%). Nanda's insight: the model encodes tiles *relative to the current player* ({Mine, Yours, Empty}, flipping parity each turn). A linear probe on that basis hits ~99%. Methodological lesson: whether you find (and whether you call "linear") a real world model depends on choosing the probe basis the *model* uses, not the human-obvious one ("projecting our preconceptions").
- **Causal usage test passed via vector arithmetic.** Adding `α·p_d` (d ∈ {Mine, Yours, Empty}) to the residual stream flips/erases a tile and changes predicted legal moves to match the counterfactual board (0.10 avg errors vs. 2.72 null; matches Li et al.'s gradient-based edit with a *single* vector addition). The geometry is *used*, not merely present — the causal-perturbation "usage test" Chen 2022 demanded, done in silico.
- **Multiple-circuits / "MoveFirst".** In end-games the model often computes legal moves *before* (or without) the full board state — simpler non-navigational circuits (e.g. Empty + Is-Border) coexist with the world-model circuit. Map-presence-and-causal-usage does **not** imply map-*exclusivity*.
- Additional linear features (`Flipped` tiles, causally relevant); iterative cross-layer refinement of the board estimate.

## Limitations

- A 2D, transition-sampled *game-board* graph in an artificial net — not a brain, and not non-embeddable symbolic reasoning; speaks to the transition-sampled/embeddable slice only.
- Why linear representations emerge is left open; single architecture/task.

Links: [[wiki/concepts/world-models.md]] · [[wiki/concepts/latent-graph-discovery.md]] · [[wiki/concepts/shortcut-reasoning.md]] · [[wiki/queries/central-framing-epistemic-audit.md]]
