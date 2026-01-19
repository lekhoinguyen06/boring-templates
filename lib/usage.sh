#!/usr/bin/env bash

# Usage and help functions for boring CLI

show_usage() {
    echo "Usage: boring <command> [options]"
    echo ""
    echo "Commands:"
    echo "  create <template> <new-app-name>  Create a new project from template"
    echo "  update                            Pull latest changes from git"
    echo "  help                              Show this help message"
    echo ""
    echo "Available templates:"
    
    # List all directories in the script directory as available templates
    for template_dir in "$SCRIPT_DIR"/*; do
        if [[ -d "$template_dir" && ! "$(basename "$template_dir")" =~ ^\. && "$(basename "$template_dir")" != "lib" ]]; then
            local template_name=$(basename "$template_dir")
            echo "  $template_name"
        fi
    done
    
    echo ""
    echo "Examples:"
    echo "  boring create cpp myApp           Create a C++ project"
    echo "  boring create vite myWebApp       Create a Vite project"
    echo "  boring update                     Update templates from git"
}

show_create_usage() {
    echo "Usage: boring create <template> <new-app-name>"
    echo ""
    echo "Available templates:"
    
    # List all directories in the script directory as available templates
    for template_dir in "$SCRIPT_DIR"/*; do
        if [[ -d "$template_dir" && ! "$(basename "$template_dir")" =~ ^\. && "$(basename "$template_dir")" != "lib" ]]; then
            local template_name=$(basename "$template_dir")
            echo "  $template_name"
        fi
    done
    
    echo ""
    echo "Examples:"
    # Generate examples based on actual available templates
    for template_dir in "$SCRIPT_DIR"/*; do
        if [[ -d "$template_dir" && ! "$(basename "$template_dir")" =~ ^\. && "$(basename "$template_dir")" != "lib" ]]; then
            local template_name=$(basename "$template_dir")
            echo "  boring create $template_name my${template_name}App"
        fi
    done
}