---
title: "Compositionality Decomposed: How Do Neural Networks Generalise? — Hupkes et al., JAIR 2020"
type: paper
tags: [compositional-generalization, systematicity, productivity, benchmark, seq2seq]
created: 2026-06-19
updated: 2026-06-19
sources: [Compositionality_decomposed]
related: [wiki/concepts/compositional-generalization.md, wiki/concepts/structural-generalization.md, wiki/concepts/binding-problem.md, wiki/concepts/attention.md]
---

# Compositionality Decomposed: How Do Neural Networks Generalise?

Hupkes, Dankers, Mul & Bruni. *Journal of Artificial Intelligence Research* 67 (2020).

---

- **Five-facet decomposition:** Compositionality splits into five independently testable properties — systematicity, productivity, substitutivity, localism, overgeneralisation — each measuring a distinct failure mode that high task accuracy masks.
- **Chunking failure:** Models achieve 79–92% task accuracy on PCFG SET by learning *function-pair representations* rather than atomic functions; systematicity scores drop 22–34% below task accuracy, revealing that task success ≠ compositional understanding.
- **Localism failure is universal:** No architecture achieves >60% localism consistency — all models compute global meanings from full sequences rather than following the syntactic tree bottom-up; LSTM worst (46%), ConvS2S best (59%) due to local convolution bias.
- **LSTM learns length-specific function representations:** LSTM accuracy on function application drops to exactly 0 at max-train-length+1 characters; Transformer and ConvS2S degrade smoothly — a competence vs. performance failure mode distinction with direct implications for systematic rule composition.
- **Overgeneralisation reveals rule internalisation:** All architectures apply compositional rules to ~68–88% of exceptions at 0.1% exception rate; Transformer and ConvS2S transition cleanly to memorising exceptions once evidence accumulates; LSTM falls into a "neither rule nor exception" regime.

**Limitations:** Tested only on PCFG SET (artificial, fully compositional, sequence-to-sequence). Fixed hyperparameters — cannot be taken as general architectural claims. Requires rule application but no perceptual encoding; ARC-AGI adds the harder pixel-to-rule inference step.

---

→ [[wiki/concepts/compositional-generalization.md]] — five-facet framework and full PCFG SET results  
→ [[wiki/concepts/structural-generalization.md]] — this paper operationalises what "standard deep learning fails" means: failure on all five facets  
→ [[wiki/concepts/binding-problem.md]] — localism failure is a compositional rule binding failure: models don't bind sub-expressions to intermediate meanings before computing global output  
→ [[wiki/concepts/attention.md]] — transformer's global receptive field is a liability for localism specifically; excels on other four facets
