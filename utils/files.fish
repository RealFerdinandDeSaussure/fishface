#!/usr/bin/env fish
set loc (path dirname (path resolve (status filename)))
set repo_dir $loc/..
set files_file $loc/files

for f in (string match -re '^functions' < $files_file)
    set base_f (path basename $f)
    mkdir -p $repo_dir/(path dirname $f)
    cp -v $HOME/.config/fish/functions/$base_f $repo_dir/$f || return 1
end

for f in (string match -re '^scripts' < $files_file)
    set base_f (path basename $f)
    test -f $HOME/.local/bin/$base_f && set target $HOME/.local/bin/$base_f
    test -f $HOME/.local/share/comp-scripts/$base_f && set target $HOME/.local/share/comp-scripts/$base_f
    mkdir -p $repo_dir/(path dirname $f)
    cp -v $target $repo_dir/$f || return 1
end
