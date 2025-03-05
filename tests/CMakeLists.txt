##
# Copyright © Ruben Van Boxem
#
# SPDX-License-Identifier: MIT
#

set(test_list_dir ${CMAKE_CURRENT_LIST_DIR})
set(shared_test_files
   )

function(runtime_test component test_name)
  set(test_src ${test_list_dir}/${component}/${test_name}.test.c++)
  source_group("" FILES ${test_src})
  string(REPLACE "/" "." test_target_name "test.${component}.${test_name}")
  add_executable(${test_target_name} ${test_src} ${shared_test_files})
  set_target_properties(${test_target_name} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_CURRENT_BINARY_DIR}
                                                       FOLDER tests/${component})
  target_include_directories(${test_target_name} PUBLIC ${test_list_dir} ${PROJECT_SOURCE_DIR})
  target_link_libraries(${test_target_name} ${component})

  add_test(${component}/${test_name} ${CMAKE_COMMAND} -Dtest_component=${component}
                                                      -Dtest_name=${test_target_name}
                                                      -P ${test_list_dir}/runtime_test.cmake)
endfunction()

function(compile_test component test_name)
  set(test_src ${test_list_dir}/${component}/${test_name}.test.c++)
  source_group("" FILES ${test_src})
  string(REPLACE "/" "." test_target_name "test.${component}.${test_name}")
  add_library(${test_target_name} OBJECT ${test_src} ${shared_test_files})
  set_target_properties(${test_target_name} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_CURRENT_BINARY_DIR}
                                                       FOLDER tests/${component})
  target_include_directories(${test_target_name} PUBLIC ${test_list_dir} ${PROJECT_SOURCE_DIR})
  target_link_libraries(${test_target_name} ${component})

  add_test(${component}/${test_name} ${CMAKE_COMMAND} -Dtest_component=${component}
                                                      -Dtest_name=${test_target_name}
                                                      -P ${test_list_dir}/compile_test.cmake)
endfunction()

function(compile_test_library component test_name)
  set(test_src ${test_list_dir}/${component}/${test_name}.test.c++)
  source_group("" FILES ${test_src})
  string(REPLACE "/" "." test_target_name "test.${component}.${test_name}")
  add_library(${test_target_name} SHARED ${test_src} ${shared_test_files})
  set_target_properties(${test_target_name} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_CURRENT_BINARY_DIR}
                                                       RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_CURRENT_BINARY_DIR}
                                                       LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                                                       LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_CURRENT_BINARY_DIR}
                                                       LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_CURRENT_BINARY_DIR}
                                                       LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_CURRENT_BINARY_DIR}
                                                       LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_CURRENT_BINARY_DIR}
                                                       FOLDER tests/${component})
  target_include_directories(${test_target_name} PUBLIC ${test_list_dir} ${PROJECT_SOURCE_DIR})
  target_link_libraries(${test_target_name} ${component})

  add_test(${component}/${test_name} ${CMAKE_COMMAND} -Dtest_component=${component}}
                                                      -Dtest_name=${test_target_name}
                                                      -P ${test_list_dir}/compile_test.cmake)
endfunction()

add_custom_target(tests_shared SOURCES
                  runtime_test.cmake
                  compile_test.cmake
                 )

#
