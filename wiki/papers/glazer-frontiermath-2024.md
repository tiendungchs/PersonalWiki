---
title: "FrontierMath: A Benchmark for Evaluating Advanced Mathematical Reasoning in AI"
type: paper
tags: [benchmark, mathematical-reasoning, abstract-reasoning, latent-graph-discovery]
created: 2026-06-24
updated: 2026-07-02
sources: [FrontierMath A Benchmark for Evaluating Advanced Mathematical Reasoning in AI]
related: [wiki/entities/frontiermath-benchmark.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/abstract-reasoning.md, wiki/entities/arc-agi.md]
---

# FrontierMath: A Benchmark for Evaluating Advanced Mathematical Reasoning in AI

**Glazer, Erdil, Besiroglu, Chicharro, Chen, Gunning et al. — Epoch AI, 2024 — arXiv:2411.04872**

---

1. Research-level math requires navigating hidden relational structure (theorem graphs, proof technique chains) with near-zero training coverage — Tao estimates "a dozen relevant papers" per problem area; the applicable latent vocabulary is genuinely sparse at test time, not just unextracted.
2. All SOTA models score <2% single-run (o1-preview, GPT-4o, Claude 3.5 Sonnet, Gemini 1.5 Pro, Grok 2); o1-preview reaches ~6% at pass@8, matching the low end of the verified ARC-AGI-2 frontier (tiny zero-pretrain nets ~4–8%; closed-model self-reports reach ≤85% but are unverified) from a completely different domain.
3. Hardness decomposes into three weakly-correlated axes: Background depth (1–5: high-school → research level) × Creativity (hours to identify key insight) × Execution (hours to compute answer once insight is found) — a problem can be research-level background but low creativity, or undergraduate background but high creativity.
4. Guessproofness criterion (<1% blind-guess probability via large, non-obvious numerical answers) operationalizes that surface-form pattern matching cannot shortcut solution — the problem statement gives no direct cue to the required proof-graph path.
5. Automated verification via SymPy-computable answers and required solution scripts decouples evaluation from human grading, but constrains the benchmark to numerically-expressible results — proof construction (the bulk of mathematical research) is excluded.

**Limitations:** No proof-writing supported; ~10% estimated critical error rate (reviewer difficulty ratings inconsistently calibrated); <2% ceiling provides insufficient variance to rank current models — suited for detecting capability jumps, not fine-grained comparison.

---

**See:** [[wiki/entities/frontiermath-benchmark.md]] for domain distribution, full results, and the latent graph discovery framing.

**Relates to:** [[wiki/concepts/latent-graph-discovery.md]] — FrontierMath instantiates latent edge + path discovery where the meta-graph vocabulary (applicable theorems) has near-zero training coverage. [[wiki/concepts/abstract-reasoning.md]] — confirms the model-building gap extends from visual grid tasks to formal mathematical domains, with identical capability ceiling. [[wiki/entities/arc-agi.md]] — parallel benchmark at the opposite prior-knowledge extreme; both stay far below human under reproducible evaluation (FrontierMath <2%; verified ARC-AGI-2 24–54%).
