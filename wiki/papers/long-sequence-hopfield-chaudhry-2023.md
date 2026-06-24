---
title: "Long Sequence Hopfield Memory"
type: paper
tags: [associative-memory, sequence-memory, hopfield, hebbian-learning, dense-associative-memory, motor-control, basal-ganglia, capacity-scaling]
created: 2026-06-22
updated: 2026-06-22
sources: [Long Sequence Hopfield Memory]
related: [wiki/concepts/associative-memory.md, wiki/concepts/sequence-memory.md, wiki/concepts/hebbian-learning.md, wiki/entities/basal-ganglia.md, wiki/concepts/working-memory.md, wiki/concepts/phase-precession.md]
---

# Long Sequence Hopfield Memory

**Chaudhry HT, Zavatone-Veth JA, Krotov D, Pehlevan C — NeurIPS 2023 (Harvard / MIT-IBM Watson AI Lab)**

---

## Key Computational Insights

- **DenseNet extends Modern Hopfield Networks to sequence storage** by replacing symmetric Hebbian weights with asymmetric ones ($J_{ij} = \frac{1}{N}\sum_\mu \xi_i^{\mu+1}\xi_j^\mu$) and applying a nonlinear interaction function $f$ to inter-pattern overlaps. The same nonlinearity that boosts static MHN (Modern Hopfield Network) capacity from linear to polynomial/exponential also boosts sequence capacity via identical crosstalk reduction mathematics.

- **Capacity scaling:** Polynomial DenseNet ($f(x)=x^d$) achieves single-transition capacity $P_T \sim N^d$ — identical to static MHN (Modern Hopfield Network) — and sequence capacity $P_S \sim N^d / d$. Exponential DenseNet ($f(x)=\exp((N{-}1)(x{-}1))$) achieves super-polynomial capacity, but the Gaussian crosstalk approximation breaks down at finite $N$ (lognormal regime); empirical simulations confirm dramatic improvement over polynomial variants.

- **MixedNet — variable-timing sequences:** $\mathbf{S}(t+1) = \text{sign}(f_S(m^\mu(t)) + \lambda\, f_A(\bar{m}^\mu(t)))$. $f_S$ (fast, symmetric synapse) stabilizes the network in the current state for $\tau$ timesteps; $f_A$ (slow, asymmetric synapse) drives the transition to the next state. Capacity scales as $\min(d_S, d_A)$. Demonstrated: $d=10$ recovers both correct sequence order and variable timing at $P=40, N=100$ where the linear TAN model fails entirely.

- **Generalized pseudoinverse (GPI) rule** extends Kanter & Sompolinsky 1987 to DenseNet nonlinearities: decorrelates patterns via the pseudoinverse of the overlap matrix $O^+$ before applying $f$. For linearly independent patterns, GPI achieves perfect recall regardless of correlation — demonstrated on 200,000-frame MovingMNIST with perfect recall under exponential nonlinearity + GPI.

- **Biologically plausible bipartite implementation** reformulates $d{+}1$-body synapses as two-body synapses via visible neurons $v$ (motor cortex) and hidden neurons $h$ (thalamic units, each encoding a motor motif) with weight matrices $W$ (cortex→thalamus) and $M$ (thalamus→cortex). The basal ganglia inhibits/disinhibits specific thalamic hidden neurons for context-dependent sequence gating — structurally mapping to the cortico-basal ganglia-thalamo-cortical (CBGT) loop.

---

## Limitations

- Analysis restricted to discrete-time, binary (±1) patterns; continuous-time and continuous-valued extensions unaddressed.
- Exponential DenseNet capacity theory is approximate (Gaussian crosstalk assumption fails at finite $N$ due to lognormal regime); accurate capacity prediction requires Edgeworth-series corrections beyond the current analysis.
- GPI rule for exponential nonlinearity suffers numerical instability; correlated-pattern capacity is not analytically derived — only empirically tested.

---

## Links

- [[wiki/concepts/sequence-memory.md]] — full concept page: DenseNet capacity table, MixedNet formalism, GPI rule, CBGT biological substrate
- [[wiki/concepts/associative-memory.md]] — DenseNet extends Hopfield/MHN; same nonlinear crosstalk reduction applies to asymmetric sequence transitions
- [[wiki/concepts/hebbian-learning.md]] — temporally asymmetric Hebbian rule ($J_{ij} = \xi_i^{\mu+1}\xi_j^\mu$) is the SeqNet write mechanism; STDP is the biological substrate
- [[wiki/entities/basal-ganglia.md]] — bipartite implementation maps to the CBGT loop; BG (Basal Ganglia) gates thalamic motor-motif neurons to control sequence context
- [[wiki/concepts/phase-precession.md]] — phase precession + STDP is the biological write mechanism for directed sequence edges (asymmetric Hopfield weights)
- [[wiki/concepts/working-memory.md]] — MixedNet fast/slow synapse split parallels the WM maintenance/readout dual-mode architecture
