<a href = "./LICENSE" target = "_blank"><img src = "https://github.com/QubitPi/Miscellaneous/blob/master/README-reference/license/gpl.png" alt = "GPLv2"></a>

dgrep is a distributed grep tool that allows you to run remote grep command across multiple machines.

<h1>Install from Source</h1>
Make sure Autoconf and Automake are installed, then run

<code>
autoreconf --install
./configure
make
sudo make install
</code>

<h1>Design</h1>
	dgrep uses client-server scheme. The server runs on each machine, which has log file on it. Any machine can be client. dgrep has the exact the same usage as grep, including command options. When a dgrep command is issued, dgrep client translates command into the corresponding grep command and sends the command to dgrep servers that run on remote machines. Once the servers receive the grep command from client, they execute it, then return the result back to client. For example, if dgrep is invoked by

<code>
dgrep POST /path_to_log
</code>

	the dgrep server, upon notified by client, executes

<code>
grep POST /path_to_log
</code>

<h1>Test</h1>
<h2>Smoke Test</h2>
	Smoke test stands up dgrep server locally. Then dgrep scans a local log for some patterns and pips result into a result file. Next the test use grep command for the same pattern on the same log file and pips result to a different file. In the end, the tests utilizes diff to make sure the two result files are the same.
