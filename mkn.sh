#!/usr/bin/env bash

set -e

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -z "$(which cmake)" ] && echo "cmake is required to build viennacl" && exit 1;

GIT_URL="https://github.com/open-mpi/hwloc"
GIT_BNC="master"
GIT_OPT="--depth 1"

THREADS="$(nproc --all)"

mkdir -p $CWD/inst

git clone $GIT_OPT $GIT_URL -b $GIT_BNC hwloc --recursive
pushd hwloc
./autogen.sh
./configure --prefix=$CWD/inst
make -j$THREADS
make install

echo "Finished successfully"
exit 0
