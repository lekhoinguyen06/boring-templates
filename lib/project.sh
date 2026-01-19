#!/usr/bin/env bash

# Project creation functions for boring CLI

create_project() {
    local template_name="$1"
    local project_name="$2"
    
    if [[ -z "$template_name" ]]; then
        echo "Error: Template name is required"
        source "$SCRIPT_DIR/lib/usage.sh"
        show_create_usage
        exit 1
    fi
    
    if [[ -z "$project_name" ]]; then
        echo "Error: Project name is required"
        source "$SCRIPT_DIR/lib/usage.sh"
        show_create_usage
        exit 1
    fi
    
    local template_path="$SCRIPT_DIR/$template_name"
    
    if [[ ! -d "$template_path" ]]; then
        echo "Error: Template '$template_name' not found"
        echo ""
        echo "Available templates:"
        for template_dir in "$SCRIPT_DIR"/*; do
            if [[ -d "$template_dir" && ! "$(basename "$template_dir")" =~ ^\. && "$(basename "$template_dir")" != "lib" ]]; then
                echo "  $(basename "$template_dir")"
            fi
        done
        exit 1
    fi
    
    if [[ -d "$project_name" ]]; then
        echo "Error: Directory '$project_name' already exists"
        exit 1
    fi
    
    echo "Creating $template_name project: $project_name"
    
    # Copy entire template directory to new project name
    cp -r "$template_path" "$project_name"
    
    echo "✅ $template_name project '$project_name' created successfully!"
    echo "Contents copied from $template_name template."
}