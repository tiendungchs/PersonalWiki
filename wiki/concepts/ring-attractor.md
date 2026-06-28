---
title: "Ring Attractor"
type: concept
tags: [ring-attractor, path-integration, head-direction, continuous-attractor, working-memory, navigation, traveling-wave, levy-flights]
created: 2026-06-13
updated: 2026-06-28
sources: [landmark-orientation, acann-li-2024, deco-dynamic-brain-2008]
related: [wiki/concepts/path-integration.md, wiki/concepts/convergent-allocentric-coding.md, wiki/concepts/binding-problem.md, wiki/concepts/neural-manifolds.md, wiki/entities/insect-central-complex.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/papers/seelig-jayaraman-2015.md, wiki/papers/turner-evans-neuron-2020.md, wiki/concepts/spike-frequency-adaptation.md, wiki/concepts/replay.md, wiki/papers/acann-li-chu-wu-2024.md, wiki/entities/fcann.md, wiki/papers/fcann-attractor-dynamics-englert-2026.md, wiki/concepts/neural-field-theory.md, wiki/entities/spacetime-attractor.md, wiki/concepts/planning-as-inference.md, wiki/concepts/cortical-traveling-waves.md]
---

# Ring Attractor

**A recurrently connected neural network whose activity settles into a single localized "bump" on a circular topology, where bump position encodes a circular variable (e.g., heading angle) and the ring of fixed points is self-sustaining without external input.**

---

## Mathematical Structure

Neurons indexed by preferred angle θ_i ∈ [0, 2π). Connectivity:

W_ij = A cos(θ_i − θ_j) + B     (A > 0, B < 0 for net global inhibition)

Activity dynamics:

τ dr_i/dt = −r_i + f( Σ_j W_ij r_j + I_vel(t) )

Steady-state profile ≈ a + b cos(θ − θ̂), where θ̂ is the encoded angle. **Any** θ̂ ∈ [0, 2π) is a valid fixed point — the ring of equally stable equilibria is the key property.

**Bump shift:** asymmetric velocity input I_vel(t) biases the bump to drift in the direction of rotation:

θ̂_{t+1} ≈ θ̂_t + ω Δt  (open-loop, path integration)

---

## Key Computational Properties

| Property | Mechanism | Failure mode |
|---|---|---|
| **Continuous memory** | Ring of fixed points — no single equilibrium | Drift accumulates in open-loop (velocity noise integrates) |
| **Persistent activity** | Recurrent excitation sustains bump without input | Decays if recurrent gain drops (e.g., neuromodulation depletion) |
| **Landmark anchoring** | External sensory input biases bump position | Ambiguous landmarks → bump jumps discontinuously |
| **Path integration** | Velocity input shifts bump proportionally | Error grows as √t (random walk) in darkness |
| **Winner-take-all** | Global inhibition suppresses all positions except one | Two-landmark ambiguity → bump stochastically selects one |

---

## Kalman Filter Correspondence

The ring attractor implements a continuous heading estimator in closed-loop:

θ̂_pred = θ̂_{t−1} + ω Δt              (prediction: P-EN path integration)
θ̂_t    = θ̂_pred + K(θ_landmark − θ̂_pred)  (update: landmark correction)

Seelig & Jayaraman 2015: visual landmark gain ≈ 1, self-motion gain ≈ 0 in conflict → K ≈ 1 when landmarks are available, K = 0 in darkness. This matches an optimal estimator that weights landmark inputs by reliability when they are far more reliable than integrated velocity.

---

## Biological Evidence

**Drosophila EB — Seelig & Jayaraman 2015 (confirmed, primary source):**
All five ring attractor signatures observed in a single preparation in behaving flies:
1. Single activity bump; width ≈ 82° FWHM in E-PG population
2. Bump tracks landmark position (not retinotopic; persists as single bump in complex scenes)
3. Landmark input dominates over self-motion when in conflict
4. In darkness: bump follows walking rotation, drift accumulates over time
5. Persistent activity: bump maintained >30 s without any input; resumes from same position after standing (n=499 events, r=0.7)

**(tentative) Drosophila hemibrain — Turner-Evans et al. 2020:**
EM connectome provides synaptic substrate: E-PG→P-EG inhibitory ring + P-EN asymmetric shift connections.

**Mammalian head direction system:**
Functionally equivalent dynamics in anterodorsal thalamus, presubiculum, and retrosplenial cortex (Taube 2007); circuit more distributed and less cleanly isolated than CX (Central Complex) — predated the fly evidence by decades but is harder to verify at circuit level.

---

## ML Implementation

```python
# Minimal ring attractor in PyTorch
# heading encoded as (cos θ, sin θ) — avoids angle-wrapping issues
def update(h, omega_dt, landmark=None, K=1.0):
    # path integration: rotate by omega_dt
    c, s = h
    h_pred = (c * cos(omega_dt) - s * sin(omega_dt),
              s * cos(omega_dt) + c * sin(omega_dt))
    # landmark correction: weighted blend toward landmark
    if landmark is not None:
        h = (1-K)*h_pred + K*landmark   # both unit vectors on S¹
    return normalize(h)
```

Equivalent to a 2D recurrent unit on the unit circle. For richer dynamics: use a full CANN (cosine-connectivity RNN with N neurons), which recovers the biological bump profile and allows multi-stability analysis.

---

## A-CANN: Adaptive Extension for Flexible State Dynamics

Adding SFA (Spike Frequency Adaptation) as a slow negative feedback (Li, Chu & Wu 2024) extends the CANN to an **adaptive CANN (A-CANN)** with four dynamical modes controlled by adaptation strength **m** and input strength **α**:

$$\tau_v \frac{dV(x,t)}{dt} = -V(x,t) + mU(x,t), \quad \tau_v \gg \tau$$

**Spontaneous dynamics (no external input):**

| Condition | Mode | Role |
|---|---|---|
| m < τ/τ_v, k < k_c2 | **Static bump** | Working memory — holds state without input |
| m > τ/τ_v | **Traveling wave** v_int = (2a/τ_v)√(mτ_v/τ − √(mτ_v/τ)) | Memory search; hippocampal replay |

**Tracking dynamics (with external input α):**

| Condition | Mode | Key property |
|---|---|---|
| m − τ/τ_v < α/A_u | **Anticipative tracking** | Leads input by constant t_ant ∝ τ_v (m − τ/τ_v) |
| Intermediate (Hopf bifurcation) | **Oscillatory tracking** | Theta-band ω ∝ √(αk(1+m)/ττ_v); phase precession/procession |
| m − τ/τ_v ≫ α/A_u | **Traveling wave** | Adaptation overwhelms input |

**Architectural implication:** all four modes — WM, memory search, predictive tracking, and theta oscillations — emerge from **one network** by varying m (neuromodulation) and α (input salience). A reasoning model needs all four; this points to a single A-CANN-type circuit with neuromodulatory mode switching rather than four separate subsystems.

**Noisy regime → Lévy flights:** when adaptation noise fluctuates m around the traveling-wave boundary, displacement statistics follow p(||Δz||) ∝ ||Δz||^{−1−α}, α = 1 + 2μ/γ² — an efficient search prior matching place-cell reactivation statistics at rest.

---

## Open Problems

1. **Symmetry breaking:** how does the ring attractor select an initial bump position when first activated — noise, sensory bias, or prior state?
2. **Multi-scale extension:** insects have one heading ring; mammals have head direction, place, and grid representations across regions — how do multiple ring attractors coordinate? fcANN (Englert et al. 2026) partially addresses this at the whole-brain scale: functional connectome eigenvectors define approximately orthogonal macro attractor states (K-S projector), analogous to the ring's equi-spaced bump positions but in N-dimensional FC space. Coordination across circuit-level ring attractors and whole-brain fcANN attractors remains open.
3. **Abstract ring attractors:** do ring attractor dynamics generalize to cyclic abstract state spaces (e.g., periodic task variables, temporal contexts)?
4. **Spatiotemporal extension:** the Spacetime Attractor (Jensen et al. 2026) generalizes ring/grid attractors from inferring a single current state to inferring an entire future trajectory simultaneously. Fixed points in the STA (Spacetime Attractor) are full paths through space and time, not single locations. The same "consistent states excite, inconsistent inhibit" principle is preserved but the topology is 3D (space × time) rather than 1D/2D. This confirms that ring attractor circuit motifs generalize beyond instantaneous state inference.

---

## Connections

- **[[wiki/concepts/path-integration.md]]** — ring attractor is the neural substrate of path integration in the CX; the bump-shift mechanism (P-EN asymmetric drive) implements g_{t+1} = f(g_t, a_t) on a circular manifold.
- **[[wiki/entities/insect-central-complex.md]]** — the EB E-PG population is the primary characterized biological ring attractor; ~16 wedge-selective groups implement the bump over a heading ring.
- **[[wiki/concepts/convergent-allocentric-coding.md]]** — ring attractor dynamics are the core circuit mechanism of the CX (Central Complex) heading system; convergent independent evolution supports this as a near-optimal solution for continuous circular state tracking.
- **[[wiki/concepts/neural-manifolds.md]]** — the ring of fixed points is a 1D manifold embedded in high-dimensional neural state space; ring attractor connectivity constrains the reachable manifold to a circle.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — mammalian head direction system in anterodorsal thalamus and presubiculum implements ring-attractor-equivalent dynamics; feeds directional input into MEC grid cells.
- **[[wiki/concepts/binding-problem.md]]** — landmark anchoring (ring neurons → E-PG bump) is a specific binding operation: landmark identity is bound to an abstract heading state, enabling allocentric rather than egocentric coding.
- **[[wiki/papers/seelig-jayaraman-2015.md]]** — primary empirical source; all five ring attractor signatures confirmed in a single in vivo preparation.
- **[[wiki/papers/turner-evans-neuron-2020.md]]** — (tentative) synaptic-level circuit substrate for the E-PG/P-EN dynamics.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — SFA (Spike Frequency Adaptation) is the adaptation mechanism in A-CANN; the traveling-wave threshold m = τ/τ_v shows how SFA (Spike Frequency Adaptation) timescale τ_v determines whether the network is in WM mode or spontaneous search mode; neuromodulation of SFA (Spike Frequency Adaptation) timescale is the biological mode-switching interface.
- **[[wiki/concepts/replay.md]]** — the traveling-wave state of A-CANN provides an intrinsic, trigger-free mechanism for sequential memory search, complementing the SWR-triggered replay mechanism; Lévy flight statistics from noisy adaptation match stochastic reactivation patterns observed in vivo.
- **[[wiki/papers/acann-li-chu-wu-2024.md]]** — primary source for the A-CANN phase diagram, four-mode analytical framework, and all derived quantities including v_int, t_ant, ω, and the Lévy flight exponent α = 1 + 2μ/γ².
- **[[wiki/entities/fcann.md]]** — fcANN extends ring attractor principles to the whole-brain functional connectome: eigenvectors of J = −Σ⁻¹ define approximately orthogonal macro attractor "positions" analogous to the ring's equi-spaced bump positions; the K-S projector result addresses the multi-scale extension open problem at the systems level.
- **[[wiki/concepts/neural-field-theory.md]]** — neural field theory provides the foundational derivation from which the ring attractor emerges as a special case: the Amari bump solution on a 2D neural field PDE with Mexican-hat connectivity, restricted to a 1D circular domain, yields exactly the ring attractor's continuous manifold of fixed points; the stability conditions (σ_e < σ_i, net excitation) from neural field theory are the theoretical justification for the cosine connectivity W_ij = A cos(θ_i − θ_j) + B used in the ring attractor model.
- **[[wiki/entities/spacetime-attractor.md]]** — STA is the 3D generalization of ring/grid attractors to spatiotemporal planning; it extends the same circuit motif (consistent states excite, inconsistent inhibit) so that fixed points encode entire future trajectories rather than single instantaneous states; confirms the generality of ring-attractor principles beyond navigation.
- **[[wiki/concepts/cortical-traveling-waves.md]]** — ring attractors exhibit a traveling-wave mode (A-CANN) when SFA adaptation strength m crosses the Hopf threshold; the cortical traveling-wave page treats instrength gradients as an alternative direction-selection mechanism for waves without requiring SFA; both mechanisms interact with intrinsic frequency gradients to determine wave behavior in extended networks.
