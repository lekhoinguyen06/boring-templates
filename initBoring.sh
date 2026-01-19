#!/usr/bin/env bash

# boring - A CLI tool for scaffolding new projects
# Usage: boring <template> <new-app-name>

set -e

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

show_usage() {
    echo "Usage: boring <template> <new-app-name>"
    echo ""
    echo "Available templates:"
    
    # List all directories in the script directory as available templates
    for template_dir in "$SCRIPT_DIR"/*; do
        if [[ -d "$template_dir" && ! "$(basename "$template_dir")" =~ ^\. ]]; then
            local template_name=$(basename "$template_dir")
            echo "  $template_name"
        fi
    done
    
    echo ""
    echo "Examples:"
    # Generate examples based on actual available templates
    for template_dir in "$SCRIPT_DIR"/*; do
        if [[ -d "$template_dir" && ! "$(basename "$template_dir")" =~ ^\. ]]; then
            local template_name=$(basename "$template_dir")
            # Skip the created projects (they shouldn't be templates)
            if [[ "$template_name" != "myApp" && "$template_name" != "testApp" ]]; then
                echo "  boring $template_name my${template_name}App"
            fi
        fi
    done
}

create_project() {
    local template_name="$1"
    local project_name="$2"
    
    if [[ -z "$template_name" ]]; then
        echo "Error: Template name is required"
        show_usage
        exit 1
    fi
    
    if [[ -z "$project_name" ]]; then
        echo "Error: Project name is required"
        show_usage
        exit 1
    fi
    
    local template_path="$SCRIPT_DIR/$template_name"
    
    if [[ ! -d "$template_path" ]]; then
        echo "Error: Template '$template_name' not found"
        echo ""
        echo "Available templates:"
        for template_dir in "$SCRIPT_DIR"/*; do
            if [[ -d "$template_dir" && ! "$(basename "$template_dir")" =~ ^\. ]]; then
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

# Main script logic
case "${1:-}" in
    "-h"|"--help"|"help")
        show_usage
        ;;
    "")
        echo "Error: No template specified"
        show_usage
        exit 1
        ;;
    *)
        create_project "$1" "$2"
        ;;
esac