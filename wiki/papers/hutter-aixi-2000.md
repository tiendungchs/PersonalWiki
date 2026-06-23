---
title: "A Theory of Universal Artificial Intelligence based on Algorithmic Complexity — Hutter 2000"
type: paper
tags: [aixi, universal-intelligence, algorithmic-information-theory, solomonoff, decision-theory, kolmogorov-complexity]
created: 2026-06-21
updated: 2026-06-21
sources: [hutter-aixi-2000]
related: [wiki/concepts/information-theory.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/meta-learning.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/working-memory.md, wiki/concepts/predictive-coding.md, wiki/concepts/two-learning-timescales.md]
---

# A Theory of Universal Artificial Intelligence based on Algorithmic Complexity — Hutter 2000

**Citation:** Marcus Hutter, preprint, Munich 2000. Foundational paper introducing the AIXI model.

---

## Key Computational Insights

- **Universal prior over all computable environments.** ξ^AI(q) = 2^{-l(q)} — shorter programs receive exponentially higher prior weight. The agent acts to maximize ξ^AI-expected future credit via the expectimax algorithm over a planning horizon m_k. This replaces the unknown true environment distribution µ with a universal semimeasure ξ that provably converges to any computable µ (formally: ξ(yx_{<k}yx_k) → µ(yx_{<k}yx_k) with µ-probability 1 as k→∞).

- **Passive vs. active intelligence is a formal boundary.** Passive environments (sequence prediction, classification) — where the agent's output does not influence the data stream — admit K(µ)-bounded error bounds via Solomonoff's convergence theorems. Active environments (games, function minimization, exploration) provably do not: no µ-universal credit bound in terms of K(µ) alone exists, because the agent's output *selects* which information the environment reveals next. The compression-prediction equivalence holds only in the passive regime.

- **Exploration is a theorem, not an assumption.** The FMξ function-minimization agent is provably *inventive*: it tests infinitely many distinct actions as T→∞ without any explicit curiosity signal. Every untried action has positive ξ-probability; when expected compression gain from a new observation exceeds the known minimum, the simplicity prior forces exploration. Curiosity is a corollary of the Kolmogorov prior.

- **Horizon problem: formal counterpart of WM timescale design.** AIXI's output is acutely sensitive to planning horizon m_k. Greedy (m_k = k) fails at chess. Infinite (m_k = ∞) causes pathological defer-forever in environments with long-range dependencies (the "heaven/hell" example: one action in cycle 1 determines all future credits; no unbiased policy can avoid catastrophic loss for some µ). Factorizable µ (independent episodes — the IID assumption) is the exact class where m_k → ∞ is safe.

- **AIξ^{t̃,l̃}: computable approximation with universality guarantee.** Runs all 2^{l̃} programs of length ≤ l̃ for time ≤ t̃ per cycle; selects the best self-justified output (programs must prove a valid lower bound on their own expected credit). Computation per cycle: O(t̃ · 2^{l̃}). Main theorem: AIξ^{t̃,l̃} is effectively more intelligent (w.r.t. the ⪰^c order) than any competing algorithm with the same resource bounds. The 2^{l̃} factor is the provable cost of universality — the lower bound on program-search overhead.

---

## Limitations

- AIXI itself is uncomputable; AIξ^{t̃,l̃} has exponential overhead 2^{l̃}, impractical for realistic l̃.
- No credit bounds for active environments (proven impossibility); only K(µ)-bounded bounds exist for passive problems.
- Horizon m_k has no general solution; every active problem class (games, FM, RL) requires problem-specific horizon choice.
- Convergence of ξ→µ requires µ to be computable; non-computable or highly non-local µ may violate safety of infinite horizon.

---

## Connections

- **[[wiki/concepts/information-theory.md]]** — AIXI extends the Solomonoff predictor (passive, sequence prediction) to the active decision-making case; ξ^AI conditioned on action history; the passive/active boundary is the formal limit of the compression-prediction equivalence.
- **[[wiki/concepts/latent-graph-discovery.md]]** — AIXI maintains a mixture over all computable latent graphs (all environments); solving all four hardness sources simultaneously; uncomputable, so all feasible architectures are bounded-program approximations to it.
- **[[wiki/concepts/meta-learning.md]]** — AIXI is the theoretical ceiling of meta-learning: Solomonoff prior = ideal slow outer loop (never learned, defined by K complexity); expectimax = ideal fast inner loop (pure inference, no gradient updates).
- **[[wiki/concepts/abstract-reasoning.md]]** — AIXI provides the formal definition of general intelligence via the intelligence order relation ⪰; the three Lake et al. ingredients are engineering routes to approximating the Kolmogorov simplicity prior.
- **[[wiki/concepts/working-memory.md]]** — the horizon problem is the formal analog of WM timescale design: greedy = no WM; infinite = full credit chain; factorizable µ = the regime where STSP/attractor WM is sufficient without pathological defer.
- **[[wiki/concepts/predictive-coding.md]]** — active inference (Friston) is a local approximation of AIXI's action component: action minimizes variational free energy rather than expectimax credit, both reducing to the same behavior for passively predictable environments.
- **[[wiki/concepts/two-learning-timescales.md]]** — the W/M split approximates the AIXI Solomonoff prior (slow W) + expectimax inference (fast M); factorizable µ is the exact mathematical condition under which the two-timescale separation is lossless.
