cmake_minimum_required(VERSION 3.0.0)
project(julia_ditomas_10_test VERSION 1.0.0 LANGUAGES C ASM)
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_C_COMPILER /home/project/phase5-JuliaDiTomas/work/ia/sdk/bin/phase5-JuliaDiTomas-ia-clang)
set(CMAKE_ASM_COMPILER /home/project/phase5-JuliaDiTomas/work/ia/sdk/bin/phase5-JuliaDiTomas-ia-clang)
set(CMAKE_CPP_COMPILER /home/project/phase5-JuliaDiTomas/work/ia/sdk/bin/phase5-JuliaDiTomas-ia-clang++)
set(CMAKE_ASM_FLAGS "-O0 -g3 -nostdlib  ")
set(CMAKE_C_FLAGS "-O0 -g3 -nostdlib  ")
set(CMAKE_EXE_LINKER_FLAGS "")
set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
file(GLOB_RECURSE all_SRCS
    "${PROJECT_SOURCE_DIR}/src/julia_ditomas_10_test.s"
)
add_executable(main.xexe ${all_SRCS})
set_target_properties(main.xexe PROPERTIES LINKER_LANGUAGE C)