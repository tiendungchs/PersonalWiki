---
title: "Empirical Tensions"
type: overview
tags: [tensions]
created: 2026-06-22
updated: 2026-06-24
sources: []
related: [wiki/overview.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/entities/arc-agi.md, wiki/entities/gwt-model.md]
---

## Empirical Tensions

Read at the start of every digest. Update when new tensions surface.

Active tensions between sources. This table is the sole home for contradiction tracking — individual pages carry the factual content as prose, not blockquotes.

| Tension | Pages | Status |
|---------|-------|--------|
| **DA = precision (Friston 2009) vs. Dopamine = TD (Temporal Difference) error (Doya 2002)** — Friston places Dopamine in the prior-precision tier; Doya places it as the reward prediction error signal; partial reconciliation via incentive salience | [[wiki/concepts/neuromodulation.md]], [[wiki/papers/friston-free-energy-2009.md]], [[wiki/papers/metalearning-neuromodulation-doya-2002.md]] | Partially reconciled; not resolved |
| **GNW offset ignition absent (Ferrante 2025)** — preregistered adversarial collaboration finds no PFC (Prefrontal Cortex) offset ignition at content transitions; GNW (Global Neuronal Workspace) prediction fails causal test; settled framing: hub handles entry not exit | [[wiki/entities/gwt-model.md]], [[wiki/papers/ferrante-adversarial-gnwt-iit-2025.md]] | Settled framing adopted; design gap #7 open |
| **CA3 connectivity (Sammons 2023: ~10% vs. Guzman 2016: <1%)** — 10× discrepancy attributed to species/preparation; Sammons is the working estimate; motif enrichment unnecessary at 10% | [[wiki/concepts/associative-memory.md]], [[wiki/papers/ca3-sammons-2023.md]] | Working estimate adopted; needs independent replication |
| **PFC consciousness role** — iES null result (Raccah 2021) and content-specificity dissociation (Ferrante 2025) both challenge GNW's constitutive claim; settled framing: PFC (Prefrontal Cortex) enables but does not constitute conscious access, encodes category not perceptual detail | [[wiki/entities/prefrontal-cortex.md]], [[wiki/entities/gwt-model.md]] | Settled framing adopted; design gap #8 open |
| **Accuracy vs. abstraction on ARC (textual overestimates, visual underestimates)** — Beger et al. 2025 show that output-grid accuracy is directionally misleading: AI models solve ConceptARC textual tasks via shortcuts ~27-29% of the time (vs. ~5% humans), inflating apparent abstraction; in visual modality, perceptual failures cause models to produce incorrect grids despite forming correct-intended rules (~28% of wrong-grid cases), deflating apparent abstraction. Standard ARC-Prize evaluation (accuracy only) conflates these two error types and cannot distinguish shortcut from genuine concept acquisition. | [[wiki/entities/arc-agi.md]], [[wiki/concepts/abstract-reasoning.md]], [[wiki/papers/beger-conceptarc-multimodal-2025.md]] | Methodological tension; dual-channel evaluation (accuracy + rule quality) is the proposed resolution |