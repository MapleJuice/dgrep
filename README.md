<a href = "./LICENSE" target = "_blank"><img src = "https://github.com/QubitPi/Miscellaneous/blob/master/README_reference/gpl.png" alt = "GPLv2"></a>

# dgrep
`dgrep` is a distributed `grep` tool that allows you to run remote grep command across multiple machines.

# Install from Release
```bash
./configure
make
sudo make install
```

# Install from Source
Install <href = "https://www.gnu.org/software/autoconf/autoconf.html" target = "_blank">Autoconf</a> and <href = "https://www.gnu.org/software/automake/" target = "_blank">Automake</a>, then run

```bash
autoreconf --install
./configure
make
sudo make install
```

# Design
`dgrep` uses client-server scheme. The server runs on each machine, which has log file on it. Any machine can be client. `dgrep` has the exact the same usage as `grep`, including command options. When a `dgrep` command is issued, `dgrep` client translates command into the corresponding `grep` command and sends the command to `dgrep` servers that run on remote machines. Once the servers receive the 'grep' command from client, they execute it, then return the result back to client. For example, if `dgrep` is invoked by

```bash
dgrep POST /path_to_log
```

the `dgrep` server, upon notified by client, executes

```bash
grep POST /path_to_log

```

## Test
### Smoke Test
Smoke test stands up `dgrep` server locally. Then `dgrep` scans a local log for some patterns and pips result into a result file. Next the test use `grep` command for the same pattern on the same log file and pips result to a different file. In the end, the tests utilizes `diff` to make sure the two result files are the same.
