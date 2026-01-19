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
    
    local template_path=""
    local template_type=""
    
    # Check for official template first
    if [[ -d "$SCRIPT_DIR/templates/$template_name" ]]; then
        template_path="$SCRIPT_DIR/templates/$template_name"
        template_type="official"
    # Check for custom template
    elif [[ -d "$SCRIPT_DIR/customs/$template_name" ]]; then
        template_path="$SCRIPT_DIR/customs/$template_name"
        template_type="custom"
    fi
    
    if [[ -z "$template_path" ]]; then
        echo "Error: Template '$template_name' not found"
        echo ""
        echo "Available templates:"
        
        # List official templates
        if [[ -d "$SCRIPT_DIR/templates" ]]; then
            for template_dir in "$SCRIPT_DIR/templates"/*; do
                if [[ -d "$template_dir" ]]; then
                    echo "  $(basename "$template_dir") (official)"
                fi
            done
        fi
        
        # List custom templates
        if [[ -d "$SCRIPT_DIR/customs" ]]; then
            for custom_dir in "$SCRIPT_DIR/customs"/*; do
                if [[ -d "$custom_dir" ]]; then
                    echo "  $(basename "$custom_dir") (custom)"
                fi
            done
        fi
        
        exit 1
    fi
    
    if [[ -d "$project_name" ]]; then
        echo "Error: Directory '$project_name' already exists"
        exit 1
    fi
    
    echo "Creating $template_name project: $project_name (using $template_type template)"
    
    # Copy entire template directory to new project name
    cp -r "$template_path" "$project_name"
    
    echo "✅ $template_name project '$project_name' created successfully!"
    echo "Contents copied from $template_name $template_type template."
}