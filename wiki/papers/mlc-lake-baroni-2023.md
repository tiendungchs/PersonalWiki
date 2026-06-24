---
title: "Human-like Systematic Generalization — Lake & Baroni, Nature 2023"
type: paper
tags: [meta-learning, compositional-generalization, systematicity, inductive-biases, seq2seq, human-behavior]
created: 2026-06-19
updated: 2026-06-21
sources: [Human-like systematic generalization through a meta-learning neural network]
related: [wiki/entities/mlc-model.md, wiki/concepts/compositional-generalization.md, wiki/concepts/meta-learning.md, wiki/concepts/structural-generalization.md, wiki/concepts/abstract-reasoning.md, wiki/papers/compositionality-decomposed-hupkes-2020.md]
---

# Human-like Systematic Generalization — Lake & Baroni, Nature 2023

**Citation:** Lake, B. M. & Baroni, M. (2023). Human-like systematic generalization through a meta-learning neural network. *Nature*, 623, 115–121.

---

## Key Computational Insights

- **Episodic meta-training installs rule-learning capacity, not rule instances.** Each of 100K training episodes uses a *different* randomly generated interpretation grammar. The slow outer loop cannot absorb grammar-specific co-occurrence patterns — there are none stable across episodes. Test-time weights are frozen; new grammars are inferred purely from in-context study examples. 26 rules held entirely out of training are acquired at 99%+ accuracy, proving the fast mechanism generalizes beyond its training vocabulary.

- **Lexical generalization is solved; structural/productivity generalization is not.** On SCAN lexical splits MLC (Meta-Learning as Compositional) achieves ≤0.22% error; on COGS lexical types 0.87% error — basic seq2seq is ≥7× worse. But on SCAN length (productivity) and COGS structural splits, MLC (Meta-Learning as Compositional) scores **100% error** — same as a random model. Meta-learning addresses within-distribution grammar variation; generalization to genuinely out-of-distribution structural forms requires something beyond the current paradigm.

- **Human behavioral data provides precise design targets.** Few-shot instruction task (n=25): 80.7% algebraic accuracy. MLC (Meta-Learning as Compositional) matches this at 82.4% (sampled). Quantitative error type breakdown: one-to-one translations = 24.4% of errors; iconic concatenation = 23.3% of errors involving function 3. Open-ended task (n=29): mutual exclusivity adherence = 93.1%. MLC (Meta-Learning as Compositional) (joint) is too rigid at 99% ME — it overfits to the modal inductive bias rather than the distribution.

- **Standard transformer: 0% exact match, same architecture.** A basic seq2seq transformer trained in the standard way on the same instruction task (same architecture, same optimizer) achieves 0% exact-match accuracy. The architecture is not the bottleneck — the training objective is. This is the cleanest controlled demonstration that episodic training objective matters more than model capacity for systematic generalization.

- **Scalability architecture for long in-context sequences.** Vanilla concatenation of all study examples + query hits O(S²) encoder self-attention with S ≈ 1,500 on COGS. Fix: copy query N times, concatenate each copy with one study example → N short source sequences processed independently. Index embeddings mark study-example origin; decoder cross-attends over the combined set. Same standard transformer components; O(S·T) decoder cost only.

---

## Limitations

- MLC (Meta-Learning as Compositional) fails completely on structural/productivity generalization (length split, novel sentence structure): 100% error on SCAN length and COGS structural types. Meta-learning succeeds when the test episode is in-distribution with respect to training grammar variation but fails when entire episode types are out-of-distribution.
- Task-specialist: requires domain-specific meta-training. Not transferable across domains without retraining the slow outer loop.
- MLC (Meta-Learning as Compositional) (joint) applies mutual exclusivity too absolutely (99%) vs. human 93.1% / human within-context variation. Meta-learning can overfit to the modal prior rather than learning its distribution.
- Untested on natural language at scale, visual modalities, or multi-step causal chains (ARC-AGI-style rule hierarchies).

---

## Links

- [[wiki/entities/mlc-model.md]] — MLC (Meta-Learning as Compositional) architecture (1.4M params, 3L/8H/128D), benchmark results table, scalability technique
- [[wiki/concepts/compositional-generalization.md]] — lexical/structural split updates open problem 2; 0% basic seq2seq confirms training-objective primacy
- [[wiki/concepts/meta-learning.md]] — MLC (Meta-Learning as Compositional) as non-RL instantiation of slow/fast meta-learning structure; knowledge-boundedness instantiated at grammar level
- [[wiki/papers/compositionality-decomposed-hupkes-2020.md]] — Hupkes et al. five-facet framework MLC (Meta-Learning as Compositional) builds on
- [[wiki/concepts/abstract-reasoning.md]] — human behavioral rates (80.7% accuracy, quantified error types) as design targets for human-like reasoning
