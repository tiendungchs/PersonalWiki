#!/usr/bin/env bash
# Rebuild or update the qmd search index from all wiki pages.
# Usage:
#   ./tools/qmd-index.sh           — add/update all wiki pages
#   ./tools/qmd-index.sh search "query"  — search the index

QMD=/home/compromises/miniconda3/envs/TEM/bin/qmd
WIKI_DIR="$(cd "$(dirname "$0")/.." && pwd)/wiki"
COLLECTION="brain-wiki"
DB_PATH="$(cd "$(dirname "$0")/.." && pwd)/tools/qmd.db"

if [[ "$1" == "search" ]]; then
    shift
    $QMD --db-path "$DB_PATH" search --collection "$COLLECTION" --query "$*" --top-k 10 --rerank
    exit 0
fi

echo "Indexing wiki pages into qmd collection '$COLLECTION'..."
find "$WIKI_DIR" -name "*.md" | while read -r f; do
    slug=$(echo "$f" | sed "s|$WIKI_DIR/||")
    $QMD --db-path "$DB_PATH" document add \
        --collection "$COLLECTION" \
        --document-id "$slug" \
        --markdown-file "$f" 2>/dev/null || true
done
echo "Done. Run: ./tools/qmd-index.sh search \"your query\""
