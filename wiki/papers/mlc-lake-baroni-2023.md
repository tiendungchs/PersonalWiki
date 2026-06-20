---
title: "Human-like Systematic Generalization — Lake & Baroni, Nature 2023"
type: paper
tags: [meta-learning, compositional-generalization, systematicity, inductive-biases, seq2seq]
created: 2026-06-19
updated: 2026-06-19
sources: [Human-like_systematic_generalization]
related: [wiki/entities/mlc-model.md, wiki/concepts/compositional-generalization.md, wiki/concepts/meta-learning.md, wiki/concepts/structural-generalization.md, wiki/papers/compositionality-decomposed-hupkes-2020.md]
---

# Human-like Systematic Generalization — Lake & Baroni, Nature 2023

**Citation:** Lake, B. M. & Baroni, M. (2023). Human-like systematic generalization through a meta-learning neural network. *Nature*, 623, 115–121. *(Source: Supplementary Information only.)*

---

## Key Computational Insights

- **Meta-training installs rule-learning in frozen weights.** MLC is trained on 100K episodic seq2seq tasks with a different compositional grammar per episode. At test time weights are frozen; new rules are inferred purely from in-context instructions. Novel rules (never in meta-training) are acquired at 99%+ accuracy — proving the fast algorithm generalizes beyond its training vocabulary.
- **GPT-4 fragility exposes surface-pattern dependence.** GPT-4 achieves 58% on the few-shot instruction task with sorted examples but collapses to 14% when example order is randomized. MLC is robust to this permutation. The diagnostic: LLMs learn order-dependent co-occurrence statistics, not abstract compositional rules — operationalising the "chunking" failure mode from Hupkes et al. 2020.
- **Meta-learning surpasses general pre-training for systematic generalization.** MLC: 92.9–96.8% exact match. GPT-4 (best setting): 58%. Humans: 80.7%. Targeted episodic training on a compositional task distribution outperforms billion-parameter models pre-trained on internet text.
- **Human inductive biases are gradable context-sensitive priors, not rigid rules.** Three priors identified: (1) mutual exclusivity (novel word → novel meaning); (2) iconic concatenation (compound meaning = concatenation of parts); (3) one-to-one (word-meaning bijection). ME weakens with contradictory evidence (β=1.76, p<0.001) and larger response pools (β=2.05, p<0.01). MLC (within-sample) matches human nuance at 68.6% ME-consistent; MLC (joint) is too rigid at 98%.
- **MLC (joint) over-rigidity reveals meta-training distribution bias.** Adding open-ended human data improves compositional accuracy but applies ME too absolutely — indicating that meta-learning can overfit to the modal inductive prior rather than learning the *distribution* of human biases.

---

## Limitations

- Source is SI only; main paper has full architecture, training details, and primary benchmark results.
- MLC is task-specialist: requires meta-training on the target compositional domain — not transferable to arbitrary new domains without retraining the slow outer loop.
- Human inductive bias nuance (context-sensitive ME, one-to-one/ME trade-offs) requires within-sample optimization (MLC within-sample), not just the out-of-distribution meta-learned model.

---

## Links

- [[wiki/entities/mlc-model.md]] — MLC architecture and benchmark results
- [[wiki/concepts/compositional-generalization.md]] — where MLC results update the five-facet picture
- [[wiki/concepts/meta-learning.md]] — MLC as non-RL instantiation of the slow/fast meta-learning structure
- [[wiki/papers/compositionality-decomposed-hupkes-2020.md]] — Hupkes et al. 2020 established the five-facet failure profile that MLC addresses
