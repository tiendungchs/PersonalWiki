---
title: "Hierarchical Representations"
type: concept
tags: [hierarchical-representations, feature-abstraction, manifold-untangling, ventral-stream, deep-learning, inductive-biases, brain-set]
created: 2026-06-20
updated: 2026-06-27
sources: [How does the brain solve visual object recognition, A deep learning framework for neuroscience, A Path Towards Autonomous Machine Intelligence, Vision-Language-Action Models for Robotics A Review Towards Real-World Applications, HiT-JEPA A Hierarchical Self-supervised Trajectory Embedding Framework for Similarity Computation, DINOv2 Learning Robust Visual Features without Supervision]
related: [wiki/concepts/neural-manifolds.md, wiki/concepts/factorized-representations.md, wiki/concepts/structural-generalization.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/binding-problem.md, wiki/concepts/analogical-reasoning.md, wiki/concepts/credit-assignment.md, wiki/concepts/canonical-microcircuit.md, wiki/entities/htm-thousand-brains.md, wiki/entities/tem-model.md, wiki/papers/dicarlo-visual-object-recognition-2012.md, wiki/papers/richards-lillicrap-dl-framework-2019.md, wiki/entities/jepa-model.md, wiki/concepts/world-models.md, wiki/papers/vla-survey-kawaharazuka-2025.md, wiki/papers/hit-jepa-li-2025.md, wiki/papers/dinov2-oquab-2023.md, wiki/entities/ms-ssm-model.md, wiki/entities/mamba-model.md, wiki/concepts/connectivity-gradients.md, wiki/entities/default-mode-network.md, wiki/papers/satpute-2026-dmn-generative-model.md, wiki/papers/spatial-learning-pfc-martinet-2011.md, wiki/entities/prefrontal-cortex.md]
---

# Hierarchical Representations

**Multi-level feature abstraction in which each processing stage applies nonlinear transformations to produce representations with progressively greater invariance to task-irrelevant variation and greater explicit availability of task-relevant structure.**

---

## Manifold Untangling: What Each Level Must Do

Object identity manifolds: for object k, M_k = {v(T(I_k)) : T ∈ identity-preserving transformations} where v(·) is the population response vector. Invariant recognition requires a hyperplane separating M_k from all M_{j≠k}.

| Level | Manifold state | Readout |
|---|---|---|
| Retina / LGN | Highly curved; M_k tangled with M_{j≠k} | Nonlinear classifier needed; fails with any linear scheme |
| V1 | ~30× dimensionality expansion; slightly less tangled | Marginally better than pixel-based baseline |
| V4 | Increasing flatness and separation | Intermediate decoding quality |
| IT (primate) | Flat, separated manifolds | Simple linear classifier from ~300 neurons → near-ceiling human generalization |
| Deep CNN (trained) | Same progression, engineered | Quantitatively approaches IT-level manifold geometry (Yamins & DiCarlo 2016) |

---

## Canonical Mechanism at Each Level: Cortically Local Subspace Untangling (CLSU)

Cortically local subspace untangling (DiCarlo et al. 2012) — three genetically encoded mechanisms proposed for each ~40K-neuron cortical sub-population:

1. **NLN non-linearities + divisive normalization** — AND-like conjunctions build selectivity; OR-like (MAX) pooling builds tolerance; normalization provides partial untangling even with random weights.
2. **Natural image statistics tuning** — concentrate response range on the input distribution; avoid encoding rarely encountered patterns.
3. **Unsupervised temporal contiguity learning** — same object produces temporally proximate retinal images (via saccades); learning similar responses for temporally contiguous stimuli factorizes identity from position/scale/pose without labels.

The same motif is applied at every cortical locus, tiled laterally (visual field coverage) and stacked vertically (progressive abstraction). No global coordinator is required; each sub-population only needs to improve local untangling.

---

## Evidence / Instantiations

| System | Levels | Invariances built | Mechanism |
|---|---|---|---|
| Primate ventral stream | V1→V2→V4→IT (~4 stages) | Position, scale, pose, illumination, clutter | NLN cascade + temporal contiguity (saccades) |
| Deep CNNs | 5–150+ layers | ImageNet recognition; near-IT representational geometry | Supervised gradient descent; functionally approximates CLSU |
| HTM (Hierarchical Temporal Memory) cortical column | L6→L4→L2-3 (within column) + cross-column hierarchy | Sensorimotor prediction across reference frames | Predictive coding within each column; same motif replicated in ~150K columns |
| TEM (g/x factorization) | Single global factorization level | Environment-invariant structural code | Explicit factorization at g/x split rather than staged local processing |
| **H-JEPA (LeCun 2022)** | 2–K stacked prediction levels (K = number of timescales) | Long-term predictability at each level's timescale; shorter-term predictions use richer detail | Non-contrastive SSL (VICReg); each level's encoder discards details unpredictable at its timescale; higher levels take lower-level representations as input |
| **Hierarchical VLA (RT-H, π₀.₅, GR00T N1)** | 2 levels: symbolic (language-motion tokens / FAST tokens) + continuous (flow matching / diffusion) | High-level: discrete task-decomposition invariant to execution variation; low-level: precise motor commands | Single network switched by input prompt; trained end-to-end; empirically superior on long-horizon tasks |
| **HiT-JEPA (Li et al. 2025)** | 3 levels: point → segment (n/2, 2d) → route (n/4, 4d) via Conv1D + MaxPool1D | Cross-domain transfer: dense GPS → sparse check-in sequences → maritime trajectories zero-shot | Top-down attention spotlight: high-level A^(l) upsampled via ConvTranspose1D and injected into A^(l-1); embedding concatenation causes collapse — attention space is the correct cross-level channel |
| **DINOv2 (Oquab et al. 2023)** | 2 levels: CLS (Complementary Learning Systems) token (global image semantics) + patch tokens (local spatial semantics) | Emergent foreground/background separation (first PCA component) and semantic object-part correspondence across pose, style, and species — without any spatial supervision | EMA (Exponential Moving Average) teacher-student + DINO (image-level cross-entropy) + iBOT (patch-level masked image modeling); patch-level objective forces context-predictive spatial representations |
| **HMN (Zhao et al. 2022)** | 2 levels: ANN backbone (task context, continuous) → SNN branch (task execution, spiking) | High-level: task similarity invariant to low-level execution variation; low-level: specific task classification | ANN generates per-neuron threshold modulation vectors V_th via learnable HUs; HUs are the cross-level interface trained to align V_th cosine similarity with task similarity score |
| **MS-SSM (Karami et al. 2025)** | S+2 levels: original signal + SWT detail streams (s=1…S) + approximation a^S; independent SSM per level | Long-range dependency and hierarchical structure in sequences; 2× Mamba on ListOps hierarchical reasoning | Scale-dependent SSM initialization: coarser scales → Ā eigenvalues closer to 1 → longer memory; fine scales → shorter memory; input-dependent scale mixer dynamically fuses cross-level outputs |
| **Connectivity gradients (human cortex)** | Continuous eigendecomposition axis from unimodal sensory/motor → transmodal association (DMN); tertiary axis (G3) separates DMN from Multi-Demand Network | G1 validated across genetics, transcriptomics, and primate evolution; G3 predicts WM balance | Diffusion embedding of pairwise FC similarity matrix; no gradient coordinator required — emerges from pairwise connectivity structure alone |
| **PFC multilevel topological maps (Martinet et al. 2011)** | 2 levels: α columns (fine spatial location nodes, one per place) → β columns (corridor-level abstraction via proprioceptive gating + recurrent dynamics) | Level 2 (β) encodes structural features (alleys, corridors); planning with β layer scales to 4× larger environments vs. α-only; validated against rodent PFC electrophysiology | Recurrent collateral plasticity within the second column population; no additional layers — hierarchy emerges from a single recurrent population receiving proprioceptive gating signal |

---

## Abstraction as Dimensionality Reduction

*Source: Satpute 2026, building on Friston's hierarchical PC framework*

Higher cortical areas produce more abstract representations not by adding capacity but by *compressing*:

| Property | Low hierarchy (primary sensory) | High hierarchy (DMN apex) |
|---|---|---|
| Neuron count | High | Low |
| Receptive field breadth | Narrow (local features) | Broad (many input regions) |
| Transmission speed | Fast (high myelination) | Slow (hypomyelination) |
| Temporal integration window | Short (ms) | Long (seconds–minutes) |
| Representation dimensionality | High (detailed, high-fidelity) | Low (compressed, abstract) |
| Role in PC | Prediction errors (bottom-up) | Priors (top-down) |

When many lower-level regions converge onto neurons with broader receptive fields and longer integration windows, outputs are **more integrated and lower in dimensionality than their inputs**. The compressed representation is the higher-level prior that guides reconstruction of sensory input — abstraction is not a separate classification step but an intrinsic property of this convergence geometry.

**Design implication:** in a brain-inspired reasoning model, the number of units per level should *decrease* toward the apex, not stay constant; the temporal integration window should *increase*; and the output should serve as a prior for the level below, not just a feature for the level above.

---

## Reasoning-Model Implications

1. **Hierarchy is necessary, not sufficient.** The ventral stream produces position/scale/pose invariance — perceptual invariance — but not relational or causal invariance. Abstract reasoning requires a further level of hierarchy organized around *relational structure*, not object identity; the loss objective and the "transformations" to be made invariant to are different.
2. **Local unsupervised learning may suffice.** Temporal contiguity cues bootstrap tolerance without supervision. An analogous unsupervised signal for relational invariance might be *temporal contiguity of relational structure* — if the same structural relationship holds across different surface realizations presented in sequence, a hierarchical system could learn to respond similarly.
3. **The abstraction target determines the architecture.** A vision hierarchy organized around object identity cannot automatically produce relational invariance. The CLSU insight is that the meta job description ("what should be untangled locally?") must match the target invariance; for abstract reasoning, the meta job description needs to be "untangle relational structure from surface content."
4. **Feedforward hierarchy ≠ reasoning.** Core recognition achieves 150 ms performance without top-down feedback; this is precisely the pattern recognition regime. Quantitatively: even V1, the simplest cortical stage, has only ~40% of its explainable response variance captured by feedforward models under natural viewing (Carandini et al. 2005) — the missing ~60% is contextual modulation and temporal adaptation, both requiring recurrent or top-down processing. Abstract reasoning requires reentrant processing for hypothesis testing — hierarchy is the substrate, but the computational mode differs.

---

## Inductive Biases: Why Hierarchy Works

The No Free Lunch theorem (Wolpert & Macready 1997) proves that no learning algorithm outperforms random search across all possible task distributions — success requires choosing the right task family and embedding structural priors matched to it.

**Key inductive biases for the AI Set / human Brain Set:**

| Bias | What it assumes | How embedded | Biological analog |
|---|---|---|---|
| **Hierarchy** | Complex patterns compose simpler ones | Stacked processing stages | Neocortical laminar organization; V1→V4→IT ventral stream |
| **Translation invariance** | Features have the same meaning regardless of position | Convolution (shared weights) | Receptive field tiling in V1 |
| **Object permanence** | Objects persist spatiotemporally | Temporal contiguity learning | Slow feature analysis; HC place cell persistence |
| **Focused attention** | Some inputs are more relevant than others | Attention mechanisms | Cortical gain modulation; FEP (Free Energy Principle) precision weighting |
| **Compositional structure** | Novel wholes are built from known parts | Recursive binding operators | Prefrontal systematic combinatorics; ARC Core Knowledge priors |

**Evolution as the inductive-bias installer.** The brain's inductive biases were installed over evolutionary timescales by selection pressure from the "Brain Set" — the task distribution that mattered for survival. This is why hierarchy for vision is so deep-wired: 3D object recognition has been in the mammalian Brain Set for hundreds of millions of years. Abstract reasoning / relational structure is much more recent — shallower evolutionary pressure, weaker pre-wired inductive bias, hence harder to replicate in ANNs without explicit architectural choices.

**Emergent phenomena as validation.** When the right architecture + objective is chosen, biologically realistic representations emerge without hand-coding:
- Grid cells from navigation objectives (Banino et al. 2018)
- V4-like shape tuning from ImageNet classification (Pospisil et al. 2018)
- Temporal receptive fields from predictive objectives (Singer et al. 2018)
- Model-based reasoning from meta-RL (Wang et al. 2018)

This confirms the reverse-engineering methodology: specify objective + architecture → observe whether brain-like representations emerge → iterate if not.

**The brain-score criterion.** ANNs can be evaluated not just on task performance but on how well their internal representations match those of biological neural circuits (RSA, linear regression to neural recordings). An architecture that solves ARC-AGI but has representations orthogonal to HC/PFC recordings is less likely to share the brain's inductive biases — and may fail on the transfer tasks that the Brain Set includes but ARC-AGI doesn't.

---

## Open Problems

1. What determines the number of levels required? Visual hierarchy converges in 4–5 stages; relational/abstract hierarchy depth is unknown.
2. Does the same CLSU mechanism generalize to relational abstraction, or is a fundamentally different learning rule needed?
3. Can a single hierarchical system produce both perceptual invariance and relational invariance, or must these be separate hierarchies?
4. How are local per-level untangling solutions composed globally without a coordinator? (Lateral connections + normalization suffice for vision; unclear for abstract domains.)

---

## Connections

- **[[wiki/concepts/neural-manifolds.md]]** — object identity manifolds are the geometric objects that hierarchical processing untangles; the manifold perspective provides the formal criterion (hyperplane separability) for what each level must achieve; this paper adds a fourth empirical category (object identity manifold) to the three manifold types documented in neural-manifolds.md.
- **[[wiki/concepts/factorized-representations.md]]** — TEM's g/x factorization is a special case of hierarchical abstraction where the structural dimension is explicitly separated globally; CLSU generalizes this to staged, local factorization of identity from identity-preserving transformations at each cortical level.
- **[[wiki/concepts/structural-generalization.md]]** — hierarchical representations are necessary but not sufficient for structural generalization; structural generalization additionally requires that the relational code be explicitly separated from content, which a generic perceptual hierarchy does not guarantee.
- **[[wiki/concepts/abstract-reasoning.md]]** — core recognition via feedforward hierarchy is the paradigm case of pattern recognition; abstract reasoning requires top-down causal model-building that hierarchical feedforward processing alone cannot provide; the feedforward/feedback distinction maps directly onto the pattern-recognition/model-building distinction.
- **[[wiki/concepts/binding-problem.md]]** — temporal contiguity learning builds separable IT tuning for identity and spatial variables simultaneously, avoiding the need for a downstream binding step; hierarchy solves the binding problem for transformation variables by factorizing them during learning.
- **[[wiki/entities/htm-thousand-brains.md]]** — HTM's ~150K cortical columns each implement the same three-layer CLSU-like hierarchy; the canonical sub-network hypothesis from DiCarlo et al. maps directly to Hawkins's universal cortical algorithm.
- **[[wiki/entities/tem-model.md]]** — TEM represents a single-level global factorization rather than a multi-level staged hierarchy; the relationship between CLSU (staged local) and TEM (global factorized) is an open architectural question.
- **[[wiki/papers/dicarlo-visual-object-recognition-2012.md]]** — primary source for the manifold untangling perspective, the CLSU canonical mechanism, temporal contiguity as unsupervised teacher, and feedforward sufficiency for core recognition.
- **[[wiki/concepts/analogical-reasoning.md]]** — hierarchical-representations describes the perceptual substrate (feedforward manifold untangling) whose output — factored identity representations — is the prerequisite input for relational role-filler binding; the CLSU identity factorization is what makes the role variable slot available for analogical mapping.
- **[[wiki/concepts/credit-assignment.md]]** — each level of a hierarchy requires a credit signal reaching its weights; the inductive bias of hierarchy creates a structural credit assignment challenge (errors must propagate backward through all levels), motivating the biologically plausible approximations documented there.
- **[[wiki/papers/richards-lillicrap-dl-framework-2019.md]]** — source for the inductive-bias framing, No Free Lunch motivation, Brain Set / AI Set concept, and emergent phenomena validation (grid cells, shape tuning, temporal RFs from task-optimized ANNs).
- **[[wiki/concepts/canonical-microcircuit.md]]** — the SLN% rule is the quantitative anatomical implementation of the feedforward/feedback asymmetry: high SLN% (L3→L4) = feedforward pattern-recognition mode; low SLN% (L5/6→L1/5/6) = feedback model-building mode; the canonical circuit provides the physical substrate that makes the hierarchy real rather than functional.
- **[[wiki/entities/jepa-model.md]]** — H-JEPA is the concrete world-model instantiation of multi-level hierarchical prediction: each stacked level abstracts further and predicts over a longer timescale, implementing the timescale-abstraction tradeoff that this page argues is necessary but leaves architecturally open.
- **[[wiki/papers/vla-survey-kawaharazuka-2025.md]]** — hierarchical VLA architectures (RT-H, π₀.₅, GR00T N1) are the largest-scale engineering validation of two-level symbolic+continuous hierarchy: a single network trained end-to-end shows that separating high-level discrete planning from low-level continuous motor control substantially improves long-horizon task performance, supporting the multi-level meta-graph architectural requirement.
- **[[wiki/papers/hit-jepa-li-2025.md]]** — provides the first three-level H-JEPA implementation for sequential data; key finding is that cross-level communication must operate in attention space (not embedding space), and the high-level loss (ν=0.80 for L3) must dominate for zero-shot generalization to hold.
- **[[wiki/papers/dinov2-oquab-2023.md]]** — DINOv2's two-level CLS+patch architecture is the most direct empirical demonstration that a dual-scale SSL objective produces emergent hierarchical decomposition without spatial supervision; patch-token PCA revealing object parts is the clearest existing evidence that the "correct" level of hierarchy is what the training objective makes predictable.
- **[[wiki/papers/carandini-early-visual-2005.md]]** — provides the quantitative V1 baseline (~40% explainable variance under natural viewing) that grounds the claim in point 4 above; divisive normalization (Heeger 1992) is the canonical nonlinear mechanism at the first CLSU stage.
- **[[wiki/entities/default-mode-network.md]]** — the DMN apex is the biological instantiation of the abstraction-as-dimensionality-reduction principle: fewer neurons, broader projections, slower timescales, hypomyelination relative to primary sensory cortex; the three-axis model specifies the anatomical structure that implements this compression across the DMN's internal organization.
- **[[wiki/papers/satpute-2026-dmn-generative-model.md]]** — source for the abstraction-as-dimensionality-reduction formalization and for the neuroanatomical evidence (neuron count, myelination, receptive fields, transmission speed) that grounds the hierarchy-level table in the new section above.
- **[[wiki/papers/spatial-learning-pfc-martinet-2011.md]]** — source for PFC multilevel topological maps: a second column population uses a proprioceptive turning-probability gate to encode corridor-level topology at coarser resolution, demonstrating that a two-level spatial hierarchy can emerge in a single recurrent population without architectural depth — hierarchy here is gating-induced, not layer-induced.
- **[[wiki/entities/prefrontal-cortex.md]]** — PFC multilevel topological maps are a biological instance of hierarchical spatial representations; the α→β column hierarchy maps directly onto the hierarchical grid/place representation already noted for HC/MEC, but via a different mechanism (proprioceptive gating vs. continuous path integration).
- **[[wiki/entities/hnn-framework.md]]** — HMN is a concrete two-level cross-paradigm hierarchy: ANN backbone (high-level task context abstraction, continuous) + SNN branch (task-specific execution, spiking) linked by learnable HUs; achieves meta-continual learning superior to single-paradigm baselines, validating that cross-paradigm hierarchical decomposition can outperform same-paradigm depth when the two levels have structurally different computational requirements.
- **[[wiki/entities/ms-ssm-model.md]]** — MS-SSM is the sequence-domain instantiation of multi-timescale hierarchical processing: SWT decomposes input into S+2 resolution streams with SSMs initialized to the appropriate timescale at each level; ablation confirms that the multi-scale decomposition — not selective gating — is the effective inductive bias for hierarchical reasoning, making it the direct SSM analog of the feedforward hierarchy argument on this page; Mamba's failure on ListOps (38%) vs. MS-SSM (63%) quantifies the cost of discarding explicit timescale separation.
- **[[wiki/concepts/connectivity-gradients.md]]** — G1 (unimodal→transmodal) is the biological implementation of a cortical hierarchy in continuous form; it emerges from pairwise FC structure without a global coordinator, offering evidence that a smooth hierarchical axis can self-organize from local connectivity statistics — relevant to whether the reasoning model hierarchy should be architecturally imposed or allowed to emerge from learning.
