---
title: "Refinement Loops (Test-Time Compute)"
type: concept
tags: [refinement-loop, test-time-training, evolutionary-program-synthesis, test-time-compute, abstract-reasoning, ARC-AGI, program-synthesis, MDL]
created: 2026-06-23
updated: 2026-06-23
sources: [ARC Prize 2025 Technical Report.md]
related: [wiki/concepts/meta-learning.md, wiki/concepts/information-theory.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/world-models.md, wiki/concepts/credit-assignment.md, wiki/entities/arc-agi.md, wiki/papers/arc-prize-2025-technical-report.md]
---

# Refinement Loops (Test-Time Compute)

**A refinement loop is a per-task iterative optimization cycle that transforms a candidate solution into a better one using a feedback signal, without updating weights across tasks — the optimization is entirely test-time and task-specific.**

Identified as the central theme of ARC Prize 2025. Distinguished from pretraining: refinement loops run *after* training, on a single task, exploiting a task-internal verifier rather than cross-task data.

---

## Formal Structure

```
Initialize: candidate c₀ (weights, program, or reasoning chain)
Repeat until stopping criterion:
  1. Generate: c' = Generate(c_t, task_examples, search_heuristic)
  2. Verify:   score = Verify(c', task_examples)
  3. Update:   c_{t+1} = Update(c_t, c', score)
Output: best candidate found
```

The verifier is task-provided (ARC-AGI: exact grid match on training pairs). Without a verifier, the loop degenerates to random search.

---

## ML Taxonomy: Four Types

| Type | Optimization space | Initialize from | Feedback mechanism | 2025 ARC-AGI-2 examples |
|---|---|---|---|---|
| **Test-time training (TTT)** | Weight space | Pretrained checkpoint | Gradient descent on task loss | NVARC (1st, 24.03%), MindsAI (3rd, 12.64%) |
| **Zero-pretraining DL** | Weight space | Random initialization | Gradient descent on task loss | TRM (7M params, 45% ARC-1, 8% ARC-2), CompressARC (76K params, 20% ARC-1) |
| **Evolutionary program synthesis** | Program space (symbolic or NL) | LLM prior / random | Input-output pair match | Berman (NL evolution), Pang (Python + abstraction library) |
| **Application-layer CoT harness** | Natural language chain | LLM prior | Verifier comparison (exact grid match) | Poetiq harness: Gemini 3 Pro 31%→54%, Claude Opus 4.5 comparable |

All four share the generate-verify-update skeleton; they differ in what is being optimized and how the gradient/update is computed.

---

## Type Details

### Test-Time Training (TTT)
Fine-tune a pretrained model's weights on the few task examples at inference time. The pretrained checkpoint provides a warm start; gradients push weights toward task-specific configurations.

- **NVARC (2025 winner):** Extends 2024 ARChitects TTT approach + synthetic data generation for stronger initialization.
- **ARChitects (2nd):** Masked-diffusion LM with 2D spatial awareness + recursive self-refinement + perspective-based scoring.
- **MindsAI (3rd):** TTT pipeline with augmentation ensembles, tokenizer dropout, novel pretraining.
- **Key advantage:** inherits all world knowledge from pretraining.
- **Key disadvantage:** requires a compatible pretrained checkpoint; inherits knowledge coverage limits.

### Zero-Pretraining DL
Initialize network randomly, train only on the current task's examples. The task itself is the complete training set.

**TRM — Tiny Recursive Model (Jolicoeur-Martineau 2025):**

Architecture: single network, two internal states — latent z and answer y.

```
For up to N_sup=16 improvement steps:
  1. Update z recursively n times: z ← f(x, y_current, z)
  2. Update answer: y ← g(y_current, z)
Output: final y
```

The latent z acts as a working memory that accumulates context; y is the current hypothesis; recursive updates allow progressive error correction. 7M parameters. Achieves 45% ARC-AGI-1, 8% ARC-AGI-2.

**CompressARC (Liao & Gu 2025):**

Principle: minimize the description length (MDL) of each task. A model that compresses the task examples well has inferred the underlying rule. VAE loss with decoder regularization substitutes for combinatorial search over program space:

```
loss = reconstruction_loss(examples) + β × KL(z || p(z))
```

No branching search; pure gradient descent. 76K parameters. Achieves 20% ARC-AGI-1, 4% ARC-AGI-2. One model per task, trained only at test time.

**Key property of both:** the resulting networks are extremely small and solve the task in weight space — the weights *are* the program.

### Evolutionary Program Synthesis
Maintain a population of candidate programs; select and mutate based on training-pair performance.

**Two phases:**
1. **Exploration:** generate many candidate programs via LLM sampling, mutation, or random search.
2. **Verification:** score candidates against all training input-output pairs; feedback drives next generation.

- Berman: evolves programs in natural language; LLM as the mutation operator.
- Pang: evolves Python programs; dynamically builds an abstraction library to guide synthesis (avoids re-discovering primitives).
- SOAR (Pourcel et al., Paper Award 2nd): LLM fine-tuned on its own successful search traces; self-improving over iterations.

### Application-Layer CoT Harness
Iterate over LLM reasoning chains with verifier feedback at the application layer (no weight modification).

- **Gemini 3 Pro:** 31% baseline → 54% with refinement harness at $31/task (vs. $0.81/task baseline).
- **Claude Opus 4.5:** comparable accuracy to Gemini 3 Pro at ~$60/task.
- CoT can be interpreted as a natural language program; extended thinking (138K tokens vs. 96 tokens) allows more refinement cycles within a single call.
- Requires: foundational model has adequate knowledge coverage of the task domain.

---

## Why Refinement Loops Work

| Ingredient | Role |
|---|---|
| **Verifier** | Provides noiseless task-internal feedback signal (exact grid match); eliminates reward hacking |
| **Search budget** | More iterations = higher probability of finding a good program |
| **Warm initialization** | TTT and CoT start near a solution; reduces search cost |
| **Program representation** | The space being searched (weights vs. programs vs. NL) determines what can be found |

**Key prediction:** refinement loops are currently bounded by verifier availability. Domains with verifiable feedback signals (math, code, visual puzzle) are directly addressable; open-ended domains (creative writing, general world knowledge) are not, unless a learned verifier can substitute.

---

## Relationship to Test-Time Scaling

Test-time compute scaling (chain-of-thought, repeated sampling) is a special case of application-layer refinement loops. Extended thinking modes in commercial models exhibit:
- Self-corrective behavior ("which fails the complete set requirement — I need to re-examine")
- Explicit verification against task constraints before committing to an answer
- Longer reasoning chains correlating with higher accuracy on ARC-AGI

---

## Open Problems

- **Verifier generalization:** current success depends on exact-match verifiers (ARC grid match, unit tests). Can learned verifiers substitute for exact verifiers in open-ended domains? If so, refinement loops could generalize beyond currently verifiable tasks.
- **Warm start vs. zero-pretraining:** TTT (warm start) generally outperforms zero-pretraining DL at the same compute, but zero-pretraining DL is surprisingly competitive on ARC-AGI-1 with tiny networks. Is the warm start informationally useful, or does it introduce bias from training distribution mismatch?
- **Program space vs. weight space:** evolutionary program synthesis operates in an interpretable space; weight-space refinement is opaque. For the goal of brain-inspired abstract reasoning, the correspondence between program operations and computational primitives is unclear.
- **Combining refinement types:** the best Kaggle submissions combine TTT with synthetic data. Can evolutionary program synthesis + TTT be combined into a single loop (program synthesis discovers the rule; TTT fine-tunes the executor)?

---

## Connections

- **[[wiki/concepts/meta-learning.md]]** — refinement loops are a new fast-inner-loop variant: instead of freezing weights and accumulating history in activation dynamics, they update weights (or programs) iteratively within a single task; the slow outer loop that produced the initialization is still present in TTT but absent in zero-pretraining variants; the LRM knowledge-boundedness limit applies to all loops that depend on a pretrained prior.
- **[[wiki/concepts/information-theory.md]]** — CompressARC's MDL principle operationalizes the Kolmogorov complexity framing from AIXI: a model with minimum description length of the training examples has inferred the shortest program consistent with the data; the VAE loss is a differentiable approximation to this.
- **[[wiki/concepts/abstract-reasoning.md]]** — refinement loops are currently the dominant method for ARC-AGI (the primary abstract reasoning benchmark); they succeed where one-shot inference fails by adding an iterative search dimension; the gap to human performance (~24% vs. ~84% on ARC-AGI-2) suggests that the refinement loop alone is insufficient without better world models or structural representations.
- **[[wiki/concepts/world-models.md]]** — Mode-2 planning (V-JEPA 2-AC, LeCun) is structurally identical to a refinement loop over action sequences: generate action plan → simulate outcome via world model → evaluate cost → update plan; the difference is that world-model planning optimizes over action sequences (not solutions), and the verifier is a learned cost function, not an exact matcher.
- **[[wiki/concepts/credit-assignment.md]]** — within TTT, gradient computation is standard backprop; within evolutionary synthesis, credit assignment is score-based selection (no gradient); within CompressARC, the VAE loss provides a differentiable credit signal for weight updates; the variety of credit mechanisms across refinement loop types maps onto the bias-variance taxonomy of credit assignment methods.
- **[[wiki/entities/arc-agi.md]]** — refinement loops are the primary technical driver of ARC-AGI-2 progress; the benchmark's verifiable nature (exact grid match) is what makes refinement loops tractable here; ARC-AGI-3 removes the in-loop verifier requirement, which should severely limit current refinement loop approaches.
- **[[wiki/papers/arc-prize-2025-technical-report.md]]** — primary source for this concept page; survey of all 2025 winning solutions and paper awards
