---
title: "Memory Formation Depends on Both Synapse-Specific Modifications and Cell-Specific Increases in Excitability — Lisman, Cooper, Sehgal & Silva 2018"
type: paper
tags: [memory-allocation, engrams, CREB, excitability, LTP, consolidation, allocate-to-link]
created: 2026-06-21
updated: 2026-06-21
sources: [lisman-memory-allocation-2018]
related: [wiki/concepts/engrams.md, wiki/concepts/hebbian-learning.md, wiki/concepts/spike-frequency-adaptation.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/replay.md]
---

# Memory Formation Depends on Both Synapse-Specific Modifications and Cell-Specific Increases in Excitability

Lisman J, Cooper K, Sehgal M, Silva AJ. *Nat Neurosci.* 2018 Feb; 21(3):309–314. doi: 10.1038/s41593-018-0076-6

---

## Key Computational Insights

- **CREB as the molecular mechanism of memory allocation.** CREB (cAMP-responsive element-binding protein) increases neuronal excitability by reducing K⁺ conductance → smaller after-hyperpolarization (AHP) → more action potentials per current pulse. Bidirectional manipulation is clean: CREB knockdown → memory deficit; CREB overexpression → memory enhancement and predictable biasing of which cells are allocated to the engram. Excitability competition among cells therefore has a specific molecular driver, not merely a statistical baseline.

- **CREB as a coincidence detector via dual pathway.** Two independent cascades converge on CREB: (1) somatic action potentials → voltage-gated Ca²⁺ → CaM → nucleus → CaMKIV → CREB phosphorylation; (2) dendritic LTP → CaMKII → ERK diffusion to soma → CREB phosphorylation. CREB is preferentially activated only when both dendritic plasticity AND somatic spiking co-occur — a two-gate molecular filter for engram eligibility.

- **Allocate-to-link hypothesis (experimentally supported).** CREB excitability increase persists ~5–24h post-encoding. If a second memory is encoded within this window, the same CREB-elevated cells preferentially win allocation → overlapping ensembles → behavioral linking. Ca²⁺ imaging of CA1 confirms greater ensemble overlap for contexts explored 5h apart vs. 7d apart. Silencing the shared ensemble disrupts associative transfer without affecting recall of either individual memory (Yokose et al. 2017).

- **Non-homeostatic excitability vs. homeostatic SFA.** CREB-mediated excitability increase is explicitly non-homeostatic (activity → *more* excitability), the opposite of SFA (activity → raised threshold → *less* excitability) and synaptic scaling. Both mechanisms coexist: SFA provides temporal contrast/sparsification; CREB provides a tagging window for plasticity-eligible cells. They target the same K⁺ channel family but in opposite directions.

- **Assembly consolidation hypothesis (speculative).** CREB-elevated excitability in engram cells may preferentially recruit those cells into SWRs, biasing consolidation toward already-potentiated cells. Not directly tested, but mechanistically coherent: higher excitability → lower threshold for the CA3→CA1 excitatory wave to trigger spikes → higher SWR participation probability → more replay events → stronger consolidation for those cells specifically.

---

## Limitations

- Assembly consolidation hypothesis is supported only circumstantially (SWR disruption → memory deficits; CREB → excitability increase); direct causal test of CREB excitability → SWR participation is absent.
- Temporal window duration (~5h–1d) is characterized phenomenologically; the molecular decay mechanism (how CREB phosphorylation reverses) is not fully specified.
- No formal capacity analysis: unclear how many memories can share the same CREB excitability window before allocate-to-link causes unintended cross-contamination.

---

## Links

- [[wiki/concepts/engrams.md]] — CREB is the molecular mechanism behind excitability competition in engram allocation
- [[wiki/concepts/hebbian-learning.md]] — synaptic LTP (Hebbian) and cellular excitability (CREB) are complementary, not redundant, memory mechanisms
- [[wiki/concepts/spike-frequency-adaptation.md]] — CREB-AHP reduction is mechanistically opposed to SFA-AHP buildup at the same K⁺ channel family
- [[wiki/concepts/two-learning-timescales.md]] — CREB defines a third timescale (~hours) between fast-M encoding and slow-W consolidation
- [[wiki/concepts/replay.md]] — assembly consolidation hypothesis links CREB excitability to preferential SWR participation
