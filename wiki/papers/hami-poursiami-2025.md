---
title: "A scalable reinforcement learning framework inspired by hippocampal memory mechanisms for efficient contextual and sequential decision making"
type: paper
tags: [hippocampus, reinforcement-learning, episodic-memory, CAM, neuromorphic, pattern-separation, sequential-decision-making, symbolic-indexing]
created: 2026-06-23
updated: 2026-06-23
sources: [A scalable reinforcement learning framework inspired by hippocampal memory mechanisms for efficient contextual and sequential decision making]
related: [wiki/entities/hami-model.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/associative-memory.md, wiki/concepts/pattern-separation.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/entities/dnc-model.md]
---

# HAMI — Poursiami et al. 2025

*Nature Scientific Reports (2025). DOI: 10.1038/s41598-025-10586-x.*

---

## Key Computational Insights

- **Event-context disentanglement maps to LEC/MEC split.** Two separate contrastive-pretrained Siamese CNNs process event (digit identity) and context (background color) independently — paralleling LEC's sensory event representations and MEC's structural/contextual code; conjunctive event-in-context codes are then formed in the symbolic indexing module, paralleling CA3 conjunctive coding.
- **Symbolic indexing as dynamic vocabulary.** High-dimensional (64-dim) embeddings are hashed to compact 6-bit symbolic indices via cosine-similarity thresholds; new symbols are added only when no existing entry is sufficiently similar. Reduces episodic retrieval from O(N) k-NN over high-dimensional vectors to O(1) exact lookup over a small codebook — 24× inference speedup over nearest-neighbor baseline (Knowledge-Enhanced-EC).
- **Hierarchical memory refinement as value-selective consolidation.** Episodic memories store (sequence-of-symbols, action, return) tuples; existing entries are replaced only when a higher-return experience is found for the same symbolic sequence. This is an explicit policy for what to retain — neither FIFO nor random, but value-ranked selection, analogous to memory consolidation in CLS.
- **Non-Markovian decision-making via structured symbolic retrieval.** A sliding sequence buffer maintains recent symbolic observations; a temporal integrator aggregates this into a structured query for episodic lookup. Exact symbolic match enables decision-making in POMDPs without gradient-based temporal credit assignment (contrast: LSTM encodes temporal context into weights; HAMI keeps it explicit).
- **NVM-CAM hardware alignment.** The 6-bit symbolic representation is designed for non-volatile memory (NVM) content-addressable memory (CAM) hardware — specifically 2T2R cells using RRAM/MRAM/PCM/FeFET — enabling single-clock-cycle parallel search across all stored memories.

---

## Limitations

- Symbolic quantization (6-bit) discards within-category feature detail; cannot distinguish novel event-context combinations that map to the same symbol pair.
- Evaluated only on HiCoS — a narrow 2-class non-Markovian benchmark; no tests on standard RL benchmarks (Atari, MuJoCo, or multi-task transfer).
- No cross-environment structural generalization; symbolic indices are environment-specific (no slow-W transfer as in TEM).

---

## Links

- [[wiki/entities/hami-model.md]] — full architecture, results, and comparison table
- [[wiki/entities/hippocampal-entorhinal-system.md]] — biological grounding; LEC/MEC event-context split; CA3 conjunctive coding instantiation
- [[wiki/concepts/associative-memory.md]] — symbolic indexing as NVM-CAM variant; comparison to DNC/Hopfield retrieval
- [[wiki/concepts/pattern-separation.md]] — cosine-threshold expansion as approximate input orthogonalization before symbolic storage
- [[wiki/concepts/factorized-representations.md]] — event/context encoder split instantiates LEC/MEC factorization in an RL context
- [[wiki/concepts/two-learning-timescales.md]] — pretext training = slow W; episodic symbolic memory = fast M; no cross-environment slow-W generalization
