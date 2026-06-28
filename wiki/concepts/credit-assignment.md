---
title: "Credit Assignment"
type: concept
tags: [credit-assignment, backpropagation, learning-rules, feedback-alignment, dendritic-error, predictive-coding]
created: 2026-06-22
updated: 2026-06-27
sources: [A deep learning framework for neuroscience, brain-learning-algorithm-transcript, hassabis-neuroscience-ai-2017, backprop_in_the_brain, whittington-bogacz-pc-backprop-2017, Assessing the Scalability of Biologically-Motivated Deep Learning Algorithms and Architectures, tavanaei-deep-snn-2018, Theories of Error Back-Propagation in the Brain, Equilibrium Propagation Bridging the Gap between Energy-Based Models and Backpropagation, towards_biologically_plausuble_DL, meta-learning-plasticity-random-feedback]
related: [wiki/concepts/predictive-coding.md, wiki/concepts/hebbian-learning.md, wiki/concepts/dendritic-computation.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/neuromodulation.md, wiki/entities/equilibrium-propagation.md, wiki/papers/richards-lillicrap-dl-framework-2019.md, wiki/papers/brain-learning-algorithm-transcript.md, wiki/papers/hassabis-neuroscience-ai-2017.md, wiki/papers/millidge-activation-relaxation-2020.md, wiki/papers/whittington-bogacz-pc-backprop-2017.md, wiki/papers/bartunov-scalability-bio-dl-2018.md, wiki/papers/tavanaei-deep-snn-2018.md, wiki/papers/theories-backprop-brain-whittington-2019.md, wiki/papers/scellier-bengio-eqprop-2017.md, wiki/papers/bengio-bioplausible-dl-2015.md, wiki/papers/meta-learning-plasticity-random-feedback.md, wiki/entities/snn.md, wiki/concepts/meta-learning.md, wiki/papers/pcm-l2l-ortner-2025.md]
---

# Credit Assignment

**Credit assignment is the problem of determining how much each parameter (synapse) should change to improve the system's performance on an objective function — i.e., computing ∂F/∂w_{ij} for every weight in a deep network.**

---

## The Gradient Solution

For objective function F(W) over weights W, the improvement per step is:

$$\Delta F \approx \Delta W^T \cdot \nabla_W F$$

Choosing ΔW = η∇_W F (gradient ascent) guarantees monotone improvement at small step size η:

$$\Delta F \approx \eta \|\nabla_W F\|^2 > 0$$

Backpropagation computes ∇_W F exactly via the chain rule, recursively propagating errors backward through all layers. It is the optimal credit assignment rule — minimal variance, no bias — but requires:

1. **Weight symmetry** — backward-pass weight matrix = exact transpose of forward-pass weight matrix
2. **Backward phase freeze** — all forward-pass activations held fixed while error signals propagate; computation and learning cannot overlap

Both requirements are neurophysiologically impossible.

---

## Bias–Variance Taxonomy of Biologically Plausible Approximations

Any credit assignment rule can be described as an estimator of ∇_W F with characteristic bias (systematic deviation from the true gradient direction) and variance (stochasticity of the estimate):

| Rule | Bias | Variance | Biological constraint satisfied | Key mechanism |
|---|---|---|---|---|
| **Backprop** | None | Low | None (reference) | Chain-rule exact gradient |
| **Feedback alignment (FA)** (Lillicrap et al. 2016) | High | Low | No weight symmetry | Random fixed B replaces W^T; forward W aligns to B during training |
| **Direct FA (DFA)** (Nøkland 2016) | High | Low | No weight symmetry; no layer-by-layer chaining | Simplifies FA by skipping the weight transport chain entirely: output error projected *directly* to each hidden layer via independent fixed random matrices; eliminates inter-layer coupling in backward pass; comparable to FA on MNIST/CIFAR, fails on ImageNet |
| **Sign-Symmetry (SS)** (Liao et al. 2016) | Medium | Low | Symmetric *signs* only (not magnitudes) | Backward matrix shares sign pattern with W^T but not magnitudes; empirically finds flatter minima than FA → better generalization; achieves comparable performance to backpropagation on large-scale datasets unlike FA/DFA |
| **Meta-learned plasticity F^bio** (Shervani-Tabar & Rosenbaum 2023) | Low (online) | Low | No weight symmetry; local updates; online learning | Bilevel meta-optimization over 10 candidate local terms discovers F^bio = pseudo-gradient − θ₂**e**_ℓ**e**ℓ₋₁^T (eHebb) + θ₉ Oja; eHebb pushes W→B^T via error correlations ($\mathbb{E}[\mathbf{e}_\ell\mathbf{e}_{\ell-1}^T\|B]\propto B^T$); Oja orthonormalizes forward features via PCA; matches BP in online (batch=1), 250-sample regime |
| **Target propagation / DTP** (Bengio 2014; Lee et al. 2015; Bengio et al. 2015) | High | Medium | No weight symmetry; no backward gradient phase | Layer-wise approximate inverses: gradient estimated by **[f(g(h)) − h]/σ²**, where f/g are encoder/decoder pairs trained as approximate inverses; justified by denoising auto-encoder theorem (Alain & Bengio 2013: r(x)−x ≈ σ²∇log p(x)); DTP adds stabilizing linear correction; competitive with BP on MNIST/CIFAR-FC but fails at ImageNet. **Variational EM (Expectation Maximization) framing** (Bengio et al. 2015): E-step = iterative neural dynamics driving h toward max log p(x,h); M-step = local weight update using converged h — identical split to predictive coding but derived from the ELBO rather than the free energy. |
| **SDTP** (Bartunov et al. 2018) | High | Medium | Fully weight-transport-free; no gradient at any layer | Extends DTP to remove last BP step (penultimate layer); degrades further than DTP due to low-entropy target diversity problem with small output alphabets |
| **Weight perturbation** | Low | High | No backward pass | Perturb each w randomly; reinforce if F improves |
| **Node perturbation** | Low | High | No backward pass | Perturb unit activations; reinforce if F improves |
| **Predictive coding** (Whittington & Bogacz 2017) | Medium | Medium | Local weight update only | ε·x rule; equivalent to backprop at energy minimum of linear network |
| **Dendritic error learning** (Sacramento et al. 2018) | Medium | Medium | Local; dual compartment | Apical δ signals deliver credit via dendrite; basal Hebbian update |
| **Contrastive Hebbian Learning** (Movellan 1990) | High | Medium | Local; two-phase | Full output clamping in phase 2 (β→∞); objective J_CHL = E(u^∞) − E(u⁰) can go negative when free/clamped phases land in different energy modes — mode-mismatch bug |
| **Equilibrium Propagation** (Scellier & Bengio 2017) | Near-zero | Low | Local; identical leaky-integrator dynamics in both phases | Weak output clamping (small β); implicit function theorem guarantees u^β stays near u⁰ (same mode); ΔW ∝ (1/β)[ρ(u^β)ρ(u^β) − ρ(u⁰)ρ(u⁰)] is the exact gradient in β→0 limit; requires symmetric weights |
| **Continuous update** (Bengio et al. 2017) | Medium | Medium | Local rate-of-change rule; no weight symmetry | Output neurons shift continuously toward target; Δw ∝ x_pre · (dx_post/dt) → asymmetric STDP; still requires control signal indicating target presence |
| **Attention-gated RL (AGREL)** (Roelfsema & van Ooyen 2005) | Medium | Medium | Neuromodulatory; no symmetric weights | Attention "tags" active synapses; Dopamine reward prediction error determines sign |
| **Activation Relaxation (AR)** (Millidge et al. 2020) | Near-zero | Low | Local; single neuron type; two distinct phases | Leaky-integrator dynamical system converges to exact backprop gradients at equilibrium; weight transport solved by learnable Hebbian backwards weights; nonlinear derivatives droppable |
| **e-prop / Natural e-prop** (Bellec et al. 2020; Ortner et al. 2025) | Medium | Low | Local eligibility traces $e_{jk}^t$; no weight symmetry; online; externalized learning signal from a dedicated LSG SNN | Eligibility traces $e_{jk}^t = h_j^t \sum_{t' \le t} \gamma^{t-t'} z_i^{t'}$ persist until learning signal $L_j^t$ arrives from LSG; update $\Delta\theta_{jk} = -\alpha \sum_t L_j^t e_{jk}^t$; LSG plays role of neuromodulatory system; meta-training (outer loop) tunes Ψ (LSG weights) so a single inner-loop update suffices for one-shot task adaptation on PCM hardware [[wiki/papers/pcm-l2l-ortner-2025.md]] |
| **SpikeProp** (Bohte et al. 2002) | High | Low | No Heaviside at hidden layers (SRM proxy) | First SNN backprop: SRM continuous PSPs substitute for spike trains as differentiable activations; output units constrained to emit exactly one spike — limits expressivity |
| **Membrane potential surrogate** (Lee et al. 2016) | Medium | Medium | No weight symmetry | V(t) as differentiable proxy for Heaviside spike threshold; 98.88% MNIST at 5× fewer ops; V(t) is not synapse-local — second-order bio-implausibility independent of weight transport |
| **EventProp** (Wunderlich & Pehle 2021; Nowotny et al. 2022) | Near-zero | Low | Locality not guaranteed; event-based backward pass | Adjoint method on hybrid ODE+spike dynamics: backward pass integrates ODEs for $(\lambda_V, \lambda_I)$ + discrete jumps at saved spike times; backward complexity ∝ spike count, not sequence length; implemented on SpiNNaker 2 neuromorphic hardware |
| **EventProp+Delay** (Mészáros et al. 2025) | Near-zero | Low | Same as EventProp | Extends EventProp to compute exact gradients w.r.t. synaptic delays $d_{ji}$ alongside weights; delay gradient uses same $(\lambda_I, \lambda_V)$ dynamics: $d\mathcal{L}/dd_{ji} = -w_{ji}\sum (\lambda_{I,j}-\lambda_{V,j})|_{t_k+d_{ji}}$; supports recurrent SNNs and multiple spikes/neuron |

No rule simultaneously achieves near-zero bias and near-zero variance using only local synaptic signals *in a single continuous-time phase*. All known rules (including TP/FA variants) also require distinct forward and backward phases — a second-order bio-implausibility independent of the weight-symmetry problem.

### Scalability at ImageNet Scale

Bartunov et al. (2018) provide the first ImageNet-scale test (first test beyond MNIST/CIFAR) of bio-plausible algorithms, using locally-connected (weight-sharing-free) architectures throughout:

| Algorithm | ImageNet Top-1 Error | CIFAR-10 Test Error (LC) |
|---|---|---|
| BP (locally-connected) | 71.4% | 32.4% |
| FA | 93.1% | 37.4% |
| DTP (parallel) | 98.3% | 39.5% |
| SDTP (parallel) | 99.3% | 45.7% |
| BP ConvNet (reference) | 63.9% | 31.9% |

Key finding: the BP vs. bio-plausible gap is due to the learning algorithm, not weight sharing. BP on locally-connected networks outperforms all bio-plausible algorithms by >20 points on CIFAR and >22 points on ImageNet top-1. The convolutional vs. locally-connected gap for BP itself is small (~7–9 points). DTP degrades gracefully from MNIST → CIFAR but collapses at ImageNet scale. AR achieves near-zero bias with local rules but at the cost of a required two-phase operation (feedforward sweep + relaxation phase). The bias–variance frontier is a hard constraint imposed by the locality requirement.

---

## Temporal-Error vs. Explicit-Error Model Classes

A secondary classification of biologically plausible backprop approximations (Whittington & Bogacz 2019) that cuts across the bias–variance taxonomy:

| Property | Temporal-error models | Explicit-error models |
|---|---|---|
| **Examples** | Contrastive learning (O'Reilly 1996), Continuous update (Bengio et al. 2017) | Predictive coding (Whittington & Bogacz 2017), Dendritic error (Sacramento et al. 2018) |
| **Error encoding** | Difference in neural activity across two time phases | Activity of dedicated error neuron populations (or apical dendrite signals) |
| **Phase-control signal required?** | Yes — must signal which phase (prediction vs. target) is active | No — error neurons autonomously converge to backprop δ terms |
| **Connectivity constraint** | Unconstrained | 1:1 error–value node pairing (PC); specific interneuron pre-training (dendritic error) |
| **Propagation depth** | L−1 synapses | 2L−1 (PC) or L−1 (dendritic error) |
| **STDP correspondence** | Asymmetric STDP (continuous update); theta-phase switching (contrastive) | Symmetric STDP (PC); apical Ca²⁺ burst (dendritic error) |
| **Experimental prediction** | No dedicated error neurons; errors visible only as activity changes over time | Increased neural response to unpredicted stimuli; inhibitory neurons respond more to novel inputs |
| **Best suited for** | Primary sensory areas where next sensory frame reliably arrives (target guaranteed) | Supervised tasks where target timing is uncertain |

Empirical evidence currently favors explicit-error models: neurons in V1 respond more strongly to visual input that violates motion predictions (Attinger et al. 2017); fMRI shows expectation suppression effects consistent with dedicated error populations. However, theta oscillations coordinating phases in HC remain a viable mechanism for temporal-error learning in episodic contexts.

**Equilibrium propagation (Scellier & Bengio 2017)** formally unifies both classes: all four models are energy-based networks whose dynamics converge to a minimum before weights update. Temporal-error models minimize Hopfield energy (recurrent excitatory networks); explicit-error models minimize free energy / ELBO. The framework derives the correct plasticity rule from the energy function alone — making anatomy → energy function → plasticity a complete specification path.

---

## Two Flavors of the Problem

| Type | Definition | Example | Current solution in brain |
|---|---|---|---|
| **Structural** | Multi-layer: credit must travel from output error back through hidden layers | Training a 10-layer network end-to-end | Feedback pathways (PC, dendritic error, feedback alignment) |
| **Temporal** | Multi-step: action at time t must receive credit for outcome at time t+k | Reward after a 10-move sequence | Dopamine temporal difference (TD) error; eligibility traces |

Temporal credit assignment is the harder problem for reasoning tasks because the delay between an intermediate reasoning step and its contribution to the final answer may span many operations. Eligibility traces (synaptic "tags" that persist from a firing event until a neuromodulatory signal arrives) are the proposed biological solution. Natural e-prop (Bellec et al. 2020; Ortner et al. 2025) operationalizes this: local eligibility traces $e_{jk}^t$ accumulate at each synapse; a dedicated LSG SNN generates per-neuron learning signals $L_j^t$ conditioned on task context; the weight update $\Delta\theta_{jk} = -\alpha \sum_t L_j^t e_{jk}^t$ is local to each synapse and requires only a single inner-loop step on neuromorphic hardware. The LSG is a computational model of how specialized brain regions (VTA, LC) provide the temporally-delayed global signal that converts eligibility tags into permanent synaptic changes.

---

## Reasoning Model Implications

- **Every trainable layer requires a credit signal pathway.** Architecture design must specify not just the forward computation but how credit reaches each layer — via top-down feedback (PC), lateral neuromodulation (AGREL), or dendrite-delivered error (Sacramento).
- **Local rules constrain architecture.** Modules that cannot receive a credit signal via local means (e.g., isolated spike-timing circuits) must be trained by a different objective or frozen after initialization.
- **Eligibility traces bridge temporal credit gaps.** For multi-step reasoning, fast-M stores (Hebbian writes) can only be credited if the synapse retains a "tag" from the time it fired until a reward/error signal arrives. τ_eligibility must span the reasoning horizon.
- **Feedback alignment insight:** the brain's feedback pathways do not need to be precise transposes of feedforward pathways. Feedforward weights can adapt to exploit arbitrary feedback structure — simplifying the architectural constraint on top-down projections considerably.

---

## Open Problems

1. Exact bias/variance properties of PC, dendritic error learning, and AGREL are unknown; Fig. 2 in Richards et al. (2019) is schematic.
2. Temporal credit assignment for reasoning tasks with variable-length chains remains unsolved in biologically plausible frameworks.
3. How modular architectures (separate fast-M and slow-W systems) partition credit responsibility — whether local rules suffice for fast-M writes or require a global error signal.
4. **NGRAD hypothesis challenged:** Millidge et al. (2020) show AR converges to exact backprop gradients without encoding them as activity differences — a direct counterexample to the NGRAD hypothesis. The hypothesis likely needs reformulation to accommodate dynamical-equilibrium approaches.
5. **Scalability of any bio-plausible rule to ImageNet+ is undemonstrated.** Bartunov et al. (2018) show that FA, DTP, and SDTP all fail at ImageNet scale. No bio-plausible rule has yet been shown to learn ImageNet-difficulty tasks. The target diversity problem in TP (low-entropy output alphabet → impoverished penultimate-layer targets) is a concrete architectural bottleneck not addressed by any current variant.
6. **Flat minima and generalization of local approximations.** Backprop finds flatter loss minima than backprop-derived local rules (FA, DFA) — flat minima generalize better (Hochreiter & Schmidhuber 1997). Backprop-derived local rules exhibit worse and *more variable* generalization than full backpropagation, and this gap does not close with larger step sizes because the gradient approximation is misaligned with the true gradient direction. Sign-Symmetry (SS) is an exception: by sharing sign patterns it finds flatter minima than FA and achieves competitive generalization. The implication: biological plausibility and generalization quality are not in fundamental conflict, but the weight symmetry relaxation matters less than the *direction alignment* between the approximated and true gradient.

---

## Connections

- **[[wiki/concepts/predictive-coding.md]]** — PC (Predictive Coding) is a medium-bias/medium-variance credit assignment approximation; the local weight rule Δw ∝ ε·x is structurally equivalent to backprop at the energy minimum of a linear network, explaining *why* PC (Predictive Coding) can approximate gradient learning with purely local updates.
- **[[wiki/concepts/dendritic-computation.md]]** — apical dendrites are the neural substrate for delivering structural credit signals; the dual-compartment (basal feedforward / apical error) pyramidal cell architecture implements dendritic error learning at the single-cell level.
- **[[wiki/concepts/hebbian-learning.md]]** — all biologically plausible credit assignment rules reduce to Hebbian-style local updates modulated by a teaching signal; STDP and BTSP are the fast-M instantiations; PC (Predictive Coding) weight rule is the slow-W instantiation.
- **[[wiki/concepts/two-learning-timescales.md]]** — credit assignment operates at both timescales: slow-W outer loop requires structural credit (across layers, across environments); fast-M inner loop requires temporal credit (within episode, within trial).
- **[[wiki/concepts/neuromodulation.md]]** — Dopamine implements temporal credit assignment as a TD (Temporal Difference) error signal; ACh modulates the gain of credit signals (precision weighting); eligibility traces require a neuromodulatory "gating" event to convert synaptic tags into persistent weight changes.
- **[[wiki/papers/richards-lillicrap-dl-framework-2019.md]]** — primary source establishing credit assignment as the central problem, with the bias–variance taxonomy of approximations.
- **[[wiki/papers/brain-learning-algorithm-transcript.md]]** — source for PC (Predictive Coding) as a credit assignment approximation: backprop violations, energy function, local update rules, two-population architecture, weight transport resolution.
- **[[wiki/papers/hassabis-neuroscience-ai-2017.md]]** — survey source for feedback alignment and energy-based local updates as biologically plausible approximations.
- **[[wiki/papers/millidge-activation-relaxation-2020.md]]** — source for AR algorithm: near-zero-bias local credit assignment via dynamical equilibrium, counterexample to NGRAD, and simplified fully-local update rule using learnable Hebbian backwards weights.
- **[[wiki/papers/whittington-bogacz-pc-backprop-2017.md]]** — primary source for PC's position in the taxonomy: derives that PC (Predictive Coding) error nodes converge to backprop δ terms at the energy minimum, establishing the bias floor — PC (Predictive Coding) achieves exact backprop only for linear networks or in the σ_out → 0 limit; also the source for the contrastive Hebbian / GeneRec comparison in section 4.3.
- **[[wiki/papers/bartunov-scalability-bio-dl-2018.md]]** — empirical source for DTP/SDTP entries in the taxonomy table and the ImageNet scalability results; introduces SDTP and exposes the target diversity failure mode; establishes "behavioural realism" as a necessary evaluation criterion for bio-plausible algorithms.
- **[[wiki/papers/tavanaei-deep-snn-2018.md]]** — source for SpikeProp (first SNN backprop via SRM PSP (Post-Synaptic Potential) proxy, avoiding Heaviside at hidden layers) and membrane potential surrogate gradient (Lee et al. 2016): the two SNN-specific credit assignment methods that replace spike non-differentiability with continuous membrane dynamics.
- **[[wiki/papers/meszaros-eventprop-delays-2025.md]]** — primary source for EventProp+Delay: demonstrates that the adjoint method simultaneously yields exact gradients for weights and delays from the same backward pass; delay gradient $d\mathcal{L}/dd_{ji} = -w_{ji}\sum(\lambda_{I,j}-\lambda_{V,j})|_{t_k+d_{ji}}$ requires no additional dynamics; 26× faster than surrogate-gradient baselines at same accuracy.
- **[[wiki/entities/snn.md]]** — EventProp and EventProp+Delay are the SNN entries in this taxonomy; the event-based backward pass resolves the memory-vs-sequence-length scaling problem that makes surrogate-gradient BPTT impractical for long sequences on neuromorphic hardware.
- **[[wiki/papers/theories-backprop-brain-whittington-2019.md]]** — review source for the temporal-error vs. explicit-error classification, continuous update model and its asymmetric STDP correspondence, model comparison table with MNIST performance numbers, and equilibrium propagation as the formal unifier of all four model classes.
- **[[wiki/entities/equilibrium-propagation.md]]** — EqProp's energy-based two-phase framework is the formal proof that local contrastive Hebbian updates at fixed points compute the exact gradient; splits cleanly from CHL (Contrastive Hebbian Learning) in the taxonomy by replacing full output clamping with weak clamping, eliminating the mode-mismatch bug.
- **[[wiki/papers/scellier-bengio-eqprop-2017.md]]** — primary source for EqProp: Theorem 1 (exact gradient via contrastive rule), STDP derivation (tied dW/dt ∝ d/dt[ρ(u_i)ρ(u_j)]), comparison to CHL/CD/Recurrent-BP, and MNIST experiments establishing trainability.
- **[[wiki/papers/bengio-bioplausible-dl-2015.md]]** — original source for targetprop in the DTP taxonomy: derives the [f(g(h))−h]/σ² gradient estimator from the denoising auto-encoder theorem; introduces the variational EM (Expectation Maximization) framing (E-step = inference dynamics, M-step = local weights) as the biological implementation; explicitly claims no weight symmetry required — the key contrast with EqProp.
- **[[wiki/papers/meta-learning-plasticity-random-feedback.md]]** — primary source for meta-learned F^bio: bilevel meta-optimization over local plasticity terms discovers an eHebb+Oja combination that closes the FA performance gap in online/low-data regimes; mechanistic decomposition shows eHebb improves alignment via error correlations ($\mathbb{E}[\mathbf{e}_\ell\mathbf{e}_{\ell-1}^T|B]\propto B^T$) while Oja improves features via unsupervised orthonormalization — two orthogonal routes to bridging the feedback alignment performance gap.
- **[[wiki/concepts/meta-learning.md]]** — natural e-prop couples credit assignment and meta-learning at the system level: the outer meta-loop trains both the learner's initial weights Θ and the LSG's credit-assignment algorithm Ψ; this is a concrete example where meta-learning optimizes not just the initialization but the credit signal generator itself.
- **[[wiki/papers/pcm-l2l-ortner-2025.md]]** — primary source for natural e-prop + LSG as an eligibility-trace + externalized-learning-signal credit assignment method; demonstrates one-shot adaptation on PCM neuromorphic hardware with biologically interpretable components (eligibility trace = synaptic tag; LSG output = neuromodulatory signal).
