# Alias
alias dc "docker-compose"
alias ls "exa --icons"
alias tf "terraform"
alias localstack "aws --profile localstack --endpoint-url http://localhost:4566"

# Remove welcome to fish
set fish_greeting

# Variables
set -Ux EDITOR nvim
set -Ux VAGRANT_DEFAULT_PROVIDER "virtualbox"
set -Ux PAGER less
set NVM_DIR "$HOME/.nvm"
set PYENV_ROOT "$HOME/.pyenv"

# Configure Jump
status --is-interactive

# Fish syntax highlighting
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_cancel -r
set -g fish_color_command green --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow'  '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

# PATH
fish_add_path -U "$HOME/.tfenv/bin"
fish_add_path -U "$HOME/.yarn/bin"
fish_add_path -U "$HOME/bin"
fish_add_path -U "/usr/local/bin"
fish_add_path -U $NVM_DIR
fish_add_path -U "$PYENV_ROOT/shims"

# Init Starship
starship init fish | source
