---
title: "MLC (Meta-Learning for Compositional generalization)"
type: entity
tags: [meta-learning, compositional-generalization, systematicity, transformer, seq2seq]
created: 2026-06-19
updated: 2026-06-19
sources: [Human-like_systematic_generalization]
related: [wiki/concepts/meta-learning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/structural-generalization.md, wiki/papers/mlc-lake-baroni-2023.md, wiki/papers/compositionality-decomposed-hupkes-2020.md, wiki/papers/arc-agi-3-paper.md]
---

# MLC — Meta-Learning for Compositional generalization

Lake & Baroni, Nature 2023. A transformer meta-trained on episodic compositional tasks to achieve human-like systematic generalization.

---

## Architecture

| Component | Description |
|---|---|
| **Base model** | Transformer encoder-decoder |
| **Training paradigm** | Episodic meta-learning: each of 100K training episodes uses a *different* context-free grammar to generate input→output mappings |
| **Fast mechanism** | Transformer attention over in-context study instructions (few examples of the episode's grammar) |
| **Slow mechanism** | Backprop across 100K episodes shapes weights to capture cross-episode compositional structure |
| **Task format** | Seq2seq: nonsense words → color sequences; rules like `wif` = triple; `kiki` = permute |

**Variants:**
- **MLC** — trained on few-shot instruction task only
- **MLC (algebraic only)** — trained on the algebraic subset of the instruction task
- **MLC (joint)** — additionally trained on open-ended human response data

---

## Key Results

| Model | Few-shot instruction accuracy | Novel rule accuracy |
|---|---|---|
| **MLC** | 92.9% (SD 8.2) | 99.3% |
| **MLC (joint)** | 96.8% (SD 5.2) | 99.8% |
| **MLC (algebraic only)** | 93.6% (SD 9.0) | 99.4% |
| **GPT-4** (sorted, batched) | 58.0% (SD 14.0) | — |
| **GPT-4** (random order) | 14.0% (SD 19.0) | — |
| **Humans** | 80.7% | — |

**Novel rule test:** 26 rules held out from all 100K training episodes; evaluated at 130 test episodes (5 per rule). MLC infers and applies novel rules purely from frozen weights + in-context examples.

---

## Limitations

- Task-specialist: must be meta-trained on target compositional domain; not plug-and-play for arbitrary new domains.
- MLC (joint) applies mutual exclusivity too rigidly (98%) vs. humans (68%) — overfits to the modal inductive prior rather than learning the distribution.
- Vocabulary is fixed (nonsense words, colors); extension to open-vocabulary domains requires re-training or architectural modification.
- Source is SI only; full training details and architecture hyperparameters are in the main paper.

---

## Comparison to Related Models

| Model | Systematicity mechanism | Localism | Novel rule generalization | Requires task-specific training |
|---|---|---|---|---|
| **MLC** | Episodic meta-learning | High (inferred from context) | Yes (99%+) | Yes (100K episodes) |
| **Transformer (Hupkes 2020)** | Attention over full sequence | 0.54 | No | Standard seq2seq |
| **GPT-4** | In-context pattern matching | Fragile (collapses with order change) | Partial | No (pre-trained) |
| **TEM** | Factorized W/M + Hebbian binding | — (spatial domain) | W transfers to new environments | Yes (training environments) |

---

## Connections

- **[[wiki/concepts/meta-learning.md]]** — MLC is the compositional-generalization instantiation of slow/fast meta-learning: slow backprop across episodes trains weights; fast transformer attention infers grammar rules within each episode without weight updates.
- **[[wiki/concepts/compositional-generalization.md]]** — MLC addresses the chunking failure identified by Hupkes et al. 2020: episodic training with a different grammar per episode prevents co-occurrence chunking and forces atomic rule learning.
- **[[wiki/concepts/structural-generalization.md]]** — MLC demonstrates that the training objective (episodic meta-learning vs. standard next-token prediction) is as important as the architecture for achieving structural transfer; a transformer with the right training regime generalizes where the same architecture with standard training fails.
- **[[wiki/papers/mlc-lake-baroni-2023.md]]** — primary source (SI); main paper contains full architecture and benchmark.
- **[[wiki/papers/compositionality-decomposed-hupkes-2020.md]]** — Hupkes et al. 2020 established the five-facet benchmark against which MLC's improvement should be measured; MLC targets the systematicity/localism facets where all 2020 architectures failed.
- **[[wiki/papers/arc-agi-3-paper.md]]** — the LRM knowledge-boundedness theorem applies to MLC: the fast inner loop cannot generalize beyond the slow outer loop's 100K-grammar training distribution, making MLC subject to the same ceiling as other LRMs on genuinely novel grammatical domains.
