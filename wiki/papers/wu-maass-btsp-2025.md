---
title: "A simple model for BTSP provides content addressable memory with binary synapses and one-shot learning"
type: paper
tags: [btsp, content-addressable-memory, binary-weights, one-shot-learning, hippocampus, repulsion-effect, neuromorphic]
created: 2026-06-27
updated: 2026-06-27
sources: [wu-maass-btsp-2025]
related: [wiki/concepts/btsp.md, wiki/concepts/hebbian-learning.md, wiki/concepts/associative-memory.md, wiki/concepts/continual-learning.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/place-cells.md]
---

# A simple model for BTSP provides content addressable memory with binary synapses and one-shot learning

Wu & Maass (2025). *Nature Communications*. doi:10.1038/s41467-024-55563-6

---

## Key Computational Insights

- **Binary BTSP rule:** $\Delta w_i = \pm 1$ (with prob 0.5) when presynaptic input arrives within the ~10s plateau potential window from EC3; depends on current weight value and relative timing, not postsynaptic firing; analytically tractable via binomial theory
- **Bimodal weighted-sum distribution:** neurons in Q(**x**) (received plateau during pattern **x**) form a high cluster; others form a low cluster; threshold between clusters enables recall from up to 33% masked cues — impossible with random projections
- **Analytical capacity theory:** closed-form expressions for firing probability $p_e$/$p_o$ and expected Hamming distance between memory traces; predicts recall of >800k patterns at human-scale parameters ($n$ = 14M CA1 neurons)
- **Binary weights match continuous Hopfield:** BTSP with binary weights achieves comparable or better CAM quality than Hopfield networks with continuous weights for sparse inputs ($f_p$ = 0.005); continuous-weight Hopfield collapses when binarized
- **Repulsion effect:** LTD branch cancels shared-input weights for neurons receiving plateaus during two similar patterns → memory traces pulled apart; first learning-based model reproducing the human brain's repulsion effect (documented in fMRI)
- **Critical parameter $f_q$:** plateau potential probability per pattern; optimal value ~0.005, matching experimental measurement; trades off trace size vs. interference vs. repulsion
- **Superiority over fly algorithm (random projection):** BTSP tailors the projection to the specific input ensemble → creates attractor basins; random projections are input-agnostic → no attractor property, no masking robustness
- **Neuromorphic target:** binary weights + on-chip one-shot learning → directly implementable in crossbar memristor arrays with only 2 resistance states; potential to vastly expand on-chip CAM capacity beyond current Hopfield-based implementations

## Limitations

- Binary weight approximation: biological synapses may have more than 2 states per release site; the paper shows multiple binary release sites recover continuous-weight dynamics on average
- No account of the biological mechanism setting $v_{th}$; threshold is chosen by grid search in simulations
- CA3 recurrent dynamics not modeled; the model is feedforward CA3→CA1 (with optional Hebbian feedback from CA1→CA3 for full input reconstruction)
- Repulsion effect analysis uses fixed $f_q = 0.02$ (different from default 0.005) to make the effect measurable at modest M; in-vivo levels may be smaller

## Links

- **[[wiki/concepts/btsp.md]]** — full concept page with equations, capacity table, and design implications
- **[[wiki/concepts/associative-memory.md]]** — Hopfield vs. BTSP comparison; bimodal distribution as attractor mechanism
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — CA1 circuit context; EC3 plateau potential instructive signal
- **[[wiki/entities/place-cells.md]]** — BTSP as the molecular mechanism of one-shot place field acquisition
