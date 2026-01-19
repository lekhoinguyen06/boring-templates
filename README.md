# Boring Templates

A templete repository and CLI tool for scaffolding new projects from templates.

### Installation

Initialize CLI:
```bash
git clone <https://github.com/lekhoinguyen06/boring-templates.git>
cd /boring-templates
chmod +x init.sh lib/*.sh
rm /usr/local/bin/boring # Run this remove existing link with the boring command
ln -s "$(pwd)/boring.sh" /usr/local/bin/boring
```

## Usage

```bash
# Create a new project from a template
./boring create <template> <project-name>

# Update templates from git
./boring update

# Show help
./boring help
```

## Available Commands

- `create` - Create a new project from a template
- `update` - Pull latest template changes from git repository
- `help` - Show usage information

## Project Structure

```
boring-templates/
├── boring              # Main CLI script (macOS/Linux)
├── boring.ps1          # PowerShell version (Windows)
├── boring.bat          # Batch wrapper (Windows)
├── lib/                # Modular library functions (Unix only)
│   ├── usage.sh        # Help and usage functions
│   ├── project.sh      # Project creation logic
│   └── update.sh       # Git update functionality
├── cpp/                # C++ project template
├── vite/               # Vite project template
└── README.md
```

