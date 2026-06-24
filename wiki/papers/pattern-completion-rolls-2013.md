---
title: "Pattern Completion and Pattern Separation in the Hippocampus — Rolls 2013"
type: paper
tags: [hippocampus, pattern-completion, pattern-separation, CA3, dentate-gyrus, autoassociation, attractor]
created: 2026-06-20
updated: 2026-06-20
sources: [The mechanisms for pattern completion and pattern separation in the hippocampus]
related: [wiki/concepts/associative-memory.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/place-cells.md, wiki/entities/grid-cells.md, wiki/concepts/neuromodulation.md, wiki/papers/ca3-sammons-2023.md]
---

# Pattern Completion and Pattern Separation in the Hippocampus — Rolls 2013

**Rolls ET (2013). Front Syst Neurosci 7:74. PMC3812781.**

- **CA3 storage capacity formula:** p_max ≈ k × C_RC / a (k ≈ 0.2–0.3), where C_RC is RC synapses per CA3 neuron (~12,000 rat; dilution 12,000 / 300,000 = 4%) and a is population sparseness. For a = 0.02, p_max ≈ 36,000 memories. Heterosynaptic LTD (Long-Term Depression) is required alongside LTP (Long-Term Potentiation) to enable overwriting of old patterns and prevent capacity overflow.
- **Diluted connectivity is adaptive (non-obvious):** Full CA3-CA3 connectivity would cause multiple synapses between neuron pairs, which dominate attractor basins and catastrophically reduce memory capacity. Dilution (~4% rat; ~9-11% Sammons 2023 mouse) prevents multiple synapses while keeping C_RC ≈ 12,000 per neuron — the quantity that sets capacity. Diluted connectivity also reduces spiking noise via larger neuron populations (300,000 CA3 neurons in rat).
- **Five DG (Dentate Gyrus) pattern separation mechanisms:** (1) Mossy fiber randomization: ~46 MF synapses per CA3 cell forces maximally different, random CA3 representations per episode regardless of input similarity; (2) Sparse DG (Dentate Gyrus) firing via inhibitory competition; (3) DG (Dentate Gyrus) expansion recoding: 10⁶ DG (Dentate Gyrus) → 3×10⁵ CA3 via competitive learning decorrelates entorhinal inputs; (4) Sparse CA3 representation (a ≈ 0.33 macaque); (5) Adult neurogenesis provides novel MF connections for new patterns without disturbing existing CA3 attractors.
- **DG transforms grid cells → place cells:** Hebbian competitive learning in DG (Dentate Gyrus) converts combinations of co-active MEC grid cells into sparse place-like fields. Feed-forward connections without competitive learning produce broad overlapping receptive fields that fail to support episodic binding. In primates, the identical mechanism produces *spatial view cells* (fovea subtends ~10-20° → view-patch specificity rather than body-location specificity).
- **Anatomical encoding/recall separation:** Mossy fibers (~46, strong, soma-proximal) dominate CA3 during *storage*, overriding RC dynamics to force a new random representation. Perforant path (~3,600, weaker) initiates *recall* from a partial cue; RC attractor then completes the full memory. Selective mossy fiber lesions impair new learning without impairing recall of existing memories (Lassalle et al.; Lee & Kesner). Structural complement to the ACh switch: ACh suppresses CA3→CA3 RC efficacy during encoding, amplifying the already-dominant mossy fiber input.

## Limitations

- Quantitative predictions (e.g., 36,000 memories) validated in simulation; behavioral experiments rarely load the hippocampus to theoretical capacity, making direct tests difficult.
- Connectivity estimates (~4% rat) extrapolated from older anatomical data (Amaral & Witter 1989); Sammons 2023 (mouse, EM (Expectation Maximization) + patch-clamp) gives direct empirical rates at 9-11%.
- Temporal order memory theory (Section 6) remains speculative in mechanistic detail; CA1 vs. CA3 substrate for temporal pattern separation is unresolved.

## Links

- [[wiki/concepts/associative-memory.md]] — p_max formula, five DG (Dentate Gyrus) separation mechanisms, dilution rationale, encoding/recall anatomical separation
- [[wiki/entities/hippocampal-entorhinal-system.md]] — DG (Dentate Gyrus) competitive learning, grid→place transformation, mossy fiber/perforant path roles
- [[wiki/entities/place-cells.md]] — DG→place cell formation mechanism from grid cell inputs
- [[wiki/entities/grid-cells.md]] — upstream input to DG (Dentate Gyrus) competitive learning for place field formation
- [[wiki/concepts/neuromodulation.md]] — ACh as neuromodulatory complement to structural mossy fiber dominance during encoding
- [[wiki/papers/ca3-sammons-2023.md]] — empirical connectivity data (9-11%) that Rolls 2013 theoretical framework helps explain
