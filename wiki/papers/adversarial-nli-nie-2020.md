---
title: "Adversarial NLI — Nie et al. 2020"
type: paper
tags: [NLI, shortcut-learning, benchmark, robustness, spurious-correlations]
created: 2026-06-24
updated: 2026-06-24
sources: [adversarial-nli-nie-2020]
related: [wiki/concepts/shortcut-reasoning.md, wiki/concepts/latent-graph-discovery.md]
---

# Adversarial NLI — Nie et al. 2020

Nie et al. 2020. *Adversarial NLI: A New Benchmark for Natural Language Understanding.* ACL 2020.

- **Hypothesis-only spurious edge quantified:** BERT/RoBERTa achieve ~72% accuracy on SNLI/MNLI using only the hypothesis (no premise). The same hypothesis-only model drops to 42–51% on ANLI's adversarially collected test sets — directly demonstrating that standard NLI benchmarks support a spurious edge H→label that bypasses the true entailment edge P→H.
- **NLI inference-type failure taxonomy (Table 7):** adversarial writers naturally rediscover which edge types models fail to learn — in roughly this order of model susceptibility: numerical/quantitative reasoning, reference/coreference resolution, lexical inference (synonyms/antonyms), tricky inferences (pragmatics, wordplay, syntactic transformations), and commonsense/world-knowledge reasoning. As models improve on earlier categories, writers shift to harder ones.
- **Static benchmark saturation via shortcuts:** IID benchmark performance saturates when models learn hypothesis-only and lexical co-occurrence shortcuts; adversarial collection breaks saturation by requiring genuine P→H edge traversal to fool the collection procedure.
- **Architecture-specific shortcut profiles:** BERT outperforms RoBERTa on ANLI despite lower IID accuracy — different architectures exploit different spurious edges, so IID benchmark comparisons are confounded by which shortcuts each architecture happens to prefer.

**Limitations:** Diagnostic only — does not propose architectural solutions. Predates CoT-era models; no analysis of reasoning-chain length vs. shortcut reliance.

---

- **[[wiki/concepts/shortcut-reasoning.md]]** — ANLI provides cross-domain NLI evidence for the hypothesis-only shortcut class; 72%→42–51% numbers ground the Geirhos taxonomy empirically in NLI; Table 7 taxonomy parallels the ARC shortcut catalogue.
- **[[wiki/concepts/latent-graph-discovery.md]]** — hypothesis-only shortcut is a direct NLI instantiation of spurious edge covariate shift (hardness source 5): H→label is a false edge that works IID; the true P→H entailment edge only becomes necessary when the spurious shortcut is adversarially blocked.
