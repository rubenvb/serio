##
# Copyright © Ruben Van Boxem
#
# SPDX-License-Identifier: MIT
#

message(STATUS "runtime test: test_component=${test_component}, test_name=${test_name}")
execute_process(COMMAND "${CMAKE_COMMAND}" -E remove "${test_component}/${test_name}${CMAKE_EXECUTABLE_SUFFIX}"
                RESULT_VARIABLE exit_code
                ERROR_VARIABLE stderr)

if(NOT 0 EQUAL ${exit_code})
  message(FATAL_ERROR "Could not remove ${test_component}/${test_name}${CMAKE_EXECUTABLE_SUFFIX}:\n${stderr}")
endif()

execute_process(COMMAND "${CMAKE_COMMAND}" --build .. --target "${test_name}"
                RESULT_VARIABLE exit_code
                ERROR_VARIABLE stderr
                OUTPUT_QUIET)

if(NOT 0 EQUAL ${exit_code})
  message(FATAL_ERROR "Could not compile ${test_component}/${test_name}${CMAKE_EXECUTABLE_SUFFIX}:\n${stderr}")
endif()

message(STATUS "Executing ${test_component}/${test_name}${CMAKE_EXECUTABLE_SUFFIX}")

execute_process(COMMAND "./${test_name}${CMAKE_EXECUTABLE_SUFFIX}"
                RESULT_VARIABLE exit_code
                ERROR_VARIABLE stderr)

if(NOT 0 EQUAL ${exit_code})
  if(NOT stderr STREQUAL "")
    set(executable_output "\nTest executable output:\n${stderr}")
  endif()
  message(FATAL_ERROR "Test execution failed: ${test_component}/${test_name}${CMAKE_EXECUTABLE_SUFFIX}${executable_output}")
endif()
