# Profiling
# zmodload zsh/zprof

## ENV

#FZF
export FZF_DEFAULT_COMMAND='fdfind --type file --type symlink --hidden .'
FZF_COLORS="fg:#ebdbb2,\
bg:#32302f,\
hl:#fabd2f,\
fg+:#ebdbb2,\
bg+:#3c3836,\
hl+:#fabd2f,\
info:#ebdbb2,\
prompt:#689d6a,\
spinner:#fabd2f,\
pointer:#fb4934,\
marker:#83a598,\
header:#665c54"
export FZF_DEFAULT_OPTS="--layout=reverse --color=$FZF_COLORS \
--multi \
--cycle \
--preview-window='noborder' \
--info='inline-right' \
--prompt='$>' \
--pointer='>' \
--marker='+' \
--bind=ctrl-d:preview-page-down,ctrl-u:preview-page-up \
"
export BAT_THEME="gruvbox-dark"

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=~/.zsh_hist

export KEYTIMEOUT=1

#HERE ADD YOUR OWN PATH VARIABLE
# PATH=SOMEPATH:$PATH

# +------------+
# | NAVIGATION |
# +------------+

unsetopt beep hist_beep list_beep
setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
 
setopt PROMPT_SUBST

#PROMPT
autoload -Uz promptinit
promptinit

# Set up the prompt (with git branch name)
#%F{256_color_code}%f
#%B%b bold
#%U%u underline
PROMPT="[%F{202}%n%f%F{105}@%f%F{28}%M%f | %B%F{184}%~%f%b | "
PROMPT=$PROMPT'%U%B${vcs_info_msg_0_}%b%u]'$'\n'' ${?} $>'

autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b'


#COLORS
autoload -U colors
colors


#completion
autoload -Uz compinit bashcompinit
compinit
bashcompinit

# [ -f ~/.zsh/completion.zsh ] && source ~/.zsh/completion.zsh

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh
[ -f ~/.fzf-tab/fzf-tab.plugin.zsh ] && source ~/.fzf-tab/fzf-tab.plugin.zsh

#cp mv rm utils completion
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:warnings' format 'No result found for : %d'

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -lhA $realpath'

# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

#ls
alias ls='ls -G'
alias ll='ls -G -lh'
alias la='ls -G -A'
alias lla='ls -G -lhA'

#git
#alias gph='git push'
#alias gfa='git fetch --all'
#alias gpl='git pull'
#alias gcl='git clone'
#alias gcr='git clone --recurse-submodules'
#alias gss='git status'
#alias gdf='git diff'
#alias ghl='git stash list'
#alias ghs='git stash save'
#alias grzt='git stash save "pre restore save" && git restore .'

fuzzy_cd() {
  cd "$(fdfind --type d --follow --hidden . ~ | fzf --preview 'ls -lhA --color=always {}')"
  zle reset-prompt
}
zle -N fuzzy_cd

fuzzy_history() {
    emulate -L zsh
    zle -I
    local S=$(fc -l -n -r 1 | fzf)
    if [[ -n $S ]] ; then
        LBUFFER=$S
    fi
    zle reset-prompt
}
zle -N fuzzy_history

fuzzy_path() {
    emulate -L zsh
    zle -I
    local S=$(fdfind --follow --type d --hidden . ~ | fzf --preview "ls -lhA --color=always {}")
    if [[ -n $S ]] ; then
        LBUFFER+=$S
    fi
}
zle -N fuzzy_path

fuzzy_git() {
    emulate -L zsh
    zle -I
    local S=$(fdfind --follow --type f --hidden | fzf --preview "fzf-preview.sh {}")
    if [[ -n $S ]] ; then
        LBUFFER+=$S
    fi
}
zle -N fuzzy_git


fuzzy_file() {
    emulate -L zsh
    zle -I
    local S=$(fdfind --no-ignore --follow --type f --hidden | fzf --preview "fzf-preview.sh {}")
    if [[ -n $S ]] ; then
        LBUFFER+=$S
    fi
}
zle -N fuzzy_file


fuzzy_processes() {
    emulate -L zsh
    zle -I
    local S=$(ps -ef | sed 1d | fzf | awk '{print $2}' | tr '\n' ' ')
    if [[ -n $S ]] ; then
        LBUFFER+=$S
    fi
}
zle -N fuzzy_processes

bindkey -r '^R'
bindkey '^R' fuzzy_history
bindkey -r '\ec'
bindkey '\ec' fuzzy_cd
bindkey -r '^F'
bindkey '^F' fuzzy_file
bindkey -r '^P'
bindkey '^P' fuzzy_path
bindkey -r '^g'
bindkey '^g' fuzzy_git
bindkey -r '^E'

[ -f ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Profiling
# zprof
