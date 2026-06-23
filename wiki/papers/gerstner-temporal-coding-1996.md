---
title: "A neuronal learning rule for sub-millisecond temporal coding — Gerstner, Kempter, van Hemmen & Wagner 1996"
type: paper
tags: [STDP, temporal-coding, phase-locking, auditory-system, hebbian-learning, integrate-and-fire, population-coding]
created: 2026-06-22
updated: 2026-06-22
sources: [A neuronal learning rule for sub-millisecond temporal coding]
related: [wiki/concepts/hebbian-learning.md, wiki/concepts/temporal-coding.md, wiki/concepts/phase-precession.md, wiki/papers/bi-poo-stdp-1998.md]
---

# A neuronal learning rule for sub-millisecond temporal coding

**Gerstner W., Kempter R., van Hemmen J.L., Wagner H. (1996). Nature, 383, 76–78.**

---

## Key Computational Insights

- **STDP window derived from auditory temporal coding, two years before Bi & Poo.** The asymmetric learning window W(s) — strengthen if presynaptic spike arrives before postsynaptic firing (s < 0), weaken if after (s > 0) — is derived here from the requirement that synaptic delays match to produce coherent input convergence in the barn owl auditory system. The rule shape matches Bi & Poo 1998's hippocampal culture measurements; two independent biological problems yield the same learning rule.

- **Sub-millisecond precision paradox resolved by coherent convergence.** A single integrate-and-fire neuron achieves ~25 µs firing precision despite EPSPs 250 µs wide and τ_m ~100 µs. Mechanism: when 154+ phase-locked inputs arrive coherently, the summed postsynaptic potential oscillates; firing always occurs on the *rising edge*, so jitter is set by EPSP slope rather than width. Precision is finer than any single neuron's time constant.

- **Hebbian delay selection structures axonal ensembles.** Before learning, axons arrive at the laminar nucleus with delays drawn from a Gaussian (~2.5 ± 0.3 ms). W(s) iteratively strengthens connections whose delays differ by exact multiples of the stimulus period T, creating a delay-line ensemble that produces coherent convergence. The same rule selects complementary delay sets from the left and right ear for binaural ITD tuning.

- **ITD tuning emerges from delay selection, not explicit encoding.** With left/right ear inputs trained jointly under a fixed ITD, W(s) selects bilateral delay pairs that maximize coherent convergence at exactly that ITD. Output phase locking peaks at training ITD and collapses at ITD = T/2. ITD selectivity is a structural consequence of delay matching, not a separately computed variable.

- **Population coding provides a second tier of temporal precision.** ~100 independent laminar neurons each at 20–25 µs single-cell precision achieve 5 µs population-level ITD estimation via population vector decoding — matching the barn owl's behavioural requirement (<5 µs). Accuracy scales as $1/\sqrt{tN}$, consistent with the central limit theorem.

---

## Limitations

- Derived for a highly specialised auditory system with extremely short τ_m (~100 µs); cortical neurons have τ_m ~10–20 ms, making direct application speculative; the authors estimate a ~100× rescaling may extend the principle to temporal codes with 1–3 ms precision.
- W(s) shape is hand-tuned (two-regime exponential); Bi & Poo 1998 subsequently provided NMDA Mg²⁺-unblock kinetics as the molecular grounding for the window.
- No account of how the broad delay distribution is initially established developmentally before learning begins.

---

## Related Wiki Pages

- [[wiki/concepts/hebbian-learning.md]] — Gerstner 1996 is the earlier independent derivation of the STDP window from temporal coding requirements rather than hippocampal co-activation statistics.
- [[wiki/concepts/temporal-coding.md]] — the precision paradox, coherent convergence principle, and population amplification are the core temporal coding concepts introduced here.
- [[wiki/concepts/phase-precession.md]] — phase locking in auditory neurons is structurally analogous to theta-phase coding: spike timing relative to a reference oscillation carries information beyond rate.
- [[wiki/papers/bi-poo-stdp-1998.md]] — later, empirically stronger STDP characterisation; provides NMDA Mg²⁺-unblock as molecular grounding for the window shape that Gerstner 1996 lacks.
