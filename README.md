# Boring Templates

A modular CLI tool for scaffolding new projects from templates with custom template support.

## Installation

Initialize CLI:
```bash
git clone <https://github.com/lekhoinguyen06/boring-templates.git>
cd boring-templates
chmod +x boring.sh lib/*.sh
rm /usr/local/bin/boring # Run this to remove existing link with the boring command
ln -s "$(pwd)/boring.sh" /usr/local/bin/boring
```

## Usage

```bash
# Create a new project from a template
./boring.sh create <template> <project-name>

# Manage custom templates
./boring.sh custom add <template-name> <path>
./boring.sh custom list
./boring.sh custom delete <template-name>

# Update templates from git
./boring.sh update

# Show help
./boring.sh help
```

## Available Commands

- `create` - Create a new project from a template (official or custom)
- `custom` - Manage custom templates (add, list, delete)
- `update` - Pull latest template changes from git repository
- `help` - Show usage information

## Custom Templates

You can add your own custom templates to the boring CLI:

```bash
# Add current directory as a custom template
./boring.sh custom add myReact .

# Add a specific directory as a custom template
./boring.sh custom add myNode /path/to/project

# List all custom templates
./boring.sh custom list

# Delete a custom template
./boring.sh custom delete myReact
```

Custom templates are stored in the `customs/` directory and can be used just like official templates.

## Project Structure

```
boring-templates/
├── boring.sh           # Main CLI script
├── lib/                # Modular library functions
│   ├── usage.sh        # Help and usage functions
│   ├── project.sh      # Project creation logic
│   ├── update.sh       # Git update functionality
│   └── custom.sh       # Custom template management
├── templates/          # Official project templates
│   ├── cpp/            # C++ project template
│   └── vite/           # Vite project template
├── customs/            # Custom user templates (created automatically)
└── README.md
```


## Examples

```bash
# Create a C++ project from official template
./boring.sh create cpp myAwesomeApp

# Create a Vite project from official template
./boring.sh create vite myWebApp

# Add current directory as a custom React template
./boring.sh custom add myReact .

# Create a project from your custom template
./boring.sh create myReact myNewReactApp

# List all available templates (official and custom)
./boring.sh help

# Update all official templates from git
./boring.sh update
```