#!/usr/bin/env bash

echo $$ > /sys/fs/cgroup/cpuset/system.slice/benchexec-cgroup.service/tasks
echo $$ > /sys/fs/cgroup/cpuacct/system.slice/benchexec-cgroup.service/tasks
echo $$ > /sys/fs/cgroup/memory/system.slice/benchexec-cgroup.service/tasks
echo $$ > /sys/fs/cgroup/freezer/system.slice/benchexec-cgroup.service/tasks

for i in {1..100}; do
    runexec --no-container --memlimit 2000000000 -- Rscript benchmark-memory.R checkmate > mem-logs/output-checkmate.$i.log
    runexec --no-container --memlimit 2000000000 -- Rscript benchmark-memory.R qcheckmate > mem-logs/output-qcheckmate.$i.log
    runexec --no-container --memlimit 2000000000 -- Rscript benchmark-memory.R R > mem-logs/output-R.$i.log
    runexec --no-container --memlimit 2000000000 -- Rscript benchmark-memory.R assertthat > mem-logs/output-assertthat.$i.log
    runexec --no-container --memlimit 2000000000 -- Rscript benchmark-memory.R assertive > mem-logs/output-assertive.$i.log
    runexec --no-container --memlimit 2000000000 -- Rscript benchmark-memory.R noop > mem-logs/output-noop.$i.log
done
