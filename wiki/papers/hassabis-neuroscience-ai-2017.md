---
title: "Neuroscience-Inspired Artificial Intelligence"
type: paper
tags: [neuroscience-ai, review, deep-learning, reinforcement-learning, continual-learning, episodic-control, simulation-planning, working-memory, attention]
created: 2026-06-21
updated: 2026-06-21
sources: [Neuroscience-Inspired Artificial Intelligence]
related: [wiki/concepts/continual-learning.md, wiki/concepts/working-memory.md, wiki/concepts/meta-learning.md, wiki/concepts/predictive-coding.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/papers/cls-mcclelland-1995.md, wiki/papers/cls-oreilly-2011.md, wiki/papers/pfc-meta-rl-wang-2018.md]
---

# Neuroscience-Inspired Artificial Intelligence

**Citation:** Hassabis, D., Kumaran, D., Summerfield, C., & Botvinick, M. (2017). Neuroscience-inspired artificial intelligence. *Neuron, 95*(2), 245–258. https://doi.org/10.1016/j.neuron.2017.06.011

Survey of historical and current AI-neuroscience interactions, with proposals for five under-leveraged future directions.

---

## Key Computational Insights

- **Algorithm-level extraction is the productive interface.** Neuroscience is most useful to AI at Marr's computational and algorithmic levels — not the implementation level (exact neural circuit details). Bio-plausibility is a search heuristic and validation signal, not a constraint. This reframes the entire neuro-AI program: look for *what* the computation is and *how* it works, not *where* in the neuron.
- **Episodic control as one-shot fast-M action selection.** HC episodic memory enables within-episode behavioral adaptation by selecting actions based on cosine similarity to stored (state, reward) episodes — bypassing the slow convergence of deep RL. Provides striking gains in the low-data regime and handles one-shot reward generalization that standard deep RL fails at; distinct from experience replay (which drives offline weight updates) in that episodic control drives *online action selection* from the episodic store.
- **Continual learning via synaptic consolidation → EWC.** Two-photon in vivo imaging reveals that strengthened dendritic spines exhibit reduced synaptic lability (spine enlargement → lower plasticity rate for those synapses); optogenetic erasure of consolidated spines selectively reinstates forgetting. Elastic Weight Consolidation (EWC) formalizes this as an importance-weighted penalty on weight deviation from prior task parameters, enabling multi-task sequential learning in a fixed-capacity network.
- **Simulation-based planning via hippocampal world model.** At choice points, HC sharp-wave ripples activate representations of candidate future trajectories (preplay) before movement is committed — an internal forward model generating rollouts for offline evaluation. PFC (Prefrontal Cortex) queries the HC world model; OFC/striatum evaluates simulated outcomes; hierarchical planning emerges from compositional recombination of trajectory segments. Deep generative models that maintain spatiotemporal coherence in generated sequences implement the AI analog.
- **Biologically plausible backpropagation.** Two objections resolved: (a) weight symmetry — feedback alignment (Lillicrap et al. 2016) shows random fixed backward weights suffice; forward weights adapt to align with backward projections, transmitting useful teaching signals. (b) Non-local error signals — energy-based networks and hierarchical autoencoders approximate backprop with purely local Hebbian-like updates (ε · x), structurally equivalent to STDP timing rules in predictive coding circuits.

---

## Limitations

- Broad 2017 survey; formal algorithmic depth is in the primary sources cited (EWC, DNC, Wang et al. meta-RL, episodic control networks). Claims about future directions are aspirational, not empirically established.
- "Virtual brain analytics" section remains under-specified: what specific neuroscience analysis tools apply to which AI architectures is not developed into actionable methods.

---

## Links

- [[wiki/concepts/continual-learning.md]] — EWC (Elastic Weight Consolidation) formalization of synaptic consolidation; CLS (Complementary Learning Systems) as two-system continual learning architecture
- [[wiki/concepts/meta-learning.md]] — episodic control as fast-M action selection; simulation-based planning as model-based inner loop
- [[wiki/entities/hippocampal-entorhinal-system.md]] — HC preplay/simulation as internal forward model for planning
- [[wiki/concepts/predictive-coding.md]] — biologically plausible backprop via feedback alignment and local PC (Predictive Coding) learning rules
- [[wiki/papers/cls-mcclelland-1995.md]] — experience replay / CLS (Complementary Learning Systems) theoretical background for continual learning and episodic memory
- [[wiki/papers/pfc-meta-rl-wang-2018.md]] — meta-RL as the full formal account of what Hassabis et al. gesture at in the meta-learning section
