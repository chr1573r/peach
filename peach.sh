#!/usr/bin/env bash
# peach <appname> <executable>
#https://raster.shields.io/badge/peach-success-red.png?&appColor=FAAB5C&logo=gnubash&logoColor=black

peach_log="pch_log.txt"
peach_result_dir="results"

export app="$1"

shift 1
app_task="$*"
export app_result_dir="${peach_result_dir}/${app}"

plog(){
    echo "peach[$app]#$(date +'%d.%m%.%y %H:%M:%S')> $@" | tee -a "$peach_log"
    echo "peach[$app]#$(date +'%d.%m%.%y %H:%M:%S')> $@" >> "$app_result_dir/$peach_log"
}

[[ -d "$app_result_dir" ]] || mkdir "$app_result_dir"

plog "Init"
nohup $app_task 2> "$app_result_dir/pch_stderr.txt" 1> "$app_result_dir/pch_stdout.txt" &
app_task_pid="$!"

( sleep 1m ; if ps -p "$app_task_pid" &> /dev/null; then kill -INT -9 "$app_task_pid" > /dev/null 2>&1; fi) &
app_task_handler="$!"


plog "Executing task: '$app_task'"
if wait "$app_task_pid" > /dev/null 2>&1; then
    app_task_result="success"
else
    if ps -p "$app_task_handler" > /dev/null 2>&1; then
        app_task_result="failure"
    else
        app_task_result="timeout"
    fi
fi
plog "Result: $app_task_result"
echo "$app_task_result" > "$app_result_dir/pch_result.txt"
echo "$(date +'%d.%m%.%y %H:%M:%S')" > "$app_result_dir/pch_lastrun.txt"


if ps -p "$app_task_handler" > /dev/null 2>&1; then
    kill -INT "$app_task_handler" > /dev/null 2>&1
fi
./peach_web.sh
