# C++ Project Setup & Workflow (CMake + vcpkg)

This guide explains **how to set up the project for the first time** and **how you work with it day-to-day**.

It is written for beginners who want a *correct, scalable setup* — not quick hacks.

---

## 1. Prerequisites (one-time)

You need these installed **once per machine**:

* **C++ compiler**

  * macOS: Xcode Command Line Tools (clang)
  * Linux: GCC or Clang
  * Windows: Visual Studio 2022 (MSVC)

* **CMake** (>= 3.21)

* **Git**

* **vcpkg** (installed globally)

Verify:

* `cmake --version`
* `git --version`
* `vcpkg version`

---

## 2. Project structure

```
project-root/
├── CMakeLists.txt
├── vcpkg.json
├── include/        # public headers (.h)
├── src/            # implementation (.cpp)
├── main.cpp
├── build/          # generated (not committed)
└── README.md
```

---

## 3. First-time setup (IMPORTANT)

### Step 1: Clone the repository

```
git clone <repo-url>
cd <project>
```

---

### Step 2: Configure the project

This step:

* Detects your compiler
* Installs dependencies via vcpkg
* Generates build files

```
cmake -S . -B build \
  -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake
```

> You only re-run this when:
>
> * `vcpkg.json` changes
> * `CMakeLists.txt` changes

---

### Step 3: Build

```
cmake --build build
```

---

### Step 4: Run

```
./build/<executable-name>
```

---

## 4. Day-to-day workflow

### Editing code

* Add `.h` files in `include/`
* Add `.cpp` files in `src/`

When you add a new `.cpp`, **you must register it in CMake**.

---

### Adding a new source file

1. Create files:

```
include/logger.h
src/logger.cpp
```

2. Declare in header (`.h`)
3. Define in source (`.cpp`)
4. Add the `.cpp` file to the target in `CMakeLists.txt`
5. Build:

```
cmake --build build
```

---

## 5. Adding a dependency (vcpkg)

### Step 1: Edit `vcpkg.json`

```
{
  "dependencies": [
    "fmt"
  ]
}
```

---

### Step 2: Reconfigure

```
cmake -S . -B build \
  -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake
```

---

### Step 3: Use in CMake

```
find_package(fmt CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt)
```

---

### Step 4: Use in code

```
#include <fmt/core.h>
```

---

## 6. What to run and when

| You changed      | Command               |
| ---------------- | --------------------- |
| `.cpp` / `.h`    | `cmake --build build` |
| `CMakeLists.txt` | Reconfigure + build   |
| `vcpkg.json`     | Reconfigure + build   |

---

## 7. What NOT to do

* Do NOT run `vcpkg install` manually
* Do NOT commit the `build/` directory
* Do NOT hardcode library paths
* Do NOT include `.cpp` files
* Do NOT use `file(GLOB_RECURSE)` for large projects

---

## 8. Mental model (important)

* **CMake** describes *what to build*
* **vcpkg** provides *dependencies*
* **Compiler** does the actual compilation
* **Build directory** contains generated files

Once configured, your daily workflow is just:

```
cmake --build build
```

---

## 9. When this setup makes sense

Use this setup if you care about:

* More than one source file
* External libraries
* Cross-platform builds
* IDE support
* CI / production readiness

For single-file experiments, `clang++ main.cpp` is enough.

---

## 10. Summary

* Setup is done once
* Workflow is simple afterward
* Explicit structure avoids hidden bugs
* This scales from small projects to large systems

---

Happy hacking 🚀
