---
title: "Training Verifiers to Solve Math Word Problems"
type: paper
tags: [math-reasoning, verification, test-time-compute, GSM8K, scaling]
created: 2026-06-24
updated: 2026-06-24
sources: [Training Verifiers to Solve Math Word Problems.md]
related: [wiki/concepts/refinement-loops.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/abstract-reasoning.md]
---

# Training Verifiers to Solve Math Word Problems

Cobbe, Kosaraju, Bavarian, Chen, Jun, Kaiser, Plappert, Tworek, Hilton, Nakano, Hesse, Schulman (OpenAI). 2021. arxiv.org/html/2110.14168.

---

## Key Computational Insights

1. **Verification scales far better than generation**: a 6B verifier on full GSM8K matches a finetuned 175B generator — a 30× effective size multiplier; verification is a more sample-efficient learning target than solution generation.
2. **Token-level value functions outperform solution-level**: predicting correctness at every token provides auxiliary signal throughout the solution, not just at the final answer, which better captures intermediate reasoning quality.
3. **Test-time compute is critical**: performance improves with up to ~400 sampled solutions per problem; beyond this, adversarial solutions begin fooling the verifier and gains diminish.
4. **Generator and verifier must be separate**: a shared generator-verifier overfits; separate architectures allow the verifier to learn generalizable correctness heuristics without generator distribution collapse.
5. **Step-by-step solutions are necessary**: direct answer generation drops from 20.6% to 5.2% — models require intermediate reasoning scaffolding; without it, the latent path is never constructed.

---

## Limitations

Verifier overfits to final answers at small dataset sizes (<1K examples); test@100 performance peaks early and degrades with overtraining; some solutions reach correct answers via flawed reasoning (false-positive training labels); high inference cost at scale (100 samples × generation + verification per problem).

---

## Links

- [[wiki/concepts/refinement-loops.md]] — verifier training is the direct empirical instantiation of the generate-verify-update loop; 30× multiplier quantifies the gain from adding verification to the loop
- [[wiki/concepts/latent-graph-discovery.md]] — path evaluation (verification) scales more favorably than path generation, supporting architectural separation of traversal from scoring
- [[wiki/concepts/abstract-reasoning.md]] — evaluation is more learnable than generation: the asymmetry reveals that correctness structure is more regular than solution structure
