#!/bin/bash
# CVHere Feature Logs Workflow Script

echo "=== CVHere Feature Logs Workflow ==="

# Function to commit feature logs
commit_feature_logs() {
    git reset HEAD . >/dev/null 2>&1 || true
    git add docs/development/feature-logs/
    
    if git diff --cached --quiet; then
        echo "No feature log changes to commit."
        return 1
    fi
    
    echo "Feature log files to commit:"
    git diff --cached --name-only | sed 's/^/  - /'
    echo
    
    default_message="Update feature logs"
    echo "Commit message (Enter for '$default_message'):"
    read -r message
    
    if [ -z "$message" ]; then
        message="$default_message"
    fi
    
    read -p "Commit these feature log files? (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        git commit -m "$message"
        echo "✅ Feature logs committed."
        return 0
    else
        echo "Commit cancelled."
        return 1
    fi
}

# Function to find feature logs that need merging to develop
find_feature_logs_to_merge() {
    feature_files_to_merge=""
    for file in docs/development/feature-logs/*.md; do
        if [ -f "$file" ] && ! git diff --quiet develop:"$file" "$file" 2>/dev/null; then
            feature_files_to_merge="$feature_files_to_merge $file"
        fi
    done
    echo "$feature_files_to_merge"
}

# Function to merge feature logs to develop
merge_to_develop() {
    local current_branch="$1"
    local files_to_merge="$2"
    
    echo "Feature log files to merge:"
    echo "$files_to_merge" | tr ' ' '\n' | sed 's/^/  - /'
    echo
    
    read -p "Merge feature logs to develop? (y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Merge cancelled."
        return 1
    fi
    
    git stash push -m "Auto-stash before merge" -q >/dev/null 2>&1 || true
    git checkout develop -q
    
    for file in $files_to_merge; do
        git checkout "$current_branch" -- "$file" >/dev/null 2>&1 || true
        git add "$file"
    done
    
    if ! git diff --cached --quiet; then
        git commit -m "Update feature logs from $current_branch"
        echo "✅ Feature logs merged to develop"
    fi
    
    git checkout "$current_branch" -q
    git stash pop -q 2>/dev/null || true
    return 0
}

# Function to find feature logs that need distribution
find_logs_to_distribute() {
    local current_branch="$1"
    
    git stash push -m "Auto-stash for distribution check" -q >/dev/null 2>&1 || true
    git checkout develop -q
    
    feature_files_to_distribute=""
    for file in docs/development/feature-logs/*.md; do
        if [ -f "$file" ]; then
            filename=$(basename "$file" .md)
            target_branch="feature/$filename"
            
            if git show-ref --verify --quiet refs/heads/$target_branch; then
                if ! git diff --quiet $target_branch:"$file" "$file" 2>/dev/null; then
                    feature_files_to_distribute="$feature_files_to_distribute $file:$target_branch"
                fi
            fi
        fi
    done
    
    git checkout "$current_branch" -q
    git stash pop -q 2>/dev/null || true
    echo "$feature_files_to_distribute"
}

# Function to distribute feature logs to branches
distribute_logs() {
    local current_branch="$1"
    local files_to_distribute="$2"
    
    echo "Feature logs to distribute:"
    for item in $files_to_distribute; do
        file=$(echo "$item" | cut -d':' -f1)
        branch=$(echo "$item" | cut -d':' -f2)
        echo "  - $file → $branch"
    done
    echo
    
    read -p "Distribute feature logs? (y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Distribution cancelled."
        return 1
    fi
    
    git stash push -m "Auto-stash for distribution" -q >/dev/null 2>&1 || true
    git checkout develop -q
    
    for item in $files_to_distribute; do
        file=$(echo "$item" | cut -d':' -f1)
        branch=$(echo "$item" | cut -d':' -f2)
        filename=$(basename "$file" .md)
        
        git checkout $branch -q
        git checkout develop -- "$file" >/dev/null 2>&1 || true
        git add "$file"
        
        if ! git diff --cached --quiet; then
            git commit -m "Update $filename from develop"
            echo "✅ $filename updated in $branch"
        fi
    done
    
    git checkout "$current_branch" -q
    git stash pop -q 2>/dev/null || true
    return 0
}

# Main workflow
commit_feature_logs

current_branch=$(git branch --show-current)
merged_to_develop=false
distributed_logs=false

# Step 1: Merge to develop
if [ "$current_branch" != "develop" ]; then
    feature_files_to_merge=$(find_feature_logs_to_merge)
    if [ -n "$feature_files_to_merge" ]; then
        if merge_to_develop "$current_branch" "$feature_files_to_merge"; then
            merged_to_develop=true
        fi
    else
        echo "Feature logs are already up to date in develop."
    fi
else
    echo "Already on develop branch. Skipping merge step."
fi

# Step 2: Distribute to feature branches
feature_files_to_distribute=$(find_logs_to_distribute "$current_branch")
if [ -n "$feature_files_to_distribute" ]; then
    if distribute_logs "$current_branch" "$feature_files_to_distribute"; then
        distributed_logs=true
    fi
else
    echo "All feature logs are up to date in their branches."
fi

# Summary
echo "✅ Feature logs workflow complete!"
if [ "$merged_to_develop" = true ]; then
    echo "    - Feature logs merged to develop"
fi
if [ "$distributed_logs" = true ]; then
    echo "    - Feature logs distributed to branches"
fi
echo "    - All work preserved in $current_branch branch"