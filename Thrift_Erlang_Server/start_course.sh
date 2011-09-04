#!/bin/sh

BASE=`dirname $0`
THRIFT=$BASE/../thrift

erl -pa \
  $BASE/ebin \
  $BASE/gen/ebin \
  $THRIFT/ebin \
  -sname course \
  -run course_app start_all
