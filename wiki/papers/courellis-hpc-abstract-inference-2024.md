---
title: "Abstract representations emerge in human hippocampal neurons during inference — Courellis et al. 2024"
type: paper
tags: [hippocampus, representational-geometry, abstract-reasoning, CCGP (Cross-Condition Generalization Performance), latent-states, human-neuroscience]
created: 2026-06-23
updated: 2026-06-23
sources: []
related: [wiki/concepts/representational-geometry.md, wiki/concepts/latent-states.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/factorized-representations.md, wiki/papers/geometry-abstraction-bernardi-2020.md]
---

# Abstract representations emerge in human hippocampal neurons during inference

**Citation:** Courellis, Minxha, Cardenas, Kimmel, Reed, Valiante, Salzman, Mamelak, Fusi & Rutishauser. *Nature* 632, 2024. Human single-unit recordings; 17 epilepsy patients; 42 sessions; 2,694 neurons across HC, amygdala, vmPFC, dACC, pre-SMA, and VTC.

**Task:** Serial reversal learning with a latent uncued context. Two fixed stimulus–response–outcome maps (context 1 and context 2) invert all stimulus–response pairings across contexts. Context switches are random and uncued; a single error signals the switch. Inference trials = first occurrence of non-error stimuli after a switch (correct response requires inferring the new context, not individual correction).

---

## Key Computational Insights

- **HC uniquely achieves simultaneous multi-variable abstraction.** Only HC simultaneously encodes latent context and stimulus identity in disentangled format (high CCGP (Cross-Condition Generalization Performance) + PS for both). Amygdala, vmPFC, dACC, pre-SMA, and VTC can abstract at most one variable — none achieves joint disentanglement. Shattering dimensionality also increases selectively in HC during inference-present sessions.

- **Abstraction = sparsification.** HC firing rates drop ~60% (3.37 → 1.36 Hz) during inference-present sessions. Against this overall decrease, the context coding direction is the lone exception: context centroid separation *increases*. Individual neurons become more consistent in context modulation direction across stimuli (increased PS). Mechanism: sparser background suppresses noise along non-context axes, isolating the context direction as the dominant variance source. Variance decrease along coding directions is fully explained by the firing-rate reduction (Fano factors unchanged), not by a separate precision increase.

- **Trial-level behavioral correlation.** Context CCGP (Cross-Condition Generalization Performance) (not raw decoding accuracy) predicts trial-level inference success. Error trials in inference-present sessions → CCGP (Cross-Condition Generalization Performance) drops to inference-absent levels while standard decoding stays above chance. Abstract format, not mere decodability, is the behavioral prerequisite.

- **Verbal instruction produces the same geometry within minutes.** Patients given a 5-minute verbal description of the latent task structure (context inversion) develop HC representations geometrically identical to those who discovered the structure by trial-and-error. Channel to abstract structure is irrelevant to representational format.

- **Human replication of Bernardi et al. 2020.** Extends CCGP (Cross-Condition Generalization Performance)/PS framework from monkey prefrontal/hippocampal recordings to human single-unit data; both species converge on HC as the multi-variable abstract-state maintainer. Human result extends area coverage to include amygdala.

---

## Limitations

- Pseudo-population analysis (neurons pooled across patients and sessions); true within-session population geometry untested.
- Causal direction unresolved: does sparsification drive abstraction, or does learning abstract structure incidentally reduce firing?
- Task is minimal (4 stimuli, 2 contexts, 3 task variables); whether the CCGP (Cross-Condition Generalization Performance)/SD balance scales to many simultaneously abstract variables is untested.

---

## Connections

- **[[wiki/concepts/representational-geometry.md]]** — primary validation source for CCGP (Cross-Condition Generalization Performance)/PS metrics in humans; adds sparsification as mechanism and multi-area specificity (only HC achieves simultaneous multi-variable abstraction across 6 recorded regions).
- **[[wiki/concepts/latent-states.md]]** — establishes that abstract latent-state encoding (context as high-CCGP variable) is HC-specific even when amygdala, vmPFC, and dACC are directly compared; verbal instruction route confirms the representational format is decoupled from learning pathway.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — provides human single-unit evidence for HC as multi-variable abstract-state maintainer; sparsification finding connects to the fast-M write mechanism and ACh-mediated sparsity.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the 60% firing-rate decrease co-occurring with abstract representation is the dynamic analog of the SDR (Sparse Distributed Representations) design prescription: sparser activity isolates the abstract structure signal.
- **[[wiki/papers/geometry-abstraction-bernardi-2020.md]]** — prior work this paper extends from monkey to human; monkey recordings included HPC and DLPFC but not amygdala; both converge on HC specificity.
