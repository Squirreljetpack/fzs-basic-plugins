export _FD_VID_EXTENSIONS="-e mp4 -e avi -e mkv -e mov"
export _FD_IMG_EXTENSIONS="-e jpg -e jpeg -e png -e gif"
export _FD_TXT_EXTENSIONS="-e txt -e md -e log --no-extension"
export _FD_AUD_EXTENSIONS="-e mp3 -e wav -e flac -e aac -e ogg -e m4a"

# : CMD,WG
$this.files.wg() {
  result=$(find.simplefiles ~) || return 1
  local key="$(awk 'NR==1' <<<"$res")"
  local res=${(@f)"$(awk 'NR!=1' <<<"$result")"}
  case "$key" in
    ctrl-d) cd "$HOME/$(dirname ${res[1]})"
      ;;
    alt-d) for line in ${(@)res:1}; do o "$HOME/$(dirname ${res[1]})"; done
      ;;
    ctrl-l) cd "$HOME/$(dirname ${res[1]})"; l "$(basename ${res[1]})"
      ;;
    *) for line in ${(@)res:1}; do o "$HOME/$line"; done
      ;;
  esac
  
}
zle -N $this.files.wg

# : CMD,WG,NC
$this.dirs.wg() {
  result=$(find.simplefiles ~ -t d --color=never) || return 1
  local key="$(awk 'NR==1' <<<"$res")"
  local res=${(@f)"$(awk 'NR!=1' <<<"$result")"}
  case "$key" in
    ctrl-d) cd "$HOME/$(dirname ${res[1]})"
    ;;
    *) for line in ${(@)res:1}; do o "$HOME/$line"; done
    ;;
  esac
  cd "$HOME/$result" 
}
zle -N $this.dirs.wg