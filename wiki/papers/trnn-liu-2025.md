---
title: "Recurrent neural networks with transient trajectory explain working memory encoding mechanisms — Liu et al., Communications Biology 2025"
type: paper
tags: [working-memory, recurrent-networks, transient-trajectory, attractor, RNN, reinforcement-learning]
created: 2026-06-19
updated: 2026-06-19
sources: [Recurrent neural networks with transient trajectory explain working memory encoding mechanisms]
related: [wiki/concepts/working-memory.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/neural-manifolds.md, wiki/entities/reservoir-computing.md, wiki/queries/building-blocks-mec-hc-pfc.md]
---

# Recurrent neural networks with transient trajectory explain working memory encoding mechanisms

Liu C., Jia S., Liu H., Zhao X., Li C.T., Xu B., Zhang T. *Communications Biology* 8, 51 (2025). doi: 10.1038/s42003-024-07282-3

---

## Key Computational Insights

- **Transient trajectory encoding outperforms attractor encoding.** Three modifications to a vanilla RNN (self-inhibition, sparse connections, hierarchical sensory→association→motor topology) produce a Transient RNN (TRNN) with higher Transient Index (TI), better delayed-choice performance, and dramatically better spatial navigation WM; vanilla RNN reduces to feedforward-level performance on the water maze task.

- **Self-inhibition (SFA analog) is the mechanistically critical modification.** A slow negative feedback term $V_t = (1 - \alpha_v)V_{t-1} + \alpha_v m r_{t-1}$ suppresses recent high-activity neurons, preventing collapse to attractor fixed points and forcing asymmetric feedforward connectivity where activity propagates through a sequential neuron chain.

- **Information richness (entropy) scales linearly with TI; energy cost drops stepwise.** For matched network size, higher TI → higher Shannon entropy of delay-period activity (more representational capacity) and lower average squared firing rate (less metabolic cost). Transient coding is a free lunch: more capacity, less energy.

- **Variable delay handled by neuron recruitment, not slower trajectory velocity.** TRNN (Transition RNN) maintains accuracy across 3–6 s delays by recruiting additional neurons for longer delays; late-memory neurons are recruited from baseline and test-response groups. WM duration is neuron-count limited, not attractor-slot limited — directly paralleling the biological 7±2 capacity limit.

- **dPCA confirms low-dimensional trajectory manifold.** Demixed PCA of TRNN (Transition RNN) hidden states during delay reveals that stimulus-dependent trajectory components remain separated throughout the entire delay period; trajectory velocity does not slow toward the end (memory is dynamically maintained in trajectory path, not a fixed point attractor).

---

## Limitations

- Rate-coded neurons only; spike-timing contributions to WM are not modeled — spike-time coding may add capacity not captured here.
- Spiking RNN equivalent not trained; efficiency claims derived from firing-rate proxy for metabolic cost.
- Self-inhibition hyperparameters (γ, m) set manually per task; no learned or biologically derived auto-tuning.

---

## Links

- [[wiki/concepts/working-memory.md]] — creates this concept page; five alternative WM theories contextualized
- [[wiki/concepts/two-learning-timescales.md]] — TRNN (Transition RNN) is a third fast WM mechanism: transient trajectory (activity-based, no write step) distinct from Hebbian M and PFC (Prefrontal Cortex) LSTM
- [[wiki/concepts/neural-manifolds.md]] — dPCA result adds trajectory manifold evidence to the manifold concept page
- [[wiki/entities/reservoir-computing.md]] — Barak 2013 comparison: reservoir (transient dynamics, frozen W) already outperforms pure attractor RNN; TRNN (Transition RNN) adds learned hierarchical structure
- [[wiki/queries/building-blocks-mec-hc-pfc.md]] — Block 3B (Working Memory) bridge should prefer TRNN (Transition RNN) over vanilla LSTM for capacity and spatial navigation
