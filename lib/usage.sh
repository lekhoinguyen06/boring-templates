#!/usr/bin/env bash

# Usage and help functions for boring CLI

show_usage() {
    echo "Usage: boring <command> [options]"
    echo ""
    echo "Commands:"
    echo "  create <template> <new-app-name>  Create a new project from template"
    echo "  custom <subcommand> [options]     Manage custom templates"
    echo "  update                            Pull latest changes from git"
    echo "  help                              Show this help message"
    echo ""
    echo "Available templates:"
    
    # List templates from templates directory
    if [[ -d "$SCRIPT_DIR/templates" ]]; then
        for template_dir in "$SCRIPT_DIR/templates"/*; do
            if [[ -d "$template_dir" ]]; then
                local template_name=$(basename "$template_dir")
                echo "  $template_name (official)"
            fi
        done
    fi
    
    # List custom templates
    if [[ -d "$SCRIPT_DIR/customs" ]]; then
        for custom_dir in "$SCRIPT_DIR/customs"/*; do
            if [[ -d "$custom_dir" ]]; then
                local template_name=$(basename "$custom_dir")
                echo "  $template_name (custom)"
            fi
        done
    fi
    
    echo ""
    echo "Examples:"
    echo "  boring create cpp myApp           Create a C++ project"
    echo "  boring create vite myWebApp       Create a Vite project"
    echo "  boring custom add myReact .       Add current dir as custom template"
    echo "  boring custom list                List custom templates"
    echo "  boring update                     Update templates from git"
}

show_create_usage() {
    echo "Usage: boring create <template> <new-app-name>"
    echo ""
    echo "Available templates:"
    
    # List templates from templates directory
    if [[ -d "$SCRIPT_DIR/templates" ]]; then
        for template_dir in "$SCRIPT_DIR/templates"/*; do
            if [[ -d "$template_dir" ]]; then
                local template_name=$(basename "$template_dir")
                echo "  $template_name (official)"
            fi
        done
    fi
    
    # List custom templates
    if [[ -d "$SCRIPT_DIR/customs" ]]; then
        for custom_dir in "$SCRIPT_DIR/customs"/*; do
            if [[ -d "$custom_dir" ]]; then
                local template_name=$(basename "$custom_dir")
                echo "  $template_name (custom)"
            fi
        done
    fi
    
    echo ""
    echo "Examples:"
    # Generate examples based on actual available templates
    if [[ -d "$SCRIPT_DIR/templates" ]]; then
        for template_dir in "$SCRIPT_DIR/templates"/*; do
            if [[ -d "$template_dir" ]]; then
                local template_name=$(basename "$template_dir")
                echo "  boring create $template_name my${template_name}App"
            fi
        done
    fi
}