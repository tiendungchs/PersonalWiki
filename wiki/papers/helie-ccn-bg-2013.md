---
title: "Exploring the Cognitive and Motor Functions of the Basal Ganglia — Helie, Chakravarthy & Moustafa 2013"
type: paper
tags: [basal-ganglia, action-selection, working-memory, categorization, sequence-learning, automaticity, motor-control, dopamine, direct-pathway, indirect-pathway, hyperdirect-pathway, TANs, cognitive-motor-integration]
created: 2026-06-20
updated: 2026-06-20
sources: [Exploring the cognitive and motor functions of the basal ganglia an integrative review of computational cognitive neuroscience models]
related: [wiki/entities/basal-ganglia.md, wiki/concepts/working-memory.md, wiki/concepts/meta-learning.md, wiki/concepts/two-learning-timescales.md, wiki/papers/pbwm-oreilly-frank-2006.md, wiki/papers/gerfen-surmeier-dopamine-striatum-2011.md]
---

# Helie, Chakravarthy & Moustafa 2013 — CCN Review of Basal Ganglia

**Citation:** Helie S, Chakravarthy S, Moustafa AA (2013). Exploring the cognitive and motor functions of the basal ganglia: an integrative review of computational cognitive neuroscience models. *Front. Comput. Neurosci.* 7:174.

- **Three-pathway algorithmic dissociation:** Direct = Go (disinhibit thalamus → action selection); Indirect = NoGo (multisynaptic channel-specific suppression); Hyperdirect = Hold (fast monosynaptic cortex→STN raises GPi inhibition non-specifically before pathway competition settles, enabling deliberate pause and goal-directed override). Only ~3 of 19 reviewed CCN models include hyperdirect; only ~5 include indirect — most models underspecify the inhibitory and braking arms.
- **TANs as catastrophic interference gate:** Cholinergic tonically-active neurons (TANs) learn to pause in rewarding contexts, releasing MSNs from inhibition and enabling corticostriatal RL. During extinction, TANs stop pausing → MSNs re-inhibited → learned weights protected. Fast reacquisition arises because intact learned weights re-emerge when TANs re-learn to pause — a second-order gate on the BG (Basal Ganglia) learning gate itself, implementing the same interference-protection the CLS (Complementary Learning Systems) two-timescale split achieves at the cortical level.
- **BG-WM three-architecture debate:** (a) BG (Basal Ganglia) gates thalamo-cortical reverberation (Monchi; FROST); (b) BG (Basal Ganglia) gates cortico-cortical loop then steps back — PBWM (Frank); (c) BG (Basal Ganglia) inside the maintenance loop (Schroll). Dissociation: (b) predicts thalamic lesion spares WM maintenance; (c) predicts BG (Basal Ganglia) lesion directly impairs maintenance, not just gating.
- **COVIS dual-system categorization:** Hypothesis-testing system (rapid, verbal, BG (Basal Ganglia) for WM gating + rule switching) and procedural system (slow dopamine RL in BG (Basal Ganglia) for stimulus-response associations). Dissociated by feedback delay: delay impairs procedural but not hypothesis-testing. This is the precursor dual-BG-loop architecture to formal meta-RL.
- **SPEED automaticity — BG (Basal Ganglia) trains then withdraws:** BG (Basal Ganglia) direct pathway trains cortical association→premotor connections via dopamine RL until consistent premotor firing triggers Hebbian LTP (Long-Term Potentiation) on the direct cortico-cortical route. Once strong enough, BG (Basal Ganglia) is no longer required for execution. Confirmed: GPi inactivation (Desmurget & Turner 2010) disrupts movement kinematics but not learned sequence knowledge — the compiled cortical route survives BG (Basal Ganglia) disconnection.

**Limitations:** No model simultaneously accounts for cognitive and motor BG (Basal Ganglia) function; direct-pathway-only models cannot reproduce full inhibitory/braking dynamics; 2013 predates deep-RL accounts of BG (Basal Ganglia) and modern SNN implementations.

**Links:** [[wiki/entities/basal-ganglia.md]] · [[wiki/concepts/working-memory.md]] · [[wiki/concepts/meta-learning.md]] · [[wiki/concepts/two-learning-timescales.md]] · [[wiki/papers/pbwm-oreilly-frank-2006.md]]
