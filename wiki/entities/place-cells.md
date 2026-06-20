---
title: "Place Cells"
type: entity
tags: [place-cells, hippocampus, latent-states, successor-representation, conjunctive-code]
created: 2026-06-09
updated: 2026-06-20
sources: [t-TEM, engram-transcript, jumping-spiders-cognition, The mechanisms for pattern completion and pattern separation in the hippocampus, Learning Fast and Slow Single- and Many-Shot Learning in the Hippocampus]
related: [wiki/concepts/latent-states.md, wiki/concepts/factorized-representations.md, wiki/concepts/successor-representation.md, wiki/concepts/structural-generalization.md, wiki/concepts/attention.md, wiki/concepts/engrams.md, wiki/concepts/binding-problem.md, wiki/concepts/convergent-allocentric-coding.md, wiki/concepts/two-learning-timescales.md, wiki/entities/grid-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/cscg-model.md, wiki/entities/arthropod-mushroom-bodies.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/engram-transcript.md, wiki/papers/jumping-spiders-cognition.md, wiki/papers/pattern-completion-rolls-2013.md, wiki/papers/learning-fast-slow-liao-2024.md]
---

# Place Cells

**Neurons in hippocampus that fire sparsely at specific locations — the biological implementation of the conjunctive code `p = f(g, x)`, binding structural position to sensory content.**

---

## Key Properties

- **Sparse, location-specific firing** — one (or few) place fields per environment
- **Context-dependent remapping** — different cells activate, or same cells at different locations, across environments
- **Non-random remapping:** cells remap to positions consistent with their grid-phase input (verified Barry 2012, Chen 2018); x changes, g-phase is preserved
- **One-shot binding via BTSP:** place fields emerge in a single trial through behavioral timescale synaptic plasticity (BTSP; Bittner et al. 2017) — an EC-instructed dendritic plateau potential potentiates all inputs active within a seconds-long window simultaneously; this is the fast-M write operation, mechanistically distinct from millisecond-scale Hebbian STDP; first synapse-level in vivo confirmation: Fan et al. 2023; Gonzalez et al. 2023

## SR Rows

Rows of S = (I−γT)^{−1} spatially resemble place cells — peaked, environment-specific fields encoding expected future occupancy rather than just current location. SR predictions verified empirically:

- **Asymmetric place fields** (Mehta 2000): fields skew backward along running direction
- **Barrier-induced fragmentation** (Derdikman 2009): inserting a barrier fragments place fields predictably

## Origin: DG Competitive Learning from Grid Inputs (Rolls 2013)

Place cells do not form directly from MEC grid cells; the dentate gyrus (DG) is the critical intermediary. Rolls 2013 ([[wiki/papers/pattern-completion-rolls-2013.md]]) shows that DG competitive learning (Hebbian synapses + strong inhibitory interneurons) transforms grid cell input into place-like fields:

1. Each DG granule cell learns to respond to a specific *combination* of co-active grid cells — that combination uniquely defines a place.
2. DG projects to CA3 via only ~46 mossy fiber synapses per CA3 cell — a sparse random projection that forces *maximally different* CA3 representations per episode regardless of input similarity.
3. Both sparse DG representation and Hebbian learning are required; fixed random feed-forward weights alone produce broad overlapping fields.

**Primate adaptation:** The same mechanism produces *spatial view cells* rather than place cells. The primate fovea covers ~10-20° (vs. rat's ~180-270°), so the DG combination encodes a viewed patch in space rather than a body location. This unifies the rodent and primate HC literatures under a single DG competitive learning account.

---

## Latent State Variants

In tasks with hidden task-relevant variables, the cognitive map expands to include those dimensions — place cells tile the expanded space:

| Task | Hidden dimension | Cell type |
|------|-----------------|-----------|
| T-maze alternation | Trial direction (L/R) | Splitter cells |
| 4-lap reward task | Lap number | Lap-specific cells |
| Tower accumulation | Cue evidence difference | Evidence cells |

All are place cells in a higher-dimensional cognitive map. See [[wiki/concepts/latent-states.md]].

---

## As Engram Cells

Hippocampal place cells are the engram cells of the hippocampus [[wiki/concepts/engrams.md]]. The cellular properties match exactly:

- **Sparsity:** dentate gyrus engrams occupy 2–6% of cells — the same range as sparse place cell firing fields
- **Causal sufficiency:** optogenetically activating tagged engram/place cells in the absence of the training context triggers the associated behavior — matching TEM's claim that p-cell retrieval is sufficient to drive prediction
- **Necessary for recall:** silencing or ablating the tagged ensemble blocks memory recall — p codes are not redundantly stored elsewhere

---

## Hopfield Memory Neuron Interpretation (TEM-t)

TEM-t [[wiki/papers/t-tem-whittington-2022.md]] provides a mechanistic account of place cell properties. When transformer self-attention is decomposed into feature neurons (`g̃`, `x̃`) and memory neurons (the softmax output layer), memory neurons:

- Fire sparsely at specific locations (softmax → winner-take-most activation)
- Develop spatially tuned firing fields
- Remap randomly between environments (g̃ connectivity is fixed; remapping comes from the changing x̃ distribution across environments)
- Act as indices binding cortical representations: HC memory neurons link together MEC (`g̃`) and LEC (`x̃`), and scale to N cortical inputs without multiplying hippocampal neuron count

This instantiates hippocampal indexing theory (Teyler & Rudy 2007) — the *why* behind place cell remapping and why place cells can bind multimodal cortical content.

---

## Convergent Evolution: Mushroom Body Place Cells

Jumping spiders (*Salticidae*) achieve allocentric spatial mapping without a hippocampus [[wiki/papers/jumping-spiders-cognition.md]]. (tentative) Electrophysiological recordings from mushroom bodies of *Habronattus dossenus* reveal neurons with place-cell-like properties:

- Selective firing at specific spatial locations within the environment
- Allocentric encoding: firing maintained when visual cues are altered — not simple visual recognition
- Mushroom bodies also serve as the cross-modal convergence zone (visual + vibrational inputs), instantiating binding [[wiki/concepts/binding-problem.md]]

**Computational implication:** the conjunctive binding computation `p = f(g, x)` is the evolutionarily conserved primitive, not the hippocampus itself. Convergent derivation in vertebrates and arthropods across 400 million years of independent evolution is the strongest available evidence that binding structural position to sensory content is the universal computational target.

---

## Connections

- **[[wiki/concepts/latent-states.md]]** — splitter cells, lap cells, and evidence cells are place cells in expanded cognitive maps; the conjunctive binding p = f(g, x) extends naturally to non-spatial task dimensions.
- **[[wiki/concepts/factorized-representations.md]]** — place cells implement the conjunctive code `p`; their environment-specific remapping while preserving grid-phase is the behavioral signature of factorization working correctly.
- **[[wiki/concepts/successor-representation.md]]** — place cells = SR rows; SR predicts their asymmetric fields, barrier fragmentation, and environment-specific character.
- **[[wiki/concepts/structural-generalization.md]]** — place cell remapping while preserving grid-phase relationships is direct evidence of the factorized split: x changes, g is preserved across environments.
- **[[wiki/entities/grid-cells.md]]** — complementary pair: grid cells define the coordinate frame; place cells instantiate it with sensory content; the split is the biological realization of the `g`/`p` factorization.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — place cells reside in HC; they make the HC component concrete, including all latent-state variants.
- **[[wiki/entities/cscg-model.md]]** — CSCG's clone cells are multiple place cell copies per observation; clone inference is the HC-local mechanism for de-aliasing place cell representations.
- **[[wiki/concepts/attention.md]]** — place cells are the memory neurons in the transformer's softmax layer; TEM-t's decomposition explains sparse spatial tuning and random remapping from attention mechanics.
- **[[wiki/concepts/engrams.md]]** — hippocampal place cells are engram cells; the DG 2–6% sparsity constraint and the causal necessity/sufficiency of engram activation match TEM's account of sparse p codes driving recall.
- **[[wiki/papers/t-tem-whittington-2022.md]]** — source for the Hopfield memory neuron interpretation; provides the mechanistic account of place cell properties and hippocampal indexing.
- **[[wiki/concepts/binding-problem.md]]** — the place cell's core function IS binding: `p = f(g, x)` combines grid-phase with sensory content into a conjunctive code; convergent evolution in jumping spider mushroom bodies confirms this binding computation is the universal computational target.
- **[[wiki/papers/jumping-spiders-cognition.md]]** — source for mushroom body place-cell analogs and cross-modal convergence zone; convergent evolution evidence that allocentric conjunctive binding is preserved across 400 Mya of independent evolution.
- **[[wiki/entities/arthropod-mushroom-bodies.md]]** — dedicated page for arthropod mushroom bodies; the jumping spider place-cell-like neurons are one component of the broader mushroom body convergent system.
- **[[wiki/concepts/convergent-allocentric-coding.md]]** — master comparative table for all systems independently evolving allocentric coding; places place cells within the broader evolutionary context.
- **[[wiki/papers/pattern-completion-rolls-2013.md]]** — source for the DG competitive learning theory of place cell formation from grid inputs; explains why both sparse DG representation and Hebbian learning are required, and why the same mechanism produces spatial view cells in primates.
- **[[wiki/papers/learning-fast-slow-liao-2024.md]]** — source for BTSP as the actual molecular mechanism of one-shot place field acquisition; establishes the mechanistic distinction between BTSP (concept, one-shot) and STDP (sequence, many-shot) within HC.
- **[[wiki/concepts/two-learning-timescales.md]]** — place cell BTSP write is the cellular implementation of the fast-M update; the field acquisition mechanism grounds the abstract "one-shot Hebbian" label in a specific dendritic plateau-potential circuit.
