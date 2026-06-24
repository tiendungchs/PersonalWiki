---
title: "Latent Graph Discovery"
type: concept
tags: [latent-graph-discovery, abstract-reasoning, structural-generalization, problem-framing, graph-inference]
created: 2026-06-20
updated: 2026-06-24
sources: []
related: [wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/path-integration.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/analogical-reasoning.md, wiki/concepts/latent-states.md, wiki/entities/tem-model.md, wiki/entities/arc-agi.md, wiki/entities/cscg-model.md, wiki/entities/tiwm-model.md, wiki/entities/dnc-model.md, wiki/entities/frontiermath-benchmark.md, wiki/entities/gsm-symbolic.md, wiki/entities/gsm-plus.md, wiki/entities/hle.md, wiki/papers/hutter-aixi-2000.md, wiki/papers/dnc-graves-2016.md, wiki/papers/shortcut-suite-yuan-2024.md, wiki/papers/shortcut-learning-geirhos-2020.md, wiki/papers/glazer-frontiermath-2024.md, wiki/papers/gsm-symbolic-2024.md, wiki/papers/gsm-plus-2024.md, wiki/papers/hle-hendrycks-2025.md, wiki/papers/hle-verified-zhai-2025.md]
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
| **Edges** (transformation rules) | Start + end node pairs | ARC-AGI, IQ tests, analogy tasks; FrontierMath (applicable theorems per problem) |
| **Path** (sequence of edges) | Start + end nodes | Navigation, planning, route-finding; FrontierMath (proof step sequence) |
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

## Five Sources of Hardness

| Source | Description | Architectural implication |
|---|---|---|
| **Two-level entanglement** | Meta-graph rules and instance-graph quirks co-occur in every observation; separating them requires many diverse episodes | Factorized latent space + two distinct learning rates |
| **Unknown vocabulary** | The action set, node types, or both are not given; they must be inferred alongside graph structure | Learnable observation and transformation embeddings |
| **Observation aliasing** | The same observation appears at structurally distinct positions; path context must disambiguate | Clone cells or path-integrated identity ([[wiki/entities/cscg-model.md]]) |
| **Simultaneity** | In hardest tasks, structure must be inferred *while* navigating — no clean discovery-then-use separation | Joint inference loop: update graph estimate and navigate concurrently |
| **Spurious edge covariate shift** | Training observations contain correlations that produce false edges (shortcuts): e.g., lexical overlap spuriously predicts entailment. False edges work IID but fail OOD when the spurious correlation is broken — the model has discovered the wrong graph. Larger LLMs are *more* susceptible under direct prompting (inverse scaling), because accumulated pretraining memorization provides more shortcut paths. | Training must force invariant causal edge discovery across diverse environments; IRM / meta-learning across distribution shifts; or explicit intermediate-node traversal (CoT) to prevent single-edge shortcut paths |

---

## Formal Ceiling: AIXI

**AIXI** (Hutter 2000 [[wiki/papers/hutter-aixi-2000.md]]) is the only known system that satisfies all four hardness sources simultaneously. It maintains a Bayesian mixture over **all computable environments** q weighted by 2^{-l(q)} — i.e., over all possible latent graphs, edge vocabularies, aliasing structures, and topologies — and acts via expectimax to maximize universal-prior-expected credit. The full history conditions ξ^AI, so aliasing is always resolved.

AIXI fails only on computability grounds: it is uncomputable. Every entry in the table below is a bounded-program approximation to it, failing on whichever hardness sources its program-search budget cannot reach.

---

## Why Current Architectures Fail

| Architecture | Satisfies | Fails |
|---|---|---|
| Transformer | Substitutivity; powerful fast-M analog | Two-level entanglement; path-consistency; localism gap |
| Reservoir computing | Temporal memory | No structured transition rules; cannot compress meta-graph across environments |
| CSCG | De-aliasing (source 3) | No cross-environment meta-graph; two-level entanglement unaddressed |
| TEM | Two-level separation; path-consistency; factorization; de-aliasing | Pre-given action vocabulary; flat (non-hierarchical) meta-graph |
| **DNC** | Instance-graph binding (fast M externalized); sequential path retrieval (temporal links); path traversal (empirically verified: 98.8% graph traversal, 81.8% inference) | Meta-graph cross-environment learning (controller W fixed); vocabulary co-discovery; no aliasing disambiguation |
| LLMs / LRMs | In-context adaptation within training distribution | Knowledge-bounded (Choi 2026 / ARC-AGI-3): fast inner loop cannot generalize beyond pretraining envelope. **Spurious edge susceptibility**: LLMs learn false edges from pretraining statistics; larger models are *more* prone under zero-shot/few-shot ICL (LLaMA2-70B drops to 0.8% on Constituent OOD, Yuan et al. 2024). CoT prompting partially bypasses this by forcing multi-hop traversal rather than single shortcut edges. **Mathematical graph fragility** (GSM-Symbolic/GSM-Plus 2024): cannot maintain computation graph topology under modification — irrelevant node insertion causes avg 65% collapse (GSM-NoOp); reversed edge direction causes up to 20% drop (GSM-Plus reversal); failures are structural, not arithmetic (97–99% arithmetic accuracy preserved) |
| **AIXI** | All four hardness sources; universal over all computable environments | Uncomputable; O(t̃ · 2^{l̃}) even in bounded form |
| **LAPA (VLA latent action)** | Vocabulary co-discovery (source 2, partial): learns discrete action codebook jointly with world model from unlabeled video; VQ-VAE on frame differences discovers a finite action alphabet | Alphabet is domain-specific (manipulation video); does not generalize across environments; no meta-graph structure |

No *computable* architecture satisfies all four hardness sources simultaneously.

---

## Connection to ARC-AGI

ARC-AGI is the primary empirical instantiation of latent edge discovery:
- **Nodes** = grid states; **Edges** = unknown transformation rules
- **Task** = infer edge labels from sparse (before, after) pairs, then apply inferred rule to a new start node
- **ARC-AGI-3 extension** = the *target node itself* is also latent — the agent must discover what constitutes a desirable outcome, not just which transformation achieves it

---

## Connection to FrontierMath

FrontierMath ([[wiki/entities/frontiermath-benchmark.md]]) is the formal-mathematics instantiation of latent edge + path discovery — the hardest configuration of the taxonomy:
- **Meta-graph** = the domain theorem network (Chebotarev density theorem, Coxeter groups, p-adic analysis, algebraic geometry…)
- **Instance-graph** = the proof/computation path for one specific problem
- **Latent** = both the applicable edge labels (which theorems apply) AND the path sequence — plus the vocabulary itself (unknown vocabulary hardness is maximally active: Tao estimates "a dozen relevant papers" per problem area, meaning the action alphabet is nearly empty at test time)
- **Observation aliasing** = the problem statement (a numerical computation request) gives no structural cue to the required proof path; surface form and latent graph topology are nearly uncorrelated

**Key contrast with ARC-AGI:** ARC-AGI holds the meta-graph vocabulary approximately fixed (Core Knowledge priors) and makes only instance-graph edges latent. FrontierMath additionally makes the meta-graph vocabulary latent — relevant theorems exist in training data but at near-zero density. This is a strictly harder configuration: both levels of the two-level hierarchy are simultaneously underspecified. Yet both benchmarks converge on <5% frontier AI performance, confirming that the bottleneck is latent structure inference at the instance level, not domain knowledge accumulation.

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
| **Causal edge invariance** | Edge labels must be learned from invariant causal structure, not i.i.d. correlations; requires training signal from diverse distribution shifts or explicit intermediate-node traversal to prevent single-hop shortcut edges from dominating |
| Multi-level hierarchy | W itself structured as a discoverable graph (open problem) |

**CoT as latent-graph traversal (Yuan et al. 2024):** Chain-of-thought prompting reduces shortcut reliance by 15–41% on adversarial NLI. In graph terms: CoT forces the model to materialize intermediate nodes (sub-steps) rather than taking a direct shortcut edge from observation to label. This is not a mechanism for discovering the correct causal graph — the edges were already learned during pretraining — but it biases path selection toward the intended multi-hop path over the memorized single-hop shortcut. The residual shortcut reliance under CoT (still ~30–40% on Constituent OOD for most models) reveals that CoT cannot fix fundamentally incorrect edge vocabularies, only select among existing ones.

---

## Open Problems

1. **Multi-level meta-graph:** can W itself be discovered as a latent graph? How many nesting levels does a general reasoning model need?
2. **Vocabulary co-discovery:** how does the system learn its action alphabet jointly with meta-graph structure, without a pre-given symbol set?
3. **Aliasing with latent node content:** when node content is partially latent, aliasing and content learning interact — no current model handles both simultaneously.
4. **Graph richness criterion:** what properties make an instance-graph sufficient to license ARC-AGI-class compositional transfer — what is the minimum required topology?
5. **Mathematical vocabulary discovery:** FrontierMath shows that latent graph discovery fails even when the meta-graph (theorem network) exists in training data but at near-zero density. Is this the same unknown-vocabulary problem as in visual domains, just at a more extreme sparsity scale — or does formal mathematics require a qualitatively different mechanism for vocabulary co-discovery (e.g., explicit literature retrieval vs. statistical extraction)?

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
- **[[wiki/papers/hutter-aixi-2000.md]]** — AIXI is the formal ceiling for latent graph discovery: maintains ξ^AI over all computable environments, satisfying all four hardness sources; every feasible architecture is a bounded-program approximation to it; the active/passive boundary proves that exploration-based graph discovery requires active architecture beyond passive compression.
- **[[wiki/entities/dnc-model.md]]** — DNC is the first architecture in the wiki empirically verified to solve graph traversal (98.8%), shortest-path (55.3%), and relational inference (81.8%) tasks via external read-write memory; demonstrates that instance-graph binding (fast M) and sequential path retrieval (temporal links) are sufficient for these tasks but that cross-environment meta-graph learning requires more than externalizing memory — the controller W must also generalize.
- **[[wiki/papers/dnc-graves-2016.md]]** — source: graph task results; LSTM-vs-DNC 37%-vs-98.8% gap establishing external memory necessity; Mini-SHRDLU demonstrating prospective planning (write-before-execute) as an emergent property of read-write memory.
- **[[wiki/papers/vla-survey-kawaharazuka-2025.md]]** — LAPA provides a partial solution to vocabulary co-discovery (hardness source 2): VQ-VAE on (frame_t, frame_{t+H}) differences learns a discrete action codebook jointly with a visual world model; the codebook is the discovered action alphabet; limitation is that it is domain-specific to the training video distribution and does not generalize meta-graph structure across environments.
- **[[wiki/papers/shortcut-suite-yuan-2024.md]]** — empirical quantification of hardness source 5 (spurious edge covariate shift) in LLMs: Constituent OOD accuracy drops >50% at scale; inverse scaling paradox (larger LLM → more shortcut use under ICL) confirms that capability accumulation amplifies false edge availability rather than suppressing it; CoT as partial graph traversal bypass is a design implication.
- **[[wiki/papers/shortcut-learning-geirhos-2020.md]]** — formal taxonomy of shortcut solutions as the i.i.d./intended-solution gap; inductive bias decomposition (architecture/data/loss/optimisation) identifies why all four factors can independently produce false edges; recommended solution path (IRM + meta-learning + causal disentanglement) maps to the causal edge invariance requirement.
- **[[wiki/entities/frontiermath-benchmark.md]]** — FrontierMath instantiates the hardest latent graph configuration: both edge vocabulary (applicable theorems) and traversal path are latent, and the vocabulary has near-zero training coverage; the benchmark confirms that all four hardness sources are active simultaneously in formal mathematical reasoning, and that the frontier AI failure at <2% parallels the ARC-AGI gap from the opposite prior-knowledge extreme.
- **[[wiki/papers/glazer-frontiermath-2024.md]]** — source: FrontierMath domain distribution, construction methodology, 3-axis difficulty decomposition, and model results establishing the <2% frontier capability gap in research-level mathematics.
- **[[wiki/entities/gsm-symbolic.md]]** — GSM-NoOp failures instantiate the spurious edge covariate shift hardness source at the mathematical graph level: LLMs absorb irrelevant clauses into computation paths, and nonlinear clause-count collapse shows they cannot maintain structural graph topology under modification; arithmetic accuracy (97–99%) confirms the failure is structural, not computational.
- **[[wiki/entities/gsm-plus.md]]** — reversal perturbations demonstrate LLMs cannot navigate reversed edge direction in a computation graph; critical thinking failures show they cannot detect underspecified graphs — convergent empirical confirmation of structural reasoning failure from a math robustness perspective.
- **[[wiki/entities/hle.md]]** — HLE's near-zero frontier accuracy (<15% across all models) provides cross-domain empirical evidence that current architectures fail at latent graph discovery in expert-level problems; HLE-Verified's finding that model confidence is *higher* on annotation-flawed items directly instantiates the spurious covariate shift hardness source — models exploit false edges from annotation artifacts rather than recovering the intended causal structure.
