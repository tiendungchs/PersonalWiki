---
title: "Spatial Learning and Action Planning in a Prefrontal Cortical Network Model"
type: paper
tags: [PFC, prefrontal-cortex, topological-map, spreading-activation, planning, place-cells, prospective-coding, hippocampus, spatial-cognition]
created: 2026-06-28
updated: 2026-06-28
sources: ["Spatial Learning and Action Planning in a Prefrontal Cortical Network Model.md"]
related: [wiki/entities/prefrontal-cortex.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/place-cells.md, wiki/concepts/prospective-coding.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/memory-schemas.md]
---

# Spatial Learning and Action Planning in a Prefrontal Cortical Network Model

Martinet, Sheynikhovich, Benchenane & Arleo. *PLoS Comput Biol* 7(11): e1002045, 2011. PMC3098199.

---

## Key Computational Insights

- **PFC as topological latent graph learner** — a recurrent network of cortical minicolumns receives redundant hippocampal place-cell input and compresses it into a sparse topological graph via unsupervised Hebbian learning; each cortical column becomes selective to one environmental location (graph node), and collateral plasticity between columns encodes adjacency (graph edges); place-field density decreases from HC → PFC α → PFC β, retaining ~85% spatial information at ~5× sparser representation
- **Spreading activation = biologically plausible BFS** — planning proceeds in two neural phases: (1) reward signal back-propagates from the goal column through reverse state-associations (ψ connections), decaying exponentially per synapse so firing rate encodes distance-to-goal; (2) once the current-position column detects coincident goal signal and location signal, a forward path signal propagates (φ connections) toward the goal; WTA competition among minicolumn neurons reads out the optimal action; signal blockade at the topological level implements path blocking without requiring environment re-exploration
- **Four functionally distinct PFC neuron types** — (1) α neurons: location-selective (symmetric receptive fields, high spatial information); (2) β/γ neurons: distance-to-goal coding (unique preferred discharge frequency inversely correlated to distance; reward-related); (3) σ neurons: prospective coding (asymmetric left-skewed tuning curves; ranked pre-execution firing predicts serial order of the planned trajectory; anticipatory discharge ~75 ms ahead of the visited column); (4) π neurons: state-action value integration (WTA action selection; activity changes track reward contingency switches)
- **Multilevel hierarchical maps** — a second β column population uses a proprioceptive signal encoding turning probability as a gating signal: during straight runs the same column integrates multiple α activations (coarser abstraction); at turning points a new column is recruited; the resulting β representation encodes corridor-level topology and allows goal-signal propagation to cover more ground per synapse, enabling planning to scale to 4× larger environments without accuracy loss
- **HC/PFC computational division** — HC provides redundant distributed place-cell code suitable for localization; PFC elaborates a compact topological graph suitable for planning; the direction of causality is HC → PFC compression, not equivalence; PFC lesions impair maze-navigation planning in rats consistently with the topological graph being in PFC not HC

---

## Limitations

- Hippocampal model is highly simplified: no place-cell remapping under environment modification, no theta oscillations, no phase precession — limits predictions about HC-PFC synchrony at decision points
- Only a single appetitive motivational signal; multi-goal evaluation, effort-cost tradeoffs, and aversive motivation are outside the model scope
- Spreading activation implements BFS (shortest unblocked path), not reward-weighted or probabilistic planning — does not capture stochastic policy or risk-sensitive choice

---

## Links to Wiki Pages

- [[wiki/entities/prefrontal-cortex.md]] — extends the PFC functional properties section with topological map learning, spreading activation planning, distance-to-goal coding, and PFC prospective coding
- [[wiki/concepts/prospective-coding.md]] — adds PFC prospective neurons (σ type) with anticipatory asymmetric tuning and sequence order coding; distinct from HC one-step look-ahead
- [[wiki/concepts/latent-graph-discovery.md]] — PFC columnar model is the most direct biological instantiation of latent graph discovery: graph inferred from observations (place-cell input), never given explicitly; spreading activation is biologically plausible graph search
- [[wiki/concepts/hierarchical-representations.md]] — β column population is a biological multi-level topological map; spatial abstraction at the corridor level is a hierarchical representation driven by recurrent dynamics rather than additional layers
- [[wiki/concepts/memory-schemas.md]] — topological maps are spatial schemas; Tolman insight capability (choosing path 3 after blocking paths 1 and 2) is schema-based planning via the topological graph
- [[wiki/entities/hippocampal-entorhinal-system.md]] — HC provides the redundant spatial input; PFC compresses it; complementary not redundant roles in spatial planning
- [[wiki/entities/place-cells.md]] — hippocampal place cells are the afferent input to the PFC columnar network; sparsification from ~85% HC info → compact PFC code quantified
