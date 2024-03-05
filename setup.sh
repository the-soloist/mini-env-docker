#!/usr/bin/env bash
# set -x

function sync-git-repo() {
    url="$1"
    path="$2"
    if [ -z "$path" ]; then
        path=$(basename "$url")
    fi

    echo ">>> sync '$url' -> '$path'"

    if [ -d "$path/.git" ]; then
        pushd "$path" >/dev/null || return 0
        git pull
        popd >/dev/null || return 0
    else
        git clone "$url" "$path"
    fi

    printf "\n"
}

### init ###

mkdir -p ./config/tmux/plugins
mkdir -p ./config/tmux/themes
mkdir -p ./deps/python-package
mkdir -p ./docker/tools/gdb/plugins
mkdir -p ./share
mkdir -p ./ssh
echo "REPLACE THIS FILE" >./ssh/authorized_keys

### download ###

# @ tmux plugins
pushd ./config/tmux/plugins/ >/dev/null
sync-git-repo https://github.com/thewtex/tmux-mem-cpu-load
sync-git-repo https://github.com/tmux-plugins/tmux-prefix-highlight
sync-git-repo https://github.com/tmux-plugins/tmux-sensible
sync-git-repo https://github.com/tmux-plugins/tmux-sidebar
sync-git-repo https://github.com/tmux-plugins/tmux-yank
sync-git-repo https://github.com/tmux-plugins/tpm
popd >/dev/null

### compile ###

# @ tmux-mem-cpu-load
echo ">>> compiling tmux-mem-cpu-load ..."
pushd ./config/tmux/plugins/tmux-mem-cpu-load >/dev/null
[ -e "./tmux-mem-cpu-load" ] && rm ./tmux-mem-cpu-load
cmake -DCMAKE_CXX_FLAGS="-static" .
make -j16
popd >/dev/null
printf "\n"
