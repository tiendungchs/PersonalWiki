---
title: "Neuronal Computation Underlying Inferential Reasoning in Humans and Mice"
type: paper
tags: [hippocampus, inference, prospective-code, SWR, mnemonic-shortcut, sensory-preconditioning, cross-species]
created: 2026-06-23
updated: 2026-06-23
sources: [neuronal-computation-inferential-reasoning]
related: [wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/place-cells.md, wiki/concepts/prospective-coding.md, wiki/concepts/replay.md, wiki/concepts/associative-memory.md, wiki/concepts/latent-states.md, wiki/papers/courellis-hpc-abstract-inference-2024.md, wiki/papers/hassabis-neuroscience-ai-2017.md]
---

# Neuronal Computation Underlying Inferential Reasoning in Humans and Mice

**Citation:** Barron, H. C. et al. (Dupret lab), *Cell* 183(1): 228–243, 2020. doi:10.1016/j.cell.2020.08.035

---

## Five Key Computational Insights

- **Prospective code during inference.** When cue X is presented at test, hippocampal CA1 activity (measured via RSA in both fMRI voxels and electrophysiology ensembles) is more similar to the representation of the intermediary cue Y than to cross-set cues — i.e., CA1 "looks ahead" to the expected next element in the learned X→Y sequence. The temporal firing order of X-tuned then Y-tuned cells is preserved even though Y is absent, confirming the code reproduces the original temporal statistics of the pairing.

- **CA1 causal necessity.** Optogenetic silencing of dorsal CA1 pyramidal cells specifically during X presentation impairs inference (ArchT-GFP mice lose the set-1 reward-seeking bias) while leaving first-order conditioning intact (visual cue Y→Z performance unaffected). This causally dissociates prospective code generation from simple associative recall.

- **Division of mnemonic labor.** The hippocampus represents the intermediary cue Y during inference but **not** the inferred outcome Z. Z is represented in medial prefrontal cortex (mPFC) and dopaminergic midbrain, identified via whole-brain RSA searchlight. This requires a two-stage architecture: HC computes the look-ahead step (X→Y), downstream circuits translate that into the outcome representation (Y→Z).

- **SWR cognitive shortcuts for inferred relationships.** During awake rest between inference trials, hippocampal sharp-wave/ripples (SWRs) increasingly co-activate cell triplets (X, Y, Z) for rewarded set 1 but not neutral set 2. With experience, X-Z doublets become co-active in SWRs even in the absence of Y activity — a direct mnemonic shortcut for an unobserved relationship. This shortcut construction is reward-biased and grows over recording days.

- **Reverse replay for credit assignment.** In awake SWRs, Z-tuned cells fire *before* X-tuned cells for rewarded pairs — reverse temporal order relative to the inferred direction (X→Z). No such temporal bias appears for neutral pairs or in sleep SWRs, consistent with awake reverse replay broadcasting reward credit backward to stimuli never directly paired with outcome.

---

## Limitations

- Three-stage task performed across multiple days; results may partly reflect multi-day consolidation rather than online inference. Same-day paradigms might show different HC vs. mPFC dynamics.
- Mouse electrophysiology covers only dCA1; how mPFC and midbrain represent Z at the cellular level in mice remains unmeasured (blocked by cross-species constraint).
- RSA measures population-level representational similarity, not direct synaptic mechanism; the cellular route by which the prospective code is generated (CA3 completion → CA1 output?) is inferred, not directly observed.

---

## Links

- [[wiki/concepts/prospective-coding.md]] — primary evidence for non-spatial prospective code
- [[wiki/entities/hippocampal-entorhinal-system.md]] — adds inference-specific section
- [[wiki/concepts/replay.md]] — SWR (Sharp Wave Ripple) shortcut mechanism
- [[wiki/concepts/associative-memory.md]] — mediated inference via associative chains
- [[wiki/papers/courellis-hpc-abstract-inference-2024.md]] — complementary human single-unit evidence that HC encodes abstract latent states during inference (geometry, CCGP (Cross-Condition Generalization Performance)); this paper provides the *mechanism* (prospective code + SWR (Sharp Wave Ripple) shortcuts) that Courellis et al. characterize geometrically
