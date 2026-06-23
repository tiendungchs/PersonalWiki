---
title: "Critical Review of LeCun's Introductory JEPA Paper — Malcolm Lett 2025"
type: paper
tags: [jepa, world-models, predictive-coding, system-i-ii, energy-based-models, critique]
created: 2026-06-23
updated: 2026-06-23
sources: ["Critical review of LeCun's Introductory JEPA paper"]
related: [wiki/entities/jepa-model.md, wiki/concepts/world-models.md, wiki/concepts/predictive-coding.md, wiki/concepts/energy-based-models.md, wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md]
---

# Critical Review of LeCun's Introductory JEPA Paper — Malcolm Lett (2025)

**Malcolm Lett, Medium (2025-03-28). Reviews LeCun (2022) from a cognitive science and ML practitioner perspective. Source: https://malcolmlett.medium.com/critical-review-of-lecuns-introductory-jepa-paper-fabe5783134e**

---

## 5 Key Computational Insights

- **z encodes the relationship between x and y, not just the latent state of x.** JEPA is a "contrastive model" (siamese network) that fundamentally requires a pair of inputs. In single-input deployment, three options exist: (a) drop z entirely, (b) hand-craft z's meaning externally (I-JEPA: z = relative spatial position of masked patch), or (c) marginalize over a sample of z values for uncertainty estimation. Without a second input to define the relationship, z is undefined and JEPA degrades to a well-trained feedforward network.

- **Mode-1 and Mode-2 are both System I, not System I/II.** MPC planning (Mode-2) is "stochastically deterministic": given a fixed world model and a hard-wired search algorithm (CEM, gradient, MCTS, beam search), the same action sequence emerges deterministically. True System II requires *learning the planning/search/reasoning algorithm itself* — all three must be learned simultaneously: world model + cost function + control algorithm. The configurator is the hint toward this, but no existing JEPA implementation approaches it.

- **JEPA is not Predictive Coding.** PC operates on a single moment-to-moment sensory input and converges via hierarchical recurrent error propagation — inference does not require a second input. JEPA requires two inputs (x and y) to compute z as the relationship between them; it cannot perform the same online single-observation iterative inference. Hierarchical JEPA stacking (higher level feeds lower) also does not cleanly map to PC's top-down error feedback hierarchy; it is unclear how to make a higher-level JEPA provide the z for a lower-level one.

- **SSL/SL/RL are the same learning paradigm at the macro level.** All three collapse to a scalar training signal: SL computes loss per independent sample; RL computes loss over ordered trajectory (lower information density per step by 1/trajectory_length); SSL collapses a per-component output (e.g., per-pixel error) to a scalar loss. The only meaningful difference is *data acquisition efficiency*: SSL requires no labeling and no interaction — that is the source of its scaling advantage, not a fundamentally different optimization principle.

- **VICReg approximates per-branch mutual information maximization.** V (variance hinge) + C (off-diagonal covariance Frobenius) implement a covariance-matrix approximation of maximizing information content within each branch independently; this approximation avoids the KL-divergence computation and is tractable per batch. The per-branch independence (vs. Barlow Twins' cross-branch) is what enables multi-modal pretraining with branches of different architecture and output statistics.

---

## Limitations

- Practitioner blog post, not peer-reviewed; claims about "stochastically deterministic" System I processing and consciousness-as-stabilization are informal arguments without formal proof.
- No empirical results; critique is conceptual only.
- The System I/II re-framing is insightful but the proposed solution (learning the planning algorithm + meta-management stabilization) is not operationalized.

---

**Connects to:** [[wiki/entities/jepa-model.md]] · [[wiki/concepts/world-models.md]] · [[wiki/concepts/predictive-coding.md]] · [[wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md]]
