#!/bin/sh

mkdir -p .tempobjs
cd .tempobjs

ar x ../../xomb/runtimes/mindrt/drt0.a
ar x ../../xomb/runtimes/mindrt/mindrt.a
ar x ../../xomb/user/c/lib/syscall.a
ar -rs ../local/x86_64-pc-xomb/lib/libc.a *.o

cd ..
rm -r .tempobjs