#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

echo "new"

# zmodload zsh/zprof
POSH_THEMES_PATH=/mnt/c/Users/lucag/AppData/Local/Programs/oh-my-posh/themes
eval "$(oh-my-posh init zsh --config ${POSH_THEMES_PATH}/half-life.omp.json)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Use emacs keybindings even if our EDITOR is set to vi
# bindkey -e

# History

# Keep 5000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# Remove superfluous blanks from each command line being added to the history
# list
setopt histreduceblanks

# Do not enter command lines into the history list if they are duplicates of the
# previous event.
setopt histignorealldups
setopt hist_ignore_all_dups   # Delete an old recorded event if a new event is a duplicate.

setopt sharehistory           # Share history between all sessions.
# setopt appendhistory

setopt hist_ignore_space      # Do not record an event starting with a space.
setopt hist_save_no_dups      # Do not write a duplicate event to the history file.
setopt hist_ignore_dups       # Do not record an event that was just recorded again.
setopt hist_find_no_dups      # Do not display a previously found event.

# Lazy-load (autoload) Zsh function files from a directory.
# ZFUNCDIR=${ZDOTDIR:-$HOME}/.zfunctions
# fpath=($ZFUNCDIR $fpath)
# autoload -Uz $ZFUNCDIR/*(.:t)

# Set any zstyles you might use for configuration.
[[ ! -f ${ZDOTDIR:-$HOME}/.zstyles ]] || source ${ZDOTDIR:-$HOME}/.zstyles

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load # initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt

# Source anything in .zshrc.d.
for _rc in ${ZDOTDIR:-$HOME}/.zshrc.d/*.zsh; do
  # Ignore tilde files.
  if [[ $_rc:t != '~'* ]]; then
    source "$_rc"
  fi
done
unset _rc

# To customize prompt, run `p10k configure` or edit .p10k.zsh.
# [[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh

eval "$(~/.local/bin/mise activate zsh)"

# zprof