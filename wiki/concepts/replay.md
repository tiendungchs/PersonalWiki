---
title: "Hippocampal Replay"
type: concept
tags: [replay, memory-consolidation, credit-assignment, offline-learning, state-space-construction, cann, traveling-wave]
created: 2026-06-09
updated: 2026-06-22
sources: [engram-transcript, memory-gate-transcript, Complementary Learning Systems, Complementary learning systems Why - Claude summary, Learning Fast and Slow Single- and Many-Shot Learning in the Hippocampus, acann-li-2024]
related: [wiki/concepts/two-learning-timescales.md, wiki/concepts/factorized-representations.md, wiki/concepts/engrams.md, wiki/concepts/neural-manifolds.md, wiki/concepts/structural-generalization.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/papers/engram-transcript.md, wiki/papers/memory-gate-transcript.md, wiki/papers/cls-oreilly-2011.md, wiki/papers/cls-mcclelland-1995.md, wiki/papers/learning-fast-slow-liao-2024.md, wiki/papers/whittington-cognitive-map-2022.md, wiki/concepts/ring-attractor.md, wiki/papers/acann-li-chu-wu-2024.md]
---

# Hippocampal Replay

**Offline reactivation of sequential hippocampal activity during rest/sleep — reinterpreted as offline composition of pre-learned representational bases into environment-specific state-space maps.**

---

## Traditional Views (Brief)

- **Credit assignment** (Mattar & Daw, 2018): prioritizes states most informative for updating value estimates — offline RL
- **Memory consolidation** (McClelland et al. 1995 [[wiki/papers/cls-mcclelland-1995.md]]): HC replays stored episodes during sleep to deliver an *interleaved* stream of diverse experiences to cortex; slow cortical learning requires this mixed diet to extract shared structure without catastrophic interference — replay is not copying but the scheduling mechanism that makes slow-W tractable
- **Planning**: forward replay simulates possible futures for decision-making

---

## Novel Interpretation: Offline State-Space Construction

After encountering a reward, every other location needs its vector relationship to that goal built into its state representation. This cannot happen during live behavior. Replay does it offline:

1. Animal encounters reward → goal-vector cells (GVCs) form at that location
2. During replay, the system path-integrates *offline* away from the reward
3. At each simulated location, the corresponding pre-learned GVC basis is bound to that hippocampal/cortical location via Hebbian memory
4. On the next visit, every state already encodes its relationship to the goal — no online credit assignment needed

This subsumes traditional accounts: both credit assignment (values propagate offline) and state-space construction (map is built, not just values) reduce to binding pre-learned compositional bases along replay trajectories.

---

## Key Properties

- **Computation happens offline:** online behavior is cheap — the expensive state-space composition was done during replay
- **Generalizes:** GVCs are pre-learned from behavioral statistics across many environments, so they work in novel environments immediately
- **Predictions:** replay should align with abstract entorhinal/frontal cortex replay (not just spatial sequences); outward replay from reward is needed for GVC construction; novel environments should trigger more replay than familiar ones

---

## Theta-Phase Oscillation and Error-Driven Encoding

During active waking, HC alternates constantly between encoding and retrieval at the theta rhythm (4–8 Hz) — not a strategic switch but a continuous oscillation (Hasselmo et al. 2002, O'Reilly et al. 2011 [[wiki/papers/cls-oreilly-2011.md]]):

| Sub-phase | Dominant pathway | Signal |
|---|---|---|
| **Retrieval (minus)** | CA3 strong, EC weak | Prior memory recalled → expectation |
| **Encoding (plus)** | EC strong, CA3 weak | Actual current input → outcome |

The delta between minus and plus is a prediction error driving contrastive Hebbian (Leabra-style) weight updates inside HC. Replay during waking is not a distinct process — it is the *retrieval sub-phase* of the theta oscillation; what we call "waking replay" is this sub-phase when the CA3 pattern diverges substantially from current EC input.

**REM sleep directionality reverses:** SWS sends HC sequences to cortex (consolidation). REM sends neocortical activity *back into* HC — endogenous CA3 activity and cortical input equalize memory strengths and re-encode HC representations to reduce interference between similar memories. This is memory *protection* for HC, not consolidation transfer.

**Relationship to SWR:** SWRs are an offline, compressed extension of the retrieval sub-phase — occurring during pauses and sleep when the theta oscillation is absent; the E/I competition mechanism selects which CA3 pattern wins, paralleling how CA3 dominates the retrieval sub-phase during theta.

---

## Co-Retrieval as Replay-Driven Engram Linking

Engram experiments [[wiki/concepts/engrams.md]] identify a second offline-linking mechanism beyond sleep replay: **co-retrieval** — repeatedly reactivating two engrams *simultaneously* causes them to merge a shared neuron pool encoding the link between memories. This is structurally identical to GVC binding during replay: both involve co-activating pre-formed representations offline to build new compositional structure. Co-retrieval is the waking analog; sleep replay the offline analog — same computational operation, different temporal context.

The shared neuron pool that emerges encodes the *relation* between memories, not their content. Silencing it selectively disrupts associative recall without affecting individual memories — direct evidence that relational knowledge is stored as a distinct engram, not as a property of either source engram.

---

## Sharp Wave Ripple Mechanism and Two-Stage Process

**SWR generation** (CA3→CA1):

| Step | Mechanism | Outcome |
|------|-----------|---------|
| 1 | Massive CA3→CA1 excitatory wave (sharp wave) | Primes many engram cells simultaneously |
| 2 | Inhibitory interneurons activate | Narrow windows of opportunity; E/I competition |
| 3 | Strongest patterns (most robustly encoded) win | Only winning memory gets replayed |
| 4 | Temporal compression ~10–20× | Seconds of experience → ~100ms replay |

The E/I competition is structurally identical to engram allocation [[wiki/concepts/engrams.md]]: winner-take-most selection via lateral inhibition operates at *encoding* (allocating which cells form the engram) and at *replay* (selecting which engram gets expressed).

**Two-stage architecture** (Science 2024, figure-8 maze, ~400 HC neurons):

| Stage | Trigger | HC action | Why this stage exists |
|-------|---------|-----------|----------------------|
| **Awake SWR** | Brief pause after reward | Replay recent trajectory; trigger local HC plasticity tagging pattern for sleep | Cortex not consolidation-receptive during waking; HC must maintain ongoing map |
| **Sleep SWR** | Offline sleep | Repeatedly replay bookmarked patterns; transfer to cortex | Cortex enters receptive state; many repetitions required; HC freed from online mapping |

**Evidence for the pipeline:** awake SWR content (decoded via UMAP projection onto maze manifold) specifically matches the most recent successful trial and trajectory. Post-learning sleep SWRs decode as the same patterns. Pre-learning sleep SWRs decode as completely different content.

The temporal compression (~100ms) is functionally critical: compressed replays arrive within cortical STDP windows, enabling synaptic strengthening. Awake SWR bookmarking solves the scheduling conflict — HC cannot both build the current map *and* run consolidation in parallel during waking.

---

## Adaptive Selectivity: Structure Over Experience

Liao & Losonczy 2024 ([[wiki/papers/learning-fast-slow-liao-2024.md]]) synthesize evidence that HC replay is not a verbatim reactivation of experience but an active filter biased toward structural regularities — a preprogrammed inductive bias toward building a transferable cognitive map.

| Finding | Source | What changes |
|---|---|---|
| SWRs recruit predictable stimuli; actively suppress random/salient ones | Terada et al. 2022 | Content — not experience-proportional |
| Replay upsamples under-experienced spatial regions; reduces behavioral bias | Grosmark et al. 2021 | Sampling distribution — corrects for time-on-location bias |
| Replay appears after single trial; gains resolution with experience | Berners-Lee et al. 2022 | Precision — coarse-to-fine not copy-then-refine |
| Remote experiences replayed more than imminent paths | Gillespie et al. 2021 | Temporal selection — not simply "replay-as-planning" |

The common thread: replay filters for *generalizable structure* and suppresses idiosyncratic episode-specific content. A stimulus that is a distraction in one context may be essential in the next — so HC must represent all stimuli online, then cull non-generalizable content offline.

**Proposed mechanism — inhibitory plasticity:** Liao et al. 2022 (computational modeling) show that selective offline suppression requires plasticity at inhibitory synapses themselves (GABAergic synapse weight modification), not just excitatory-to-inhibitory plasticity. Inhibitory interneurons must learn which patterns to suppress from SWRs — a process that requires experience-dependent modification of GABAergic weights. In vitro evidence for long-term GABAergic plasticity exists (Gaiarsa et al. 2002; Caillard et al. 1999); direct in vivo HC confirmation remains an open question.

**Implication for the W/M split:** Replay does not simply *deliver* episodes to cortex — it pre-processes them, removing noise and amplifying structure before transfer. This makes replay a distributed slow-W learning mechanism: the structural filtering happens in HC offline, before cortical extraction. The HC is not a passive relay but an active generalization engine.

---

## Traveling Wave as Intrinsic Memory Search

The A-CANN framework (Li, Chu & Wu 2024) provides a complementary, **trigger-free** replay mechanism: when SFA adaptation strength exceeds m > τ/τ_v, the network's own adaptation spontaneously destabilizes the static bump and drives it through the attractor space, revisiting stored states in sequence. Unlike SWR replay, no CA3 sharp-wave trigger or E/I competition is required.

| Property | SWR replay | Traveling-wave replay |
|---|---|---|
| Trigger | CA3 sharp wave → E/I competition | None — SFA threshold crossing |
| Content selection | Strongest engrams win E/I competition | All states visited; speed ∝ v_int |
| Displacement statistics | Episodic sequence; fixed-length | Power-law Lévy flights near m ≈ τ/τ_v |
| Phase of sleep | NREM SWS (primarily) | Quiet wakefulness / lighter sleep (proposed) |

**Lévy flight statistics:** when adaptation noise fluctuates m around the traveling-wave boundary, displacement follows p(||Δz||) ∝ ||Δz||^{−1−α} with α = 1 + 2μ/γ². Pfeiffer & Foster 2015 report this exact power-law in sequential place-cell reactivation at rest — the A-CANN provides the mechanistic origin from first principles.

**Neuromodulatory control:** ACh modulation of K⁺ conductance adjusts SFA timescale τ_v, setting m relative to the τ/τ_v threshold and thereby controlling which replay mode is active — making the traveling-wave search mode a **neuromodulatory function**, not a separate circuit.

---

## Connections

- **[[wiki/concepts/two-learning-timescales.md]]** — replay is the proposed biological mechanism for the slow W update: replayed HC sequences give cortex the clean (latent state → next state) pairs it needs to extract shared structural regularities across environments.
- **[[wiki/concepts/factorized-representations.md]]** — replay constructs factorized state-space maps offline: the GVC binding mechanism assembles local (goal-vector) bases with specific hippocampal locations, building the full compositional map without online experience.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — replay is an HC phenomenon; the specific prediction that replay radiates outward from reward locations follows from the GVC binding account and is a testable signature of offline state-space construction.
- **[[wiki/concepts/engrams.md]]** — co-retrieval is the waking analog of replay-driven engram linking: both involve offline co-activation of existing memory traces to build new shared representations encoding relational structure between memories. SWR E/I competition selects which engram gets replayed using the same winner-take-most mechanism as engram allocation.
- **[[wiki/concepts/neural-manifolds.md]]** — the UMAP maze manifold is the reference frame for decoding SWR replay content; off-manifold SWRs represent other cognitive processes that lie outside the task-learned subspace; the HC manifold encodes both spatial position and learning progress in the same low-dimensional structure.
- **[[wiki/papers/memory-gate-transcript.md]]** — source for SWR mechanism (E/I competition, temporal compression), two-stage bookmarking + consolidation architecture, UMAP decoding of replay content and off-manifold events.
- **[[wiki/papers/cls-mcclelland-1995.md]]** — foundational argument that replay must be *interleaved* (not just delivered): catastrophic interference in monolithic networks proves cortex needs a mixed diverse stream; replay is the scheduling mechanism that provides that stream, not merely a copying operation.
- **[[wiki/papers/cls-oreilly-2011.md]]** — source for theta-phase encoding/retrieval oscillation as the waking mechanism underlying continuous HC replay; REM = cortex→HC memory protection (reversal of SWS direction); HC-neocortex synergy establishing that consolidation is a transformation, not a literal transfer.
- **[[wiki/papers/learning-fast-slow-liao-2024.md]]** — source for adaptive replay selectivity (Terada 2022, Grosmark 2021, Berners-Lee 2022 synthesis) and inhibitory plasticity as the computational mechanism; establishes that SWRs actively filter for generalizable structure rather than replaying verbatim experience.
- **[[wiki/concepts/structural-generalization.md]]** — adaptive replay selectivity is the HC-level implementation of structural generalization: filtering idiosyncratic content and amplifying transferable regularities is the same operation structural generalization requires but expressed in the HC offline consolidation process.
- **[[wiki/papers/whittington-cognitive-map-2022.md]]** — source for the offline state-space construction framing of replay (distinct from the credit assignment and consolidation views); the GVC binding account derives from this paper.
- **[[wiki/concepts/ring-attractor.md]]** — traveling-wave state of A-CANN is an intrinsic memory-search mechanism in which SFA spontaneously drives the activity bump through all attractor states; Lévy flight statistics near the adaptation boundary match the power-law place-cell reactivation patterns documented in vivo.
- **[[wiki/papers/acann-li-chu-wu-2024.md]]** — primary source for the traveling-wave replay mechanism, the Lévy flight power-law statistics from noisy adaptation, and the neuromodulatory (ACh/τ_v) control of the WM-vs-search mode transition.
