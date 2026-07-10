---
title: "Structured World Representations in Maze-Solving Transformers — Ivanitskiy, Spies, Räuker et al. 2023"
type: paper
tags: [world-models, mechanistic-interpretability, linear-representation-hypothesis, emergence, maze, latent-graph-discovery, grokking, transformer]
created: 2026-07-10
updated: 2026-07-10
sources: [Structured World Representations in Maze-Solving Transformers]
related: [wiki/concepts/world-models.md, wiki/concepts/latent-graph-discovery.md, wiki/papers/emergent-linear-world-models-nanda-2023.md, wiki/papers/linear-spatial-world-models-tehenan-2025.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/representational-geometry.md, wiki/entities/transformer-model.md, wiki/queries/central-framing-epistemic-audit.md]
---

# Structured World Representations in Maze-Solving Transformers

**Ivanitskiy, Spies, Räuker et al., 2023 (arXiv:2312.02566; NeurIPS 2023 UniReps workshop).** Autoregressive decoder-only GPT models trained *only* to solve mazes — tokenized as `<ADJLIST> … <ORIGIN> … <TARGET> … <PATH>` — spontaneously form structured internal representations of maze topology. Two models: `hallway` (1.2M params, "forkless" mazes) and `jirpy` (9.6M params, sparse forking mazes). The most literally *latent-graph* of the wiki's Axis-4 sources: the recovered world model is an actual **connectivity graph**, not a board (Nanda) or R³ space (Tehenan).

## Key computational insights

- **The entire maze connectivity graph is linearly decodable from a *single* token's residual stream.** Linear probes on the `<PATH_START>` token reconstruct the whole maze (wall present/absent per position × direction), reaching >90% for `jirpy`, *already at layer 2*. Direct ML evidence that a relational graph — the object of latent graph discovery — is a natural attractor of pure next-token SSL, and can be compressed into one token.
- **Emergent spatial structure in the embedding space.** Coordinate tokens have orthogonal vocabulary vectors, yet learned embeddings correlate with Manhattan (lattice) distance for short distances. Adjacency-list order is randomized, so this is *not* sequence-proximity. Caveat the authors flag: the embedding can only encode the *lattice* structure shared across all mazes, **not** the in-context connectivity (which walls exist in *this* maze) — that lives in the residual stream / attention, not the embedding.
- **Adjacency heads — a topology-respecting circuit.** Layer-5 Head-3 consistently attends to tokens at **path-length 1** from the current position, i.e. it learns in-context to respect the maze's walls. Tuned Lens shows valid-neighbor information written onto coordinate tokens after layer 1–2 and refined in later layers.
- **Grokking co-emergence (the datapoint neither sibling has).** Across training checkpoints, the periods where the linear maze representation improves most coincide with the sharpest jumps in generalization (exact-path accuracy) — a *training-dynamics* link suggesting structured representation drives systematic generalization. Authors call this "suggestive but incomplete" (correlational).

## Limitations

- **Correlational only** — DLA/Tuned Lens *locate* heads and representations; ablations/interventions are explicit future work. Weaker than Nanda's causal vector-steering or Tehenan's activation-steering: no causal usage test here.
- **Presence ≠ necessity.** `hallway` solves its (simpler) task *without* forming a clear linear maze representation — the training-side analog of Nanda's MoveFirst "presence ≠ exclusivity."
- **Shortcut co-presence.** Both models "often violate constraints" (pass through walls) yet still reach the target — a [[wiki/concepts/shortcut-reasoning.md]] signature coexisting with the world model.
- 2D lattice maze = the embeddable / transition-sampled slice again; says nothing about non-embeddable symbolic structure.

Links: [[wiki/concepts/world-models.md]] · [[wiki/concepts/latent-graph-discovery.md]] · [[wiki/papers/emergent-linear-world-models-nanda-2023.md]] · [[wiki/queries/central-framing-epistemic-audit.md]]
