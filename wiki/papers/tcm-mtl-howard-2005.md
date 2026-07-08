---
title: "The Temporal Context Model in Spatial Navigation and Relational Learning (Howard, Fotedar, Datey & Hasselmo 2005)"
type: paper
tags: [temporal-context, medial-temporal-lobe, entorhinal-cortex, relational-memory, transitive-inference, place-cells, leaky-integrator]
created: 2026-07-03
updated: 2026-07-03
sources: [tcm-mtl-howard-2005]
related: [wiki/concepts/temporal-context.md, wiki/concepts/successor-representation.md, wiki/concepts/path-integration.md, wiki/concepts/prospective-coding.md, wiki/concepts/structural-generalization.md, wiki/entities/tem-model.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md]
---

# TCM & MTL Function (Howard, Fotedar, Datey & Hasselmo 2005)

**Citation:** Howard, M. W., Fotedar, M. S., Datey, A. V., & Hasselmo, M. E. (2005). The temporal context model in spatial navigation and relational learning: Toward a common explanation of medial temporal lobe function across domains. *Psychological Review*, 112(1), 75–116.

The conceptual ancestor of TEM and the successor representation: a single leaky-integrator equation for temporal context is shown to unify **episodic recall**, **spatial navigation** (entorhinal place code), and **relational memory** (transitive inference) — three previously separate theories of MTL function.

---

## Key Computational Insights

- **One equation for temporal context:** `t_i = ρ_i·t_{i-1} + β·t_iᴵᴺ` with `‖t_i‖ = 1` (Eq. 6). A leaky, self-normalizing integrator of item-driven inputs `t_iᴵᴺ`. Context is the *sole cue* for episodic recall; item-to-item associations are never stored directly — they are mediated through context.
- **Place code = leaky path integration of velocity.** Feeding velocity vectors (head-direction × speed) as `t_iᴵᴺ` reproduces the entorhinal place code: noisy large fields, topological consistency across enclosures, and history-dependence (retrospective/trajectory/prospective coding on the W-maze). The integration constant ρ interpolates: ρ=0 → pure head-direction, ρ=1 → perfect path integrator, **intermediate ρ → trajectory code** (the only regime that yields retrospective coding). A leaky "pseudo-integrator" is *better* than a perfect one for disambiguating episodes at the same location.
- **Hippocampus = new item-to-context binding (α_N).** Two-component retrieved context (Eq. 9): old input `t_Aᴵᴺ` (asymmetric, forward-only) + reinstated prior context `t_A` (symmetric). "Lesion" = setting α_N→0 selectively abolishes backward + transitive associations while sparing forward pairwise ones — matching Bunsey & Eichenbaum (1996) hippocampal-lesion data.
- **"Memory space" — emergent latent structure.** New item-to-context learning gradually mixes item representations so `tᴵᴺ` similarity comes to reflect *distance in the latent higher-order structure* (double-function list A→B→C→D→E→F). Transitive inference emerges from a similarity gradient, not logic. Confirmed physiologically by Miyashita (1988) pair-coding / temporal-context cells in area TE, abolished by rhinal lesion.
- **Cellular grounding:** EC layer V integrator cells with graded persistent firing (Egorov et al. 2002) implement the integrator; activity-dependent divisive gain (Chance et al. 2002) implements the ρ normalization; presubicular head-direction input supplies the velocity signal.

## Limitations

- The pseudo-integrator is a *systematically imperfect* representation of Euclidean space — precise metric navigation requires added mechanism (predates the 2005 grid-cell discovery; no account of hexagonal periodicity).
- Purely associative account of "transitive inference" — provides a similarity gradient, not genuine logical inference; prospective coding is fragile and requires unmodeled HC→EC feedback.
- Assumes a pre-existing head-direction attractor as given input; no structure discovery from raw sensory data.

## Informs

- [[wiki/concepts/temporal-context.md]] — dedicated concept page for the contextual-drift mechanism
- [[wiki/concepts/successor-representation.md]] — TCM is the temporal-precursor from which SR and TEM descend
- [[wiki/concepts/path-integration.md]] — leaky vs. perfect integrator; the ρ knob
- [[wiki/concepts/prospective-coding.md]] — retrospective/trajectory/prospective EC coding
- [[wiki/entities/tem-model.md]] — the Tolman-Eichenbaum lineage
- [[wiki/entities/place-cells.md]] — history-dependent pseudo-place code
