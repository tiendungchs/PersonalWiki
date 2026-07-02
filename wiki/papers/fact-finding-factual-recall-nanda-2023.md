---
title: "Fact Finding: Reverse-Engineering Factual Recall in Pythia 2.8B (Posts 1–5)"
type: paper
tags: [mechanistic-interpretability, factual-recall, memorization, superposition, detokenization, transformer]
created: 2026-07-01
updated: 2026-07-01
sources: [fact-finding-post1, fact-finding-post2, fact-finding-post3, fact-finding-post4, fact-finding-post5]
related: [wiki/concepts/two-learning-timescales.md, wiki/concepts/binding-problem.md, wiki/concepts/sparse-distributed-representations.md, wiki/entities/transformer-model.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/latent-graph-discovery.md]
---

# Fact Finding: Reverse-Engineering Factual Recall in Pythia 2.8B (Posts 1–5)

Nanda, Rajamanoharan, Kramár & Shah (Google DeepMind mech-interp team), "Fact Finding" sequence, AI Alignment Forum, Dec 2023.

## Key computational insights

- **Three-stage circuit** for athlete-sport recall: (1) attention layers 0–1 concatenate the tokens of a multi-token entity name onto the final name token; (2) MLP layers 2–6 nonlinearly map this to a **multi-token embedding** — a linear representation of the entity's attributes ("detokenization"); (3) sparse mid/late attention heads (e.g. L16H20) linearly extract the target attribute and write it to the logits. Context before the entity's name is irrelevant to lookup.
- **Falsified single-step detokenization**: fact lookup is not one GELU-per-fact Boolean AND. Ablating individual neurons shows near-zero cross-correlation between which neurons matter for different facts about the same entity — storage is distributed across all 5 MLP layers, not localized to one layer or neuron set.
- **Partial "hash and lookup"**: early MLPs measurably break the linear structure between summed token embeddings (60–70% orthogonalized vs. 20–40% for a random MLP of the same shape) before later layers read off the attribute — but the transition is smooth, not a clean two-stage split; known names have higher MLP output norm than unknown names even in the "hashing" layers.
- **Formal micro/macrofeature criterion**: a *macrofeature* is a feature useful for generalizing to unseen inputs; a *microfeature* is specific to one input. A task is **pure memorization** exactly when its only macrofeature is the output label itself. In that regime, every neuron's activation is trivially a weighted lookup table over inputs — there is no other structure for circuit-style interpretability (or generalization) to find, by construction, not by failure of technique.
- **Early layers softly specialize in local/recent-token processing** (multi-token detokenization), degrading gradually from layer 0 to ~layer 10 of 32; punctuation and common words are the exception, integrating long-range context immediately (used for summarization/counting/resting positions).

## Limitations

- Single narrow task (1,500 athlete→sport facts) in one mid-size model (Pythia 2.8B, 32 layers); generalization to richer/multi-hop facts is speculative.
- The team explicitly reports failing to reverse-engineer the neuron-level mechanism after ~6–7 FTE-months; conclusions are strong negative results plus conceptual framing, not a solved circuit.

## Links

- **[[wiki/concepts/two-learning-timescales.md]]** — mechanistic evidence that transformer fact storage is slow-trained yet functionally M-like (memorized, non-generalizing), with no physically separate fast-write pathway.
- **[[wiki/concepts/binding-problem.md]]** — token concatenation is a concrete transformer instantiation of feature binding (assembling multi-token entities onto one position).
- **[[wiki/concepts/sparse-distributed-representations.md]]** — superposed/distributed fact storage is a dense alternative to SDR-style sparse orthogonal coding for representing more items than units.
- **[[wiki/entities/transformer-model.md]]** — grounds the entity page's mechanistic detail on MLP fact storage and the localism-adjacent memorization finding.
- **[[wiki/concepts/shortcut-reasoning.md]]** — the micro/macrofeature distinction formalizes when shortcuts are/aren't possible: no macrofeature ⟹ no shortcut, only memorization.
- **[[wiki/concepts/latent-graph-discovery.md]]** — pure memorization tasks (no macrofeatures) have a degenerate latent graph: no shared edges exist to discover.
