---
title: "Sparse Distributed Representations"
type: concept
tags: [sdr, sparse-coding, neocortex, active-dendrites, nmda, pattern-recognition, capacity, htm]
created: 2026-06-20
updated: 2026-06-20
sources: [sparse_representations]
related: [wiki/concepts/pattern-separation.md, wiki/concepts/engrams.md, wiki/concepts/associative-memory.md, wiki/concepts/binding-problem.md, wiki/concepts/two-learning-timescales.md, wiki/entities/htm-thousand-brains.md, wiki/papers/ahmad-hawkins-sdr-2016.md, wiki/queries/building-blocks-mec-hc-pfc.md]
---

# Sparse Distributed Representations

**A sparse distributed representation (SDR) is a binary vector over a large neuronal population in which only ~1–5% of units are active; information is encoded in the collective *pattern* of active neurons, not in any single unit's identity.**

Ubiquitous in neocortex: 1–5% active cells across auditory, visual, somatosensory, motor, and higher-association areas; 2–6% in dentate gyrus. Sparsity is homeostatically conserved — it does not increase with stimulus intensity or change with memory valence.

---

## Key Formalism (Ahmad & Hawkins 2016)

Notation: population size $n$, active cell count $a$ ($a \ll n$), dendritic segment synapse count $s$, spike threshold $\theta$.

**Dendritic match condition:**
$$\mathbf{D} \cdot \mathbf{A}_t \geq \theta$$
where $\mathbf{D}, \mathbf{A}_t \in \{0,1\}^n$; $\cdot$ is binary dot product (count of co-active bits).

**False positive probability (hypergeometric):**
$$P(\text{FP}) = \sum_{b=\theta}^{s} \frac{\binom{s}{b}\binom{n-s}{a-b}}{\binom{n}{a}}$$

**Population false positive ($M$ independent segments):**
$$P(\text{pop FP}) \leq M \cdot P(\text{FP})$$

Numerical example: $n{=}10{,}000$, $a{=}300$ (3%), $s{=}30$, $\theta{=}12$ → $P(\text{FP}) \approx 10^{-27}$. Storing $10^6$ patterns with $s{=}30$, $\theta{=}15$: population $P(\text{FP}) < 10^{-9}$.

---

## Critical Joint Requirement

| Condition | Error behavior |
|---|---|
| Sparse ($a/n < 5\%$) + high-dim ($n > 2000$) | Drops to 0 faster than exponentially |
| Dense ($a/n \approx 50\%$) + high-dim | Remains high regardless of $n$ |
| Sparse + low-dim ($n < 500$) | Remains high |

Sparsity and dimensionality are individually necessary and jointly sufficient for robust recognition with small $s$.

---

## Union Property

A segment storing a Boolean OR of $M$ sparse patterns recognizes each reliably without segregating them:
$$\mathbf{X} = \mathbf{x}_1 \;\text{OR}\; \mathbf{x}_2 \;\text{OR}\; \cdots \;\text{OR}\; \mathbf{x}_M$$

For $n{=}20{,}000$, $a{=}100$, $M{=}10$, $s{=}25$, $\theta{=}15$: $P(\text{false mix}) < 10^{-11}$. Analysis is mathematically equivalent to Bloom filter false positive calculation. Segments with 100–400 synapses can encode 4–16 independent patterns sloppily. Biological evidence: longer dendritic segments show higher empirical NMDA thresholds (Major et al. 2008), consistent with the model's prediction that larger $\theta$ is optimal when patterns are mixed.

---

## NMDA Threshold Prediction

| $\theta$ range | Error behavior | Biological consequence |
|---|---|---|
| < 9 | False positives rise sharply | Too many spurious detections |
| 9–20 | Optimal: near-zero FP and FN | Computationally ideal |
| > 20 | Diminishing returns | Metabolic cost of extra synapses not justified |

Prediction across $n{=}10^4$–$2{\times}10^5$; $a/n{=}0.5$–$3\%$; $s{=}20$–$50$. Experimental NMDA thresholds: 8–20 (Major et al. 2013). The model *derives* this experimentally measured range from first principles.

---

## Instantiations

| System | $n$ (approx.) | Sparsity | Role |
|---|---|---|---|
| Neocortex (V1, A1, S1) | $10^4$–$10^5$/area | 1–5% | Sensory feature SDRs; abstract codes in higher areas |
| Dentate gyrus | ~$10^6$ (rat) | 2–6% | Pattern separation; episodic indexing |
| Higher cortex (ITC, PFC) | $10^4$–$10^5$ | ~5% | Abstract categorical SDRs |
| HTM cortical columns | 4,096/column | ~2% | Numenta theoretical SDR architecture |

---

## Application to Building a Reasoning Model

- **One-shot fast-M write:** subsampling property makes one-shot Hebbian learning viable — $s \ll a$ synapses per segment reliably encode a full population pattern, so a single trial of NMDA-dependent plasticity suffices [[wiki/concepts/two-learning-timescales.md]].
- **DG expansion justification:** DG expansion (10⁶ cells, 2–6% active) places episodic representations squarely in the robust regime ($n > 2000$, $a/n < 5\%$); this is the mathematical basis for the CA3 capacity formula [[wiki/concepts/pattern-separation.md]].
- **Homeostatic necessity:** error increases superexponentially if sparsity is relaxed — the homeostatically regulated engram fraction is computationally mandatory, not merely a resource constraint [[wiki/concepts/engrams.md]].
- **ML design:** any fast episodic store (Block 2D / fast-M) should maintain high-dimensional sparse activations. $k$-winners-take-all is the exact analog; softmax with low temperature is an approximation. Full-density hidden states (standard LSTM) do not benefit from SDR scaling laws.

---

## Open Problems

1. How does SDR sparsity arise in higher cortical areas that lack a DG-like expansion + competitive inhibition circuit?
2. Optimal sparsity is derived for recognition accuracy; what is the trade-off with reconstruction capacity and compositional generalization?
3. The analysis assumes stationary random distributions; how do structural plasticity dynamics (synapses added/removed over time) interact with the Bloom-filter-like union property?

---

## Connections

- **[[wiki/concepts/pattern-separation.md]]** — DG creates the sparse, high-dimensional vectors whose recognition properties the SDR framework formalizes; the capacity formula $p_\text{max} \approx k \times C_{RC}/a$ depends on sparse $a$ because SDR scaling laws guarantee near-zero interference at DG sparsity levels.
- **[[wiki/concepts/engrams.md]]** — excitability competition enforces the homeostatic sparse fraction required for SDR noise immunity; the 2–6% DG and 20–30% amygdala/HC fractions sit in the regime where the scaling laws yield negligible false positive rates.
- **[[wiki/concepts/associative-memory.md]]** — the Hopfield binary dot product overlap metric is identical to the SDR overlap metric; Hopfield's ~0.14N capacity limit applies to dense random patterns, whereas SDRs with high $n$ and low $a$ achieve far higher effective capacity per the Ahmad & Hawkins scaling laws.
- **[[wiki/concepts/binding-problem.md]]** — NMDA spikes triggered by co-localized synaptic clusters (8–20 synapses, 20–300 μm, 1–5 ms synchrony) implement local dendritic binding: a segment detects a specific presynaptic co-activity pattern as a single non-linear event without requiring soma-level integration.
- **[[wiki/entities/htm-thousand-brains.md]]** — HTM/TBT is Hawkins's computational framework built entirely on SDR theory; this paper provides the mathematical foundation for why sparse columnar representations enable reliable sensorimotor inference and large-scale pattern storage.
- **[[wiki/concepts/two-learning-timescales.md]]** — the subsampling property of SDRs explains why one-shot Hebbian fast-M write is viable: $s \ll a$ synapses suffice to encode a full population pattern, making single-trial synapse formation practical at biologically realistic timescales.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — SDR format is the representation substrate assumed by Block 2B (HC autoassociative pattern completion) and Block 2D (sparse engram allocation); both require $n \gg s$ and $a/n \ll 1$ to achieve low-interference episodic storage.
