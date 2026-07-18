---
title: "Neural Manifolds and Intrinsic Dynamics"
type: concept
tags: [neural-manifolds, intrinsic-dynamics, learning-constraints, architecture, motor-cortex]
created: 2026-06-12
updated: 2026-07-17
sources: [brain-learning-limits-transcript, memory-gate-transcript, convergence-wiring-transcript, reservoir-computing-transcript, Recurrent neural networks with transient trajectory explain working memory encoding mechanisms, How does the brain solve visual object recognition, nieh-hippocampal-geometry-2021, sun-hippocampal-osm-2025, vohryzek-2024-lr-connections, Learning by neural reassociation, Neural constraints on learning]
related: [wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/predictive-coding.md, wiki/concepts/replay.md, wiki/concepts/small-world-networks.md, wiki/concepts/working-memory.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/contextual-inference.md, wiki/concepts/arbitrary-mapping.md, wiki/concepts/two-learning-timescales.md, wiki/entities/reservoir-computing.md, wiki/papers/sadtler-neural-constraints-learning-2014.md, wiki/papers/golub-neural-reassociation-2018.md, wiki/papers/brain-learning-limits-transcript.md, wiki/papers/memory-gate-transcript.md, wiki/papers/convergence-wiring-transcript.md, wiki/papers/reservoir-computing-transcript.md, wiki/papers/trnn-liu-2025.md, wiki/papers/dicarlo-visual-object-recognition-2012.md, wiki/papers/nieh-hippocampal-geometry-2021.md, wiki/concepts/latent-states.md, wiki/entities/place-cells.md, wiki/papers/friston-kiebel-pc-2009.md, wiki/papers/sun-hippocampal-osm-2025.md, wiki/papers/vohryzek-2024-lr-connections.md, wiki/concepts/neural-field-theory.md]
---

# Neural Manifolds and Intrinsic Dynamics

**Neural activity occupies a low-dimensional manifold within the high-dimensional neural state space, shaped by physical wiring; patterns outside this manifold are not learned on the timescales tested, regardless of training or motivation.**

*Scope caveat (Sadtler et al. 2014, the primary source below).* Every manifold in this page is **estimated from recorded activity during a particular behaviour**, not read off anatomy. Sadtler's authors explicitly decline to call their intrinsic manifold M1's true dimensionality, since it "likely depends on considerations such as the behaviours the animal is performing and perhaps its level of skill." Read "determined by wiring" as a hypothesis about *why* the estimate is stable, not as something any of these studies measured. See [[wiki/empirical-tensions.md]].

---

## BCI Evidence

Experiment (Nature Neuroscience): monkeys controlled a cursor via linear projection of ~90 motor cortex neurons. Two projections of the same activity:

| Projection | What it shows |
|------------|---------------|
| Movement intention view | Left/right trajectories appear similar — behavioral symmetry |
| Separation maximizing view | Left/right completely distinct, curved differently — neural asymmetry |

Left and right movements are **not mirror images** at the neural level — entirely different patterns, different manifold regions.

Critical test: monkeys were required to **time-reverse a neural trajectory** to stay in a narrow reward corridor. With strong incentive, visual feedback, and extended training, they **consistently failed**. The manifold boundary could not be crossed.

### The primary source: within vs. outside the manifold (Sadtler et al. 2014)

Sadtler et al. 2014 ([[wiki/papers/sadtler-neural-constraints-learning-2014.md]]) is the experiment that established the manifold as a constraint on *learning* rather than a description of activity. Both perturbations are **permutations** of the same BCI decoder, applied mid-session without cue:

| Perturbation | Permutes | Requires | Learned in ~hours? |
|---|---|---|---|
| **Within-manifold** | the 10 factors | re-associating existing co-modulation patterns with new kinematics | **Yes** — and leaves aftereffects |
| **Outside-manifold** | the ~90 units | generating *new* co-modulation patterns | **No** — and leaves no aftereffects |

**What makes this evidence rather than an observation is the control set.** Five alternative explanations were equated across the two perturbation types: initial performance impairment, principal angles between intuitive and perturbed control spaces, required preferred-direction changes per unit, search-space size (monkey L), and hand movement. The perturbations were also not workspace rotations. With all five matched, IM membership is the parsimonious remaining explanation for the learnability difference.

**Dimensionality, measured:** 9.81 ± 0.31 across 88 days (per-day range 4–16) among ~90 units, by cross-validated factor-analysis model selection — the source of this page's "~10D" figure.

**The design was deliberately uncued and blinded.** Animals were given no indication which perturbation type was coming, and the order was randomized. This matters beyond methodology: it is the condition the pointer/no-pointer reconciler in [[wiki/empirical-tensions.md]] turns on.

### The constraint is tighter than the manifold: Reassociation (Golub et al. 2018)

The manifold boundary is not the binding constraint. Golub et al. 2018 ([[wiki/papers/golub-neural-reassociation-2018.md]]) perturbed the BCI mapping **within** the intrinsic manifold — permuting the columns of $B$ in $v_t = A v_{t-1} + B z_t + c$, so every activity pattern the animal needed was already reachable — and animals *still* did not produce the required novel patterns:

| Strategy | Predicts | Verdict |
|---|---|---|
| **Realignment** (optimal) — grow novel patterns aligned to the new mapping | repertoire expansion along perturbed-mapping dimensions | Refuted ($p<10^{-10}$) |
| **Rescaling** — per-dimension gain adaptation (visuomotor-gain analog) | repertoire expansion along intuitive-mapping dimensions | Refuted ($p<10^{-10}$) |
| **Subselection** — keep only each movement's still-correct patterns | movement-specific contraction | Refuted |
| **Reassociation** — same repertoire, re-bound to different intents | no repertoire change at all | **Matches** ($p=0.55$) |

Within 1–2 hours, the **overall repertoire of activity patterns is preserved**; what changes is which movement intent each pattern is associated with — and the re-binding is genuinely cross-pointer (a movement recruits patterns that previously belonged to *other* movements, which is why Subselection fails). Reassociation is suboptimal by construction and predicts the animals' **incomplete** behavioral recovery. Animals showed no more Realignment when the incentive to realign was larger, so this is a constraint, not a motivational shortfall.

**Two nested boundaries, not one:**

| Boundary | Timescale | Evidence |
|---|---|---|
| Re-bind existing patterns to new intents | hours | Golub 2018 — the routine case |
| Produce novel patterns *inside* the manifold (Realignment) | days–weeks (proposed; only a subtle hint at 1–2 h) | Golub 2018 discussion |
| Produce patterns *outside* the manifold | not learned in ~hours; **no upper bound established** | Sadtler 2014; BCI reversal failure above |

**The outer boundary is unlocated, not merely distant.** Sadtler's outside-manifold result is a *failure to learn within a session* (~600/400 perturbed trials). The frequently-repeated "outside-manifold learning takes days" is the authors' **proposal** in their discussion ("could benefit from multi-day exposure... might require the IM to expand or change orientation"), never a measurement. Their cross-session analysis does not fill the gap either: it shows the monkeys did not get better at *learning-to-learn* across days on which a **different** perturbation was used each day, which does not test repeated exposure to one outside-manifold mapping. So the honest statement of the outer wall is "not crossed in hours, unknown thereafter."

**The mechanistic reading (authors' inference, not a measurement):** repertoire preservation is more consistent with learning-related changes to M1's **inputs** than to connectivity *within* M1 — rewiring M1 internally would have changed the repertoire it can generate. The executor's weights are untouched; what is rewritten sits upstream.

---

## Hippocampal Manifold: UMAP Evidence

Complementary evidence from HC (Science 2024, figure-8 maze, ~400 neurons):

**UMAP** maps 400D population activity to a 3D manifold without position labels:

| Coloring variable | Recovered structure |
|-------------------|---------------------|
| Physical maze position | Manifold topology perfectly mirrors figure-8 layout |
| Trial number (learning progress) | Systematic drift through neural space across days |

Both spatial structure and learning progress are jointly encoded in the same low-dimensional manifold — HC geometry reflects multiple task dimensions simultaneously.

**Off-manifold SWRs:** sharp wave ripple events that do not project onto the maze-learned manifold represent other cognitive content (other memories, future planning). They are not noise — they occupy distinct HC state-space regions — but they cannot be decoded using the maze reference frame. This demonstrates that the HC manifold has meaningful structure both on and off the task-specific subspace.

**Implication:** the HC manifold is not fixed by anatomy alone — it reflects the current task's learned structure. This is qualitatively different from the hard motor cortex constraint (BCI reversal failure), suggesting that HC manifold structure may be more plastic, encoding whichever task dimensions are currently behaviorally relevant.

### OSM Manifold: Topology Changes During Learning (Sun et al. 2025)

Sun et al. 2025 ([[wiki/papers/sun-hippocampal-osm-2025.md]]) document the learning *trajectory* of the task-plastic HC manifold — not just its final state. UMAP of thousands of CA1 neurons, tracked longitudinally across days in a 2ACDC virtual-reality task, reveals a stereotyped sequence of topological stages:

| Learning stage | UMAP topology | Interpretation |
|---|---|---|
| Session 1 | Unstructured; clusters near sensory cues | Sensory-driven; no sequential structure |
| Session 2 | **Hub-and-spoke** | Spoke = cue transitions; hub = grey regions (undifferentiated) |
| Session 3 | **Ring** | Closed by teleportation period; sequential track structure learned |
| Expert | **Split-shank wedding ring** | Ring splits into two distinct strands (one per trial type); diamond = reward consumption point cloud |

The transition from ring to split-shank ring is the geometric signature of latent state orthogonalization: the two trial types occupy separate manifold strands only when their underlying task states have been decorrelated. The topology change is not just a re-labeling — it is a structural reorganization of the manifold itself.

**Design implication for reasoning models:** the manifold topology at the expert stage has a predictable relationship to the task's latent graph structure. For a two-state task, the manifold is a split ring; for an n-state task, the prediction is an n-way split. This means the manifold geometry can serve as a readout of how well the latent graph has been learned — a measurable indicator of abstract structure acquisition.

---

## HC Abstract Manifold: Joint Physical + Abstract Encoding (Nieh et al. 2021)

Nieh et al. 2021 ([[wiki/papers/nieh-hippocampal-geometry-2021.md]]) provide the clearest quantitative characterization of the task-plastic HC manifold:

| Property | Finding |
|---|---|
| **Dimensionality** | ~5.4D [4.8, 6.0] in ~450D neural state space (MIND algorithm); scales with task complexity (simpler control: ~4.2D) |
| **Nonlinearity** | PCA needs 40 PCs to match 5 MIND latent dimensions — HC manifold is intricately curved |
| **Content** | Both physical (position) and abstract (accumulated evidence) variables appear as smooth orthogonal gradients |
| **Cross-animal sharing** | ~69–75% of geometry shared after SO(5) rotation — task-specific, not animal-specific |
| **Sensory vs. neural dissociation** | Visual input manifold: luminance gradient, no evidence gradient; neural manifold: evidence gradient, less luminance |

**MIND algorithm (Low, Lewallen et al. 2018):** unlike PCA or standard UMAP, MIND constructs latent variables from *transition probabilities* between observed population states — it finds the geometry that best predicts the sequential dynamics of neural activity. This makes it particularly suited to HC data where information is carried in sequential trajectories, not point locations.

**Key implication for manifold type 2 (task-plastic):** the HC manifold does not merely remap to encode the current physical environment. It extends into abstract, non-sensory dimensions (accumulated evidence, lap number, choice history) that must be memory-integrated rather than read from the current sensory state. The ~70% cross-animal geometry sharing implies convergence on a canonical abstract representation — the manifold is plastic enough to reflect the task structure, but converges on a stable configuration once the task is learned.

---

## TRNN (Transition RNN) dPCA: Trajectory Manifolds for Working Memory

Liu et al. 2025 ([[wiki/papers/trnn-liu-2025.md]]) adds a third manifold signature — working memory trajectories:

Demixed PCA (dPCA) decomposes TRNN (Transition RNN) delay-period activity into stimulus-dependent ($X_{st}$) and time-dependent ($X_t$) components. Key findings:

| Finding | Manifold interpretation |
|---|---|
| Stimulus-dependent trajectories remain separated throughout entire delay period | WM content is encoded in a low-D submanifold where stimulus identity corresponds to distinct trajectory paths |
| Trajectory velocity does not decrease toward end of delay | Memory is maintained dynamically in trajectory path, not in approach to a fixed-point attractor |
| Decision-dependent component diverges only at test stimulus presentation | Decision manifold is orthogonal to memory manifold during delay — two independent submanifolds coexist |
| Variable-delay TRNN (Transition RNN) maintains separated trajectories at all tested durations | The trajectory manifold is robust to temporal extension; no attractor basin needed |

**Implication for manifold architecture:** this establishes three types of low-D manifold structure in neural circuits:
1. **Spatial (motor cortex, HC):** hard anatomical manifold; BCI reversal failure; UMAP of HC encodes position + learning progress
2. **Representational (HC):** task-plastic manifold; encodes current task dimensions
3. **Temporal (TRNN delay activity):** trajectory manifold; information = path, not endpoint; requires sequential dynamics (no fixed-point attractors)

The trajectory manifold type suggests that effective WM requires networks whose intrinsic dynamics create stable separable trajectories — this is a manifold-design constraint analogous to TEM's factorization constraint for structural generalization.

---

## Object Identity Manifolds: Ventral Stream Evidence

DiCarlo et al. 2012 ([[wiki/papers/dicarlo-visual-object-recognition-2012.md]]) add a fourth empirical category of neural manifold structure — object identity manifolds across the visual hierarchy:

| Visual area | Manifold state | Linear decode performance |
|---|---|---|
| Retina / V1 | Highly curved; different objects' manifolds tangled together | Near-chance with hyperplane |
| V4 | Progressive flattening and separation | Intermediate |
| IT | Flat, separated object identity manifolds | ~300 neurons linearly decoded → near-ceiling human generalization across position, scale, context |

The critical metric is **hyperplane separability**: can a linear classifier separate one object's manifold from all others? At IT, yes. This gives a quantitative criterion for what each hierarchical level must achieve — unlike the motor cortex constraint (binary reachability) or the HC manifold (task-plastic, multi-variable encoding), the IT manifold has a graded measurable improvement across levels.

Key distinction from other manifold types:
- **Motor cortex:** hard anatomical constraint; BCI reversal failure proves unreachable patterns exist
- **HC task manifold:** plastic; reshapes to encode whichever task dimensions are behaviorally relevant
- **TRNN trajectory manifold:** temporal; information = path, not endpoint
- **IT object identity manifold:** hierarchically constructed; each level improves separation via NLN + temporal contiguity learning; the manifold geometry is shaped by the learning history (saccade statistics), not just anatomy

---

## Intrinsic Dynamics Defined

Physical connectivity (synaptic weights, biophysics, E/I balance) defines a vector field over neural state space. Activity flows along low-dimensional "channels" — the intrinsic manifold:

- **Inside manifold:** patterns reachable by following the vector field — learnable
- **Outside manifold:** require activity to flow against intrinsic dynamics — permanently unreachable

Plasticity reshapes the manifold (learning = landscape change), but the reshaping is itself constrained by the existing landscape.

**Generative account of temporal manifolds (Friston & Kiebel 2009; [[wiki/papers/friston-kiebel-pc-2009.md]]):** hierarchical PC (Predictive Coding) formalizes how manifold shape is controlled top-down. In the attractor-based model, the higher-level PC (Predictive Coding) state provides control parameters that parametrically reshape the lower-level attractor manifold (structural priors), while intrinsic connections maintain the temporal flow within the current manifold (dynamical priors). This gives a mechanistic bridge between the two-population PC (Predictive Coding) architecture and the temporal trajectory manifolds documented empirically in TRNN (Transition RNN) dPCA: the manifold's *shape* is top-down; its *dynamics* are intrinsic. Removing structural priors collapses categorical identity; removing dynamical priors collapses sequential structure. Both must be intact for the trajectory manifold to carry decodable content.

**Behavioral flexibility ≠ neural flexibility.** The same behavior appears achievable from multiple projections, but the underlying manifold is rigid; apparent freedom is an artifact of the viewing angle.

---

## Dimensionality

With N neurons, the state space is ℝ^N. The intrinsic manifold is typically much lower-dimensional (motor cortex: effectively ~10–20D despite ~90 neurons recorded). Two 2D projections of the same 90D activity can show opposite conclusions about flexibility — the manifold structure is only fully visible in the high-dimensional representation.

---

## Implication for Reasoning Models

This is a **feasibility argument, not an efficiency argument.** If a target computation requires activity patterns outside the model's manifold, training cannot reach it — no gradient steps will produce reliable generalization.

| Architecture | Manifold structure | Abstract relational generalization |
|---|---|---|
| Standard transformer (monolithic weights) | Structure and content entangled | Outside manifold — unreachable |
| TEM (factorized g/x) | Structural code in separable submanifold | Inside manifold — reachable by construction |

TEM's factorized split does not merely make structural generalization *easier*: it places the target computation inside the model's reachable manifold. Without factorization, the target may be structurally unreachable regardless of training.

---

## CT Model Expressivity: Trajectory Length as a Temporal Manifold Measure

Hasani et al. 2021 ([[wiki/papers/ltc-hasani-2021.md]]) introduce **trajectory length** — arc length of the hidden-activation path in PCA latent space, measured against a circular input `{sin(t), cos(t)}` for `t ∈ [0, 2π]` — as a rigorous, weight-agnostic measure of how much of the temporal manifold a CT model can sweep:

| Model | Typical trajectory length | Growth rate with width |
|---|---|---|
| Neural ODE | ~10² | Exponential (then saturates) |
| CT-RNN | ~10²–10³ | Slower exponential |
| **LTC** | **~10⁴** | Linear (Theorem 5); faster-than-linear with σ²_w |

LTCs trace orders-of-magnitude more complex paths through their temporal trajectory space than CT-RNNs or Neural ODEs, across activation functions, widths, depths, and ODE solvers. This is not just a quantitative difference: it means LTCs can represent temporal patterns that CT-RNNs cannot express regardless of weight tuning, analogous to how the motor cortex BCI reversal failure shows patterns outside the anatomical manifold are unreachable regardless of training.

**Connection to the TRNN (Transition RNN) trajectory manifold:** dPCA on TRNN (Transition RNN) delay-period activity (Liu et al. 2025) shows a low-D *task-structured* trajectory manifold — stimulus-separated paths with orthogonal decision submanifolds. Trajectory length (LTC) and dPCA trajectory structure (TRNN) are complementary: length measures *how much* manifold a model sweeps; dPCA structure reveals *how organized* the sweep is. A reasoning model needs both — expressive enough to separate complex patterns, structured enough to decode them linearly.

This extends the manifold taxonomy to five types (see also type 6 below):
1. **Spatial (motor cortex, HC):** hard anatomical constraint
2. **Task-plastic (HC):** reshapes to encode current behavioral dimensions
3. **Temporal WM (TRNN dPCA):** trajectory path encodes identity; constant velocity; orthogonal decision submanifold
4. **Hierarchical perceptual (IT):** each stage improves hyperplane separability
5. **Expressive CT (LTC trajectory length):** how much of temporal manifold space a CT model can sweep; determines which temporal patterns are representable

---

## Representational Geometry: Type 6 Manifold

Bernardi et al. 2020 ([[wiki/papers/geometry-abstraction-bernardi-2020.md]]) identify a sixth manifold type — the **CCGP/SD configuration** of firing-rate space arrangements:

| Axis | Measure | Biological value (HPC/PFC) |
|---|---|---|
| Abstraction | CCGP (Cross-Condition Generalization Performance) (cross-condition generalization performance) | High for 2–3 variables (context, value, action) |
| Flexibility | SD (Shattering Dimensionality) (shattering dimensionality) | Near-maximal |
| Geometry | PS (parallelism score) | High for abstract variables |

This differs from types 1–5 in that it characterizes not *where* activity lives in neural state space but the *coding-direction structure* across experimental conditions. A representation lies on the CCGP (Cross-Condition Generalization Performance) manifold when its coding directions for key variables are parallel across condition subsets — placing zero-shot generalization in the reachable set for a downstream linear readout without sacrificing the SD (Shattering Dimensionality) needed for flexible responses.

The full manifold taxonomy is now eight types:
1. **Spatial:** hard anatomical constraint (BCI reversal failure)
2. **Task-plastic:** reshapes to encode current behavioral dimensions (HC UMAP)
3. **Temporal WM:** trajectory path encodes identity (TRNN dPCA)
4. **Hierarchical perceptual:** each stage improves hyperplane separability (IT)
5. **Expressive CT:** how much of temporal manifold a CT model sweeps (LTC trajectory length)
6. **Representational geometry:** CCGP (Cross-Condition Generalization Performance)/SD configuration; coding-direction parallelism for abstract variables (HPC/PFC)
7. **Structural-functional (connectome):** leading eigenvectors of the anatomy graph span most of brain dynamics; task and spontaneous activity share the same ~20-dimensional subspace
8. **Structured flows (SFM):** connectome-induced symmetry breaking produces organized low-D flows on a manifold; serves as both the object of forward simulation and the target of causal inference

### Type 7: Structural-Functional Manifold (Vohryzek et al. 2024)

Brain activity decomposes as $F(x,t) = \sum_k a_k(t)\psi_k(x)$ where $\psi_k$ are Laplacian eigenvectors of the EDR+LR anatomy graph. Key properties:

| Property | Finding |
|---|---|
| **Dimensionality** | ~20 modes reconstruct bulk of dynamics; ~200 modes plateau |
| **Shared basis** | Spontaneous and task-evoked dynamics lie in the *same* low-D subspace |
| **Topology dependence** | EDR+LR modes outperform geometry-only modes for LR FC ($p < 10^{-4}$) |
| **Identity specificity** | Shuffling LR connection locations eliminates the advantage |

Contrast with type 1 (hard anatomical manifold): the structural-functional manifold is not a constraint on which patterns are *reachable* but which patterns the anatomy *prefers* — the subspace of highest spontaneous and task-evoked activity. Not a hard barrier but a soft structural prior on the dynamic repertoire.

**ML implication:** Initializing connectivity to match a domain's EDR+LR structure should "pre-load" the low-D functional manifold, providing a geometry-aware basis without needing to discover it purely from data.

---

### Type 8: Structured Flows on Manifolds (SFM; Jirsa & Sheheitli)

When the connectome breaks the symmetry of an otherwise uniform neural field, the resulting heterogeneous coupling produces **organized, low-dimensional flows** on the state-space manifold rather than isotropic diffusion. Key properties:

| Property | Detail |
|---|---|
| **Origin** | Symmetry breaking via heterogeneous long-range connectivity (the connectome); uniform coupling → no SFM |
| **Content** | Can represent multistable network states, limit cycles, traveling waves, or any low-D attractor |
| **Dual role** | Forward simulation: mechanistic account of spatiotemporal pattern formation; Inverse: the mathematical object sampled during causal inference from brain imaging |
| **Sensitivity to SC** | As structural connectivity changes (neurodevelopment → neurodegeneration), SFM deforms — disease manifests as SFM distortion |
| **Dimensionality** | Low-D by construction; adiabatic elimination eliminates fast variables near instabilities, leaving slow order parameters as the SFM axes |

The SFM is conceptually distinct from type 7 (structural-functional manifold): type 7 describes which subspace brain activity occupies (a static structural prior); SFM describes the *organized flow* within that subspace (a dynamical property). Both are shaped by the connectome, but type 7 is about the basis, SFM is about the vector field on that basis.

**Connection to criticality:** SFM is maximally structured near the critical working point — near bifurcation, slow modes dominate and the effective dimensionality of the flow collapses to its minimum, producing the most organized SFM. Far from criticality (deep in attractor or fully chaotic), flows lose structure.

**ML design implication:** An architecture that builds SFMs is not just doing dimensionality reduction — it is building a dynamical object whose structure encodes the causal graph of the domain. Inference in such a system means inverting the SFM to recover hidden causal parameters, not fitting a static function.

---

## Open Problems

- **Manifold modification by learning:** plasticity changes the landscape — can it make previously unreachable patterns reachable, or is reshaping itself bounded by a meta-manifold? **Sharpened by Golub 2018:** the question is now two questions, because the manifold is not the operative limit on the hours timescale — the *repertoire within it* is. Reaching a novel inside-manifold pattern and reaching an outside-manifold one are both slow, and no account says whether they are slow for the same reason.
- **What sets the repertoire, if not the manifold?** Golub's animals declined to produce patterns that were reachable, useful, and incentivized. Something narrower than the intrinsic manifold defines what M1 will actually emit — a distribution over it, not a support constraint. Nothing in the wiki's manifold taxonomy (types 1–8) names this object; all eight characterize *where activity can live*, none *which of the reachable points get used*.
- **Is the "hard anatomical" manifold actually anatomical?** The type-1/type-2 contrast this page draws (rigid motor manifold vs. task-plastic HC manifold) may be partly an artifact of measurement rather than a fact about the two regions. Sadtler's IM is estimated per-day, from one calibration behaviour, with a linear 10-D model chosen by fiat — and its authors explicitly say the dimensionality depends on what the animal is doing and how skilled it is. Nothing in the BCI literature measures a manifold *across* behaviours in the same population, which is what "determined by wiring" predicts should be invariant. The rigid/plastic contrast is currently confounded with a paradigm difference (one task, hours, motor vs. many task states, days, HC). See [[wiki/empirical-tensions.md]].
- **What controls manifold dimensionality?** E/I balance, recurrent connectivity, and modulatory inputs all affect effective dimensionality — unclear how to engineer this.
- **Generalization beyond motor cortex:** motor cortex constraints are hard (BCI reversal failure). HC manifold is task-plastic but converges on a canonical geometry (~70% cross-animal sharing, Nieh 2021) — neither fully hard nor fully arbitrary. Whether certain abstract patterns are structurally unreachable in HC (analogous to BCI reversal patterns in motor cortex) remains untested.

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — intrinsic dynamics sharpens the "5 minimum ingredients" from efficiency arguments to feasibility arguments: each ingredient is necessary not because it speeds up learning but because without it the target generalization is outside the model's reachable manifold.
- **[[wiki/concepts/factorized-representations.md]]** — the factorized g/x split is a manifold-design choice: it carves representational space so structural codes occupy a separable submanifold, placing zero-shot generalization inside the reachable manifold by construction.
- **[[wiki/concepts/predictive-coding.md]]** — PC's energy landscape over neural state space defines the intrinsic manifold: energy minima are the attractors that correspond to inside-manifold patterns; the two-population architecture shapes which activity patterns are stable and reachable.
- **[[wiki/papers/brain-learning-limits-transcript.md]]** — source: BCI reversal task demonstrates hard manifold constraints; two-projection analysis reveals hidden neural structure.
- **[[wiki/papers/sadtler-neural-constraints-learning-2014.md]]** — the primary source for the within/outside-manifold learnability contrast, the ≈10-D estimate, and the five matched controls that make IM membership the parsimonious explanation; also the source of this page's task-dependence caveat, since its authors decline to read the estimated IM as M1's true dimensionality.
- **[[wiki/papers/golub-neural-reassociation-2018.md]]** — source for the Reassociation result: within-manifold perturbations show the repertoire, not the manifold, is the operative constraint on the hours timescale; supplies the refutations of Realignment/Rescaling/Subselection and the inputs-not-connectivity inference.
- **[[wiki/concepts/contextual-inference.md]]** — the manifold is the hard boundary on contextual inference (re-weighting a repertoire stays inside it; inventing an operator leaves it), and Reassociation is what COIN's *apparent learning* looks like at the population level: behaviour changes with the repertoire held fixed.
- **[[wiki/concepts/arbitrary-mapping.md]]** — the ~3-trials/cue binding rate applies to rebinding within an existing repertoire; the intrinsic-manifold constraint is the same boundary from the other side. The two numbers do not agree (see [[wiki/empirical-tensions.md]]).
- **[[wiki/papers/memory-gate-transcript.md]]** — UMAP of ~400 HC neurons provides empirical HC manifold evidence: low-D structure encodes both position and learning progress; off-manifold SWRs correspond to other cognitive content.
- **[[wiki/concepts/replay.md]]** — UMAP manifold is the reference frame for decoding SWR (Sharp Wave Ripple) replay content; the two-stage SWR (Sharp Wave Ripple) architecture (awake bookmark → sleep consolidate) operates within the HC manifold structure revealed here.
- **[[wiki/concepts/small-world-networks.md]]** — physical wiring topology (clustering + path length) directly determines the intrinsic manifold: small-world architecture's finite wiring budget is the hard constraint that makes manifold boundaries structurally fixed; wiring cost minimization and manifold boundary hardness are two descriptions of the same phenomenon.
- **[[wiki/papers/convergence-wiring-transcript.md]]** — source for wiring cost as the evolutionary constraint shaping brain network topology.
- **[[wiki/entities/reservoir-computing.md]]** — echo-state property (ρ < 1) is the dynamical-systems statement of the manifold stability condition: inputs leave traces inside the computable manifold; chaos (ρ ≥ 1) takes dynamics outside it; reservoir computing frames the manifold constraint as a spectral radius condition on the weight matrix.
- **[[wiki/papers/reservoir-computing-transcript.md]]** — source for echo-state property as stability condition and the Fourier analogy for random temporal bases.
- **[[wiki/concepts/working-memory.md]]** — transient trajectory is a third type of manifold structure (temporal trajectory manifold) alongside the spatial and representational manifolds documented here; TRNN (Transition RNN) dPCA shows stimulus-separated trajectory paths as the WM manifold signature.
- **[[wiki/papers/trnn-liu-2025.md]]** — source for dPCA trajectory manifold analysis; shows decision-manifold orthogonality to memory-manifold during delay; velocity constancy as evidence against fixed-point attractors.
- **[[wiki/concepts/hierarchical-representations.md]]** — the IT object identity manifold is shaped by a hierarchy of CLSU sub-networks; hierarchical representations are the construction mechanism for the fourth manifold type added here; each level produces a measurably better-separated manifold geometry.
- **[[wiki/papers/dicarlo-visual-object-recognition-2012.md]]** — source for object identity manifolds; hyperplane separability as the per-level criterion; four-level ventral stream manifold evidence; temporal contiguity learning as the mechanism that shapes manifold geometry from saccade statistics.
- **[[wiki/entities/ltc-model.md]]** — trajectory length is the expressivity measure for CT temporal manifolds; LTCs demonstrate that liquid τ allows sweeping orders of magnitude more of the temporal manifold than CT-RNNs or Neural ODEs; extends the manifold taxonomy to a fifth type (expressive CT manifold).
- **[[wiki/papers/ltc-hasani-2021.md]]** — source for trajectory length bounds (Theorems 4 & 5) and empirical trajectory length comparisons across activations, widths, and depths.
- **[[wiki/concepts/representational-geometry.md]]** — defines the sixth manifold type (CCGP/SD configuration); coding-direction parallelism for abstract variables is the geometric property that determines whether zero-shot generalization is in the reachable set for a downstream linear readout.
- **[[wiki/papers/geometry-abstraction-bernardi-2020.md]]** — source for the CCGP (Cross-Condition Generalization Performance)/SD coexistence finding in HPC, DLPFC, and ACC (Anterior Cingulate Cortex); introduces the representational geometry framework and its correlation with behavioral accuracy.
- **[[wiki/papers/nieh-hippocampal-geometry-2021.md]]** — source for quantitative characterization of the task-plastic HC manifold: MIND algorithm, ~5.4D dimensionality, gradient organization of abstract variables, and ~70% cross-animal geometry sharing.
- **[[wiki/papers/sun-hippocampal-osm-2025.md]]** — source for OSM manifold topology evolution: unstructured → hub-and-spoke → ring → split-shank ring; the split-shank ring is the geometric signature of latent state orthogonalization; topology change is the manifold-level observable for abstract structure acquisition.
- **[[wiki/concepts/latent-states.md]]** — the task-plastic HC manifold is the geometric substrate within which latent-state firing fields (evidence cells, splitter cells, lap cells) are organized; manifold dimensionality ≈ number of jointly tracked task variables.
- **[[wiki/entities/place-cells.md]]** — place cells (and their latent-state variants) are the individual units that tile the manifold surface; the ~1.7 2D firing fields per evidence cell make the joint encoding concrete.
- **[[wiki/papers/friston-kiebel-pc-2009.md]]** — provides the generative account of temporal trajectory manifolds: higher-level PC (Predictive Coding) attractor state parametrically reshapes the lower-level attractor manifold (structural priors), while intrinsic connections maintain temporal flow within it (dynamical priors); the manifold's shape is top-down, its dynamics are intrinsic.
- **[[wiki/papers/vohryzek-2024-lr-connections.md]]** — source for type 7 (structural-functional manifold): ~20 EDR+LR harmonic modes span the bulk of spontaneous and task-evoked brain activity, with EDR+LR outperforming geometry modes for long-range functional connectivity.
- **[[wiki/concepts/neural-field-theory.md]]** — the harmonic modes (Laplacian eigenvectors) used in the structural-functional manifold are the discrete graph analog of the neural field PDE eigenmodes; the EDR+LR manifold and the LBO manifold are related by the Belkin-Niyogi convergence theorem; the NMM taxonomy (A1–A5) and bistability/separatrix formalism underlie the node dynamics that generate SFM structure.
- **[[wiki/concepts/criticality.md]]** — SFM is maximally organized near the critical working point: near-bifurcation adiabatic elimination produces the slowest, lowest-D flows; fluidity (FCD variance) is the operational proxy for when the SFM reaches its most structured state; criticality is the necessary condition for SFM to carry stable, decodable causal information.
