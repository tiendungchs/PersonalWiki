---
title: "Sequence Memory"
type: concept
tags: [sequence-memory, hopfield, asymmetric-hebbian, dense-associative-memory, motor-control, temporal-association, capacity-scaling, cbgt-loop]
created: 2026-06-22
updated: 2026-06-22
sources: [Long Sequence Hopfield Memory, Hybrid computing using a neural network with dynamic external memory]
related: [wiki/concepts/associative-memory.md, wiki/concepts/hebbian-learning.md, wiki/concepts/working-memory.md, wiki/entities/basal-ganglia.md, wiki/concepts/phase-precession.md, wiki/concepts/two-learning-timescales.md, wiki/entities/dnc-model.md, wiki/papers/long-sequence-hopfield-chaudhry-2023.md, wiki/papers/dnc-graves-2016.md, wiki/concepts/temporal-coding.md]
---

# Sequence Memory

**The ability to encode, store, and autonomously replay ordered sequences of patterns: retrieval of element µ automatically cues element µ+1, enabling temporal chain execution independent of external input.**

Sequence memory extends static associative memory from fixed-point attractors to directed state trajectories. Unlike working memory (which *holds* a pattern across a delay), sequence memory *propels* the network through a stored ordered path.

---

## Key Formalisms

**SeqNet — baseline asymmetric Hebbian network:**
$$J_{ij} = \frac{1}{N}\sum_{\mu=1}^P \xi_i^{\mu+1}\xi_j^{\mu}, \qquad \mathbf{S}(t+1) = \text{sign}(J\,\mathbf{S}(t))$$
Asymmetric weight matrix creates directed edges $\xi^\mu \to \xi^{\mu+1}$. Capacity $P \sim N$ — identical to classical Hopfield. Fails in simulation at $P=100, N=300$.

**DenseNet — nonlinear extension (Dense Associative Memory for sequences):**
$$\mathbf{S}(t+1) = \text{sign}\!\left(\sum_{\mu=1}^P f(m^\mu(\mathbf{S}))\,\boldsymbol{\xi}^{\mu+1}\right), \quad m^\mu = \frac{1}{N}\sum_i \xi_i^\mu S_i$$
Nonlinear $f$ reduces inter-pattern crosstalk in transitions — the same mechanism as Modern Hopfield Network (MHN) for static attractors. Enables polynomial and exponential capacity scaling.

**MixedNet — variable-timing sequences (fast + slow synapses):**
$$\mathbf{S}(t+1) = \text{sign}\!\left(f_S(m^\mu(t)) + \lambda\,f_A\!\left(\bar{m}^\mu(t)\right)\right)$$
$\bar{m}^\mu(t) = \sum_{\rho=0}^\tau w(\rho)\,m^\mu(t{-}\rho)$ is a low-pass average of recent overlaps.
$f_S$ (fast, symmetric): stabilizes network at the current pattern for $\tau$ timesteps.
$f_A$ (slow, asymmetric): drives transition to the next pattern. $\lambda$ controls transition gain.
Capacity scales as $\min(d_S, d_A)$.

**Generalized Pseudoinverse (GPI) for correlated patterns:**
$$J_{ij}^{\text{GPI}} = \sum_{\mu\nu} f\!\left((O^+)_{\mu\nu}\right) \xi_j^\nu\,\xi_i^{\mu+1}, \quad O_{\mu\nu} = \frac{1}{N}\sum_i \xi_i^\mu \xi_i^\nu$$
Pseudoinverse of the overlap matrix $O^+$ decorrelates stored patterns before applying the DenseNet transition. For linearly independent patterns, GPI achieves perfect recall regardless of correlation strength.

---

## Capacity Scaling

| Model | Interaction | Single-transition $P_T$ | Sequence $P_S$ | Notes |
|---|---|---|---|---|
| SeqNet | Linear ($f=\text{id}$) | $\sim N/(4\log N)$ | $\sim N$ | Interferes above $P \sim N$; fails catastrophically |
| Polynomial DenseNet (degree $d$) | $f(x)=x^d$ | $\sim N^d / (\beta_d \log N^d)$ | $\sim P_T / d$ | Same scaling as static MHN; optimal degree $d_\text{max}$ finite for each $N$ |
| Exponential DenseNet | $f(x)=\exp((N{-}1)(x{-}1))$ | $\sim \exp(N)$ (approx.) | $\sim P_T / N$ (approx.) | Gaussian theory approximate; lognormal crosstalk at finite $N$ causes deviation |

The Polynomial DenseNet single-transition capacity is rigorously a lower bound (Demircigil et al. 2017 argument adapted). The Exponential DenseNet capacity is a heuristic Gaussian estimate.

---

## MixedNet: Variable-Timing Details

The Temporal Association Network (Sompolinsky & Kanter 1986) combines symmetric + asymmetric terms but capacity is $\sim 0.1N$. MixedNet upgrades TAN by applying separate nonlinearities to each term:

| Parameter | Effect |
|---|---|
| $d_S = d_A = 1$ (linear) | TAN; fails at $P=40, N=100$ |
| $d_S = d_A = 2$ | Correct order; incorrect timing |
| $d_S = d_A = 10$ | Correct order AND timing |
| Capacity | Scales as $\min(d_S, d_A)$ — weaker nonlinearity is the bottleneck |

Crosstalk distribution is **bimodal** in MixedNet (unlike unimodal in DenseNet), arising from the interference between symmetric and asymmetric terms — requires conditioning on the bimodal structure for capacity analysis.

---

## Biological Substrate

| Mechanism | Sequence memory analog |
|---|---|
| Temporally asymmetric STDP | SeqNet weight $J_{ij} = \xi_i^{\mu+1}\xi_j^\mu$ — pre→post LTP (Long-Term Potentiation) writes the forward edge $\xi^\mu \to \xi^{\mu+1}$ |
| Phase precession + STDP | Compresses sequence edges into theta cycles; provides the biological write mechanism for asymmetric weights |
| NMDA dendritic coincidence detection | DenseNet nonlinearity $f$ — high-order overlap via NMDA spike approximates polynomial $f(x)=x^d$ |
| AMPA (fast) / NMDA (slow) timescales | MixedNet $f_S$ (fast AMPA, recurrent) / $f_A$ (slow NMDA, associative) — dual-timescale synaptic dynamics |
| Cortico-BG-thalamo-cortical (CBGT) loop | DenseNet bipartite circuit: visible (motor cortex) + hidden (thalamic motor motifs) + BG (Basal Ganglia) context gate |

**CBGT loop as sequence executor:**

The $d{+}1$-body synaptic interaction in the Polynomial DenseNet is biologically unrealistic. The bipartite reformulation resolves this: weights $W_{j\mu} = \frac{1}{N}\xi_j^\mu$ (cortex→thalamus) and $M_{\mu j} = \xi_j^{\mu+1}$ (thalamus→cortex) implement the same dynamics with two-body synapses.

The BG (Basal Ganglia)'s role in this circuit is **not** action selection (Go/NoGo) but *context-dependent sequence gating*: inhibiting specific thalamic hidden neurons ($h_\mu$) reduces the probability of transitioning to pattern $\xi^{\mu+1}$, while activating them increases it. This is a distinct mechanistic mode for BG (Basal Ganglia) — selecting which sequence program drives the motor cortex, rather than selecting among competing motor actions.

---

## DNC (Differentiable Neural Computer) Temporal Link Matrix: One-Shot Sequence Encoding

DenseNet (above) encodes sequences in asymmetric synaptic weights via many-shot STDP — the same directed edge $J_{ij} = \xi_i^{\mu+1}\xi_j^\mu$ accumulates over multiple exposures. The DNC (Differentiable Neural Computer) (Graves et al. 2016 [[wiki/papers/dnc-graves-2016.md]]) provides a complementary mechanism: **one-shot sequence encoding in a dynamic data structure** rather than fixed weights.

**Temporal link matrix L∈[0,1]^{N×N}:**
$$L_t[i,j] \approx 1 \text{ iff location } i \text{ was written immediately after location } j$$
Updated after each write: $L_t \leftarrow (1 - \hat{w}_t^w \mathbf{1}^\top - \mathbf{1}(\hat{w}_t^w)^\top) \odot L_{t-1} + \hat{w}_t^w (\hat{p}_{t-1})^\top$
where $\hat{p}_t$ is the precedence weighting (probability that location $i$ was the last written).

**Forward/backward retrieval from any starting point:**
$$\mathbf{f}^i = L_t \mathbf{w}^{r,i}_{t-1} \quad \text{(shift focus forward along write order)}$$
$$\mathbf{b}^i = L_t^\top \mathbf{w}^{r,i}_{t-1} \quad \text{(shift focus backward)}$$
Any read head can traverse the write-order chain in either direction from any starting location, regardless of whether consecutive writes were in adjacent memory locations.

| Property | DenseNet (weight-encoded) | DNC (Differentiable Neural Computer) temporal links (structure-encoded) |
|---|---|---|
| Write mechanism | Many-shot asymmetric STDP (accumulates over trials) | One-shot structural update (immediate L update) |
| Storage medium | Synaptic weight matrix J (permanent) | Temporal link matrix L (dynamic, per-episode) |
| Capacity | P_S ~ N^d / d (polynomial) to exp(N) | N locations (one chain per episode) |
| Biological analog | Phase precession + STDP populating J | Temporal context model (Howard & Kahana 2002) |
| Use case | Motor programs, long learned sequences | Novel input lists, graph edges written in one pass |

**Key observation from DNC (Differentiable Neural Computer) graph experiments (Fig. 3):** During London Underground traversal, read head 1 spontaneously specializes in temporal-link forward traversal (to retrieve instructions in order) while read head 2 uses content lookup (to find destination stations). The two mechanisms operate *simultaneously* on the same memory matrix, enabling joint sequential + associative access — a combination not possible in either pure weight-encoded sequence memory or pure Hopfield recall.

**Relationship to hippocampal temporal context model:** The temporal link matrix is a direct computational analog of Howard & Kahana (2002)'s temporal context model for free recall: the increased probability of recalling item N+1 after item N is not arbitrary but follows from a maintained context vector tracking write history. DNC (Differentiable Neural Computer) makes this an explicit differentiable data structure rather than an implicit weight-based tendency.

---

## Open Problems

- Continuous-time and continuous-valued extensions: the Chaudhry 2023 analysis is discrete-time binary; biological neural sequences are continuous and graded.
- Accurate Exponential DenseNet capacity theory: the Gaussian approximation fails; Edgeworth-series corrections for lognormal-tailed crosstalk distributions are needed.
- Quantitative mapping from STDP window width (±20ms, Bi & Poo 1998) to DenseNet nonlinearity degree: is there a derivation of $d$ from NMDA coincidence curve shape?
- How does GPI rule capacity scale with realistic neural correlation statistics (beyond MovingMNIST)?

---

## For Building a Reasoning Model

- **Prerequisite for multi-step causal chains:** abstract reasoning requires executing ordered transformation rules; sequence memory provides the substrate for program execution without external step-by-step prompting.
- **CBGT loop as program executor:** thalamic hidden units are the "program slots"; BG (Basal Ganglia) selects the active program context; cortex executes each step — this is the circuit-level analog of the Block 3C hierarchical rule stack.
- **MixedNet temporal flexibility:** variable $\tau$ per state allows the executor to pause at complex reasoning steps for longer (deliberate pause), consistent with the BG (Basal Ganglia) Hold function via hyperdirect pathway.
- **Exponential capacity for long episodes:** real reasoning chains can be very long; exponential DenseNet capacity scales to this regime while linear SeqNet fails at $P > N$.

---

## Connections

- **[[wiki/concepts/associative-memory.md]]** — DenseNet extends the static Hopfield/MHN framework to directed asymmetric transitions; the same nonlinear crosstalk reduction lifts sequence capacity from $N$ to $N^d$ identically to static memory capacity; the energy-minimization/attractor mathematics remains the shared foundation.
- **[[wiki/concepts/hebbian-learning.md]]** — the asymmetric Hebbian write rule $J_{ij} = \xi_i^{\mu+1}\xi_j^\mu$ is the biological write mechanism for SeqNet; temporally asymmetric STDP (pre→post within ±20ms → LTP) encodes exactly this directed edge; DenseNet nonlinearity corresponds to higher-order Hebbian interactions via NMDA dendritic computation.
- **[[wiki/concepts/phase-precession.md]]** — phase precession compresses temporal sequences into theta cycles; STDP acting on phase-shifted spike pairs writes asymmetric weights, making phase precession the biological mechanism that populates the SeqNet/DenseNet weight matrix with causal forward edges.
- **[[wiki/entities/basal-ganglia.md]]** — the DenseNet bipartite implementation maps onto the CBGT loop; BG (Basal Ganglia)'s role is reframed from competing-action selection (Go/NoGo) to context-dependent gating of which sequence-memory program drives thalamic hidden units.
- **[[wiki/concepts/working-memory.md]]** — MixedNet's fast/slow synapse split (stay vs. transition) parallels the STSP-WM dual-mode architecture (maintenance vs. readout); sequence memory and WM differ in function (propel vs. hold) but share a dual-timescale synaptic mechanism at the circuit level.
- **[[wiki/concepts/two-learning-timescales.md]]** — asymmetric STDP is the fast-M timescale write that populates the sequence weight matrix; the CBGT structural weights ($W, M$) are slow-W parameters learned over extended experience; sequence memory execution requires both timescales simultaneously.
- **[[wiki/papers/long-sequence-hopfield-chaudhry-2023.md]]** — source paper: capacity derivations, MixedNet analysis, GPI rule, bipartite implementation, MovingMNIST demonstrations.
- **[[wiki/entities/dnc-model.md]]** — DNC (Differentiable Neural Computer) temporal link matrix is the one-shot complement to DenseNet's many-shot weight encoding: L encodes write order in a dynamic data structure updated after each write; forward/backward reads traverse the sequence without STDP accumulation; visualization of head specialization (Fig. 3) confirms spontaneous emergence of sequential vs. associative access modes in the same memory.
- **[[wiki/papers/dnc-graves-2016.md]]** — source for temporal link matrix formalism, forward/backward weighting derivation, sparse link matrix approximation (O(N log N) with K=8), and London Underground traversal visualization demonstrating head specialization.
- **[[wiki/concepts/prospective-coding.md]]** — prospective coding requires the asymmetric sequence weights that sequence memory encodes: the STDP-learned X→Y edge weight is the substrate that CA1 pattern-completes to produce the Y look-ahead when X is cued; sequence memory provides the stored structure that prospective coding reads out online.
- **[[wiki/concepts/temporal-coding.md]]** — temporal coding is the biological substrate for the asymmetric Hebbian write step: spike-pair timing within the STDP window encodes the directed edge ξ^{µ+1} ← ξ^µ; coherent convergence (Gerstner 1996) is the circuit mechanism that allows sequence edges to be written at millisecond precision from population-level spike timing.
