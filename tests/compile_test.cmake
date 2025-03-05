##
# Copyright © Ruben Van Boxem
#
# SPDX-License-Identifier: MIT
#

message(STATUS "compile test: test_component=${test_component}, test_name=${test_name}")
execute_process(COMMAND "${CMAKE_COMMAND}" -E remove "${test_component}/${test_name}"
                RESULT_VARIABLE exit_code
                ERROR_VARIABLE stderr)

if(NOT 0 EQUAL ${exit_code})
  message(FATAL_ERROR "Could not remove ${test_component}/${test_name}:\n${stderr}")
endif()

message(STATUS COMMAND "${CMAKE_COMMAND}" --build .. --target "${test_name}")
execute_process(COMMAND "${CMAKE_COMMAND}" --build .. --target "${test_name}"
                RESULT_VARIABLE exit_code
                ERROR_VARIABLE stderr
                OUTPUT_QUIET)

if(NOT 0 EQUAL ${exit_code})
  message(FATAL_ERROR "Could not compile ${test_component}/${test_name}:\n${stderr}")
endif()
