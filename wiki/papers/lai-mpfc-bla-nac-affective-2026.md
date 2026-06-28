---
title: "Functional Specialization of mPFC-BLA and mPFC-NAc Pathways in Affective State Representation"
type: paper
tags: [mPFC, BLA, NAc, affective-state, calcium-imaging, anxiety, social-behavior, valence, pattern-decorrelation]
created: 2026-06-27
updated: 2026-06-27
sources: ["Functional specialization of mPFC-BLA and mPFC-NAc pathways in affective state representation.md"]
related: [wiki/entities/prefrontal-cortex.md, wiki/concepts/neuromodulation.md, wiki/concepts/pattern-separation.md, wiki/papers/jin-maren-hpc-pfc-emotion-2015.md]
---

# Functional Specialization of mPFC-BLA and mPFC-NAc Pathways in Affective State Representation

Lai et al., *eLife* 2026. doi:10.7554/elife.105528

In vivo Ca²⁺ imaging (retrograde AAV-GCaMP6m + miniscope) in female CaMKII-Cre mice tracks mPFC excitatory neurons projecting to BLA vs. NAc across open field (OFT), elevated plus maze (EPM), and social interaction tasks. The same prelimbic cortex contains interleaved functionally specialized populations differentiated by output target.

---

## Key Computational Insights

- **Projection-specific affective tuning**: mPFC→BLA neurons preferentially encode negatively-valenced states (anxiety-like: center zone, open arm exposure, aversive contexts); mPFC→NAc neurons preferentially encode positively-valenced states (exploration: sniffing; social preference). Same cortical region, opposite valence tuning by output target.
- **Population firing rates cannot distinguish pathways**: Average Ca²⁺ transient rates are statistically equivalent across pathways for all behavioral states. PCA of ensemble dynamics and center-ON subpopulation analyses are required to reveal functional specialization.
- **center-ON neurons as state-transition detectors**: Neurons selectively active on entry to the anxiogenic center zone. mPFC→BLA has a higher proportion of center-ON neurons; their activity generalizes to open arm entry in EPM. mPFC→NAc center-ON neurons additionally activate during sniffing (exploratory state), not just center entry — indicating dual positive-valence tuning.
- **Pattern decorrelation for social preference (mPFC→NAc only)**: Social preference is encoded via reduced pairwise Pearson correlation (smaller FWHM of correlation coefficient distribution) during interaction with preferred stimuli — not via firing rates. mPFC→BLA shows no such decorrelation. Authors compare mechanism to olfactory bulb separation of structurally similar odorants.
- **Complementary dual-pathway encoding**: At population level, mPFC→BLA better separates social vs. non-social stimuli; at center-ON subpopulation level, mPFC→NAc better separates them. The two pathways provide scale-dependent, complementary encoding of social information.
- **Chronic social status validates affective states**: Repeated social subordination (tube test loser) elevates corticosterone, increases anxiety-like behavior (less center time post-test), and abolishes social preference; winners show enhanced sociability index. Provides independent physiological validation that behavioral states reflect genuine internal affective conditions.

## Limitations

- All experiments in adult female mice; sex differences in mPFC-limbic circuits are documented and male replication is required.
- Findings are correlational; causal necessity of each pathway for each affective state was not tested (no pathway-specific optogenetic inhibition during tasks).
- 1-mm GRIN lens covers full prelimbic depth without layer resolution; layer-specific contributions within mPFC→BLA and mPFC→NAc populations remain unknown.

## Links

- **[[wiki/entities/prefrontal-cortex.md]]** — mPFC is the source region; projection-specific encoding extends the PFC page's account of mPFC output-target-specific functional identity
- **[[wiki/concepts/neuromodulation.md]]** — projection-specificity principle extends to cortical excitatory neurons: mPFC projection identity (BLA vs. NAc target) determines affective valence tuning, paralleling the target-circuit-specific functional diversity of neuromodulatory projections
- **[[wiki/concepts/pattern-separation.md]]** — pattern decorrelation in mPFC→NAc for social preference encoding parallels the DG (Dentate Gyrus) decorrelation mechanism but operates in PFC-projection-specific ensembles without an expansion step
- **[[wiki/papers/jin-maren-hpc-pfc-emotion-2015.md]]** — Jin & Maren 2015 established the tripartite circuit (VH → both mPFC and amygdala) and NAc as motivation convergence hub; this paper provides direct Ca²⁺ imaging evidence for what mPFC→BLA and mPFC→NAc neurons specifically encode at the ensemble level
