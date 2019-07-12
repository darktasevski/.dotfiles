#!/usr/bin/env bash
# To debug how long init takes, run "DEBUG=1 source-rc"
function debug() {
        [[ x == "${DEBUG+x}" ]] && echo "$@" >&2
}

function t_debug() {
        [[ x == "${DEBUG+x}" ]] && echo "$(timer_now)" "$@" >&2
}

function timer_start(){
    __timer=$(millis)
}

function timer_start_if_unset(){
    if [[ x${__timer} == x ]]; then
        debug Timer was unset. Initializing timer.
        timer_start
    fi
}

function timer_now(){
    if [[ x${__timer} == x ]]; then
        echo "Timer is unset. Use timer_start"
        return 1
    fi

    local diff;
    local now;
    now=$(millis)
    diff=$now-$__timer
    echo "${diff}"
}

# vi: ft=sh
