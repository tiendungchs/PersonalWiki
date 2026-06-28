---
title: "A mechanistic theory of planning in prefrontal cortex"
type: paper
tags: [planning, prefrontal-cortex, attractor, world-models, working-memory, successor-representation, RNN, meta-learning]
created: 2026-06-28
updated: 2026-06-28
sources: [A mechanistic theory of planning in prefrontal cortex]
related: [wiki/entities/spacetime-attractor.md, wiki/concepts/planning-as-inference.md, wiki/entities/prefrontal-cortex.md, wiki/concepts/world-models.md, wiki/concepts/successor-representation.md, wiki/concepts/working-memory.md, wiki/concepts/ring-attractor.md, wiki/concepts/meta-learning.md, wiki/concepts/replay.md, wiki/concepts/prospective-coding.md]
---

# A mechanistic theory of planning in prefrontal cortex

Jensen, Doohan, Sablé-Meyer, Reinert, Baram, Akam & Behrens. eLife (2026). https://elifesciences.org/reviewed-preprints/109757

---

## Key Computational Insights

- **Spacetime Attractor (STA):** PFC neurons form subspaces indexed by delay δ, each encoding expected agent location δ steps into the future simultaneously. Subspace connectivity encodes the environment adjacency matrix. Attractor dynamics infer the optimal future trajectory from goal and current-location inputs — planning as inference, not sequential search.
- **Three-algorithm taxonomy:** TD learning (stable environments, striatum), Successor Representation (intermediate timescale reward changes, hippocampus), STA (within-trial dynamic rewards, PFC). The STA uniquely separates reward inputs per future timestep, so moving or time-varying goals are handled without re-learning.
- **RNNs discover STA:** RNNs meta-trained on a dynamic reward-landscape task spontaneously learn (i) explicit future representations with conveyor-belt dynamics, (ii) recurrent weights matching the environment adjacency matrix (correlation 0.91 ± 0.07), and (iii) attractor dynamics with stable fixed points. Simpler tasks allow energy-cheaper alternatives — the STA is selected by task difficulty, not architecture.
- **Structural generalization via transition gating:** networks trained across changing environments represent future *transitions* (not locations); wall-input inhibits unavailable transitions, making effective connectivity reflect the current maze structure without synaptic plasticity.
- **Hierarchical STAs:** stacking two STAs (abstract + concrete) produces plans exponentially long in hierarchy depth vs. linear scaling for a flat STA. Learning appropriate abstractions remains open.

## Limitations

- World model must be pre-embedded in synaptic weights — requires prior structural experience (hippocampal replay proposed as the learning mechanism); cannot plan in fully novel environments without prior W-learning.
- All analyses use small 4×4 grid mazes; scalability to high-dimensional state spaces (e.g., abstract rule graphs for ARC-AGI) is undemonstrated.
- Temporal depth of plan is bounded by the number of subspaces (number of future time slots); long-horizon plans would require many subspaces and many neurons.

## Links to Concept/Entity Pages

- [[wiki/entities/spacetime-attractor.md]] — full architecture and model details
- [[wiki/concepts/planning-as-inference.md]] — the core algorithmic concept introduced
- [[wiki/entities/prefrontal-cortex.md]] — STA as the mechanistic account of PFC planning
- [[wiki/concepts/world-models.md]] — STA as a world model embedded in synaptic weights
- [[wiki/concepts/successor-representation.md]] — STA vs SR comparison; three-algorithm taxonomy
- [[wiki/concepts/working-memory.md]] — conveyor belt dynamics; STA unifies WM and planning
- [[wiki/concepts/ring-attractor.md]] — STA as 3D generalization of ring/grid attractors
- [[wiki/concepts/meta-learning.md]] — STA is the algorithm meta-trained RNNs discover
- [[wiki/concepts/replay.md]] — HC replay as the proposed STA learning mechanism
