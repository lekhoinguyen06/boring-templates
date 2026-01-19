#!/usr/bin/env bash

# Custom template management functions for boring CLI

CUSTOMS_DIR="$SCRIPT_DIR/customs"

ensure_customs_dir() {
    if [[ ! -d "$CUSTOMS_DIR" ]]; then
        mkdir -p "$CUSTOMS_DIR"
        echo "Created customs directory: $CUSTOMS_DIR"
    fi
}

add_custom_template() {
    local template_name="$1"
    local source_path="$2"
    
    if [[ -z "$template_name" ]]; then
        echo "Error: Template name is required"
        echo "Usage: boring custom add <template-name> <path>"
        exit 1
    fi
    
    if [[ -z "$source_path" ]]; then
        echo "Error: Source path is required"
        echo "Usage: boring custom add <template-name> <path>"
        exit 1
    fi
    
    # Resolve source path
    if [[ "$source_path" == "." ]]; then
        source_path="$(pwd)"
    elif [[ ! "$source_path" =~ ^/ ]]; then
        source_path="$(pwd)/$source_path"
    fi
    
    if [[ ! -d "$source_path" ]]; then
        echo "Error: Source path '$source_path' does not exist or is not a directory"
        exit 1
    fi
    
    ensure_customs_dir
    
    local custom_template_path="$CUSTOMS_DIR/$template_name"
    
    if [[ -d "$custom_template_path" ]]; then
        echo "Error: Custom template '$template_name' already exists"
        echo "Use 'boring custom delete $template_name' to remove it first"
        exit 1
    fi
    
    echo "Adding custom template '$template_name' from '$source_path'..."
    
    # Copy all files from source path to custom template directory
    cp -r "$source_path" "$custom_template_path"
    
    echo "✅ Custom template '$template_name' added successfully!"
    echo "You can now use: boring create $template_name <project-name>"
}

list_custom_templates() {
    ensure_customs_dir
    
    echo "Custom templates:"
    
    if [[ ! -d "$CUSTOMS_DIR" ]] || [[ -z "$(ls -A "$CUSTOMS_DIR" 2>/dev/null)" ]]; then
        echo "  (none)"
        return
    fi
    
    for custom_dir in "$CUSTOMS_DIR"/*; do
        if [[ -d "$custom_dir" ]]; then
            local template_name=$(basename "$custom_dir")
            echo "  $template_name"
        fi
    done
}

delete_custom_template() {
    local template_name="$1"
    
    if [[ -z "$template_name" ]]; then
        echo "Error: Template name is required"
        echo "Usage: boring custom delete <template-name>"
        exit 1
    fi
    
    local custom_template_path="$CUSTOMS_DIR/$template_name"
    
    if [[ ! -d "$custom_template_path" ]]; then
        echo "Error: Custom template '$template_name' not found"
        echo ""
        echo "Available custom templates:"
        list_custom_templates
        exit 1
    fi
    
    echo "Deleting custom template '$template_name'..."
    rm -rf "$custom_template_path"
    
    echo "✅ Custom template '$template_name' deleted successfully!"
}

show_custom_usage() {
    echo "Usage: boring custom <command> [options]"
    echo ""
    echo "Commands:"
    echo "  add <template-name> <path>    Add a custom template from a directory"
    echo "  list                          List all custom templates"
    echo "  delete <template-name>        Delete a custom template"
    echo ""
    echo "Examples:"
    echo "  boring custom add myReact .                    Add current directory as 'myReact' template"
    echo "  boring custom add myNode /path/to/node-app     Add directory as 'myNode' template"
    echo "  boring custom list                             List all custom templates"
    echo "  boring custom delete myReact                   Delete 'myReact' custom template"
}

handle_custom_command() {
    local subcommand="$1"
    local template_name="$2"
    local source_path="$3"
    
    case "$subcommand" in
        "add")
            add_custom_template "$template_name" "$source_path"
            ;;
        "list")
            list_custom_templates
            ;;
        "delete")
            delete_custom_template "$template_name"
            ;;
        "")
            echo "Error: Custom subcommand is required"
            echo ""
            show_custom_usage
            exit 1
            ;;
        *)
            echo "Error: Unknown custom subcommand '$subcommand'"
            echo ""
            show_custom_usage
            exit 1
            ;;
    esac
}