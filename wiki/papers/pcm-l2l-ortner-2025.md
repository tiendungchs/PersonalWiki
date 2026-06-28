---
title: "Rapid learning with phase-change memory-based in-memory computing through learning-to-learn"
type: paper
tags: [meta-learning, neuromorphic, SNN, e-prop, MAML, few-shot, eligibility-traces, PCM]
created: 2026-06-27
updated: 2026-06-27
sources: ["Rapid learning with phase-change memory-based in-memory computing through learning-to-learn"]
related: [wiki/concepts/meta-learning.md, wiki/entities/snn.md, wiki/concepts/credit-assignment.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/neuromodulation.md]
---

# Rapid learning with phase-change memory-based in-memory computing through learning-to-learn

**Ortner, Petschenig, Vasilopoulos et al. — Nature Communications, 2025**

---

- **Task 1 — MAML + CNN on PCM hardware:** Few-shot image classification (Omniglot 5-way 5-shot; CIFAR100-FS 5-way 5-shot). Meta-training in full-precision software (30K–37K outer-loop iterations). Only the last dense layer (<1% of weights) updated during 4-step inner-loop adaptation; update reduces to a simple delta rule $\Delta\theta_{lk} = \alpha(y_l^{(d)} - f_{\theta^j,l}) h_k$ — no backpropagation through the network required.
- **Task 2 — Natural e-prop + SNN on PCM hardware:** One-shot motor command learning for a real robot arm (ED-Scorbot). LSG (Learning Signal Generator) SNN receives target trajectory + clock signal; generates per-neuron learning signals $L_j^t$ that modulate trainee eligibility traces $e_{jk}^t = h_j^t \sum_{t' \le t} \gamma^{t-t'} z_i^{t'}$ to produce a single weight update: $\theta^1 = \theta - \alpha \sum_t L^t \odot e^t$. After one update the trainee SNN controls the robot to track arbitrary trajectories.
- **Hardware robustness finding:** Full-precision (32-bit) software meta-training transfers to 4-bit PCM hardware without measurable performance loss. Hardware-in-loop training and accurate hardware models are unnecessary — the few-step adaptation structure limits error accumulation.
- **Biological interpretation of loops (Discussion):** Outer meta-training = evolutionary/developmental timescale shaping neural circuits to be fast learners; inner adaptation = rapid within-lifetime task specialization; LSG = specialized brain region (e.g., VTA/LC) generating neuromodulatory learning signals; eligibility traces = synaptic tags persisting until the learning signal arrives.
- **PCM devices:** Phase-change material (Ge₂Sb₂Te₅) transitions between crystalline (high conductance) and amorphous (low conductance) phases via electrical pulses; non-volatile analog weight storage; 256×256 crossbar with 4R8T unit cells performs constant-time matrix-vector multiplication (MVM); 4-phase MVM for increased precision; 14 nm fabrication.

**Limitations:**
- Demonstrations limited to classification and motor control; no abstract reasoning evaluation.
- Outer-loop meta-training uses BPTT (non-local); only the inner-loop update is local and hardware-compatible.
- Physical crossbar size (256×256) limits network scale; CIFAR100-FS experiments required a calibrated software emulator (EM-NMHW) rather than real hardware.

**Links:** [[wiki/concepts/meta-learning.md]] · [[wiki/entities/snn.md]] · [[wiki/concepts/credit-assignment.md]] · [[wiki/concepts/two-learning-timescales.md]] · [[wiki/concepts/neuromodulation.md]]
