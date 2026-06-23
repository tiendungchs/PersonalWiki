---
title: "A Deep Learning Framework for Neuroscience — Richards, Lillicrap et al., Nat Neurosci 2019"
type: paper
tags: [credit-assignment, backpropagation, inductive-biases, objective-functions, learning-rules, architectures]
created: 2026-06-22
updated: 2026-06-22
sources: [A deep learning framework for neuroscience]
related: [wiki/concepts/credit-assignment.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/predictive-coding.md, wiki/concepts/dendritic-computation.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/hebbian-learning.md]
---

# A Deep Learning Framework for Neuroscience

Richards BA, Lillicrap TP, et al. *Nat Neurosci* 22(11):1761–1770 (2019). PMC7115933.

---

## Five Key Computational Insights

- **Three-component normative framework.** What is designed in any ANN — and what should be identified in the brain — is the triple (objective function, learning rule, architecture). The specific computation performed by each neuron is *emergent*, not designed. This makes the framework tractable: three compact descriptions generate the full complexity of neural responses.

- **Credit assignment is the central problem.** Gradient descent (backprop) is the exact solution — ΔW ∝ ∇_W F ensures monotone improvement at small step size — but requires biologically implausible backward-pass freezing and exact weight symmetry. A family of approximate solutions spans a bias–variance spectrum: feedback alignment (random B, high bias / low variance), weight/node perturbation (low bias / high variance), predictive coding and dendritic error learning (intermediate positions, exact locations unknown). No known rule achieves simultaneously near-zero bias and near-zero variance with local synaptic rules only.

- **Inductive biases are the differentiator.** The "No Free Lunch" theorem rules out a universal learning algorithm; success requires prior knowledge embedded as structural constraints. Deep learning succeeded not from blank-slate scale but from useful inductive biases for the AI Set (hierarchy, translation invariance, attention). The brain's inductive biases — including object permanence, compositional structure, Core Knowledge priors — were installed by evolution over the "Brain Set," the task family that species evolved to solve.

- **Brain Set / AI Set framing.** Systems neuroscience should anchor models to the specific task set a species evolved for, not arbitrary benchmarks. Abstract reasoning, planning, and language constitute the overlapping region of the human Brain Set and the AI Set. A reasoning model's objective function, learning rule, and architecture must all be validated against tasks *in* that set — ARC-AGI is the appropriate Brain Set proxy for human-like abstract reasoning.

- **Emergent phenomena as framework validation.** Grid cells, shape tuning (V4-like in CNNs), temporal receptive fields, visual illusions, and apparent model-based reasoning all emerge in task-optimized deep ANNs trained on naturalistic objectives — without hand-coding. This confirms the reverse-engineering methodology: specify the correct objective + architecture → biologically realistic representations arise as a consequence.

---

## Limitations

- Perspective paper only — programmatic framework, no specific model. Does not prescribe which objective function, learning rule, or architecture combination is correct for any given brain area.
- Credit assignment bias/variance taxonomy (Fig. 2) is schematic; exact properties of most biologically plausible rules remain empirically open.
- Does not address temporal credit assignment (multi-step delays between action and outcome) — the harder problem for reasoning tasks.

---

## Links

- [[wiki/concepts/credit-assignment.md]] — the paper establishes credit assignment as the central organizing concept for learning in brains and ANNs
- [[wiki/concepts/hierarchical-representations.md]] — inductive bias framing; Brain Set / AI Set; emergent phenomena validation
- [[wiki/concepts/predictive-coding.md]] — PC as a medium-bias/medium-variance credit assignment approximation
- [[wiki/concepts/dendritic-computation.md]] — apical dendrites as the neural substrate for credit signal delivery
- [[wiki/concepts/abstract-reasoning.md]] — Brain Set = abstract reasoning + planning; ARC-AGI as the canonical benchmark
- [[wiki/concepts/hebbian-learning.md]] — local Hebbian rules as the low-level implementation of approximate credit signals
