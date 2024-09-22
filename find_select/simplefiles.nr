#!/bin/zsh

# find wrapper wrapper

if [[ ${@} =~ --help ]]; then
  echo "Usage: $0 [paths...] [suffix/fd-type] [other params for fd]"
  exit 0
fi

fd_params=("-E" ".cache")
spaths=()
while [[ -d "$1" ]]; do
  spaths+=("$1/")
  shift 1
done
if [[ -n "$1" && "$1" =~ ^[A-Za-z0-9]+$ ]]; then
  EXT_VAR="_FD_${(@U)1}_EXTENSIONS"
  if typeset -p "$EXT_VAR" > /dev/null 2>&1; then
    fd_params+=(${=${(P)EXT_VAR}})
  else
    fd_params+=("--extension" "$1")
    echo "-ext: $1" >&2
  fi
  shift 1
fi
fd_params+=${@}
if ! [[ "${fd_params[@]}" =~ -t ]]; then
  fd_params+=("-t" "f")
fi

if [[ "$OSTYPE" == linux* ]]; then

elif [[ "$OSTYPE" == darwin* ]]; then
  exclusions=("Contents" "Library/" "micromamba/")  # excludes ALL Library folders, unfortunately
fi

for e in $exclusions; do
  (! echo "${spaths[*]}" | grep -q "$e") && fd_params+=("-E" "$e")
done


pipedir="${FZS_DATA_DIR}/pipes"
mkdir -p $pipedir
mypipe="$pipedir/ffsfpipe"
[[ -e $mypipe ]] && rm $mypipe;
trap "rm $mypipe; trap - EXIT INT"
mkfifo "$mypipe"
if (( ${#spaths} < 2 )); then
  cd "$spaths"
  fd --color always --exclude '.*' ${=fd_params} ${@} '.'  2> /dev/null > "$mypipe" & res=$(fzf \
    -m \
    --bind 'ctrl-y:execute-silent(echo /{+} | ${CLIPcmd})' \
    --height='~30' \
    --delimiter '\t' \
    --expect 'ctrl-d,alt-o,alt-d' \
     < "$mypipe")
else
  fd --exclude '.*' ${=fd_params} ${@} '.' ${=spaths}  2> /dev/null > "$mypipe" & res=$(fzf \
  -m \
  --bind 'one:accept' \
  --bind 'ctrl-y:execute-silent(echo /{+} | ${CLIPcmd})' \
  --delimiter '\t' \
  --expect 'ctrl-d,alt-d,ctrl-l' \
  --height='~40')
fi
if [[ -z "$res" ]]; then
  exit 1
fi

[[ -z "$(awk 'NR==1' <<<"$res")" ]] && awk 'NR!=1' <<<"$res" || echo "$res"