---
title: "Benchmarking Benchmark Leakage in Large Language Models"
type: paper
tags: [llm, benchmarks, data-contamination, evaluation, mathematical-reasoning]
created: 2026-06-24
updated: 2026-06-24
sources: [Benchmarking Benchmark Leakage in Large Language Models]
related: [wiki/entities/arc-agi.md]
---

# Benchmarking Benchmark Leakage in Large Language Models

**Xu, Wang, Fan & Liu (SJTU/GAIR), 2024. arXiv:2404.18824.**

- Detection pipeline: synthesize three paraphrased versions of each benchmark via GPT-3.5; compute normalized N-gram accuracy and perplexity drop δ = (M_ori − M_ref) / M_ori on original vs. synthetic; key signal is δ_train-test — if the model memorizes the test split more than the train split, test leakage is flagged.
- ~50% of 31 open-source LLMs show training-set leakage on GSM8K/MATH; Qwen-7B (δ_train-test = 44%), Qwen-14B (43%), InternLM2-20B (40%), Aquila2 (~27%) are the most contaminated — benchmark scores for these models overestimate generalization.
- Instance-level detection: Qwen-1.8B exactly predicts all 5-grams in 223 GSM8K training examples and 25 test examples — confirming test-set inclusion in pretraining.
- Perplexity catches reformatted leakage (e.g., ChatGLM2 predicts "Answer: \\boxed" for a "\\n### 12" golden), while N-gram misses it; the two metrics are complementary.
- Proposes **Benchmark Transparency Card**: per-model disclosure of which benchmark splits were used in training and what augmentation was applied.

**Limitations:** cannot detect simultaneous train+test leakage (δ_train-test ≈ 0 for both-leaked or neither-leaked); augmented/reformatted training data partially evades N-gram detection; analysis limited to GSM8K and MATH.

**Related pages:** [[wiki/entities/arc-agi.md]]
