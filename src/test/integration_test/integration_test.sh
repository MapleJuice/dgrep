#!/bin/bash

#***************************************************************************#
#                         Integration Test for dgrep                        #
#        The test stands up 4 containers and run dgrep servers in them      #
#       The host machine runs dgrep against the 4 containers and itself     #
#                 then compare its results with grep's results              #
#                      INTEGRATION TEST RUNS ONLY ON UBUNTU                 #
#***************************************************************************#

function set_up_container
{
	printf "===========================\n"
	printf "Setting up container ${1: -1}...\n"
	printf "===========================\n"

	sudo lxc-create -t ubuntu -n $1
	printf "=====================================\n"
	printf "Successfully created container ${1: -1}"
	printf "=====================================\n"

	sudo lxc-start -n $1 -d
	printf "=====================================\n"
	printf "Successfully started container ${1: -1}"	
	printf "=====================================\n"
}

SUCCESS=0
FAILURE=1
SKIP=77

# --------------------- #
# Make sure it's Ubuntu #
# --------------------- #
python -mplatform | grep -qi Ubuntu && (echo "Integration Test runs only on Ubuntu\n"; exit SKIP) || printf "Ubuntu distribution detected, allow integration test to run\n"

containers=("container1", "container2", "container3", "container4")

# ----------- #
# Install LXC #
# ----------- #
sudo apt-get update
sudo apt-get install lxc --yes

# ---------------- #
# Setup Containers #
# ---------------- #
for container in ${containers[@]}; do
	echo $container
done
#set_up_container "container1"


# ----------------- #
# Delete Containers #
# ----------------- #
#clear_container "container1"
