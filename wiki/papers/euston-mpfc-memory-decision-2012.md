---
title: "The Role of Medial Prefrontal Cortex in Memory and Decision Making"
type: paper
tags: [mPFC, memory-consolidation, hippocampus, decision-making, theta-oscillation, context-event-mapping]
created: 2026-06-27
updated: 2026-06-27
sources: [The Role of Medial Prefrontal Cortex in Memory and Decision Making]
related: [wiki/entities/prefrontal-cortex.md, wiki/concepts/memory-schemas.md, wiki/concepts/replay.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/nucleus-reuniens.md]
---

# The Role of Medial Prefrontal Cortex in Memory and Decision Making

Euston, Gruber & McNaughton. *Neuron* 76(6):1057–1070, 2012. doi: 10.1016/j.neuron.2012.12.002

---

## Computational Insights

- **Canonical input-output model of mPFC**: inputs are (current context, current events); output is the adaptive response that past experience predicts is best. Context = spatial location + emotional state (encoded by ventral HC). Events = sensory cues + actions. Output = motoric response (dorsal mPFC) or emotional/autonomic response (ventral mPFC). This framing explains mPFC involvement in both memory and decision-making as one function.
- **Dorsal-ventral gradient**: dorsal mPFC (ACC, dorsal PL) → action outputs (direct spinal projections, premotor connectivity); ventral mPFC (IL, ventral PL) → autonomic/emotional outputs (amygdala, hypothalamus, PAG, locus coeruleus, VTA connections). OFC provides sensory inputs to the whole system.
- **HC-mPFC theta phase-locking as retrieval mechanism**: ~50% of mPFC cells phase-lock to hippocampal theta during spatial tasks. Theta coherence (spike-LFP and LFP-LFP) increases as the animal approaches memory-guided choice points. Increased coherence follows acquisition of a new rule. Reduced phase-locking predicts errors — synchrony is either necessary for correct retrieval or reflects decision confidence.
- **HC-mPFC functional disconnection**: unilateral mPFC inactivation + contralateral HC inactivation ≈ bilateral mPFC inactivation across multiple memory paradigms (water maze, T-maze, radial arm, Hebb-Williams maze). Confirms mPFC depends entirely on the HC→mPFC unidirectional pathway for both context provision and rapid associative learning support.
- **Post-task consolidation window**: mPFC activity during the 1–2 hours immediately after a learning session is necessary for subsequent recall. Chemical disruption of mPFC within this window impairs memory tested 24–48h later; disruption before or after the window has no effect. This is HC-driven replay coordinating with mPFC during awake rest/early sleep.
- **Consolidation timeline**: hippocampus learns rapidly during the task; mPFC builds its mapping over ~2 weeks (rodent) via replay-driven synaptic strengthening. Remote memory is MORE mPFC-dependent than recent because at remote timescales mPFC both *stores* and *represents* context-event-response mappings, whereas during recent recall the mapping is still stored in HC.
- **mPFC stores schemas, not episodes**: representations are schematic (gist/regularities over many experiences), not episodic. HC enables the rapid per-episode binding; mPFC extracts the central tendency across episodes. This directly maps to slow-W learning via interleaved replay (McClelland et al. 1995).

## Limitations

- Review paper; primary evidence synthesized across rodent, primate, and human literature with varying task paradigms, making causal claims indirect.
- The claim that mPFC is needed for BOTH recent and remote memory conflicts with several inactivation studies showing selective remote-memory dependence; reconciliation relies on statistical power arguments.
- The parallel-learning-systems account (other areas compensate during on-line learning but not consolidation) is post-hoc and not directly tested.

## Links to Wiki Pages

- [[wiki/entities/prefrontal-cortex.md]] — primary entity page; theta coupling and disconnection evidence added there
- [[wiki/concepts/memory-schemas.md]] — post-task consolidation window and input-output framing added there
- [[wiki/concepts/replay.md]] — consolidation timeline consistent with SWA/SWR two-level consolidation hierarchy
- [[wiki/entities/hippocampal-entorhinal-system.md]] — ventral HC as source of context input to mPFC; HC-mPFC unidirectional anatomy
- [[wiki/entities/nucleus-reuniens.md]] — the indirect mPFC→RE→HC return pathway that reciprocates the direct HC→mPFC input
