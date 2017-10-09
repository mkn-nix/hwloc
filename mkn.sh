#!/usr/bin/env bash

set -e

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

GIT_URL="https://github.com/open-mpi/hwloc"
GIT_BNC="hwloc-1.11.8"
GIT_OPT="--depth 1"
DIR="hwloc"

THREADS="$(nproc --all)"

rm -rf $CWD/inst
mkdir -p $CWD/inst

HAS=1
[ ! -d "$CWD/$DIR" ] && HAS=0 && git clone $GIT_OPT $GIT_URL -b $GIT_BNC $DIR --recursive

pushd $DIR
[ $HAS -eq 1 ] && git pull origin $GIT_BNC;

./autogen.sh
./configure --prefix=$CWD/inst
make clean
make -j$THREADS
make install
popd

echo "Finished successfully"
exit 0
