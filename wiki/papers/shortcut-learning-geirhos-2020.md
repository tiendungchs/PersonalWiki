---
title: "Shortcut Learning in Deep Neural Networks — Geirhos et al. 2020"
type: paper
tags: [shortcut-learning, generalization, inductive-bias, o.o.d, abstract-reasoning, compositionality]
created: 2026-06-23
updated: 2026-06-23
sources: [shortcut learning.md]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/structural-generalization.md, wiki/entities/arc-agi.md, wiki/concepts/meta-learning.md, wiki/concepts/energy-based-models.md, wiki/papers/shortcut-suite-yuan-2024.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/shortcut-reasoning.md, wiki/papers/beger-conceptarc-multimodal-2025.md]
---

# Shortcut Learning in Deep Neural Networks — Geirhos et al. 2020

Geirhos, Jacobsen, Michaelis, Zemel, Brendel, Bethge & Wichmann. *Nature Machine Intelligence* 2020. DOI: 10.1038/s42256-020-00257-z

---

- **Decision-rule taxonomy:** uninformative features → overfitting solutions → i.i.d. solutions (includes shortcuts) → intended solutions. A shortcut is any rule that achieves good i.i.d. test performance but fails on out-of-distribution (o.o.d.) data — the gap between appearing capable and being capable. ARC-AGI is precisely an o.o.d. generalisation benchmark: performance on static i.i.d. tasks (ARC-AGI-1 solved at 87% by o3) does not transfer to structurally novel tasks (ARC-AGI-2 <25%, ARC-AGI-3 <1%).
- **Inductive bias decomposition:** four factors jointly determine which solutions are easy to learn — (a) **architecture** (hard constraints on representable functions), (b) **training data** (shortcut opportunities persist at scale; big data does not eliminate systematic bias), (c) **loss function** (cross-entropy stops learning once any discriminative predictor is found), (d) **optimisation** (SGD biases toward simple functions; large LR → shared coarse patterns, small LR → complex instance-specific patterns).
- **Discriminative vs. generative:** discriminative learning takes any feature sufficient to distinguish training examples — shortcut features are preferred when they are simpler than the intended features. Generative/world-model learning (JEPA, PC, EBM) must model all variation in the training data, forcing representations onto features that span the full data manifold — structurally harder to exploit shortcuts.
- **Biological shortcut learning:** unintended cue learning in rats (colour discrimination via smell) and surface learning in students both exhibit the same i.i.d./ intended-solution gap — shortcut learning may be a universal property of learning systems, not an artefact of gradient descent.
- **Solution path — meta-learning and causality:** overcomes shortcuts by identifying invariant causal mechanisms across environments (Arjovsky IRM, Peters causal invariant prediction); meta-learning extracts inductive biases that generalise beyond training-distribution variation; disentangled generative models recover true latent factors. All three converge on the same requirement as the wiki's target architecture: factorised causal-structural representations with explicit latent variables.

**Limitations:** conceptual perspective paper, no new models. Emphasises CV and NLP failure cases; application sections (fairness, RL reward-hacking) tangential to the wiki's architectural goals.

---

- **[[wiki/concepts/abstract-reasoning.md]]** — shortcut taxonomy formalises the i.i.d./o.o.d. distinction that separates pattern recognition (shortcut regime) from model-building (intended-solution regime).
- **[[wiki/entities/arc-agi.md]]** — ARC-AGI is an o.o.d. benchmark designed so shortcut solutions fail; the jump from ARC-AGI-1 (i.i.d.-exploitable) to ARC-AGI-2/3 (genuine o.o.d.) is predicted by the taxonomy.
- **[[wiki/concepts/compositional-generalization.md]]** — chunking failure and i.i.d. shortcut overlap: a model trained on composition statistics exploits co-occurrence shortcuts; genuine compositionality requires the intended causal factorisation, not the easiest discriminative rule.
- **[[wiki/concepts/energy-based-models.md]]** — generative/EBM training avoids discriminative shortcuts by construction; the anti-shortcut argument is an additional design motivation for JEPA/PC over contrastive discriminative objectives.
- **[[wiki/concepts/meta-learning.md]]** — the paper's recommended solution path (IRM + meta-learning + causal disentanglement) maps to the slow-W structural learning loop; learning invariant mechanisms is equivalent to extracting the latent causal graph.
- **[[wiki/papers/shortcut-suite-yuan-2024.md]]** — Yuan 2024 is the LLM-scale empirical instantiation: Shortcut Suite confirms Geirhos taxonomy holds at scale; adds inverse scaling paradox (larger LLM → more shortcut use under ICL) and ICS / EQS as explanation-level metrics beyond accuracy.
- **[[wiki/concepts/latent-graph-discovery.md]]** — shortcut solutions map to spurious edge covariate shift (hardness source 5): a model that has discovered the correct latent causal graph is shortcut-resistant by construction; Geirhos's three solution paths (IRM / meta-learning / disentanglement) are all implementations of causal edge invariance.
- **[[wiki/concepts/shortcut-reasoning.md]]** — unified synthesis concept page consolidating this taxonomy with Yuan 2024 (LLM-scale empirical confirmation) and Beger 2025 (ARC-domain shortcut catalogue and objectness prior analysis).
- **[[wiki/papers/beger-conceptarc-multimodal-2025.md]]** — instantiates the i.i.d./o.o.d. taxonomy at the ARC concept level; "correct-unintended" rules are the ARC-specific manifestation of Geirhos's shortcut solutions.
