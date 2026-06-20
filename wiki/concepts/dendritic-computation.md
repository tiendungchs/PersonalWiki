---
title: "Dendritic Computation"
type: concept
tags: [dendritic-computation, NMDA, active-dendrites, coincidence-detection, binding-problem]
created: 2026-06-20
updated: 2026-06-20
sources: [ahmad-hawkins-sdr-2016, gerfen-surmeier-dopamine-striatum-2011]
related: [wiki/concepts/sparse-distributed-representations.md, wiki/concepts/binding-problem.md, wiki/entities/basal-ganglia.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/two-learning-timescales.md]
---

# Dendritic Computation

**Dendritic computation is the use of sub-threshold nonlinear integration in dendritic branches — particularly N-Methyl-D-Aspartate (NMDA)-receptor-dependent plateau potentials — to implement coincidence detection, local binding, and gating independently of somatic firing.**

---

## NMDA Spike Mechanism

Each pyramidal neuron has 100+ independent dendritic segments. A segment fires an NMDA plateau potential when 8–20 co-localized synapses (within 20–300 µm, synchronized within 1–5 ms) become co-active:

$$\mathbf{D} \cdot \mathbf{A}_t \geq \theta \quad (\theta_\text{opt} \approx 9\text{–}20)$$

This is a **threshold-logic coincidence detector** operating entirely locally — the soma need not fire, and the segment's output is independent of other dendritic compartments. Each neuron thus contains >100 independent pattern detectors. False positive probability for typical SDR parameters ($n=10{,}000$, $a=300$, $s=30$, $\theta=12$): $P(\text{FP}) \approx 10^{-27}$ (Ahmad & Hawkins 2016).

---

## Instantiations

| System | Dendritic mechanism | Computation | Reasoning-model implication |
|---|---|---|---|
| **Neocortical pyramidal neuron** | NMDA spike from 8–20 co-localized synapses | >100 independent coincidence detectors per neuron | Single-neuron capacity ≫ linear integration models; enables one-shot feature binding |
| **DG granule cell (BTSP)** | EC-instructed dendritic plateau potential (behavioral timescale) | One-shot place field acquisition via dendritic depolarization | Fast-M episodic write occurs at the dendritic level, not the soma |
| **Striatal SPN (up-state gating)** | Convergent Glu input overcomes Kir2 to reach up-state; D1/D2 modulate the threshold | Coincidence-gated action selection | Credit assignment requires convergence detection at dendrite, not max-firing |
| **CA3 pyramidal cell** | NMDA-dependent Hebbian LTP on recurrent collaterals | Pattern completion via attractor dynamics | Associative memory write is a local dendritic event; theta-phase timing regulates write window |

---

## Application to Building a Reasoning Model

- **Local binding without a global serializer:** NMDA spike binding (8–20 synapses) is the biological implementation of the conjunctive code `p = f(g, x)` — role-filler binding occurs at the dendritic segment without requiring global attention.
- **Scalable coincidence detection:** Because each segment operates independently, the same neuron can detect hundreds of distinct patterns simultaneously — architecturally equivalent to multi-head attention with a hard threshold rather than softmax.
- **Active gating (BG):** SPN up-state bistability means that action selection is hardware-level coincidence detection, not winner-take-all activation. Artificial BG blocks should replicate convergence gating, not scalar threshold selection.

---

## Open Problems

1. How to implement NMDA spike dynamics in differentiable ML models without sacrificing trainability.
2. How active dendritic segments interact with global attention mechanisms — do they operate in parallel or in competition?
3. Whether dendritic branches implement learned routing (i.e., do the 8–20 synapses per segment self-organize via local Hebbian rules or require a global error signal)?

---

## Connections

- **[[wiki/concepts/sparse-distributed-representations.md]]** — NMDA spike coincidence detection is only reliable when presynaptic populations are sparse and high-dimensional; SDR scaling laws explain why dendritic binding requires the neocortical sparse coding regime.
- **[[wiki/concepts/binding-problem.md]]** — local dendritic NMDA spikes are the binding mechanism for local feature conjunctions; the binding table in that page lists this as the "local dendritic binding" row.
- **[[wiki/entities/basal-ganglia.md]]** — SPN up-state bistability is a dendritic computation: Kir2 K⁺ channels block transition to up-state until convergent Glu input overcomes them; D1/D2 receptors modulate the convergence threshold in opposite directions via their distinct downstream cascades.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — BTSP uses EC-instructed dendritic plateau potentials in CA1 to write one-shot place fields; the EC input is the instructive signal that depolarizes the dendrite to the plateau threshold during a behavioral event.
- **[[wiki/concepts/two-learning-timescales.md]]** — BTSP (single-shot, seconds timescale) vs. STDP (many-shot, milliseconds timescale) are two dendritic plasticity rules that together span the fast-M timescale; both operate at dendritic synapses, not the soma.
