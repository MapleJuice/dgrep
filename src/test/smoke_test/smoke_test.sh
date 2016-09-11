#!/bin/bash

#***************************************************************************#
#                            Smoke Test for dgrep                           #
#                       dgrep will query a local log                        #
#                and compare its results with grep's results                #
#***************************************************************************#

SUCCESS=0
FAILURE=1

TEST_LOG_DIRECTORY=$(pwd)"/test/logs"
SMOKE_TEST_DIRECTORY=$(pwd)"/test/smoke_test"
printf "TEST_DATA_DIRECTORY = $TEST_LOG_DIRECTORY\n"
printf "SMOKE_TEST_DIRECTORY = $SMOKE_TEST_DIRECTORY\n\n\n"

# ------------------------ #
# dgrep a frequent pattern #
# ------------------------ #
grep GET $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/grep.result
dgrep GET $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/dgrep.result
diff $SMOKE_TEST_DIRECTORY/grep.result $SMOKE_TEST_DIRECTORY/dgrep.result && exit $SUCCESS || exit $FAILURE

grep "GET" $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/grep.result
dgrep "GET" $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/dgrep.result
diff $SMOKE_TEST_DIRECTORY/grep.result $SMOKE_TEST_DIRECTORY/dgrep.result && exit $SUCCESS || exit $FAILURE

# --------------------------- #
# dgrep an infrequent pattern #
# --------------------------- #
grep POST $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/grep.result
dgrep POST $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/dgrep.result
diff $SMOKE_TEST_DIRECTORY/grep.result $SMOKE_TEST_DIRECTORY/dgrep.result && exit $SUCCESS || exit $FAILURE

grep "POST" $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/grep.result
dgrep "POST" $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/dgrep.result
diff $SMOKE_TEST_DIRECTORY/grep.result $SMOKE_TEST_DIRECTORY/dgrep.result && exit $SUCCESS || exit $FAILURE

# ------------------------ #
# dgrep regular expression #
# ------------------------ #
grep -E *edu $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/grep.result
dgrep -E *edu $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/dgrep.result
diff $SMOKE_TEST_DIRECTORY/grep.result $SMOKE_TEST_DIRECTORY/dgrep.result && exit $SUCCESS || exit $FAILURE

grep -E "*edu" $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/grep.result
dgrep -E "*edu" $TEST_LOG_DIRECTORY/vm1.log > $SMOKE_TEST_DIRECTORY/dgrep.result
diff $SMOKE_TEST_DIRECTORY/grep.result $SMOKE_TEST_DIRECTORY/dgrep.result && exit $SUCCESS || exit $FAILURE

rm $SMOKE_TEST_DIRECTORY/grep.result $SMOKE_TEST_DIRECTORY/dgrep.result
