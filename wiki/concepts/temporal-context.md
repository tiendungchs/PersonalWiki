---
title: "Temporal Context (Contextual Drift)"
type: concept
tags: [temporal-context, leaky-integrator, retrieved-context, relational-memory, transitive-inference, entorhinal-cortex, episodic-memory]
created: 2026-07-03
updated: 2026-07-03
sources: [tcm-mtl-howard-2005]
related: [wiki/concepts/successor-representation.md, wiki/concepts/path-integration.md, wiki/concepts/prospective-coding.md, wiki/concepts/structural-generalization.md, wiki/concepts/associative-memory.md, wiki/concepts/working-memory.md, wiki/concepts/memory-schemas.md, wiki/entities/tem-model.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/papers/tcm-mtl-howard-2005.md]
---

# Temporal Context (Contextual Drift)

**A slowly-drifting, self-normalizing recurrent state vector that integrates the recent history of experience and serves as the sole retrieval cue — the mechanism from which the successor representation and TEM's structural code both descend.**

Introduced by the Temporal Context Model (TCM; Howard & Kahana 2002; extended to the MTL by Howard et al. 2005 [[wiki/papers/tcm-mtl-howard-2005.md]]).

---

## The Core Equation

$$\mathbf{t}_i = \rho_i \mathbf{t}_{i-1} + \beta\, \mathbf{t}_i^{IN}, \qquad \|\mathbf{t}_i\| = 1$$

- `t_iᴵᴺ` = input caused by the *item* presented at step i (not random drift — this is TCM's departure from earlier context models).
- ρ_i chosen each step to renormalize → context changes **as a function of input, not the passage of time** (no input ⇒ ρ=1 ⇒ no drift).
- With orthonormal inputs, similarity decays exponentially: `t_i · t_j = ρ^{|i−j|}` — the formal basis of the recency/contiguity effects.

Because `t` is the sole recall cue and decays gradually, temporal proximity → representational proximity. This is a **leaky integrator**: an RNN with a single fixed decay, the minimal precursor to path integration.

---

## Two-Component Retrieved Context

When item A recurs, its evoked input updates (Eq. 9):

$$\mathbf{t}_{A_{i+1}}^{IN} = \alpha_O\, \mathbf{t}_{A_i}^{IN} + \alpha_N\, \mathbf{t}_{A_i}, \qquad \gamma := \alpha_N/\alpha_O$$

| Component | Weight | Retrieval geometry | Association type |
|---|---|---|---|
| Old input `t_Aᴵᴺ` | α_O | Contributes only to *later* states → **asymmetric** | Forward pairwise |
| Reinstated prior context `t_A` | α_N | Symmetric around A | Backward + **transitive** |

**Hippocampal lesion = α_N → 0.** This selectively abolishes backward and transitive associations while sparing forward pairwise learning — matching Bunsey & Eichenbaum (1996). The HC's specific job in this framework: *reinstate the EC context state that was active when an item was first presented.*

---

## Memory Space: Emergent Latent Structure

The load-bearing result for abstract reasoning. New item-to-context learning (α_N>0) gradually **mixes** item representations so that `t_Aᴵᴺ · t_Bᴵᴺ` comes to reflect the **distance between A and B in the latent higher-order graph**, even for pairs never presented together:

- Double-function list `A→B→C→D→E→F` (pairs shown in random order) induces `t_Bᴵᴺ·t_Dᴵᴺ > t_Bᴵᴺ·t_Eᴵᴺ > t_Bᴵᴺ·t_Fᴵᴺ`.
- Transitive inference then falls out of a **similarity gradient**, not logical deduction — a primitive, fully-analytic instance of latent-graph discovery from co-occurrence statistics.
- Physiologically confirmed: Miyashita (1988) pair-coding cells in area TE acquire correlated firing for temporally-nearby stimuli; abolished by rhinal-cortex lesion (Higuchi & Miyashita 1996).
- Same two-process logic as Latent Semantic Analysis (co-occurrence + dimensional reduction) — semantic structure from context statistics.

---

## Evidence / Instantiations

| Domain | Input `t_iᴵᴺ` | What TCM reproduces |
|---|---|---|
| Free recall | Item vectors | Recency across timescales; asymmetric contiguity (CRP) |
| Spatial navigation | Velocity (head-dir × speed) | EC place fields; retrospective/trajectory coding (see [[wiki/concepts/path-integration.md]]) |
| Relational memory | Odor/item vectors | Transitive & backward associations; memory space |
| Cellular | — | EC-V graded persistent firing (Egorov 2002); divisive gain normalization (Chance 2002) |

---

## Open Problems

- **From leaky scalar to structured basis.** TCM's single ρ is a scalar decay; TEM/SR replace it with a *learned, factorized, action-conditioned* transition operator W. How the brain graduates from an unstructured leaky integrator to a periodic structural code (grid cells) is the open frontier — TCM predates grid cells and offers no account of hexagonal periodicity.
- **Gradient vs. genuine inference.** The memory space supplies a metric similarity gradient; it does not perform symbolic/logical inference. What downstream mechanism converts the gradient into a discrete relational judgment is unspecified.
- **Vocabulary is given.** Item vectors are assumed orthonormal and pre-existing; TCM does not discover the symbol alphabet from raw data.

---

## Connections

- **[[wiki/concepts/successor-representation.md]]** — TCM is the temporal precursor of SR: both accumulate a decaying trace of experience (ρ^{|i−j|} ↔ (I−γT)^{−1}); SR replaces TCM's scalar ρ with a policy-dependent transition matrix and its item inputs with state-occupancy, making explicit the structural operator TCM leaves implicit.
- **[[wiki/concepts/path-integration.md]]** — TCM's leaky integrator *is* path integration with a single scalar decay: with velocity input it path-integrates position (ρ=1 = perfect integrator), but intermediate ρ yields a history-dependent trajectory code; TEM generalizes ρ to a learned action-conditioned W.
- **[[wiki/concepts/prospective-coding.md]]** — TCM reproduces retrospective/trajectory coding directly and prospective coding weakly; it grounds these EC phenomena in the drift equation rather than in explicit look-ahead, and predicts prospective coding needs unmodeled HC→EC feedback.
- **[[wiki/concepts/structural-generalization.md]]** — the memory space is the most primitive instance of emergent latent-structure extraction: `tᴵᴺ` similarity comes to encode graph distance from co-occurrence alone, the analytic ancestor of TEM's learned structural code.
- **[[wiki/concepts/associative-memory.md]]** — TCM's `M^{TF}` (context→item) and `M^{FT}` (item→context) are Hebbian outer-product heteroassociators; context-cued recall is exactly content-addressable retrieval with the drifting context vector as the query.
- **[[wiki/concepts/working-memory.md]]** — the drifting `t` implements a leaky-integrator form of short-term memory that produces the recency effect without a discrete buffer; EC-V graded persistent firing (Egorov 2002) is its cellular substrate, a concrete instance of the persistent-vs-transient WM debate.
- **[[wiki/concepts/memory-schemas.md]]** — the memory space is a schema built by contextual binding: overlapping temporal contexts fuse items into an ordered relational structure supporting transitive inference, the same assimilation TCM ascribes to α_N > 0.
- **[[wiki/entities/tem-model.md]]** — TEM is the direct descendant: TCM's context `t` → TEM's structural code `g`; TCM's scalar ρ drift → TEM's learned path-integration W; TCM's item-to-context binding → TEM's conjunctive `p = f(g,x)`.
- **[[wiki/entities/place-cells.md]]** — TCM derives the place code as a leaky-integrated velocity history (a "pseudo-place code"), predicting history-dependence (retrospective/trajectory coding) that a pure positional code cannot produce.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — TCM's anatomical mapping: items = cortical association areas, context `t` = parahippocampal/EC, and the HC = the α_N reinstatement of prior EC context; grounds the map-vs-memory dual role in a single equation.
- **[[wiki/papers/tcm-mtl-howard-2005.md]]** — source paper unifying episodic recall, navigation, and relational memory under the contextual-drift equation.
