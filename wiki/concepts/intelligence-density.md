---
title: "Intelligence Density"
type: concept
tags: [intelligence, kolmogorov-complexity, generalization, memorization, measurement, algorithmic-information-theory]
created: 2026-06-23
updated: 2026-06-23
sources: [choi-intelligence-density-2026]
related: [wiki/concepts/information-theory.md, wiki/concepts/abstract-reasoning.md, wiki/entities/arc-agi.md, wiki/papers/hutter-aixi-2000.md, wiki/papers/arc-agi-overview.md, wiki/papers/choi-intelligence-density-2026.md]
---

# Intelligence Density

**$\mathcal{I}(S) = \log_2 N(S) / C(S)$ — ratio of informational output diversity to system description length; a substrate-independent measure that formally separates memorisation ($\mathcal{I}(n) \to 0$) from knowing ($\mathcal{I}(n) \to \infty$).**

---

## Key Equations

**Intelligence Density:**
$$\mathcal{I}(S) = \frac{\log_2 N(S)}{C(S)}$$
- $N(S)$: number of mutually Kolmogorov-independent outputs the system can produce
- $C(S)$: total description length of the system in bits

**Independent Outputs:** $o_1, o_2$ are independent if:
$$K(o_1 \mid o_2) \approx K(o_1) \quad \text{and} \quad K(o_2 \mid o_1) \approx K(o_2)$$
Neither output can be predicted from the other by a program shorter than the output itself.

**Knowing a Domain:** $S$ *knows* domain $D$ when $C(S)$ stays finite as $n \to \infty$ while $\mathcal{I}(S,n) \to \infty$.

---

## Four-Way Taxonomy

| System | $C(S)$ | $\log_2 N$ | $\mathcal{I}$ scaling | Status |
|--------|---------|-----------|----------------------|--------|
| Rock / river | $> 0$ | $\approx 0$ | $\approx 0$ | No computation |
| Lookup table ($n$ entries) | $\Theta(n)$ | $\Theta(n)$ | $\to 0$ | **Memorisation** |
| $n$-bit adder family (one circuit per $n$) | $O(n)$ | $\Theta(n)$ | $\Theta(1)$ | Computation without knowing |
| Multiplication algorithm | $O(1)$ | $\Theta(n)$ | $\to \infty$ | **Knows** |
| LLM / human brain (multi-domain) | $O(1)$ | diverges | $\to \infty$ | **Knows** |

---

## Worked Examples

**Multiplication algorithm** ($C \approx 667$ bits, fixed):
$$\mathcal{I}(n) \approx \frac{6.6n}{667} \to \infty \quad \checkmark$$

**Block's Blockhead** (lookup table, vocabulary $V = 10^4$, conversation length $L$):
$$C > V^L \gg 10^{400} \text{ bits for } L=100; \quad \mathcal{I}(L) \to 0 \quad \times$$

**Multi-domain coverage** (log-additive independence):
$$\log_2 N_\text{total} = \sum_i \log_2 N_i$$
A system covering $k$ independent domains accumulates $N$ equal to the product of per-domain capacities.

---

## Architectural Implication for Reasoning Models

| Architecture | $\mathcal{I}$ scaling | Why |
|---|---|---|
| Feedforward (fixed depth) | $\Theta(1)$ | Computation depth bounded → domain bounded |
| Recurrent / iterative | Can achieve $\to \infty$ | Depth scales with problem size → unbounded domain |

Recurrence (or iteration) is the minimal architectural condition for knowing. Feedforward networks, regardless of width or depth, are provably bounded to $\mathcal{I} = \Theta(1)$.

---

## Open Problems

- **Graded independence:** Definition 2 is binary; a continuous version based on $K(o_1 \mid o_2)/K(o_1)$ is needed for empirical measurement of real systems
- **Exact $N(n)$ for LLMs:** qualitative result ($\mathcal{I} \to \infty$) is clear; precise growth rate as sentence length scales is an open empirical question
- **Understanding vs. knowing:** $\mathcal{I}$ measures whether outputs generalise across a domain; it does not capture whether the system can construct algorithms for *genuinely novel* domains (meta-generalisation)

---

## Connections

- **[[wiki/concepts/information-theory.md]]** — $\mathcal{I}$ is the dual of Kolmogorov complexity $K$ ($K$: output → program; $\mathcal{I}$: program → output diversity) and the inverse of MDL; the uniform/non-uniform computation dichotomy in complexity theory maps exactly onto $\mathcal{I} \to \infty$ vs. $\mathcal{I} = \Theta(1)$
- **[[wiki/concepts/abstract-reasoning.md]]** — $\mathcal{I}(n) \to \infty$ as domain scales is a formal sufficient criterion for abstract reasoning; the feedforward/recurrent architectural divide maps onto $\mathcal{I} = \Theta(1)$ (bounded) vs. $\mathcal{I} \to \infty$ (knowing)
- **[[wiki/entities/arc-agi.md]]** — Chollet's skill-acquisition efficiency and $\mathcal{I}$ share the core generalisation-not-memorisation insight; Proposition 2 unifies Legg-Hutter $\Upsilon$, Chollet's measure, and $\mathcal{I}$ under a common monotonicity relationship
- **[[wiki/papers/hutter-aixi-2000.md]]** — Legg-Hutter $\Upsilon(\pi)$ is monotonically increasing in $\mathcal{I}(\pi)$ (Proposition 2); AIXI (AI with (X) induction (I)) performs expectimax over the same Kolmogorov prior that underlies the independence weights in $\mathcal{I}$
- **[[wiki/papers/arc-agi-overview.md]]** — Chollet 2019 operationalises intelligence as skill-acquisition efficiency over novel tasks; $\mathcal{I}$ provides the substrate-independent formal grounding for this criterion without requiring task or reward specification
