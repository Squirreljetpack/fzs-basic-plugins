### FUNCTIONS

### WIDGETS


# : WG cmd=find.dirs.wg name=dirs


# : CMD,WG
$this.command.wg() {
  # params=("${(z)LBUFFER}")
  zle reset-prompt
  BUFFER="$(command fzf.command) "
  CURSOR=$#BUFFER
}
zle -N $this.command.wg