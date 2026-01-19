# Boring Templates

A collection of project templates for quick scaffolding.

## Usage

The `boring` CLI tool helps you quickly create new projects from templates.

### Installation

Init cli:
```bash
cd /boring-templates
chmod +x initBoring.sh
rm /usr/local/bin/boring # Run this remove existing link with the boring command
ln -s "$(pwd)/initBoring.sh" /usr/local/bin/boring
```

Usage:
```bash
boring <template> <app-name>
```

### Commands

#### Create a C++ Project

```bash
./initBoring.sh cpp <project-name>
```

This will create a new directory with the specified name containing a complete C++ project template with:
- CMake configuration
- vcpkg dependency management
- Development scripts
- Project structure with `include/` and `src/` directories
- Example main.cpp with fmt library

**Examples:**
```bash
./initBoring.sh cpp myApp
./initBoring.sh cpp game-engine
./initBoring.sh cpp calculator
```

### Available Templates

- **cpp**: Modern C++ project with CMake and vcpkg

### Getting Help

```bash
./initBoring.sh --help
```

## Template Structure

### C++ Template (`cpp/`)

The C++ template includes:
- Modern CMake setup (3.21+)
- vcpkg for dependency management
- clang-format configuration
- Development and watch scripts
- Proper project structure
- Example with fmt library

After creating a project, follow the setup instructions in the generated README.md.
