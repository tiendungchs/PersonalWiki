---
title: "Cross-Entropy from First Principles (tutorial transcript)"
type: paper
tags: [information-theory, entropy, cross-entropy, kl-divergence, generative-models]
created: 2026-06-12
updated: 2026-06-12
sources: [cross-entropy-first-principles-transcript]
related: [wiki/concepts/information-theory.md]
---

# Cross-Entropy from First Principles (tutorial transcript)

**Source:** YouTube educational video transcript. Tutorial content; not a research paper.

---

## 5 Key Computational Insights

1. **Surprisal must be additive:** combining independent events adds surprise while multiplying probability — this forces the log(1/p) form. No other function satisfies both requirements simultaneously.

2. **Entropy is average surprisal:** H(P) = Σ P(x) log(1/P(x)) — expected surprise under the true distribution. Measures inherent uncertainty, not model error.

3. **Cross-entropy separates sources of surprise:** H(P,Q) decomposes into irreducible uncertainty H(P) and reducible model mismatch KL(P‖Q). This decomposition identifies what a model can improve versus what is irreducibly hard about the data.

4. **Cross-entropy minimization ≡ KL (Kullback-Leibler) minimization:** H(P) is constant w.r.t. model parameters, so both objectives select the same optimal model Q. Code uses cross-entropy; theory frames it as KL (Kullback-Leibler) — they are equivalent for optimization.

5. **Cross-entropy is asymmetric:** swapping P and Q can dramatically change the value (tutorial example: H=0.7 vs H=2.3 for reversed coin assumptions). The direction of divergence determines which model failures are penalized most heavily.

## Limitations

Tutorial aimed at a general ML audience. Does not address variational inference, the free energy principle formulation, or mode-seeking vs. mean-seeking behavior of different KL (Kullback-Leibler) directions. The FEP (Free Energy Principle) is mentioned in passing only (line 47–48).

## Links

- [[wiki/concepts/information-theory.md]]
