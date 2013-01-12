#!/bin/bash

#
# Handle error returns from called commands.
#
# This simple error handler will make the script return the exit code of the last
# command that returned non-zero.
#
# For this to work, the called commands must actually return non-zero in case of
# errors. For other shell scripts, it is thus advisable to set the 'errexit' shell
# option, see also http://www.alittlemadness.com/2006/05/24/bash-tip-exit-on-error/
# (or ensure non-zero return on error by some other means, e.g. yet another error
# handler).
#
# see http://stackoverflow.com/questions/1000370/add-collect-exit-codes-in-bash
# for an example and further documentation.
#

# inheriting the ERR trap into the ( ... ) subshells does not work even with '-E',
# in spite of what's said here:
# http://stackoverflow.com/questions/9624947/bash-not-trapping-interrupts-during-rsync-subshell-exec-statements

declare -i ERROR=0

ErrorHandler () {
    ERROR=$?
    if [[ $BASH_SUBSHELL -gt 0 ]]; then
      echo "      ^- returned ERROR: $ERROR"
    fi
}

ExitHandler () {
    # echo "      >- returning ERROR: $ERROR"
    exit $ERROR
}

waitfor() {
    for i in {0..30}; do
	$@
	if [ $? -eq 0 ]; then
	    break
	fi
	sleep 1
#	echo "Waitinig ... $i"
    done
}

function download() {
    [ -f $2 ] || (curl -s $1 > $2.part; mv $2.part $2)
}

function startbg() {
    id=$1
    shift
    mkdir -p $TMP
    nohup $@ > $TMP/$id.out 2> $TMP/$id.err < /dev/null &
    echo $! > $TMP/$id.pid
}

function stopbg() {
    id=$1
    if [ -f $TMP/$id.pid ]; then
	PID=`cat $TMP/$id.pid`
	kill $PID >/dev/null
    fi
}
