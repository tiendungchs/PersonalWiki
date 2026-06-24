---
title: "The Basal Ganglia and Cortex Implement Optimal Decision Making Between Alternative Actions — Bogacz & Gurney 2007"
type: paper
tags: [basal-ganglia, decision-making, MSPRT, action-selection, STN, globus-pallidus, striatum, bayesian, hicks-law]
created: 2026-06-20
updated: 2026-06-20
sources: [Basal_Ganglia_and_Cortex]
related: [wiki/entities/basal-ganglia.md, wiki/concepts/cognitive-control.md, wiki/concepts/working-memory.md, wiki/papers/helie-ccn-bg-2013.md, wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md, wiki/papers/pbwm-oreilly-frank-2006.md]
---

# Bogacz & Gurney 2007 — BG (Basal Ganglia) as Optimal Decision Maker

**Citation:** Bogacz, R., & Gurney, K. (2007). The basal ganglia and cortex implement optimal decision making between alternative actions. *Neural Computation*, 19(2), 442–477.

---

- **MSPRT circuit decomposition:** The cortex–BG circuit implements the Multihypothesis Sequential Probability Ratio Test (MSPRT) in the proficient phase. Direct pathway (D1 striatum → GPi/SNr) computes the negated salience term −yi(T). STN (Subthalamic Nucleus) receives diffuse cortical excitation and fires exponentially (exp transfer function); GP log-compresses STN (Subthalamic Nucleus) via inhibitory feedback; their combined output is S(T) = ln(Σ_j exp(yj(T))). BG (Basal Ganglia) output: OUT_i = −yi(T) + S(T) = −ln P(H_i | evidence). Selection fires by disinhibition when any OUT_i drops below threshold — equivalent to selecting the action with maximum Bayesian posterior probability. This is not winner-take-all but Bayesian log-posterior selection.

- **Biologically validated transfer functions:** MSPRT predicts STN (Subthalamic Nucleus) must fire as exp(input) and GP must log-compress STN (Subthalamic Nucleus) activity. Exponential STN (Subthalamic Nucleus) I/O confirmed in Hallworth et al. 2003 and Wilson et al. 2004 (current-injection recordings). GP fires approximately linearly in STN (Subthalamic Nucleus) input — which equals log-compression for large N (ln(linear · N) dominates) — confirmed Nambu & Llinas 1994. Both predictions were derived from the algorithm *before* comparison with physiology, then confirmed post-derivation.

- **Proficient vs. learning phase dissociation:** D2 striatum → GPe → STN (Subthalamic Nucleus) serves MSPRT normalization (computing S(T)) during proficient execution. During the learning phase, the same D2 pathway serves punishment blocking (blocking actions associated with negative outcomes, Frank et al. 2004). Same anatomy, context-determined mode. The paper restricts to proficient phase; the full BG (Basal Ganglia) account requires MSPRT (execution) + PVLV/RL (learning) as complementary modes. The transition mechanism between modes is not specified.

- **Hick's Law from first principles:** S(T) = ln(Σ_j exp(yj(T))) grows with N (number of alternatives), raising the minimum salience required for any action to cross the decision threshold. Consequently, decision time ∝ log(N) — exactly Hick's Law (Teichner & Krebs 1974). Derived analytically; confirmed in simulation vs. race model and UM model (mutual inhibition model). No ad hoc assumptions required.

- **Parametric robustness and cortical compatibility:** The MSPRT model is robust to miscalibrated cortical gain g: overestimation converges to MSPRT_b (a second asymptotically optimal test); underestimation converges to UM model (mutual inhibition); never worse than UM for any g. If cortex itself implements UM-style competition (inhibitory integrators), the BG (Basal Ganglia) output is mathematically unchanged — the Bayesian log-posterior is invariant to upstream cortical competition mode.

---

**Limitations:** Restricted to proficient phase; does not specify how BG (Basal Ganglia) transitions between MSPRT execution mode and RL learning mode, or what Dopamine state triggers each. Assumes localist (one-per-action channel) action representations; extension to distributed representations requires additional machinery noted as future work. Does not address simultaneous cognitive and motor loop selection — the cognitive-motor integration gap (Helie et al. 2013) is unaddressed.

---

**Links:** [[wiki/entities/basal-ganglia.md]] · [[wiki/concepts/cognitive-control.md]] · [[wiki/concepts/working-memory.md]] · [[wiki/papers/helie-ccn-bg-2013.md]] · [[wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]] · [[wiki/papers/pbwm-oreilly-frank-2006.md]]
