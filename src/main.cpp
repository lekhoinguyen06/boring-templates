#include <argh.h>
#include <filesystem>
#include <fmt/core.h>
#include <string>

namespace fs = std::filesystem;

int main(int argc, char* argv[]) {
  argh::parser cmdl(argc, argv);

  std::string command, plate_name, source;
  auto cwd = fs::current_path();
  auto program_path = cwd.parent_path();

  cmdl(1) >> command;
  cmdl(2) >> plate_name;
  cmdl(3) >> source;

  fs::path src = program_path / fs::relative(source);
  fs::path target = program_path / "templates/" / fs::relative(plate_name);

  fmt::println("Program: " + program_path.string());
  fmt::println("Command: " + command);
  fmt::println("Template name: " + plate_name);
  fmt::println("Source: " + src.string());
  fmt::println("Destination: " + target.string());

  if (command == "save") {
    try {
      fs::create_directories(target);
      fs::copy(src, target, fs::copy_options::recursive);
    } catch (fs::filesystem_error error) {
      fmt::println(stderr, "Error {}", error.what());
    }
  }

  if (cmdl[{"-h", "--help"}])
    fmt::print("Verbose, I am.\n");

  return EXIT_SUCCESS;
}
