---
title: "LISA (Learning and Inference with Schemas and Analogies)"
type: entity
tags: [analogical-reasoning, binding-problem, symbolic-connectionist, working-memory, temporal-synchrony]
created: 2026-06-20
updated: 2026-06-20
sources: [analogy-holyoak-2012]
related: [wiki/concepts/analogical-reasoning.md, wiki/concepts/binding-problem.md, wiki/concepts/working-memory.md, wiki/entities/prefrontal-cortex.md, wiki/papers/analogy-holyoak-2012.md]
---

# LISA (Learning and Inference with Schemas and Analogies)

Symbolic-connectionist model of analogical reasoning (Hummel & Holyoak 1997, 2003). Implements the full four-component analogy algorithm (Retrieval → Mapping → Inference → Schema Induction) with explicit role-filler binding via oscillatory temporal synchrony.

---

## Architecture

| Component | Description |
|---|---|
| **Units** | Hierarchy: semantic feature units → predicate/object units → proposition units |
| **Role-filler binding** | Gamma-band (~40 Hz) temporal synchrony: units within one proposition co-activate in phase; different simultaneous propositions in anti-phase |
| **Working Memory (Driver)** | Active proposition set: ≤2–3 simultaneous propositions; constrained by the number of distinct anti-phase synchrony slots |
| **Long-term memory (Recipient)** | Candidate analogs activated by semantic overlap with driver; mapping connections grow via Hebbian co-activation |
| **Inference** | Copy-With-Substitution-and-Generation (CWSG): unmapped source propositions are copied to target, substituting mapped correspondences and postulating new elements |
| **Schema induction** | Mapping connections from two compared analogs are averaged → abstract schema with role-filler variables replacing specific fillers |

---

## Key Results

- **WM capacity predicts frontal damage profile:** The ≤2–3 proposition limit matches the empirical relational complexity ceiling; frontal patients fail only problems requiring ≥2 simultaneous relational constraints (Waltz et al. 1999), which LISA can reproduce by reducing its driver capacity.
- **Developmental relational shift:** LISA explains why children rely on surface similarity before relational structure — the model's semantic units are activated before structural mapping connections strengthen; with experience, structural connections dominate (Rattermann & Gentner 1998).
- **Schema retroactively enhances retrieval:** An induced schema from two analogs increases the probability of subsequently retrieving prior stored analogs — consistent with Gentner et al. 2009.

---

## Limitations

- Gamma-band synchrony is a neural *metaphor* in LISA, not an implemented oscillatory mechanism — the model uses phased co-activation as a bookkeeping device, not a spiking network.
- All predicates and relations must be hand-coded; autonomous learning of role-filler structure from perceptual inputs is largely absent (Doumas et al. 2008 begins to address this).
- Scaling to deep relational hierarchies (>3 proposition levels) requires additional proposition layers not specified in the core model.
- No account of the retrieval stage — LISA starts from already-retrieved analogs in WM; the surface-biased LTM access problem is outside its scope.

---

## Comparison Table

| Property | LISA | Symbolic logic | Transformer self-attention |
|---|---|---|---|
| **Binding mechanism** | Gamma-band temporal synchrony | Explicit variable assignment | Soft key-value lookup (no role-filler separation) |
| **WM capacity** | ≤2–3 propositions | Unlimited (no capacity model) | Scales with context length; entropy bottleneck at large N |
| **Biological plausibility** | Oscillatory metaphor (medium) | None | Low |
| **Compositionality** | Yes (proposition hierarchy) | Yes (formal) | Fails localism (Hupkes 2020) |
| **Schema induction** | Yes (Hebbian averaging) | Requires explicit generalization rule | Only via in-context learning |

---

## Connections

- **[[wiki/concepts/analogical-reasoning.md]]** — LISA is the primary computational implementation of the four-component analogy algorithm described there; the gamma-band synchrony binding and ≤2–3 proposition WM limit are both covered in detail.
- **[[wiki/concepts/binding-problem.md]]** — role-filler binding via temporal synchrony is the fifth binding mechanism listed in the binding-problem table; LISA's anti-phase proposition separation is the mechanism that prevents illusory conjunctions between simultaneous relations.
- **[[wiki/concepts/working-memory.md]]** — the ≤2–3 proposition limit directly sets the WM capacity for relational integration; this is a different constraint from the attention entropy bottleneck in transformers — structural, not positional.
- **[[wiki/entities/prefrontal-cortex.md]]** — frontopolar BA (Brodmann Area)-10 lesions selectively impair the ≥2 simultaneous relation integration that LISA's driver capacity implements; IFG handles the distractor suppression that LISA's semantic co-activation can otherwise induce.
- **[[wiki/papers/analogy-holyoak-2012.md]]** — primary source covering LISA architecture, WM capacity predictions, developmental evidence, and schema induction results.
