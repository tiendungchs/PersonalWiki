---
title: "Do LLMs Overcome Shortcut Learning? Shortcut Suite — Yuan et al. 2024"
type: paper
tags: [shortcut-learning, LLM, NLI, benchmark, generalization, evaluation, inverse-scaling]
created: 2026-06-24
updated: 2026-06-24
sources: ["Do LLMs Overcome Shortcut Learning? An Evaluation of Shortcut Challenges in Large Language Models.md"]
related: [wiki/concepts/latent-graph-discovery.md, wiki/papers/shortcut-learning-geirhos-2020.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/structural-generalization.md, wiki/concepts/shortcut-reasoning.md, wiki/papers/beger-conceptarc-multimodal-2025.md]
---

# Do LLMs Overcome Shortcut Learning? — Yuan et al. 2024

Yuan, Zhao, Zhang, Zheng & Liu. USTC 2024. arXiv:2410.13343.

---

- **Shortcut Suite benchmark:** 6 shortcut types (Lexical Overlap, Subsequence, Constituent, Negation, Position, Style), 5 metrics (ACC, SFS, ICS, EQS, CFS), 4 prompt settings (zero-shot, few-shot ICL, zero-shot CoT, few-shot CoT), 8 LLMs (GPT-3.5-Turbo, GPT-4, Gemini-Pro, LLaMA2-7B/13B/70B, ChatGLM3-6B, Mistral-7B). All shortcuts are injected into MultiNLI/HANS via logical tautologies (`q ∧ s ≡ q`), creating two valid inference paths: semantic relationship (`x → l`) vs. shortcut (`s → l`).
- **Severity:** Constituent shortcut causes worst degradation — LLaMA2-Chat-13B zero-shot drops from 54.3% to 0.8% on non-entailment set (¬E), 52.4% drop for GPT-3.5-Turbo few-shot. Position shortcut reveals left-bias: adding tautologies at sentence start consistently lowers accuracy more than at end — LLMs over-weight earlier tokens.
- **Inverse scaling under simple prompting:** larger LLMs are *more* prone to shortcuts under zero-shot and few-shot ICL, not less (LLaMA2 70B → 1.6% on Constituent ¬E few-shot). Interpretation: larger models have memorized more surface patterns, making spurious edges easier to activate. Capability accumulation amplifies shortcut availability.
- **CoT as partial mitigation:** chain-of-thought prompting substantially reduces shortcut reliance (LLaMA2-Chat-13B improves 40.9% on Constituent ¬E) by forcing intermediate reasoning steps — equivalent to requiring traversal of intermediate latent graph nodes rather than a direct surface edge to the label. Zero-shot CoT (Chain of Thought) outperforms few-shot ICL consistently.
- **Internal consistency collapse:** ICS < 50% across all models in shortcut-laden datasets — over half of CoT (Chain of Thought) reasoning chains contain internal contradictions. Models produce plausible-sounding but logically inconsistent chains when shortcuts are available, revealing that the explanation and prediction can diverge (disguised comprehension).
- **Three error types in CoT:** (1) *Distraction* — attending to tautologies or sentence-start tokens while ignoring semantically relevant content; (2) *Disguised comprehension* — producing a fluent but incorrect paraphrase of the premise/hypothesis, masking that the model missed the actual semantic relationship; (3) *Logical fallacy* — overgeneralizing from specific to general ("they know of the action" → "they know the person").

**Limitations:** Focused on NLI; SA and PI extended evaluations confirm generality but shallowly. No architectural intervention proposed — diagnostic only. Confidence elicitation is self-reported, not calibrated.

---

- **[[wiki/concepts/latent-graph-discovery.md]]** — shortcut learning is false edge discovery: LLMs learn spurious edges (lexical overlap → entailment) that work IID but fail OOD; CoT (Chain of Thought) forces multi-hop latent graph traversal instead of taking a single shortcut edge.
- **[[wiki/papers/shortcut-learning-geirhos-2020.md]]** — Yuan 2024 is the empirical LLM-scale instantiation of Geirhos's taxonomy; adds inverse-scaling paradox and internal consistency metrics beyond accuracy.
- **[[wiki/concepts/abstract-reasoning.md]]** — inverse scaling (bigger LLM → more shortcuts under ICL) quantifies why capability measured on i.i.d. benchmarks doesn't transfer to o.o.d. abstract reasoning.
- **[[wiki/concepts/compositional-generalization.md]]** — Constituent shortcut failure reveals inability to use parse-tree structure for inference, the same structural shortcoming that causes compositional generalization failures.
- **[[wiki/concepts/structural-generalization.md]]** — shortcut solutions are structurally shallow: they exploit surface statistics of the training distribution rather than extracting the invariant relational structure that generalizes across syntactic forms.
- **[[wiki/concepts/shortcut-reasoning.md]]** — synthesis concept page; Yuan 2024 provides the LLM-scale empirical pillar (inverse scaling paradox, ICS collapse) of the broader shortcut taxonomy.
- **[[wiki/papers/beger-conceptarc-multimodal-2025.md]]** — complements Yuan's NLI findings with ARC-domain shortcut analysis; both papers confirm that scale does not reduce shortcut reliance and that rule-level evaluation is required to detect it.
