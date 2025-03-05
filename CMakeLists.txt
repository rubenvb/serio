##
# Copyright © Ruben Van Boxem
#
# SPDX-License-Identifier: MIT
#
cmake_minimum_required(VERSION 3.16)

project(serio LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(serio
  include/serio.h++ src/serio.c++
  LICENSE
  .gitignore
)

target_include_directories(serio PUBLIC include)

target_compile_definitions(serio PRIVATE SERIO_LIBRARY)

enable_testing()
add_subdirectory(tests)

