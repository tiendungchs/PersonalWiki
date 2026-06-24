---
title: "Thousand Brains Theory / HTM"
type: entity
tags: [thousand-brains, htm, cortical-columns, sensorimotor, numenta, hawkins]
created: 2026-06-12
updated: 2026-06-20
sources: [150000-mini-brain-transcript, convergence-wiring-transcript, reservoir-computing-transcript, sparse_representations]
related: [wiki/concepts/factorized-representations.md, wiki/concepts/path-integration.md, wiki/concepts/structural-generalization.md, wiki/concepts/small-world-networks.md, wiki/concepts/canonical-microcircuit.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/grid-cells.md, wiki/entities/tem-model.md, wiki/entities/reservoir-computing.md, wiki/concepts/predictive-coding.md, wiki/concepts/sparse-distributed-representations.md, wiki/papers/150000-mini-brain-transcript.md, wiki/papers/convergence-wiring-transcript.md, wiki/papers/reservoir-computing-transcript.md, wiki/papers/ahmad-hawkins-sdr-2016.md]
---

# Thousand Brains Theory / HTM

**Hawkins & Numenta's proposal that neocortex = ~150,000 independent world models (cortical columns), each miniaturizing the hippocampal-entorhinal formation to build reference-frame-based representations via sensorimotor coupling.**

---

## Architecture

Each cortical column implements the full HC formation circuit:

| Layer | Role | HC analog |
|-------|------|-----------|
| L1 | Top-down prediction from higher columns | — |
| L2-3 | Binding (what × where); lateral consensus voting | HC (place cells / conjunctive code p) |
| L4 | Sensory input ("what") | LEC (sensory code x) |
| L5 | Motor output; efference copy to L6 | — |
| L6 | Grid-like path integration ("where") | MEC (structural code g) |

The L5→L6 efference copy loop is the key addition over the bare HC formation: the column *generates* its "where" signal from its own motor predictions rather than receiving it from a dedicated MEC.

---

## Key Claims

- **Perception = sensorimotor loop:** passive sensory input (L4 alone) provides "what" without "where" — insufficient for a unique prediction; the column must act or predict action to localize itself.
- **Consensus voting:** lateral L2-3 connections propagate consistency signals; columns with agreeing hypotheses mutually excite; inconsistent ones suppress via E/I dynamics; percept emerges from convergence without hierarchical readout.
- **Hierarchical abstraction:** L5 output of one column → sensory input of a higher column; higher columns navigate increasingly abstract reference frames (sensory features → objects → concepts) using identical L6 path integration.
- **Universal cortical algorithm:** structural generalization is not a specialization of MEC but the universal cortical primitive — evolution solved it by transplanting the HC formation 150,000 times.
- **SDR as the representational substrate:** every columnar computation in HTM (Hierarchical Temporal Memory) assumes high-dimensional sparse representations (~2% active out of 4,096 mini-columns per column). Ahmad & Hawkins 2016 [[wiki/papers/ahmad-hawkins-sdr-2016.md]] formally proves that SDR (Sparse Distributed Representations) recognition achieves $P(\text{FP}) \approx 10^{-27}$ with just 30 synapses per dendritic segment — the mathematical justification for why sparse columnar coding enables reliable large-scale pattern storage despite noisy, incomplete inputs.

---

## Comparison to TEM

| Dimension | TEM | TBT (Thousand Brains Theory) |
|-----------|-----|-----|
| Architecture basis | Formal generative model (variational) | Anatomical / evolutionary |
| Number of world models | 1 | ~150,000 |
| g update | Explicit W-parameterized RNN | L6 grid-like neurons via efference copy |
| Perception | Sequential inference | Distributed columnar consensus |
| Validation | Computational (emergent cell types) | Anatomical (cortical layer correspondence) |

Both independently arrive at g/x/p factorization: TEM from the outer-product memory structure; TBT (Thousand Brains Theory) from the cortical layer anatomy.

---

## Limitations

- No computational validation at the claimed 150,000-column scale.
- Consensus voting convergence properties unproven.
- Efference copy as path integration driver confirmed in motor cortex; unconfirmed in sensory/association cortex.
- Evolutionary HC→column claim is interpretive; significant circuit differences exist between HC and neocortex.

---

## Connections

- **[[wiki/concepts/factorized-representations.md]]** — TBT (Thousand Brains Theory) independently derives g/x/p from cortical anatomy (L6/L4/L2-3); anatomical convergence with TEM's formal derivation strengthens the case that factorization is architecturally necessary, not a modeling convenience.
- **[[wiki/concepts/path-integration.md]]** — L6 grid-like path integration via efference copy is TBT's structural code update; extending this to every cortical column makes path integration a proposed universal cortical primitive, not a MEC specialization.
- **[[wiki/concepts/structural-generalization.md]]** — if every column runs the factorized world-model circuit, structural generalization is the organizing principle of the entire neocortex, not a specialization; strengthens the universality of the feasibility argument.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — TBT (Thousand Brains Theory) proposes the HC formation as evolutionary template; each cortical column recapitulates MEC/LEC/HC as L6/L4/L2-3 with an added L5 efference copy loop.
- **[[wiki/entities/grid-cells.md]]** — TBT (Thousand Brains Theory) proposes grid-cell-like L6 neurons in every cortical column; if confirmed, grid-like path integration is universal rather than an MEC specialization.
- **[[wiki/entities/tem-model.md]]** — complementary derivations of the same architecture; TEM provides formal validation (emergent cell types, zero-shot transfer); TBT (Thousand Brains Theory) provides anatomical grounding and evolutionary motivation.
- **[[wiki/concepts/predictive-coding.md]]** — TBT's L1 (top-down prediction) vs. L4 (sensory input) circuit is structurally identical to PC's two-population architecture (representational vs. error neurons); the frameworks converge on the same cortical organization from different starting points.
- **[[wiki/papers/150000-mini-brain-transcript.md]]** — primary source.
- **[[wiki/concepts/small-world-networks.md]]** — ~150,000 cortical columns are locally-clustered processing modules (high C within each column) with lateral L2-3 consensus voting connections acting as inter-module shortcuts (short L) enabling rapid cross-column hypothesis convergence — TBT (Thousand Brains Theory) describes a biological small-world architecture instantiated at the column scale.
- **[[wiki/papers/convergence-wiring-transcript.md]]** — source for the small-world topology framework that frames TBT's columnar architecture as modules + shortcuts.
- **[[wiki/entities/reservoir-computing.md]]** — the transcript explicitly frames the neocortex as a reservoir of cortical columns: fixed anatomical wiring = reservoir W_res; theta/gamma oscillations = pacemaker signal; learned plasticity = linear readout; TBT's columnar architecture is the structured biological counterpart to the idealized random reservoir.
- **[[wiki/papers/reservoir-computing-transcript.md]]** — source for the neocortex-as-reservoir framing of TBT.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — HTM (Hierarchical Temporal Memory) is built entirely on SDR (Sparse Distributed Representations) theory; Ahmad & Hawkins 2016 (co-authored by Hawkins) formally proves that the sparse columnar representations TBT (Thousand Brains Theory) assumes achieve near-zero false positive rates with only 20–30 synapses per dendritic segment, providing the mathematical foundation for HTM's pattern recognition claims.
- **[[wiki/papers/ahmad-hawkins-sdr-2016.md]]** — primary mathematical source for TBT's SDR (Sparse Distributed Representations) representational substrate.
- **[[wiki/concepts/canonical-microcircuit.md]]** — TBT's layer anatomy (L4=sensory, L2/3=consensus/binding, L6=path integration, L5=output) is a specific instantiation of the canonical L4→L2/3→L5→L6→L4 loop; TBT's lateral L2/3 consensus voting is the canonical horizontal WTA (Winner-Take-All) mechanism applied across 150,000 columns rather than within patches of one area.
