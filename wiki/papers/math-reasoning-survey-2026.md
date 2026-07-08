---
title: "Artificial Intelligence for Mathematical Reasoning: An Integrated Survey of Language Models, Neuro-symbolic Systems, and Verified Discovery (2026)"
type: paper
tags: [mathematical-reasoning, survey, solver, verifier, neuro-symbolic, theorem-proving, latent-graph-discovery]
created: 2026-07-02
updated: 2026-07-02
sources: ["Artificial Intelligence for Mathematical Reasoning An Integrated Survey of Language Models, Neuro-symbolic Systems, and Verified Discovery"]
related: [wiki/queries/brain-inspired-vs-solver-approach.md, wiki/queries/sota-review-brain-inspired-abstract-reasoning.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/refinement-loops.md, wiki/entities/frontiermath-benchmark.md, wiki/entities/olymmath.md, wiki/entities/gpqa-benchmark.md, wiki/papers/verifiers-math-cobbe-2021.md]
---

# AI for Mathematical Reasoning: Integrated Survey (2026)

Citation: *Artificial Intelligence for Mathematical Reasoning: An Integrated Survey of Language Models, Neuro-symbolic Systems, and Verified Discovery* (arXiv:2606.08728v1, literature cutoff April 2026). Four co-equal axes: informal reasoning, multimodal/geometry, formal proving, mathematical discovery.

## Key computational insights (for the brain-vs-solver question)

- **Central pattern — "expressive generation + strong external constraint."** Progress is not new architectures but pairing a powerful (unreliable) generator with an *external verifier* that supplies a training/selection signal a next-token objective cannot. The constraint may be an equation grammar, Python interpreter, geometry theorem DB, PRM, or a Lean 4 kernel.
- **The supervision ladder / "representation engineering → verifier engineering."** Rungs: final answer → program → step rationale/PRM → kernel-checked proof. Each rung is costlier but more informative. The field's history is climbing this ladder; the *representation* (the structured intermediate / latent graph) is increasingly **externalized into a symbolic substrate** and *checked*, rather than hand-designed to be always-correct.
- **The solver approach demonstrably works** where a verifier + vocabulary exist: AlphaGeometry2 42/50 IMO-geo (neuro-symbolic: DDAR engine + LM proposes auxiliary constructions); AlphaProof+AlphaGeometry silver IMO-2024; Gemini Deep Think gold IMO-2025 (35/42, end-to-end NL); MiniF2F 25%→93%, PutnamBench 0→60%+ in ~1yr; FunSearch/AlphaEvolve improve best-known bounds on ~20% of 67 problems; four Erdős problems solved + Lean-verified (2025–26).
- **Where it stops (the seam):** Tao's *"discovery modulo expertise"* ceiling — models are strong at *connecting a problem to an existing technique* (traversing a known meta-graph) but weak at *genuinely novel ideas* (extending the vocabulary). FrontierMath Tier-4 (novel-insight tier) stays single-digit for solvers; co-mathematician workbench reaches only 48%. Erdős solves are "lowest hanging fruit"; Oct-2025 GPT-5 "10 Erdős solves" were retracted as literature lookups.
- **Robustness probes = spurious-edge diagnostics.** SVAMP 87%→37%; GSM-Symbolic NoOp −65%; MATH-Perturb hard −12–28% vs. <5% surface. Three competing readings of the variance: memorization, autoregressive-architecture mismatch, or "genuine-but-shallow" reasoning.
- **Verifier is the binding constraint (and can be hacked).** Verification helps only when the verifier is accurate, non-hackable, and gradient-rich — only kernel-checked proofs satisfy all three (why the formal track moved fastest). Rule-based RLVR graders miss ~38% correct answers (formatting) and are gamed (Goodhart); more accurate PRMs can be *more* hackable.
- **Convergence hypothesis:** the four axes may fuse into one pipeline (generator + verifier + search controller + domain modules) — "architectural pluralism within shared infrastructure."

## Limitations

Survey (no new experiments); many 2025–26 frontier numbers are self-reported/live-leaderboard and contamination-caveated (AIME-2024 inflated ~10–20 pts, one model ~60%). Compute costs enormous (o3-high ≈ $30k/ARC task). Cutoff April 2026.

## See also

- [[wiki/queries/brain-inspired-vs-solver-approach.md]] — the full comparison this source anchors.
- [[wiki/concepts/refinement-loops.md]] — the generate–verify–refine paradigm the survey documents at scale.
- [[wiki/concepts/latent-graph-discovery.md]] — the survey's benchmarks mapped onto the LGD taxonomy.
- [[wiki/entities/frontiermath-benchmark.md]] — the Tier-4 wall where the solver approach's ceiling appears.
- [[wiki/queries/sota-review-brain-inspired-abstract-reasoning.md]] — §4.6 positions this survey's solver stack as the "solver pivot" in the field's state-of-the-art review, complementary to the brain-inspired direction.
