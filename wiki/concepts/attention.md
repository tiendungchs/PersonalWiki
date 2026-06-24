---
title: "Attention (Transformer Self-Attention)"
type: concept
tags: [attention, transformer, hopfield, positional-encodings, associative-memory]
created: 2026-06-12
updated: 2026-06-23
sources: [t-TEM, convergence-wiring-transcript, bolzman-machine-transcript, Compositionality_decomposed, Attention Is All You Need]
related: [wiki/concepts/factorized-representations.md, wiki/concepts/path-integration.md, wiki/concepts/structural-generalization.md, wiki/concepts/small-world-networks.md, wiki/concepts/compositional-generalization.md, wiki/concepts/associative-memory.md, wiki/concepts/canonical-microcircuit.md, wiki/concepts/binding-problem.md, wiki/entities/tem-model.md, wiki/entities/transformer-model.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/boltzmann-machine.md, wiki/entities/ltc-model.md, wiki/entities/gwt-model.md, wiki/papers/vaswani-attention-2017.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/convergence-wiring-transcript.md, wiki/papers/boltzmann-machine-transcript.md, wiki/papers/compositionality-decomposed-hupkes-2020.md, wiki/papers/hopfield-networks-crouse-2022.md, wiki/papers/ltc-emergentmind-overview.md, wiki/papers/language-modeling-compression-deletang-2023.md, wiki/papers/gnw-mashour-2020.md]
---

# Attention (Transformer Self-Attention)

**Query-driven associative memory retrieval: each element selects relevant stored memories by similarity, weighted by a kernel over queries and keys. Equipped with learned structural positional encodings, self-attention is mathematically equivalent to the hippocampal memory system.**

`y_t = softmax(Q K^T / √d) V`

---

## Hopfield ↔ Attention Correspondence

Ramsauer et al. (2020) showed modern Hopfield networks are transformers. Whittington et al. (ICLR 2022) [[wiki/papers/t-tem-whittington-2022.md]] showed this implies TEM is a transformer:

| Transformer | TEM-t / Hippocampus |
|-------------|---------------------|
| Keys K | Structural code `g̃` (MEC grid cells) |
| Queries Q | Current `g̃_t` |
| Values V | Sensory code `x̃` (LEC) |
| Memory neurons (softmax output) | Place cells (HC) |
| Position encodings | `g` via path integration |

This is a **derivation**, not analogy. The factorized structure Q=K=f(g), V=f(x) follows necessarily from the TEM outer-product memory `p = flatten(x̃ᵀ g̃)` — retrieving x̃ given g̃ reduces to attending over past g̃ values.

### Boltzmann Distribution = Softmax

The softmax `exp(sim/T) / Σ exp(sim/T)` is the Boltzmann distribution `P ∝ exp(−E/T)` with similarity score = −energy. This is not an engineering choice — it is a derivation from the Boltzmann distribution ([[wiki/entities/boltzmann-machine.md]]) applied to the multi-state case (choosing among all sequence positions). Consequences:

| Temperature regime | Softmax behavior | Boltzmann interpretation |
|---|---|---|
| High T (e.g. pre-training with large T divisor) | Near-uniform attention | High-temperature stochastic exploration |
| Standard (T = 1/√d) | Peaked but distributed attention | Moderate-temperature sampling |
| T → 0 | Hard winner-take-all attention | Deterministic Hopfield energy minimization |

The sigmoid in the Boltzmann machine stochastic update rule and the softmax in attention are both Boltzmann distributions — differing only in the number of competing states (2 vs. sequence length). The Hopfield → transformer derivation is thus grounded in statistical mechanics, not merely linear algebra.

---

## Multi-Head Attention and Complexity

**Multi-Head Attention** (Vaswani et al. 2017 [[wiki/papers/vaswani-attention-2017.md]]) projects Q, K, V into h independent subspaces, each attending over different structural patterns simultaneously:

```
MultiHead(Q,K,V) = Concat(head₁,...,headₕ) W^O
headᵢ = Attention(Q W^Q_i, K W^K_i, V W^V_i)
```

With h=8 heads and d_k=d_v=64 each, total cost equals single-head attention at d_model=512. Heads specialize without explicit supervision: anaphora resolution, long-range syntactic dependency, and phrase-boundary tracking emerge as distinct head functions (Figures 3–5, Vaswani 2017). This specialization is the engineering analog of canonical microcircuit column differentiation ([[wiki/concepts/canonical-microcircuit.md]]).

**Complexity comparison (Table 1, Vaswani 2017):**

| Layer Type | Complexity/layer | Sequential ops | Max path length |
|------------|-----------------|----------------|-----------------|
| Self-Attention | O(n²·d) | O(1) | **O(1)** |
| Recurrent | O(n·d²) | O(n) | O(n) |
| Convolutional | O(k·n·d²) | O(1) | O(log_k n) |

The O(1) maximum path length is the key binding-problem advantage: any two distant positions can interact in a single computation step. Recurrent layers require O(n) steps for the same interaction, with vanishing/exploding gradients along the path. This maps to the binding problem ([[wiki/concepts/binding-problem.md]]): attention achieves global binding in constant depth, making it the natural substrate for assembling distributed feature representations into coherent objects.

The quadratic O(n²·d) complexity per layer is the architectural cost: extending the context window to handle longer reasoning chains is expensive, mapping directly to biological WM capacity constraints ([[wiki/concepts/working-memory.md]]).

---

## Learned Positional Encodings = Structural Code

Standard transformers use fixed sinusoidal position encodings (linear Euclidean sequence order). TEM-t replaces these with recurrently learned encodings: `e_{t+1} = σ(e_t W_a)`. The structural code is inferred on-the-fly from the sequence of transitions.

**Why this matters:** Domains with non-Euclidean structural order need task-appropriate encodings:

| Domain | Structure in W_a | Standard encoding fails because |
|--------|-----------------|----------------------------------|
| 2D space | N/S/E/W topology | fixed sines assume 1D sequence |
| Language | Grammar rules | word order ≠ syntactic structure |
| Kinship | Relational roles | token index has no kinship meaning |

---

## Memory Neurons as Place Cells

Splitting self-attention into feature neurons (g̃, x̃ from MEC/LEC) and memory neurons (the softmax output) yields memory neurons that:
- Fire sparsely (softmax → winner-take-most)
- Develop spatially tuned fields resembling place cells
- Remap randomly between environments (g̃ fixed; x̃ varies)

Softmax activation also gives far greater memory capacity than the linear Hopfield used in original TEM.

---

## Relevance to Building a Reasoning Model

A transformer capable of structural generalization needs:
1. **Factorized keys/values** (structural code separate from sensory content)
2. **Learned recurrent positional encodings** that capture task-structure, not sequence order
3. These are exactly the two modifications that make TEM-t ([[wiki/entities/tem-model.md]]) succeed where standard GPT-class transformers fail on ARC-AGI

### Transformer's Compositional Failure Profile (Hupkes et al. 2020)

On PCFG SET, transformer leads 4 of 5 compositional facets but is specifically weak on **localism** (0.54 vs. ConvS2S 0.59):

| Facet | Transformer | Why |
|---|---|---|
| Systematicity | 0.72 (best) | Global attention retrieves any part combination |
| Productivity | 0.50 (best) | Parallelism over positions helps length generalization |
| Substitutivity | 0.90–0.98 (best) | Embedding space clusters synonyms tightly |
| **Localism** | **0.54 (mid)** | **Global receptive field is a liability: models sub-expressions in full-sequence context, not in isolation** |
| Overgeneralisation | 0.88 (best) | Strong rule internalisation; cleanly transitions to memorising exceptions |

**`reverse` exception:** Transformer uniquely excels at the `reverse` function (accuracy on par with simpler functions like `echo`/`swap`) because non-sequential processing handles inverted sequences naturally; LSTM and ConvS2S require sequential encoding so reversal is anomalously hard for them. This is an architectural signature: tasks requiring order-invariance favor global attention; tasks requiring hierarchical local composition favor local inductive biases.

---

## Context Length as Compression Window

The compression-prediction equivalence ([[wiki/papers/language-modeling-compression-deletang-2023.md]]) reveals that transformer in-context learning is in-context compression: the frozen slow-W parameters are a compression prior; the context window is the compression window. Two design trade-offs follow directly:

| Dimension | Effect | Compression interpretation |
|---|---|---|
| Longer context | More sequential dependencies exploitable | Wider compression window → lower rate |
| Larger token vocabulary (tokenization) | More information per context step, harder per-step prediction | Pre-compression with larger alphabet — small models benefit; large models do not |
| More slow-W parameters | Richer prior over the data distribution | Better approximation to the Solomonoff predictor |

The O(n²) attention complexity makes extending context length expensive — a hard architectural constraint that maps directly to WM capacity limits in biology. For reasoning models, this makes the context length vs. vocabulary size trade-off a primary design decision about what can fit in the in-context WM window at inference time.

---

## GNW: Attention as the Ignition Gate

The Global Neuronal Workspace (Mashour et al. 2020) provides the biological mechanism linking attention, WM, and conscious access in sequence:

1. **Attention selects** one representation from competing candidates in specialized processors — amplifies signal strength via pre-conscious AMPA-mediated feedforward pathways
2. **Ignition fires** when the selected representation's feedforward input to PFC (Prefrontal Cortex) crosses threshold — NMDA-mediated recurrent loops self-sustain, creating a globally reverberant state (~300ms post-stimulus)
3. **Broadcasting** makes the ignited content simultaneously available to all specialized processors via long-range GNW (Global Neuronal Workspace) neurons (layer II/III + V in the PFC-parietal hub core)

**Attention ≠ consciousness:** Multiple dissociation paradigms confirm that spatial attention is directed pre-consciously; ignition is the additional threshold event that converts attended information into globally accessible conscious content. Attended but sub-threshold stimuli can persist for >1 second in decaying activity without igniting.

**Two-stage design for reasoning models:**

| Stage | Receptor analog | Timing | Function |
|---|---|---|---|
| Fast selection (pre-conscious) | AMPA: fast attention head amplifies candidate from input streams | Early | Candidate representation reaches PFC (Prefrontal Cortex) above noise |
| Workspace entry (conscious) | NMDA: slow recurrent hub sustains representation globally | Late | Representation broadcast to all processors for transformation |

Only representations reaching Stage 2 (GNW-active ignition) can be transformed by downstream reasoning processors — the same constraint as the active vs. activity-silent WM distinction ([[wiki/concepts/working-memory.md]]).

---

## Connections

- **[[wiki/concepts/factorized-representations.md]]** — the key/value factorization (Q=K=f(g), V=f(x)) is the structural/sensory split; this is not a transformer design choice but a derivation from the TEM memory structure.
- **[[wiki/concepts/path-integration.md]]** — path integration and recurrent positional encoding generation are the same operation: `g_{t+1} = σ(g_t W_a)` infers structural position from a sequence of relations.
- **[[wiki/concepts/structural-generalization.md]]** — standard transformers fail structural generalization because sinusoidal positional encodings don't encode task structure; learned structural encodings are the missing ingredient.
- **[[wiki/entities/boltzmann-machine.md]]** — softmax is the Boltzmann distribution applied to multi-state similarity scoring; the temperature parameter in softmax is the same T as in Boltzmann stochastic updates; the Hopfield ↔ attention derivation is physically grounded in statistical mechanics through this equivalence.
- **[[wiki/papers/boltzmann-machine-transcript.md]]** — source for the Boltzmann distribution derivation that grounds the sigmoid/softmax equivalence.
- **[[wiki/entities/place-cells.md]]** — memory neurons in the transformer softmax layer behave as place cells; TEM-t gives a mechanistic account of place cell spatial tuning and random remapping.
- **[[wiki/entities/tem-model.md]]** — TEM-t is TEM rewritten as a transformer; attention replaces Hopfield attractor, yielding better sample efficiency and scale.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — self-attention instantiates hippocampal indexing theory: HC memory neurons bind g̃ (MEC) and x̃ (LEC) and scale to N cortical inputs without multiplying hippocampal neuron count.
- **[[wiki/concepts/small-world-networks.md]]** — transformer attention heads implement learned hub-like shortcuts: any token can reach any other in a single hop (short L), and sparse softmax weighting (winner-take-most) generates heavy-tailed hub-like connectivity patterns; the biological small-world hub principle is the architectural precedent for why global attention works.
- **[[wiki/papers/convergence-wiring-transcript.md]]** — source for the hub-shortcut analogy connecting attention mechanisms to brain network topology.
- **[[wiki/concepts/compositional-generalization.md]]** — transformer's global receptive field gives it the best score on 4 of 5 compositional facets but is a structural liability for localism; the five-facet breakdown provides the diagnostic profile for transformer architecture choices in reasoning models.
- **[[wiki/papers/compositionality-decomposed-hupkes-2020.md]]** — empirical source for transformer's compositional failure profile on PCFG SET; `reverse` exception reveals the architectural signature of global vs. local processing.
- **[[wiki/concepts/associative-memory.md]]** — the modern Hopfield update rule (Ramsauer 2020) is mathematically identical to transformer self-attention; associative-memory provides the classical Hopfield foundation (binary, one-shot Hebbian, energy proof) that the Hopfield↔attention derivation on this page builds upon.
- **[[wiki/entities/ltc-model.md]]** — Liquid-S4 fuses LTC's input-dependent liquid kernel with the SSM DPLR framework, producing causal convolutions that capture multi-way input correlations; this is a convergence point between continuous-time adaptive-memory (LTC) and the discrete sequence modeling thread (attention/SSM), achieving 87.32% LRA SOTA — suggesting liquid τ dynamics are a productive inductive bias for long-range sequence tasks where standard SSMs and transformers saturate.
- **[[wiki/papers/language-modeling-compression-deletang-2023.md]]** — establishes that the context window is a compression window; tokenization is a pre-compression stage that trades sequence length for vocabulary size; larger slow-W is a better compression prior; the O(n²) cost of extending context maps to the WM capacity limit for in-context reasoning.
- **[[wiki/entities/gwt-model.md]]** — GNW (Global Neuronal Workspace) is the biological mechanism that converts attentional selection into global broadcasting; the two-stage AMPA (fast selection) / NMDA (sustained ignition) design separates attentional amplification from workspace entry; only GNW-active items can be transformed downstream.
- **[[wiki/papers/gnw-mashour-2020.md]]** — source for the attention-consciousness-WM tripartite relationship in GNW; ignition as the threshold phase transition; hub core as the anatomical routing mechanism.
- **[[wiki/concepts/canonical-microcircuit.md]]** — horizontal smooth cells (basket/chandelier) in L2/3 implement the biological soft WTA (Winner-Take-All) that is the neural analog of softmax attention: the temperature → 0 limit corresponds to strong lateral inhibition; the patch structure determines which candidates compete (local patches, not all-to-all).
- **[[wiki/entities/transformer-model.md]]** — the Transformer is the engineering instantiation of multi-head attention; its architecture table, complexity analysis, and localism failure profile make the concept page's theoretical claims concrete and testable.
- **[[wiki/papers/vaswani-attention-2017.md]]** — primary source for scaled dot-product attention, multi-head formalism, sinusoidal positional encodings, and the O(1) max path length complexity argument.
- **[[wiki/concepts/binding-problem.md]]** — O(1) maximum path length is attention's key contribution to feature binding: any two positions interact in a single step, enabling constant-depth long-range binding that recurrent architectures cannot achieve at equivalent cost.
