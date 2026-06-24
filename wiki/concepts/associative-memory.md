---
title: "Associative Memory"
type: concept
tags: [associative-memory, hopfield, attractor, hebbian, pattern-completion, content-addressable-memory, sdm]
created: 2026-06-19
updated: 2026-06-23
sources: [Hopfield Networks Neural Memory Machines, Structure and function of the hippocampal CA3 module, The mechanisms for pattern completion and pattern separation in the hippocampus, Complementary Learning Systems, High Capacity and Dynamic Accessibility in Associative Memory Networks with Context-Dependent Neuronal and Synaptic Gating, sparse_representations, High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations, Hybrid computing using a neural network with dynamic external memory, kanerva-sdm-1993, Bio-inspired computational memory model of the Hippocampus An approach to a neuromorphic spike-based Content-Addressable Memory]
related: [wiki/concepts/attention.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/engrams.md, wiki/concepts/working-memory.md, wiki/concepts/binding-problem.md, wiki/concepts/neuromodulation.md, wiki/concepts/pattern-separation.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/hebbian-learning.md, wiki/concepts/sequence-memory.md, wiki/entities/equilibrium-propagation.md, wiki/entities/boltzmann-machine.md, wiki/entities/vector-hash-model.md, wiki/entities/dnc-model.md, wiki/entities/sdm-model.md, wiki/entities/cerebellum.md, wiki/entities/snn.md, wiki/entities/hami-model.md, wiki/papers/hopfield-networks-crouse-2022.md, wiki/papers/boltzmann-machine-transcript.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/ca3-sammons-2023.md, wiki/papers/pattern-completion-rolls-2013.md, wiki/papers/cls-oreilly-2011.md, wiki/papers/podlaski-context-modular-memory-2025.md, wiki/papers/ahmad-hawkins-sdr-2016.md, wiki/papers/vector-hash-chandra-2023.md, wiki/papers/long-sequence-hopfield-chaudhry-2023.md, wiki/papers/dnc-graves-2016.md, wiki/papers/kanerva-sdm-1993.md, wiki/papers/scellier-bengio-eqprop-2017.md, wiki/papers/spiking-cam-hippocampus-casanueva-2024.md, wiki/papers/hami-poursiami-2025.md]
---

# Associative Memory

**A memory system in which retrieval is driven by content similarity: a partial or noisy input pattern self-completes to the closest stored pattern via energy minimization, without requiring an explicit address.**

Also called content-addressable memory (CAM) or autoassociative memory.

---

## Key Equations

**Energy function:**
$$E(\mathbf{s}) = -\frac{1}{2} \sum_{i \neq j} w_{ij} s_i s_j$$
Memories are stored as energy minima; each update step decreases $E$ monotonically → convergence guaranteed.

**Asynchronous update rule (binary, deterministic):**
$$s_i \leftarrow \text{sign}\!\left(\sum_j w_{ij} s_j\right)$$

**One-shot Hebbian learning ($p$ patterns, $n$ neurons):**
$$W = \frac{1}{n} Y^\top Y, \quad w_{ii} = 0$$
Single exposure suffices — no backprop. Capacity ~0.14N patterns before spurious attractors appear.

**Modern Hopfield / continuous (Ramsauer et al. 2020) — exponential capacity:**
$$\mathbf{\xi}^{\text{new}} = X^\top \text{softmax}(\beta X \mathbf{\xi})$$
Mathematically identical to one step of transformer self-attention; capacity O(exp d).

---

## Instantiations

| System | Mechanism | Capacity | Notes |
|---|---|---|---|
| Binary Hopfield (1982) | Fixed-point attractor; deterministic update | ~0.14N | Spurious attractors when patterns correlated |
| Modern Hopfield (2020) | Softmax energy; one-step convergence | O(exp d) | Equivalent to transformer attention |
| CA3 hippocampus | Recurrent Schaffer collaterals + LTP; 8.8–11% connectivity (Sammons 2023) | ~exp(d) for sparse codes | Random connectivity sufficient; log-normal weights; no motif enrichment needed |
| Transformer attention | softmax(QKᵀ/√d)V | Full sequence length | Keys=g (structural), Values=x (sensory) in TEM-t |

---

## Storage Capacity and DG (Dentate Gyrus) Pattern Separation

See **[[wiki/concepts/pattern-separation.md]]** for the complete account: five DG (Dentate Gyrus) mechanisms (mossy fiber randomization, sparse firing, expansion recoding, sparse CA3 representation, adult neurogenesis), the capacity formula $p_\text{max} \approx k \times C_{RC} / a$, diluted connectivity advantage, and mossy fiber/perforant path encoding-recall anatomical separation.

DG pattern separation is the prerequisite that prevents CA3 attractor interference: inputs must be orthogonalized before storage so that similar episodes map to non-overlapping attractor basins.

---

## Context-Modular Hopfield Network (Podlaski et al. 2025)

Standard Hopfield stores all memories as simultaneously stable attractors — biological memory is dynamic: some memories are accessible while others are hidden depending on behavioral context. Podlaski et al. introduce a formal extension:

**Model:** $s$ discrete contexts, each imposing an inhibitory mask $a_{ki} a_{kj} c_{kij}$ (neuronal gates $a$, synaptic gates $c$) onto $J_{ij}$. Context $k$ active → only its $p$ memories are stable attractors; the rest are destabilized.

| Scheme | Capacity gain (s=100) | Key mechanism | Biological mapping |
|---|---|---|---|
| Standard Hopfield | 1× (baseline ~0.14N) | All memories always stable | — |
| Random neuronal gating | ~7× | Sparse neuron subset per context reduces inter-context crosstalk | Excitability-based engram allocation (20–30% active = optimal $a$) |
| Synaptic refinement | ~40× | Post-learning gating mask removes destabilizing synapses | Dendritic branch-specific interneurons (dendrite-targeting in cortex + HC) |

**Optimal neuronal gating formula:** $1 - a_\text{opt} \approx 1 - (\sqrt{2s-1} - 1)/(s-1)$. For $s=10$–$100$ contexts, this yields $a \approx 0.2$–$0.3$ — directly matching observed HC/amygdala engram fractions. The sparse engram fraction is not a general sparsity constraint but the *optimal neuronal gating ratio for the number of contextually organized memories*.

**Synaptic refinement on a random weight matrix:** When $J_{ij} \sim \mathcal{N}(0,1)$ (no memory information), synaptic gating can still impose stable attractors — half the random weights happen to have the correct sign for any target pattern, and refinement selects those. **Memory is stored in the gating structure, not the weights.** This separates learning (writing $J_{ij}$) from contextual memory organization (setting $c_{kij}$ at retrieval time).

**Trade-off:** Total capacity $\alpha^* \propto s$ (grows with contexts), but fraction accessible at any moment $\propto 1/s$. The brain may prioritize flexible access over maximizing stored count.

---

## Vector-HaSH: Factorizing Dynamics from Content

The memory cliff — perfect recall up to ~0.14N patterns, then catastrophic failure — is a structural property of all Hopfield variants, not a capacity limit of the underlying network. The root cause: the *same* synaptic weights simultaneously generate error-correcting attractor basins and encode content. Any new pattern distorts both the attractor landscape and existing content.

**Vector-HaSH** (Chandra et al. 2023 [[wiki/papers/vector-hash-chandra-2023.md]]) resolves this by factorizing the two responsibilities:

| Component | Role | Weights |
|---|---|---|
| **Scaffold** (grid circuit + fixed grid→HC random projection + fixed HC→grid learned projection) | Generates ⟨K⟩^M error-correcting fixed points from M grid modules with K phases each | Immutable after development |
| **Heteroassociative layer** (bidirectional HC↔neocortex) | Attaches sensory content to scaffold states | Plastic — the memory write |

New memories modify only heteroassociative weights; attractor basins are scaffold-generated and never perturbed. Adding item N+1 does not degrade recall of items 1…N. Instead, capacity degrades *gracefully*: more items → less reconstruction fidelity per item (less detail), but no cliff and no catastrophic erasure.

**Why the scaffold has exponential capacity at linear cost:** Each of M modules independently codes its 2D torus with K phases; if K_i values are coprime, the joint state space is ∏K_i ≈ ⟨K⟩^M — exponential in M modules. HC neuron count scales O(M), not O(⟨K⟩^M). Content-free fixed points can be generated from a small metric traversal of grid phase space (the ordered torus topology is essential; random patterns of equal sparsity require exponentially more training).

**Comparison of capacity strategies:**

| Model | Cliff? | Mechanism | Neurons needed for ⟨K⟩^M patterns |
|---|---|---|---|
| Hopfield | Yes, ~0.14N | Content in attractor weights | O(⟨K⟩^M) |
| Modern Hopfield (Ramsauer) | Yes (softer) | Softmax energy | O(⟨K⟩^M) in circuit implementation |
| Context-Modular (Podlaski) | Reduced | Neuronal/synaptic gating | O(N) per context |
| **Vector-HaSH** | No | Scaffold/content factorization | O(M) = O(log ⟨K⟩^M) |

**For a reasoning model:** the scaffold/content split is the architectural principle that enables lifelong episodic memory without catastrophic interference. The fast-M write should target only the heteroassociative layer; the structural scaffold (analogous to slow-W weights) should be held fixed once learned. See [[wiki/entities/vector-hash-model.md]] for the full architecture.

---

## SDM: Generalizing Hopfield and Correlation-Matrix Memories

Kanerva's **Sparse Distributed Memory (SDM)** (Kanerva 1993 [[wiki/papers/kanerva-sdm-1993.md]]) is the unifying framework from which Hopfield networks, Anderson/Kohonen correlation-matrix memories, and DG→CA3 hippocampal memory all derive as special cases [[wiki/entities/sdm-model.md]].

**Hopfield as degenerate SDM:** Setting activation radius H=0 and building a hard location for every 2^N address yields an SDM (Sparse Distributed Memory) that activates exactly one location per query (exact match) — functionally equivalent to a RAM. The Hebbian weight matrix W = (1/N)ΣξξΤ in Hopfield emerges from SDM's content matrix **C** when activation vectors are orthogonal identity rows. Capacity ~0.14N.

**Correlation-matrix memories as full-activation SDM:** When all M locations are always active (p=1), the SDM (Sparse Distributed Memory) majority-vote collapses to summed correlation — the same linear associator as Anderson (1968) and Kohonen (1972).

**SDM's N-independence:** Both Hopfield and correlation-matrix memories have capacity bounded by the pattern dimension N. SDM (Sparse Distributed Memory) replaces this with M (number of hard locations), which is a free parameter chosen independently of N.

| Model | Capacity | N-dependence | Biological mapping |
|---|---|---|---|
| Correlation-matrix (Kohonen/Anderson) | ~N | Yes | Heteroassociative cortex |
| Hopfield (1982) | ~0.14N | Yes | CA3 recurrent collaterals |
| **SDM (Kanerva 1988)** | **~0.1M** | **No** | DG→CA3; cerebellar cortex |
| Modern Hopfield (Ramsauer 2020) | O(exp d) | Yes (d) | TEM-t attention layer |

Keeler (1988): capacity *per storage element* is identical between SDM (Sparse Distributed Memory) and Hopfield at asymptote (τ ≈ 0.1 vs. 0.14N, same order). The SDM (Sparse Distributed Memory) advantage is that M is a free hardware parameter; adding more hard locations (granule cells, memory rows) linearly increases capacity without changing the input or output dimensionality.

**For a reasoning model:** The fast-M store's address projection (**A** matrix) should be fixed randomly after initialization — SDM (Sparse Distributed Memory) proves that a random projection from input space to activation space already achieves near-orthogonal addressing for any uniform random input distribution. Only the content layer (**C**) needs episodic writes, matching the Vector-HaSH scaffold/content factorization [[wiki/entities/vector-hash-model.md]].

---

## DenseNet: Sequence Memory Extension

Static Hopfield networks store individual memories as fixed-point attractors. Extending this to sequences requires *asymmetric* weights that drive transitions from one pattern to the next. Chaudhry et al. 2023 ([[wiki/papers/long-sequence-hopfield-chaudhry-2023.md]]) show that the same Dense Associative Memory nonlinearity that lifts static capacity from $N$ to $N^d$ (polynomial) or $\exp(N)$ (exponential) applies equally to sequence transitions.

**SeqNet weight matrix (baseline):**
$$J_{ij} = \frac{1}{N}\sum_\mu \xi_i^{\mu+1}\xi_j^\mu$$
Same crosstalk analysis as symmetric Hopfield; capacity $P \sim N$ — fails catastrophically beyond this.

**DenseNet upgrade:** Replace sign$(Jm)$ with sign$(\sum_\mu f(m^\mu)\,\xi^{\mu+1})$ where $f$ is the same nonlinear interaction function used in MHN. The nonlinearity suppresses overlapping-pattern contributions to the crosstalk, giving:

| Model | Sequence capacity $P_S$ | Mechanism |
|---|---|---|
| SeqNet (linear) | $\sim N$ | Linear asymmetric Hebbian |
| Polynomial DenseNet (degree $d$) | $\sim N^d / d$ | $f(x)=x^d$, same as static MHN (Modern Hopfield Network) |
| Exponential DenseNet | $\sim \exp(N)$ (approx.) | $f(x)=\exp((N{-}1)(x{-}1))$; Gaussian approx. |

**Key structural result:** The Polynomial DenseNet's single-transition capacity $P_T \sim N^d$ is *identical* to the static MHN (Modern Hopfield Network) capacity, because excluding self-interaction terms makes the single-bitflip crosstalk statistics identical for Rademacher patterns. The Demircigil et al. 2017 argument for static MHN (Modern Hopfield Network) is therefore a rigorous lower bound on sequence-transition capacity as well.

**Correlated patterns:** Standard theory assumes i.i.d. random patterns. For real-world correlated sequences (demonstrated on 200,000-frame MovingMNIST): exponential DenseNet achieves perfect recall; lower-degree polynomial variants fail. The **Generalized Pseudoinverse (GPI) rule** — applying the pseudoinverse of the pattern overlap matrix before the DenseNet transition — extends capacity to linearly independent but highly correlated pattern sets without modifying the nonlinearity.

**MixedNet for variable timing:** Combining symmetric ($f_S$, fast synapse: stay) and asymmetric ($f_A$, slow synapse: transition) terms enables the network to remain in each state for a controlled $\tau$ timesteps. Capacity scales as $\min(d_S, d_A)$. The fast/slow synapse distinction maps directly to AMPA/NMDA timescales in biological circuits.

---

## DNC: External Differentiable Content-Addressable Memory

Standard Hopfield networks store memories in synaptic weights — the same weights that generate the attractor dynamics. This entangles storage capacity with network size and makes the memory inaccessible for write-then-read-at-will operation within a single episode. The Differentiable Neural Computer (DNC; Graves et al. 2016 [[wiki/papers/dnc-graves-2016.md]]) externalizes the memory matrix entirely:

**Content lookup mechanism:**
$$C(\mathbf{M}, \mathbf{k}, \beta)[i] = \text{softmax}\!\left(\beta \cdot \frac{\mathbf{k} \cdot \mathbf{M}[i,\cdot]}{\|\mathbf{k}\|\,\|\mathbf{M}[i,\cdot]\|}\right)$$
A key vector **k** emitted by the controller is compared to every row of the N×W memory matrix M via cosine similarity. The soft attention weighting over locations is the differentiable analog of Hopfield's energy minimization: both implement *content-addressable retrieval* — identifying the stored location whose content best matches the query. Unlike Hopfield, partial match is a smooth soft weighting rather than a convergent discrete update, and a single query does not modify the memory.

**What this enables over weight-bound CAM:**

| Property | Hopfield / MHN (Modern Hopfield Network) | DNC (Differentiable Neural Computer) external CAM (Content-Addressable Memory) |
|---|---|---|
| Write mechanism | Outer product Hebbian (modifies weights) | Soft write to matrix row (weight-free) |
| Write speed | One-shot (no gradient) | One-shot (attention-based, within episode) |
| Read mechanism | Energy minimization (iterative) | Single attention step (one-shot) |
| Capacity | ~0.14N (linear) / O(exp d) (modern) | N locations (expandable without retraining) |
| Read-modify-write | Not supported | Yes — erase + add vectors per location |

**Critical empirical result:** LSTM (weight-bound associative memory only) reaches 37% accuracy on graph traversal; DNC (Differentiable Neural Computer) (content lookup over external memory) reaches 98.8%. The 2× gap demonstrates that content-addressable *external* memory is necessary for graph-structured reasoning — the weight-bound CAM (Content-Addressable Memory) mechanisms (Hopfield, MHN) that suffice for static pattern completion cannot support the iterative write-then-retrieve operations graph traversal requires.

**Relationship to Vector-HaSH scaffold:** Both DNC (Differentiable Neural Computer) and Vector-HaSH factorize dynamics from content. DNC (Differentiable Neural Computer) externalizes *all* memory into an explicit matrix managed by attention; Vector-HaSH externalizes the *scaffold* (fixed) while keeping the heteroassociative layer plastic. DNC (Differentiable Neural Computer) is the extreme: no capacity cliff, no attractor dynamics — pure key-value lookup with no interference between stored locations. The trade-off is that DNC (Differentiable Neural Computer) has no error-correcting basins (retrieval degrades linearly with key error), whereas Hopfield's attractors provide robustness to noisy cues.

---

## Spiking CA3 CAM: Bidirectional Retrieval (Casanueva-Morato et al. 2024)

All Hopfield-family models retrieve a stored pattern from a *cue* fragment (forward lookup). The biological CA3 must support the *reverse* direction: given a content fragment, recover which cue it belongs to — what Casanueva-Morato et al. 2024 ([[wiki/papers/spiking-cam-hippocampus-casanueva-2024.md]]) call **recall by content**.

**Architecture:** Two parallel STDP-connected sub-networks:

| Sub-network | Direction | Learns | Recalls |
|---|---|---|---|
| **S1** (recall by cue) | S1Cue→S1Cont (STDP) | cue–content association | cue fragment → full content |
| **S2** (recall by content) | S2Cont→S2Cue (STDP) | content–cue association | content fragment → all matching cues |

S2 receives its input from S1's output, ensuring forgetting operations propagate bidirectionally. A Merge structure equalizes S1/S2 output representations.

**STDP as implicit forgetting:** Overwriting a stored memory with a new one sharing the same cue proceeds in two sub-steps within a single 7-ms learning window:
1. The old content is recalled (post neurons fire before pre in the forgetting synapses → LTD).
2. The new content is encoded (pre fires before post → LTP).

No explicit "forget" call is needed; forgetting is a natural consequence of STDP's bidirectional window during the cue-collision event.

**Interneuron gating (temporal delay as router):** S2Int and S2Cond interneurons gate the content pathway using a 1 ms spike-timing race:
- During **learning/recall-by-content**: excitation and inhibition arrive at S2Cont simultaneously or excitation first → gate open.
- During **recall-by-cue**: S1Cue fires, generating inhibition that arrives at S2Cond *before* the excitatory signal from S1Cont → gate closed, preventing spurious forgetting.

**DG as one-hot encoder:** The cue sub-field is assumed to undergo maximum DG (Dentate Gyrus) sparsification (one-hot code), enabling the S1Cue subpopulation to reliably distinguish memories using single active neurons. This is the engineering formalization of the DG (Dentate Gyrus) pattern-separation function ([[wiki/concepts/pattern-separation.md]]).

**Non-orthogonal patterns:** Unlike prior spiking CAM (Content-Addressable Memory) proposals (which failed on overlapping patterns), bidirectional STDP + DG (Dentate Gyrus) one-hot encoding together handle non-orthogonal content patterns because the cues are always maximally separated, even when content overlaps.

**For a reasoning model:** Bidirectional CA3-CAM implements *reverse lookup in the latent graph* — the same structure as searching edges by label rather than source node. If transformations are stored as (cue=rule-id, content=observable-effect), then recall-by-content answers "which rules produce this observation?" — directly needed for Gap 1 (Transformation Inference, Block 3A).

---

## Open Problems

**CA3 connectivity:** Working estimate ~10% (Sammons 2023, mouse, 3D EM (Expectation Maximization) + octuple patch-clamp); Guzman 2016 (rat, slice) reported <1% and attributed pattern completion to enriched disynaptic motifs. At ~10%, random connectivity suffices — motif enrichment is unnecessary. Discrepancy attributed to species, preparation, and cell density; see [[wiki/open-problems.md]] Empirical Tensions for replication status.

- **CA1 combinatorial code:** CA1 provides a sparse invertible mapping between EC (Entorhinal Cortex) patterns and CA3's arbitrary codes — without it, EC (Entorhinal Cortex) (high overlap, many memories per neuron) would suffer catastrophic interference when associating with each novel CA3 pattern. CA1 must develop a combinatorial code representing novel inputs as recombinations of existing elements; how this code emerges during learning is unspecified in current CLS (Complementary Learning Systems) models (O'Reilly et al. 2011).
- How does CA3 autoassociation compose with DG (Dentate Gyrus) (pattern separation) and CA1 (output) to implement full episodic recall, and what is the exact division of labor?
- Can spurious attractor interference be quantitatively mapped to engram interference within the 6h temporal linkage window?
- Is there a continuum between pattern completion (CA3) and pattern separation (DG) that controls the generalization–memorization trade-off?
- Does the c × M ≈ const relationship (Sammons 2023) impose a biologically-realistic constraint on assembly size that should be enforced in ML models of CA3?

---

## For Building a Reasoning Model

Associative memory solves **key-based retrieval without explicit addressing**; a partial observation completes to the stored representation. Needed in:

- **Mediated inference:** the biological hippocampus traverses associative chains (X→Y, Y→Z) during inference to answer X→? without direct X-Z pairing. Dupret et al. 2020 demonstrate this via RSA: CA1 completes X to Y (one hop); mPFC/midbrain then resolve Y to Z. The key insight is that associative memory enables *inference by chaining* — the brain does not need to store all higher-order associations directly, only the first-order links. SWR (Sharp Wave Ripple) shortcuts (offline) eventually cache X→Z pairs to bypass the chain. For a reasoning model, this argues for a two-stage architecture: a CAM (Content-Addressable Memory) lookup module (HC-like) paired with a downstream outcome-translation module (mPFC-like). See [[wiki/concepts/prospective-coding.md]].
- **Block 3A (Transformation Inferrer):** retrieve the transformation rule most consistent with an observed before/after pair — a pattern completion over a stored vocabulary of transformations.
- **Block 3B (WM / context maintenance):** one-shot Hebbian write (W = YᵀY/n) is the biological fast-M mechanism for encoding context into HC in a single episode.
- **Attention mechanism:** modern Hopfield = transformer attention, so factorized keys/values (TEM-t) make every attention head a structured associative memory lookup over the structural code.
- **SDR and capacity:** Hopfield's ~0.14N capacity limit applies to dense random patterns. For sparse high-dimensional SDR (Sparse Distributed Representations) inputs, the same binary dot product overlap metric achieves $P(\text{FP}) < 10^{-27}$ with only 30 synapses per dendritic segment (Ahmad & Hawkins 2016). Designing ML associative memories with $k$-WTA output (rather than full softmax) keeps activations in the favorable SDR (Sparse Distributed Representations) regime [[wiki/concepts/sparse-distributed-representations.md]].

---

## Connections

- **[[wiki/concepts/attention.md]]** — the modern Hopfield update rule (Ramsauer 2020) is mathematically identical to transformer self-attention; softmax = Boltzmann distribution over key-query similarities; every transformer attention head is an associative memory retrieval with exponential storage capacity.
- **[[wiki/concepts/two-learning-timescales.md]]** — one-shot Hebbian learning (W = YᵀY/n) is the fast-M write mechanism: single-trial exposure suffices with no backprop, paralleling hippocampal LTP; modern Hopfield exponential capacity is what TEM-t exploits over the linear-capacity original.
- **[[wiki/concepts/engrams.md]]** — CA3 recurrent collaterals + LTP (Long-Term Potentiation) implement biological associative memory; engram pattern completion (partial cue → full episode) is Hopfield fixed-point convergence; spurious attractors map to engram interference when engram density exceeds ~0.14N.
- **[[wiki/concepts/working-memory.md]]** — the classical attractor theory of WM (persistent activity; Fuster, Goldman-Rakic) is a Hopfield network held at a stored pattern; the attractor vs. transient-trajectory debate is whether WM uses Hopfield fixed points or dynamic trajectory paths.
- **[[wiki/entities/boltzmann-machine.md]]** — Boltzmann Machine generalizes Hopfield by adding stochasticity (temperature T) and hidden units; deterministic Hopfield is the T→0 limit; contrastive Hebbian extends one-shot Hebbian by adding a free-running negative phase that shapes the full energy landscape.
- **[[wiki/concepts/binding-problem.md]]** — pattern completion across distributed feature representations implements implicit binding: a partial cue (one feature) completes to the full bound-object representation without requiring explicit conjunctive neurons.
- **[[wiki/papers/hopfield-networks-crouse-2022.md]]** — primary source: classical and modern Hopfield tutorial, energy proof, Hebbian learning, and CA3 pattern completion discussion.
- **[[wiki/papers/ca3-sammons-2023.md]]** — empirical grounding for CA3 as a high-connectivity (~9-11%) autoassociative network; random connectivity sufficient for pattern completion; log-normal weight distribution; c × M ≈ const relationship for assembly replay.
- **[[wiki/concepts/pattern-separation.md]]** — DG (Dentate Gyrus) orthogonalizes inputs before CA3 storage; without it, CA3 attractor completion produces spurious attractors from inter-episode overlap; the capacity formula and five mechanisms live there.
- **[[wiki/papers/pattern-completion-rolls-2013.md]]** — source for capacity formula, five DG (Dentate Gyrus) mechanisms, diluted connectivity advantage, encoding-recall anatomical separation; full treatment now in pattern-separation.md.
- **[[wiki/concepts/neuromodulation.md]]** — ACh suppresses CA3→CA3 RC synapses during encoding, amplifying the mossy fiber structural dominance; the neuromodulatory and structural mechanisms are convergently redundant implementations of the same encoding logic.
- **[[wiki/papers/cls-oreilly-2011.md]]** — source for CA1's sparse invertible mapper role as the architectural fix for EC-level catastrophic interference; establishes that HC's associative memory requires not just CA3 (pattern completion) and DG (Dentate Gyrus) (pattern separation) but CA1 (combinatorial re-encoding) to fully avoid interference at the system boundary.
- **[[wiki/papers/podlaski-context-modular-memory-2025.md]]** — extends the Hopfield framework with context-dependent neuronal and synaptic gating; formally derives that the observed 20–30% sparse engram fraction is the optimal neuronal gating ratio; shows that synaptic refinement can encode memories in the gating mask alone, independent of synaptic weights.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the Hopfield binary dot product overlap metric is identical to the SDR (Sparse Distributed Representations) overlap metric; SDR (Sparse Distributed Representations) scaling laws explain why Hopfield's ~0.14N capacity limit can be surpassed when inputs are sparse and high-dimensional, directly motivating $k$-WTA activations in ML associative memories.
- **[[wiki/papers/ahmad-hawkins-sdr-2016.md]]** — derives the false positive hypergeometric formula and union property for binary dot product pattern matching over sparse populations; provides the theoretical underpinning for why CA3 achieves low-interference storage at biologically realistic densities.
- **[[wiki/concepts/hebbian-learning.md]]** — the one-shot Hopfield storage rule ($W = Y^\top Y / n$) is the multi-pattern Hebbian rule; the PCA derivation shows why Hebbian weights converge to the dominant covariance structure; Hebbian instability is the formal reason sparse codes are required before any associative write.
- **[[wiki/entities/vector-hash-model.md]]** — Vector-HaSH resolves the memory cliff by factorizing fixed-point generation (scaffold, immutable) from content storage (heteroassociative layer, plastic); achieves ⟨K⟩^M capacity with O(M) neurons; no cliff — graceful capacity-detail tradeoff instead.
- **[[wiki/papers/vector-hash-chandra-2023.md]]** — source for scaffold/content factorization, exponential capacity analysis, sequence memory via shift operator, and memory palace circuit model.
- **[[wiki/concepts/sequence-memory.md]]** — DenseNet extends the static Hopfield/MHN attractor framework to directed asymmetric sequences: the same nonlinear crosstalk reduction lifts sequence capacity from $N$ to $N^d$ identically to static memory; the GPI rule and MixedNet variable-timing extension are the sequence-specific additions.
- **[[wiki/papers/long-sequence-hopfield-chaudhry-2023.md]]** — source for DenseNet sequence extension: capacity derivations, MixedNet analysis, GPI rule, bipartite biologically plausible implementation.
- **[[wiki/entities/dnc-model.md]]** — DNC (Differentiable Neural Computer) content lookup is a differentiable soft-attention implementation of content-addressable retrieval; unlike Hopfield's iterative energy minimization, DNC (Differentiable Neural Computer) achieves one-step retrieval and supports write-modify-read within a single episode; DNC (Differentiable Neural Computer) proves that external CAM (Content-Addressable Memory) is necessary for graph traversal (98.8% vs LSTM 37%) where weight-bound associative memory fails.
- **[[wiki/papers/dnc-graves-2016.md]]** — source for DNC (Differentiable Neural Computer) content-based addressing formalism, dynamic allocation mechanism, temporal link matrix, and empirical graph-reasoning results establishing that external read-write CAM (Content-Addressable Memory) is architecturally necessary for structured reasoning tasks.
- **[[wiki/entities/sdm-model.md]]** — SDM (Sparse Distributed Memory) is the unifying framework from which Hopfield and correlation-matrix memories derive as special cases; its M-based capacity τ ≈ 0.1 (independent of pattern dimension N) is the architectural rationale for choosing hard-location count M as the primary fast-M capacity design parameter rather than neuron count N.
- **[[wiki/papers/kanerva-sdm-1993.md]]** — source for the Hopfield/correlation-matrix/SDM unification; Keeler (1988) capacity equivalence result; DG→CA3 and cerebellar biological mappings; proof that a fixed random projection suffices as the address structure for the fast-M store.
- **[[wiki/entities/equilibrium-propagation.md]]** — EqProp is the gradient-correct supervised training algorithm for continuous Hopfield networks; it replaces CHL (Contrastive Hebbian Learning) by using weak output clamping (β small) rather than full clamping, computing the exact gradient of the prediction error at equilibrium via the same leaky-integrator dynamics used for inference.
- **[[wiki/papers/scellier-bengio-eqprop-2017.md]]** — establishes EqProp as the theoretical resolution to training continuous Hopfield networks with a well-defined objective; Theorem 1 proves the contrastive update computes ∂J/∂W exactly in the limit β→0.
- **[[wiki/entities/cerebellum.md]]** — cerebellar cortex implements a supervised variant of SDM (Sparse Distributed Memory) where climbing fibers carry the word-in error signal; parallel fiber→Purkinje LTD (Long-Term Depression) is the supervised analog of Hebbian C-matrix updates; both HC and cerebellum confirm SDM (Sparse Distributed Memory) as a domain-general memory primitive.
- **[[wiki/papers/spiking-cam-hippocampus-casanueva-2024.md]]** — concrete SNN instantiation of bidirectional CA3-CAM; two parallel STDP sub-networks (S1: cue→content, S2: content→cue) enable reverse lookup; STDP forgetting is implicit via the LTD (Long-Term Depression) branch on cue-collision events; DG (Dentate Gyrus) one-hot encoding is the operational mechanism enabling non-orthogonal pattern handling.
- **[[wiki/entities/snn.md]]** — the spiking CA3-CAM is a content-addressable retrieval application of SNNs; STDP is the unsupervised learning rule driving both storage and implicit forgetting; SpiNNaker platform validates the approach on neuromorphic hardware.
- **[[wiki/entities/hami-model.md]]** — HAMI's symbolic indexing reduces high-dimensional CAM (Content-Addressable Memory) retrieval to exact lookup over a 6-bit codebook; represents the discrete-quantization extreme of the CAM (Content-Addressable Memory) spectrum (vs. Hopfield's continuous energy minimization and DNC's soft attention); NVM-CAM hardware alignment enables single-clock-cycle parallel search across all stored episodic memories.
- **[[wiki/concepts/prospective-coding.md]]** — prospective coding is content-addressable lookup in an asymmetric (directed) associative store: X retrieves Y because STDP encoded the X→Y temporal order; the directional asymmetry distinguishes prospective from standard (symmetric) Hopfield retrieval.
- **[[wiki/papers/inferential-reasoning-dupret-2020.md]]** — demonstrates that biological associative chains (X→Y, Y→Z) can be traversed at inference time via CA1 pattern completion; SWR (Sharp Wave Ripple) shortcuts later compress the two-hop chain into a direct X→Z association, showing how higher-order relational structure emerges from first-order pairwise memories.
