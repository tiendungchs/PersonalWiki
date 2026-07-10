---
title: "Continual Learning"
type: concept
tags: [continual-learning, catastrophic-forgetting, synaptic-consolidation, EWC, plasticity, lifelong-learning]
created: 2026-06-21
updated: 2026-07-08

sources: [Neuroscience-Inspired Artificial Intelligence, High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations, Improving the adaptive and continuous learning capabilities of artificial neural networks Lessons from multi-neuromodulatory dynamics, Dendrites endow artificial neural networks with accurate, robust and parameter-efficient learning, Hybrid neural networks for continual learning inspired by corticohippocampal circuits, Interplay of hippocampus and prefrontal cortex in memory]
related: [wiki/concepts/two-learning-timescales.md, wiki/concepts/hebbian-learning.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/associative-memory.md, wiki/concepts/neuromodulation.md, wiki/concepts/memory-schemas.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/vector-hash-model.md, wiki/entities/snn.md, wiki/concepts/dendritic-computation.md, wiki/papers/cls-mcclelland-1995.md, wiki/papers/cls-oreilly-2011.md, wiki/papers/hassabis-neuroscience-ai-2017.md, wiki/papers/vector-hash-chandra-2023.md, wiki/concepts/world-models.md, wiki/papers/kessler-continual-dreamer-2023.md, wiki/papers/mei-multimodulatory-continual-2025.md, wiki/papers/chavlis-dann-2025.md, wiki/entities/ch-hnn-model.md, wiki/papers/shi-ch-hnn-2025.md, wiki/papers/preston-eichenbaum-hpc-pfc-2013.md, wiki/concepts/meta-learning.md, wiki/concepts/differentiable-plasticity.md, wiki/concepts/btsp.md, wiki/entities/hnn-framework.md]
---

# Continual Learning

**Continual learning is the capacity to acquire new tasks sequentially without catastrophic forgetting — where catastrophic forgetting is the overwriting of prior task parameters by gradient descent on a new task's objective.**

The core tension: plasticity (ability to update for new tasks) must coexist with stability (retention of prior tasks). These goals are in direct conflict under standard gradient descent on a single parameter set.

---

## Catastrophic Forgetting

Given tasks T₁ (already learned, optimal parameters θ₁*) and T₂ (new), gradient descent on L(T₂) moves θ toward θ₂*, erasing the T₁ solution. Severity scales with the overlap between the parameter subspaces used by each task. No task-boundary signal is required — gradients from T₂ data alone suffice to destroy T₁ performance.

Formal condition for no forgetting: θ₁* ≈ θ₂* (tasks share the same solution), OR the T₁ loss landscape is flat at the current parameters (T₁ performance is insensitive to the relevant weight directions). Neither condition is generic.

---

## Biological Solutions

| Mechanism | Where | How | AI analog |
|---|---|---|---|
| **Synaptic consolidation** | Neocortex | Strengthened spines become less labile; optogenetic erasure of consolidated spines reinstates forgetting; persists months | EWC (Elastic Weight Consolidation) importance-weighting |
| **Complementary Learning Systems** | HC + neocortex | HC encodes rapidly (one-shot, sparse); SWR (Sharp Wave Ripple) replay during rest drives interleaved neocortical consolidation | Rehearsal / experience replay; two-system architecture |
| **Cascade metaplasticity** | All synapses | Synapses transition between high- and low-plasticity states; recent potentiation → high-plasticity; stability by settling into low-plasticity cascade state | Online EWC (Elastic Weight Consolidation) approximations; momentum-based optimizers |
| **BTSP stochastic gating** | CA1 | Stochastic plateau potentials ($f_q$ ≈ 0.005) uniformly distribute memory load across all CA1 neurons regardless of prior activity; unlike Hebbian rules, highly active neurons are not preferentially recruited for new memories; Wu & Maass 2025 show memory traces for items learned early and late in a 10k-item sequence have equal quality [[wiki/papers/wu-maass-btsp-2025.md]] | Random gating of which neurons store each item; $f_q$ as a modulated capacity dial |

---

## Elastic Weight Consolidation (EWC)

Direct formalization of synaptic consolidation (Kirkpatrick et al. 2017):

$$\mathcal{L}(\theta) = \mathcal{L}_B(\theta) + \sum_i \frac{\lambda}{2} F_i \left(\theta_i - \theta^*_{A,i}\right)^2$$

| Term | Interpretation |
|---|---|
| $\mathcal{L}_B(\theta)$ | Loss on new task B |
| $\theta^*_{A,i}$ | Parameter $i$ optimal for task A |
| $F_i$ | Fisher information of $\theta_i$ w.r.t. task A: how much does this weight matter? |
| $\lambda$ | Plasticity-stability trade-off coefficient |

High $F_i$ → large penalty → parameter stays near θ*_A → T₁ performance retained. Low $F_i$ → free to move → T₂ learned efficiently. Weights shared between tasks can simultaneously satisfy both constraints when their T₁ and T₂ optima overlap. Allows multi-task learning with fixed network capacity.

**Connection to spine lability:** $F_i$ is the AI analog of spine size/rigidity — high-information weights correspond to enlarged, stabilized spines; low-information weights correspond to thin, plastic spines.

---

## Schema-Based Consolidation

Memory consolidation is not a simple transfer of HC episodes to cortex but integration of new memories into existing schematic networks ([[wiki/concepts/memory-schemas.md]]) via two Piagetian processes (Preston & Eichenbaum 2013 [[wiki/papers/preston-eichenbaum-hpc-pfc-2013.md]]):

**Assimilation (overlap is high):** New events fit a pre-existing schema → HC encodes in a single trial; mPFC is recruited from the start because schema provides organizational context. The new memory is immediately coherent with prior knowledge. Tse et al. demonstrated one-trial acquisition of new flavor-place associations once the schema was established.

**Accommodation (conflict):** New events contradict existing associations → mPFC drives schema modification. PFC lesions block adaptation to conflicting A-B vs. A-C pairings and increase intrusions from prior associations.

**Design implication:** A reasoning model's consolidation module should distinguish assimilation from accommodation:
- *Assimilation path:* high schema overlap → fast-M writes directly into existing schema slot; mPFC-analog confirms schema match
- *Accommodation path:* conflict detected → slow-W mPFC-analog modification triggered; existing schema weights selectively updated

This extends CLS (fast HC / slow neocortex) to a three-way interaction: HC writes rapidly, mPFC monitors for conflict, slow cortex integrates schema-consistent replays over time. The accommodation path is the biological analog of EWC-style importance-weighting, but driven by mPFC conflict detection rather than Fisher information computation — and it is event-triggered rather than task-boundary-triggered.

---

## CLS (Complementary Learning Systems) as Continual Learning Architecture

McClelland et al. 1995 and O'Reilly et al. 2011 show that the *architectural* solution to catastrophic forgetting is separating fast and slow stores:

| CLS (Complementary Learning Systems) component | Continual learning role |
|---|---|
| HC sparse encoding | Rapid acquisition of new episodes without interference — high sparsity → orthogonal codes → near-zero overlap with prior HC memories |
| SWR (Sharp Wave Ripple) offline replay | Drives neocortical weight updates via interleaved replay, gradually extracting shared structure without disrupting previously consolidated knowledge |
| Neocortex slow-W | Never required to encode an episode in one shot — only updates incrementally across many replayed presentations |

The fundamental insight: catastrophic forgetting arises from single-system fast learning on overlapping representations. CLS (Complementary Learning Systems) eliminates the conflict by ensuring the slow store (neocortex) is never asked to write rapidly.

---

## SDR (Sparse Distributed Representations) Sparsity as Continual Learning Enabler

Sparse distributed representations reduce between-task interference passively. Two random k-hot patterns over N neurons have expected overlap $\binom{n}{k}^{-2}$ — exponentially small in k. DG's ~2% active fraction (k ≈ 0.02N) gives near-zero expected overlap between any two memories without explicit importance-weighting. This is why pattern separation precedes CA3 storage: it converts arbitrary entorhinal inputs into maximally orthogonal HC codes, protecting existing CA3 attractor basins from interference. See [[wiki/concepts/sparse-distributed-representations.md]] for the hypergeometric bound.

**Design implication:** k-WTA sparsity on the fast-M write layer provides continual learning protection for free, without requiring Fisher information computation or explicit task boundary detection.

**Structured sparsity (dANN, Chavlis & Poirazi 2025):** random k-WTA sparsity is not necessary — *structured* sparsity (tree-like dendritic connectivity + receptive-field input restriction) provides similar sequential learning benefits. In class-incremental learning experiments, dANNs maintained higher accuracy and lower variance across initializations than vanilla ANNs of matched accuracy, without any explicit CL mechanism. The structured topology acts as a distributed regularizer, reducing gradient interference between tasks at the architectural level. This suggests that connectivity structure, not just density, determines CL robustness.

---

## Vector-HaSH Scaffold Space: Structural Solution to Catastrophic Forgetting

EWC and CLS (Complementary Learning Systems) address catastrophic forgetting by constraining how gradient updates are applied. Vector-HaSH (Chandra et al. 2023 [[wiki/papers/vector-hash-chandra-2023.md]]) provides a structurally different solution: make the forgetting mechanism inapplicable.

**The argument:** Hopfield-style models forget because adding a new pattern changes the recurrent weight matrix, which shifts all existing attractor basins. Vector-HaSH's scaffold fixed points are generated by the *grid circuit and fixed random projections* — neither changes when new content is learned. Only the heteroassociative (HC↔neocortex) weights are plastic. Adding item N+1 perturbs only the mapping from scaffold states to cortical patterns; the attractor basins remain exactly the same.

**Capacity-detail tradeoff (graceful degradation):** as heteroassociative weights accumulate more patterns, reconstruction fidelity degrades — older memories are recalled with less detail. But no memory is suddenly erased. This is qualitatively different from the Hopfield cliff (perfect recall → complete failure at a threshold) and matches human experience better: old memories fade in detail rather than disappearing.

**Exponential space prevents interference:** the ⟨K⟩^M scaffold states (M modules) guarantee that each new item can be assigned to a previously unused scaffold state with high probability, as long as M is adequate. Interference between items requires two items to share a scaffold state — probability drops exponentially with M.

**Comparison of continual learning strategies:**

| Strategy | Mechanism | Cliff? | Requires task boundary? |
|---|---|---|---|
| EWC (Elastic Weight Consolidation) | Fisher-weighted penalty on important weights | No, but degrades with tasks | Yes (to compute F_i) |
| CLS (Complementary Learning Systems) (HC replay) | Separate fast/slow stores; interleaved consolidation | No, if replay is adequate | No |
| SDR (Sparse Distributed Representations) sparsity | Orthogonal codes → near-zero interference passively | Probabilistic cliff at very high load | No |
| **Vector-HaSH scaffold** | Scaffold fixed points immune to content updates | No — structural guarantee | No |
| **World model + replay** | Imagination-trained policy; persisting cross-task replay buffer | No | No |

**Design implication:** a reasoning model's episodic fast-M layer should treat the scaffold as frozen infrastructure (analogous to pretrained weights) and confine all new learning to the heteroassociative layer. This avoids the need for importance-weighting, replay, or task-boundary detection.

---

## Model-Based (World Model) Approaches

**Key insight:** training a policy *inside the world model* (in imagination) instead of on real data decouples the policy gradient from the replay buffer. Only the experience buffer — not gradients — crosses task boundaries.

**Continual-Dreamer (Kessler et al. 2023):** DreamerV2 (RSSM world model) + reservoir-sampled replay buffer.

| Component | Role |
|---|---|
| RSSM world model | Learns forward dynamics from the shared replay buffer; updated across all tasks |
| Actor-critic (in imagination) | Policy trained on imagined rollouts from frozen world model; no real-data gradient interference between tasks |
| Reservoir buffer | Stores real experience across all tasks; world model trains from this |

**Reservoir sampling:** accept episode $t$ into the buffer with probability $\min(n/t, 1)$ where $n$ = buffer capacity. Maintains a uniform distribution over all past tasks as the buffer fills. Outperforms coverage maximization (distance-based) and recent-biased (50:50) strategies.

**Buffer size = stability-plasticity dial (empirically quantified):**
- Large buffer → past task data dominates → less forgetting (stability ↑), slower new skill acquisition (plasticity ↓)
- Hard exploration tasks (HideNSeek-v0) fail with large buffers: new task transitions too rare to guide exploration against the mass of old task data

**Interference failure mode:** when reward functions change across tasks within the same environment, the world model correctly predicts reward for past tasks — and the actor trained in imagination then pursues the wrong reward for the new task. Replaying old (observation, reward) pairs actively misleads the new task. Current workaround: task-specific output heads, which breaks task-agnosticity and requires a task identity signal.

**Design implication for reasoning models:** the world model architecture naturally factorizes task knowledge — the world model (transition dynamics, observation model) is shared across tasks; only the actor/cost is task-specific. This maps onto the [[wiki/concepts/two-learning-timescales.md]] split: shared world model ≈ slow-W structural knowledge; per-task actor ≈ fast-M task-specific policy.

---

## Neuromodulatory Plasticity Gating in Continual Learning (Mei et al. 2025)

Neuromodulatory systems provide a biological solution to catastrophic forgetting that is orthogonal to EWC/CLS/SDR approaches — they actively gate *which synapses are plastic* and *when* plasticity is permitted, rather than structurally separating stores or regularizing weights ([[wiki/papers/mei-multimodulatory-continual-2025.md]]).

**Synaptic tagging:** Neuromodulators (DA, ACh, NA) selectively "tag" recently active synapses for plasticity modulation. Tagged synapses can be stabilized (if the associated event was task-relevant) or pruned (if irrelevant), without requiring explicit importance-weighting or task boundary signals. This is the biological analog of EWC's Fisher information weighting, but implemented online via chemical signals rather than offline via gradient computations.

**LC/NA network-reset as contingency-shift detector:** The locus coeruleus (LC) operates in two modes:
- **Phasic LC (tonic low):** promotes focused attention and exploitation of known contingencies
- **Tonic LC (elevated baseline):** promotes behavioral flexibility and exploration

When the environment changes unexpectedly, a predictive coding discrepancy drives a phasic LC burst, releasing NA (Noradrenaline / Norepinephrine) broadly. This transiently flattens the network's attractor landscape, enabling cross-basin exploration and rapid adaptation to new contingencies — without requiring an explicit task boundary signal. In the Mei et al. SNN demo, DA-only learning fails after a contingency set-shift (trapped in old optimum), while DA+NA co-modulation recovers via NA-driven entropy increase H(A|C) that enables resampling of action policies.

**Neuromodulator → CL paradigm mapping:** Different CL regimes preferentially engage different neuromodulatory systems:

| CL Paradigm | Key Neuromodulator | Role |
|---|---|---|
| Transfer learning | ACh (BF→HC/PFC) | Schema tagging: encode shared structure; suppress task-specific details |
| Meta-learning | Dopamine (VTA/SNc→PFC/striatum) | Slow weight update (outer loop) trains recurrent fast RL (inner loop) |
| Multi-task learning | ACh + NA (Noradrenaline / Norepinephrine) | Attention allocation + task-switching; ACh prioritizes relevant inputs; NA (Noradrenaline / Norepinephrine) gates task transitions |
| Incremental learning | Dopamine + ACh | Dopamine = which new experiences are worth writing; ACh = high → write fast, low → protect old memories |
| Online learning | NA (Noradrenaline / Norepinephrine) (LC) | Rapid contingency detection and network reset; NA (Noradrenaline / Norepinephrine) burst = "environment has changed, relearn" |

**Metabotropic timescale gap in ANNs:** The slow metabotropic pathway (second-messenger cascades → gene expression → structural synaptic changes) operates over seconds-to-minutes and implements the long-term stabilization component of continual learning. Current ANNs have no principled analog — LSTM gating and learning-rate schedules approximate only the fast ionotropic effects. The metabotropic path is essential for the observed months-long synaptic consolidation that defines the biological stability end of the plasticity-stability spectrum.

---

## Hybrid Architecture: Meta-Continual Learning via Learned Modulation (HMN)

Zhao et al. 2022 ([[wiki/entities/hnn-framework.md]]) demonstrate a hybrid ANN+SNN approach to continual learning that achieves parameter reuse across similar tasks without requiring explicit task boundaries or importance-weighting.

**Architecture:** ANN backbone (trained on task similarity objective) → learnable HU → threshold modulation vector $V_{\text{th}}$ → applied to SNN branch neurons during each sub-task. Similar tasks produce cosine-similar $V_{\text{th}}$, activating overlapping subnets; dissimilar tasks produce orthogonal $V_{\text{th}}$, activating disjoint subnets.

**Key results (permuted N-MNIST, 40 sequential tasks):**
- Single SNN accuracy saturates and drops after ~10 tasks (catastrophic forgetting)
- HMN accuracy keeps rising with more tasks (positive transfer from similar tasks)
- Outperforms SNN+EWC, SNN+SI, SNN+CDG in mean accuracy after 40 tasks
- Works for *unlearned* tasks with similar structure (backbone generalizes task-similarity geometry)

**Comparison to existing CL strategies:**

| Strategy | Mechanism | Cliff? | Task boundary? | Reuse? |
|---|---|---|---|---|
| EWC | Fisher-weighted penalty | No | Yes | No |
| CLS (HC replay) | Separate fast/slow stores | No | No | Partial |
| SDR sparsity | Orthogonal codes passively | Probabilistic | No | No |
| Vector-HaSH scaffold | Structural guarantee | No | No | No |
| **HMN threshold modulation** | **Learned per-task subnet gating** | **No** | **Soft (similarity)** | **Yes — explicit reuse for similar tasks** |
| **CH-HNN episode inference** | **ANN masks partition SNN into per-episode sub-networks** | **No** | **No (task-agnostic)** | **Yes — ANN encodes cross-episode regularities** |
| World model + replay | Imagination training | No | No | Partial |

**Distinctive contribution:** HMN is the only listed approach that *explicitly learns* to reuse subnets for similar tasks by encoding task similarity into the modulation signal geometry. Other approaches prevent interference; HMN additionally promotes positive transfer.

---

## Corticohippocampal Episode Inference (CH-HNN)

Shi et al. 2025 ([[wiki/papers/shi-ch-hnn-2025.md]]) map the biological mPFC-CA1 / DG-CA3 recurrent loop onto a hybrid ANN+SNN system ([[wiki/entities/ch-hnn-model.md]]), extending the HMN approach with explicit corticohippocampal circuit grounding and bidirectional loop validation.

**Episode inference:** ANN (mPFC-CA1 analog, trained offline on prior episodes) generates sparse binary masks **R** that gate SNN (DG-CA3 analog) hidden neurons. Mask cosine similarity mirrors inter-episode similarity: similar episodes activate overlapping sub-networks; dissimilar episodes activate disjoint ones. No task boundary signal or task oracle is required.

**Bidirectional loop, both directions validated:**
- *Feedforward (mPFC-CA1 → DG-CA3):* ANN guidance is the dominant contribution; ablation shows episode inference accounts for ~100% of performance gains in class-incremental settings
- *Feedback (DG-CA3 → mPFC-CA1):* Incremental ANN training progressively improves the ANN's ability to generalize across episodes, confirming that novel SNN embeddings enhance mPFC-CA1 encoding of episodic regularities

**Metaplasticity (biological DA/5-HT analog):**

$$W_{i+1} = W_i - \alpha \cdot e^{-|mW_i|}$$

Reduces each synapse's learning capacity as its weight grows; primarily stabilizes old memories when ANN guidance is weak (off-domain priors). Not the primary forgetting prevention mechanism when episode inference is accurate.

**Episode inference vs. engrams:** CH-HNN's success implies that prior-knowledge regularities extracted by the ANN are sufficient for task-agnostic routing — episodes need not be encoded via per-episode physical engram allocation. This is a computational argument against discrete engrams as the primary mechanism during incremental learning (see [[wiki/concepts/engrams.md]] and [[wiki/empirical-tensions.md]]).

**Design implication for reasoning models:** A fast-M layer should implement episode inference rather than per-episode engram allocation: a slow-W module pre-trained on related prior knowledge can generate routing masks that partition the fast-M store into episode-specific sub-networks without explicit task identity, enabling task-agnostic continual learning.

---

## Open Problems

- **Online importance estimation:** EWC (Elastic Weight Consolidation) requires a completed task and known objective to compute $F_i$; continuous task-boundary-free learning has no clear when-to-consolidate signal.
- **Compositional continual learning:** tasks sharing sub-structures should share sub-network weights; importance-weighting at the individual parameter level cannot express structural reuse — an open architectural problem.
- **Neocortical consolidation mechanism:** CLS (Complementary Learning Systems) posits gradient descent on replayed HC examples as the neocortical update rule; biologically plausible approximations (PC-based replay) are still approximate and lose convergence guarantees.
- **Capacity renewal:** as the slow store fills, old low-priority memories must be displaced; the biological mechanism (DG neurogenesis as capacity renewal; [[wiki/concepts/adult-neurogenesis.md]]) has no established AI analog.
- **Metabotropic cascade in ANNs:** the slow second-messenger pathway (cAMP, PKA, gene expression) that drives months-long synaptic stabilization has no ANN analog; bridging ionotropic (fast gate) to metabotropic (structural plasticity) timescales is unsolved.

---

## Connections

- **[[wiki/concepts/two-learning-timescales.md]]** — CLS (Complementary Learning Systems) is the primary biological solution to continual learning: fast-M (HC) takes the plasticity burden while slow-W (neocortex) provides stability; the interaction between the two stores via SWR (Sharp Wave Ripple) replay is the continual learning mechanism.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — HC's BTSP one-shot encoding and DG (Dentate Gyrus) sparsity implement the fast-store side of CLS (Complementary Learning Systems) continual learning; SWR (Sharp Wave Ripple) replay is the interface that drives neocortical consolidation without interference.
- **[[wiki/concepts/btsp.md]]** — stochastic plateau gating ($f_q$) is the BTSP mechanism for load-balancing memory allocation across CA1 neurons; unlike Hebbian rules, it prevents repeated recruitment of a small neuron subset and achieves equal memory quality for items learned early and late in a long sequence.
- **[[wiki/papers/wu-maass-btsp-2025.md]]** — demonstrates empirically (Fig. 5E) that BTSP shows equal reconstruction quality for the first and last 100 items in a 10,000-item sequence, contrasting with postsynaptic-firing-dependent one-shot rules that degrade for early items.
- **[[wiki/papers/cls-mcclelland-1995.md]]** — foundational account of CLS (Complementary Learning Systems) as continual learning solution; catastrophic interference as the formal proof of why architectural separation is necessary; interleaved training as the consolidation protocol.
- **[[wiki/papers/cls-oreilly-2011.md]]** — updated CLS (Complementary Learning Systems) account; CA1 as invertible mapper; theta-phase error-driven learning; consolidation as transformation (not simple transfer).
- **[[wiki/concepts/sparse-distributed-representations.md]]** — SDR (Sparse Distributed Representations) sparsity reduces between-task interference by orthogonalizing stored patterns; hypergeometric false-positive bound gives the continual learning protection quantitatively.
- **[[wiki/concepts/hebbian-learning.md]]** — Hebbian instability is the micro-level cause of catastrophic forgetting in single-system fast learning; EWC (Elastic Weight Consolidation) and sparsity are the two principled solutions that address the same instability at network scale.
- **[[wiki/papers/hassabis-neuroscience-ai-2017.md]]** — survey source; provides the two-photon spine evidence connecting neocortical lability reduction to EWC; describes EWC (Elastic Weight Consolidation) as the first direct transfer of synaptic consolidation findings to deep RL.
- **[[wiki/entities/vector-hash-model.md]]** — scaffold/content factorization makes catastrophic forgetting structurally inapplicable to scaffold fixed points; only heteroassociative weights are plastic; graceful capacity-detail tradeoff rather than cliff.
- **[[wiki/concepts/associative-memory.md]]** — the memory cliff is the catastrophic forgetting failure mode for Hopfield-style associative memory; Vector-HaSH's scaffold approach is the architectural fix that eliminates the cliff.
- **[[wiki/papers/vector-hash-chandra-2023.md]]** — source for scaffold-based continual learning; exponential scaffold space, graceful degradation analysis, and comparison to standard Hopfield forgetting.
- **[[wiki/concepts/world-models.md]]** — DreamerV2's imagination-based policy training decouples task gradients from the replay buffer, enabling world models to support CRL; the world model = shared slow-W knowledge, the per-task actor = fast-M policy, instantiating the two-timescale split in a model-based RL system.
- **[[wiki/papers/kessler-continual-dreamer-2023.md]]** — source for the model-based CRL section; Continual-Dreamer (DreamerV2 + reservoir replay) is the first task-agnostic world-model-based CRL method; reservoir sampling as the dominant replay strategy; buffer-size tradeoff and interference failure mode.
- **[[wiki/concepts/neuromodulation.md]]** — the four neuromodulatory systems (DA/ACh/5-HT/NA) gate plasticity in a CL-paradigm-specific way; synaptic tagging (DA/ACh) is the biological analog of EWC (Elastic Weight Consolidation) importance-weighting; LC/NA network-reset is the task-agnostic contingency-shift detector that CLS/EWC-based methods cannot implement without an explicit task boundary signal.
- **[[wiki/concepts/dendritic-computation.md]]** — dANN structured sparsity (dendritic connectivity) reduces sequential learning interference without any explicit CL mechanism, demonstrating that structured bio-inspired architecture is an alternative route to CL robustness complementary to EWC/CLS/SDR approaches.
- **[[wiki/papers/chavlis-dann-2025.md]]** — source for dANN sequential learning results: structured dendritic sparsity reduces class-incremental interference, with the LRF sampling variant showing best robustness across initializations.
- **[[wiki/entities/snn.md]]** — SNNs with Dopamine R-STDP + LC-inspired NA (Noradrenaline / Norepinephrine) burst implement three-factor neuromodulated CL; the Go/No-Go demo (Mei et al. 2025) shows the minimal architecture needed for contingency-adaptive continual learning.
- **[[wiki/papers/mei-multimodulatory-continual-2025.md]]** — source for neuromodulatory plasticity gating (synaptic tagging), CL paradigm mapping (Table 1), LC/NA network-reset mechanism, and the DA+NA SNN demo quantifying how NA (Noradrenaline / Norepinephrine) entropy increase enables post-set-shift recovery.
- **[[wiki/entities/hnn-framework.md]]** — HMN is the first published hybrid ANN+SNN CL architecture to explicitly learn task-similarity geometry in modulation space, achieving both interference prevention (dissimilar tasks → disjoint subnets) and positive transfer (similar tasks → overlapping subnet reuse) — a combination that EWC/CLS/SDR approaches do not simultaneously achieve.
- **[[wiki/entities/ch-hnn-model.md]]** — CH-HNN grounds the ANN+SNN episode-routing principle in the explicit mPFC-CA1/DG-CA3 corticohippocampal circuit, validates both directions of the recurrent loop via ablation, and introduces metaplasticity as a stability backstop; it extends HMN with biological fidelity and bidirectional loop validation.
- **[[wiki/papers/shi-ch-hnn-2025.md]]** — source for CH-HNN architecture, episode inference mechanism, metaplasticity formulation, bidirectional loop ablations, and neuromorphic energy results.
- **[[wiki/concepts/memory-schemas.md]]** — schema assimilation (fast one-trial HC encoding when schema overlap is high) vs. accommodation (mPFC-driven schema modification when conflict arises) is the biological account of the consolidation mechanism that CLS describes at the algorithmic level; the assimilation/accommodation distinction predicts when mPFC is engaged from the first trial vs. only after remote consolidation.
- **[[wiki/papers/preston-eichenbaum-hpc-pfc-2013.md]]** — source for schema-based consolidation: assimilation/accommodation framework, HC-mPFC division of labor in consolidation, one-trial schema-fast encoding (Tse et al.), conflict-resolution role of vmPFC during overlapping-association learning.
