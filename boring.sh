#!/usr/bin/env bash

# boring - A CLI tool for scaffolding new projects
# Usage: boring <command> [options]

set -e

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

# Source library functions
source "$SCRIPT_DIR/lib/usage.sh"
source "$SCRIPT_DIR/lib/project.sh"
source "$SCRIPT_DIR/lib/update.sh"

# Main script logic
case "${1:-}" in
    "create")
        create_project "$2" "$3"
        ;;
    "update")
        update_templates
        ;;
    "-h"|"--help"|"help"|"")
        show_usage
        ;;
    *)
        echo "Error: Unknown command '$1'"
        echo ""
        show_usage
        exit 1
        ;;
esac