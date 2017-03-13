#
# Language
#

export LANG="it_IT.UTF-8"
export LC_ALL='it_IT.UTF-8'

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Async for zsh, used by pure
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
# Load completion library for those sweet [tab] squares
# zplug "lib/completion", from:oh-my-zsh
# Prezto modules
# zplug 'modules/archive', from:prezto
zplug 'modules/environment', from:prezto
zplug 'modules/git', from:prezto
zplug 'modules/homebrew', from:prezto
zplug 'modules/node', from:prezto
zplug 'modules/osx', from:prezto
# zplug 'modules/ssh', from:prezto
zplug 'modules/tmux', from:prezto
zplug 'modules/terminal', from:prezto
zplug 'modules/editor', from:prezto
zplug 'modules/history', from:prezto
zplug 'modules/directory', from:prezto
zplug 'modules/spectrum', from:prezto
zplug 'modules/utility', from:prezto
zplug "zsh-users/zsh-completions"
# Syntax highlighting for commands, load last and defer
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "modules/history-substring-search", from:prezto,  defer:2

# Prezto configuration options
zstyle ':prezto:*:*' color 'yes'

 zstyle ':prezto:module:syntax-highlighting' highlighters \
   'main' \
   'brackets' \
   'pattern' \
   'line' \
   'cursor' \
   'root'

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':prezto:module:editor' key-bindings 'emacs'

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Then, source plugins and add commands to $PATH
zplug load
