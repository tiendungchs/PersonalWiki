---
title: "Attention (Transformer Self-Attention)"
type: concept
tags: [attention, transformer, hopfield, positional-encodings, associative-memory]
created: 2026-06-12
updated: 2026-06-19
sources: [t-TEM, convergence-wiring-transcript, bolzman-machine-transcript, Compositionality_decomposed]
related: [wiki/concepts/factorized-representations.md, wiki/concepts/path-integration.md, wiki/concepts/structural-generalization.md, wiki/concepts/small-world-networks.md, wiki/concepts/compositional-generalization.md, wiki/concepts/associative-memory.md, wiki/entities/tem-model.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/boltzmann-machine.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/convergence-wiring-transcript.md, wiki/papers/boltzmann-machine-transcript.md, wiki/papers/compositionality-decomposed-hupkes-2020.md, wiki/papers/hopfield-networks-crouse-2022.md]
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
