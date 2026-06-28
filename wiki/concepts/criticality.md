---
title: "Criticality"
type: concept
tags: [criticality, bifurcation, resting-state-networks, metastability, stochastic-resonance, neural-avalanche, edge-of-chaos, noise]
created: 2026-06-26
updated: 2026-06-28
sources: [deco-resting-state-2011, cabral-kringelbach-deco-2014, li-yap-mechanistic-connectome-2022, vohryzek-2024-lr-connections]
related:
  - wiki/concepts/neural-field-theory.md
  - wiki/concepts/excitation-inhibition-balance.md
  - wiki/concepts/small-world-networks.md
  - wiki/entities/default-mode-network.md
  - wiki/concepts/energy-based-models.md
  - wiki/concepts/ring-attractor.md
  - wiki/concepts/cortical-traveling-waves.md
  - wiki/papers/deco-resting-state-2011.md
  - wiki/papers/vohryzek-2024-lr-connections.md
  - wiki/papers/koller-2024-connectome-traveling-waves.md
  - wiki/concepts/network-integration-segregation.md
  - wiki/concepts/temporal-multiplexing.md
---

# Criticality

**A dynamical operating regime at the boundary between ordered (stable attractor) and disordered (chaotic/oscillatory) dynamics, where the system achieves maximum sensitivity to inputs, maximum dynamic range, and the richest repertoire of reachable states.**

---

## Formalisms

| Formalism | Expression | Interpretation |
|---|---|---|
| Hopf proximity | Re(λ_max) → 0 | Eigenvalue of Jacobian approaches imaginary axis; marginal stability |
| Branching ratio | σ = 1 | Mean secondary activations per primary event; σ < 1 = subcritical, σ > 1 = supercritical |
| Power-law avalanches | P(s) ~ s^{−3/2}, P(t) ~ t^{−2} | Neural avalanche size/duration distributions at criticality (Beggs & Plenz 2003) |
| 1/f BOLD spectrum | S(f) ~ f^{−β}, β ≈ 1 | Macroscopic signature of near-critical dynamics; β > 1 under anesthesia/sleep |
| Stochastic resonance | σ* = argmax SNR(σ) | Optimal noise amplitude drives transitions between multistable states; noise is constructive near the critical point |

---

## Evidence Across Scales

| Scale | Observation | Control parameter |
|---|---|---|
| Local cortex | Power-law neural avalanche size/duration in rat cortex (Beggs & Plenz 2003) | Branching ratio σ |
| Whole-brain model | RSNs emerge *only* near the critical line; anticorrelations collapse farther from criticality (Deco et al. 2011) | Coupling strength / transmission velocity |
| Resting fMRI | 1/f BOLD power spectrum; long-range temporal correlations | E/I (Excitation-Inhibition) balance |
| Whole-brain spiking model | Optimal FC fit at edge of bifurcation to multistable ghost-attractor regime; attractor landscape entropy peaks at this working point (Deco 2013, Cabral et al. 2014) | Global coupling W |
| Anesthesia | Subcritical shift: β > 1 (steeper spectrum), loss of RSN coherence | Propofol/sevoflurane reduces net excitatory gain κ |
| BNM whole-brain | Brain is **maximally** metastable — repertoire of transient states peaks exactly at the bifurcation boundary (Cabral 2014; Kringelbach 2015); maximum metastability produces "critical slowing down" explaining deliberation slowness | Global coupling *G* / metastability maximum |

---

## Structural Prerequisite: Rare Long-Range Connections

Near-critical dynamics require more than a generic small-world topology. Vohryzek et al. 2024 show that **rare long-range (LR) connections** — ~3 SD above the mean weight for distances >40 mm — are the specific structural substrate for the long-range spatial correlations that define criticality:

- EDR+LR harmonic modes reconstruct long-range functional connectivity (FC > 0.5, distance > 40 mm) significantly better than geometry-only or EDR-only modes ($p < 10^{-4}$).
- Brain dynamics lie on a low-dimensional manifold of ~20 EDR+LR modes — consistent with near-critical operation where a small number of slow, long-range modes dominate dynamics.
- Shuffling the spatial locations of LR connections eliminates this advantage, confirming that criticality depends on the *specific topology* of rare LR connections, not just their existence.

The paper explicitly links rare LR structural connections to "time-critical information processing," and evolutionary pressure is hypothesized to have refined EDR connectivity with LR exceptions to enable complex cognition — with disruption in Alzheimer's and schizophrenia as the predicted failure mode.

**Design implication:** Criticality is not achievable through uniform connectivity; it requires a topology where specific LR shortcuts link otherwise geometrically isolated regions, sustaining the long-range spatial correlations (power-law decay) that define the critical regime.

---

## RSN Emergence from Criticality

Six independent model families (Deco 2011, Cabral 2014) all show criticality as a *necessary condition* for RSN formation:

- **Model 2 (Ghosh):** Must operate near the critical line; too far from criticality → noise-driven oscillations suppressed → no coherent RSNs
- **Model 3 (Deco):** Wilson-Cowan nodes near Hopf bifurcation; stochastic resonance at v ≈ 1.65 m/s drives transitions between two cluster-synchronization states → anticorrelated RSN pairs at optimal noise
- **Unifying:** "the stochasticity can express itself only if the deterministic framework of the network is critical" — criticality is the structural prerequisite; noise is the fuel; anatomical connectivity is the landscape
- **Kuramoto (Cabral 2011):** Gamma-frequency phase oscillators near incoherence-synchrony boundary; metastable synchronization of structural modules → slow BOLD fluctuations matching empirical FC; criticality = border between incoherence and synchrony
- **Ghost attractor scenario (Deco 2013):** Spiking IF attractor network at the edge of bifurcation from stable low-activity state to multistable regime. Below the bifurcation, ghost basins of latent attractors warp the energy landscape — RSNs are transiently visited without becoming stable fixed points. Attractor landscape entropy H = −Σ p(i) log p(i) is maximized exactly at this working point. Best empirical FC fit obtained here across coupling strengths.
- **Asynchronous linearization (Fokker-Planck):** Even in the no-oscillation scenario (stable asynchronous state), RSNs emerge from noise-driven rate fluctuations structured by anatomical coupling — but only when coupling k is near the destabilization threshold.

**Cross-model verdict:** The specific node dynamics (chaotic, oscillatory, asynchronous) matter less than proximity to the bifurcation. Working point relative to the critical line is the universal control parameter.

DMN hub nodes are the critical anchors: they are the key constituents that move the whole-brain system toward the metastable near-critical state.

---

## Maximally Metastable Brain and Critical Slowing Down

BNM analysis (Cabral et al. 2014; Kringelbach et al. 2015) reveals the brain is not merely near-critical but **maximally metastable** — global coupling *G* is tuned to the point where the reachable state repertoire is maximized:

- **Maximum metastability:** departure in either direction (sub- or supercritical) reduces the number of distinguishable transient network states
- **Critical slowing down:** at the metastability maximum, the network lingers in transition dynamics before committing to a new state; this is the mechanistic basis of deliberation slowness during higher cognition — not a bug but the cost of exhaustive state-space exploration
- **Probabilistic metastable substates (PMS; Deco et al. 2019):** each brain state is a distribution over metastable substates characterized by stability probability and occurrence frequency; whole-brain BNM can predict optimal stimulation targets to force PMS transitions (e.g., deep sleep → wakefulness; aged → middle-aged brain state)

**Design implication:** An architecture at maximum metastability gains the widest dynamic repertoire but deliberates slowly. Tuning the global gain *G* (or per-module E/I or neuromodulatory κ) down from the maximum speeds up processing but narrows the state repertoire — operationalizing the System 1 / System 2 mode axis.

---

## Fluidity as Operational Criticality Proxy

**Fluidity** = variability of explored FC states over time, measured as FCD (functional connectivity dynamics) variance. VBT modeling operationalizes criticality through the working point where (Jirsa et al. 2025):

| Signature | Mechanism |
|---|---|
| FCD variance maximized | Brain explores widest FC configuration repertoire; metastability at peak |
| Responsiveness to perturbation peaked | Same G that maximizes fluidity also maximizes PCI under TMS |
| Intrinsic dimensionality minimized | SC breaks symmetry across nodes, concentrating dynamics in low-D subspace |
| Structural–dynamic balance | Network influence and local NMM dynamics balanced; neither dominates |

**Anesthesia validation:** resting-state fluidity under propofol, xenon, and ketamine separates consciousness states as effectively as active TMS perturbation (perturbational complexity index). This equivalence holds specifically at the near-critical working point — unperturbed critical dynamics encode the same discriminative information as explicit probing.

**Design implication:** FCD variance is a model-selection criterion. A recurrent architecture at the right G should self-organize near maximum FCD variance at rest — too low G freezes FC; too high G chaotifies it. The critical window is narrow and must be maintained by homeostatic gain regulation, not fixed at initialization.

---

## Computational Advantages for Reasoning

| Advantage | Mechanism |
|---|---|
| Maximum sensitivity | Marginally stable systems amplify weak perturbations to large responses |
| Maximum state repertoire | Near-critical systems reach a wider range of activity patterns than sub- or supercritical systems |
| Long-range correlations | Autocorrelations decay as power laws, not exponentials → context integration across timescales |
| Constructive noise | At the critical point, noise drives useful state transitions (exploration) rather than degrading signal |
| Flexible switching | Near-bifurcation → small change in κ or E/I switches between attractor regimes without architectural redesign |

**Design implication:** A reasoning architecture with a tunable gain κ (or per-module E/I ratio) held near its bifurcation threshold by homeostatic regulation gains a "free" dynamic repertoire — multiple functional states within the same architectural skeleton — matching the biological observation that the same anatomical connectivity supports many distinct RSNs.

---

## Open Problems

1. Is criticality global or local? Evidence suggests heterogeneous criticality — DMN near-critical at rest; sensory areas subcritical; tasks may transiently shift regions away from criticality.
2. Does task performance move the brain away from criticality, or does it redistribute criticality across regions?
3. Can artificial systems achieve self-organized criticality (SOC) through local learning rules (STDP, synaptic homeostasis) without explicit parameter tuning?

---

## Connections

- **[[wiki/concepts/neural-field-theory.md]]** — the critical line (Re(λ) = 0) in neural field stability diagrams is the formal definition of the critical point; Hopf bifurcation is the specific transition marking oscillatory criticality; neural field theory provides the mathematical framework for analyzing criticality in spatially extended cortical models.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — E/I ratio is the primary control parameter for criticality; balanced E/I places the circuit at the critical point; Deco 2011 Model 3's near-Hopf working point is precisely the E/I-balanced critical regime; the E/I–FC monotonic relationship (Schirner et al. 2023) implies resting-state FC tracks proximity to the critical line.
- **[[wiki/concepts/small-world-networks.md]]** — small-world topology (local clustering + long-range shortcuts with transmission delays) is the structural prerequisite for critical-regime RSN dynamics; hub shortcuts set the delays and inter-module coupling strengths that determine where the system sits relative to the critical line.
- **[[wiki/entities/default-mode-network.md]]** — DMN hub nodes are the critical anchors that hold the whole-brain system near its metastable near-critical state; the "dynamic repertoire" explored at rest is anchored by DMN hub connectivity; task-driven DMN suppression corresponds to a local shift away from criticality in hub nodes.
- **[[wiki/concepts/energy-based-models.md]]** — the energy landscape near criticality has shallow basins separated by low barriers; this corresponds to a near-flat EBM energy surface where small noise drives state transitions; criticality is the EBM operating point that maximizes dynamic range without collapse to a single dominant energy minimum.
- **[[wiki/concepts/ring-attractor.md]]** — ring attractors operate near the bifurcation between static-bump and traveling-wave modes (controlled by adaptation strength m in A-CANN); this is a local instance of criticality; the continuous attractor manifold is maintained by operating near, but not past, the Hopf threshold for spontaneous rotation.
- **[[wiki/papers/deco-resting-state-2011.md]]** — primary source establishing criticality as the necessary condition for RSN emergence across three converging computational models.
- **[[wiki/papers/cabral-kringelbach-deco-2014.md]]** — extends the convergence evidence to six model families; introduces the ghost attractor scenario (spiking model, Deco 2013) and the Kuramoto near-incoherence criticality; also provides EEG/MEG frequency-specific signatures of RSNs.
- **[[wiki/papers/vohryzek-2024-lr-connections.md]]** — identifies rare LR connections (3 SD above mean, >40 mm) as the specific structural substrate for long-range spatial correlations defining criticality; EDR+LR harmonic modes reconstruct these correlations with only ~20 modes, consistent with near-critical low-dimensional dynamics; shuffling LR locations destroys this, confirming topology specificity matters.
- **[[wiki/concepts/cortical-traveling-waves.md]]** — instrength-directed traveling waves emerge specifically in the near-critical metastable regime; Koller 2024 shows that models achieving best resting-state MEG FC fit simultaneously produce directed waves and smooth EF gradients, linking traveling wave structure to the critically-tuned operating point.
- **[[wiki/papers/koller-2024-connectome-traveling-waves.md]]** — empirical demonstration that instrength-directed waves coordinate resting-state MEG functional connectivity; best-fitting models operate in the same near-critical parameter regime where metastability is maximized.
- **[[wiki/concepts/network-integration-segregation.md]]** — the integration/segregation toggle is a discrete two-basin instantiation of the near-critical metastable repertoire: integrated and segregated states are the two most probable energy basins; near-critical global coupling G determines how easily the LC-NA phasic burst can shift the system from one basin to the other; too subcritical locks the system in one mode.
- **[[wiki/concepts/temporal-multiplexing.md]]** — near-critical metastability is the operating regime that enables a large repertoire of transient ICN co-activation states; temporal multiplexing requires this regime to prevent any single frequency stream from locking the whole system into a fixed attractor; the 126-blueprint combinatorial state space is the metastable repertoire mapped onto ICN combinations.
