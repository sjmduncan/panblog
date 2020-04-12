#!/bin/bash

set -ue

pb_bindir="$HOME/.local/bin/"
pb_sharedir="$HOME/.local/share/panblog/"

mkdir -p "$pb_sharedir"
cp -vr "./src/style" "$pb_sharedir"
cp "./src/pb.conf" "$pb_sharedir/pb.conf.tmpl"

mkdir -p "$pb_bindir"
cp "./src/pb" "$pb_bindir"
cp "./src/pb-create" "$pb_bindir"
chmod a+x "$pb_bindir/pb"
chmod a+x "$pb_bindir/pb-create"

