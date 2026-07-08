---
title: "Place Cells"
type: entity
tags: [place-cells, hippocampus, latent-states, successor-representation, conjunctive-code]
created: 2026-06-09
updated: 2026-06-27
sources: [t-TEM, engram-transcript, jumping-spiders-cognition, The mechanisms for pattern completion and pattern separation in the hippocampus, Learning Fast and Slow Single- and Many-Shot Learning in the Hippocampus, spiking-tem-kawahara-2025, nieh-hippocampal-geometry-2021, sun-hippocampal-osm-2025, valero-interneuron-families-2025]
related: [wiki/concepts/latent-states.md, wiki/concepts/factorized-representations.md, wiki/concepts/successor-representation.md, wiki/concepts/structural-generalization.md, wiki/concepts/attention.md, wiki/concepts/engrams.md, wiki/concepts/binding-problem.md, wiki/concepts/convergent-allocentric-coding.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/excitation-inhibition-balance.md, wiki/concepts/btsp.md, wiki/concepts/temporal-context.md, wiki/entities/grid-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/cscg-model.md, wiki/entities/arthropod-mushroom-bodies.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/engram-transcript.md, wiki/papers/jumping-spiders-cognition.md, wiki/papers/pattern-completion-rolls-2013.md, wiki/papers/learning-fast-slow-liao-2024.md, wiki/papers/spiking-tem-kawahara-2025.md, wiki/papers/nieh-hippocampal-geometry-2021.md, wiki/papers/sun-hippocampal-osm-2025.md, wiki/papers/valero-interneuron-families-2025.md, wiki/papers/wu-maass-btsp-2025.md, wiki/papers/tcm-mtl-howard-2005.md]
---

# Place Cells

**Neurons in hippocampus that fire sparsely at specific locations — the biological implementation of the conjunctive code `p = f(g, x)`, binding structural position to sensory content.**

---

## Key Properties

- **Sparse, location-specific firing** — one (or few) place fields per environment
- **Context-dependent remapping** — different cells activate, or same cells at different locations, across environments
- **Non-random remapping:** cells remap to positions consistent with their grid-phase input (verified Barry 2012, Chen 2018); x changes, g-phase is preserved
- **One-shot binding via BTSP:** place fields emerge in a single trial through behavioral timescale synaptic plasticity (BTSP; Bittner et al. 2017) — an EC3-instructed dendritic plateau potential opens a ~10s plasticity window; binary weights updated with stochastic ±1 rule (probability 0.5 per synapse) depending on current weight value and timing relative to plateau onset; gating parameter $f_q$ ≈ 0.005 (plateau probability per pattern) distributes place field allocation uniformly across CA1 neurons; the resulting bimodal weight distribution (plateau-gated neurons vs. others) enables recall from up to 33% masked input cues (Wu & Maass 2025 [[wiki/papers/wu-maass-btsp-2025.md]]); LTD branch actively pushes apart memory traces for similar spatial contexts (repulsion effect); first synapse-level in vivo confirmation: Fan et al. 2023; Gonzalez et al. 2023; see [[wiki/concepts/btsp.md]] for full formalism

## SR (Successor Representation) Rows

Rows of S = (I−γT)^{−1} spatially resemble place cells — peaked, environment-specific fields encoding expected future occupancy rather than just current location. SR (Successor Representation) predictions verified empirically:

- **Asymmetric place fields** (Mehta 2000): fields skew backward along running direction
- **Barrier-induced fragmentation** (Derdikman 2009): inserting a barrier fragments place fields predictably

## Origin: DG (Dentate Gyrus) Competitive Learning from Grid Inputs (Rolls 2013)

Place cells do not form directly from MEC grid cells; the dentate gyrus (DG) is the critical intermediary. Rolls 2013 ([[wiki/papers/pattern-completion-rolls-2013.md]]) shows that DG (Dentate Gyrus) competitive learning (Hebbian synapses + strong inhibitory interneurons) transforms grid cell input into place-like fields:

1. Each DG (Dentate Gyrus) granule cell learns to respond to a specific *combination* of co-active grid cells — that combination uniquely defines a place.
2. DG (Dentate Gyrus) projects to CA3 via only ~46 mossy fiber synapses per CA3 cell — a sparse random projection that forces *maximally different* CA3 representations per episode regardless of input similarity.
3. Both sparse DG (Dentate Gyrus) representation and Hebbian learning are required; fixed random feed-forward weights alone produce broad overlapping fields.

**Primate adaptation:** The same mechanism produces *spatial view cells* rather than place cells. The primate fovea covers ~10-20° (vs. rat's ~180-270°), so the DG (Dentate Gyrus) combination encodes a viewed patch in space rather than a body location. This unifies the rodent and primate HC literatures under a single DG (Dentate Gyrus) competitive learning account.

---

## The "Place" Code Is a History-Dependent Pseudo-Place Code (TCM)

Howard et al. 2005 [[wiki/papers/tcm-mtl-howard-2005.md]] argue the entorhinal "place" code is not a representation of position at all, but a **leaky-integrated trace of recent movements** — `t_i = ρ_i t_{i-1} + β·velocity`. Position is merely a *correlate*, because the set of paths reaching a location constrains the accumulated trace:

- **Place-like fields emerge from kinematics** — a cell tuned to "East" fires along the East wall because East movements cannot reach the West wall; the field location follows the cell's preferred head direction.
- **Topological consistency across enclosures** — the same field appears in square and circular arenas (matches Quirk et al. 1992 EC), because analogous positions share analogous approach paths. EC does *not* remap; HC does (via DG → downstream x-change).
- **History-dependence is the signature** — retrospective/trajectory coding (same location, different approach → different firing; Frank et al. 2000 W-maze) is a *prediction*, not an anomaly. A pure positional code cannot produce it.

This reframes place cells as **episode indices**: the leaky trajectory trace simultaneously localizes *and* disambiguates which episode is unfolding — the same property that later makes TEM's `g` a structural code rather than a coordinate.

---

## Latent State Variants

In tasks with hidden task-relevant variables, the cognitive map expands to include those dimensions — place cells tile the expanded space:

| Task | Hidden dimension | Cell type |
|------|-----------------|-----------|
| T-maze alternation | Trial direction (L/R) | Splitter cells |
| 4-lap reward task | Lap number | Lap-specific cells |
| Tower accumulation | Cue evidence difference | Evidence cells: 2D firing fields in joint (position × evidence) space; ~29% of CA1 neurons, ~1.7 fields/cell (Nieh et al. 2021) |

All are place cells in a higher-dimensional cognitive map. See [[wiki/concepts/latent-states.md]].

---

## State Cells: A Continuum, Not a Type (Sun et al. 2025)

Traditional terminology (place cells, splitter cells, lap cells) implies discrete categories. Sun et al. 2025 ([[wiki/papers/sun-hippocampal-osm-2025.md]]) show this is incorrect: CA1 neurons occupy a 2D continuum defined by:

- **Difference score** — fractional difference in peak activity between the two trial types (high = strong splitter)
- **Correlation coefficient** — similarity of spatial tuning profiles across trial types (high = place-like)

This space is continuously populated. Cells transition between regions during learning:
- Cells tuned to track start/end → rapid convergence to pure place-like (high correlation, low difference)
- Indicator-tuned cells → rapid convergence to pure splitter (high difference)
- Pre-reward cells → slow transition from place-like to splitter (the cells that matter for orthogonalization)

**The implication:** CA1 neurons do not commit permanently to functional roles. They are plastic state cells whose response profile is determined by task experience. The population-level OSM emerges from individual neurons progressively narrowing their tuning to specific latent states — not from pre-existing cell types being selectively activated.

---

## Sparsity and Remapping in Spiking TEM

Spiking TEM ([[wiki/papers/spiking-tem-kawahara-2025.md]]) reproduces two place cell properties in a biologically plausible spiking model without explicit silence rules:

- **Silent cells:** 50.3% of CA1 neurons remain silent per environment (matches in vivo ~60%); DG (Dentate Gyrus) shows 90% silence (vs. 85.8% in vivo) — confirming sparse place coding is a natural consequence of theta-gated inhibitory drive plus hippocampal sparsity loss, not a post-hoc constraint.
- **Global remapping with preserved grid structure:** when sensory inputs change (one-hot → two-hot), CA1 place fields remap globally while MECII maintains its gridness, confirming that the g/x/p factorization holds in a biologically plausible spiking implementation.

Theta inhibitory modulation is the proximate cause of CA1 sparsity: removing it eliminates spatial tuning before training is even attempted (Fig. 4B,C).

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

## Interneuron Cooperative Control of Place Field Features (Valero et al. 2025)

Four GABAergic interneuron families cooperatively gate distinct spatial coding dimensions of CA1 pyramidal cells [[wiki/papers/valero-interneuron-families-2025.md]]:

| Family | Place field property | Optogenetic evidence | Anatomical target |
|---|---|---|---|
| **Pvalb** | Spatial stability | Suppresses first half (EC input phase) | Soma/AIS perisomatic |
| **Sst** (OLM) | Context generalization (L/R arm) | Suppresses second half (CA3 recurrent phase) | Distal apical dendrites |
| **Vip** | Space-rate MI, selectivity | Boosts amplitude via Sst disinhibition | Suppresses Sst/OLM |
| **Id2** | Context specificity | Suppresses second half; broad Id2→Sst/Pvalb coupling | Neurogliaform + CCK basket |

**Time-division control:** entorhinal cortex (EC) provides dominant excitation in the first half of the place field; CA3 recurrent input dominates the second half. As the animal traverses the field, the place cell–OLM (Sst) synapse potentiates, weakening EC input while CA3 drive grows. Pvalb timing gates the EC phase; Sst/Id2 gate the CA3 phase.

**VIP disinhibitory gate:** Vip → suppresses Sst/OLM → releases distal dendritic compartments → strongest place field amplitude boost of any family. This is the biological implementation of a context-sensitive gain modulator — Vip activation modulates encoding gain without altering the structural code.

**Interneurons as active spatial coders:** interneuron-only CEBRA position decoder matches an equal-count pyramidal cell decoder; omitting any single family significantly degrades decoding accuracy (Vip, Id2, Pvalb exclusions most damaging). Inhibitory cells are active participants in spatial coding, not passive normalizers.

**(brainstorm) ML design implication:** a differentiable memory module with four inhibitory sub-circuits — each controlling a different representational property (stability, generalization, gain, specificity) — would enable post-hoc modulation of stored representations without rewriting their content.

---

## Connections

- **[[wiki/concepts/temporal-context.md]]** — TCM derives the entorhinal place code as a leaky-integrated velocity history (a "pseudo-place code"), explaining topological cross-enclosure consistency and predicting retrospective/trajectory coding that a pure positional code cannot; recasts place cells as episode indices.
- **[[wiki/concepts/latent-states.md]]** — splitter cells, lap cells, and evidence cells are place cells in expanded cognitive maps; the conjunctive binding p = f(g, x) extends naturally to non-spatial task dimensions.
- **[[wiki/concepts/factorized-representations.md]]** — place cells implement the conjunctive code `p`; their environment-specific remapping while preserving grid-phase is the behavioral signature of factorization working correctly.
- **[[wiki/concepts/successor-representation.md]]** — place cells = SR (Successor Representation) rows; SR (Successor Representation) predicts their asymmetric fields, barrier fragmentation, and environment-specific character.
- **[[wiki/concepts/structural-generalization.md]]** — place cell remapping while preserving grid-phase relationships is direct evidence of the factorized split: x changes, g is preserved across environments.
- **[[wiki/entities/grid-cells.md]]** — complementary pair: grid cells define the coordinate frame; place cells instantiate it with sensory content; the split is the biological realization of the `g`/`p` factorization.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — place cells reside in HC; they make the HC component concrete, including all latent-state variants.
- **[[wiki/entities/cscg-model.md]]** — CSCG's clone cells are multiple place cell copies per observation; clone inference is the HC-local mechanism for de-aliasing place cell representations.
- **[[wiki/concepts/attention.md]]** — place cells are the memory neurons in the transformer's softmax layer; TEM-t's decomposition explains sparse spatial tuning and random remapping from attention mechanics.
- **[[wiki/concepts/engrams.md]]** — hippocampal place cells are engram cells; the DG (Dentate Gyrus) 2–6% sparsity constraint and the causal necessity/sufficiency of engram activation match TEM's account of sparse p codes driving recall.
- **[[wiki/papers/t-tem-whittington-2022.md]]** — source for the Hopfield memory neuron interpretation; provides the mechanistic account of place cell properties and hippocampal indexing.
- **[[wiki/concepts/binding-problem.md]]** — the place cell's core function IS binding: `p = f(g, x)` combines grid-phase with sensory content into a conjunctive code; convergent evolution in jumping spider mushroom bodies confirms this binding computation is the universal computational target.
- **[[wiki/papers/jumping-spiders-cognition.md]]** — source for mushroom body place-cell analogs and cross-modal convergence zone; convergent evolution evidence that allocentric conjunctive binding is preserved across 400 Mya of independent evolution.
- **[[wiki/entities/arthropod-mushroom-bodies.md]]** — dedicated page for arthropod mushroom bodies; the jumping spider place-cell-like neurons are one component of the broader mushroom body convergent system.
- **[[wiki/concepts/convergent-allocentric-coding.md]]** — master comparative table for all systems independently evolving allocentric coding; places place cells within the broader evolutionary context.
- **[[wiki/papers/pattern-completion-rolls-2013.md]]** — source for the DG (Dentate Gyrus) competitive learning theory of place cell formation from grid inputs; explains why both sparse DG (Dentate Gyrus) representation and Hebbian learning are required, and why the same mechanism produces spatial view cells in primates.
- **[[wiki/papers/learning-fast-slow-liao-2024.md]]** — source for BTSP as the actual molecular mechanism of one-shot place field acquisition; establishes the mechanistic distinction between BTSP (concept, one-shot) and STDP (sequence, many-shot) within HC.
- **[[wiki/concepts/two-learning-timescales.md]]** — place cell BTSP write is the cellular implementation of the fast-M update; the field acquisition mechanism grounds the abstract "one-shot Hebbian" label in a specific dendritic plateau-potential circuit.
- **[[wiki/papers/spiking-tem-kawahara-2025.md]]** — source for biologically realistic silent-cell proportions and global remapping under sensory context change in a spiking TEM; theta inhibition is the proximate cause of CA1 sparsity and spatial tuning.
- **[[wiki/papers/nieh-hippocampal-geometry-2021.md]]** — evidence cells as the canonical empirical instance of place cells in a higher-dimensional cognitive map: ~29% of CA1 neurons tile the joint (position × evidence) manifold with 2D firing fields, and ~70% of that manifold geometry is shared across animals.
- **[[wiki/papers/sun-hippocampal-osm-2025.md]]** — establishes that place/splitter/lap cell distinctions are points on a 2D continuum (difference score × correlation) rather than discrete categories; shows individual CA1 neurons dynamically shift response profiles during learning, so functional role is not fixed but is an expression of task experience.
- **[[wiki/concepts/prospective-coding.md]]** — spatial preplay at choice points (place cell sequences of candidate future paths) is the spatial instance of prospective coding; the same CA1 look-ahead operation that generates spatial preplay also generates the non-spatial X→Y prediction during sensory preconditioning inference.
- **[[wiki/papers/valero-interneuron-families-2025.md]]** — source for interneuron division of labor in place field coding: Pvalb→stability, Sst→generalization, Vip→gain/MI, Id2→specificity; VIP disinhibitory gate; time-division control of EC vs. CA3 input phases across the field.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the four interneuron families are the cell-type decomposition of the E/I parameter; each shapes a distinct spatial coding dimension that the global E/I ratio collapses into a single number.
- **[[wiki/concepts/btsp.md]]** — dedicated concept page for BTSP: the molecular write mechanism for place fields; formalization of the binary stochastic rule, bimodal distribution enabling masking-robust recall, stochastic gating parameter $f_q$, and the repulsion effect for similar spatial contexts.
- **[[wiki/papers/wu-maass-btsp-2025.md]]** — establishes that binary-weight BTSP achieves Hopfield-equivalent CAM quality for sparse inputs; provides the analytical theory for memory trace properties and demonstrates the repulsion effect of the LTD branch.
