---
title: "C2C (Connectome-to-Connectome) State Transformation Model"
type: entity
tags: [connectome, functional-connectivity, state-transformation, cognitive-states, PCA, PLS, fMRI, whole-brain-model]
created: 2026-06-26
updated: 2026-06-26
sources: [yoo-2022-c2c]
related: [wiki/entities/fcann.md, wiki/entities/default-mode-network.md, wiki/concepts/cognitive-control.md, wiki/concepts/latent-states.md, wiki/concepts/neural-manifolds.md, wiki/papers/yoo-2022-c2c.md]
---

# C2C (Connectome-to-Connectome) State Transformation Model

**A linear generative model that predicts an individual's task-specific functional connectome from their resting-state connectome via PCA-based subsystem extraction followed by PLS (Partial Least Squares) regression.**

Yoo et al. (2022), *NeuroImage*. Trained and validated on HCP S1200 (316 subjects, 7 cognitive tasks).

---

## Architecture

Three sequential steps:

| Step | Operation | Parameters |
|------|-----------|-----------|
| 1. Rest subsystem extraction | PCA on resting-state FC matrices | 100 components; scores: R_score = W_rest^T · R |
| 2. State transformation | PLS regression: R_score → T̂_score | 10 PLS latent variables; learned β from training set |
| 3. Connectome reconstruction | T̂ = W_task · T̂_score | W_task from separate PCA on task FC matrices |

Input: 35,778 unique edges (268×268 Shen-atlas FC matrix). Output: predicted task connectome per subject. Seven independent C2C models, one per task.

---

## Key Results (10-fold CV × 1000 iterations, n = 316)

| Metric | Value |
|--------|-------|
| Within-task similarity | r = 0.643 (Emotion) – 0.723 (WM) |
| State fingerprint success rate | 74% (chance = 14.3%) |
| WM behavior prediction (generated) | r = 0.180 vs. r = 0.076 (rest baseline) |
| Sample efficiency | 100 subjects (C2C) ≥ 300 subjects (rest-only baseline) |
| Within-individual vs. cross-individual | Within > cross for all 7 tasks (fingerprint amplified) |

---

## Task-General vs Task-Specific Subsystems

C2C's PLS coefficients reveal which PCA components reorganize similarly across all tasks (task-general) vs. differently (task-specific):

| Type | Components | Networks | Interpretation |
|------|-----------|----------|---------------|
| **Task-general** | 1, 2, 3, **6**, 7, 8 | Comp 1: group-mean within-network; **Comp 6: DMN within-network + cross-network**; Comp 7: subcortical/cerebellum; Comp 8: frontoparietal (partial) | Stable connectivity backbone preserved across all cognitive states |
| **Task-specific** | 4, 5, 9+ | Frontoparietal–frontal pattern of connectivity, some DMN-FPN relationship edges | Task-modulated overlay; each task reconfigures these differently |

Component 6 (DMN) is the sharpest task-general signal: its PLS transformation coefficients are statistically similar across almost every pair of 7 cognitive states. This establishes that DMN internal connectivity topology is a cognitive substrate that persists through state transitions, even as DMN BOLD activation is suppressed.

---

## Limitations

- Linear (PCA + PLS) — cannot capture nonlinear state dynamics, network merging/splitting, or higher-order interactions.
- Assumes one-to-one component correspondence across states; real reconfiguration may be more complex.
- Trained on healthy adults 22–36 (HCP); clinical or developmental generalizability unknown.
- Does not cleanly separate task-evoked connectivity from task coactivation (spurious inflation possible).

---

## Comparison to fcANN

| Aspect | C2C | fcANN |
|--------|-----|-------|
| Goal | Generate task connectome from rest | Recover attractor landscape from rest |
| Method | PCA + PLS regression | J = −Σ⁻¹ (precision matrix of resting FC) |
| State representation | PCA subsystem components | Eigenvectors of J (orthogonal attractors) |
| Individual differences | Amplified through transformation | Encoded in attractor basin geometry |
| Output | Specific task FC matrix | Energy landscape + attractor states |
| Task handling | Separate model per task | Single landscape; task = perturbation direction |

Both confirm that resting-state FC encodes sufficient information for cognitive state prediction. C2C generates specific task states via a learned linear path; fcANN identifies the static attractor structure within which those paths occur.

---

## Connections

- **[[wiki/entities/fcann.md]]** — complementary whole-brain models: fcANN recovers the energy landscape (attractor geometry) from resting-state FC; C2C learns the linear trajectory through that landscape as the brain moves from rest to a specific task; the task-general subsystems in C2C correspond to the stable basin structure in fcANN (the DMN/anti-DMN primary axis).
- **[[wiki/entities/default-mode-network.md]]** — C2C component 6 (DMN within-network connectivity + cross-network coupling) is task-general across all 7 cognitive tasks; DMN internal FC topology is a stable cognitive substrate even when BOLD activation is suppressed — task engagement modifies the DMN's relationship to external networks, not its internal connectivity structure.
- **[[wiki/concepts/cognitive-control.md]]** — C2C formalizes task-mode switching: task-general subsystems ≈ the fixed CC infrastructure (stable goal-maintenance backbone); task-specific subsystems ≈ task-dependent configuration signals; the PLS transformation stage maps directly onto LeCun's configurator, which primes the world model per task.
- **[[wiki/concepts/latent-states.md]]** — cognitive task engagement is a macro-level latent state in the connectome space: C2C learns to decode which latent state (task) the brain occupies from resting-state FC; the 74% state identification accuracy quantifies how linearly separable the 7 task-states are in the learned subsystem space.
- **[[wiki/concepts/neural-manifolds.md]]** — the 7 task connectomes and resting state lie on a shared low-dimensional manifold (100 PCA components suffice for reconstruction); C2C's state transformation is a learned path through this manifold; task-general vs task-specific components correspond to the manifold's stable vs. flexible principal directions.
- **[[wiki/papers/yoo-2022-c2c.md]]** — primary source.
