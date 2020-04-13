#!/bin/bash

set -u

pb_bindir="$HOME/.local/bin/"
pb_sharedir="$HOME/.local/share/panblog/"

if ! grep "export PATH=\"\$PATH:\$HOME/.local/bin.*\"" "$HOME/.bashrc" >/dev/null 2>/dev/null; then
    echo "Adding \$HOME/.local/bin to your path in .bashrc"
    echo "export PATH=\"\$PATH:\$HOME/.local/bin\"" >> "$HOME/.bashrc"
fi

mkdir -p "$pb_bindir"
mkdir -p "$pb_sharedir"

cp -vr "./src/templates" "$pb_sharedir"
cp "./src/pb.conf" "$pb_sharedir/pb.conf.tmpl"


cp "./src/pb" "$pb_bindir"
cat "./src/pb-create" | sed "s:__PBSHAREDIR__:$pb_sharedir:;" > "$pb_bindir/pb-create"
chmod a+x "$pb_bindir/pb"
chmod a+x "$pb_bindir/pb-create"
