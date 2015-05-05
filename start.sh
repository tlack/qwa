#!/bin/sh
DEV="-l -e 1 -p 8080"
PROD="-l -p 80"
ARGS=$DEV
rlwrap ~/q/l32/q qwa $* $ARGS


