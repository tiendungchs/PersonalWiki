---
title: "HAMI (Hippocampal-Augmented Memory Integration)"
type: entity
tags: [reinforcement-learning, episodic-memory, hippocampus, CAM, neuromorphic, sequential-decision-making, symbolic-indexing, episodic-control]
created: 2026-06-23
updated: 2026-06-23
sources: [A scalable reinforcement learning framework inspired by hippocampal memory mechanisms for efficient contextual and sequential decision making]
related: [wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/associative-memory.md, wiki/concepts/pattern-separation.md, wiki/entities/dnc-model.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/papers/hami-poursiami-2025.md]
---

# HAMI (Hippocampal-Augmented Memory Integration)

Biologically inspired episodic control framework for context-dependent sequential decision-making. Introduced by Poursiami et al. 2025 ([[wiki/papers/hami-poursiami-2025.md]]).

---

## Architecture

| Component | Biological analog | ML implementation |
|---|---|---|
| **Event encoder** (pretext contrastive) | LEC — sensory event content | Siamese CNN → 64-dim embedding; trained with contrastive loss (10 epochs, 10k pairs) |
| **Context encoder** (pretext contrastive) | MEC — structural/contextual code | Siamese CNN → 64-dim embedding; separate from event encoder |
| **Symbolic indexing associative memory** | CA3 — conjunctive event-in-context binding | Cosine-similarity thresholding → 6-bit (event, context) symbol pair; dynamic expansion |
| **Sequence buffer** | CA3 recurrent replay / sliding temporal context | Sliding window of recent symbolic observations (within-episode) |
| **Temporal integrator** | CA1 — past/present/future integration | Aggregates sequence buffer → structured query for episodic memory |
| **Episodic memory** | HC fast-M store | (symbolic-sequence, action, return) tuples; persists across episodes |
| **Memory refinement** | Hippocampal consolidation / value-based reactivation | Replace stored entry only if new return > old return |
| **Action selection** | PFC (Prefrontal Cortex) — memory-guided decision-making | Exact match → max-return action; no match → explore (train) / nearest-neighbor (test) |

---

## Key Results (HiCoS benchmark)

| Metric | HAMI | DQN (baseline) | Knowledge-Enhanced-EC |
|---|---|---|---|
| Action accuracy | **~95%** | ~82% | ~90% |
| Inference time | Fast (exact lookup) | Fast (feedforward) | **24× slower** (k-NN) |
| Memory footprint | **~32 KB** (episodic + symbolic only) | Larger (replay buffer) | Larger (high-dim vector store) |
| Training episodes to plateau | ~5,000 | >20,000 | ~4,000 (lower final reward) |

HiCoS (Hierarchical Contextual Sequences): non-Markovian 2-class RL environment (in-sequence / out-of-sequence decisions), 4 context-dependent rules over Colored-MNIST digits.

---

## Limitations

- **No structural generalization**: symbolic indices are environment-specific; no slow-W transfer across environments (the gap TEM addresses).
- **6-bit quantization ceiling**: within-category detail is discarded; 43.54% of hyperparameter configurations achieve ≥90% accuracy, but threshold sensitivity affects fine-grained discrimination.
- **Narrow evaluation**: only HiCoS tested; no evidence of performance on standard RL benchmarks or multi-environment transfer.
- **Instance-based only**: no forward simulation or planning; HAMI cannot reason about hypothetical future sequences.

---

## Comparison to Related Models

| Model | Episodic memory | Structural W generalization | Retrieval | Planning |
|---|---|---|---|---|
| **HAMI** | Yes (symbolic) | No | Exact symbol match (O(1)) | No |
| DNC (Differentiable Neural Computer) | Yes (external matrix) | No | Soft content attention | Via preplay (brainstorm) |
| MFEC/NEC | Yes (high-dim vectors) | No | k-NN Euclidean (O(N)) | No |
| TEM | Yes (Hebbian M) | Yes (W transfers across envs) | Attractor-based | No |
| CSCG | Yes (clone-state model) | No | Bayesian Expectation Maximization (EM) | No |

**The key differentiator**: HAMI's symbolic quantization converts k-NN retrieval (O(N) over high-dimensional space) into exact lookup (O(1) over symbol space), with a hardware-aligned binary representation for Non-Volatile Memory Content-Addressable Memory (NVM-CAM). The cost is loss of generalization to unseen fine-grained feature combinations.

---

## Connections

- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — HAMI directly instantiates the LEC (event encoder) / MEC (context encoder) / CA3 (conjunctive symbolic coding) / CA1 (temporal integration) / PFC (Prefrontal Cortex) (action selection) biological circuit as a sequential ML system; the clearest RL-level operationalization of the hippocampal processing pipeline.
- **[[wiki/concepts/associative-memory.md]]** — HAMI's episodic memory with exact-symbol lookup is a sparse symbolic variant of content-addressable retrieval; the symbolic indexing module implements a dynamic codebook (expandable vocabulary) rather than a fixed attractor landscape; NVM-CAM hardware targets single-clock-cycle parallel search across all stored (symbol, action, return) tuples.
- **[[wiki/concepts/pattern-separation.md]]** — symbolic indexing performs an approximate form of input orthogonalization: cosine-threshold quantization maps nearby embeddings to the same symbol (completion) and distant embeddings to distinct symbols (separation); this is a discrete analog of DG's continuous competitive orthogonalization.
- **[[wiki/entities/dnc-model.md]]** — DNC (Differentiable Neural Computer) and HAMI both implement episodic external memory for non-Markovian environments; DNC (Differentiable Neural Computer) uses soft content attention over high-dimensional rows (flexible generalization, slower retrieval); HAMI uses exact symbolic match (fast retrieval, no within-category generalization); HAMI's symbolic approach is the CAM-hardware-optimized extreme of the DNC (Differentiable Neural Computer) content-lookup paradigm.
- **[[wiki/concepts/factorized-representations.md]]** — the event/context encoder split is a direct ML instantiation of the LEC/MEC factorization: event (LEC, specific item content) and context (MEC, structural rule) representations are computed independently before being combined into a conjunctive symbolic code, matching the TEM g/x/p architecture at the RL decision-making level.
- **[[wiki/concepts/two-learning-timescales.md]]** — pretext contrastive training of event/context encoders = slow-W learning (shared across all episodes); symbolic episodic memory = fast-M write (episode-specific, single-shot); the two-timescale structure is explicit but HAMI's slow-W (pretext encoders) does not generalize across environments, unlike TEM's W.
