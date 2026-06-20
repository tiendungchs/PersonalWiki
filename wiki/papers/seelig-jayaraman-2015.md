---
title: "Neural dynamics for landmark orientation and angular path integration (Seelig & Jayaraman, Nature 2015)"
type: paper
tags: [ring-attractor, central-complex, path-integration, landmark-orientation, drosophila, head-direction]
created: 2026-06-13
updated: 2026-06-13
sources: [landmark-orientation]
related: [wiki/concepts/ring-attractor.md, wiki/concepts/path-integration.md, wiki/concepts/convergent-allocentric-coding.md, wiki/entities/insect-central-complex.md, wiki/papers/turner-evans-neuron-2020.md]
---

# Neural dynamics for landmark orientation and angular path integration

Seelig JD, Jayaraman V. *Nature*. 2015 May 14;521(7551):186–191. Janelia Research Campus, HHMI.

## Key Computational Insights

- **Ring attractor confirmed in vivo:** EBw.s neurons (~16 wedge-selective groups in the ellipsoid body) form a single localized activity bump that rotates as the fly turns — the first direct in-animal observation of a ring attractor operating in a behaving animal. Bump position decoded by population vector average (PVA); mean bump width ≈ 82° FWHM.
- **Allocentric, not retinotopic:** in complex multi-feature visual scenes, the EB still shows a single narrow bump (not an expanded map); PVA correlates with fly heading (r ≈ 0.97), not with individual feature positions — confirming true allocentric orientation encoding.
- **Landmark dominance over self-motion:** abrupt cue shifts drive the bump to follow landmark position with high fidelity (N=50 shifts, r=0.85, slope=0.78); gain-manipulation experiments show visual cue gain ≈ 1, walking-rotation gain varies with closed-loop gain → landmark input is dominant.
- **Path integration in darkness:** bump tracks walking rotation in total darkness via self-motion cues alone; PVA accuracy degrades over time (accumulating drift), consistent with integrating noisy velocity signals without corrective feedback.
- **Persistent activity:** bump maintained for >30 seconds when fly stands still in complete darkness — two orders of magnitude longer than calcium sensor decay — demonstrating true attractor network dynamics. Bump resumes from the same wedge after standing (r=0.7, slope=0.96 across 499 events).

## Limitations

- Only rotational (angular) path integration characterized; how translational motion is incorporated into full 2D position estimation is unknown.
- GCaMP6f temporal resolution (~141 ms rise, ~380 ms decay) insufficient to distinguish predicted-future vs. current-orientation encoding.
- Functional connectivity inferred from dynamics; synaptic-level wiring characterized subsequently by Turner-Evans et al. 2020.
- Data from tethered walking flies in virtual reality; translates to freely navigating animals with some uncertainty.

## Relevant Pages

- [[wiki/concepts/ring-attractor.md]] — full ring attractor formalism; this paper is the primary empirical confirmation
- [[wiki/concepts/path-integration.md]] — CX P-EN path integration adds direct in vivo evidence alongside CANN/VCO/SR accounts
- [[wiki/entities/insect-central-complex.md]] — CX anatomy; E-PG and P-EN neuron architecture; all quantitative results cited here
- [[wiki/papers/turner-evans-neuron-2020.md]] — anatomical follow-up characterizing the synaptic circuit
