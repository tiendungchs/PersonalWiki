---
title: "Contextual inference underlies the learning of sensorimotor repertoires — Heald, Lengyel & Wolpert 2021"
type: paper
tags: [contextual-inference, motor-learning, nonparametric-bayes, action-semantics, vocabulary-co-discovery, two-learning-timescales]
created: 2026-07-17
updated: 2026-07-17
sources: [Contextual inference underlies the learning of sensorimotor repertoires]
related: [wiki/concepts/contextual-inference.md, wiki/concepts/arbitrary-mapping.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/memory-schemas.md, wiki/concepts/working-memory.md, wiki/concepts/neural-manifolds.md, wiki/queries/action-semantics-contextual-inference.md, wiki/architectural-gaps.md]
---

# Contextual inference underlies the learning of sensorimotor repertoires

Heald, J.B., Lengyel, M. & Wolpert, D.M. (2021). *Nature* 600(7889):489–493. doi:10.1038/s41586-021-04129-3. Code: github.com/jamesheald/COIN. n=40 participants (vBOT force-field reaching); COIN = COntextual INference.

Full treatment in [[wiki/concepts/contextual-inference.md]].

## Key computational insights

- **One computation controls memory creation, expression, and updating: inferring which context is active.** Memory is a repertoire of context-specific models, not one model per task.
- **Proper vs. apparent learning** — the paper's central distinction. Behaviour can change by *updating* memories (proper) or purely by changing *how much existing memories are expressed* (apparent). Apparent learning requires no weight change at all.
- **Savings, anterograde interference, and environmental-consistency effects are apparent, not proper.** Cross-validated simulations (parameters fit to their own experiments, applied parameter-free to three other labs' paradigms) show Kalman gain and inferred state are *unchanged* across conditions; only the context posterior differs. Classic "learning rate" findings are re-read as expression changes.
- **All memories update, scaled by responsibility** — not winner-take-all. Confirmed by graded single-trial learning under engineered cue/feedback conflict (cue *F*₁,₂₃=10.35, p=3.8×10⁻³; perturbation *F*₁,₂₃=21.16, p=1.3×10⁻⁴; no interaction).
- **Novel prediction confirmed: evoked recovery.** Two P⁺ "evoker" trials produce strong recovery that decays to a *non-zero* asymptote — beating dual-rate and multi-rate models, which predict exponential decay to baseline (Δ group-level BIC 394.1 nats).
- **Memory creation is triggered by abruptness, not magnitude.** A gradually introduced perturbation creates no new memory; the old one is stretched to absorb it — explaining slower deadaptation after gradual training.
- **Working memory maintains context responsibilities** (not states): a WM task after counter-exposure abolishes spontaneous recovery, resetting predicted probabilities to stationary values.

## Limitations

Scalar state, single effector, force-field/visuomotor reaching only — the "contexts" are perturbation regimes, far simpler than an operator repertoire. Inference is particle-based and offline-expensive; no claim to neural implementation (the neural bases are left as future work). Parameter recovery is *partial* — α and ρ recover poorly; the authors explicitly make no claims about individual parameters, only model class. γ and γᵉ (the Dirichlet-process concentrations that set the effective number of contexts — the false-split/false-merge dial) were **fixed at 0.1 by hand, not fit**. Contexts are inferred from prior experience: the model selects within a repertoire and grows it by instantiation, but never invents an operator outside its generative family.
