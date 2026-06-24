---
title: "Hebbian Theory — Wikipedia"
type: paper
tags: [hebbian-learning, synaptic-plasticity, stdp, btsp, unsupervised-learning, cell-assembly]
created: 2026-06-20
updated: 2026-06-20
sources: [Hebbian theory]
related: [wiki/concepts/hebbian-learning.md, wiki/concepts/associative-memory.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/engrams.md, wiki/concepts/pattern-separation.md]
---

# Hebbian Theory — Wikipedia

**Citation:** Donald Hebb (1949). *The Organization of Behavior*. Wiley & Sons. Wikipedia article: https://en.wikipedia.org/wiki/Hebbian_theory

---

## Key Computational Insights

1. **Hebbian rule = Hopfield storage rule:** multi-pattern Hebbian $w_{ij} = \frac{1}{p}\sum_k x_i^k x_j^k$ is identical to one-shot Hopfield learning ($W = Y^\top Y / n$); single-trial episodic storage requires no error signal or backprop.
2. **Hebbian → PCA:** weight dynamics converge to the leading eigenvector of the input correlation matrix $C = \langle \mathbf{x}\mathbf{x}^\top \rangle$; adding neurons with lateral inhibition performs full PCA — Hebbian learning is implicit unsupervised dimensionality reduction.
3. **Instability requires a constraint:** $C$ is positive-definite → weights diverge exponentially; Oja's rule (normalized updates) and BCM theory (sliding threshold) are the canonical stabilizers; SDR (Sparse Distributed Representations) sparsity (k-WTA) is the architectural solution in HC.
4. **Temporal precision (STDP / BTSP):** STDP refines Hebb's causal requirement to millisecond spike order (pre→post: LTP; post→pre: LTD); BTSP (Magee et al. 2017) extends to behavioral timescales (seconds) via dendritic plateau potentials — the correct molecular mechanism for single-shot CA1 place field acquisition.
5. **Striatal and PFC (Prefrontal Cortex) Hebbian:** striatal D1 projections show Hebbian LTP (Long-Term Potentiation) in vivo (Perrin & Venance 2019); Hebbian learning in a random PFC (Prefrontal Cortex) network reproduces mixed selectivity matching in vivo data (Lindsay et al. 2017).

---

## Limitations

- Does not specify rules for inhibitory synapses, anti-causal spike sequences, heterosynaptic plasticity, or homeostatic scaling — all require non-Hebbian extensions.
- The PCA derivation assumes a linear neuron; biological nonlinearities change the dynamics but do not eliminate eigenvector convergence.

---

**Relevant concept pages:** [[wiki/concepts/hebbian-learning.md]] · [[wiki/concepts/associative-memory.md]] · [[wiki/concepts/two-learning-timescales.md]] · [[wiki/concepts/engrams.md]] · [[wiki/concepts/pattern-separation.md]]
