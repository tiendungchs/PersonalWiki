---
title: "Frontal Networks for Learning and Executing Arbitrary Stimulus-Response Associations"
type: paper
tags: [PFC, arbitrary-mapping, action-semantics, rule-learning, premotor, SMA, striatum, contextual-inference, fMRI, vocabulary-co-discovery]
created: 2026-07-17
updated: 2026-07-17
sources: [Frontal Networks for Learning and Executing Arbitrary Stimulus-Response Associations]
related: [wiki/concepts/arbitrary-mapping.md, wiki/concepts/contextual-inference.md, wiki/concepts/cognitive-control.md, wiki/entities/prefrontal-cortex.md, wiki/entities/basal-ganglia.md, wiki/papers/frontal-cortex-abstract-rules-badre2010.md, wiki/papers/wise-murray-arbitrary-mapping-2000.md, wiki/queries/action-semantics-contextual-inference.md, wiki/architectural-gaps.md]
---

# Frontal Networks for Learning and Executing Arbitrary Stimulus-Response Associations

**Boettiger & D'Esposito (2005). *J. Neurosci.* 25(10): 2723–2732. doi: 10.1523/JNEUROSCI.3697-04.2005**

Human fMRI (n=14, 4T). Subjects learned by trial and error to map *sets* of abstract visual stimuli (10 per set, grouped by a non-verbalizable constellation of covarying colored elements) onto one of four buttons. Some rules were trained the day before (**familiar**), others learned in the scanner (**novel**), and a third covert condition (**no-rule**) contained 20 unrelated stimuli with arbitrarily assigned buttons.

---

## Key Computational Insights

**Learning and executing the same rule type recruit disjoint circuits.** Stimulus statistics and motor actions are matched across conditions, so the contrast isolates the computation, not the content:

| Contrast | Regions |
|---|---|
| **novel > familiar** (acquisition) | right dlPFC (MFG); midline SMA/pre-SMA; left ventral premotor (PCG); right anterior striatum (caudate); map-wise also left MFG, right IFG/IFS (vlPFC), bilateral insula |
| **familiar > novel** (execution) | left rostral dorsal premotor (SFG, BA6/8); frontopolar cortex; rostral ACC; left insula |

**The no-rule condition is the load-bearing control.** It matches novelty, uncertainty, and error-feedback rate but removes *learnable latent structure*. All four learning regions were **more** active for novel than no-rule (MFG p<2×10⁻⁴; SMA p<0.03; PCG p<8×10⁻⁵; striatum p<0.01) — so they track inferable structure, not surprise or difficulty. Subjects scored **below chance (35 ± 3%)** on no-rule blocks, worse than the 50% obtainable by ignoring the stimuli and pressing one of two buttons: they kept hypothesis-testing structure that did not exist.

**Asymmetric decay.** MFG and SMA decline from early→late runs *only* in the novel condition, and their block-wise BOLD correlates inversely with accuracy. PCG and striatum are learning-selective but **do not decay** (striatum trends up, matching Brasted & Wise monkey recordings) — cortical inference disengages while the executor/valuation side does not.

**Coupling predicts learning, magnitude does not.** Block-wise dlPFC↔SMA correlation explains **63%** of between-subject variance in overall accuracy; SMA/MFG and SMA/striatum coupling separate high from low learners. Per-subject BOLD–accuracy correlation strength in MFG/SMA/PCG predicts novel-rule learning ability (R²=0.59/0.47/0.34) — and only in the learning condition.

**Why earlier imaging missed dlPFC.** Prior studies used few stimuli, explicit 1:1 mappings, and pre-scan practice. Requiring a *categorical* (higher-order) rule over many lower-order mappings, sustained across a block, is what recruits dlPFC — reconciling imaging with the lesion and monkey-physiology literature. This is the 2005 precursor of the same lab's policy-abstraction hierarchy ([[wiki/papers/frontal-cortex-abstract-rules-badre2010.md]]).

**Proposed circuit (authors' hypothesis).** SMA/pre-SMA maintains the set of *candidate* S-R associations; dlPFC holds accumulated outcomes in WM, detects regularities, and biases selection among the SMA candidates; striatum monitors feedback. On success, associations transfer to striatum and lateral premotor cortex for use without evaluation. Structurally this is MOSAIC's module bank + responsibility computation + error signal — see [[wiki/concepts/contextual-inference.md]].

---

## Limitations

- Reverse inference: BOLD condition differences license "region is more engaged," not "region computes X"; and a region can be lesion-necessary throughout while showing higher BOLD in one phase (cf. Wise & Murray's PMd result).
- Frontopolar's familiar>novel effect has two incompatible readings the authors cannot separate: spare "mental space" during the easier condition vs. subgoal coordination under a held rule.
- Lenient threshold (p<0.005 uncorrected, ≥8 voxels), n=14; coverage excluded most cortex posterior to the postcentral gyrus.
- Block-design correlations are far too coarse (2.2 s TR) to establish a circuit; the dlPFC→SMA direction is asserted, not measured. Badre 2010 later supplied Granger-causality direction for the fronto-striatal arm.

---

## Links

- **[[wiki/concepts/arbitrary-mapping.md]]** — the human categorical extension of the monkey conditional-motor-learning literature: same arbitrary cue→action binding, but with sets rather than single cues, and with acquisition and execution circuits separated within one task.
- **[[wiki/concepts/contextual-inference.md]]** — the no-rule below-chance result is human data on COIN's unfit false-split (γ) dial; the MFG/SMA decay vs. striatal persistence is a candidate neural discriminator for the proper/apparent-learning distinction.
- **[[wiki/entities/prefrontal-cortex.md]]** — source for dlPFC recruitment by higher-order (not 1:1) S-R rule acquisition, its decay to baseline on acquisition, and the 63%-of-variance dlPFC–SMA coupling result.
- **[[wiki/entities/basal-ganglia.md]]** — source for anterior caudate learning-selectivity without decay in human S-R rule learning.
- **[[wiki/papers/frontal-cortex-abstract-rules-badre2010.md]]** — same lab, same rostro-caudal logic five years later: this paper's novel/familiar dissociation anticipates the prePMd-searches/PMd-executes split under RL.
- **[[wiki/papers/wise-murray-arbitrary-mapping-2000.md]]** — the monkey lesion/physiology review this paper's human imaging was designed to reconcile with.
- **[[wiki/queries/action-semantics-contextual-inference.md]]** — supplies that query's within-task evidence that inferring an action's effect and expressing it are separate computations.
