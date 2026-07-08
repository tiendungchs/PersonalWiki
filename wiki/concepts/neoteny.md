---
title: "Neoteny / Altriciality"
type: concept
tags: [neoteny, altriciality, heterochrony, developmental-plasticity, self-domestication, domain-general, evolution]
created: 2026-07-07
updated: 2026-07-08
sources: [unraveling-evolution-uniquely-human-cognition, a-natural-history-of-the-human-mind, transcriptional-neoteny-human-brain]
related: [wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/cognitive-control.md, wiki/concepts/meta-learning.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/cultural-learning.md, wiki/papers/maclean-human-cognition-evolution-2016.md, wiki/papers/sherwood-natural-history-mind-2008.md, wiki/papers/somel-transcriptional-neoteny-2009.md]
---

# Neoteny / Altriciality

**Developmental-timing traits that gate how much a brain can *learn* before its structure consolidates.** **Neoteny** = retention of juvenile traits/plasticity into adulthood via shifted developmental timing (*heterochrony*); **altriciality** = being born immature and dependent, extending the post-natal window of experience-dependent wiring. Neoteny is about *rate/retention*, altriciality about *birth maturity*; both lengthen the plastic learning window.

---

## The Extended-Window Numbers (Sherwood et al. 2008)

| Trait | Human | Chimp | Macaque | Implication |
|---|---|---|---|---|
| Brain size at birth (% adult) | **27%** | 36% | 70% | Human wiring is deferred to experience |
| Postnatal growth | fetal rate through year 1 | decelerates at birth | decelerates | Fast synaptogenesis under environmental input |
| Adult synaptic plasticity markers | THBS2/4 ↑, plasticity genes ↑ | baseline | baseline | Plastic window stays open longer |

Joint-attention onset falls *inside* the first-year rapid-growth window — social facilitation shapes synapses while connections are maximally malleable. The extended window is when the outer loop runs.

---

## The Molecular Evidence (Somel et al. 2009)

The morphology numbers above are corroborated at the transcriptome. Comparing PFC (DLPFC + SFG) mRNA across human/chimp/macaque postnatal life (macaque as outgroup), a heterochrony test finds adult human PFC expression resembles that of **younger chimpanzees** — direct molecular neoteny, reproduced across two regions and platforms. Two refinements that change the design reading:

| Property | Finding | Design consequence |
|---|---|---|
| **Extent** | Mosaic, **~4% of transcriptome** (a global slowdown is excluded) | Extended window = *targeted schedule shift on specific gene networks*, **not** a uniform slowing → **per-subsystem plasticity schedules** |
| **Which genes** | Overrepresented in **gray-matter-specific / synaptic** genes (adhesion, synaptic transmission, axonogenesis) | The delayed subsystem is the *synaptic/structural* (slow-W) machinery specifically |
| **When** | Divergence peaks **~10 yr (early adolescence)**, coinciding with gray-matter-volume decline = **synaptic pruning** | The neotenic delay is concentrated at the **consolidation/pruning** stage → *delayed freezing of structure*, not merely slower onset |

**Reframing:** neoteny is not "learning stays slow everywhere for longer." It is a *selective deferral of the pruning/consolidation schedule on the plasticity-relevant subsystem*, concentrated near maturity. This sharpens open-question #3 below: a principled plasticity taper should defer **pruning of the structural (slow-W) parameters specifically**, and defer it *late*. See [[wiki/concepts/two-learning-timescales.md]], [[wiki/papers/somel-transcriptional-neoteny-2009.md]].

---

## Domain-General → Domain-Specific Emergence (the core architectural claim)

Sherwood et al.'s central thesis: human reasoning specializations are **not new domain-specific modules** — macaque homologues exist for nearly all human cortical areas, and total frontal/prefrontal cortex fraction sits at ape-scaling predictions. Instead:

> Quantitative reweighting of **domain-general primitives** (attention, executive control, working memory, inhibition), amplified through the extended plastic window, *emergently* produces domain-specific skills (reading, syntax, tool schemas, unobservable-cause inference).

This is a **schedule-and-reweighting** account, not a module-addition account — and a concrete design lever: attainable cognition is set by *when* structure consolidates and *how* general primitives are biased during learning, not only by architecture. Compare the "which brain to model" constellation argument ([[wiki/papers/maclean-human-cognition-evolution-2016.md]]).

---

## Why this matters for a reasoning model

- **Extended plasticity = longer outer loop.** A prolonged immature phase is a long, curriculum-driven meta-learning window before weights consolidate. See [[wiki/concepts/meta-learning.md]], [[wiki/concepts/two-learning-timescales.md]].
- **Emergence over engineering.** If specialized competence emerges from reweighting general primitives under a developmental schedule, a reasoning model may not need hand-built modules per skill — it needs the right primitives + a consolidation schedule + a rich input curriculum.
- **Self-domestication link.** Selection against aggression → neotenic traits → increased tolerance → unlocks social learning/cooperation. Training-time analog of "reduced aggression enabling learning from others" is open.
- **Altriciality vs. precociality trade-off.** Precocial animals hard-code more; altricial animals defer to learning. Which regime (and for which subsystems) does an abstract reasoner want?

## Open questions

1. Formal relationship between plastic-window length and attainable [[wiki/concepts/abstract-reasoning.md]] (compositional/causal competence)?
2. Does the cultural-ratchet argument require altriciality, or only sufficient window + social transmission?
3. How to translate "consolidation freezes structure" into a principled pretraining→finetuning schedule with a graded plasticity taper.
4. What is the minimal set of *domain-general primitives* whose reweighting yields the target domain-specific skills?

---

## Connections

- **[[wiki/papers/sherwood-natural-history-mind-2008.md]]** — source: the extended-growth numbers, the domain-general→specific emergence thesis, and the enhanced-adult-plasticity molecular markers.
- **[[wiki/papers/maclean-human-cognition-evolution-2016.md]]** — source: neoteny/self-domestication as a developmental-timing lever; the constellation ("which brain to model") complement to the emergence thesis.
- **[[wiki/concepts/abstract-reasoning.md]]** — extended developmental plasticity is a candidate substrate for accumulating the compositional/causal priors abstract reasoning needs; the emergence thesis reframes those priors as reweighted general primitives, not dedicated modules.
- **[[wiki/concepts/compositional-generalization.md]]** — domain-independence/generalized systematicity is proposed to emerge from cross-domain connectivity laid down during the plastic window, not from a hard-coded compositional module.
- **[[wiki/concepts/cognitive-control.md]]** — inhibition is one of the domain-general primitives whose developmental reweighting the emergence thesis credits with unlocking latent-cause reasoning.
- **[[wiki/concepts/meta-learning.md]]** — the plastic developmental window is the biological outer loop; neoteny lengthens it.
- **[[wiki/concepts/two-learning-timescales.md]]** — consolidation (structure "freezing") is the slow-W end; neoteny delays that freeze, keeping W malleable longer — and Somel 2009 localizes the delay to *synaptic/gray-matter* genes at the *pruning* stage, i.e. the slow-W substrate specifically.
- **[[wiki/concepts/cultural-learning.md]]** — the extended plastic window is *when* the social acquisition channel runs; self-domestication → tolerance is precisely what unlocks that channel, so neoteny supplies the window and cultural learning the mechanism it makes usable.
- **[[wiki/papers/somel-transcriptional-neoteny-2009.md]]** — primary source: direct transcriptomic evidence that human PFC development is delayed (adults resemble juvenile chimps); establishes the shift is mosaic (~4%), gray-matter/synaptic-specific, and peaks at adolescent pruning.
