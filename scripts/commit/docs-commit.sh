#!/bin/bash
# CVHere Documentation Strategy Workflow Script

echo "=== CVHere Documentation Strategy Workflow ==="

# Function to commit documentation files
commit_docs() {
    git reset HEAD . >/dev/null 2>&1 || true
    git add docs/ README.md
    git reset HEAD docs/development/feature-logs/ >/dev/null 2>&1 || true
    
    if git diff --cached --quiet; then
        echo "No documentation changes to commit."
        return 1
    fi
    
    echo "Documentation files to commit:"
    git diff --cached --name-only | sed 's/^/  - /'
    echo
    
    default_message="Update project documentation"
    read -p "Commit message (Enter for '$default_message'): " message
    if [ -z "$message" ]; then
        message="$default_message"
    fi
    
    read -p "Commit these documentation files? (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        git commit -m "$message"
        echo "✅ Documentation committed."
        return 0
    else
        echo "Commit cancelled."
        return 1
    fi
}

# Function to find files that need merging to main
find_docs_to_merge() {
    docs_files_to_merge=""
    for file in docs/**/*.md README.md; do
        if [ -f "$file" ] && [[ ! "$file" =~ docs/development/feature-logs/ ]] && ! git diff --quiet main:"$file" "$file" 2>/dev/null; then
            docs_files_to_merge="$docs_files_to_merge $file"
        fi
    done
    echo "$docs_files_to_merge"
}

# Function to merge documentation to main
merge_docs_to_main() {
    local current_branch="$1"
    local files_to_merge="$2"
    
    echo "Documentation files to merge:"
    echo "$files_to_merge" | tr ' ' '\n' | sed 's/^/  - /'
    echo
    
    read -p "Merge documentation to main? (y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Merge cancelled."
        return 1
    fi
    
    git stash push -m "Auto-stash before docs merge" -q
    git checkout main -q
    
    for file in $files_to_merge; do
        git checkout "$current_branch" -- "$file" >/dev/null 2>&1 || true
        git add "$file"
    done
    
    if ! git diff --cached --quiet; then
        git commit -m "Update documentation from $current_branch"
        echo "✅ Documentation merged to main"
    fi
    
    git checkout "$current_branch" -q
    git stash pop -q 2>/dev/null || true
    return 0
}

# Main workflow
commit_docs

current_branch=$(git branch --show-current)
if [ "$current_branch" = "main" ]; then
    echo "Already on main branch. Workflow complete."
    exit 0
fi

docs_files_to_merge=$(find_docs_to_merge)
if [ -z "$docs_files_to_merge" ]; then
    echo "Documentation is already up to date in main."
    exit 0
fi

if merge_docs_to_main "$current_branch" "$docs_files_to_merge"; then
    echo "✅ Documentation workflow complete!"
else
    echo "Documentation remains in $current_branch branch."
fi
