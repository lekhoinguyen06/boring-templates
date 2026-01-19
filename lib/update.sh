#!/usr/bin/env bash

# Git update functions for boring CLI

update_templates() {
    echo "Updating boring templates from git..."
    
    # Check if we're in a git repository
    if [[ ! -d "$SCRIPT_DIR/.git" ]]; then
        echo "Error: Not a git repository. Cannot update templates."
        echo "Make sure you're running this from a git-managed boring templates directory."
        exit 1
    fi
    
    # Save current directory
    local current_dir=$(pwd)
    
    # Change to script directory
    cd "$SCRIPT_DIR"
    
    # Check if there are uncommitted changes
    if ! git diff-index --quiet HEAD --; then
        echo "Warning: You have uncommitted changes in the templates directory."
        echo "Stashing changes before update..."
        git stash push -m "Auto-stash before boring update $(date)"
    fi
    
    # Pull latest changes
    echo "Pulling latest changes..."
    if git pull origin main 2>/dev/null || git pull origin master 2>/dev/null; then
        echo "✅ Templates updated successfully!"
        
        # Show what changed
        echo ""
        echo "Recent changes:"
        git log --oneline -5
    else
        echo "❌ Failed to update templates from git"
        echo "Please check your internet connection and git configuration."
        exit 1
    fi
    
    # Return to original directory
    cd "$current_dir"
}