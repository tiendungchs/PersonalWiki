---
title: "Real-Time Computing Without Stable States — Maass, Natschläger & Markram 2002"
type: paper
tags: [liquid-state-machine, reservoir-computing, fading-memory, dynamic-synapses, computational-universality, spiking-networks, separation-property]
created: 2026-06-23
updated: 2026-06-23
sources: [maass-lsm-2002]
related: [wiki/entities/reservoir-computing.md, wiki/concepts/working-memory.md, wiki/concepts/temporal-coding.md, wiki/entities/snn.md, wiki/papers/reservoir-computing-transcript.md, wiki/papers/maass-snn-third-gen-1997.md]
---

# Real-Time Computing Without Stable States: A New Framework for Neural Computation Based on Perturbations

**Maass, Natschläger & Markram. *Neural Computation* 14, 2531–2560 (2002). Founding paper of the Liquid State Machine (LSM) framework — one of two co-founding papers of reservoir computing alongside Jaeger (2001, Echo State Networks).**

---

- **Theorem 1: universal computation without task-specific circuits.** Via Stone-Weierstrass, any time-invariant filter with fading memory can be approximated to arbitrary precision by an LSM, provided the liquid satisfies the **Separation Property (SP)** and the readout class satisfies the **Approximation Property (AP)**. The circuit itself never needs to be constructed for the task — only the readout is trained. This is the formal proof that generic evolved or "found" recurrent circuitry suffices.

- **SP and AP as the complete design specification.** SP: the liquid must map distinct input histories to distinguishable states — depends on circuit heterogeneity, dynamic synaptic time constants, and connectivity structure (optimal λ is intermediate: local-dense + sparse long-range; too global → quasi-chaos; too sparse → no memory). AP: the readout must approximate any continuous function on compact sets — satisfied by perceptron pools (Stone-Weierstrass). The theorem is tight: only fading-memory filters are approximable, making SP+AP a necessary and sufficient characterization.

- **Dynamic synapses (Tsodyks-Markram) are the actual fading memory.** Replacing short-term plastic synapses (depression + facilitation, τ_D/τ_F ~ 0.05–1.1s) with static synapses collapses recoverable memory from ~800ms to ~30ms (one membrane time constant). The synapse — not the spike or membrane state — is the temporal memory store; each new spike is processed differently depending on the context set by preceding spikes. This makes short-term synaptic plasticity a computational requirement, not an optimization.

- **Readout equivalence classes: stable output from unstable dynamics.** Readout neurons learn to collapse high-dimensional transient liquid states onto task-relevant equivalence classes. The liquid state never repeats, yet readout outputs are stable and nearly constant when input class is constant (Figure 9). Mechanism: dimensionality reduction from N-dimensional state space to 1-dimensional output forces equivalence classes; the result is that these equivalences are task-meaningful, not arbitrary. This is the formal proof that stable output does not require stable internal states.

- **Parallel multitasking is structurally native.** Six simultaneously trained readout modules (rate integration, pattern detection, coincidence counting, etc.) perform completely different real-time computations on the same liquid without interference. Possible because the liquid is not trained for any task — multiple readouts define independent projection axes through the same state space.

---

**Limitations:** recoverable memory is bounded by the echo-state timescale (ρ → 1 → chaos); in-liquid plasticity for SP development is acknowledged but not formalized; results are on single canonical microcircuit columns, not scaled to multi-area hierarchies; Theorem 1 covers only time-invariant fading-memory filters — non-stationary environments require re-justification.

- [[wiki/entities/reservoir-computing.md]] — SP/AP formalism; dynamic synapses; readout equivalence classes; parallel multitasking; universality theorem
- [[wiki/concepts/working-memory.md]] — readout equivalence mechanism as formal proof that transient dynamics suffice for stable WM output
- [[wiki/entities/snn.md]] — LSM as the universal computational framework for spiking recurrent circuits
