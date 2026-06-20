---
title: "Metalearning and Neuromodulation — Doya, Neural Networks 2002"
type: paper
tags: [neuromodulation, dopamine, serotonin, noradrenaline, acetylcholine, reinforcement-learning, metalearning, basal-ganglia]
created: 2026-06-19
updated: 2026-06-19
sources: [Metalearning_and_Neuromodulation]
related: [wiki/concepts/neuromodulation.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/predictive-coding.md, wiki/entities/hippocampal-entorhinal-system.md]
---

# Metalearning and Neuromodulation

**Citation:** Doya, K. (2002). Metalearning and neuromodulation. *Neural Networks*, 15(4–6), 495–506.

---

## Key Computational Insights

- **One-to-one RL metaparameter mapping:** DA → TD error δ; 5-HT → discount factor γ; NA → inverse temperature β; ACh → learning rate α. Neuromodulators carry parameter values, not content signals, enabling global coordination of distributed learning.
- **Basal ganglia as actor-critic RL machine:** Striatum (patch/matrix compartments) = critic/actor; SNc/VTA dopaminergic neurons = TD error signal; cortico-striatal synapses implement TD-weighted plasticity. DA-dependent reversal of plasticity direction (Reynolds & Wickens 2001) is the cellular substrate of the TD weight update rule.
- **ACh storage/retrieval switch in HC (Hasselmo & Bower 1993):** High ACh suppresses CA3→CA1 Schaffer collateral transmission and enables LEC→CA1 direct encoding (storage mode). Low ACh restores CA3 pattern completion (retrieval mode). This is the biological mechanism for the fast-M/slow-W timescale switch.
- **Noradrenaline and urgency gating:** LC neurons activate phasically in urgent/aversive situations, increasing action selection determinism (β ↑ → winner-take-all). Amphetamine (↑NA) produces stereotyped behavior — the exploitation limit.
- **Closed metalearning loop:** High DA variance → suppress 5-HT (γ ↓); high 5-HT → suppress NA (β ↓) + ACh (α ↓); extremes of V(s) → NA ↑; frequent DA sign reversals → ACh ↓ (delta-bar-delta). The system self-tunes toward stable, patient, focused learning as uncertainty decreases.

## Limitations

- Theory is centered on basal ganglia; cortical and cerebellar neuromodulatory roles are mentioned but not formally derived.
- Serotonin evidence is weakest: DA/5-HT interactions are bidirectional and receptor-subtype-dependent; Daw et al. (2002) propose an alternative (5-HT = average reward) that is not definitively excluded.
- Discrete MDP formulation; continuous-time extensions needed for cortical dynamics.

## Links to Wiki Pages

- [[wiki/concepts/neuromodulation.md]] — full concept page: four-neuromodulator theory, equations, interactions
- [[wiki/concepts/two-learning-timescales.md]] — ACh storage/retrieval switch grounds the fast-M/slow-W split biologically
- [[wiki/concepts/predictive-coding.md]] — DA = TD error is the RL realization of the prediction error principle
- [[wiki/entities/hippocampal-entorhinal-system.md]] — ACh gating of HC encoding vs. retrieval modes
