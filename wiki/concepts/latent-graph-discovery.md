---
title: "Latent Graph Discovery"
type: concept
tags: [latent-graph-discovery, abstract-reasoning, structural-generalization, problem-framing, graph-inference]
created: 2026-06-20
updated: 2026-06-20
sources: []
related: [wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/path-integration.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/analogical-reasoning.md, wiki/concepts/latent-states.md, wiki/entities/tem-model.md, wiki/entities/arc-agi.md, wiki/entities/cscg-model.md, wiki/entities/tiwm-model.md]
---

# Latent Graph Discovery

**CORE PROBLEM FRAMING — The unified problem a brain-inspired reasoning model must solve.**

**Latent graph discovery = infer the structure (nodes, edges, topology) of a relational graph from observations, then navigate it — where the graph is never given explicitly and must be recovered from partial, aliased, or sequential evidence.**

This framing subsumes most cognitive tasks: abstract reasoning, analogy, planning, mathematics, navigation, and scientific discovery all reduce to recovering an implicit relational structure and using it to generate predictions, plans, or inferences.

---

## The Graph Formalization

| Element | Interpretation |
|---|---|
| **Nodes** | Observations / states of the world |
| **Edges** | Transformations / actions that move between states |
| **Edge labels** | The rule or operation applied (often unknown) |
| **Topology** | The relational skeleton of the domain |

The graph is **never directly observable**. It must be inferred from sequences of (observation, action, next-observation) triples — or from before/after pairs alone (ARC-AGI style), where edge labels are what must be recovered.

---

## Taxonomy: What Is Latent?

Tasks differ by which graph components are hidden. This is more principled than domain enumeration: it reveals what the model must compute regardless of surface form, and predicts which task types share computational structure.

| Latent component | Observed | Canonical examples |
|---|---|---|
| **Edges** (transformation rules) | Start + end node pairs | ARC-AGI, IQ tests, analogy tasks |
| **Path** (sequence of edges) | Start + end nodes | Navigation, planning, route-finding |
| **Node content** (partial state) | Path + partial content | Algebra, physics problems, constraint satisfaction |
| **Graph topology + edges** | Observations only | Scientific discovery, causal learning, exploration |

---

## Two-Level Graph Hierarchy

Every reasoning domain has two nested graph levels:

| Level | Role | Examples |
|---|---|---|
| **Meta-graph** | Shared transition structure across all tasks in the domain | Arithmetic operators; kinship relations; ARC-AGI transformation types |
| **Instance-graph** | Task-specific topology for a single problem | The particular equation to solve; one ARC-AGI grid pair |

A system that conflates these levels cannot transfer: it must relearn the meta-graph rules from scratch for each new instance. Separating them is the core requirement of structural generalization ([[wiki/concepts/structural-generalization.md]]).

Direct mapping to the W/M split ([[wiki/concepts/two-learning-timescales.md]]):
- **Slow W** ← meta-graph (shared structure, learned across many episodes)
- **Fast M** ← instance-graph (episode-specific, bound within a context)

And to the factorized code ([[wiki/concepts/factorized-representations.md]]):
- **g** (structural code) ← position in the meta-graph
- **x** (sensory code) ← node content
- **p = f(g, x)** ← conjunction anchoring content to graph position

---

## Four Sources of Hardness

| Source | Description | Architectural implication |
|---|---|---|
| **Two-level entanglement** | Meta-graph rules and instance-graph quirks co-occur in every observation; separating them requires many diverse episodes | Factorized latent space + two distinct learning rates |
| **Unknown vocabulary** | The action set, node types, or both are not given; they must be inferred alongside graph structure | Learnable observation and transformation embeddings |
| **Observation aliasing** | The same observation appears at structurally distinct positions; path context must disambiguate | Clone cells or path-integrated identity ([[wiki/entities/cscg-model.md]]) |
| **Simultaneity** | In hardest tasks, structure must be inferred *while* navigating — no clean discovery-then-use separation | Joint inference loop: update graph estimate and navigate concurrently |

---

## Why Current Architectures Fail

| Architecture | Satisfies | Fails |
|---|---|---|
| Transformer | Substitutivity; powerful fast-M analog | Two-level entanglement; path-consistency; localism gap |
| Reservoir computing | Temporal memory | No structured transition rules; cannot compress meta-graph across environments |
| CSCG | De-aliasing (source 3) | No cross-environment meta-graph; two-level entanglement unaddressed |
| TEM | Two-level separation; path-consistency; factorization; de-aliasing | Pre-given action vocabulary; flat (non-hierarchical) meta-graph |
| LLMs / LRMs | In-context adaptation within training distribution | Knowledge-bounded: fast inner loop cannot generalize beyond pretraining envelope to genuinely novel graph structures |

No current architecture satisfies all four hardness sources simultaneously.

---

## Connection to ARC-AGI

ARC-AGI is the primary empirical instantiation of latent edge discovery:
- **Nodes** = grid states; **Edges** = unknown transformation rules
- **Task** = infer edge labels from sparse (before, after) pairs, then apply inferred rule to a new start node
- **ARC-AGI-3 extension** = the *target node itself* is also latent — the agent must discover what constitutes a desirable outcome, not just which transformation achieves it

---

## Architectural Requirements

| Requirement | Mechanism |
|---|---|
| Two-level separation | Factorized latent space: g (meta-graph position) ≠ x (node content) |
| Meta-graph learning | Slow W update over many episodes |
| Instance-graph binding | Fast Hebbian M within episode |
| De-aliasing | Path-context-sensitive identity (clone cells or path-integrated g) |
| Path-consistency | g must commute: same meta-graph position via any path |
| Vocabulary learning | Observation + action embeddings learnable, not fixed |
| Multi-level hierarchy | W itself structured as a discoverable graph (open problem) |

---

## Open Problems

1. **Multi-level meta-graph:** can W itself be discovered as a latent graph? How many nesting levels does a general reasoning model need?
2. **Vocabulary co-discovery:** how does the system learn its action alphabet jointly with meta-graph structure, without a pre-given symbol set?
3. **Aliasing with latent node content:** when node content is partially latent, aliasing and content learning interact — no current model handles both simultaneously.
4. **Graph richness criterion:** what properties make an instance-graph sufficient to license ARC-AGI-class compositional transfer — what is the minimum required topology?

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — structural generalization is latent meta-graph discovery: extracting shared transition structure W across environments and immediately applying it to new instance-graphs without relearning.
- **[[wiki/concepts/factorized-representations.md]]** — the g/x/p factorization is the direct architectural solution to two-level entanglement: g tracks meta-graph position, x encodes node content, p binds them per episode.
- **[[wiki/concepts/two-learning-timescales.md]]** — slow W learns the meta-graph over many episodes; fast M binds the instance-graph within one episode; the W/M split is the computational implementation of the two-level hierarchy.
- **[[wiki/concepts/path-integration.md]]** — path integration maintains path-consistency of g: the structural code must return to the same meta-graph position via any path, which requires integrating transitions rather than memorizing node addresses.
- **[[wiki/concepts/latent-states.md]]** — latent states are the hidden nodes of the instance-graph when observation aliasing is present; splitter/lap/evidence cells are biological implementations of path-context-sensitive node identity.
- **[[wiki/entities/cscg-model.md]]** — CSCG addresses hardness source 3 (aliasing) via clone cells: multiple latent nodes per observation, path context selecting the correct clone; handles within-environment de-aliasing but not cross-environment meta-graph transfer.
- **[[wiki/entities/tem-model.md]]** — TEM is the reference proof-of-concept: it solves sources 1 and 3 (two-level separation + de-aliasing) but requires a pre-given action vocabulary (source 2 unmet) and is limited to flat (non-hierarchical) meta-graphs.
- **[[wiki/entities/arc-agi.md]]** — ARC-AGI is the primary empirical target: edge labels (transformation rules) are latent; ARC-AGI-3 additionally makes the target node latent, operationalizing the hardest case of the taxonomy.
- **[[wiki/concepts/abstract-reasoning.md]]** — abstract reasoning is latent graph discovery + causal model construction: the causal model encodes the generative process giving edges their meaning, enabling counterfactual and explanatory queries beyond pattern-matching edge labels.
- **[[wiki/concepts/compositional-generalization.md]]** — compositional generalization addresses the case where meta-graph edges are themselves composed of atomic primitives; latent graph discovery must recover atomic edge types, not just their chunks.
- **[[wiki/concepts/analogical-reasoning.md]]** — analogy is latent edge discovery: given a source graph (understood causal model) and target (partially observed), map source edge labels onto target and infer unobserved target edges via CWSG; schema induction builds new meta-graph entries from episodic comparison.
- **[[wiki/entities/tiwm-model.md]]** — TIWM is the primary architectural proposal for Type 2 latent-edge discovery; the Transformation Inferrer is the mechanism for recovering hidden edge labels from sparse (g_in, g_out) pairs using the W vocabulary bidirectionally.
