#!/bin/sh
TARGET_DIR=`dirname $2`
if [ ! -x $TARGET_DIR ]; then
    mkdir -p $TARGET_DIR
fi

ln -sfnv ${1} ${2}
