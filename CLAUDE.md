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
├── CLAUDE.md               ← this file: schema and operating rules
├── index.md                ← lightweight routing file (links to wiki indexes)
├── log.md                  ← append-only chronological log
├── raw/                    ← immutable source documents (never modify)
│   └── assets/             ← locally downloaded images
├── tools/
│   └── qmd-index.sh        ← hybrid BM25+vector search script
└── wiki/                   ← all LLM-generated content
    ├── overview.md         ← high-level synthesis of the research area
    ├── open-problems.md    ← current architectural gaps and priority tasks
    ├── glossary.md         ← abbreviation expansions
    ├── index-papers.md     ← papers list
    ├── index-concepts.md   ← concepts list
    ├── index-entities.md   ← models, benchmarks, biological systems list
    ├── entities/           ← models, benchmarks, biological systems
    ├── concepts/           ← core ideas, techniques, mechanisms
    ├── papers/             ← per-paper summary pages
    └── queries/            ← filed answers to significant queries
```

**Rules:**
- Never modify files under `raw/`. They are the source of truth.
- All wiki content lives under `wiki/` or at the root (index.md, log.md, overview).
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
- Structure: Citation line → 5 key computational insights as bullet points → Limitations (2–3 lines) → links to relevant concept/entity pages
- Target length: ~200 words. No TL;DR, no detailed results section, no extensive background.
- Full detail lives in the concept/entity pages the paper informs.

**Query pages** (`wiki/queries/`): filed answers to significant questions.
Structure: Question → Answer (full, with citations to wiki pages) → Implications → Follow-up questions.

**Overview** (`wiki/overview.md`): the master synthesis. Updated after every 5 ingests or when a major insight changes the picture. Sections: Current best understanding → Key open problems → Promising directions → Major controversies.

---

## Operations

### INGEST

Triggered when the user drops a new source in `raw/` and says "ingest [filename]" or similar.

**Steps (in order):**
1. Read the source file fully. If it references images, note them but continue.
2. **Discuss first** — briefly surface key takeaways relevant to the main goal and confirm the user wants to proceed with those emphases.
3. Run qmd search on the paper title and key terms to find related pages.
4. Read `wiki/index-concepts.md` + `wiki/index-entities.md` in parallel to verify what exists.
5. Create a paper/source page under `wiki/papers/[slug].md`.
6. Identify all entities and concepts touched. Create or update their pages under `wiki/entities/` and `wiki/concepts/`.
7. Update cross-references: add links from new pages to existing ones and vice versa.
8. If this source contradicts an existing claim in the wiki, flag it explicitly in both pages with a `> **Contradiction [YYYY-MM-DD]:**` blockquote.
9. If this source significantly changes the synthesis, update `wiki/overview.md`.
10. Update `wiki/index-papers.md`; update `wiki/index-concepts.md` and/or `wiki/index-entities.md` if new pages were created.
11. Append one-liner to `log.md`: `## YYYY-MM-DD | ingest | [Title] | created: ...; updated: ...`
12. Update `wiki/open-problems.md` if new gaps or tensions surfaced.

**Scope:** a single ingest typically touches 3–8 wiki pages. Prefer updating existing pages over creating new ones. Only create a new page for a concept or model that has no existing home.

### QUERY

Triggered when the user asks a question.

**Steps:**
1. Run qmd search on the question terms to find the most relevant pages.
2. Read `wiki/index-concepts.md` + `wiki/index-entities.md` to ensure complete coverage.
3. Read all relevant wiki pages.
4. Synthesize an answer with explicit citations: `[[wiki/concepts/foo.md]]`.
5. **Decide:** is this answer significant enough to file? File it if: it synthesizes multiple sources, reveals a non-obvious connection, or the user is likely to return to this question. If filing, create `wiki/queries/[slug].md` and add it to `index.md`.
6. Update cross-references if the synthesis reveals new connections between existing pages.
7. Append one-liner to `log.md`: `## YYYY-MM-DD | query | [Question summary] | filed: [slug or no]`

### LINT

Triggered when the user says "lint the wiki" or periodically suggested after every 20 ingests.

**Check for:**
- Pages with no inbound links (orphans)
- Claims that are contradicted by newer sources but not flagged
- Concepts mentioned across multiple pages but lacking their own page
- Missing cross-references between obviously related pages
- Stale `updated` dates on pages that should have been touched by recent ingests
- Gaps: important sub-topics with no coverage
- **Abbreviations:** scan all wiki pages for uppercase sequences of 2–5 letters (e.g. HTM, SDR, PFC). For each: (a) check it appears with its full expansion on first use in that page as "Full Term (ABBR)"; (b) check it is listed in `wiki/glossary.md`. Report missing expansions per page and any abbreviations absent from the glossary.

**Output:** a markdown report filed as `wiki/queries/lint-YYYY-MM-DD.md` listing findings and suggested follow-up sources and update wiki/open-problems.md.

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

Fall back to `grep -r "terms" wiki/` if the index is stale or qmd errors.

---

## Cross-referencing Conventions

- Internal links: `[[wiki/concepts/working-memory.md]]` — always use full path from repo root.
- When a concept page is updated, scan for all pages in `related:` frontmatter and check if they need updating too.
- The `related:` frontmatter list is the authoritative cross-reference graph. Keep it current.
- Every paper page must link to at least one concept page and one entity page.

---

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

**Entities (expected key players):**
- Researchers: Jeff Hawkins, Karl Friston, Yoshua Bengio, Demis Hassabis, Blake Richards, Timothy Lillicrap, Randall O'Reilly
- Models/Frameworks: HTM (Hierarchical Temporal Memory), Transformer, Neural ODE, CogNet, ART (Adaptive Resonance Theory), GWT (Global Workspace Theory)
- Benchmarks: ARC (Abstraction and Reasoning Corpus), RAVEN, CLEVR, Bongard Problems, ARC-AGI

---

## Conventions

- Dates: always ISO 8601 — `YYYY-MM-DD`.
- Uncertainty: prefix claims with `(tentative)` when based on a single source or the user has flagged doubt.
- **Unsourced content:** general domain knowledge, cross-paper synthesis, and architectural speculation are allowed without a source slug. Leave `sources:` frontmatter empty for synthesis pages. Prefix speculative or brainstorming claims with `(brainstorm)` when they are hypotheses rather than established facts. Do not mark widely accepted domain knowledge.
- Contradictions: always use `> **Contradiction [YYYY-MM-DD]:** ...` blockquotes so they are visually scannable.
- Quote policy: keep direct quotes minimal and always cite the source slug.
- Page length: concept and entity pages ~250 words; paper pages ~200 words. Split into sub-pages only if content is genuinely distinct, not to preserve redundancy.
- Minimize prose: prefer tables, bullet points, equations. Every sentence must carry information relevant to building a reasoning model.
- Researcher pages: **do not create**. Attribution belongs in paper citations only.
- When ingesting, ask: does this content help build a reasoning model? If not, omit it.
- Deleting irrelevant content is acceptable and preferred over strikethrough accumulation. Strikethrough only for contradicted factual claims that should remain visible as a record.

---

## Session Start Checklist

At the start of every new session:
1. Read `wiki/open-problems.md` — current architectural gaps, empirical tensions, and priority tasks.
2. Confirm with the user what they want to do today.

---

## Index and Log Format

**index.md** — lightweight routing file only: links to `wiki/open-problems.md`, `wiki/index-papers.md`, `wiki/index-concepts.md`, `wiki/index-entities.md`, and the queries list. Keep it under 30 lines.

**wiki/index-papers.md** — papers list only. Each entry: `- [Title](path) — one-line description`. Updated after each ingest.

**wiki/index-concepts.md** — concepts list only. Same format. Updated when a new concept page is created.

**wiki/index-entities.md** — models, benchmarks, and biological systems. Same format. Updated when a new entity page is created.

**log.md** — append-only, one line per operation:
`## YYYY-MM-DD | operation | title | created: x,y; updated: a,b,c`
No prose. The concept and entity pages hold the insights.
