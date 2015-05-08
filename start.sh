#!/bin/sh
ENV=dev

DEV="-l -e 1 -p 8080"
PROD="-l -p 80"

if [ x$ENV = xdev ]; then
	rm qwa.log qwa.qdb
	ARGS=$DEV
else
	ARGS=$PROD
fi

rlwrap ~/q/l32/q qwa $* $ARGS


