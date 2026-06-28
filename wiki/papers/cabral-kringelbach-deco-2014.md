---
title: "Cabral, Kringelbach & Deco (2014) — Exploring Resting-State Network Dynamics"
type: paper
tags: [resting-state-networks, criticality, metastability, ghost-attractors, neural-mass, small-world-networks, structural-connectivity, default-mode-network]
created: 2026-06-26
updated: 2026-06-26
sources: [cabral-kringelbach-deco-2014]
related:
  - wiki/concepts/criticality.md
  - wiki/concepts/small-world-networks.md
  - wiki/concepts/excitation-inhibition-balance.md
  - wiki/concepts/neural-field-theory.md
  - wiki/entities/default-mode-network.md
  - wiki/entities/fcann.md
  - wiki/papers/deco-resting-state-2011.md
---

# Cabral, Kringelbach & Deco (2014) — Exploring the Network Dynamics Underlying Brain Activity during Rest

**Cabral J, Kringelbach ML, Deco G (2014). Progress in Neurobiology, 114, 102–131.**

---

## Key Computational Insights

- **Ghost attractor hypothesis:** The spiking attractor network model (Deco et al. 2013) shows that optimal empirical FC fit occurs at the edge of a bifurcation between a stable low-activity state and a multistable regime. In this regime RSNs are "ghost" attractors — subcritical states whose basins warp the energy landscape without being fully stable fixed points. Resting-state activity = noise-driven transient excursions into ghost attractor basins, not full stabilization. Entropy of the attractor landscape is maximized exactly at this critical working point.
- **Cross-model convergence on criticality:** Five independent model families — conductance-based biophysical (Honey 2007), FitzHugh–Nagumo (Ghosh 2008), Wilson–Cowan (Deco 2009), Kuramoto phase oscillators (Cabral 2011), spiking IF attractor networks (Deco 2013), and Fokker–Planck asynchronous linearization — all reproduce empirical resting-state FC *only* near criticality. The specific node model matters less than proximity to the bifurcation.
- **Structural disconnection models disease:** Simulated decrease of global coupling W reproduces the schizophrenia resting-state signature: network reorganization with increased efficiency/hierarchy but decreased small-worldness, lower clustering coefficient, and narrower degree distribution — matching empirical graph-theory findings from patient data.
- **Frequency-specific spatial hubs (MEG):** Power envelope correlations in MEG identify distinct hubs by frequency band: theta (4–6 Hz) hubs in medial temporal lobe; alpha/beta (8–32 Hz) hubs in lateral parietal cortex; gamma (32–45 Hz) hubs in sensorimotor areas. RSNs are not frequency-neutral; each operates in its characteristic band.
- **Non-stationarity gap:** Existing models optimize averaged FC matrices, implicitly assuming stationarity. RSNs transiently form and dissolve at ~0.1 Hz; models must capture time-varying connectivity profiles, not just long-time averages.
- **Balloon–Windkessel as BOLD proxy:** BOLD signal primarily reflects the very slow (<0.35 Hz) part of simulated neural activity (r = 0.9 correlation between low-pass filtered neural activity and B–W output); hemodynamic nonlinearities are secondary contributors.

---

## Limitations

- All reviewed models optimize for averaged (stationary) FC matrices; transient RSN dynamics not reproduced.
- Balloon–Windkessel parameters assumed uniform across regions and subjects; in reality they vary with age, vascular health, and pathology.
- Structural connectivity matrices exclude subcortical routes (thalamus, cerebellum) known to shape spontaneous dynamics via polysynaptic pathways.

---

## Links

- [[wiki/concepts/criticality.md]] — ghost attractor scenario and cross-model convergence strengthen the criticality-as-necessary-condition claim beyond what Deco 2011 established
- [[wiki/concepts/small-world-networks.md]] — schizophrenia/AD disruption of small-world properties modeled by decreasing coupling W; confirms functional relevance of hub topology
- [[wiki/concepts/neural-field-theory.md]] — Wilson-Cowan (Hopf boundary), FitzHugh-Nagumo, and Fokker-Planck asynchronous models are all neural mass / neural field instantiations
- [[wiki/concepts/excitation-inhibition-balance.md]] — coupling strength W in all models is the long-range excitatory coupling, directly setting the E/I regime; decreased W → schizophrenia-like FC
- [[wiki/entities/default-mode-network.md]] — DMN is the primary task-negative RSN reviewed throughout; MEG shows it correlates with beta-band power (13–30 Hz)
- [[wiki/entities/fcann.md]] — fcANN (Englert 2026) formalizes the ghost-attractor landscape; J = −Σ⁻¹ encodes the same bifurcation structure that Cabral 2014 describes via spiking model entropy
- [[wiki/papers/deco-resting-state-2011.md]] — covered Models 1-3 (Honey, Ghosh, Deco 2009); Cabral 2014 extends with Models 4-6 and adds empirical EEG/MEG signatures and the ghost-attractor scenario
