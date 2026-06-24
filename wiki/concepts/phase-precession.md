---
title: "Phase Precession"
type: concept
tags: [phase-precession, theta-oscillations, temporal-coding, grid-cells, place-cells, sequence-learning, STDP, cann]
created: 2026-06-21
updated: 2026-06-22
sources: [spiking-tem-kawahara-2025, acann-li-2024]
related: [wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/hebbian-learning.md, wiki/concepts/neuromodulation.md, wiki/concepts/path-integration.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/temporal-coding.md, wiki/papers/spiking-tem-kawahara-2025.md, wiki/papers/gerstner-temporal-coding-1996.md, wiki/concepts/ring-attractor.md, wiki/papers/acann-li-chu-wu-2024.md]
---

# Phase Precession

**The spike timing of a place cell or grid cell advances systematically to earlier phases of the ongoing theta oscillation (4–8 Hz) as an animal traverses the cell's firing field — encoding sequential position within a temporal frame independently of firing rate.**

---

## Key Formalism

**Phase-position relationship:**
$$\theta(x) \approx \theta_0 - \beta \cdot x$$

where $x$ is position within the firing field, $\beta \in [0.2, 0.6]$ rad/position bin (SpikingTEM classification: |slope| ≤ 0.2 = phase-locked; 0.2–0.6 = phase-precessing; ≥ 0.6 = phase-independent).

**Temporal compression:** a sequence of $N$ positions traversed in $T$ seconds is compressed into one theta cycle (~125 ms), with cells firing in spatial order from late to early phase.

**STDP consequence:** if cell A fires before cell B within the ~20 ms STDP window, $w_{AB}$ increases — so the temporal ordering induced by phase precession within each cycle teaches forward transition weights without any explicit temporal credit assignment signal.

---

## Evidence / Instantiations

| Source | System | Key finding |
|---|---|---|
| O'Keefe & Recce 1993 | Rat CA1 place cells | Phase advances systematically across field; first documentation |
| Hafting et al. 2008 | Rat MEC grid cells | Phase precession in EC (Entorhinal Cortex) is hippocampus-independent — an intrinsic MEC computation |
| SpikingTEM (Kawahara 2025) | MECII model neurons | Emergent from neuromodulatory gain G + LIF (Leaky Integrate-and-Fire) dynamics without explicit oscillatory interference |

---

## Mechanism Debate

Three biological accounts, all plausible:

| Account | Core mechanism | Status |
|---|---|---|
| **Oscillatory interference** (Burgess 2007) | Multiple VCOs at slightly different frequencies interfere to produce traveling phase | Dominant theoretical model; VCO cells found in MEC |
| **Somatic-dendritic** | Intrinsic somatic theta + faster dendritic oscillation cancel/reinforce to shift phase | Plausible; supported by LFP/intracellular data |
| **Attractor dynamics** | Asymmetric forward connections push activity bump forward each half-cycle | Explains grid-cell phase precession without per-cell VCOs |
| **A-CANN oscillatory tracking** (Li et al. 2024) | Hopf bifurcation at intermediate SFA (Spike Frequency Adaptation) strength drives limit-cycle bump oscillations at ω ∝ √(αk(1+m)/ττ_v) | Analytic; tunable to theta band; directly produces both precession (forward sweep) and procession (backward sweep) |

SpikingTEM provides a **fourth** account: neuromodulatory gain G (no explicit oscillatory interference) is sufficient for phase precession to emerge in learned grid cells. This suggests the phenomenon may be mechanism-agnostic — achievable by any spiking dynamics that amplify temporal asymmetry. A-CANN oscillatory tracking provides a **fifth** account via bifurcation dynamics: at intermediate adaptation strength in a CANN, a Hopf bifurcation produces limit-cycle sweeps with analytically derived frequency; both forward and backward sweeps are predicted, matching the co-occurrence of precession and procession observed in hippocampal place cells.

---

## MECII / MECIII Dissociation (Kawahara 2025)

| Module | Neuromod condition | Temporal mode | Functional interpretation |
|---|---|---|---|
| **MECII** | G on + theta_MECIII on | Phase-precessing (80.2%) | Current + look-ahead state encoder |
| **MECIII** | G on + theta_MECIII on | Phase-locked (86.7%) | Predicted next-state (t+1) encoder |
| Both | G on, theta_MECIII off | Phase-precessing | Full look-ahead mode |
| Both | G off, theta_MECIII on | Phase-locked | Stable reference mode |

G enables phase advance; theta_MECIII inhibition enforces a stable phase reference. Together they produce the biological MECII/MECIII split observed experimentally (Hafting et al. 2008).

---

## For Building a Reasoning Model

- Phase precession sequences abstract state representations in a temporal frame — enabling STDP to learn causal forward-transition weights from a single pass through a sequence, without global temporal credit assignment.
- The theta compression scheme is a biologically plausible "look-ahead" mechanism: within each 125 ms cycle, the network encodes the ordered sequence of the next ~1–2 seconds of expected states.
- The MECII (precessing, current+lookahead) vs. MECIII (locked, prediction target) dissociation is a biological implementation of the current-state encoder / predicted-state decoder split in TEM's generative and inference models. A reasoning model should separate these two representations.

---

## Open Problems

- Whether phase precession generalizes from spatial sequences to abstract state sequences in relational reasoning tasks.
- The relative contribution of oscillatory interference vs. attractor dynamics vs. neuromodulation; SpikingTEM shows G is sufficient but doesn't rule out the others.
- How phase precession interacts with replay and SWRs to extend look-ahead beyond one theta cycle to multi-step planning.

---

## Connections

- **[[wiki/entities/grid-cells.md]]** — phase precession is a key temporal coding property of MEC grid cells; MECIII predictive grid cells are the fixed-phase complement.
- **[[wiki/entities/place-cells.md]]** — phase precession was first characterized in CA1 place cells (O'Keefe & Recce 1993) before it was found in grid cells.
- **[[wiki/concepts/hebbian-learning.md]]** — STDP + phase precession jointly learn forward transition weights: the temporal ordering imposed by precession within each theta cycle places pre-synaptic activity before post-synaptic activity for sequential cells, directly potentiating forward edges.
- **[[wiki/concepts/neuromodulation.md]]** — neuromodulatory gain G is the sufficient condition for phase precession in SpikingTEM; theta inhibitory input controls whether MECIII locks rather than precesses — neuromodulation governs temporal coding mode, not just learning rate.
- **[[wiki/concepts/path-integration.md]]** — phase precession gives the path integrator a look-ahead: cells fire in order of upcoming positions within each theta cycle, providing a prospective code for the next few steps of the trajectory.
- **[[wiki/concepts/two-learning-timescales.md]]** — the STDP consequence of phase precession (forward edge potentiation per theta cycle) is a fast-M write operating at millisecond timescale; the compressed temporal ordering within one cycle is the unit of slow structural extraction.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — the theta oscillation that drives phase precession is the same oscillation that creates the encoding/retrieval sub-phase alternation; both temporal coding phenomena are expressions of theta-phase organization.
- **[[wiki/papers/spiking-tem-kawahara-2025.md]]** — primary source for the emergent phase precession result and the neuromodulation-controlled MECII/MECIII dissociation.
- **[[wiki/concepts/temporal-coding.md]]** — phase precession is the spatial-navigation instance of temporal coding: the systematic phase advance within each theta cycle is a temporal code for sequential position that STDP converts into causal forward edges; the coherent convergence principle (Gerstner 1996) applies when multiple phase-locked place cells drive a downstream target within a theta cycle.
- **[[wiki/papers/gerstner-temporal-coding-1996.md]]** — the precision paradox resolved by coherent convergence (auditory system) is structurally analogous to theta-phase coding: in both cases, multiple inputs sharing a temporal phase drive downstream spike timing to finer resolution than any individual neuron's time constant.
- **[[wiki/concepts/ring-attractor.md]]** — A-CANN oscillatory tracking (Li et al. 2024) is a Hopf bifurcation in the CANN framework that directly produces theta-band sweeps and the forward/backward bump oscillations underlying phase precession and procession; ring-attractor dynamics are the mechanistic substrate.
- **[[wiki/papers/acann-li-chu-wu-2024.md]]** — primary source for the oscillatory tracking account of phase precession; provides the analytic frequency formula ω ∝ √(αk(1+m)/ττ_v) and the Hopf bifurcation stability conditions.
