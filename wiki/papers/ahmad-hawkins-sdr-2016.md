---
title: "How do neurons operate on sparse distributed representations? A mathematical theory of sparsity, neurons and active dendrites"
type: paper
tags: [sdr, sparse-coding, active-dendrites, nmda, pyramidal-neurons, numenta, htm]
created: 2026-06-20
updated: 2026-06-20
sources: [sparse_representations]
related: [wiki/concepts/sparse-distributed-representations.md, wiki/entities/htm-thousand-brains.md, wiki/concepts/pattern-separation.md, wiki/concepts/engrams.md, wiki/concepts/associative-memory.md, wiki/concepts/binding-problem.md]
---

# Ahmad & Hawkins 2016 — Mathematical Theory of SDRs and Active Dendrites

**Citation:** Ahmad, S., & Hawkins, J. (2016). *How do neurons operate on sparse distributed representations? A mathematical theory of sparsity, neurons and active dendrites.* arXiv:1601.00720. Numenta, Inc.

---

## Five Key Computational Insights

1. **Active dendritic segments as independent coincidence detectors:** clusters of 8–20 synapses spatially co-localized on a dendritic branch (within 20–300 μm, synchronized within 1–5 ms) trigger NMDA spikes independently of the soma. A single distal synapse has negligible somatic effect; 8–20 co-active spatially clustered synapses generate a large regenerative NMDA spike depolarizing the cell for 50–200 ms. A pyramidal neuron with ~10,000 synapses can have >100 such independent segments, each a separate pattern detector.

2. **Scaling laws — jointly required sparsity and dimensionality:** false positive probability follows the hypergeometric distribution $P(\text{FP}) = \sum_{b=\theta}^{s} \binom{s}{b}\binom{n-s}{a-b}/\binom{n}{a}$. For $n{=}10{,}000$, $a{=}300$ (3%), $s{=}30$, $\theta{=}12$: $P \approx 10^{-27}$. Dense representations ($a/n \approx 50\%$) never achieve low error regardless of $n$; sparse representations with $n > 2000$ and $a/n < 5\%$ achieve $P \to 0$ faster than exponentially. Both conditions are individually necessary and jointly sufficient.

3. **Union property:** a single dendritic segment can store a Boolean OR of $M$ sparse patterns without pattern segregation and still detect each reliably (mix-and-match false positive < 10⁻¹¹ for $n{=}20{,}000$, $M{=}10$, $s{=}25$, $\theta{=}15$). Analysis is equivalent to Bloom filter false positive calculation. Segments can be "sloppy" — mixed synapses from multiple patterns still yield highly accurate recognition. Biological segments holding 100–400 synapses encode 4–16 patterns. Larger $\theta$ is optimal when patterns are mixed, consistent with empirical finding that longer dendritic segments have higher NMDA thresholds.

4. **NMDA spike threshold prediction from first principles:** the model predicts $\theta_\text{opt} = 9$–$20$ across a wide range ($n{:}10^4$–$2{\times}10^5$; $a/n{:}0.5$–$3\%$; $s{:}20$–$50$). Below 9: false positives rise sharply. Above 20: diminishing returns, metabolic cost of extra synapses not justified. Experimentally measured NMDA thresholds: 8–20 (Major et al. 2013). The paper *derives* an experimental result from first principles.

5. **Subsampling efficiency:** $s \ll a$ suffices for reliable recognition. With $a{=}300$, a segment sampling only $s{=}30$ synapses (10% of the active population) achieves $P(\text{FP}) \approx 10^{-27}$. Error declines exponentially with $s$; 15–25 synapses achieves $P < 10^{-10}$ across typical sparsity ranges. Explains why neurons need only a tiny random subsample of a population pattern to detect it reliably.

---

## Limitations

- Binary synapses and binary cell activations assumed; multi-valued extensions outlined qualitatively but not derived.
- Assumes random, decorrelated presynaptic activity; correlated inputs raise error rates (non-uniform distribution analysis is future work).
- Static analysis: recognition accuracy derived for fixed synaptic weights; how synaptic clusters are learned and updated via structural plasticity is discussed qualitatively (NMDA-dependent plasticity, Takahashi et al. 2012) but not formally analyzed.

---

Concept pages: [[wiki/concepts/sparse-distributed-representations.md]], [[wiki/concepts/binding-problem.md]], [[wiki/concepts/pattern-separation.md]]
Entity pages: [[wiki/entities/htm-thousand-brains.md]]
