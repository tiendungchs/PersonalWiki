---
title: "Improving the Adaptive and Continuous Learning Capabilities of Artificial Neural Networks: Lessons from Multi-Neuromodulatory Dynamics — Mei et al. 2025"
type: paper
tags: [neuromodulation, continual-learning, catastrophic-forgetting, spiking-neural-networks, three-factor-learning, meta-learning]
created: 2026-06-24
updated: 2026-06-24
sources: [Improving the adaptive and continuous learning capabilities of artificial neural networks Lessons from multi-neuromodulatory dynamics]
related: [wiki/concepts/neuromodulation.md, wiki/concepts/continual-learning.md, wiki/entities/snn.md, wiki/concepts/meta-learning.md, wiki/concepts/hebbian-learning.md]
---

# Improving the Adaptive and Continuous Learning Capabilities of ANNs: Lessons from Multi-Neuromodulatory Dynamics

Mei, Rodriguez-Garcia, Takeuchi, Wainstein, Hubig, Mohsenzadeh & Ramaswamy. arXiv 2501.06762v3, 2025.

---

- The Doya 2002 one-to-one neuromodulator → metaparameter mapping is an oversimplification; neuromodulators interact via **modulatory** (one changes the other's release), **convergent** (overlapping effects on the same task), and **opponent** (opposing effects) relationships — a single cognitive task is co-modulated by multiple systems simultaneously ("many-to-one" principle).
- Neuromodulators function as **attractor topology controllers**: they stabilize task-relevant attractor basins, reshape basins when task demands change, and trigger inter-basin transitions; NA (Noradrenaline / Norepinephrine) specifically flattens the loss landscape on contingency shift, enabling exploration between attractors before a new basin stabilizes.
- Neuromodulation implements the **three-factor learning rule** `Δw = F(M, pre, post)` where M is the global modulatory third factor; Dopamine (reward/surprise) is most studied; NA (Noradrenaline / Norepinephrine) (surprise/novelty) is an underexplored third factor now implemented in SNN learning rules via eligibility traces that bridge the temporal gap between fast synaptic events and slow global modulation.
- The coexistence of **ionotropic** (fast, channel-opening: 5-HT₃, nAChR) and **metabotropic** (slow, second-messenger: all Dopamine receptors, all NA (Noradrenaline / Norepinephrine) receptors, most 5-HT, muscarinic ACh) receptor pathways allows neural networks to operate across multiple timescales simultaneously — a multi-timescale capacity that ANNs currently only approximate via fast gating (LSTM forget gate); the slow metabotropic path (gene expression, long-term excitability changes) has no ANN analog.
- **Projection-specificity** is a key missing dimension: ACh from the basal forebrain (BF) differentially shapes emotional learning (BF→amygdala), spatial memory (BF→dHC), and cue encoding (BF→mPFC); a single global ACh signal cannot implement these distinct effects — modular architectures with subnetwork-specific modulatory signals are required.
- Conceptual SNN Go/No-Go demo: **DA-only learning fails after a set-shift** (stimulus-reward contingency change) because the loss landscape is trapped at the old optimum; **DA+NA co-modulation** recovers by having an LC-inspired predictive module detect the contingency change and release a phasic NA (Noradrenaline / Norepinephrine) burst that transiently increases action entropy H(A|C), enabling exploration and rapid adaptation to the new contingency.

**Limitations:** No standard benchmark evaluation; conceptual SNN demo is illustrative only. Multi-neuromodulatory parameter space is large and context-dependent, making principled training objectives unclear. Projection-specific and metabotropic effects have no ANN implementation at scale.

---

- **[[wiki/concepts/neuromodulation.md]]** — extends Doya's one-to-one metaparameter account to many-to-one: neuromodulatory interactions (modulatory, convergent, opponent) and attractor landscape control are the missing dimensions.
- **[[wiki/concepts/continual-learning.md]]** — neuromodulatory plasticity gating (synaptic tagging, LC network-reset, three-factor rule) are the biological continual learning mechanisms complementing CLS/EWC/SDR approaches.
- **[[wiki/entities/snn.md]]** — the DA+NA SNN demo uses R-STDP + LC-inspired NA (Noradrenaline / Norepinephrine) burst; SNNs are the natural substrate for integrating multi-timescale neuromodulatory signals.
- **[[wiki/concepts/meta-learning.md]]** — the slow outer loop (DA-driven weight updates) and fast inner loop (recurrent dynamics) are one instantiation of the multi-neuromodulatory CL framework; Dopamine dual role (plasticity + activity) extends naturally here.
