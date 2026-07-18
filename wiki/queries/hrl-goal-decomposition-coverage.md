---
title: "Does the Proposed Model Have HRL Goal-Decomposition, Corticostriatal Gating, Temporal Discounting, and MB/MF Arbitration?"
type: query
tags: [hierarchical-reinforcement-learning, goal-decomposition, corticostriatal-gating, pbwm, temporal-discounting, model-based-rl, model-free-rl, arbitration, ingest-tracker]
created: 2026-07-18
updated: 2026-07-18
sources: []
related: [wiki/queries/proposed-reasoning-model-block-architectures.md, wiki/concepts/cognitive-control.md, wiki/entities/basal-ganglia.md, wiki/concepts/neuromodulation.md, wiki/concepts/meta-learning.md, wiki/concepts/successor-representation.md, wiki/entities/prefrontal-cortex.md, wiki/concepts/memory-schemas.md, wiki/concepts/hierarchical-reinforcement-learning.md, wiki/papers/botvinick-niv-barto-hrl-2009.md, wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md, wiki/papers/kable-glimcher-subjective-value-2007.md]
---

# HRL Goal-Decomposition & RL-Arbitration Coverage in the Proposed Model

**Question:** When pursuing a long-term goal, the brain does not evaluate every micro-action against the multi-year objective — it uses **HRL to break a temporally-extended goal into a hierarchy of tractable subgoals**. Does the proposed reasoning model ([[wiki/queries/proposed-reasoning-model-block-architectures.md]]) contain mechanisms for: (1) the **rostrocaudal PFC axis**; (2) **corticostriatal DA "gating"** (striatum learns via RPE which short-term reps enter PFC WM and which subgoals are worth pursuing); (3) **temporal discounting** (smaller-sooner vs. larger-later); and (4) **model-free / model-based RL** at action selection? If not, which sources should be ingested?

---

## Answer — coverage matrix

| Mechanism | In wiki concept library? | Wired into the *proposed* model? | Home page |
|---|---|---|---|
| **1. Rostrocaudal PFC axis** | ✅ strong (+ **temporal-abstraction/options** reading, HRL page) | ✅ **yes** — Block 3C #1 (three-level gated TEM stack); ⚠️ temporal-option operator documented, not yet selected | [[wiki/concepts/cognitive-control.md]] + [[wiki/concepts/hierarchical-reinforcement-learning.md]] |
| **2. Corticostriatal DA gating (PBWM)** | ✅ strong (+ **create-or-reuse** extension, Collins & Frank 2013) | ⚠️ **concept present, not selected** for the v1 stack | [[wiki/entities/basal-ganglia.md]] |
| **3. Temporal discounting (5-HT = γ)** | ✅ **now grounded** (Kable & Glimcher 2007 ingested 2026-07-18) | ⚠️ **repurposed as planning depth**; SV signal now maps to Block 3D `V(g)`, inter-temporal choice still not a modeled decision | [[wiki/concepts/neuromodulation.md]] + [[wiki/papers/kable-glimcher-subjective-value-2007.md]] |
| **4. MB / MF RL at selection** | ✅ **now covered** (Daw uncertainty arbiter ingested 2026-07-18) | ⚠️ **dual exists (STA⇄replay-MCTS) + online arbiter now documented, not yet wired** | [[wiki/concepts/successor-representation.md]] + [[wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md]] |

**The genuine hole — now has a home (Botvinick, Niv & Barto 2009 ingested 2026-07-18, [[wiki/concepts/hierarchical-reinforcement-learning.md]]).** The leading framing — **HRL as goal *decomposition* (options / temporal abstraction / subgoal discovery)** — previously had no dedicated page. The rostrocaudal axis in the wiki is a **representational abstraction** hierarchy (rule depth); HRL/options is the complementary **temporal abstraction** hierarchy (temporally-extended action chunks). Botvinick maps *both* onto the same "higher = more anterior" frontal gradient, so they are two readings of one substrate — but the conceptual machinery (options = ⟨I, β, π_o⟩, SMDP, pseudo-reward, option-specific `V_o`, the subgoal-discovery problem) is now documented and wired to Blocks 3C/3D. The proposal itself flags "subgoal decomposition is the hardest unspecified component" — HRL supplies the *vocabulary* for that decomposition (option models, saltatory search, bottleneck/graph-partition subgoals) while leaving end-to-end subgoal **discovery** open.

### 1. Rostrocaudal axis — fully covered
`cognitive-control.md`: TMS-causal gradient (BA-8 S→R / BA-9-46 context / BA-10 rule-of-rules) + Badre 2010 parallel multi-level policy search (all levels search from trial 1; per-level reward-gated pruning; step-wise learning curves = rule-discovery signature). Instantiated as **Block 3C #1**. *Missing:* the temporal-abstraction/subgoal reading (see hole above).

### 2. Corticostriatal DA gating — documented (now with create-or-reuse), not chosen
`basal-ganglia.md` + `neuromodulation.md` map **PBWM** (O'Reilly & Frank 2006, already ingested): ~20K BG-PFC stripes, per-stripe Go/NoGo, DA-RPE learns which representation each PFC WM slot admits; D1 stabilizes / D2 updates (inverted-U). This *is* "which subgoals are worth admitting." **Extended by Collins & Frank 2013 (ingested 2026-07-18, [[wiki/papers/collins-frank-cts-task-set-2013.md]]):** nested PFC-BG / PMC-BG loops don't just gate *known* reps — the anterior loop **creates and clusters** latent task-set stripes (a "blank" stripe = a new task-set), with create-vs-reuse governed by a Dirichlet concentration α under the same DA-RL. This upgrades item #2 from "gate the known" to "grow the vocabulary of subgoal/rule reps." **But** the proposal's Block 3B v1 pick is **TRNN + meta-RL LSTM** and the WM seam is the **VQ⇄mask codec** — neither an RPE-gated stripe gate, let alone a blank-stripe-recruitment operator. The "worth pursuing" learning is partly displaced into **Block 3D's `V(g)` value head**. Integration gap unchanged: WM + goal-value head exist, but no explicit DA-gated *admission/creation* gate. **Caveat re the HOLE:** C-TS grows *representational* task-sets (context clusters), not *temporal* options — so it strengthens item #2 without closing the genuine hole (temporal abstraction, source #1).

### 3. Temporal discounting — a parameter, now with a value signal, still not a choice
`neuromodulation.md`: 5-HT = discount γ in `V(s)=E[Σγ^k r]`, with the depletion→impulsivity evidence. Proposal reads **5-HT (γ) = STA planning depth** — how far the planner looks, not inter-temporal preference between competing rewards. **Kable & Glimcher 2007 (ingested 2026-07-18, [[wiki/papers/kable-glimcher-subjective-value-2007.md]])** supplies the *output* γ controls: a **common-currency subjective-value signal** (vmPFC/ventral striatum/PCC) whose neural discount rate `k` matches each subject's behavioral rate, `SV=A/(1+kD)`. Two things this buys: (a) `k` is a **per-agent latent read from one value node**, not a fixed hyperparameter — and it maps directly onto Block 3D's `V(g)` head; (b) it **falsifies the β–δ two-system valuation view** — one continuous value scale covers all delays, so valuation is single even where control (MB/MF) is dual. *Still open:* no smaller-sooner-vs-larger-later **operator** — inter-temporal choice is grounded as a value signal but not yet wired as a modeled decision. Cheap to add (same γ).

### 4. MB / MF RL — dual present; arbiter now documented (Daw ingested), not yet wired
Proposal **D3** = **STA** (model-based: world model in weights, exploit) + **replay-MCTS** (deliberative, explore); offline replay consolidates MCTS→STA weights = an MB→MF *consolidation* path. `successor-representation.md` covers the SR middle-ground; Lake 2016 notes MB/MF cooperation. **Now filled (Daw, Niv & Dayan 2005, ingested 2026-07-18, [[wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md]]):** the explicit **online, uncertainty-based arbiter** — two controllers (PFC/DMS tree-search vs. DLS TD-cache) at the extremes of a statistical-efficiency-vs-computational-cost trade-off, each tracking a Bayesian **posterior variance** over its values, with the *more certain* one driving each response. This maps cleanly onto the proposal: STA/replay-MCTS = tree-search pole, a cached policy = caching pole, and the gate is the **calibrated posterior variance the Neural-Process Block-3A encoder already computes** (diffuse K=1 → explore/MB; sharp K≥3 → exploit/cache). *Still open:* the proposal only arbitrates by *offline consolidation*; wiring the Daw *online* per-decision switch (and its partial-evaluation expand-tree-vs-cache node rule) into D3 is now a documented-but-unbuilt addition, not a missing concept. See Follow-up 2.

---

## Ingest tracker — next 4 sources

Drop into `raw/` and say "ingest [filename]". Ranked by leverage; check off as ingested.

| # | Source | Fills | Target pages | Status |
|---|---|---|---|---|
| 1 | **Botvinick, Niv & Barto 2009** — "Hierarchically organized behavior and its neural foundations: an RL perspective" (*Cognition*) | HOLE: options/HRL → PFC-BG; subgoal decomposition, temporal abstraction, pseudo-reward | **new** `concepts/hierarchical-reinforcement-learning.md`; link Block 3C/3D | ☑ ingested 2026-07-18 → [[wiki/concepts/hierarchical-reinforcement-learning.md]], [[wiki/papers/botvinick-niv-barto-hrl-2009.md]] |
| 2 | **Daw, Niv & Dayan 2005** — "Uncertainty-based competition between prefrontal and dorsolateral striatal systems" (*Nat Neurosci*) | #4: explicit MB↔MF online arbiter | `successor-representation.md`, `meta-learning.md`; D3 arbiter | ☑ ingested 2026-07-18 → [[wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md]] |
| 3 | **Collins & Frank 2013** — "Cognitive control over learning: creating, clustering, generalizing task-set structure" (*Psych Review*) *(or Frank & Badre 2012)* | #2: hierarchical corticostriatal gating of *subgoal* reps (extends PBWM) | `basal-ganglia.md`, `cognitive-control.md`, `contextual-inference.md`; Block 3B gate | ☑ ingested 2026-07-18 → [[wiki/papers/collins-frank-cts-task-set-2013.md]] |
| 4 | **Kable & Glimcher 2007** *(or McClure et al. 2004)* — neural valuation of immediate vs. delayed reward | #3: inter-temporal choice as a modeled decision (lower priority) | `neuromodulation.md`; Block 3D | ☑ ingested 2026-07-18 → [[wiki/papers/kable-glimcher-subjective-value-2007.md]] |

---

## Implications

- Three of four mechanisms are **present as documented biology but not wired into the selected v1 stack** — the proposed model under-uses its own concept library on the RL/control side. The next ingests should push these from "documented" to "selected."
- The model's abstraction hierarchy (Block 3C) is **representational, not temporal** — it lacks options/subgoal chunking. Source #1 is the highest-leverage fix and would spawn the wiki's first dedicated HRL concept page.
- MB/MF is handled by *consolidation* (offline STA compilation) rather than *arbitration* (online uncertainty gating). Whether reasoning needs both is an open design question (Follow-up 2).

## Follow-up questions

1. **Subgoal discovery vs. rule discovery:** is subgoal decomposition a distinct mechanism, or does Badre's parallel multi-level policy search already supply it once goals (not just rules) are the search targets?
2. **Arbiter vs. compiler:** does ARC-AGI-3 need an online MB/MF arbiter (Daw), or is offline MCTS→STA consolidation a sufficient (and simpler) substitute?
3. **One γ or two?** Should the 5-HT parameter serve both planning depth (STA) and inter-temporal reward choice, or are these dissociable dials?

## See also
- [[wiki/queries/proposed-reasoning-model-block-architectures.md]] — the model this audits.
- [[wiki/concepts/cognitive-control.md]] / [[wiki/entities/basal-ganglia.md]] — rostrocaudal axis + PBWM gating substrate.
- [[wiki/concepts/successor-representation.md]] — the MB/MF middle-ground already in the wiki.
