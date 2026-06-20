---
title: "Robust and brain-like working memory through short-term synaptic plasticity — Kozachkov et al., PLoS Comput Biol 2022"
type: paper
tags: [working-memory, STSP, RNN, PFC, activity-silent, robustness]
created: 2026-06-19
updated: 2026-06-19
sources: [Robust and brain-like working memory through short-term synaptic plasticity]
related: [wiki/concepts/working-memory.md, wiki/concepts/two-learning-timescales.md, wiki/papers/trnn-liu-2025.md]
---

**Citation:** Kozachkov L, Tauber J, Lundqvist M, Brincat SL, Slotine J-J, Miller EK (2022). *Robust and brain-like working memory through short-term synaptic plasticity.* PLoS Computational Biology 18(12): e1010776.

- NHP PFC (dlPFC/vlPFC, 256 electrodes, macaque, delayed match-to-sample) spike-rate decoder drops to chance within ~1s of sample offset even at delays up to 4s; pre- vs. post-sample activity remains distinguishable — memory is not in sustained firing rates, but state is not simply reset.
- STSP models (PS-pre: presynaptic calcium dynamics from Mongillo 2008; PS-hebb: anti-Hebbian excitatory + Hebbian inhibitory) match NHP decoder profiles across ~2000 hyperparameter configurations; fixed-synapse attractor models (FS-tanh, FS-relu) maintain high spike-rate decodability throughout delay, contradicting the data.
- PS-hebb is most brain-like and most structurally robust: tolerates 50% random synapse ablation with negligible performance loss; fixed-synapse networks fail at 10–20% ablation. Anti-Hebbian excitatory rule (reduces weights when activity too correlated) provides provable stability; purely Hebbian STSP is unstable.
- Dual-mode operation: sparse spiking during maintenance (WM in synaptic weights); burst spiking during readout (spikes "ping" the synaptic state to extract information). Explains why delay-period spiking depends on task type — spatial hold-and-go tasks (known response, inhibit it) produce sustained spiking; delayed match-to-sample (response unknown until test) produces sparse spiking.
- LSTM/GRU are more robust to process noise than STSP, but less brain-like — brain appears to optimize for structural robustness over process-noise robustness, consistent with ~40%/5-day dendritic synapse turnover rate in sensory cortex.

**Limitations:** Single-circuit model (no hippocampus, no inter-area communication); demonstrates maintenance but not manipulation or downstream decision readout; synaptic-state timescale (~200ms calcium decay) limits how long information can bridge without any spiking.

→ [[wiki/concepts/working-memory.md]] — adds STSP as 4th fast WM mechanism (synaptic-state-based, activity-silent); empirically confirms activity-silent WM in NHP PFC
→ [[wiki/concepts/two-learning-timescales.md]] — STSP occupies the fast-timescale slot with a distinct storage medium (transient synaptic efficacy) and its own write mechanism (calcium dynamics)
