---
title: "A Survey: Learning Embodied Intelligence from Physical Simulators and World Models"
type: paper
tags: [world-models, embodied-ai, robotics, survey, planning, hierarchical-wm]
created: 2026-06-24
updated: 2026-06-24
sources: [A Survey Learning Embodied Intelligence from Physical Simulators and World Models]
related: [wiki/concepts/world-models.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/compositional-generalization.md]
---

# A Survey: Learning Embodied Intelligence from Physical Simulators and World Models

Long et al. 2025. *A Survey: Learning Embodied Intelligence from Physical Simulators and World Models.* arXiv:2507.00917.

- **Three-way world model taxonomy**: robotics WMs partition into (a) Neural Simulators — generate perceptually realistic synthetic trajectories for policy training (WhALE, RoboDreamer, EnerVerse); (b) Dynamics Models — learn state transition p(s_{t+1}|s_t, a_t) for imagination-based planning (Dreamer series, V-JEPA 2-AC, HWM); (c) Reward Models — estimate reward from observation sequences when environment reward is sparse (VIPER, Vista). Cleaner functional framing than generative vs. representation-space for applied settings.
- **Independent convergence on hierarchical WMs**: HWM, PIVOT-R, and OSVI-WM independently arrive at multi-level predictors with learned sub-goal representations as the primary solution to long-horizon planning failure. Three independent papers converging on the same architecture is strong evidence that hierarchical decomposition is the correct structural answer to the planning horizon dilemma.
- **Cross-hardware generalization trend**: DWL, Surfer, and SSWM train single dynamics models across heterogeneous robot embodiments; preliminary evidence that structural transition dynamics are hardware-agnostic, with only the low-level motor mapping being embodiment-specific.
- **Unified WMs for policy generalization**: EnerVerse-AC and FlowDreamer demonstrate that high-fidelity neural simulators with action conditioning can replace physical simulators for policy training, with zero-shot transfer to real hardware — supporting the view that a well-trained world model collapses the sim-to-real gap.
- **§6.3 challenges map directly to wiki open problems**: causal reasoning vs. correlation learning (Gap 1, latent edge inference); compositional generalization and abstraction (compositional-generalization.md open problems); memory architecture and long-term dependencies (planning horizon dilemma in world-models.md); abstract and semantic understanding (abstract-reasoning.md).

**Limitations:** ~450 papers surveyed at breadth, not depth; robotics and physical-simulator specific throughout; no formal theory of generalization or transfer; autonomous driving section (§6.1) irrelevant to abstract reasoning; simulator hardware comparisons (§4) are purely engineering.

---

- **[[wiki/concepts/world-models.md]]** — primary concept page; this survey adds the three-way taxonomy and new model entries (EnerVerse, HWM, MoDem-V2) to the instantiations table.
- **[[wiki/concepts/hierarchical-representations.md]]** — HWM, PIVOT-R, and OSVI-WM instantiate multi-level hierarchical representations for long-horizon planning; independent embodied-domain convergence evidence for Gap 2.
- **[[wiki/concepts/compositional-generalization.md]]** — §6.3 explicitly identifies compositional generalization as an unsolved open problem across all current robotics world models.
