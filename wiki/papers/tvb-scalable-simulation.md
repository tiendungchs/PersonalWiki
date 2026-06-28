---
title: "The Virtual Brain: Scalable Brain Simulation"
type: paper
tags: [brain-network-model, neural-field-theory, connectome, mean-field, resting-state, multi-scale, time-delays, simulation]
created: 2026-06-27
updated: 2026-06-27
sources: [tvb-scalable-simulation]
related:
  - wiki/concepts/neural-field-theory.md
  - wiki/concepts/criticality.md
  - wiki/concepts/cortical-traveling-waves.md
  - wiki/entities/fcann.md
---

# The Virtual Brain: Scalable Brain Simulation

The Virtual Brain (TVB) Project. https://thevirtualbrain.org/tvb/zwei/neuroscience-simulation

---

## Key Computational Insights

- **Time delays are necessary, not optional:** early neural field models approximated connectivity as homogeneous and instantaneous → produced symmetric spatiotemporal artifacts; integrating distance-dependent conduction delays (few–hundreds of ms, from DTI/DSI tractography) was the primary motivation for creating TVB; removing delays or reverting to homogeneous connectivity destroys realistic spatiotemporal dynamics
- **Local/global connectivity decomposition:** TVB separates two structurally distinct coupling types:
  - *Local* (~cm, instantaneous): spatially invariant fall-off — $\int g_\text{local}(x,x')S(\Psi(x',t))dx'$
  - *Global* (~tens of cm, delayed): heterogeneous DTI-derived weights with per-connection delay $|x-x'|/v$ — the critical missing ingredient in pre-TVB models
- **Whole-brain evolution equation (Jirsa 2009):**
  $$\dot{\Psi}(x,t) = N(\Psi) + \int_\Gamma g_\text{local}(x,x')S(\Psi(x',t))dx' + \int_\Gamma g_\text{global}\,S\!\left(\Psi\!\left(x',t-\frac{|x-x'|}{v}\right)\right)dx' + I(x,t) + \xi(x,t)$$
  $\Psi$ = neural population activity vector; $N$ = intrinsic local dynamics (neural mass model); $v$ = conduction velocity; $I$ = external stimulus; $\xi$ = noise
- **Resting state as dynamical substrate:** resting-state networks are the near-critical oscillatory foundation from which task states emerge as perturbations — not background noise but pre-organized dynamics
- **Multi-scale autonomy:** no single spatial scale dominates; upward transitions use dimension reduction (small-scale complexity averaged out); downward transitions add model detail; mutual interdependence across scales reduces computational load compared to monoscale simulation
- **Mean-field degeneracy** (Haken 1983): macroscopic dynamics obey laws independent of microscopic details — confirmed within the rate-coded / mean-field regime; breaks down when spike timing or temporal coding matters (see [[wiki/concepts/temporal-coding.md]])

---

## Limitations

- Pure rate-coded mean-field framework: no spike timing, no STDP, no temporal coding — blind to any computation that depends on precise spike patterns
- EEG/MEG forward model neglects subcortical sources; inhibitory neurons (~15%) omitted from dipole model
- Neurovascular coupling (BOLD) modeled via canonical HRF convolution — poor mechanistic consensus; alternative Balloon-Windkessel model available but not universally validated

---

## Connections

- **[[wiki/concepts/neural-field-theory.md]]** — TVB is the whole-brain implementation of the neural field PDE; the Jirsa 2009 equation concretizes the meso→macro extension with explicit DTI-based delays and local/global connectivity decomposition that the theoretical NFT page abstracts
- **[[wiki/concepts/criticality.md]]** — TVB's resting-state-as-dynamical-substrate principle is the computational motivation for criticality: the near-critical oscillatory foundation enables rapid task-state deployment from small perturbations
- **[[wiki/concepts/cortical-traveling-waves.md]]** — TVB's heterogeneous global connectivity with distance-dependent delays is the structural substrate that produces instrength-directed traveling waves; Koller 2024 uses the same DTI-weighted delayed coupling framework
- **[[wiki/entities/fcann.md]]** — both TVB and fcANN derive their coupling matrices from resting-state structural/functional connectivity; TVB uses the evolution equation to generate forward dynamics; fcANN inverts the precision matrix J = −Σ⁻¹ to extract attractor basins — complementary views of the same SC→FC relationship
