---
title: "MLC (Meta-Learning for Compositional generalization)"
type: entity
tags: [meta-learning, compositional-generalization, systematicity, transformer, seq2seq]
created: 2026-06-19
updated: 2026-06-21
sources: [Human-like systematic generalization through a meta-learning neural network]
related: [wiki/concepts/meta-learning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/structural-generalization.md, wiki/papers/mlc-lake-baroni-2023.md, wiki/papers/compositionality-decomposed-hupkes-2020.md, wiki/papers/arc-agi-3-paper.md]
---

# MLC (Meta-Learning as Compositional) — Meta-Learning for Compositional generalization

Lake & Baroni, Nature 2023. A transformer meta-trained on episodic compositional tasks to achieve human-like systematic generalization.

---

## Architecture

| Component | Description |
|---|---|
| **Base model** | Standard seq2seq transformer (encoder-decoder) |
| **Parameters** | ~1.4M |
| **Layers** | 3 encoder + 3 decoder |
| **Attention heads** | 8 per layer |
| **Hidden / embedding dim** | 128 |
| **FFN hidden size** | 512 |
| **Activation** | GELU (GPT-style, not ReLU) |
| **Positional encoding** | Sinusoidal |
| **Training paradigm** | Episodic meta-learning: each of 100K episodes uses a *different* randomly generated interpretation grammar |
| **Fast mechanism** | Encoder attends over concatenated [query input + study examples]; decoder generates output — no weight update at test time |
| **Slow mechanism** | Backprop across 100K episodes shapes weights to embed cross-episode rule-learning capacity |
| **Task format** | Seq2seq: nonsense words → abstract output sequences (colour circles); rules like function1=triple, function3=reverse-concatenate |
| **Optimizer** | Adam, lr=0.001, batch=25 episodes, 50 epochs |

**Variants:**
- **MLC** — few-shot instruction task, mixed algebraic + biased outputs (80/20)
- **MLC (algebraic only)** — same episodes, purely algebraic target outputs
- **MLC (joint)** — additionally meta-trained on open-ended human response data
- **MLC (copy only)** — trained on copy task only; control showing 0% systematic generalization

**Scalability architecture for long in-context sequences (SCAN/COGS):** Copy query N times, concatenate each copy with one study example → N short source sequences processed independently by shared encoder. Index embeddings mark study-example origin. Decoder cross-attends over combined set via standard cross-attention. Reduces O(S²) encoder self-attention to O(S·T) decoder cost.

---

## Key Results

### Human Behavioural Comparison

| Model | Few-shot accuracy | Sampled accuracy | ME adherence |
|---|---|---|---|
| **Humans** | 80.7% | — | 93.1% |
| **MLC** | 100% (best run, greedy) | 82.4% | — |
| **MLC (joint)** | 96.8% | — | 99% (too rigid) |
| **Basic seq2seq** | **0%** | — | — |
| **GPT-4 (sorted)** | 58% | — | — |
| **GPT-4 (random order)** | 14% | — | — |

Human error types: one-to-one translations = 24.4% of errors; iconic concatenation = 23.3% of function-3 errors. MLC (Meta-Learning as Compositional) matches these within 2×.

### Machine Learning Benchmarks (SCAN / COGS)

| Benchmark | Split type | MLC (Meta-Learning as Compositional) error | Basic seq2seq |
|---|---|---|---|
| SCAN | add jump (lexical) | 0.22% | ~7× higher |
| SCAN | around right (lexical) | ≤0.22% | ~7× higher |
| SCAN | opposite right (lexical) | ≤0.22% | ~7× higher |
| COGS | 18 lexical generalization types | 0.87% | ~7× higher |
| SCAN | length split (productivity) | **100%** | 100% |
| COGS | 3 structural types | **100%** | 100% |

**Critical split:** lexical generalization (new word meanings, recombination of known structural forms) ≈ solved. Structural/productivity generalization (new sentence structures, longer-than-trained sequences) = completely unsolved by current MLC.

---

## Limitations

- Fails completely on structural/productivity generalization (100% error on length/novel-structure splits).
- Task-specialist: requires meta-training on target compositional domain; not plug-and-play for new domains.
- MLC (Meta-Learning as Compositional) (joint) applies mutual exclusivity too rigidly (99%) vs. humans (93.1%) — overfits to modal prior distribution.
- Vocabulary is fixed (nonsense words, colours); open-vocabulary extension requires architectural modification.
- LRM (Large Reasoning Model) knowledge-boundedness applies: fast inner loop cannot generalize beyond the slow outer loop's 100K-grammar training distribution.

---

## Comparison to Related Models

| Model | Systematicity mechanism | Localism | Novel rule generalization | Requires task-specific training |
|---|---|---|---|---|
| **MLC** | Episodic meta-learning | High (inferred from context) | Yes (99%+, lexical) | Yes (100K episodes) |
| **Transformer (Hupkes 2020)** | Attention over full sequence | 0.54 | No | Standard seq2seq |
| **GPT-4** | In-context pattern matching | Fragile (collapses with order change) | Partial | No (pre-trained) |
| **TEM** | Factorized W/M + Hebbian binding | — (spatial domain) | W transfers to new environments | Yes (training environments) |

---

## Connections

- **[[wiki/concepts/meta-learning.md]]** — MLC (Meta-Learning as Compositional) is the compositional-generalization instantiation of slow/fast meta-learning: slow backprop across episodes trains weights; fast transformer attention infers grammar rules within each episode without weight updates.
- **[[wiki/concepts/compositional-generalization.md]]** — MLC (Meta-Learning as Compositional) addresses chunking by ensuring no grammar-specific co-occurrence statistics exist across episodes; 0% basic seq2seq vs. 100% MLC (Meta-Learning as Compositional) accuracy confirms training objective primacy; lexical/structural split defines the remaining open problem.
- **[[wiki/concepts/structural-generalization.md]]** — MLC (Meta-Learning as Compositional) demonstrates that training objective is as important as architecture for structural transfer; the lexical vs. structural split maps to within-distribution vs. out-of-distribution grammar variation at the slow-loop level.
- **[[wiki/papers/mlc-lake-baroni-2023.md]]** — primary source; full architecture, behavioral data, SCAN/COGS results.
- **[[wiki/papers/compositionality-decomposed-hupkes-2020.md]]** — Hupkes et al. five-facet benchmark; MLC (Meta-Learning as Compositional) targets systematicity/localism where all 2020 architectures failed.
- **[[wiki/papers/arc-agi-3-paper.md]]** — LRM (Large Reasoning Model) knowledge-boundedness theorem applies to MLC: the fast inner loop cannot generalize beyond the slow outer loop's training distribution, so structural/productivity failure is not a fixable fine-tuning problem — it requires either a broader slow-loop distribution or a different architecture class.
