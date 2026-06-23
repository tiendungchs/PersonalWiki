---
title: "Predictive Coding / Free Energy Principle"
type: concept
tags: [predictive-coding, free-energy-principle, generative-model, variational-inference, bayesian-brain, active-inference, precision]
created: 2026-06-12
updated: 2026-06-23
sources: [free-energy-principle-transcript, A Path Towards Autonomous Machine Intelligence, brain-learning-algorithm-transcript, bolzman-machine-transcript, Metalearning_and_Neuromodulation, The role of prefrontal cortex in cognitive control and executive function, The free-energy principle - a rough guide to the brain, Language Modeling Is Compression, Neuroscience-Inspired Artificial Intelligence, A deep learning framework for neuroscience, whittington-bogacz-pc-backprop-2017, bastos-canonical-microcircuit-2012, Theories of Error Back-Propagation in the Brain]
related: [wiki/concepts/information-theory.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/factorized-representations.md, wiki/concepts/latent-states.md, wiki/concepts/neural-manifolds.md, wiki/concepts/neuromodulation.md, wiki/concepts/cognitive-control.md, wiki/concepts/attention.md, wiki/concepts/hebbian-learning.md, wiki/concepts/credit-assignment.md, wiki/concepts/canonical-microcircuit.md, wiki/entities/equilibrium-propagation.md, wiki/entities/tem-model.md, wiki/entities/htm-thousand-brains.md, wiki/entities/boltzmann-machine.md, wiki/entities/prefrontal-cortex.md, wiki/entities/basal-ganglia.md, wiki/papers/brain-learning-algorithm-transcript.md, wiki/papers/150000-mini-brain-transcript.md, wiki/papers/boltzmann-machine-transcript.md, wiki/papers/metalearning-neuromodulation-doya-2002.md, wiki/papers/pfc-cognitive-control-friedman-2021.md, wiki/papers/friston-free-energy-2009.md, wiki/papers/language-modeling-compression-deletang-2023.md, wiki/papers/hassabis-neuroscience-ai-2017.md, wiki/entities/gwt-model.md, wiki/papers/gnw-mashour-2020.md, wiki/papers/richards-lillicrap-dl-framework-2019.md, wiki/papers/millidge-activation-relaxation-2020.md, wiki/papers/whittington-bogacz-pc-backprop-2017.md, wiki/papers/bastos-canonical-microcircuit-2012.md, wiki/concepts/temporal-coding.md, wiki/concepts/dendritic-computation.md, wiki/entities/jepa-model.md, wiki/concepts/energy-based-models.md, wiki/concepts/world-models.md, wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md]
---

# Predictive Coding / Free Energy Principle

**The brain minimizes variational free energy — a tractable upper bound on sensory surprise — by iterating a recognition model (encoder, approximate posterior) against a generative model (prior + likelihood), adjusting latent representations at inference time and connection weights during learning.**

---

## Backprop Biological Violations

Two requirements absolutely incompatible with neurophysiology:

| Violation | Backprop requires | Biology |
|-----------|-------------------|---------|
| **Discontinuous processing** | Neurons freeze forward-pass activations during backward pass — computation and learning cannot overlap | Brains process continuously; no pause between sensing and learning |
| **Non-local coordination** | Global controller switches entire network between phases; errors propagate in strict temporal sequence with cell-by-cell precision | Neurons are locally autonomous; state changes based solely on locally available information |

Predictive coding addresses both: all phases overlap; every update driven by local prediction errors only.

---

## Variational Free Energy

Given observations `o`, latent causes `z`, generative model `p(o,z) = p(o|z)·p(z)`, recognition model `q(z|o)`:

```
F = −E_q[log p(o|z)] + KL[q(z|o) ‖ p(z)]
      ↑ accuracy cost        ↑ complexity cost
  (reconstruction loss)   (KL from prior)
```

**F = −ELBO** (negative evidence lower bound). Two equivalent decompositions:

| Decomposition | Form | Interpretation |
|---|---|---|
| Accuracy + Complexity | `−E_q[log p(o|z)] + KL[q‖p(z)]` | Trade off fit vs. prior adherence |
| Surprise + Posterior gap | `−log p(o) + KL[q(z|o) ‖ p(z|o)]` | F ≥ surprise; gap = divergence from true posterior |

Second form: **F is always ≥ sensory surprise** `−log p(o)`. Minimizing F tightens this bound while avoiding the intractable true posterior `p(z|o)`.

---

## Hierarchical Algorithm

**Energy function** — total squared prediction error across all layers:
```
E = Σ_l Σ_i ε_{l,i}²     where  ε_{l,i} = x_{l,i} − Σ_k w_{lk} x_{l+1,k}
```

**Activity update** (inference — fast, settles per input):
```
dx_{l,i}/dt = −ε_{l,i} + Σ_k w_{lk} ε_{l−1,k}
```
Term 1: align with top-down prediction. Term 2: better predict the layer below. Equilibrium = energy minimum for current input.

**Weight update** (learning — slow, accumulates across inputs):
```
Δw_{lk} ∝ ε_{l,i} · x_{l+1,k}
```
Hebbian-like: prediction error × presynaptic activity. Fully local. **Weight transport resolution:** feedback and feedforward synapses follow the same update rule and converge independently without central coordination (approximate with nonlinear activations).

**Two-population architecture per layer:**

| Population | Computes | Input connections |
|------------|----------|------------------|
| Representational `x_{l,i}` | Estimate of causes at level l | Inhibited by own ε; excited by ε neurons from layer below |
| Error `ε_{l,i}` | `x_{l,i} − Σ_k w_{lk} x_{l+1,k}` | Excited by own `x_{l,i}`; inhibited by top-down predictions |

Maps to cortical anatomy: superficial layers carry prediction errors (bottom-up); deep layers carry predictions (top-down).

---

## Two-Timescale Minimization

| | Timescale | Minimized over | Neural analog |
|--|-----------|----------------|---------------|
| **Perception** | ~100 ms | Activations of `q(z|o)` | Adjust latent neuron firing for current input |
| **Learning** | Days–months | Parameters of `p(o|z)`, `p(z)` | Adjust synaptic weights |

Both minimize F; different parameters, different timescales. Maps onto TEM:

- Perception ↔ fast **M** (Hebbian binding in HC, per-environment, per-timestep)
- Learning ↔ slow **W** (backprop across environments, structural weights)

FEP provides the principled theoretical basis for the [[wiki/concepts/two-learning-timescales.md]] split.

---

## Cortical Laminar Implementation

Full mapping of PC computational variables to specific neuronal populations (Bastos et al. 2012), confirmed against quantitative intrinsic connectivity data (Haeusler & Maass 2007):

| Layer | Cell type | Computational role | Extrinsic projection |
|---|---|---|---|
| **L2/3 superficial pyramidal** | Excitatory | Prediction errors on hidden causes ε^c | **Feedforward** → L4 of next (higher) area |
| **L2/3 supragranular excitatory interneurons** | Excitatory | Expectations about hidden causes x^c | Descend to L5/6 via intrinsic connections |
| **L2/3 supragranular inhibitory interneurons** | Inhibitory | Expectations about hidden states x^h | Descend to L5/6 |
| **L4 spiny stellate (granular)** | Excitatory | Receive incoming ε^c from level below; relay to L2/3 | — (relay only) |
| **L4 inhibitory interneurons** | Inhibitory | Prediction errors on hidden states ε^h | — |
| **L5/6 deep pyramidal** | Excitatory | Conditional expectations → generate predictions | **Feedback** → L1/L5/6 of lower area |

**Feedforward = linear; feedback = nonlinear.** Prediction errors are a linear subtraction (ε = x − g(x̃)). Top-down predictions are nonlinear functions of expectations. This asymmetry maps directly to anatomy: feedforward (superficial → L4) connections are linearly driving; feedback connections require nonlinear/modulatory post-synaptic effects because prediction formation is context-sensitive.

**Feedback is net inhibitory via L1.** Feedback projections from L5/6 terminate in L1, which contains nearly 100% inhibitory cells. These cells make monosynaptic inhibitory connections onto *apical dendrites* of L2/3 pyramidal cells — the anatomical route by which top-down predictions suppress prediction errors. The apical dendrite is therefore simultaneously the credit-signal landing site (see [[wiki/concepts/dendritic-computation.md]]) and the feedback-inhibition target.

**Spectral asymmetry (derives from Bayesian filtering).** Deep prediction cells integrate error signals: ẋ ∝ ε, so their Fourier content is ω-suppressed: x̃(ω) ∝ ε̃(ω)/ω. Result:

| Layer | Dominant frequency | Functional role |
|---|---|---|
| Superficial (L2/3) | **Gamma (γ)** | Error neurons — no integration, high-frequency preserved |
| Deep (L5/6) | **Beta (β)** | Prediction neurons — Bayesian filtering suppresses high freq |

Feedforward inter-areal connections (from superficial cells) operate at gamma; feedback connections (from deep cells) operate at beta/alpha. Empirically confirmed in monkey V4→V1/V2 (Bosman et al. 2012), primate multi-laminar recordings (Buffalo et al. 2011; Maier et al. 2010). See [[wiki/concepts/temporal-coding.md]].

---

## Generative Model Components

| Component | Role | Effect on perception |
|-----------|------|---------------------|
| `p(z)` — prior | Distribution over latent causes | Strong priors override sensory evidence (hollow mask illusion: face-convex prior dominates lighting cue) |
| `p(o|z)` — likelihood | Maps causes → predicted observations | Defines what each cause should look like; the generator/decoder |
| `q(z|o)` — recognition model | Approximate posterior | Fast amortized inference: observation → cause distribution |

The prior is why context modulates perception: the same sensory input yields different percepts in city park vs. safari because `p(z)` (likelihood of encountering a tiger) differs.

---

## Relationship to Information Theory

The accuracy term `−E_q[log p(o|z)]` is **cross-entropy** between the data distribution and the generative model's predictions:

```
F = H(data, p(o|z)) + KL[q(z|o) ‖ p(z)]
```

Minimizing F = minimizing cross-entropy + regularizing toward the prior. Via arithmetic coding, minimizing the accuracy term (cross-entropy) is identical to minimizing the lossless compression rate of sensory data — FEP minimization is formally compression rate minimization. The Solomonoff predictor (optimal universal compression, Bayesian mixture over all computable programs weighted 2^(−|program|)) is the theoretical ceiling that a perfect FEP-minimizing agent would approach. See [[wiki/concepts/information-theory.md]] for the compression-prediction equivalence and ELBO derivation, and [[wiki/papers/language-modeling-compression-deletang-2023.md]] for empirical evidence and scaling-law implications.

---

## Instantiations

| System | Recognition `q` | Generator `p` | What minimizing F achieves |
|--------|-----------------|---------------|---------------------------|
| TEM | HC inference path `p_inf` | W-parameterized transitions + Hebbian M | Structural + episodic prediction accuracy |
| VAE | Encoder `q(z|x; φ)` | Decoder `p(x|z; θ)` + prior `p(z)` | Latent generative model |
| Transformer (TEM-t) | Key-query attention over `g` | Value `x` retrieval | Memory retrieval accuracy |
| Rao & Ballard 1999 | Error neurons (superficial layers, bottom-up) | Representational neurons (deep layers, top-down) | Minimize E = Σ ε²; derives local activity + weight update rules; foundational hierarchical PC formulation |
| Thousand Brains (TBT) | L4 sensory input; L6 path integrator (via L5 efference copy) | L1 top-down predictions from higher columns | Minimize column-level prediction error; distributed consensus via L2-3 lateral connections — PC without a central coordinator |
| Boltzmann Machine | Positive phase: visible units clamped to data, hidden units settle freely | Energy function over all units; Hopfield-style weights | Two-phase contrastive learning: pull down energy of data states, push up energy of hallucinated states |
| Basal ganglia / DA (Doya 2002) | Striatum critic: `V(s)` predicted from cortical state representation | Reward signal `r(t)` | TD error δ(t) = r(t) + γV(s(t)) − V(s(t−1)): this is PC's prediction error ε applied to reward; midbrain DA neurons *are* the biological ε neurons for the reward domain |
| ACC / cognitive control (Friedman & Robbins 2021) | Predicted Response Outcome model: ACC predicts outcome of responding given context | Actual outcome at multiple timescales | *Unsigned* prediction error (both unexpected omission and unexpected occurrence of any outcome); modulates reactive CC (error correction) + proactive CC (anticipatory bias before conflict). Distinct from DA: unsigned, multi-timescale, controls effort allocation not value |
| **Bilinear DCM / LTC (Friston et al. 2003; Hasani et al. 2021)** | Recognition model implicit in ODE state `x(t)` | Bilinear generative model: `dx/dt = (A + I(t)B)x + CI` | ODE semantics give inherent causal temporal ordering; DCMs model fMRI time-series as causal latent state trajectories; LTC equation is structurally equivalent (see [[wiki/entities/ltc-model.md]]); shared principle: continuous-time state-space dynamics as FEP-style generative temporal world models |
| **GNW + Bayesian inference (Mashour et al. 2020; Dehaene & Changeux 2005)** | Hub-top compressed symbolic model of current world state; broadcasts predictions via long-range GNW neurons | NMDA-mediated sustained reverberant activity: top-down predictions broadcast via NMDA recurrence; feedforward mismatch (sensory data) arrives via fast AMPA | Ignition = successful inference convergence: when feedforward (AMPA) sensory signal is strong enough, NMDA-gated self-sustaining loops lock in the inferred world state; subliminal stimuli produce only decaying (AMPA-driven) waves without NMDA ignition |
| **JEPA (LeCun 2022)** | x-encoder s_x and latent z encoding the *relationship* between x and y (not the latent state of x alone) | y-encoder s_y (abstract representation); encoder invariance discards unpredictable details | Minimize D(s_y, ŝ_y) in representation space + maximize information in s_x, s_y + minimize information in z; non-generative analog of PC's prediction objective — operates without explicit error neuron populations. **Critical difference from PC (Lett 2025):** PC infers latent state from a *single* input via iterative recurrent convergence; JEPA requires *two* inputs (x and y) to define z as their relational encoding; in single-input settings z is undefined and must be hand-crafted or dropped. |

---

## Contrastive Hebbian Learning as PC Precursor

The Boltzmann machine ([[wiki/entities/boltzmann-machine.md]]) anticipates PC's two-population architecture through its two-phase training structure:

| Boltzmann phase | PC population / operation |
|---|---|
| **Positive phase** — visible units clamped to data; hidden units settle | Error neurons driven by bottom-up sensory signal; representational neurons pulled toward data |
| **Negative phase** — entire network runs freely from random state | Representational neurons propagating top-down prediction without sensory constraint |
| `Δw ∝ ⟨x_i x_j⟩_data − ⟨x_i x_j⟩_free` | `Δw ∝ ε · x` (prediction error × presynaptic activity) |

PC resolves the Boltzmann machine's two computational bottlenecks:
1. **Equilibrium sampling removed:** the negative-phase Markov chain (requiring many stochastic steps to reach equilibrium) is replaced by local error propagation — each layer's representational neuron settles on the local prediction error, not a global equilibrium.
2. **Partition function avoided:** Z = Σ_s exp(−E(s)/T) over all 2^N states is replaced by the variational free energy F = −ELBO — a tractable local approximation. See [[wiki/concepts/information-theory.md]].

The lineage is: Boltzmann (two-phase contrastive, intractable Z) → PC (one-phase local error, tractable F) → FEP (hierarchical tractable variational inference).

The two-phase structure of contrastive learning reappears in the **temporal-error model class** (Whittington & Bogacz 2019): contrastive learning uses anti-Hebbian plasticity during the prediction phase and Hebbian plasticity once the target is provided; the **continuous update model** (Bengio et al. 2017) eliminates the discrete phase boundary by continuously nudging output neurons toward target, with weight change ∝ x_pre · (dx_post/dt) — mapping directly to asymmetric STDP. **Hippocampal theta oscillations** (Ketz et al. 2013) are the proposed biological phase coordinator for contrastive learning: feedforward inputs dominate one theta half-cycle (prediction phase, anti-Hebbian) while target-clamped feedback dominates the other (target phase, Hebbian) — enabling phase coordination via locally available oscillatory rhythm without a centralized controller.

---

## Biologically Plausible Backpropagation

Two requirements of standard backpropagation are biologically implausible:

| Objection | Backprop requires | Biology |
|---|---|---|
| **Weight symmetry** | Backward-pass weights are the exact transpose of forward-pass weights | Forward and backward synaptic connections are anatomically separate; exact transpose symmetry is not observed |
| **Non-local error signals** | Each weight update requires an error signal from units many layers downstream | Synaptic plasticity depends on locally available pre- and post-synaptic activity; neurons cannot access gradient signals from distant layers |

**Feedback alignment (Lillicrap et al. 2016):** Random fixed backward weight matrix B (not tied to forward weights W) transmits useful teaching signals. During training, W adapts so that WB ≈ WW^T — forward weights learn to align with the random backward projection. Weight symmetry need not be pre-imposed; approximate alignment is learned. Implication for biology: the brain's feedback pathways need not be precise transposes of feedforward pathways; feedforward connections can adapt to exploit whatever feedback structure exists.

**Local learning rules via energy-based networks:** Hierarchical autoencoders and continuous Hopfield networks minimize an energy E = Σ ε_l² with the same form as PC's free energy. The resulting weight update is:

```
Δw_{lk} ∝ ε_{l,i} · x_{l+1,k}
```

This is purely local (prediction error at level l × presynaptic activity from level l+1). With appropriate timing assumptions, this rule is structurally equivalent to STDP: a pre-before-post pairing reduces prediction error → Δw ∝ ε · x_pre matches the STDP potentiation window. This bridges Hebbian / STDP rules to error-gradient learning via the PC energy formalism.

**AR as a simpler alternative (Millidge et al. 2020):** Activation Relaxation (AR) achieves near-zero-bias credit assignment (converging to *exact* backprop gradients) with a single neuron type — no separate error-neuron population required. AR's update is driven by the same inter-layer error signal as PC but without the second population. This challenges PC's assumed architectural necessity: the two-population structure is not required to approximate backprop locally. AR also counterexamples the NGRAD hypothesis (which PC satisfies via spatial activity differences), showing that activity-difference encoding is not a necessary feature of biologically plausible backprop approximations. See [[wiki/papers/millidge-activation-relaxation-2020.md]].

**Design implication:** PC's local weight rule is the biologically plausible approximation to backprop for the slow-W outer loop. Implementing end-to-end training via PC is possible in principle — at comparable computational cost to backprop but using only locally available signals, making it the candidate learning algorithm for architectures where global credit assignment is architecturally impossible (e.g., modular or spike-based implementations).

**Position in the credit assignment bias–variance taxonomy (Richards et al. 2019):** PC sits at a medium-bias / medium-variance position — better bias than feedback alignment (which uses random fixed B), better variance than weight/node perturbation. It satisfies both locality constraints (no weight symmetry required; no backward-pass freeze). The Whittington & Bogacz 2017 result that PC = backprop exactly at energy minimum of a *linear* network establishes the bias floor for PC: for nonlinear networks, the approximation degrades and a finite bias appears. See [[wiki/concepts/credit-assignment.md]] for the full taxonomy.

---

## Active Inference

**Perception and action are symmetric gradient-descent moves on free-energy: perception updates the recognition density to better predict sensory data; action updates sensory data to conform to the recognition density.**

F decomposes as accuracy + complexity. Each variable controls a different term:
- **Perception** (optimizing m): reduces both accuracy and complexity — makes q(z) ≈ p(z|y), improving predictions
- **Action** (optimizing a): can only affect *accuracy* — changes sensory input y, not the model — makes sensations conform to predictions

An agent cannot evaluate surprise directly (would require knowing all hidden world states). F ≥ surprise always, so minimizing F avoids surprising encounters without solving intractable inference. Perception makes F a tighter bound on surprise; action samples only expected sensory states.

**Active inference vs. value-learning:** Replace value function V(s) with prior expectations over sensory trajectories. Desired states = strongly predicted states; action fulfills predictions rather than maximizing reward. The Parkinson's prediction: if dopamine encodes precision of priors, low DA → imprecise predictions → small action-triggering errors → bradykinesia. See [[wiki/concepts/neuromodulation.md]] DA=precision Contradiction entry.

**Architectural implication:** PFC (recognition density, goal-state predictions) + BG/motor cortex (action) jointly minimize free-energy. PFC must maintain a precise prediction of the desired state before BG action selection is warranted — a principled derivation of why goal maintenance precedes action selection in the Block 3C/3D architecture.

---

## Three-Tier Representation (Perception / Learning / Attention)

FEP specifies three classes of sufficient statistics, all minimizing F at different timescales:

| Tier | Sufficient statistics | Neural substrate | Achieves | Timescale |
|------|-----------------------|-----------------|----------|-----------|
| **States** | Expected hidden/causal states m_x | Synaptic activity (firing) | Perceptual inference — approximate posterior over current causes | ~ms |
| **Parameters** | Connection strengths m_u | Synaptic efficacy | Perceptual learning — causal regularities; Hebbian-like ε·x rule | Hours–days |
| **Precisions** | Inverse variances m_λ | Synaptic gain (neuromodulators, oscillatory synchrony) | Attention — weight prediction errors by reliability | ~100ms |

Recognition dynamics by tier: states use **first-order** ODEs (fast settling); parameters and precisions use **second-order** dynamics driven by accumulated synaptic traces (integrating gradient signals before applying updates — biologically, "tagging" synapses).

**Precisions are the gain of error-units.** High precision at level i means errors from that level dominate inference at i+1. This is attention in the FEP sense: directing representational update toward high-reliability signals. ACh (exteroceptive/posterior systems) and DA (interoceptive/motor/prior precision) are proposed as the two neuromodulatory realizations in distinct hierarchies.

**Design implication:** A reasoning model needs all three tiers: (1) fast per-input inference dynamics, (2) slow weight updates, (3) precision/gain-control tuned to signal reliability. The precision tier is what the Doya metalearning framework calls neuromodulation, but FEP specifies it as a single computation (precision optimization) across multiple neuromodulatory systems.

---

## Open Problems

- **Expected free energy / epistemic foraging:** Active inference above covers minimizing *current* F. The full FEP extends to minimizing *expected future* free energy, decomposing into epistemic (information-seeking) and pragmatic (goal-achieving) drives. Not yet covered in this wiki.
- **Hierarchical FEP:** multi-level generative models with prediction errors at every cortical layer; exact correspondence to cortical hierarchy not fully specified.
- **Weight transport with nonlinearities:** the weight symmetry argument (feedforward/feedback synapses converge independently) holds exactly only for linear networks; with nonlinear activations the updates diverge, making the resolution approximate. Degree of degradation in deep nonlinear networks is empirically open.
- **Local update vs. structural generalization:** PC's weight rule (`Δw ∝ ε · x`) extracts single-network statistical patterns — but extracting *shared abstract structure across environments* (TEM's slow W) requires cross-environment credit assignment that purely local PC updates may not achieve alone [[wiki/concepts/two-learning-timescales.md]].

---

## Connections

- **[[wiki/concepts/information-theory.md]]** — F = −ELBO; accuracy term = cross-entropy between data and generative model; complexity term = KL from prior; FEP is the Bayesian brain interpretation of the cross-entropy/KL training objective.
- **[[wiki/concepts/two-learning-timescales.md]]** — FEP decomposes naturally into two timescales (fast perceptual inference over activations, slow weight learning), providing the principled theoretical justification for TEM's slow-W/fast-M split.
- **[[wiki/concepts/factorized-representations.md]]** — TEM's factorized generative model `p(o,z) = p(o|g)·p(g)` is a specific FEP instantiation: structural code `g` is the latent cause; factorization ensures the prior `p(g)` (transition rules W) transfers across environments while the likelihood `p(o|g)` adapts via M.
- **[[wiki/concepts/latent-states.md]]** — latent causes z in FEP are exactly latent states: unobservable task-relevant variables inferred from sequences; the FEP recognition model `q(z|o_{1:t})` is the abstract description of what TEM's inference path and CSCG's clone-cell mechanism both implement.
- **[[wiki/entities/tem-model.md]]** — TEM implements FEP with factorized latents: g path-integrates the structural prior; Hebbian M is the fast perceptual inference step; W learning is the slow generative model update; TEM's three training losses decompose as FEP accuracy + complexity terms.
- **[[wiki/papers/brain-learning-algorithm-transcript.md]]** — source for the hierarchical PC algorithm: backprop biological violations, energy function derivation, activity/weight update rules, two-population architecture, weight transport resolution.
- **[[wiki/concepts/neural-manifolds.md]]** — PC's energy landscape defines the intrinsic manifold: energy minima are the stable attractors that correspond to inside-manifold patterns; the two-population architecture shapes which activity patterns are reachable equilibria.
- **[[wiki/entities/htm-thousand-brains.md]]** — TBT's L1 (top-down prediction) vs. L4 (sensory input) circuit is structurally identical to PC's representational vs. error neuron architecture; convergence from evolutionary anatomy supports that the two-population PC organization is universal across neocortex, not a special-purpose circuit.
- **[[wiki/papers/150000-mini-brain-transcript.md]]** — source for TBT's columnar prediction-error architecture and its convergence with PC.
- **[[wiki/entities/boltzmann-machine.md]]** — the contrastive Hebbian rule's positive/negative phase structure is the historical precursor to PC's two-population architecture; PC replaces Boltzmann's intractable equilibrium sampling and partition function with local error propagation and the tractable ELBO.
- **[[wiki/papers/boltzmann-machine-transcript.md]]** — source for Boltzmann distribution derivation, contrastive Hebbian learning rule, and the two-phase training structure.
- **[[wiki/concepts/neuromodulation.md]]** — DA = TD error is the RL instantiation of the prediction error principle; midbrain DA neurons play the role of ε neurons for reward prediction, connecting PC's sensory prediction-error framework to reinforcement learning via a shared mathematical structure.
- **[[wiki/papers/metalearning-neuromodulation-doya-2002.md]]** — source for the basal ganglia actor-critic model and the DA = TD error hypothesis.
- **[[wiki/concepts/cognitive-control.md]]** — ACC's Predicted Response Outcome model instantiates PC in the CC domain: unsigned prediction errors across timescales modulate proactive and reactive CC, extending the signed DA/TD account to unsigned multi-timescale control signals.
- **[[wiki/papers/pfc-cognitive-control-friedman-2021.md]]** — source for ACC Predicted Response Outcome model and its reactive/proactive CC distinction.
- **[[wiki/entities/ltc-model.md]]** — the LTC ODE is structurally equivalent to Friston's bilinear DCMs; both are continuous-time causal state-space generative models; ODE semantics give inherent causal ordering that FEP's active inference framework requires for action-perception loops.
- **[[wiki/papers/ltc-hasani-2021.md]]** — source for the LTC–DCM structural resemblance; Friston, Harrison & Penny 2003 and Penny, Ghahramani & Friston 2005 cited as motivation for the LTC formulation.
- **[[wiki/papers/friston-free-energy-2009.md]]** — primary source for active inference (action as F-minimization), three-tier representation (states/params/precisions → perception/learning/attention), and DA=precision reinterpretation; the canonical short-form FEP statement.
- **[[wiki/concepts/attention.md]]** — biological attention as precision optimization (gain of error-units) is the FEP derivation; the transformer self-attention account in that page is a complementary computational-level description.
- **[[wiki/entities/prefrontal-cortex.md]]** — PFC maintains the recognition density (goal-state predictions) that active inference requires before BG action selection; the Block 3C/3D architecture maps directly to the FEP action-perception loop.
- **[[wiki/entities/basal-ganglia.md]]** — BG implements action in the active inference loop; DA (precision of priors) gates whether predictions are precise enough to drive action — the FEP account of why BG action selection requires a sufficiently confident prior expectation.
- **[[wiki/papers/language-modeling-compression-deletang-2023.md]]** — establishes that the accuracy term in F equals the lossless compression rate; FEP minimization is therefore formally compression minimization; the Solomonoff predictor is the theoretical ceiling that a perfect FEP-minimizing agent approximates.
- **[[wiki/concepts/hebbian-learning.md]]** — STDP is the biological instantiation of the local PC weight update Δw ∝ ε · x; feedback alignment and energy-based networks provide the formal bridge from backprop to this Hebbian rule, resolving the weight-symmetry and non-locality objections while connecting gradient learning to the same local coincidence-detection rule used in fast-M writes.
- **[[wiki/papers/hassabis-neuroscience-ai-2017.md]]** — survey source for feedback alignment (Lillicrap et al. 2016) and local energy-based network updates as biologically plausible backprop approximations; frames the two objections (weight symmetry and non-locality) as resolved by recent AI research, supporting PC as the candidate slow-W learning rule.
- **[[wiki/concepts/credit-assignment.md]]** — PC occupies the medium-bias/medium-variance position in the full credit assignment approximation spectrum; that page gives the unified bias–variance taxonomy across all biologically plausible learning rules, including AR which achieves near-zero bias using a single neuron type.
- **[[wiki/papers/millidge-activation-relaxation-2020.md]]** — AR challenges PC's two-population architecture necessity: a single neuron type with dynamical relaxation achieves exact backprop gradients locally, and counterexamples the NGRAD hypothesis that PC satisfies.
- **[[wiki/papers/richards-lillicrap-dl-framework-2019.md]]** — source for the bias–variance framing of PC and the broader credit assignment taxonomy; establishes that satisfying locality constraints necessarily incurs either bias or variance relative to backprop.
- **[[wiki/papers/whittington-bogacz-pc-backprop-2017.md]]** — the primary source for PC-as-backprop: formal derivation that PC error nodes converge to backprop δ terms at steady state; identifies three convergence conditions and the σ_out → 0 limit as the exact-equivalence case; MNIST results confirm practical parity; also establishes the bidirectional association capability absent from standard backprop.
- **[[wiki/entities/gwt-model.md]]** — GNW + Bayesian inference is the explicit PC-GNW synthesis: hub broadcasts compressed top-down predictions via NMDA-gated recurrence; ignition = inference convergence; AMPA feedforward = fast sensory mismatch signal.
- **[[wiki/papers/gnw-mashour-2020.md]]** — source for the GNW-Bayes integration; AMPA/NMDA receptor dissociation as the biological mechanism for the PC feedforward/feedback timing split; anesthesia data confirming disrupted top-down feedback = disrupted conscious inference.
- **[[wiki/papers/bastos-canonical-microcircuit-2012.md]]** — source for the Cortical Laminar Implementation section: derives the specific neuronal-population-to-variable mapping from the PC equations, confirms it against quantitative connectivity data, and establishes spectral asymmetry (gamma = superficial error; beta = deep prediction) as a mathematical consequence of Bayesian filtering.
- **[[wiki/concepts/temporal-coding.md]]** — the gamma/beta spectral asymmetry between superficial error neurons and deep prediction neurons is a temporal-coding consequence of PC dynamics; feedforward = gamma channel; feedback = beta/alpha channel.
- **[[wiki/concepts/dendritic-computation.md]]** — the L1 inhibitory route targets apical dendrites of L2/3 pyramidal cells; this is simultaneously the feedback-prediction suppression mechanism and the credit-signal delivery site, making dendritic computation the implementation substrate for PC's two-population architecture.
- **[[wiki/papers/theories-backprop-brain-whittington-2019.md]]** — review that places PC within the explicit-error class of biologically plausible backprop models; introduces the temporal-error vs. explicit-error classification; establishes that symmetric STDP implements the PC weight rule; and proposes hippocampal theta oscillations as the phase coordinator for the contrastive learning precursor (temporal-error class).
- **[[wiki/concepts/canonical-microcircuit.md]]** — the canonical L4→L2/3→L5→L6→L4 loop is the anatomical substrate that the PC laminar mapping assigns variables to; recurrent amplification explains how weak afferent inputs become cortically dominant; the L6→thalamus arm is the biological active-inference action channel.
- **[[wiki/entities/equilibrium-propagation.md]]** — EqProp's free phase (gradient-flow settling to u⁰) is structurally identical to PC's inference phase (free-energy minimization via gradient-flow dynamics); both classify as temporal-error credit assignment models in which network convergence to a fixed point performs the effective backward pass — EqProp provides the theoretical guarantee that this shared mechanism computes the exact gradient.
- **[[wiki/entities/jepa-model.md]]** — JEPA is a non-generative PC analog: both aim to predict hidden causes in representation space; JEPA uses non-contrastive SSL instead of the free-energy hierarchy, and does not require explicit error-neuron populations — a valid alternative implementation of prediction-error minimization. Key structural difference (Lett 2025): PC iteratively infers latent state from a single input via recurrent error propagation; JEPA requires two inputs (x and y) to define z and cannot do the same online single-observation inference.
- **[[wiki/concepts/energy-based-models.md]]** — PC's squared prediction-error sum Σ ε_l² is an EBM energy function; the local ε·x weight update is gradient descent on this energy; EBM training strategies (contrastive vs. regularized) are the ML classification of what PC and its variants optimize.
- **[[wiki/concepts/world-models.md]]** — PC's hierarchical generative model p(o,z) is a probabilistic world model; active inference (action as F-minimization) is PC's formulation of Mode-2-style world-model planning; JEPA is the non-generative alternative that avoids blurriness in continuous high-dimensional prediction.
