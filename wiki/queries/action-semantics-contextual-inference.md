---
title: "How Does the Brain Adapt to Changing Action Semantics? (Contextual Inference vs. a Trained action_to_v)"
type: query
tags: [action-semantics, contextual-inference, arc-agi-3, vocabulary-co-discovery, two-learning-timescales, motor-control]
created: 2026-07-17
updated: 2026-07-17
sources: []
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/meta-learning.md, wiki/concepts/memory-schemas.md, wiki/concepts/neural-manifolds.md, wiki/concepts/path-integration.md, wiki/entities/tem-model.md, wiki/entities/arc-agi.md, wiki/entities/vector-hash-model.md, wiki/entities/basal-ganglia.md, wiki/entities/prefrontal-cortex.md, wiki/architectural-gaps.md]
---

# Question

ARC-AGI-3 gives each game a limited action set (ACTION1–5 + CLICK(row,col)), but **what each action does differs per game** — the agent must discover action semantics, not just graph structure. Real agents face the same problem: the effect of an action is context-dependent. **Is there a neuroscience mechanism for adapting to changing action labels/vocabulary?** Training an `action_to_v` map (HICAAR block 1B) feels like a deep-learning workaround rather than a brain-inspired solution.

---

# Answer

**Yes — the mechanism is called *contextual inference*, and it is the explicit rejection of the single-context learner that `action_to_v` instantiates.**

## The core claim

Heald, Lengyel & Wolpert 2021 (*Nature* 600:489–493, the **COIN** model — COntextual INference) argue that memory **creation**, **updating**, and **expression** in sensorimotor learning are all controlled by one computation: inferring which *context* you are currently in, over a repertoire of context-specific models. The brain does **not** learn "what action A does." It maintains a **repertoire** of context-conditioned action→outcome models and infers a **posterior over which one applies now**. Adaptation is proportional to that posterior. COIN's nonparametric (Dirichlet-process) prior lets the repertoire **grow**: a new context is instantiated when no existing context explains the observations.

This is the direct answer to "the effects of our actions are not always the same": the brain never assumed they were.

## Four converging lines of evidence

| Source | Mechanism | What it contributes |
|---|---|---|
| **COIN** (Heald, Lengyel & Wolpert 2021) | Nonparametric Bayesian mixture over contexts; each context owns its own state-space action→outcome model; context posterior gates both *which* memory updates and *how much* | The normative theory; explains spontaneous recovery/savings that single-context learning cannot |
| **MOSAIC** (Haruno, Wolpert & Kawato 2001, *Neural Comput.* 13:2201–2220) | *N* paired forward/inverse modules; each module's **responsibility** = softmax over its own forward-model prediction error. Modules that predict well take control *and* receive the learning signal → self-specialization to contexts. A **responsibility predictor** estimates responsibility from contextual cues *before* acting | The mechanistic ancestor: a concrete circuit for "infer which action-semantics apply" |
| **Arbitrary visuomotor mapping** (Wise & Murray lineage) | The literal biological task: learn cue→action mappings that are *arbitrary* (no natural cue-action relation) — the exact type of ARC-AGI-3's ACTION1–5. **Division of labor: hippocampal system + ventral PFC acquire *novel* mappings; premotor–striatal circuits retain *overlearned* ones** | Fast acquisition and slow retention are **different circuits** — the biological form of the W/M split applied to action semantics |
| **BCI learning** (Sadtler et al. 2014 *Nature* 512:423; Golub et al. 2018 *Nat. Neurosci.*) | New arbitrary neuron→cursor mappings are learned **fast only if the required activity lies within the pre-existing intrinsic manifold**; learning is **reassociation** of existing activity patterns, not generation of new ones. Outside-manifold mappings take far longer | The hard constraint: fast re-binding happens **within** a learned repertoire; extending the repertoire is a different, slow regime |

## Why `action_to_v` is the wrong *type*, not the wrong *implementation*

The problem is not that `Linear(action_dim, space_dim)` is a neural net. It is the **type signature**: a function commits to **one** `v` per action, globally and permanently, learnable only by gradient descent.

- DESIGN.md already caught the symptom: *"Do not train one `action_to_v` across games — ACTION1–5 vary by game, so a shared operator averages conflicting semantics."* That is precisely COIN's critique of single-context learning: a single model **averages over contexts it should have separated**.
- But a **per-game `action_to_v` is not the fix either** — it just relocates the single-context assumption inside the game, and still needs many gradient steps to learn what a button does. A human learns it in ~1 press.

**The brain-inspired type is: `v` is a latent variable, not a parameter.**

> The action index is a **pointer** carrying no content. Its effect `v_a` is **inferred at play-time** from observed `(f_t, f_{t+1})` transitions, carries a posterior, and is freely re-bound per game.

## The mapping onto HICAAR blocks

| Piece | Biological role | HICAAR status |
|---|---|---|
| **Slow W** (backprop, across games) learns the **space of possible operators** — the SSP manifold / repertoire. The *only* thing trained on the multi-game corpus | The intrinsic manifold (Sadtler); premotor-striatal overlearned repertoire | 1B `SSPPathIntegration` + Phase-1 corpus training — exists |
| **Inference** of `v_a` from the agent's own transitions, keyed by action index: `v_a = 3A.posterior({(f_t, f_{t+1}) : a_t = a})` | MOSAIC responsibility / COIN context posterior. A Neural Process **is** an amortized responsibility computation | **3A `NeuralProcessInferrer` already does this** — currently aimed at ARC-style before/after examples, not at the agent's own transitions |
| **Fast M** binds pointer → point in the manifold, one-shot, per game | HC + ventral PFC acquisition of novel arbitrary mappings | `mem` (Vector-HaSH) — **built but unwired**; this is a keyed content store (key = action one-hot, content = `v`) |
| **Probing** to disambiguate action semantics | Epistemic foraging | 3D InfoGain — reducing 3A's posterior entropy over `v_a` *is* information gain; no separate "discover actions" phase needed |
| **Repertoire growth** when no existing operator explains the data | COIN's Dirichlet-process new-context instantiation; schema **accommodation** | **D2 (INVENT #1)** — COIN supplies the formal, implemented trigger this stub is missing |

## The CLICK caveat

ACTION6 is a different animal. ACTION1–5 are **pure pointers** (all content latent). `CLICK(row, col)` has **compositional** content: the coordinates carry shared cross-game structure (a click at `(r,c)` relates to position `(r,c)` in *any* game), while its *semantics* (select vs. paint vs. teleport) is latent. Click therefore needs its coordinate part in slow W and its semantic part in fast M — a **partial** binding. The `space_dim` / `action_dim` split (2026-07-15) is the seam where this can be expressed.

---

# Implications

1. **Do not train `action_to_v` at all — infer it.** Replace the parameter with a call to the 3A inferrer over the agent's own `(f_t, f_{t+1}, a_t)` transitions. The inferrer already exists and already returns a posterior; it is pointed at the wrong input.
2. **This wires `mem`** (STATUS item 3): the fast store's job is `action_id → v`, one-shot, reset per game. Keys are one-hot action indices — pairwise distinct and near-random, satisfying `MemoryCore`'s key semantics without the SSP-correlation worry flagged in STATUS.
3. **This collapses a STATUS risk item.** 3D's InfoGain term (item 2) subsumes action-semantics discovery: probing an ambiguous button is the highest-information-gain act available early in a game. No separate mechanism.
4. **This gives D2 (INVENT #1) a formal spec.** "When `x` stops supporting inference, something has to restructure" = COIN's CRP new-context test. Conflict-triggered accommodation is the same computation as repertoire expansion ([[wiki/concepts/memory-schemas.md]]).
5. **The multi-game corpus rung changes meaning.** It is not learning what actions do — it is learning the *manifold of what actions can do*. Sadtler predicts this is the load-bearing asset: fast per-game binding is only possible for operators already inside the learned manifold.
6. **Honest limit — this does not close Gap #3.** COIN/MOSAIC infer over contexts drawn from *prior experience*. They buy **vocabulary selection**, not **vocabulary invention**. A genuinely novel operator is the Sadtler *outside-manifold* regime, which took days of practice in monkeys. Contextual inference converts co-discovery into selection **only if** the corpus has taught a rich enough operator manifold — which is exactly the bet the multi-game corpus is making. The hard core of Gap #3 (inventing an operator never seen) remains open.
7. **ACTION7 (undo) is not an exception to patch, it is a category error.** In COIN terms undo is not an action with a `v`; it is a **state revert**. The current exclusion is principled, not a workaround.

---

# Follow-up questions

- Does `v_a` need a full posterior, or does MOSAIC-style responsibility over a **discrete** operator bank (VQ codebook, LAPA-like) suffice? Discrete makes one-shot binding trivial and connects to [[wiki/entities/vsa-model.md]]; continuous keeps 3A's calibrated uncertainty.
- What is the CRP concentration parameter's analog in D2 — i.e. what sets the threshold at which HICAAR decides "this operator is new" rather than "this is a noisy instance of a known operator"? This is the false-split/false-merge dial and likely the hardest hyperparameter in the accommodation trigger.
- Sadtler's outside-manifold regime took **days**. Is there any biological instance of *fast* repertoire extension, or is slow extension a hard constraint that ARC-AGI-3 (which demands within-episode novelty) simply violates? If the latter, the corpus must cover ARC's operator space almost exhaustively — a testable prediction.
- Does the responsibility-predictor idea (predict which context applies from *cues before acting*) map onto reading a game's **visual style** as a context prior — i.e., can D1's `x` serve as MOSAIC's contextual cue input?

---

## Sources to ingest (priority order)

1. **Heald, Lengyel & Wolpert 2021**, "Contextual inference underlies the learning of sensorimotor repertoires", *Nature* 600:489–493 — the normative theory; highest value.
2. **Haruno, Wolpert & Kawato 2001**, "MOSAIC Model for Sensorimotor Learning and Control", *Neural Computation* 13(10):2201–2220 — the responsibility-signal mechanism.
3. **Sadtler et al. 2014**, "Neural constraints on learning", *Nature* 512:423–426 — the intrinsic-manifold constraint on fast re-binding.
4. **Wise & Murray** arbitrary visuomotor mapping review — the acquisition/retention circuit dissociation.
