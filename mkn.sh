#!/usr/bin/env bash

set -e

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -z "$(which cmake)" ] && echo "cmake is required to build viennacl" && exit 1;

GIT_URL="https://github.com/open-mpi/hwloc"
GIT_BNC="master"
GIT_OPT="--depth 1"

THREADS="$(nproc --all)"

rm -rf v
git clone $GIT_OPT $GIT_URL -b $GIT_BNC h --recursive
pushd h
./autogen.sh
./configure --prefix=$CWD
make -j$THREADS
make install

echo "Finished successfully"
rm -rf $CWD/h
exit 0
