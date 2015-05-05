#!/bin/sh
DEV="-e 1 -p 8080"
PROD="-p 80"
ARGS=$DEV
rlwrap ~/q/l32/q qwa.q $* $ARGS


