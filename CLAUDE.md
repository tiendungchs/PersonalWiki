# Wiki Schema — Brain-Inspired Models for Abstract Reasoning

This file is the operating contract for this wiki. Every interaction follows these rules. Read this file at the start of every session before doing anything else.

---

## Mission

This wiki is a persistent, compounding knowledge base for research on **brain-inspired machine learning models capable of abstract reasoning**. The human curates sources and asks questions. The LLM writes and maintains all wiki content — summaries, entity pages, concept pages, cross-references, and filed query answers. Nothing is re-derived from scratch; everything builds on what is already in the wiki.

**Primary purpose: brainstorming.** The wiki is a thinking tool first. Synthesis, architectural speculation, cross-paper connections, and general domain knowledge are first-class content — sources are useful but not required. Every page should move thinking forward, not merely report what sources say.

---

## Directory Layout

```
PersonalWiki/
├── CLAUDE.md                   ← this file: schema and operating rules
├── index.md                    ← lightweight routing file (links to wiki indexes)
├── log.md                      ← append-only chronological log
├── raw/                        ← immutable source documents (never modify)
│   └── assets/                 ← locally downloaded images
├── tools/
│   └── qmd-index.sh            ← hybrid BM25+vector search script
└── wiki/                       ← all LLM-generated content
    ├── overview.md             ← high-level synthesis of the research area
    ├── priority-tasks.md       ← current priority tasks identified from lint passes
    ├── architectural-gaps.md   ← current architectural gaps, updated each digest
    ├── empirical-tensions.md   ← current empirical tensions, updated each digest
    ├── glossary.md             ← abbreviation expansions
    ├── index-papers.md         ← papers list
    ├── index-concepts.md       ← concepts list
    ├── index-entities.md       ← models, benchmarks, biological systems list
    ├── entities/               ← models, benchmarks, biological systems
    ├── concepts/               ← core ideas, techniques, mechanisms
    ├── papers/                 ← per-paper summary pages
    └── queries/                ← filed answers to significant queries
```

**Rules:**
- Never modify files under `raw/`. They are the source of truth.
- All wiki content lives under `wiki/` or at the root (index.md, log.md).
- File names: lowercase, hyphens for spaces, `.md` extension. Example: `wiki/concepts/working-memory.md`.
- Every wiki page must have YAML frontmatter (see Page Format below).

---

## Page Format

Every wiki page begins with YAML frontmatter:

```yaml
---
title: "Human-readable title"
type: concept | entity | paper | query | overview
tags: [tag1, tag2]          # domain tags, free-form
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: [slug1, slug2]     # raw source slugs this page draws from
related: [wiki/path/page1.md, wiki/path/page2.md]
---
```

**Entity pages** (`wiki/entities/`): one page per **model, framework, or biological system**. No researcher pages.
- Models: architecture table → key results → limitations → comparison table to related models → **Connections**
- Biological systems: anatomy/function → computational role → how it maps to model components → **Connections**
- Target length: ~300 words. Use tables and bullet points over prose.

**Concept pages** (`wiki/concepts/`): one page per core mechanism or idea.
- Structure: one-line bold definition → key equations/formalisms → evidence/instantiations table → open problems → **Connections**
- Target length: ~300 words. Equations preferred over prose where possible.
- Every concept page must show how the concept applies to building a reasoning model.

**Connections section** (required on all concept and entity pages):
- Appears at the end of every concept and entity page.
- Each entry: `**[[wiki/path/page.md]]** — one sentence explaining *how* these pages relate` (the mechanism of the relationship, not just that they are related).
- Links should be bidirectional: if A connects to B, B must connect to A.
- Updated whenever a new ingest creates a new relationship.

**Paper pages** (`wiki/papers/`): **source stubs only** — not full summaries.
- Structure: Citation line → key computational insights as bullet points → Limitations (2–3 lines) → links to relevant concept/entity pages
- Target length: ~200 words. No TL;DR, no detailed results section, no extensive background.
- Full detail lives in the concept/entity pages the paper informs.

**Query pages** (`wiki/queries/`): filed answers to significant questions.
Structure: Question → Answer (full, with citations to wiki pages) → Implications → Follow-up questions.

**Overview** (`wiki/overview.md`): the master synthesis. Updated after every 10 ingests or when a major insight changes the picture. Sections: The Central Thesis → Master Problem Framing: Latent Graph Discovery → Current best understanding → Key open problems → Promising directions → Major controversies.

**index.md** — lightweight routing file only: links to `wiki/architectural-gaps.md`, `priority-tasks.md`, `empirical-tensions.md`, `wiki/index-papers.md`, `wiki/index-concepts.md`, `wiki/index-entities.md`, and the queries list. Keep it under 30 lines.

**wiki/index-papers.md** — papers list only. Each entry: `- [Title](path) — one-line description`. Updated after each ingest.

**wiki/index-concepts.md** — concepts list only. Same format. Updated when a new concept page is created.

**wiki/index-entities.md** — models, benchmarks, and biological systems. Same format. Updated when a new entity page is created.

**log.md** — append-only, one line per operation:
`## YYYY-MM-DD | operation | title | created: x,y; updated: a,b,c`
No prose. The concept and entity pages hold the insights.

---

## Operations

### INGEST

Triggered when the user drops a new source in `raw/` and says "ingest [filename]" or similar.

**Steps (in order):**
1. Read the source file fully.
2. Read `wiki/index-concepts.md` + `wiki/index-entities.md` to verify what exists.
3. Extract key takeaways relevant to the main goal (ask: does this content help build a reasoning model?, if not, skip it), identify all entities and concepts that might be touched/created and confirm the user wants to proceed with the plan.
4. Run qmd search on the paper title and key terms to find additional related pages.
5. Read all related pages in parallel to have the full context.
6. Create a paper page under `wiki/papers/[slug].md`.
7. Update `wiki/index-papers.md`; update `wiki/index-concepts.md` and/or `wiki/index-entities.md` if new pages were created. Update `updated`.
8. Update cross-references: add links from new pages to existing ones and vice versa.
9. If this source contradicts an existing claim in the wiki, add a row to `wiki/empirical-tensions.md`. On the affected concept/entity pages, update the prose to reflect both positions (or the settled framing if one exists).
10. Append at the end one-liner to `log.md`: `## YYYY-MM-DD | ingest | [Title] | created: ...; updated: ...`

**Scope:** a single ingest typically touches 3–8 wiki pages. Prefer updating existing pages over creating new ones. Only create a new page for a concept or model that has no existing home.

### QUERY

Triggered when the user asks a question.

**Steps:**
1. Run qmd search on the question terms to find the most relevant pages.
2. Read `wiki/index-concepts.md` + `wiki/index-entities.md` to ensure complete coverage.
3. Read all relevant wiki pages.
4. Synthesize an answer.
5. **Decide:** is this answer significant enough to file? File it if: it synthesizes multiple sources, reveals a non-obvious connection, or the user is likely to return to this question. If filing, create `wiki/queries/[slug].md`.
6. Update cross-references if the synthesis reveals new connections between existing pages.
7. Append one-liner to `log.md`: `## YYYY-MM-DD | query | [Question summary] | filed: [slug or no]`

### LINT

Triggered when the user says "lint the wiki" or periodically suggested after every 20 ingests.

**Steps:**
1. Read `wiki/index-concepts.md`, `wiki/index-entities.md` and `wiki/index-papers.md` to ensure complete coverage.
2. Read all concept, entity pages.
3. Read `wiki/architectural-gaps.md`, `wiki/priority-tasks.md` and `wiki/empirical-tensions.md` for current open problems.
4. Check for:
   - Pages with no inbound links (orphans)
   - Important concepts or entities that are not sufficiently covered
   - Concepts mentioned across multiple pages but lacking their own page
   - Overloaded concept/entitiy pages that is worth splitting
   - Missing cross-references between obviously related pages
   - Uncommon abbreviations that are not expanded or in `wiki/glossary.md`.
5. Propose a plan to fix problems found: prioritize problems that can be solved immediately; propose sources to fill identified gaps. Confirm the user wants to proceed
6. Update `wiki/index-papers.md`; update `wiki/index-concepts.md` and/or `wiki/index-entities.md` if new pages were created. Update `updated`.
7. Update `wiki/architectural-gaps.md`, `wiki/priority-tasks.md` and `wiki/empirical-tensions.md`: remove resolved problems, add new unresolved problems.
8. Update cross-references of pages touched.
9. Append one-liner to `log.md`: `## YYYY-MM-DD | lint | [lint summary] | created: ...; updated: ...`.

### WEB SEARCH

Use WebSearch/WebFetch when:
- The user asks for it explicitly
- A lint pass reveals a factual gap that a quick search could fill
- A lint pass identifies important sub-topics that need follow-up sources
- A paper references a model or dataset with no wiki page and details are sparse

After fetching, treat the result as an ephemeral source: extract relevant facts into existing wiki pages rather than creating a `raw/` file (which is for curated sources only).

---

## Search (qmd)

qmd is **installed and operational** at `/home/compromises/miniconda3/envs/TEM/bin/qmd`. The search index lives at `tools/qmd.db`, collection name `brain-wiki`.

**When updating `wiki/overview.md`** (every 5 ingests or on major insight), re-index all wiki pages:
```bash
cd /home/compromises/PersonalWiki && ./tools/qmd-index.sh
```

**To search at the start of any INGEST or QUERY:**
```bash
cd /home/compromises/PersonalWiki && ./tools/qmd-index.sh search "query terms"
```

The search script is at `tools/qmd-index.sh`. It uses hybrid BM25+vector search with reranking (Qwen3-Embedding-0.6B model, on-device).

Fall back to `grep -r "terms" wiki/` if qmd errors.

## Domain Taxonomy

This wiki covers the intersection of neuroscience-inspired AI and abstract reasoning. Key top-level categories:

**Concepts:**
- `latent-graph-discovery` — **CORE PROBLEM FRAMING** — the unified problem: infer hidden graph structure from observations and navigate it; subsumes all task types
- `abstract-reasoning` — the target capability: analogical reasoning, systematic generalization, rule learning, compositional generalization
- `working-memory` — short-term state maintenance mechanisms (biological and artificial)
- `attention` — selective routing of information (transformers, cortical columns, etc.)
- `hierarchical-representations` — multi-level feature abstraction
- `predictive-coding` — error-minimization frameworks (Friston, Rao & Ballard)
- `neuromodulation` — dopamine, acetylcholine signals mapped to learning rate / gating
- `sparse-distributed-representations` — SDR theory, HTM
- `binding-problem` — how features get associated into coherent objects
- `compositional-generalization` — combining known primitives in novel ways
- `meta-learning` — learning to learn; few-shot generalization

---

## Conventions

- Dates: always ISO 8601 — `YYYY-MM-DD`.
- - Internal links: `[[wiki/concepts/working-memory.md]]` — always use full path from repo root.
- When a concept page is updated, scan for all pages in `related:` frontmatter and check if they need updating too.
- The `related:` frontmatter list is the authoritative cross-reference graph. Keep it current.
- Full expansion of all abbreviations (e.g. FT (Full-Term)), except terms that are really common (e.g AI, NN, ML, DNA, etc) or too long (AMPA (α-amino-3-hydroxy-5-methyl-4-isoxazolepropionic acid receptor)), in that case, they will be stored in `wiki/glossary.md`.
- Uncertainty: prefix claims with `(tentative)` when based on non-scientific source or the user has flagged doubt.
- **Unsourced content:** general domain knowledge, cross-paper synthesis, and architectural speculation are allowed without a source slug. Leave `sources:` frontmatter empty for synthesis pages. Prefix speculative or brainstorming claims with `(brainstorm)` when they are hypotheses rather than established facts. Do not mark widely accepted domain knowledge.
- Quote policy: keep direct quotes minimal and always cite the source slug.
- Minimize prose: prefer tables, bullet points, equations. Every sentence must carry information relevant to building a reasoning model.