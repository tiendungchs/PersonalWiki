---
title: "Latent Graph Discovery"
type: concept
tags: [latent-graph-discovery, abstract-reasoning, structural-generalization, problem-framing, graph-inference]
created: 2026-06-20
updated: 2026-06-24
sources: []
related: [wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/path-integration.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/analogical-reasoning.md, wiki/concepts/latent-states.md, wiki/entities/tem-model.md, wiki/entities/arc-agi.md, wiki/entities/cscg-model.md, wiki/entities/tiwm-model.md, wiki/entities/dnc-model.md, wiki/entities/frontiermath-benchmark.md, wiki/entities/olymmath.md, wiki/papers/hutter-aixi-2000.md, wiki/papers/dnc-graves-2016.md, wiki/papers/shortcut-suite-yuan-2024.md, wiki/papers/shortcut-learning-geirhos-2020.md, wiki/papers/glazer-frontiermath-2024.md, wiki/papers/olymmath.md, wiki/papers/odouard-2022-concept-evaluation.md, wiki/entities/vsa-model.md, wiki/papers/joffe-vsa-arc-2025.md, wiki/papers/math-perturb-2025.md, wiki/entities/gpqa-benchmark.md, wiki/papers/gpqa-rein-2024.md, wiki/papers/adversarial-nli-nie-2020.md, wiki/papers/spatial-learning-pfc-martinet-2011.md, wiki/entities/prefrontal-cortex.md]
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
| **Path** (sequence of edges) | Start + end nodes | Navigation, planning, route-finding; FrontierMath (proof step sequence); **AIME/HMMT** (olympiad solution path with known vocabulary — largely solved by frontier models 2025–2026); **MATH** (competition math, known operator vocabulary, long chains; 3–7% frontier 2021; ~60–80% by 2025 but MATH-Perturb reveals structural brittleness remains); **OlymMATH-HARD** (intermediate tier: olympiad path with partially-known vocabulary; 31–58% top-model accuracy 2025–2026) |
| **Node content** (partial state) | Path + partial content | Algebra, physics problems, constraint satisfaction; **GPQA** (biology, physics, chemistry — intermediate causal-chain states latent; google-proof design tests spurious-edge suppression) |
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
| **Spurious edge covariate shift** | Training observations contain correlations that produce false edges (shortcuts). Canonical NLI (Natural Language Inference) case: hypothesis text alone predicts the entailment label at ~72% IID accuracy (false edge H→label), bypassing the true edge P→H; ANLI's adversarial collection blocks this shortcut and accuracy drops to 42–51% (Nie et al. 2020). False edges work IID but fail OOD when the spurious correlation is broken — the model has discovered the wrong graph. Larger LLMs are *more* susceptible under direct prompting (inverse scaling), because accumulated pretraining memorization provides more shortcut paths. | Training must force invariant causal edge discovery across diverse environments; IRM / meta-learning across distribution shifts; or explicit intermediate-node traversal (CoT) to prevent single-edge shortcut paths |

---

## Formal Ceiling: AIXI (AI with (X) induction (I))

**AIXI** (Hutter 2000 [[wiki/papers/hutter-aixi-2000.md]]) is the only known system that satisfies all four hardness sources simultaneously. It maintains a Bayesian mixture over **all computable environments** q weighted by 2^{-l(q)} — i.e., over all possible latent graphs, edge vocabularies, aliasing structures, and topologies — and acts via expectimax to maximize universal-prior-expected credit. The full history conditions ξ^AI, so aliasing is always resolved.

AIXI fails only on computability grounds: it is uncomputable. Every entry in the table below is a bounded-program approximation to it, failing on whichever hardness sources its program-search budget cannot reach.

---

## Biological Instantiation: PFC Columnar Model

Martinet et al. 2011 ([[wiki/papers/spatial-learning-pfc-martinet-2011.md]]) provide the most direct biological proof that a neural system can solve latent graph discovery from sequential observations:

| LGD element | Biological implementation |
|---|---|
| **Nodes (locations)** | Cortical minicolumns, each becoming selective to one environmental state via Hebbian learning from HC place-cell input |
| **Edges (adjacency)** | Lateral collateral synapses (ψ/φ connections) potentiated when the animal moves between two columns — edge = co-activation during locomotion |
| **Graph never given** | Animal explores; topology is inferred from sequential (position, motion, next-position) triples — exact LGD problem setup |
| **Graph search (planning)** | Spreading activation (BFS): reward signal back-propagates from goal node, decaying per edge; current-location node detects goal signal and fires; forward path signal propagates to goal |
| **Two levels** | α columns = fine spatial topology (instance graph); β columns = corridor-level topology (coarser meta-graph layer) |

**Why spreading activation = BFS:** because the goal signal decays exponentially per synaptic relay, the first signal to arrive at the current-position column has traversed the *minimum number of edges* (shortest path). This is BFS without an explicit queue — the distance-to-goal property is implemented by exponential signal decay through the graph, not by any explicit search data structure.

**HC → PFC compression as source hardness mitigation:** HC provides a redundant high-dimensional code (many place cells per location, ~85% spatial information) that the PFC columnar system compresses to a sparse topological code (~5× fewer active units). This solves the aliasing problem locally: each PFC column has a unique, non-overlapping receptive field, so observation aliasing is resolved by the compression step rather than by explicit de-aliasing (contrast: CSCG uses clone cells for the same purpose).

---

## Why Current Architectures Fail

| Architecture | Satisfies | Fails |
|---|---|---|
| Transformer | Substitutivity; powerful fast-M analog | Two-level entanglement; path-consistency; localism gap |
| Reservoir computing | Temporal memory | No structured transition rules; cannot compress meta-graph across environments |
| CSCG | De-aliasing (source 3) | No cross-environment meta-graph; two-level entanglement unaddressed |
| TEM | Two-level separation; path-consistency; factorization; de-aliasing | Pre-given action vocabulary; flat (non-hierarchical) meta-graph |
| **DNC** | Instance-graph binding (fast M externalized); sequential path retrieval (temporal links); path traversal (empirically verified: 98.8% graph traversal, 81.8% inference) | Meta-graph cross-environment learning (controller W fixed); vocabulary co-discovery; no aliasing disambiguation |
| LLMs / LRMs | In-context adaptation within training distribution | Knowledge-bounded (Choi 2026 / ARC-AGI-3): fast inner loop cannot generalize beyond pretraining envelope. **Spurious edge susceptibility**: LLMs learn false edges from pretraining statistics; larger models are *more* prone under zero-shot/few-shot ICL (LLaMA2-70B drops to 0.8% on Constituent OOD, Yuan et al. 2024). CoT (Chain of Thought) prompting partially bypasses this by forcing multi-hop traversal rather than single shortcut edges. **Mathematical graph fragility** (GSM-Symbolic/GSM-Plus 2024): cannot maintain computation graph topology under modification — irrelevant node insertion causes avg 65% collapse (GSM-NoOp); reversed edge direction causes up to 20% drop (GSM-Plus reversal); failures are structural, not arithmetic (97–99% arithmetic accuracy preserved). **Structural blindness to graph edits** (MATH-Perturb 2025): when latent path structure is altered (hard perturbations requiring different solution strategies), models apply memorized edge labels from the original graph — 12–28% accuracy drops (vs. <5% for surface-only edits); subtle memorization (technique-application-without-structural-check) is distinct from verbatim copying and scales with model capability |
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

**CoT as latent-graph traversal (Yuan et al. 2024):** Chain-of-thought prompting reduces shortcut reliance by 15–41% on adversarial NLI. In graph terms: CoT (Chain of Thought) forces the model to materialize intermediate nodes (sub-steps) rather than taking a direct shortcut edge from observation to label. This is not a mechanism for discovering the correct causal graph — the edges were already learned during pretraining — but it biases path selection toward the intended multi-hop path over the memorized single-hop shortcut. The residual shortcut reliance under CoT (Chain of Thought) (still ~30–40% on Constituent OOD for most models) reveals that CoT (Chain of Thought) cannot fix fundamentally incorrect edge vocabularies, only select among existing ones.

**Self-poisoning via model-generated intermediate nodes (MATH 2021):** Training on ground-truth step-by-step solutions improves test accuracy by ~10% relative, but asking models to generate their own CoT (Chain of Thought) at test time *decreases* accuracy. Self-generated intermediate nodes are unreliable latent graph positions — errors at step k propagate through all subsequent steps. This is distinct from the bias-reduction effect of ground-truth CoT: ground-truth CoT (Chain of Thought) prevents shortcut path selection; model-generated CoT (Chain of Thought) corrupts the intermediate nodes on which subsequent traversal depends. The implication: CoT's benefit requires reliable intermediate structure, which current architectures cannot self-generate under distribution.

**Domain-module assignment for metric vs. associative graphs:** Kumaran & Maguire 2005 ([[wiki/papers/kumaran-maguire-2005-hippocampus.md]]) establish that HC engages only metric or temporal-sequential latent graphs, not purely declarative associative ones. Even when two graph-traversal tasks are matched in relational complexity and behavioral difficulty (same 14 nodes; edges differ: spatial proximity vs. social acquaintance), only the spatially-embedded graph drives HC. For a brain-inspired reasoning model, this implies a domain split within the latent-graph taxonomy: *metric/sequential latent graphs* (spatial navigation, temporal sequence traversal, path integration with continuous distances) → HC-analog module; *purely topological/declarative latent graphs* (social networks, logical propositions without sequential ordering) → mPFC/social-brain analog (STS, TPJ, temporal poles). In the task taxonomy: path-discovery over metric space → HC; pure edge-discovery in declarative associative domains → mPFC.

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
- **[[wiki/papers/hutter-aixi-2000.md]]** — AIXI (AI with (X) induction (I)) is the formal ceiling for latent graph discovery: maintains ξ^AI over all computable environments, satisfying all four hardness sources; every feasible architecture is a bounded-program approximation to it; the active/passive boundary proves that exploration-based graph discovery requires active architecture beyond passive compression.
- **[[wiki/entities/dnc-model.md]]** — DNC (Differentiable Neural Computer) is the first architecture in the wiki empirically verified to solve graph traversal (98.8%), shortest-path (55.3%), and relational inference (81.8%) tasks via external read-write memory; demonstrates that instance-graph binding (fast M) and sequential path retrieval (temporal links) are sufficient for these tasks but that cross-environment meta-graph learning requires more than externalizing memory — the controller W must also generalize.
- **[[wiki/papers/dnc-graves-2016.md]]** — source: graph task results; LSTM-vs-DNC 37%-vs-98.8% gap establishing external memory necessity; Mini-SHRDLU demonstrating prospective planning (write-before-execute) as an emergent property of read-write memory.
- **[[wiki/papers/vla-survey-kawaharazuka-2025.md]]** — LAPA provides a partial solution to vocabulary co-discovery (hardness source 2): VQ-VAE on (frame_t, frame_{t+H}) differences learns a discrete action codebook jointly with a visual world model; the codebook is the discovered action alphabet; limitation is that it is domain-specific to the training video distribution and does not generalize meta-graph structure across environments.
- **[[wiki/papers/shortcut-suite-yuan-2024.md]]** — empirical quantification of hardness source 5 (spurious edge covariate shift) in LLMs: Constituent OOD accuracy drops >50% at scale; inverse scaling paradox (larger LLM → more shortcut use under ICL) confirms that capability accumulation amplifies false edge availability rather than suppressing it; CoT (Chain of Thought) as partial graph traversal bypass is a design implication.
- **[[wiki/papers/shortcut-learning-geirhos-2020.md]]** — formal taxonomy of shortcut solutions as the i.i.d./intended-solution gap; inductive bias decomposition (architecture/data/loss/optimisation) identifies why all four factors can independently produce false edges; recommended solution path (IRM + meta-learning + causal disentanglement) maps to the causal edge invariance requirement.
- **[[wiki/entities/frontiermath-benchmark.md]]** — FrontierMath instantiates the hardest latent graph configuration: both edge vocabulary (applicable theorems) and traversal path are latent, and the vocabulary has near-zero training coverage; the benchmark confirms that all four hardness sources are active simultaneously in formal mathematical reasoning, and that the frontier AI failure at <2% parallels the ARC-AGI gap from the opposite prior-knowledge extreme.
- **[[wiki/papers/glazer-frontiermath-2024.md]]** — source: FrontierMath domain distribution, construction methodology, 3-axis difficulty decomposition, and model results establishing the <2% frontier capability gap in research-level mathematics.
- **[[wiki/entities/gpqa-benchmark.md]]** — GPQA's google-proof gap (PhD experts 65% vs. non-experts+web 34%) is a direct empirical test of spurious-edge suppression in expert-level scientific reasoning: surface keyword lookup fails; only correct causal-chain traversal succeeds; occupies the "node content latent" tier where intermediate reasoning states (physical laws, chemical mechanisms) must be inferred.
- **[[wiki/entities/olymmath.md]]** — OlymMATH-HARD occupies the intermediate tier between AIME (solved) and FrontierMath (open) in the path-discovery taxonomy; OlymMATH-LEAN's Lean 4 track provides a process-level oracle that distinguishes genuine latent path traversal from heuristic shortcut guessing — the Pass@64 vs Cons@64 gap directly measures traversal consistency rather than endpoint accuracy.
- **[[wiki/papers/olymmath.md]]** — source: OlymMATH benchmark construction, EN>ZH gap analysis, Pass@64 vs Cons@64 consistency gap, and Lean 4 shortcut detection results.
- **[[wiki/papers/odouard-2022-concept-evaluation.md]]** — concept-based evaluation is an empirical probe for spurious edge covariate shift at the rule level: if a model learned the true latent transformation rule (edge), it must generalize to any instantiation of that rule; MRNet/SCL's drop on Sameness/Progression concept variations confirms that distribution-specific correlates were learned, not abstract edges.
- **[[wiki/entities/vsa-model.md]]** — VSA/SSP solver empirically isolates hardness source 2 (unknown vocabulary) as the residual bottleneck: 94.5% Sort-of-ARC (pre-given DSL) → 3% ARC-AGI-1-Eval (open DSL) is the clearest measured vocabulary co-discovery gap in the literature; SSP path integration (φ(x) ⊛ φ(d) = φ(x+d)) achieves within-episode path-consistency but no meta-graph W is learned across tasks.
- **[[wiki/papers/joffe-vsa-arc-2025.md]]** — primary empirical source for the VSA/SSP performance gap; diagnoses vocabulary co-discovery as the architectural gap separating brain-inspired structured methods from genuine ARC-AGI-class generalization.
- **[[wiki/papers/adversarial-nli-nie-2020.md]]** — ANLI is the clearest quantified NLI (Natural Language Inference) instantiation of hardness source 5 (spurious edge covariate shift): 72% IID accuracy from the false H→label edge collapses to 42–51% when adversarial collection forces traversal of the true P→H entailment edge; the inference-type failure taxonomy maps which NLI (Natural Language Inference) edge types remain unsolvable even after the primary shortcut is blocked.
- **[[wiki/concepts/shortcut-reasoning.md]]** — shortcut reasoning is the failure mode that hardness source 5 (spurious edge covariate shift) produces; the full taxonomy of shortcut mechanisms (discriminative/generative asymmetry, ARC catalogue, NLI (Natural Language Inference) instantiation) and the architectural solution path (IRM + causal disentanglement) are consolidated there.
- **[[wiki/papers/spatial-learning-pfc-martinet-2011.md]]** — biological proof-of-concept: PFC columnar network solves latent graph discovery from sequential spatial observations via Hebbian edge inference and spreading activation planning; uniquely maps all LGD components to identifiable neural populations and synaptic mechanisms.
- **[[wiki/entities/prefrontal-cortex.md]]** — PFC is the biological latent graph discovery module: compresses HC redundant code into a sparse topological graph (instance graph), uses recurrent column dynamics for corridor-level abstraction (meta-graph layer), and runs spreading activation for optimal path planning.
