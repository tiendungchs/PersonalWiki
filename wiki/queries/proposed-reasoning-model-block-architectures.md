---
title: "A Proposed Brain-Inspired Reasoning Model: Per-Block Architecture Menus (ARC-AGI-3 target)"
type: query
tags: [architecture, reasoning-model, building-blocks, arc-agi-3, path-integration, transformation-inferrer, schema, planning, curiosity, latent-graph-discovery]
created: 2026-07-06
updated: 2026-07-18
sources: []
related: [wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md, wiki/papers/kable-glimcher-subjective-value-2007.md, wiki/queries/hrl-goal-decomposition-coverage.md, wiki/queries/central-framing-epistemic-audit.md, wiki/queries/building-blocks-mec-hc-pfc.md, wiki/queries/building-blocks-declarative-subsystem.md, wiki/queries/reasoning-as-coupled-navigation-strategizing.md, wiki/queries/mec-abstract-codes-vs-declarative-rules.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/path-integration.md, wiki/concepts/planning-as-inference.md, wiki/concepts/prospective-coding.md, wiki/concepts/refinement-loops.md, wiki/concepts/memory-schemas.md, wiki/concepts/neuromodulation.md, wiki/concepts/differentiable-plasticity.md, wiki/concepts/energy-based-models.md, wiki/concepts/relational-reinterpretation.md, wiki/concepts/recursion.md, wiki/concepts/core-knowledge.md, wiki/entities/tem-model.md, wiki/entities/spacetime-attractor.md, wiki/entities/vector-hash-model.md, wiki/entities/vsa-model.md, wiki/entities/trnn-model.md, wiki/entities/arc-agi.md]
---

# A Proposed Brain-Inspired Reasoning Model — Per-Block Architecture Menus

**Question:** Given the module inventory of [[wiki/queries/building-blocks-mec-hc-pfc.md]] (System 1), [[wiki/queries/building-blocks-declarative-subsystem.md]] (System 2 + gate), and the coupled dynamics of [[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]], propose a concrete reasoning model. For each block, rank candidate architectures by suitability — including ones we would have to **invent** (well-explored in neuroscience, not yet implemented in ML).

**Target regime (chosen):** ARC-AGI-3 general reasoner — interactive, verifier-free, latent goal. So the model must run the *full* coupled loop (both systems + gate + explore→imitate→practice curriculum) and must *bootstrap* a goal (Block 3D) from curiosity/learning-progress/empowerment, with no external in-loop verifier.

**Ranking convention (blended best-bet):** `#1` = best overall bet (neuroscientific fit × trainability × composability). Status tags: **[exists]** off-the-shelf; **[adapt]** existing arch, novel use; **[semi]** partially invented (pieces exist, the integration doesn't); **[INVENT]** no implementation, but the neuroscience specifies it. Depth is concentrated on the six high-leverage blocks (**1B, 3A, 3C/D3, D2, gate, 3D**); the near-solved blocks are compressed.

---

## 0. The model at a glance

Two factorized subsystems joined by a continuous↔discrete codec, driven by one coupled loop and one neuromodulatory bus:

```
                          ┌────────────── NEUROMOD BUS (Block 3D engine) ───────────────┐
                          │  DA(RPE+novelty)   ACh(write/read)   NE(explore)   5-HT(γ)  │
                          └───────────────────────────┬─────────────────────────────────┘
                                                      │
  SYSTEM 1 — NAVIGATOR (metric)                       │  SYSTEM 2 — STRATEGIST (declarative)
  "where am I / what will I see"                      │  "where do I want to go / how"
                                  gate                │
                               (VQ ⇄ mask)            │
  1A grid g → 1B path-integrate g → 1C fix ═══════════╪═►  VQ p→key → D1 encode → D2 schema slow-W
       │          ▲ (operator graph)                  │  (the meta-graph)
       ▼          │ ε_x = x'−x̂' (trains W & V(a), 3A) │  ▼  D3 rule-hierarchy
  2A/2B/2C/2D  HC memory M (bind/complete/gate) ◄═════╪═══  search (3C stack)
       │                                              │  (schema unmasks region-A edges,
       ▼                                              │   gates M writes — Block D4)
  3A Transformation Inferrer → 3B working memory → 3C/D3 planner (STA + replay-MCTS) → 3D goal
       ▲                                              │
       │  ε_r (DA) trains goal g_goal + policy π ◄────┘
  Offline: replay → consolidate M into schema/W  =  "compile System-2 search into System-1 intuition"
```

**One-line control flow** (from [[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]]): encode `x` → complete `p=f(g,x)` → Navigator reverse-predicts `x̂'` under a proposed operator → act/observe `x'` → **`ε_x` trains the operator vocabulary (3A)**, **`ε_r`/DA trains the goal (3D)** → Strategist uses the Navigator as a simulator to replay-sample and score candidate operator chains against `g_goal` → consolidate winners into schema/W.

**Training curriculum:** ① **Explore** (curiosity-driven self-supervised world-model pretraining), ② **Imitate** (behavioral cloning / process supervision on human step-traces — supplies the latent path for free), ③ **Practice** (RL/refinement on the agent's own rollouts). In ARC-AGI-3 there is no external verifier in-loop, so Phase-3's check is the **intrinsic** LP+empowerment signal (the load-bearing bet — see Block 3D).

---

## SYSTEM 1 — The Navigator (metric scaffold)

### Block 1B — Path integration over the operator graph  ★ DEEP

The Navigator core: update the structural code `g` under a *latent, compositional, invertible* operator vocabulary that must be co-discovered. Requirements for ARC-AGI-3: (a) operators continuous/composable, (b) **invertible** (inverse PI feeds Block 3A), (c) generator learnable end-to-end, (d) manifold-preserving.

| Rank | Architecture | Why it wins / loses | Status |
|---|---|---|---|
| **#1** | **SSP fractional binding** (`φ(x)⊛φ(d)=φ(x+d)`, Eliasmith) | Operator = one convolution; **inverse is analytic** (`φ⁻¹=φ(−x)` → free reverse edges for 3A); composable; grid periodicity *emergent* from Θ; **Θ learnable end-to-end**. Ceiling: operators are translation-like (abelian) — non-abelian rules need #2. | [exists] |
| **#2** | **Learned Lie-group / SO(N) generator** `g'=norm(g+R(v)g)`, `R` skew-symmetric conditioned on action vector `v` | Most general: exact manifold constraint, novel action *magnitudes*, non-abelian operators. But training the `v→R` map for a *latent* operator set is unsolved — the hard part. | [semi] |
| **#2-alt** | **Invertible cross-attention flow** — operator latent `a` conditions a coupling-layer update `g'=g+Attn(Q=g, K=V=a)` (`g` asks *which slots change*, `a` answers *how*); split-coupling gives an analytic inverse | The **trainable** stand-in for #2: attention learns the latent conditional map that `v→R` can't, and content-routes updates to *part* of `g` → native localized/conditional (non-abelian) operators SSP can't express. Coupling restores invertibility (free 3A inverse); needs norm-projection for the manifold, and `a`-space must be trained to compose. **Risk:** an unconstrained attention block reverts to shortcut chunking (cf. 3A #4) — the coupling/norm constraints are what prevent it. | [semi] |
| **#3** | **KAN-ODE / Neural ODE flow** `dg/dt=f(g,v)` | Continuous, param-efficient (KAN-ODE ~N⁻⁴ scaling), operator **symbolically recoverable** post-hoc. Weaker composition/inversion guarantees. | [exists] |
| **#4** | **A-CANN** (cosine-connectivity continuous attractor, traveling-wave modes) | Biologically exact substrate (fly CX-validated); but weights hand-tuned, not learned — poor fit for abstract latent operators. | [exists] |
| ✗ | TEM discrete `W(a)` lookup | Baseline. Closed vocabulary, no novel magnitudes, no invertibility → rejected for ARC-AGI-3. | [exists] |

**Recommendation:** SSP as the substrate (invertibility + composability + learnable Θ are exactly what the loop needs), with a learned SO(N) generator as the escape hatch when a rule is non-abelian. See [[wiki/concepts/path-integration.md]].

### Block 3A — Transformation Inferrer (inverse path integration)  ★ DEEP

**The critical capability absent from TEM.** Given K example pairs `(g_in, g_out)` → posterior over the operator/`W`. Must be permutation-invariant over the K examples and return **calibrated uncertainty** (K=1 diffuse → explore; K≥3 sharp → commit).

| Rank | Architecture | Why | Status |
|---|---|---|---|
| **#1** | **Neural-Process-style latent set encoder** — aggregate `{Δgᵢ}` → latent `z` = posterior over the operator | *Literally* "posterior over a latent function from a context set"; the diffuse-vs-sharp uncertainty is native and gates exploration (Block 3D). | [adapt] |
| **#2** | **Analytic SSP unbind** `op̂ = mean_i g_out,i ⊛ g_in,i⁻¹` | Closed-form, ~zero-cost operator estimate when 1B is SSP and the operator is a binding; a strong cheap prior to seed #1. | [semi] |
| **#3** | **Set-attention → operator codebook** (Set Transformer; cross-attend `{Δgᵢ}` to learnable `W` columns) | The building-blocks bridge; jointly optimized with the forward model so vocabulary is *shared*. Uncertainty less principled than #1. | [adapt] |
| **#4** | **In-context transformer** (K pairs as context → autoregress the operator) | The LLM/ICL route; strong pattern-matcher but prone to shortcut edges and no calibrated posterior. | [exists] |

**Open:** multi-step transforms (A→B→C) need *iterated* inference over #1 — a transformation chain, not one shot. This is where 3A hands off to the 3C/D3 planner.

### Block 3B — Working memory / context maintenance

| Rank | Architecture | Why | Status |
|---|---|---|---|
| **#1** | **TRNN** ([[wiki/entities/trnn-model.md]]) — self-inhibiting sparse hierarchical RNN | High-capacity multi-item WM (neuron-count-limited, not entropy-limited); `γ` = D1/D2 stability dial. Holds "what's in the workspace." | [exists] |
| **#2** | **Meta-RL LSTM** (Wang 2018) stacked above TRNN | Hidden state = within-episode RL algorithm; holds "what strategy am I running." | [exists] |
| **#3** | **S4 / MS-SSM** | Linear, multi-scale; MS-SSM beats Mamba on hierarchical reasoning. Mamba alone collapses (ListOps 38%). | [exists] |
| ✗ | Transformer context window | Baseline; entropy-limited WM. | [exists] |

### Blocks 1A / 1C / 2A–2D — near-solved substrate (compressed)

| Block | #1 pick | Alternates | Status |
|---|---|---|---|
| **1A grid substrate** | Oscillatory/toroidal pairs w/ learnable frequencies (VCO as inductive bias) | SSP basis; learned-RNN emergent (TEM); Vector-HaSH fixed coprime scaffold | [exists] |
| **1C landmark correction** | Cross-attention `x→(g,x)` + learned Kalman gain `K` | Modern-Hopfield `x→g` retrieval | [exists] |
| **2A bidirectional bind** | Reverse attention `x→g` (`softmax(x·Xᵀ)·G`) | — | [exists] |
| **2B pattern completion** | Iterative modern Hopfield (2–3 steps) | **Vector-HaSH scaffold** (exp. capacity, no cliff, no forgetting); sparse Hopfield; SDM | [exists] |
| **2C importance write gate** | Surprise-gated write `M←M+σ(ε_pred)·p` (ACh=α analog) | Prioritized-replay TD-error gate | [exists] |
| **2D sparse allocation** | Top-k straight-through write (2–6%) | k-WTA; adult-neurogenesis fresh-unit allocation | [exists] |

**Integration note:** **Vector-HaSH** ([[wiki/entities/vector-hash-model.md]]) elegantly fuses 1A+2B+2D — a fixed grid scaffold + heteroassociative content layer giving `⟨K⟩^M` capacity with no catastrophic forgetting. Strong candidate for the *whole* memory core rather than four separate modules.

---

## SYSTEM 2 — The Strategist (declarative / schema)

**What System 2 must *deliver* (the specification, not just the block list).** Per relational reinterpretation ([[wiki/concepts/relational-reinterpretation.md]]), the Strategist's job is to add the four Physical-Symbol-System properties System 1 lacks: **role-filler independence, type/token separation, concatenative composition, and classical (structural) systematicity**. These are a *checklist over the blocks*, not one module — D1's VSA role⊛filler binding supplies role-filler independence + type/token separation; D2's schema meta-graph + 3C's *recursive* hierarchy supply concatenative composition + structural systematicity. The failure mode every block must design against is **chunking**: collapsing a relation into an analog scalar (the representational root of shortcut reasoning) — the default a System-1-only stack reverts to. Penn's "graft, not scale" is the design mandate for building System 2 as distinct machinery rather than a bigger Navigator.

### Block D2 — Schema store (slow-W meta-graph)  ★ DEEP

**The load-bearing System-2 novelty.** Holds the declarative meta-graph; updates by **conflict-triggered accommodation** (mPFC), *not* a fixed regularizer — the biological answer to catastrophic interference.

| Rank | Architecture | Why | Status |
|---|---|---|---|
| **#1** | **Slow-weight associative store + conflict-*triggered* update** — EWC-style consolidation, but a *learned conflict detector* (schema-graph prediction error) fires assimilate (reuse engram) vs. accommodate (allocate + modify) | This is exactly the mPFC assimilation/accommodation mechanism ([[wiki/concepts/memory-schemas.md]]); the *trigger* is the missing piece — no ML system gates the update this way. **Addressing implementation:** cross-attention (new-experience `Q` → schema-slot `K/V`) supplies the *which-part-of-the-store-changes* routing natively — high slot-overlap ⇒ small targeted edit (assimilate), low ⇒ allocate (accommodate); the conflict detector only has to gate write *magnitude*. | [INVENT] |
| **#2** | **Differentiable plasticity / fast-weight programmers** (Miconi; Schmidhuber) | Slow outer loop meta-learns the plasticity rule; inner loop writes the schema via local Hebbian. Retroactive-neuromod variant = three-factor (eligibility + DA) matches accommodation timing. | [exists] |
| **#3** | **Context-modular / modern Hopfield** as schema store | Schemas = attractors; a context signal gates which schema is retrievable (Podlaski neuronal/synaptic gating). Clean, but no principled accommodation. | [exists] |
| **#4** | **GNN with editable adjacency** (explicit meta-graph) | Most literal meta-graph; but declarative graphs have *no metric hash* (the whole System-2 difficulty), so matching reverts to NP-hard search. | [exists] |

**Why #1 is worth inventing:** D2 is System 2's analog of Block 3A — the highest-value addition. The store itself is easy; the *conflict-gated write schedule* (assimilate vs. accommodate) is where structural generalization without forgetting lives.

**Two under-specified stages the store *reads through* — configurator + orientation (central-framing audit, [[wiki/queries/central-framing-epistemic-audit.md]]).** The block list above treats D2 as one always-active meta-graph, but the biology says the store is a **bank of parallel latent graphs** (Zheng 2024: transition vs. taxonomic maps coexist, separable, *not fused*) traversed via two operations the current diagram conflates ([[wiki/concepts/memory-schemas.md]], §Parallel Schemas + §Context Retrieval vs. Orientation):

| Stage | Job | Spatial analog | Where it lands here |
|---|---|---|---|
| **Configurator** (which-map selection) | Pick the task-relevant graph from the parallel bank *before* navigating | Context retrieval (PPA→HC) | Upstream of the gate — the VQ selector token (§codec #1) is the seed, but it must select *among stored schemas*, not just quantize position |
| **Orientation / anchoring** | Locate & align the current instance *onto* the selected map (fix coordinates + axes) | RSC local↔global reference-frame transform; Park's cross-session grid-angle realignment | **A genuinely missing block** — no current block registers a novel instance onto a retrieved schema |

The Navigator's graph-matching (SSP grid-phase shift, Block 1B) *is* the System-1 orientation op for embeddable structure; System 2 lacks its declarative counterpart. This is why the audit flags anchoring as the pillar with **no demonstrated abstract analog** — and marks the configurator+orientation pair as a required addition, not an optional refinement.

### Blocks 3C + D3 — Rule hierarchy + planner (the Strategist search)  ★ DEEP

Two coupled things: **3C** = the hierarchical *representation*; **D3** = the *search* over it. The ARC-AGI-3 twist: the graph is latent, so the planner needs both an *exploit* mode (structure known) and an *explore* mode (structure latent).

**3C — hierarchical representation:**

| Rank | Architecture | Why | Status |
|---|---|---|---|
| **#1** | **Three-level gated TEM stack** — `W_rule-of-rules` (BA-10) → `W_context` (BA-9/46 hub) → `W_instance` (BA-8) | Matches the TMS-causal rostro-caudal gradient; explicit gating where the higher level sets the lower level's operator context. | [semi] |
| **#2** | Hierarchical SSM / hierarchical VAE | Multi-timescale abstraction, but gating is implicit (no explicit rule-context control). | [exists] |
| ✗ | Multi-layer transformer | Implicit, non-gated hierarchy → fails localism/compositional-interaction (ARC-AGI-2 gap). | [exists] |

**Why three levels and why *recursive*** ([[wiki/concepts/recursion.md]]). A flat or finite-state W is *provably insufficient*: finite-state grammars cannot capture center-embedding (the AₙBₙ regime), so the hierarchy must support rules-embedded-in-rules (phrase-structure) — this is the formal content of the multi-level meta-graph, not a capacity choice. It also fixes the **3A↔3C handoff**: multi-step transforms (A→B→C) require *iterated* Transformation-Inferrer inference — a recursive operator chain over Block 3A #1, not a single shot. The open question is which mechanism supplies the bounded stack/push-down memory recursion needs (WM gating, replay, or external memory), since finite-state dynamics are generic to any RNN but a stack is not.

**D3 — search / planner:**

| Rank | Architecture | Why | Status |
|---|---|---|---|
| **#1 (exploit)** | **STA / planning-as-inference** ([[wiki/entities/spacetime-attractor.md]]) — embed the discovered graph in recurrent weights, relax to a fixed point = full trajectory; conveyor-belt execution | No autoregressive rollout error; parallel multi-trajectory eval; handles within-trial dynamic reward. **Requires a pre-learned world model** → this is the *familiar-structure* planner. | [exists] |
| **#1 (explore)** | **Replay-MCTS refinement loop** — HC/DMN preplay *generates* candidate operator chains (prospective coding → multi-step), Navigator rolls them forward, PFC value head *verifies* against `g_goal` | The generate→verify→update loop ([[wiki/concepts/refinement-loops.md]]); the only mode that works when structure is *latent* (ARC-AGI-3). Pairs with 3D's intrinsic verifier. | [adapt] |
| **#2** | **Hierarchical RL / options** with parallel level-search + reward-gated pruning (Badre) | The biological D3 (all levels active from trial 1). Sample-hungry. | [exists] |
| **#3** | **Hierarchical STA** (stacked spacetime attractors) | Extends planning depth exponentially — but requires *learning the abstractions* that define each level's state space (open problem). | [INVENT] |

**Recommendation:** run **both #1s** — STA as the fast cached planner once `W` is learned, replay-MCTS as the deliberative fallback while structure is still latent. This is the brain's own dual (STA exploit ⇄ HC-preplay explore, Jensen 2026) and the compilation story: repeated MCTS solutions consolidate (offline replay) into STA weights = System-2 search becoming System-1 intuition.

**Online arbiter (the missing per-decision switch — Daw, Niv & Dayan 2005, [[wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md]]):** the compilation story above is an *offline* MB→MF path only; it never decides *at act-time* whether to deliberate (replay-MCTS, model-based tree-search) or fire the cached policy (model-free). Daw's rule supplies it: track each controller's **posterior variance** over values and let the *more certain* one drive the response. This is nearly free here — the Neural-Process 3A encoder already emits calibrated uncertainty (diffuse K=1 → deliberate; sharp K≥3 → cache), and its **partial-evaluation** form (expand-tree-vs-fall-back-on-cache by uncertainty at each node) is the same expand/skip decision as HRL option models. Adding it turns D3 from "compile offline" into "compile offline **and** gate online." See [[wiki/queries/hrl-goal-decomposition-coverage.md]] mechanism #4 and Follow-up 2.

### Blocks D1 / D4 — encoder + write gate (compressed)

| Block | #1 pick | Why | Alternates | Status |
|---|---|---|---|---|
| **D1 relational encoder** | **Slot-attention front-end → VSA role-filler binding** | Slot attention gives object-centric discrete slots from the ARC grid (the objectness prior); VSA/HRR binds `role⊛filler` invertibly, composably, fixed-width ([[wiki/entities/vsa-model.md]]). | Graph tokens/GNN; VQ-VAE codebook | [exists] |
| **D4 schema write gate** | **Overlap-gated allocation** (de Sousa vmPFC→MEC→NGF template): schema-match high → reuse engram cells; low → allocate fresh | Declarative analog of Block 2C; controls ensemble overlap = assimilate vs. accommodate at the cell level. | Neurogenesis fresh-unit allocation | [semi] |

---

## The gate — continuous↔discrete codec  ★ DEEP

The runtime seam of the coupled loop. Two directions; the residual difficulty is a **format codec**, since both biological channels are already named ([[wiki/queries/building-blocks-declarative-subsystem.md]] §4).

**System 1 → System 2** (metric position `p=f(g,x)` → discrete schema key; the Miller-2002 sharp-boundary op):

| Rank | Architecture | Why | Status |
|---|---|---|---|
| **#1** | **VQ (vector quantization)** of `p` → schema codebook index | Continuous → sharp symbol; "am I in region A?" becomes a discrete selector token. | [exists] |
| **#2** | Cross-attention from `p` to a set of schema keys | Soft, differentiable; no hard codebook commitment. | [exists] |
| **#3** | **Jointly-inferred schema key** (co-discovered *with* the schema, à la 3A vocabulary co-discovery) | The principled version — the schema key isn't pre-fixed. Open problem. | [INVENT] |

**System 2 → System 1** (schema → bias the Navigator's operators + gate M writes; "apply rule X only in region A"):

| Rank | Architecture | Why | Status |
|---|---|---|---|
| **#1** | **Schema-emitted mask over the 1B operator vocabulary + write-gate over 2C/2D** | Direct de Sousa NGF template: schema X unmasks region-A edges, suppresses others. | [semi] |
| **#2** | **FiLM conditioning** (schema → γ,β modulating Navigator layers) | Cheapest buildable version of the same bias; no per-edge mask. | [exists] |

**The bind at the seam:** a nonlinear conjunction of (metric position, active schema) — **mixed-selectivity conjunctive tuning** (Rigotti). Anatomically the two formats co-locate in vmPFC (Constantinescu 2016), the natural place to put the codec.

---

## Block 3D — Goal / curiosity engine  ★ DEEP (the ARC-AGI-3 crux)

Verifier-free + latent goal means the goal must be **bootstrapped**. Two parts:

**(a) Goal representation & generation**

| Rank | Architecture | Why | Status |
|---|---|---|---|
| **#1** | **Learned value head `V(g)` over structural space**, sharpened by DA-stamped reward into a structured `g_goal` target; action = `argmin_a ‖f(W g,a) − g_goal‖` | vmPFC mechanism; unifies with the Transformation Inferrer when before/after is given. `g_goal` starts as scalar valence, becomes a g-space target. | [semi] |

**Biological grounding for `V(g)` (Kable & Glimcher 2007, [[wiki/papers/kable-glimcher-subjective-value-2007.md]]):** vmPFC/ventral-striatum/PCC explicitly encode a **common-currency subjective value** — one continuous scale for rewards at all delays, `SV=A/(1+kD)`, with the *neural* discount rate matching each subject's *behavioral* rate. Three design cues for this block: (a) the value head is a **single common-currency node**, not one head per reward-type or per-delay-regime (falsifies the β–δ two-system valuation split); (b) the discount `k` (= 5-HT/γ) is a **per-agent latent read out of `V(g)`**, not a global hyperparameter — so temporal discounting and planning-depth γ can share one dial (Follow-up in [[wiki/queries/hrl-goal-decomposition-coverage.md]]); (c) it confirms valuation is **single even where control is dual** (System 1/2, MB/MF), so only one `V(g)` head is needed regardless of how many planners consume it. *Not yet wired:* an explicit smaller-sooner-vs-larger-later inter-temporal **choice operator** — the value signal exists, the modeled decision over competing delayed rewards does not.

**(b) Intrinsic reward that bootstraps the goal** — the single most important design choice:

| Rank | Signal | Rule | Kills which failure | Status |
|---|---|---|---|---|
| **#1** | **Blended `r_int`** = `w₁·LP + w₂·InfoGain + w₃·Empowerment − w₄·cost` | assemble the three below | the composite is the bet | [semi] |
| ┗ | **Learning progress (LP)** | maximize `−d/dt E[ε_x]` per region | ignores mastered *and* unlearnable → auto-curriculum at intermediate difficulty; defeats the **noisy-TV** trap that kills raw novelty | [exists] |
| ┗ | **Information gain** | expected drop in posterior entropy over `W` | undirected novelty-seeking | [exists] |
| ┗ | **Empowerment** `I(A;S′)` | reach controllable states | wandering into uncontrollable regions | [INVENT] cheap neural estimator (variational bound, or count of reliably-reachable next-states) |
| ✗ | Raw DA-novelty (`ε_x` as reward) | maximize prediction error | hijacked by aleatoric noise (noisy-TV) → rejected as *sole* signal | [exists] |

**The verifier substitute:** in Phase-3 practice, LP+empowerment is the candidate internal stand-in for the missing external verifier (open Q5). This is the biggest risk in the whole design — self-generated reward can reintroduce reward-hacking; LP+empowerment are chosen precisely because they reward error-*reduction* and controllability, not raw surprise.

**Neuromodulatory bus** (all buildable as learned scalar gates, Doya mapping — [[wiki/concepts/neuromodulation.md]]): **DA** dual-role (RPE for value + novelty for exploration; plasticity signal + activity input), **ACh** (write/read α = Block 2C gate), **NE** (explore β; *plus* attractor-flattening on detected non-stationarity), **5-HT** (planning horizon γ = STA depth).

---

## Recommended v1 concrete stack (if building tomorrow)

Pull the #1 from each block into one system, and sequence the build by the priority order of the block pages:

| Tier | Blocks | Concrete v1 choice | Effort |
|---|---|---|---|
| **A. Memory core** | 1A+2B+2D | **Vector-HaSH** scaffold (fused) | Low |
| | 2C, 2A, 1C | surprise-gated write; reverse attention; Kalman fix | Low |
| **B. Navigator** | 1B | **SSP fractional binding** (+ SO(N) escape hatch) | Med |
| | 3A | **Neural-Process set encoder** (seeded by SSP analytic unbind) | High |
| | 3B | **TRNN + meta-RL LSTM** | Med |
| **C. Strategist** | D1 | **slot-attention → VSA** | Low |
| | D2 | **conflict-triggered slow-W store** ⟵ *invention #1* | High |
| | 3C | **three-level gated TEM stack** | High |
| | D3 | **STA (exploit) + replay-MCTS (explore)** | High |
| | D4 | overlap-gated allocation | Med |
| **D. Gate** | S1→S2 / S2→S1 | **VQ in / mask+FiLM out**, mixed-selectivity bind | Med |
| **E. Goal engine** | 3D | **V(g) head + blended r_int (LP+InfoGain+empowerment)** ⟵ *invention #2* | High |
| **F. Training** | — | explore (curiosity SSL) → imitate (BC on human traces) → practice (intrinsic-verifier RL) + offline consolidation | High |

**What must be invented (ranked by leverage):**
1. **Blended intrinsic-motivation engine as internal verifier (3D)** — without it, ARC-AGI-3's verifier-free regime has no learning signal. Assembles existing LP/InfoGain pieces + a cheap empowerment estimator [INVENT].
2. **Conflict-triggered schema slow-W (D2)** — structural generalization without catastrophic forgetting; the store exists, the *accommodation trigger* doesn't.
3. **Learned SO(N)/Lie-group operator generator for latent non-abelian rules (1B #2)** — SSP covers the abelian case; this covers the rest.
4. **Hierarchical STA with learned abstractions (D3 #3)** — exponential planning depth; blocked on the abstraction-learning problem.
5. **Jointly-inferred schema key (gate #3)** — the principled S1→S2 codec.

---

## Implications

- **The model is two factorized subsystems + a codec, not one pipeline.** A pure grid/path-integration model (System 1) cannot represent amodal declarative rules; a pure rule-search model (System 2) forfeits the periodic-hash generalization that makes metric structure cheap. ARC-AGI-3 needs both plus the gate.
- **Most blocks are [exists]/[adapt]; the whole reduces to ~5 inventions**, and two of them (3D intrinsic verifier, D2 accommodation trigger) carry almost all the risk. The near-solved substrate (1A/1C/2A–2D) should be assembled from Vector-HaSH + modern Hopfield with minimal novelty.
- **The single overloaded DA signal (RPE + novelty) is why a goal-free agent can bootstrap a goal** — and it is absent from all current architectures. Block 3D is where this proposal most departs from the solver stack.
- **Compilation is free in this design:** offline replay consolidates replay-MCTS solutions into STA weights and schema/W — effortful System-2 search becomes fast System-1 intuition without a separate mechanism.

## Follow-up questions

1. **Intrinsic verifier robustness (Q5 carried forward):** does LP+empowerment survive as a Phase-3 verifier, or does self-generated reward reintroduce reward-hacking on ARC-AGI-3?
2. **Region provenance for LP (chicken-egg):** LP is defined per region, but regions are the latent-graph partition still being discovered. How is the partition bootstrapped before `W` exists?
3. **One codec or two seams?** Is the continuous↔discrete conversion intra-regional (vmPFC mixed-selectivity, one seam) or genuinely inter-regional (two channels)? Determines whether VQ-in/mask-out is one module or two.
4. **Does the SSP abelian limit bite?** How many ARC-AGI operators are non-abelian enough to *require* the SO(N) generator, versus expressible as SSP bindings?
5. **Minimal prior scaffold:** which of {grid manifold, Core-Knowledge priors, reward machinery} must be *built in* (not learned) to make the coupled loop sample-tractable at init?

## See also
- [[wiki/queries/building-blocks-mec-hc-pfc.md]] / [[wiki/queries/building-blocks-declarative-subsystem.md]] — the module inventory this page turns into ranked architecture menus.
- [[wiki/queries/reasoning-as-coupled-navigation-strategizing.md]] — the coupled loop and curriculum that drive the blocks.
- [[wiki/concepts/latent-graph-discovery.md]] — the core problem this model targets; ARC-AGI-3 = latent edges + latent goal + non-stationary state.
- [[wiki/entities/spacetime-attractor.md]] / [[wiki/concepts/planning-as-inference.md]] — the D3 exploit-mode planner.
- [[wiki/concepts/refinement-loops.md]] — the D3 explore-mode generate→verify→update loop.
- [[wiki/queries/hrl-goal-decomposition-coverage.md]] — coverage audit of this model against HRL goal-decomposition, corticostriatal PBWM gating, temporal discounting, and MB/MF arbitration; flags the missing options/subgoal mechanism and tracks the next 4 ingests.
