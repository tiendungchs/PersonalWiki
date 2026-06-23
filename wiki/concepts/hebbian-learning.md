---
title: "Hebbian Learning"
type: concept
tags: [hebbian-learning, synaptic-plasticity, stdp, btsp, unsupervised-learning, associative-memory, cell-assembly]
created: 2026-06-20
updated: 2026-06-23
sources: [Hebbian theory, bi-poo-stdp-1998, A neuronal learning rule for sub-millisecond temporal coding, Theories of Error Back-Propagation in the Brain, Equilibrium Propagation Bridging the Gap between Energy-Based Models and Backpropagation, towards_biologically_plausuble_DL]
related: [wiki/concepts/associative-memory.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/engrams.md, wiki/concepts/pattern-separation.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/neuromodulation.md, wiki/concepts/sequence-memory.md, wiki/concepts/temporal-coding.md, wiki/entities/basal-ganglia.md, wiki/papers/hebbian-theory-wikipedia.md, wiki/papers/hopfield-networks-crouse-2022.md, wiki/papers/learning-fast-slow-liao-2024.md, wiki/papers/bi-poo-stdp-1998.md, wiki/papers/gerstner-temporal-coding-1996.md, wiki/concepts/dendritic-computation.md, wiki/papers/long-sequence-hopfield-chaudhry-2023.md, wiki/papers/gardner-gruning-supervised-snn.md, wiki/papers/whittington-bogacz-pc-backprop-2017.md, wiki/papers/theories-backprop-brain-whittington-2019.md, wiki/concepts/credit-assignment.md, wiki/entities/equilibrium-propagation.md, wiki/papers/scellier-bengio-eqprop-2017.md, wiki/papers/bengio-bioplausible-dl-2015.md, wiki/entities/snn.md]
---

# Hebbian Learning

**A local, unsupervised synaptic plasticity rule: connections strengthen when pre- and post-synaptic neurons co-activate — "neurons that fire together, wire together" — with the crucial caveat that causal order matters: pre must fire before post.**

---

## Key Equations

**Basic rule:**
$$w_{ij} = x_i x_j$$

**Multi-pattern (epoch-mode) — the Hopfield one-shot storage rule:**
$$w_{ij} = \frac{1}{p}\sum_{k=1}^{p} x_i^k x_j^k \quad \Leftrightarrow \quad W = \frac{1}{p} Y^\top Y$$
Single exposure per pattern; no error signal; no backprop.

**Continuous-time dynamics:**
$$\frac{d\mathbf{w}}{dt} = \eta C \mathbf{w}, \qquad C = \langle \mathbf{x}\mathbf{x}^\top \rangle$$

**Hebbian → PCA:** $C$ is symmetric positive-definite → solution is $\mathbf{w}(t) \propto e^{\eta\alpha^* t}\mathbf{c}^*$, where $\mathbf{c}^*$ is the eigenvector of $C$ with the largest eigenvalue $\alpha^*$. Weights converge to the first principal component of the input — Hebbian learning performs implicit unsupervised dimensionality reduction.

**Instability:** all eigenvalues of $C$ are positive → weights diverge exponentially for any neuron model. Solutions:
- **Oja's rule:** $\Delta w_i = \eta(x_i y - y^2 w_i)$ — normalizes weights online, stable fixed point at $\mathbf{c}^*$.
- **BCM theory:** sliding threshold $\theta$ that rises with output activity prevents runaway potentiation.
- **SDR (k-WTA):** architectural solution — limiting co-active neurons to $k \ll N$ bounds the effective Hebbian update magnitude.

---

## Temporal Refinements

| Variant | Timescale | Mechanism | Functional role |
|---|---|---|---|
| **Classic Hebbian** | Rate co-activation | Weight ∝ covariance | Association, PCA, engram formation |
| **STDP** | Milliseconds | Pre→post within ±20ms → LTP; post→pre within ±20ms → LTD; ~5ms transition zone; no effect outside ±40ms. NMDA Mg²⁺-unblock kinetics implement the window molecularly (Bi & Poo 1998). **Gerstner et al. 1996** derived the same asymmetric W(s) window two years earlier from the barn owl auditory system: the rule selects delay-matched axonal connections to maximise coherent input convergence for ITD detection — a functionally distinct motivation that converges on identical rule structure. | Sequential edge learning in CA3; delay selection for temporal binding; the timing asymmetry encodes causal direction — strengthens forward-predictive connections only |
| **BTSP** | Seconds | EC-instructed dendritic plateau → mass potentiation of all inputs in behavioral window | Single-shot node (concept) acquisition in CA1; molecular substrate of fast-M write |
| **Asymmetric STDP (SeqNet/DenseNet)** | Milliseconds (same as STDP) | Pre→post pairs create *directed* weight matrix $J_{ij} = \xi_i^{\mu+1}\xi_j^\mu$; forward edges only (asymmetric Hopfield) | Sequential memory storage: transitions from pattern µ to µ+1; the biological write for sequence executors (see [[wiki/concepts/sequence-memory.md]]) |
| **FILT (Gardner & Grüning)** | Milliseconds (τ_q ≈ τ_m ≈ 10ms) | Gradient ascent on log-likelihood of target spike train; PSP ε as presynaptic eligibility trace (theoretically derived, not heuristic); exponentially filtered spike-train difference as postsynaptic error; STDP-shaped window emerges from maximum-likelihood rather than empirical measurement | Supervised temporal encoding: α_m ≈ 0.14–0.15 at 1ms precision, α_m ≈ 0.07 at 0.2ms; online-compatible; error signal from backpropagated APs or neuromodulatory concentration at synapse |

Hebb's original causal emphasis foreshadowed STDP. BTSP (Magee et al. 2017) is the empirically confirmed single-trial write mechanism for HC — it supersedes "one-shot Hebbian LTP" as the correct molecular account.

**STDP form ↔ credit assignment model (Whittington & Bogacz 2019; Scellier & Bengio 2017; Bengio et al. 2015):** Four STDP forms correspond to distinct biologically plausible backprop classes:
- **Asymmetric STDP** (pre→post = LTP, post→pre = LTD) → **continuous update model** (temporal-error): weight change ∝ x_pre · (dx_post/dt); the window reflects whether postsynaptic activity is rising or falling around the presynaptic spike, not causal order per se.
- **Symmetric STDP** (co-activation → LTP regardless of order; below-baseline activity → LTD) → **predictive coding** (explicit-error): weight change ∝ ε_post · x_pre; direction depends on absolute error-node level, not spike timing order.
- **Tied STDP** (symmetric weights; sum of both directions): dW_{ij}/dt ∝ d/dt[ρ(u_i)ρ(u_j)] → **equilibrium propagation** (temporal-error): integrating over the nudged phase u⁰→u^β yields ΔW ∝ ρ(u^β_i)ρ(u^β_j) − ρ(u⁰_i)ρ(u⁰_j), which exactly computes ∂J/∂W as β→0. The postsynaptic signal is the *rate of change* of firing rate, not the instantaneous rate — distinguishable experimentally from the continuous update form.
- **SGD-STDP** (Bengio et al. 2015): ΔW_{ij} ∝ S_i · V̇_j, where S_i is the presynaptic spike and V̇_j is the temporal derivative of postsynaptic voltage potential. This recovers the observed STDP curve directly and implements SGD on *any* objective J — provided neural dynamics (the inference/E-step) push V_j toward better values of J. Unlike the other three forms, this interpretation is objective-agnostic: the learning rule is correct for supervised, unsupervised, and RL objectives simultaneously. Requires no weight symmetry.

### STDP Biological Constraints (Bi & Poo 1998)

Three properties of STDP that go beyond the basic timing rule:

| Constraint | Mechanism | Reasoning-model implication |
|---|---|---|
| **Strength ceiling for LTP** | LTP only at weak synapses (<500 pA EPSC); LTD strength-independent | No global homeostatic signal needed; strong E→E connections are self-protected from runaway — complements BCM sliding threshold and SDR sparsity |
| **E→E only** | GABAergic postsynaptic neurons show zero plasticity under identical protocols; they lack the Ca²⁺ signaling pathway (L-type channels + downstream cascade) | Fast-M writes are confined to excitatory→excitatory connections; inhibitory circuits remain structurally stable and act as fixed reference points |
| **L-type Ca²⁺ asymmetry** | LTD requires L-type Ca²⁺ (back-propagating AP source); LTP uses NMDA-dominated Ca²⁺ | LTP and LTD are mechanistically separable — a model can implement them with different Ca²⁺ thresholds rather than a single graded signal |

---

## Cell Assembly Theory

Hebb proposed that repeated co-firing builds **cell assemblies**: auto-associated neuron groups that reconstitute the full pattern from a partial cue (Allport's auto-association). This is the original engram concept formalized:

| Hebb's concept | Computational equivalent |
|---|---|
| Cell assembly | Hopfield attractor |
| Co-firing → weight strengthening | Hebbian write $W = Y^\top Y / n$ |
| Partial cue retrieval | Energy minimization |
| Assembly auto-association | Pattern completion |

---

## Instantiations

| System | Hebbian variant | Role |
|---|---|---|
| CA3 recurrent collaterals | One-shot Hopfield rule | Fast-M episodic storage; pattern completion from partial cue |
| DG granule cells | Competitive Hebbian + lateral inhibition | Grid→place transformation; orthogonalizes inputs for pattern separation |
| CA1 place fields | BTSP (EC-instructed dendritic plateau) | Single-trial node acquisition in one behavioral exposure |
| Striatum (D1 SPNs) | Hebbian LTP via PKA cascade | Reinforcement of rewarded actions; SPEED cortico-cortical automaticity |
| Transformer self-attention | Modern Hopfield (Ramsauer 2020) | Exponential-capacity content-addressable key-value retrieval |
| SpikingTEM fast-M (memory M) | STDP (±Δt spike-pair rule) | Associative memory matrix between generated and inferred CA1 patterns; jointly necessary for grid cell formation (ablation: 59.6% → 10.1%) |

---

## For Building a Reasoning Model

- **Fast-M write:** the one-shot Hopfield rule is the computational fast-M write; BTSP is its biological implementation. Any fast episodic binding layer needs a Hebbian-equivalent local rule — no backprop required.
- **Instability → sparsity requirement:** exponential weight divergence is the formal proof that unconstrained Hebbian learning fails; k-WTA / SDR codes are the architectural solution, directly motivating sparse episodic codes throughout HC.
- **Unsupervised structure:** Hebbian → PCA means fast-M writes extract the dominant covariance structure from input patterns. Episodic memory is not just storage — it is low-dimensional compression happening in a single trial.
- **DG as prerequisite:** competitive Hebbian learning in DG creates the non-overlapping input codes that make CA3 Hopfield storage interference-free. The Hebbian write step and the orthogonalization step are both Hebbian — same rule, two functions.
- **Dual mechanism:** Hebbian/BTSP synaptic modification is the long-term content store, but it is not sufficient alone. CREB-mediated excitability increase is a complementary, non-synaptic mechanism that determines *which neurons* are eligible for the next Hebbian write and creates a hours-long linking window across temporally proximate memories. The two mechanisms are computationally distinct: the Hebbian write records content; CREB marks eligibility for future writes. A reasoning model needs a CREB-analog: after each episodic fast-M write, tagged cells should remain preferentially recruitable across the subsequent linking window.

---

## Open Problems

- Whether BTSP and STDP jointly implement "any graph representable" (Liao & Losonczy 2024): requires BTSP to write nodes (CA1) and STDP to write edges (CA3) without interference — anatomical segregation is the proposed solution but has not been directly tested.
- BCM threshold dynamics: the molecular correlate of the sliding threshold $\theta$ is debated; calcium-dependent processes are candidates but not established.
- Stability of layered Hebbian learning (forward-forward, predictive coding): whether Oja's rule / BCM extend to multi-layer Hebbian networks without eigenvalue explosion is an open engineering question.

---

## Connections

- **[[wiki/concepts/associative-memory.md]]** — the one-shot Hopfield rule is the Hebbian write mechanism: Hebbian learning stores patterns as energy minima, and pattern completion retrieves them via energy minimization; modern Hopfield (softmax energy) is exponential-capacity Hebbian associative memory.
- **[[wiki/concepts/two-learning-timescales.md]]** — fast-M writes are Hebbian; BTSP and STDP are the molecular substrates for single-shot (seconds) and sequential (milliseconds) fast-M updates; Hebbian instability is the formal reason sparse codes are required for stable fast-M storage.
- **[[wiki/concepts/engrams.md]]** — Hebb's cell assembly theory is the conceptual precursor to the engram: co-firing establishes auto-associated assemblies; excitability competition (lateral inhibition) determines which neurons participate in the Hebbian write and enforces the sparsity that keeps assemblies distinct; CREB is the molecular mechanism that sets pre-training excitability and creates the hours-long linking window.
- **[[wiki/papers/lisman-memory-allocation-2018.md]]** — establishes that synaptic modification (LTP/LTD, Hebbian) and cellular excitability (CREB) are complementary memory mechanisms with distinct computational roles: Hebbian writes store content; CREB marks eligibility and links temporally proximate memories — both are necessary for full memory function.
- **[[wiki/concepts/pattern-separation.md]]** — DG competitive Hebbian learning converts MEC grid co-activity patterns into sparse, non-overlapping place codes; lateral inhibition enforces the winner-take-all constraint that makes Hebbian convergence produce distinct attractor basins rather than correlated overlapping attractors.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — SDR k-WTA is the architectural stabilizer for Hebbian learning: limiting co-active cells prevents exponential weight divergence while keeping per-segment false positive rates near zero; sparsity and Hebbian learning are co-dependent.
- **[[wiki/entities/basal-ganglia.md]]** — striatal D1 SPN Hebbian LTP (PKA-mediated) and D2 LTD (endocannabinoid-mediated) are the cellular Hebbian substrate for BG credit assignment; SPEED shows BG-bootstrapped cortico-cortical Hebbian LTP compiles practiced skills into cortex permanently.
- **[[wiki/concepts/neuromodulation.md]]** — DA gates Hebbian plasticity direction in striatum (D1→LTP, D2→LTD); ACh switches HC between encoding (high ACh → Hebbian write enabled) and retrieval modes; NA modulates DG competitive Hebbian gain via the hilar circuit.
- **[[wiki/papers/hebbian-theory-wikipedia.md]]** — source for core formalism, PCA derivation, instability proof, Oja's rule, BCM, STDP/BTSP overview, and connections to PFC mixed selectivity and striatal in vivo evidence.
- **[[wiki/papers/hopfield-networks-crouse-2022.md]]** — establishes the Hopfield–Hebbian equivalence: multi-pattern Hebbian rule = one-shot Hopfield storage; modern Hopfield = transformer self-attention = exponential-capacity Hebbian memory.
- **[[wiki/papers/learning-fast-slow-liao-2024.md]]** — BTSP as the molecular replacement for "one-shot Hebbian LTP" in CA1: EC-supervised dendritic plateau integrates population activity over seconds, not millisecond spike pairs; STDP writes sequential edges in CA3; together the two cover all graph structure.
- **[[wiki/papers/bi-poo-stdp-1998.md]]** — foundational STDP empirical characterization: quantifies the ±20ms asymmetric window, establishes NMDA requirement for both LTP and LTD, and identifies the two key biological constraints (strength ceiling for LTP; E→E cell-type specificity) that constrain where fast-M Hebbian writes land.
- **[[wiki/concepts/dendritic-computation.md]]** — NMDA Mg²⁺-unblock kinetics are the molecular implementation of the STDP coincidence window; L-type Ca²⁺ channels provide the separate Ca²⁺ source for LTD; STDP is dendritic computation applied to synaptic weight update.
- **[[wiki/papers/spiking-tem-kawahara-2025.md]]** — ablation study shows STDP is jointly necessary for grid cell emergence (removal drops grid proportion from 59.6% to 10.1%); confirms that associative memory formation via STDP is required for the structural code to emerge, not just for episodic storage.
- **[[wiki/concepts/sequence-memory.md]]** — asymmetric STDP (pre→post LTP) is the biological write mechanism for directed sequence edges $J_{ij} = \xi_i^{\mu+1}\xi_j^\mu$; the DenseNet nonlinearity $f$ corresponds to higher-order Hebbian interactions via NMDA dendritic coincidence detection, upgrading sequence capacity from linear to polynomial/exponential.
- **[[wiki/papers/long-sequence-hopfield-chaudhry-2023.md]]** — establishes that temporally asymmetric Hebbian weights are both the SeqNet baseline and the substrate onto which DenseNet nonlinearity is applied; the GPI rule extends the pseudoinverse Hebbian correction to correlated sequences.
- **[[wiki/concepts/temporal-coding.md]]** — STDP is the temporal-precision version of Hebbian learning; the W(s) window was first derived (Gerstner 1996) from the requirement to select delay-matched connections for temporal binding, giving STDP a second, functionally distinct biological motivation alongside the co-activation statistics account.
- **[[wiki/papers/gerstner-temporal-coding-1996.md]]** — earliest derivation of the asymmetric STDP window (1996, before Bi & Poo 1998); derived from barn owl ITD tuning; shows that delay selection by W(s) and sequence edge selection by W(s) are the same computation at different timescales (~100 µs for auditory, ~20 ms for hippocampal).
- **[[wiki/papers/gardner-gruning-supervised-snn.md]]** — FILT rule derives the PSP as the correct presynaptic eligibility trace from maximum-likelihood, providing theoretical justification for the STDP-shaped learning window independent of empirical measurement; shows supervised temporal encoding achieves near-maximal capacity (α_m ≈ 0.14–0.15) with online-compatible biologically plausible rules.
- **[[wiki/papers/whittington-bogacz-pc-backprop-2017.md]]** — shows that the PC weight update Δw ∝ ε·x is a supervised Hebbian rule: the prediction error node ε provides the teaching signal that modulates the standard co-activation product, bridging pure Hebbian associativity to gradient-based supervised learning; establishes the formal conditions under which this supervised Hebbian rule approximates exact backprop.
- **[[wiki/papers/theories-backprop-brain-whittington-2019.md]]** — establishes that the two standard STDP forms map to distinct credit assignment model classes: asymmetric STDP implements the continuous update (temporal-error) model; symmetric STDP implements predictive coding (explicit-error); the review also introduces equilibrium propagation as the formal unifier explaining why all Hebbian-like local rules can approximate gradient descent when the network converges to an energy minimum.
- **[[wiki/entities/equilibrium-propagation.md]]** — EqProp's tied STDP rule (dW/dt ∝ d/dt[ρ(u_i)ρ(u_j)]) provides the most principled derivation that a biologically observed STDP form computes exact gradients at equilibrium, not merely approximates them; extends the STDP ↔ credit assignment correspondence to a third distinct class.
- **[[wiki/papers/scellier-bengio-eqprop-2017.md]]** — primary source for the tied STDP derivation and its connection to the contrastive Hebbian update via time-integration over the nudged phase.
- **[[wiki/papers/bengio-bioplausible-dl-2015.md]]** — source for the fourth STDP ↔ credit assignment correspondence: ΔW_{ij} ∝ S_i·V̇_j implements SGD on any objective J when inference dynamics improve J; the derivation recovers the full observed STDP curve from this single update rule without assuming weight symmetry.
- **[[wiki/entities/snn.md]]** — STDP is the native unsupervised learning rule in spiking networks; the four STDP↔credit-assignment correspondences (asymmetric→continuous update, symmetric→PC, tied→EqProp, SGD-STDP→variational EM) ground the theoretical legitimacy of SNN-native learning without teacher signals.
