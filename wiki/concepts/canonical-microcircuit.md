---
title: "Canonical Microcircuit"
type: concept
tags: [canonical-microcircuit, neocortex, laminar-organization, recurrent-amplification, winner-take-all, cortical-column, inhibitory-interneurons]
created: 2026-06-23
updated: 2026-06-23
sources: [douglas-martin-neocortex-2004, bastos-canonical-microcircuit-2012]
related: [wiki/concepts/predictive-coding.md, wiki/concepts/dendritic-computation.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/attention.md, wiki/entities/htm-thousand-brains.md, wiki/papers/douglas-martin-neocortex-2004.md, wiki/papers/bastos-canonical-microcircuit-2012.md]
---

# Canonical Microcircuit

**The universal 6-layer neocortical loop (L4→L2/3→L5→L6→L4) in which weak afferent inputs are recurrently amplified to cortical scale, competing interpretations are selected by horizontal inhibition (soft WTA), and superficial versus deep layers implement explore versus exploit computation.**

---

## The Loop

| Synapse | Source → Target | Direction |
|---------|-----------------|-----------|
| Thalamus → L4 spiny stellate | Extrinsic → granular | Feedforward input |
| L4 → L2/3 superficial pyramidal | Granular → supragranular | Amplify + project up |
| L2/3 → L5 deep pyramidal | Supragranular → infragranular | Route to output |
| L5 → L6 deep pyramidal | Infragranular → infragranular | Continue deep loop |
| L6 → L4 | Infragranular → granular | Close the loop |
| L6 → thalamus | Infragranular → extrinsic | Corticothalamic feedback |

Interareal feedforward = L3 pyramidal → L4 of target (high SLN%); interareal feedback = L5/6 pyramidal → L1/5/6 of target (low SLN%).

---

## Recurrent Amplification

Thalamic synapses are **<10% of excitatory inputs** in L4; peak EPSPs from thalamic synapses are only ~2× those from cortico-cortical synapses (Stratford et al. 1996; Gil et al. 1999). Yet thalamic input reliably drives the cortex. The resolution (Douglas et al. 1989; Douglas & Martin 2004): afferent signals **seed** the recurrent loop, which amplifies them via cascading mutual excitation. Small inputs with moderate synaptic weights dominate cortical responses because they trigger sustained loop-internal activity, not because they are individually strong.

**Architectural implication:** A sparse external signal (e.g., a goal token in a reasoning model) can drive a large cortical representation if it seeds a sufficiently recurrent circuit — recurrence is the amplification mechanism, not synapse strength.

---

## Inhibitory Dissociation

Two anatomically and functionally distinct inhibitory modes gate the circuit:

| Class | Cell types | Axon targets | Computation |
|-------|------------|-------------|-------------|
| **Horizontal** | Large basket, chandelier (axo-axonic) | Soma, AIS, proximal dendrites | Soft WTA / soft MAX among competing L2/3 patches |
| **Vertical** | Double bouquet | Distal basal + apical dendrites | Dynamic gating of individual dendrite input-output transform |

Horizontal cells (parvalbumin+) implement lateral competition: when one L2/3 patch wins, it suppresses neighbors via horizontal collaterals. Vertical cells (calbindin+, double bouquet) form a regular array spaced ~25 µm apart in tangential view, with narrow columnar axon bundles — each can modulate the dendritic transfer function of a column of pyramidal cells independently of somatic output.

---

## Explore / Exploit Layer Split

**Superficial L2/3 — explore:**
- Patchy lateral connections: ~10–30 patches at 400–700 µm spacing (patch diameter ≈ basal dendritic arbor diameter — maximizes input diversity, not purity)
- Each patch receives feedforward (thalamic/L4), local (neighboring patches), and interareal (feedback from higher areas) input
- Horizontal inhibition selects the interpretation most consistent with this ensemble — soft MAX over hypotheses

**Deep L5/6 — exploit:**
- L5 projects to subcortical structures (basal ganglia, colliculus, spinal cord, motor output)
- L5 also provides feedback to superficial layers of *other* areas (spreading the winning interpretation as contextual signal)
- L6 closes the thalamic loop and adapts the input gate for subsequent processing

The output of the exploit stage constrains the next explore stage via L6→L4 recurrence and interareal L5 feedback — the circuit is continuously self-modifying, not a one-pass pipeline.

---

## SLN% Hierarchy Rule

The proportion of superficial-layer neurons (SLN%) contributing to a projection between two areas encodes their hierarchical distance:

| SLN% | Projection type | Laminar anatomy |
|-------|----------------|-----------------|
| ~100% | Feedforward | L3 → L4 of target |
| ~50% | Lateral (same level) | L2/3+5/6 → L2/3+5/6 |
| ~0% | Feedback | L5/6 → L1/5/6 of target |

Confirmed across macaque visual cortex hierarchy (V1→V4: 100% SLN%; V4→V1: <20% SLN%). Implication: a single consistent anatomical hierarchy — not a partial order — organizes neocortical areas.

---

## Application to Reasoning Models

1. **Recurrent seed architectures:** A sparse symbol or goal can be amplified to a rich distributed representation if injected into a recurrent loop; no need for giant embedding tables. Mirror the L4→loop injection.
2. **Soft WTA as hypothesis selector:** Horizontal inhibition among L2/3 patches maps directly to lateral inhibition among competing candidate rules/transformations — the neural implementation of "select the most consistent hypothesis."
3. **Two-layer output:** L5 → action/output; L6 → input gating. A reasoning model needs both a decision output and a mechanism to update what it pays attention to next.
4. **Hierarchical routing:** SLN% rule suggests that feedforward and feedback signals must arrive in anatomically different layers — mixing them (as flat residual connections do) loses the hierarchy signal.

---

## Open Problems

- The soft WTA dynamics are qualitative; convergence, capacity (how many competing interpretations can be maintained), and selection bias are not formally characterized.
- How do patchy lateral L2/3 connections and the horizontal WTA interact when interpretations are partially overlapping rather than disjoint?
- What determines the number and spacing of patches across areas — functional (feature map), developmental, or wiring-cost constraints?

---

## Connections

- **[[wiki/concepts/predictive-coding.md]]** — Bastos et al. 2012 maps PC's error/prediction variable split onto this circuit: L2/3 superficial = prediction-error neurons (broadcast feedforward at gamma); L5/6 deep = prediction neurons (broadcast feedback at beta); the L6→thalamus loop is the active-inference action channel.
- **[[wiki/concepts/dendritic-computation.md]]** — double bouquet vertical inhibitors target distal basal and apical dendrites, gating the input-output transfer function of individual dendritic compartments; basket/chandelier horizontal inhibitors target soma/AIS, gating somatic output; together they implement dual-compartment credit-assignment anatomy.
- **[[wiki/concepts/hierarchical-representations.md]]** — the SLN% rule quantifies the feedforward/feedback asymmetry; feedforward (L3→L4) drives the bottom-up pattern-recognition mode; feedback (L5/6→L1/5/6) implements the top-down model-building mode that distinguishes hierarchical representations from reasoning.
- **[[wiki/concepts/attention.md]]** — horizontal smooth cells implementing soft WTA among L2/3 patches are the biological analog of softmax attention: both select from competing candidates, both implement a soft MAX rather than a hard threshold; the temperature → 0 limit of softmax corresponds to the strong horizontal inhibition regime.
- **[[wiki/entities/htm-thousand-brains.md]]** — HTM's cortical column L1–L6 layer assignment (L4=sensory, L2/3=binding/consensus, L6=path integration, L5=motor output) directly instantiates the canonical circuit; TBT proposes ~150,000 columns each running this same loop independently and reaching consensus via L2/3 lateral connections.
- **[[wiki/papers/douglas-martin-neocortex-2004.md]]** — primary anatomy source; establishes universality, recurrent amplification, soft WTA model, horizontal/vertical inhibitor dissociation, and SLN% rule.
- **[[wiki/papers/bastos-canonical-microcircuit-2012.md]]** — derives the laminar PC variable mapping from this circuit anatomy; establishes spectral asymmetry (gamma=superficial/error, beta=deep/prediction) as a mathematical consequence.
