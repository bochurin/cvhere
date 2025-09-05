#!/bin/bash
# CVHere Documentation Strategy Workflow Script

echo "=== CVHere Documentation Strategy Workflow ==="

# Function to commit documentation files
commit_docs() {
    local suggested_message="$1"
    
    git reset HEAD . >/dev/null 2>&1 || true
    git add docs/ README.md
    
    if git diff --cached --quiet; then
        echo "No documentation changes to commit."
        return 1
    fi
    
    echo "Documentation files to commit:"
    git diff --cached --name-only | sed 's/^/  - /'
    echo
    
    default_message="Update project documentation"
    if [ -n "$suggested_message" ]; then
        echo "Commit message (Enter for '$suggested_message'):"
        read -r -e -i "$suggested_message" message
    else
        echo "Commit message (Enter for '$default_message'):"
        read -r message
    fi
    
    if [ -z "$message" ]; then
        if [ -n "$suggested_message" ]; then
            message="$suggested_message"
        else
            message="$default_message"
        fi
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

# Function to find files that need merging to develop
find_docs_to_merge() {
    docs_files_to_merge=""
    for file in docs/**/*.md README.md; do
        if [ -f "$file" ] && ! git diff --quiet develop:"$file" "$file" 2>/dev/null; then
            docs_files_to_merge="$docs_files_to_merge $file"
        fi
    done
    echo "$docs_files_to_merge"
}

# Function to merge documentation to develop
merge_docs_to_develop() {
    local current_branch="$1"
    local files_to_merge="$2"
    
    echo "Documentation files to merge:"
    echo "$files_to_merge" | tr ' ' '\n' | sed 's/^/  - /'
    echo
    
    read -p "Merge documentation to develop? (y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Merge cancelled."
        return 1
    fi
    
    git stash push -m "Auto-stash before docs merge" -q
    git checkout develop -q
    
    for file in $files_to_merge; do
        git checkout "$current_branch" -- "$file" >/dev/null 2>&1 || true
        git add "$file"
    done
    
    if ! git diff --cached --quiet; then
        git commit -m "Update documentation from $current_branch"
        echo "✅ Documentation merged to develop"
    fi
    
    git checkout "$current_branch" -q
    git stash pop -q 2>/dev/null || true
    return 0
}

# Main workflow
suggested_message="$1"
commit_docs "$suggested_message"

current_branch=$(git branch --show-current)
if [ "$current_branch" = "develop" ]; then
    echo "Already on develop branch. Workflow complete."
    exit 0
fi

docs_files_to_merge=$(find_docs_to_merge)
if [ -z "$docs_files_to_merge" ]; then
    echo "Documentation is already up to date in develop."
    exit 0
fi

if merge_docs_to_develop "$current_branch" "$docs_files_to_merge"; then
    echo "✅ Documentation workflow complete!"
else
    echo "Documentation remains in $current_branch branch."
fi
