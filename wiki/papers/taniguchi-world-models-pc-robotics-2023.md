---
title: "World Models and Predictive Coding for Cognitive and Developmental Robotics: Frontiers and Challenges"
type: paper
tags: [world-models, predictive-coding, active-inference, free-energy-principle, robotics, neuro-symbolic, cognitive-architecture]
created: 2026-06-24
updated: 2026-06-24
sources: [taniguchi-world-models-pc-robotics-2023]
related: [wiki/concepts/world-models.md, wiki/concepts/predictive-coding.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/entities/jepa-model.md]
---

# World Models and Predictive Coding for Cognitive and Developmental Robotics

**Citation:** Taniguchi T, Murata S, Suzuki M, et al. (2023). *Advanced Robotics*, 37(13), 892–912. doi:10.1080/01691864.2023.2225232

---

## Key Computational Insights

- **World model = SSM under FEP.** The SSM training objective (maximize ELBO over sensorimotor sequences) is formally identical to minimizing variational free energy F = −ELBO. Dreamer/PlaNet and FEP (Free Energy Principle) active inference are the same optimization viewed from ML vs. neuroscience perspectives. The latent state-space model `p(z_{t+1}|z_t, a_t), p(x_t|z_t)` is the FEP (Free Energy Principle) generative model with action conditioning.

- **Expected free energy resolves exploration-exploitation.** Policy selection via expected G(π) = epistemic value (expected KL (Kullback-Leibler) between observation-conditioned and prior latent distributions, driving uncertainty reduction) + pragmatic value (preference-matching to desired outcome distribution C). This formal decomposition shows exploration and exploitation are not competing objectives but two terms of a single variational objective — no separate intrinsic motivation mechanism needed.

- **Active inference vs. Control as Inference (CaI).** CaI introduces binary optimality variable O ∈ {0,1}: p(O=1|s,a) ∝ exp(r/T); maximizing its ELBO yields entropy-regularized RL. Active inference uses preference-priors C instead. **Key difference:** CaI separates reward r(s,a) from the observation generative model; active inference encodes all goals as prior beliefs, requiring no explicit reward function — potentially more flexible for abstract goal specification.

- **Planning horizon dilemma (named explicitly).** Transition errors accumulate over T rollout steps, making long-horizon plans unreliable. Three partial solutions: (a) latent RSSM transitions avoiding pixel generation, (b) value function gradients through multi-step world model simulations (DreamerV2), (c) goal-conditioned latent inverse dynamics learning. None fully resolves the horizon problem for abstract reasoning tasks.

- **Neuro-symbolic bottom-up symbol discovery.** Binary bottleneck autoencoders trained on (image, action) → pixel-effect produce discrete object symbols that cluster by affordance. Decision tree distillation extracts probabilistic PDDL rules from the neural effect predictor. This is the bottom-up path to a discrete action/state vocabulary — complementary to LAPA's top-down VQ-VAE approach; neither has been demonstrated on non-physical abstract transformations.

---

## Limitations

- Survey scope is cognitive/developmental robotics; abstract reasoning (ARC-AGI-type tasks) is not discussed; all neuro-symbolic examples are physical manipulation environments. It is unresolved whether the identified challenges (planning horizon, symbol discovery, policy coupling) apply in the same form to abstract transformation spaces.
- Policy coupling debate (entangled vs. decoupled π/WM) is identified but not resolved; the paper advocates investigation without prescribing an answer.

---

## Links

- [[wiki/concepts/world-models.md]] — planning horizon dilemma formalized here; NewtonianVAE and DayDreamer added as robot instantiations
- [[wiki/concepts/predictive-coding.md]] — expected free energy G(π) decomposition; CaI vs. active inference distinction; Gap 6 formalism now explicit
- [[wiki/concepts/abstract-reasoning.md]] — neuro-symbolic symbol discovery via affordance clustering is a partial bottom-up path to discrete abstract vocabulary
- [[wiki/concepts/compositional-generalization.md]] — binary bottleneck affordance symbols relate to compositionality; neither approach reaches cross-environment generalization
- [[wiki/entities/jepa-model.md]] — Mode-2 (CEM-based MPC) is the non-probabilistic analog of active inference's G(π) minimization; this paper clarifies the formal relationship
