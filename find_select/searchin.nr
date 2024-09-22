#!/bin/zsh

# searches basically all files in multiple dirs
# compared to ffsf, which is more judicious, i.e. ignores hidden files
# this is useful for picking from curated collections

search_dirs=(${@})
[[ ${#search_dirs[@]} -eq 0 ]] && search_dirs=("$HOME")
fd ${=FZF_FD_OPT} . ${@} 2> /dev/null |
    fzf --bind 'one:become(o {})' \
        --delimiter '/' \
        --with-nth '4..' \
        --bind 'enter:become(o {})' \
        --layout=reverse \
        --preview-window 'nohidden'