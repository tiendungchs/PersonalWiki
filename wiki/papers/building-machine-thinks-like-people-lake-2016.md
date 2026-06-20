---
title: "Building Machines That Learn and Think Like People — Lake, Ullman, Tenenbaum & Gershman 2016"
type: paper
tags: [abstract-reasoning, model-building, compositionality, causality, meta-learning, intuitive-physics]
created: 2026-06-20
updated: 2026-06-20
sources: [building_machine_that_thinks_like_people]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/meta-learning.md, wiki/concepts/two-learning-timescales.md, wiki/entities/arc-agi.md, wiki/concepts/analogical-reasoning.md]
---

# Building Machines That Learn and Think Like People — Lake et al. 2016

Lake, B. M., Ullman, T. D., Tenenbaum, J. B., & Gershman, S. J. (2016). *Behavioral and Brain Sciences* (in press).

---

## Key Computational Insights

- **Pattern recognition vs. model-building:** Human intelligence constructs causal generative models that support explanation, counterfactual inference, and arbitrary goal repurposing — not discriminative mappings locked to a training task. DQN requires 924h to reach <10% of human performance on Frostbite; a person watching 2 minutes of expert play reaches parity in 15 minutes. The gap is the causal model, not compute.
- **Developmental start-up software:** Intuitive physics and intuitive psychology are early-present structured inductive biases functioning as probabilistic simulators — a physics engine and a Bayesian inverse-planning agent model. They are not learned per-task but function as strong domain priors that make all subsequent learning efficient.
- **Compositionality + causality as prerequisites for human-level learning-to-learn:** Multi-task transfer on monolithic features yields only 2–5× speed-up; human-level one-shot transfer requires representations that are both compositional (recombineable parts+relations) and causal (resembling the actual generative process). Without both, learning-to-learn cannot leverage prior knowledge efficiently.
- **Bayesian Program Learning (BPL) as proof-of-concept:** Represents concepts as stochastic programs — causal descriptions of how to generate instances. From a single example BPL achieves human-level one-shot classification, generation, part-parsing, and concept recombination simultaneously; all tasks fall out of the single causal model.
- **Model-free / model-based RL cooperation:** Human RL integrates both systems — model-based planning simulates training data for the model-free system (Dyna); model-free responses become automatic with practice while model-based handles novel goals. This is the RL instantiation of the slow-W / fast-M principle.

## Limitations

- BPL's program language (pen strokes, relations) is hand-designed for handwriting; learning the program primitives from raw data is unsolved.
- Agenda-setting paper, not a unified architecture — no general system proposed.
- Does not specify how a machine acquires intuitive physics/psychology without hand-coding.

## Links

[[wiki/concepts/abstract-reasoning.md]] · [[wiki/concepts/structural-generalization.md]] · [[wiki/concepts/compositional-generalization.md]] · [[wiki/concepts/meta-learning.md]] · [[wiki/concepts/two-learning-timescales.md]] · [[wiki/entities/arc-agi.md]] · [[wiki/concepts/analogical-reasoning.md]]

**[[wiki/concepts/analogical-reasoning.md]]** — schema induction from episodic comparison (Lake et al.) is the relational-level analog of BPL; analogical-reasoning.md provides the four-component process that operationalizes model-building as a computational algorithm.
