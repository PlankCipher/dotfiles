export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="steeef"

plugins=(zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias bat="bat -p --theme rose-pine-moon"
alias gd="git diff --patch --stat"
alias gdf='git status -s | sed -E "/(^\?\?)|(^M )/d" | awk "{ print \$2 }" | fzf --preview "bat -p --color always -l diff <(git diff --patch --stat {})"'

_full_upgrade () {
  for target in "$@"; do
    echo -n '\n\n\n'

    case "$target" in
      "pacman")
        sudo pacman -Syu
        ;;

      "yay")
        yay -Syu --devel
        ;;

      "yarn")
        yarn global upgrade
        ;;

      "composer")
        composer global update
        ;;

      "rust")
        rustup update stable nightly
        ;;

      "eww")
        git clone https://github.com/elkowar/eww.git $HOME/Downloads/eww
        cd $HOME/Downloads/eww
        cargo build --release --no-default-features --features=wayland
        chmod +x target/release/eww
        eww close-all
        eww kill
        sudo cp target/release/eww /sbin/
        eww daemon
        eww open bar
        cd -
        rm -rf $HOME/Downloads/eww
        ;;

      *)
        echo "unknown update target"
        ;;
    esac
  done
}

alias full_upgrade="_full_upgrade pacman yay yarn composer rust eww"

function clear_history {
  echo -n >| "$HISTFILE"
  fc -p "$HISTFILE"
}

# Clear history on start and exit
clear_history
trap 'clear_history' EXIT

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# Set cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam cursor shape for each new prompt
_fix_cursor() {
  echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

colorscript --random
