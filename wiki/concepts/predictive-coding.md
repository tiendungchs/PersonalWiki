---
title: "Predictive Coding / Free Energy Principle"
type: concept
tags: [predictive-coding, free-energy-principle, generative-model, variational-inference, bayesian-brain]
created: 2026-06-12
updated: 2026-06-19 (2)
sources: [free-energy-principle-transcript, brain-learning-algorithm-transcript, bolzman-machine-transcript, Metalearning_and_Neuromodulation, The role of prefrontal cortex in cognitive control and executive function]
related: [wiki/concepts/information-theory.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/factorized-representations.md, wiki/concepts/latent-states.md, wiki/concepts/neural-manifolds.md, wiki/concepts/neuromodulation.md, wiki/concepts/cognitive-control.md, wiki/entities/tem-model.md, wiki/entities/htm-thousand-brains.md, wiki/entities/boltzmann-machine.md, wiki/papers/brain-learning-algorithm-transcript.md, wiki/papers/150000-mini-brain-transcript.md, wiki/papers/boltzmann-machine-transcript.md, wiki/papers/metalearning-neuromodulation-doya-2002.md, wiki/papers/pfc-cognitive-control-friedman-2021.md]
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

Minimizing F = minimizing cross-entropy + regularizing toward the prior. See [[wiki/concepts/information-theory.md]] for the KL–cross-entropy equivalence and the ELBO derivation.

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

---

## Open Problems

- **Active inference:** extending FEP so actions minimize *expected future* free energy (epistemic foraging), not just current free energy. Not yet covered in this wiki.
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
