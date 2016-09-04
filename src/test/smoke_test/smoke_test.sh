#!/bin/bash

#***************************************************************************#
#                            Smoke Test for dgrep                           #
#                    dgrep will query 2 local logs twice                    #
#                and compare its results with grep's results                #
#***************************************************************************#

printf "====== Smoke Tests ======\n\n\n"

SUCCESS=0
FAILURE=1

TEST_LOG_DIRECTORY=$(pwd)"/test/logs"
SMOKE_TEST_DIRECTORY=$(pwd)"/test/smoke_test"
printf "TEST_DATA_DIRECTORY = $TEST_LOG_DIRECTORY\n"
printf "SMOKE_TEST_DIRECTORY = $SMOKE_TEST_DIRECTORY\n\n\n"

# ------------------------ #
# dgrep a frequent pattern #
# ------------------------ #
grep GET $TEST_LOG_DIRECTORY/1.log > $SMOKE_TEST_DIRECTORY/1_grep.result
dgrep GET $TEST_LOG_DIRECTORY/1.log > $SMOKE_TEST_DIRECTORY/1_dgrep.result
diff $SMOKE_TEST_DIRECTORY/1_grep.result $SMOKE_TEST_DIRECTORY/1_dgrep.result && exit $SUCCESS || exit $FAILURE

# --------------------------- #
# dgrep an infrequent pattern #
# --------------------------- #
grep POST $TEST_LOG_DIRECTORY/1.log > $SMOKE_TEST_DIRECTORY/1_grep.result
dgrep POST $TEST_LOG_DIRECTORY/1.log > $SMOKE_TEST_DIRECTORY/1_dgrep.result
diff $SMOKE_TEST_DIRECTORY/1_grep.result $SMOKE_TEST_DIRECTORY/1_dgrep.result && exit $SUCCESS || exit $FAILURE

# ------------------------ #
# dgrep regular expression #
# ------------------------ #
grep -E "*mail" $TEST_LOG_DIRECTORY/1.log > $SMOKE_TEST_DIRECTORY/1_grep.result
dgrep -E "*mail" $TEST_LOG_DIRECTORY/1.log > $SMOKE_TEST_DIRECTORY/1_dgrep.result
diff $SMOKE_TEST_DIRECTORY/1_grep.result $SMOKE_TEST_DIRECTORY/1_dgrep.result && exit $SUCCESS || exit $FAILURE
