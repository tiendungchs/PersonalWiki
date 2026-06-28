---
title: "Brain-inspired learning in artificial neural networks: a review"
type: paper
tags: [brain-inspired-learning, synaptic-plasticity, hebbian-learning, local-learning, meta-learning, snn, continual-learning, review]
created: 2026-06-27
updated: 2026-06-27
sources: [brain-inspired-learning-review]
related: [wiki/concepts/hebbian-learning.md, wiki/concepts/credit-assignment.md, wiki/concepts/meta-learning.md, wiki/concepts/neuromodulation.md, wiki/concepts/continual-learning.md, wiki/entities/snn.md, wiki/concepts/differentiable-plasticity.md]
---

# Brain-inspired learning in artificial neural networks: a review

Schmidgall, Achterberg, Miconi, Kirsch, Ziaei, Hajiseyedrazi, Eshraghian (2023). Johns Hopkins / Cambridge / Intel Labs / IDSIA / UC Santa Cruz.

---

## Key Computational Insights

- **Three-factor plasticity / node perturbation:** multiplying the Hebbian update by a reward signal is insufficient; one term must be zero-mean. Node perturbation (perturb activations Δx_j → update ∝ x_i · Δx_j · R) implements REINFORCE exactly and is biologically plausible in recurrent networks learning from sparse delayed rewards.
- **Differentiable plasticity:** backprop through unrolled plasticity rule dynamics optimizes the *parameters governing the update rule* (e.g., η in Δw_ij = η · x_i · x_j) rather than the weights themselves; enables intra-lifetime fast-W learning; two neuromodulation variants (global M + retroactive dopamine-like eligibility trace). See [[wiki/concepts/differentiable-plasticity.md]].
- **Generalization of local rules:** backprop-derived local learning rules (FA, DFA, SS) find sharper minima than backpropagation → systematically worse generalization; the gradient approximation is misaligned with the true gradient, and step-size scaling does not help.
- **In-context learning = plastic W (interpretation):** parameter sharing in meta-learners leads to an activations-as-weights interpretation — Transformer self-attention implements gradient descent in activation space; fixed-W networks with in-context learning and plastic-W networks may converge on equivalent computations.
- **Self-referential meta-learning:** extends the two-level (meta-learner / discovered rule) hierarchy to arbitrary levels by allowing the network to modify all its own parameters recursively, including the update rule itself.
- **Evolvable Neural Units (ENUs):** evolutionary discovery of both spiking dynamics and learning rules; gating structure controls input processing, storage, and parameter updates; demonstrates T-maze RL rule discovery with lower memory cost than differentiable methods.

## Limitations

- Review scope: primarily covers feed-forward / recurrent networks without detailed cortical hierarchy; connectome-level organization largely absent.
- Performance gap not quantified: does not benchmark meta-optimized local rules against backpropagation at ImageNet scale (see [[wiki/papers/bartunov-scalability-bio-dl-2018.md]] for that comparison).
- Glial cells and neurogenesis sections are speculative with respect to AI implications.

## Links to Concept / Entity Pages

- [[wiki/concepts/differentiable-plasticity.md]] — primary home for Miconi-style meta-optimized plasticity
- [[wiki/concepts/hebbian-learning.md]] — three-factor rules and node perturbation
- [[wiki/concepts/credit-assignment.md]] — FA, DFA, SS, e-prop taxonomy; generalization finding
- [[wiki/concepts/meta-learning.md]] — differentiable plasticity and self-referential meta-learning instantiations
- [[wiki/concepts/neuromodulation.md]] — three-factor rule and eligibility trace formalism
- [[wiki/entities/snn.md]] — SNN-native surrogate-gradient plasticity, e-prop
- [[wiki/concepts/continual-learning.md]] — catastrophic forgetting as primary application motivation
