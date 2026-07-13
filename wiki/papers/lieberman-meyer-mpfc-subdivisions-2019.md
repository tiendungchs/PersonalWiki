---
title: "Social, self, (situational), and affective processes in MPFC: Causal, multivariate, and reverse inference evidence — Lieberman et al. 2019"
type: paper
tags: [MPFC, prefrontal-cortex, reverse-inference, situational-processing, value, self, social-cognition, schema, amodal-coding]
created: 2026-07-13
updated: 2026-07-13
sources: ["Social, self, (situational), and affective processes in medial prefrontal cortex (MPFC) Causal, multivariate, and reverse inference evidence"]
related: [wiki/entities/prefrontal-cortex.md, wiki/entities/default-mode-network.md, wiki/concepts/memory-schemas.md, wiki/concepts/representational-geometry.md, wiki/papers/gusnard-2001-mpfc-default-mode.md, wiki/papers/euston-mpfc-memory-decision-2012.md, wiki/queries/sota-review-brain-inspired-abstract-reasoning.md]
---

# MPFC Subdivisions: Reverse & Causal Inference (Lieberman et al. 2019)

Lieberman MD, Straccia MA, Meyer ML, Du M, Tan KM. *Neuroscience & Biobehavioral Reviews* (2019). Multi-method review (lesion, TMS, MVPA, Neurosynth reverse inference) of five domains × three MPFC subdivisions (BA 9/10/11).

## Key computational insights

- **Forward ≠ reverse inference.** "Domain X activates region R" (forward) does *not* license "R computes X" (reverse) — that is affirming the consequent. Forward maps show *all* five domains lighting up *all* of MPFC (overlapping), so forward inference cannot assign structure→function. Reverse inference asks the inverted, decision-relevant question: given activity in R, which domain is it most likely from? Operationalized as Neurosynth posterior with prior=0.5, reducing to `P(term) = hit(term) / [hit(term)+hit(non-term)]`; **multi-term** version pits two domains head-to-head, and "battle-royale" conjunction finds voxels a domain wins against all four others.
- **Converged subdivision map:** DMPFC(BA9)→**social/mental-state inference**; AMPFC(BA10)→**self + value**; VMPFC(BA11)→**value + emotion** (affect). Only these got "strong" overall.
- **Two amodal (abstract) codes** — direct representational-geometry instances (cross-class generalization ≈ CCGP):
  - **AMPFC common-value scale:** MVPA cross-classification (train on food value, test on money value) succeeds in AMPFC, *not* VMPFC — value abstracted away from stimulus class.
  - **DMPFC mental-state code:** cross-classifies the emotion of a target from *facial expression* vs. from *situation alone* — decodes the abstract mental state, not surface features. Decodes 20 emotions; RSA aligns to 38-D appraisal space.
- **VMPFC value is contextual & self-specific:** codes *relative* (not absolute) value, and only for *one's own* reward — not a stranger's outcomes.
- **Situational processing (VMPFC, tentative):** a non-selective VMPFC cluster (329 voxels) belongs to no single domain but supports all — an *integrated set of situational associations* (spatial, temporal, causal, evaluative, social). Overlaps reverse-inference maps for 'scene' and 'events'; tied to **scene construction** and **schema** processing (BA11 lesions → impaired assimilation to schemas, less schema-biased recall). Situational *cueing* raises inter-subject VMPFC correlation → shared construal.

## Limitations

DMPFC lesions are rare; TMS cannot reach VMPFC; Neurosynth links article text to peak coordinates by automated (imperfect) tagging. Situational processing is "an educated guess and a call for further research." Conclusions are *relative to the five domains only*. VMPFC ventral-surface signal dropout causes forward-inference Type II errors (explaining a surprise reverse-inference social cluster there).

## Links

- [[wiki/entities/prefrontal-cortex.md]] — MPFC functional-subdivision map, amodal codes, situational processing
- [[wiki/concepts/memory-schemas.md]] — situational processing = schema/scene-construction node
- [[wiki/entities/default-mode-network.md]] — VMPFC situational cluster ≈ DMN "frames of thought"/scene construction
- [[wiki/concepts/representational-geometry.md]] — AMPFC common-value & DMPFC mental-state cross-classification are abstraction (CCGP) instances
