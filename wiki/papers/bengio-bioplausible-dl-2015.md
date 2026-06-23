---
title: "Towards Biologically Plausible Deep Learning — Bengio et al. 2015"
type: paper
tags: [credit-assignment, stdp, hebbian-learning, variational-em, targetprop, biologically-plausible]
created: 2026-06-23
updated: 2026-06-23
sources: [towards_biologically_plausuble_DL]
related: [wiki/concepts/credit-assignment.md, wiki/concepts/hebbian-learning.md, wiki/concepts/predictive-coding.md, wiki/entities/equilibrium-propagation.md, wiki/papers/scellier-bengio-eqprop-2017.md, wiki/papers/bartunov-scalability-bio-dl-2018.md]
---

# Towards Biologically Plausible Deep Learning

Bengio, Lee, Bornschein, Mesnard & Lin. ICML 2015 Deep Learning Workshop. arXiv:1502.04156.

---

## Key Computational Insights

- **STDP = SGD**: The update rule ΔW_{ij} ∝ S_i · V̇_j (presynaptic spike × temporal derivative of postsynaptic voltage) is equivalent to stochastic gradient descent on any objective J — provided neural dynamics push V_j toward better values of J. This is a direct ML interpretation of the primary biological learning rule, without requiring symmetric weights or separate backward circuits.

- **Variational EM as neural computation**: Cast neural inference as the E-step — iterative dynamics driving latent states h toward higher log p(x,h) — and weight updates as the M-step using locally converged h. The training objective is a variational lower bound on log p(x); maximizing it avoids explicit gradient computation or global coordination signal.

- **Targetprop gradient estimator**: The gradient ∂log p(x|h)/∂h is approximated by [f(g(h)) − h]/σ², where f and g are encoder/decoder pairs trained as approximate inverses. Derived from the denoising auto-encoder theorem (Alain & Bengio 2013): a well-trained DAE with corruption variance σ² satisfies r(x) − x ≈ σ² ∇_x log p(x). Only ordinary forward/backward neural computation required.

- **No weight symmetry required**: Unlike EqProp (Scellier & Bengio 2017), which requires W_{ij} = W_{ji}, targetprop learns approximate inverse mappings between adjacent layers. Feedback weights are trained separately from feedforward weights and need not be their transposes — directly addressing the weight transport problem without the symmetric-weights constraint.

- **Joint denoising auto-encoder interpretation**: The trained generative model is equivalently a joint DAE over (x, h). Iterating encode/decode with noise injection (stochastic quantization from spikes) moves h toward the training distribution and yields better samples than the directed generative model alone; the Markov chain's stationary distribution is an implicit estimator of p(x).

---

## Limitations

- Gradient estimate f(g(h)) − h is high-bias relative to backprop; DTP collapses at ImageNet scale (Bartunov et al. 2018: >98% top-1 error vs. BP's 71%).
- Of the six backprop biological implausibility points, only phase synchronization (point 5 — feedforward and inference phases must be time-multiplexed) remains unaddressed.
- Empirical validation limited to unsupervised generative learning on MNIST; extension to supervised learning and reinforcement learning described in theory but not demonstrated.

---

## Links

- [[wiki/concepts/credit-assignment.md]] — DTP entry in taxonomy; variational EM adds the inference-phase framing
- [[wiki/concepts/hebbian-learning.md]] — STDP-as-SGD interpretation; fourth STDP ↔ credit assignment correspondence
- [[wiki/concepts/predictive-coding.md]] — variational EM is structurally the PC inference/learning split, re-derived from the ELBO
- [[wiki/entities/equilibrium-propagation.md]] — contrast: EqProp exact but symmetric weights; targetprop approximate but weight-transport-free
