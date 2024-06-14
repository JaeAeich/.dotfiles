### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# option "--wsl" will uncomment this line
# local dotfiles_wsl_ssh=1

if [[ ${dotfiles_wsl_ssh:-0} -eq 1 ]]; then
  eval $(keychain --eval --agents ssh id_rsa)
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"

# ---------------------------------------------- #
#                  Install zinit                 #
# ---------------------------------------------- #

if [[ ! -f "${HOME}/.zinit/bin/zinit.zsh" ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  mkdir -p "${HOME}/.zinit" && chmod g-rwX "${HOME}/.zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.zinit/bin" \
    && print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" \
    || print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "${HOME}/.zinit/bin/zinit.zsh"

# ---------------------------------------------- #
#                     Plugins                    #
# ---------------------------------------------- #

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# fix underline in VSCode Terminal
local znt_history_active_text=reverse

zinit wait lucid for \
  OMZL::directories.zsh \
  OMZL::git.zsh \
  OMZL::grep.zsh \
  OMZL::history.zsh \
  OMZL::key-bindings.zsh \
  OMZP::cp \
  OMZP::colored-man-pages \
  OMZP::command-not-found \
  OMZP::copyfile \
  OMZP::copypath \
  OMZP::dirhistory \
  OMZP::extract \
  OMZP::colorize \
  OMZP::git \
  OMZP::globalias \
  OMZP::zsh-interactive-cd \
  Aloxaf/fzf-tab \
  agkozak/zsh-z \
  psprint/zsh-navigation-tools \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
  atload"!_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  as"completion" OMZP::fzf

zinit ice wait'1' lucid
zinit light laggardkernel/zsh-thefuck

# ---------------------------------------------- #
#                      asdf                      #
# ---------------------------------------------- #
if [[ ! -d ${ASDF_DATA_DIR} ]]; then
  git clone https://github.com/asdf-vm/asdf.git "${ASDF_DATA_DIR}" --branch v0.14.0
fi

. "${ASDF_DATA_DIR}/asdf.sh"
# ---------------------------------------------- #
#                     docker                     #
# ---------------------------------------------- #

# option "--docker" will uncomment this line
# local dotfiles_docker=1

if [[ ${dotfiles_docker:-0} -eq 1 ]]; then
  zinit wait lucid for \
    OMZP::docker-compose \
    as"completion" https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/docker/_docker
fi

# ---------------------------------------------- #
#                      Theme                     #
# ---------------------------------------------- #
zi ice depth=1; zi light romkatv/powerlevel10k

# Install fonts recommended by Powerlevel10k
# Cf. https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#manual-font-installation
if [[ ! -d "${XDG_DATA_HOME}/fonts" ]]; then
  mkdir -p "${XDG_DATA_HOME}/fonts"
fi
if [[ ! -f "${XDG_DATA_HOME}/fonts/MesloLGS NF Regular.ttf" ]]; then
  curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o "${XDG_DATA_HOME}/fonts/MesloLGS NF Regular.ttf"
fi
if [[ ! -f "${XDG_DATA_HOME}/fonts/MesloLGS NF Bold.ttf" ]]; then
  curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o "${XDG_DATA_HOME}/fonts/MesloLGS NF Bold.ttf"
fi
if [[ ! -f "${XDG_DATA_HOME}/fonts/MesloLGS NF Italic.ttf" ]]; then
  curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o "${XDG_DATA_HOME}/fonts/MesloLGS NF Italic.ttf"
fi
if [[ ! -f "${XDG_DATA_HOME}/fonts/MesloLGS NF Bold Italic.ttf" ]]; then
  curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o "${XDG_DATA_HOME}/fonts/MesloLGS NF Bold Italic.ttf"
fi

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# ---------------------------------------------- #
#                   zsh options                  #
# ---------------------------------------------- #

# Just to make sure that the options are defined
setopt append_history
setopt extended_history
setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_verify
setopt share_history

# ---------------------------------------------- #
#                     Aliases                    #
# ---------------------------------------------- #

# LSDeluxe
alias xx='exit'
alias re='reboot'
alias sn='shutdown now'
alias n='nvim .'
