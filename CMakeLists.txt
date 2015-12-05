
cmake_minimum_required(VERSION 2.6)

# Project declaration
project(test)

set(EXECUTABLE_OUTPUT_PATH lib/${CMAKE_BUILD_TYPE})

# Adding project include directory
include_directories(include)

# Generate list of source file
file(
  GLOB_RECURSE
  source_files
  src/*
  )

file(
  GLOB_RECURSE
  header_files
  include/*
  )

# Executable declaration
add_executable(
  test
  ${source_files}
  ${header_files}
  )

