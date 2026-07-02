---
title: "Compositional Generalization"
type: concept
tags: [compositional-generalization, abstract-reasoning, systematicity, productivity, seq2seq]
created: 2026-06-19
updated: 2026-07-02
sources: [Compositionality_decomposed, Human-like_systematic_generalization, ARC-AGI-2.md, building_machine_that_thinks_like_people, raven, The ConceptARC Benchmark]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/binding-problem.md, wiki/concepts/attention.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/meta-learning.md, wiki/concepts/abstract-reasoning.md, wiki/papers/compositionality-decomposed-hupkes-2020.md, wiki/papers/mlc-lake-baroni-2023.md, wiki/entities/mlc-model.md, wiki/entities/arc-agi.md, wiki/papers/arc-agi-overview.md, wiki/papers/cls-mcclelland-1995.md, wiki/papers/building-machine-thinks-like-people-lake-2016.md, wiki/papers/pgm-barrett-2018.md, wiki/papers/conceptarc-moskvichev-2023.md, wiki/entities/baba-is-ai.md]
---

# Compositional Generalization

**The ability to produce novel combinations of known primitives and rules — where the meaning of a whole is a systematic function of the meanings of its parts and their mode of combination (Frege's principle).**

Distinct from [[wiki/concepts/structural-generalization.md]]: structural generalization transfers relational *graph topology* across content domains; compositional generalization recombines *symbolic operations* systematically. A reasoning model needs both: structural generalization to know where it is in a relational space, compositional generalization to chain the rules that navigate it.

---

## Five Facets (Hupkes et al. 2020)

| Facet | Test question | Transformer | ConvS2S | LSTM |
|---|---|---|---|---|
| **Systematicity** | Handle function *pairs* never seen together? | 0.72 | 0.56 | 0.53 |
| **Productivity** | Generalize to sequences *longer* than training? | 0.50 | 0.31 | 0.30 |
| **Substitutivity (equal)** | Treat equally-distributed synonyms consistently? | 0.98 | 0.95 | 0.80 |
| **Substitutivity (primitive)** | Bootstrap synonym meaning from few examples? | 0.90 | 0.58 | 0.60 |
| **Localism** | Compute meaning bottom-up through parse tree? | 0.54 | 0.59 | 0.46 |
| **Overgeneralisation** | Apply the general rule to exceptions? | 0.88 | 0.79 | 0.68 |
| **Task accuracy** | *(baseline: overall PCFG SET performance)* | 0.92 | 0.85 | 0.79 |

Results from PCFG SET: seq-to-seq task, artificial PCFG grammar, naturalised to English length/depth distribution.

---

## The Chunking Failure Mode

High task accuracy ≠ compositional understanding. Models learn representations of *function pairs* (e.g. `append + swap` as a single unit) rather than individual atomic functions. When unseen pairs appear, performance collapses — systematicity scores fall 22–34% below task accuracy for all architectures.

**Causality as a co-prerequisite (Lake et al. 2016):** Chunking is not merely a statistical artifact — it is a symptom of lacking causal representations of how expressions are generated. Models learn joint probabilities over (function-pair, output) rather than the generative process that produces outputs from atomic rules. This explains why compositional representations alone do not achieve human-level learning-to-learn: without causality, the slow loop's prior does not resemble the actual generative mechanism of the domain, so the prior cannot be reused across novel task variants.

**Implication for TIWM:** If the W-matrix in TEM absorbs multi-step transformation sequences as chunks, it will fail on novel transformation compositions even with good training accuracy. The slow-W system must learn atomic transformation primitives, not co-occurrence-weighted composition shortcuts.

---

## Localism Is the Hardest Property

No architecture exceeds 60% localism consistency. All models build *global* sequence representations rather than composing meanings hierarchically bottom-up. LSTM failure is categorical: function representations are length-specific (accuracy drops to 0 immediately at max-train-length+1 characters). Transformer and ConvS2S failures are graceful — they generalize somewhat beyond training length before degrading.

**Why ConvS2S leads on localism:** Local convolutions impose an inductive bias toward building meaning from adjacent constituents — the same reason convolutional feature hierarchies outperform global pooling on structured data. The architectural precedent for why local inductive bias aids compositional rule application.

---

## Formalism

Frege's principle (strong / local compositionality):

`M(E) = F(M(A), M(B))` where `E = compose(A, B)` and F depends only on E's top-level rule.

Weak (global) compositionality: `M(E) = G(M(A), M(B), structure(E))` — meaning depends on the full expression tree, not just immediate children. All tested models operate closer to the weak version; none implements strong compositionality by default.

---

## MLC: Meta-Learning as the Solution to Chunking

Lake & Baroni 2023 ([[wiki/papers/mlc-lake-baroni-2023.md]]) show that episodic meta-training across grammars prevents chunking. Because each of the 100K training episodes uses a *different* compositional grammar, the slow outer loop cannot absorb function-pair co-occurrence statistics — there are none stable across episodes. This is the computational analog of McClelland et al. 1995's interleaved HC replay ([[wiki/papers/cls-mcclelland-1995.md]]): just as HC prevents catastrophic interference by delivering a mixed stream of diverse episodes to cortex, episodic meta-training prevents chunking by ensuring the slow loop never receives a focused burst from any single grammar. The result: MLC (Meta-Learning as Compositional) achieves 92.9–96.8% on few-shot instruction learning vs. GPT-4 at 58% and humans at 80.7%.

**GPT-4 fragility as a diagnostic.** Randomizing study example order collapses GPT-4 from 58% → 14% while MLC (Meta-Learning as Compositional) is unaffected. Order-dependence is the behavioral signature of chunking: GPT-4 exploits surface order patterns that vanish under permutation; MLC (Meta-Learning as Compositional) extracts abstract rules that hold regardless.

**Standard transformer: 0% exact match.** A basic seq2seq transformer with the same architecture, same optimizer, same training data achieves 0% exact-match accuracy — because without episodic meta-training it has no in-context study examples and must absorb everything into fixed weights. Architecture is not the bottleneck.

**Novel rule generalization at 99%+.** 26 rules held out from all 100K training episodes are inferred at test time from frozen weights + in-context examples alone. This confirms the slow loop has embedded *rule-learning capacity*, not rule *instances*.

**The lexical/structural split — the remaining hard boundary.** On SCAN lexical splits (add jump, around right, opposite right) MLC (Meta-Learning as Compositional) achieves ≤0.22% error; on COGS lexical types 0.87% — basic seq2seq is ≥7× worse on both. But on SCAN length (productivity) and COGS structural types, MLC (Meta-Learning as Compositional) scores **100% error** — same as random. Meta-learning generalizes when the test episode is in-distribution with respect to training grammar *variation* (new vocabulary with known structure); it fails when episode *types* themselves are out-of-distribution (new sentence structures, sequences longer than training). The LRM (Large Reasoning Model) knowledge-boundedness ceiling applies here: the fast inner loop is bounded by the slow outer loop's training distribution.

---

## PGM: Recombination vs. Decomposition in the Visual Domain

Barrett et al. 2018 ([[wiki/papers/pgm-barrett-2018.md]]) provide visual-relational evidence for the same composition-decomposition asymmetry that Hupkes et al. probe in sequence-to-sequence tasks. WReN (a pairwise Relation Network) on Raven-style PGM (Progressive Generalization Matrix) matrices shows:
- **Recombination succeeds:** novel *combinations* of familiar (r × o × a) triples — Held-out Triple Pairs: 41.9% → 56.3% with auxiliary meta-targets; Held-out Attribute Pairs: 27.2% → 51.7%. Well above 12.5% chance.
- **Decomposition fails:** genuinely novel individual triples — Held-out Triples: 19.0% → 20.1% with meta-targets. Near chance; meta-targets provide almost no benefit.

The pattern confirms that models learn combination statistics over known primitives, not meanings of the primitives themselves — the visual-domain instantiation of Hupkes et al.'s localism failure: global composition patterns are learned, local part-meaning assignment is not. The meta-target result is a direct confirmation: symbolic supervision on known relations improves how they are recombined but cannot supply meanings for unseen components. Contrast with MLC: episodic meta-training across grammars prevents chunking by forcing atomic rule extraction from the training *distribution*; PGM (Progressive Generalization Matrix) meta-targets are applied post-hoc and cannot change what atomic primitives the model has already encountered.

---

## ConceptARC: Within-Concept Generalization in the ARC Domain

Moskvichev et al. 2023 ([[wiki/papers/conceptarc-moskvichev-2023.md]]) provide a third domain confirming the composition-decomposition asymmetry — the ARC grid domain — with within-concept generalization as the measurement:

**Concept-level difficulty profile (ARC-Kaggle 1st place):**

| Concept type | Example concepts | Accuracy |
|---|---|---|
| Spatial-relational (local) | Extend to Boundary, Filled/Not Filled, Count | 60–77% |
| Compositional transformation | Copy, Order, Move to Boundary | 23–37% |

This mirrors PGM's decomposition asymmetry at the primitive level: programs learn local spatial heuristics (which lines to extend, which regions are filled) but fail on higher-order operations (copying an object requires: identify, replicate, place — a three-step compositional sequence). This is localism failure at the *primitive* level — not because two rules must compose simultaneously, but because even a single concept like "Copy" requires abstractly encoding a multi-step relational operation rather than a local grid transformation.

**Concept-group methodology as evidence standard:** A solver that correctly answers all 30 Copy variations has strong evidence of possessing "copy" as an abstract operation. A solver that answers only some has found a heuristic covering those surface instances. This raises the evaluation bar beyond what single-task accuracy reveals — within-concept generalization separates rule extraction from rule-instance memorization.

---

## VLM-Scale Evidence: Compositional Failures Survive Massive Scale

Bordes et al. 2024 ([[wiki/papers/vlm-intro-bordes-2024.md]]) review three benchmarks showing that contrastive pretraining at billion-sample scale does not solve compositionality — a fourth evidence domain alongside PCFG, PGM, and ConceptARC:

| Benchmark | What it tests | VLM result |
|---|---|---|
| **Winoground** [Thrush et al.] | Word-order discrimination — two images, two captions differing only in word order; model must assign higher score to correct pair | Near-chance; CLIP models fail; argmax tie-breaking inflates published scores |
| **ARO** [Yuksekgonul et al.] | Attribute / Relation / Order — negative captions generated by swapping relations ("horse eating grass" → "grass eating a horse"), attributes, or word order | CLIP fails across all three sub-categories; relation understanding worst |
| **PUG** (spatial) [Bordes et al.] | Synthetic controllable scenes; objects placed left/right/above/below; model must select correct spatial caption | At random chance — spatial relations entirely absent from CLIP representations |

**Generative classifiers partially solve Winoground.** Generative models trained on p(x|c) used as classifiers via Bayes' theorem outperform CLIP (discriminative p(c|x)) on Winoground. This is the analysis-by-synthesis advantage: the generative model must build an internal representation consistent with *both* the image and the relational structure of the caption to assign high likelihood — forcing richer compositional binding than contrastive alignment. The gap closes with model quality (Parti/Imagen outperform CLIP on Winoground).

**Implication for the reasoning model:** contrastive embedding alignment (CLIP-family) and token-generative language modeling (LLaVA-family) both fail on relational binding. The reasoning model must go beyond co-occurrence statistics to learn relational structure — exactly the latent-graph-discovery framing. The analysis-by-synthesis advantage suggests that a world model capable of *generating* scenes consistent with a relational description would outperform one that only aligns representations.

---

## Human Inductive Biases as Compositional Target Specification

Lake & Baroni identify three gradable priors that define *human* compositional generalization:

| Bias | Description | Human rate | MLC (Meta-Learning as Compositional) (within-sample) | MLC (Meta-Learning as Compositional) (joint) |
|---|---|---|---|---|
| **Mutual exclusivity (ME)** | Novel word → novel meaning | 68.2% ME-consistent | 68.6% | 98.0% (too rigid) |
| **Iconic concatenation** | Compound meaning = part concatenation | 93.9% | 93.8% | 66.7% |
| **One-to-one** | Each word maps to exactly one meaning | 50% trade-off with ME | 53.2% favors 1-to-1 | 56.2% |

ME is context-sensitive, not rigid: it weakens with contradictory evidence (β=1.76, p<0.001) and larger response pools (β=2.05, p<0.01). MLC (Meta-Learning as Compositional) (joint)'s over-rigid ME (98%) shows meta-learning can overfit to the modal prior rather than its distribution.

**Implication for reasoning models:** a compositional system should not apply these biases absolutely — it must learn their context-sensitive weighting. MLC (Meta-Learning as Compositional) (within-sample) achieves this but requires within-distribution optimization, suggesting the training distribution must explicitly sample the diversity of human inductive behavior.

---

## Open Problems

1. **Preventing chunking without parse-tree supervision:** largely addressed by MLC's episodic meta-training — different grammar per episode forces atomic rule learning without explicit structural annotations. Remaining gap: extending to open-ended, multi-level compositional chains (ARC-AGI rule hierarchies).
2. **Productivity vs. depth extrapolation:** MLC (Meta-Learning as Compositional) quantifies this failure precisely — 100% error on SCAN length split and COGS structural types even after solving lexical generalization at ≤0.22% / 0.87%. The lexical/structural boundary is not a data or scale problem; it is an out-of-distribution episode-type problem for the slow outer loop. Solving it requires either a broader meta-training distribution (covering structural variation) or an architecture capable of genuine productivity beyond meta-learned grammar templates.
3. **ARC-AGI binding constraint (partially answered by ARC-AGI-2):** ARC-AGI-2 empirically identifies which facets bind: (a) *compositional reasoning* (multiple interacting rules simultaneously — localism + systematicity failure) and (b) *contextual rule application* (context-gated selection — structural generalization with WM context). Symbolic interpretation is a third orthogonal failure (semantic grounding, not purely compositional). Current systems succeed on single-rule tasks (good substitutivity) but fail when rules must compose or context must gate selection — confirming localism and context-sensitivity are the binding constraints, not task accuracy per se. Log-linear scaling cannot close this gap (ARC-AGI-2 efficiency result).
4. **Context-sensitive inductive bias weighting:** MLC (Meta-Learning as Compositional) (joint) is too rigid on ME; achieving human-like gradable priors requires the meta-training distribution to sample the *diversity* of inductive contexts, not just the modal compositional task.

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — complementary capability: structural generalization transfers graph topology; compositional generalization recombines symbolic operations; the five facets operationalise what "transformers fail at structural generalization" means in precise, testable terms — they fail on all five facets simultaneously.
- **[[wiki/concepts/binding-problem.md]]** — localism failure is a compositional binding failure: models do not bind sub-expression results to their intermediate meanings before computing the parent expression; this is the binding problem instantiated at the rule-composition level, distinct from feature binding or variable-slot binding.
- **[[wiki/concepts/attention.md]]** — transformer's global receptive field (no inherent sequentiality) is a liability for localism specifically; ConvS2S's local convolutions are architecturally better matched; transformer leads on 4 of 5 other facets.
- **[[wiki/concepts/two-learning-timescales.md]]** — chunking is the failure mode where slow-W absorbs multi-step co-occurrence patterns rather than atomic primitives; the W/M split must enforce atomicity at the primitive level, not just at the transition level.
- **[[wiki/concepts/meta-learning.md]]** — overgeneralisation (rule internalisation at 68–88% peak) is the compositional correlate of meta-learning: a model that generalises the rule has learned *how to compose*, not just *what was composed during training* — the slow-W meta-parameter for compositional rule application.
- **[[wiki/papers/compositionality-decomposed-hupkes-2020.md]]** — primary source; all five-facet results and PCFG SET benchmark definition.
- **[[wiki/entities/mlc-model.md]]** — MLC (Meta-Learning as Compositional) is the first model to resolve the chunking failure by using episodic meta-learning to force atomic rule acquisition; its 92.9–96.8% systematicity vs. GPT-4's 58% (order-sensitive) operationalises the training-objective solution to the localism and systematicity gaps.
- **[[wiki/papers/mlc-lake-baroni-2023.md]]** — source for MLC (Meta-Learning as Compositional) benchmark results, GPT-4 fragility diagnostic, and human inductive bias quantification.
- **[[wiki/entities/arc-agi.md]]** — ARC-AGI-2 compositional reasoning gap = localism + systematicity failure under multi-rule interaction; contextual rule application gap = structural generalization with WM-gated context; together these identify localism and context-sensitivity as the binding constraints on ARC-AGI performance, partially answering open problem 3.
- **[[wiki/papers/arc-agi-overview.md]]** — source for ARC-AGI-2 capability gap taxonomy; Chollet's intelligence definition as the evaluation criterion that distinguishes compositional task skill from compositional generalization capacity.
- **[[wiki/papers/cls-mcclelland-1995.md]]** — MLC's episodic meta-training is the direct computational analog of McClelland's interleaved HC replay: both prevent chunking/catastrophic interference by ensuring the slow loop receives a mixed stream of diverse episodes rather than a focused burst from any single task or grammar.
- **[[wiki/papers/pgm-barrett-2018.md]]** — PGM's held-out triple pairs vs. held-out triples distinction operationalises the recombination/decomposition asymmetry in the visual domain: the same composition-decomposition failure mode as Hupkes et al.'s localism gap, confirming that models learn combination statistics over known primitives rather than the meanings of primitives themselves.
- **[[wiki/concepts/abstract-reasoning.md]]** — compositionality is the first of three required ingredients for abstract reasoning; chunking failure explains why current systems cannot build the combinatorial causal models needed for one-shot concept learning and goal repurposing.
- **[[wiki/papers/building-machine-thinks-like-people-lake-2016.md]]** — primary source for the causality co-prerequisite argument: chunking is a causal failure (learning statistics over function pairs rather than the generative process); BPL resolves it by representing characters as causal programs.
- **[[wiki/concepts/latent-graph-discovery.md]]** — compositional generalization addresses the case where meta-graph edges are themselves composed of atomic primitives; the chunking failure mode corresponds to learning coarse edge chunks rather than atomic edge types, preventing correct latent graph inference in domains with combinatorial rule structure.
- **[[wiki/papers/conceptarc-moskvichev-2023.md]]** — ConceptARC confirms localism failure at the primitive level in the ARC domain: programs solve individual task instances through local spatial heuristics but fail within-concept generalization — even atomic Core Knowledge concepts (Copy, Count, Order) require abstraction that current architectures cannot achieve across all 30 variations per concept group.
- **[[wiki/papers/vlm-intro-bordes-2024.md]]** — Winoground, ARO, PUG benchmarks add VLM-scale evidence that compositional failures persist even at billion-sample contrastive pretraining; generative classifiers (analysis-by-synthesis) partially outperform discriminative models on Winoground, supporting the world-model approach.
- **[[wiki/concepts/shortcut-reasoning.md]]** — shortcut reasoning is the concurrent failure mode: when systems fail compositionality (localism, systematicity) they typically learn distribution-specific chunked co-occurrence patterns, which are precisely the shortcuts that fail on o.o.d. recompositions; the inverse scaling paradox (larger LLMs more shortcut-prone) and chunking failure compound each other.
- **[[wiki/entities/vsa-model.md]]** — VSA's slot-filler encoding (ROLE ⊛ FILLER) directly implements the localism requirement: sub-expression results are bound to roles before composition, satisfying the binding constraint that transformers fail on; the 94.5% Sort-of-ARC score confirms systematic generalization when the vocabulary is pre-specified.
- **[[wiki/entities/baba-is-ai.md]]** — Baba's `break→make→goto` test is compositional generalization over *rule-manipulation* primitives rather than object features; frontier models score ~15–20%, showing the localism/systematicity failure extends to composing edits of the environment's own rules.
