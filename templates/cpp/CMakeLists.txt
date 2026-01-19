cmake_minimum_required(VERSION 3.21)

project(index
    VERSION 0.1.0
    LANGUAGES CXX
)

add_executable(${PROJECT_NAME}
    main.cpp
)

target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_17)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# Dependencies (vcpkg)
find_package(fmt CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt)
