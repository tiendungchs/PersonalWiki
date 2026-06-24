---
title: "Bio-inspired computational memory model of the Hippocampus: An approach to a neuromorphic spike-based Content-Addressable Memory"
type: paper
tags: [hippocampus, CA3, spiking-neural-networks, content-addressable-memory, STDP, neuromorphic, SpiNNaker, pattern-separation]
created: 2026-06-23
updated: 2026-06-23
sources: [Bio-inspired computational memory model of the Hippocampus An approach to a neuromorphic spike-based Content-Addressable Memory]
related: [wiki/concepts/associative-memory.md, wiki/concepts/hebbian-learning.md, wiki/concepts/pattern-separation.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/snn.md, wiki/concepts/sparse-distributed-representations.md]
---

# Bio-inspired Spiking Hippocampal CAM (Content-Addressable Memory) — Casanueva-Morato et al. 2024

*Neural Networks 177, 106474. DOI: 10.1016/j.neunet.2024.106474.*

---

## Key Computational Insights

- **Bidirectional CAM (Content-Addressable Memory) via dual STDP structures.** CA3 is modeled as two parallel recurrent sub-networks: S1 (cue→content, forward STDP synapses) and S2 (content→cue, reverse STDP synapses). Both learn simultaneously during storage, enabling *recall from any fragment*. No prior spiking CAM (Content-Addressable Memory) achieved bidirectional retrieval.
- **STDP encodes and forgets implicitly.** Learning a new memory with a reused cue automatically triggers forgetting of the old one: during storage, the old content is recalled first (activating post-before-pre on those synapses → LTD), then the new content is encoded (pre-before-post → LTP). No separate forgetting operation is needed.
- **Interneuron gating via spike-timing delay.** S2Int and S2Cond interneurons use a 1 ms excitatory/inhibitory race to block the content pathway during recall-by-cue (inhibition arrives first) while passing it during learning or recall-by-content (excitation arrives simultaneously or first). Temporal delays alone implement a functionally complex routing gate.
- **DG modeled as maximum-sparsity one-hot encoder.** The cue sub-field is assumed to undergo maximum DG (Dentate Gyrus) pattern separation → one-hot coding; content sub-field keeps its natural encoding. This is the architectural mechanism enabling non-orthogonal pattern handling without prior spiking CAM (Content-Addressable Memory) proposals achieving this.
- **First SpiNNaker hardware implementation.** Full functional validation on the SpiNNaker neuromorphic platform (1 ms time step); 6 time-step latency per recall operation; parameterized for arbitrary memory size.

---

## Limitations

- Cue must be pre-orthogonalized (one-hot); the DG (Dentate Gyrus) encoding network is assumed, not implemented.
- Content-based recall returns all cues that *partially* match, not the complete stored memory — requires a second cue-recall step.
- Residual STDP weight degeneration accumulates across many operations due to SpiNNaker's non-zero baseline STDP increment.

---

## Links to Concept / Entity Pages

- [[wiki/concepts/associative-memory.md]] — places this architecture within the CAM (Content-Addressable Memory) taxonomy; adds to the spiking CAM (Content-Addressable Memory) instantiation row
- [[wiki/entities/hippocampal-entorhinal-system.md]] — sharpens the CA3 operational model with a concrete SNN architecture
- [[wiki/concepts/hebbian-learning.md]] — STDP forgetting as a natural consequence of the learning rule's LTD (Long-Term Depression) branch
- [[wiki/concepts/pattern-separation.md]] — DG (Dentate Gyrus) one-hot encoding as the practical maximum-sparsity limit of DG (Dentate Gyrus) pattern separation
- [[wiki/entities/snn.md]] — SpiNNaker hardware implementation; STDP-based unsupervised content-addressable memory
