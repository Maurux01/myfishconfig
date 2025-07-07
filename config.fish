# File: config.fish
# Fish config - Enhanced version
set fish_greeting
# File: config.fish
# Fish config - Enhanced version
set fish_greeting

set -g theme_nerd_fonts yes


# Configuración de historial
set -g history_size 10000
set -g fish_escape_delay_ms 10

# Configuración de autocompletado
set -g fish_autosuggestion_enabled 1
set -g fish_autosuggestion_highlight_color 555

# Aliases básicos
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate'

# Herramientas de desarrollo
alias lg='lazygit'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias top='btop'
alias y='yazi'
alias z='zoxide'
alias fz='fzf'

# Sistema
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias ports='netstat -tulanp'
alias meminfo='free -h | grep "Mem" | awk "{print \"Memoria: \" $3 \" / \" $2 \" (\" $3/$2*100.0 \"%)\"}"'
alias cpuinfo='top -bn1 | grep "Cpu(s)" | awk "{print \"CPU: \" $2 \"%\"}"'

# Configuración de aplicaciones
alias nv='nvim'
alias vim='nvim'
alias vi='nvim'
alias e='eww'
alias h='hyprctl'

# Nuevos aliases geniales
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
alias myip='curl -s https://ipinfo.io/ip'

# Función para backup rápido de dotfiles
function dotbackup
  cd ~/github/arch-dots
  git add .
  git commit -m "Backup: $(date '+%Y-%m-%d %H:%M:%S')"
  git push
  cd -
  echo "✅ Backup subido a GitHub!"
end

# Función para actualizar sistema
function update
  echo "🔄 Actualizando sistema..."
  sudo pacman -Syu
  echo "🧹 Limpiando caché..."
  sudo pacman -Sc
  echo "✅ Sistema actualizado!"
end

# Función para buscar paquetes
function search
  pacman -Ss $argv
end

# Función para instalar paquetes
function install
  sudo pacman -S $argv
end

# Función para desinstalar paquetes
function remove
  sudo pacman -R $argv
end

# Función para ver información del sistema
function sysinfo
  neofetch
end

# Función para ver el clima
function weather
  curl wttr.in/$argv
end

# Nuevas funciones geniales
function extract
  if test -f $argv[1]
    switch $argv[1]
      case "*.tar.gz" "*.tgz"
        tar -xzf $argv[1]
      case "*.tar.bz2" "*.tbz"
        tar -xjf $argv[1]
      case "*.tar.xz" "*.txz"
        tar -xJf $argv[1]
      case "*.zip"
        unzip $argv[1]
      case "*.rar"
        unrar x $argv[1]
      case "*.7z"
        7z x $argv[1]
      case "*"
        echo "Formato no soportado"
    end
  else
    echo "Archivo no encontrado"
  end
end

function mkcd
  mkdir -p $argv[1] && cd $argv[1]
end

function backup
  cp $argv[1] $argv[1].backup.(date +%Y%m%d_%H%M%S)
  echo "✅ Backup creado: $argv[1].backup.(date +%Y%m%d_%H%M%S)"
end

function serve
  python3 -m http.server $argv[1]
end

function cheat
  curl cheat.sh/$argv[1]
end

# Configuración de Oh My Fish
if not functions -q omf
  echo "🐟 Instalando Oh My Fish..."
  curl -L https://get.oh-my.fish | fish
end

# Instalar tema si no está instalado
if not omf theme | grep -q bobthefish
  omf install bobthefish
end

# Configuración del tema
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_default_branch yes
set -g theme_git_default_branches master main
set -g theme_git_worktree_support yes
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_vagrant yes
set -g theme_display_docker_machine yes
set -g theme_display_k8s_context yes
set -g theme_display_hg yes
set -g theme_display_virtualenv yes
set -g theme_display_nix yes
set -g theme_display_ruby yes
set -g theme_display_node yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_vi no
set -g theme_display_date no
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_display_jobs_verbose yes
set -g default_user your_normal_user
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 1
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '

# Configuración de fzf
set -g FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'
set -g FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

# Configuración de zoxide
zoxide init fish | source

# Configuración de atuin (historial mejorado)
if command -v atuin >/dev/null 2>&1
  atuin init fish | source
end

# Configuración de starship (prompt alternativo)
if command -v starship >/dev/null 2>&1
  starship init fish | source
end

# Configuración de direnv
if command -v direnv >/dev/null 2>&1
  direnv hook fish | source
end

# Configuración de asdf (version manager)
if command -v asdf >/dev/null 2>&1
  source ~/.asdf/asdf.fish
end

# Configuración de nvm
if command -v nvm >/dev/null 2>&1
  nvm use default >/dev/null 2>&1
end

# Configuración de pyenv
if command -v pyenv >/dev/null 2>&1
  pyenv init - | source
end

# Configuración de rbenv
if command -v rbenv >/dev/null 2>&1
  rbenv init - | source
end

# Completions útiles
for tool in kubectl docker helm terraform az
  if command -v $tool >/dev/null 2>&1
    switch $tool
      case kubectl
        kubectl completion fish | source
      case docker
        docker completion fish | source
      case helm
        helm completion fish | source
      case terraform
        terraform -install-autocomplete
      case az
        az completion fish | source
    end
  end
end

# PATH optimizado y rápido
function add_path --argument path
  if test -d $path
    if not contains $path $PATH
      set -gx PATH $path $PATH
    end
  end
end

add_path $HOME/.cargo/bin
add_path $HOME/go/bin
add_path $HOME/flutter/bin
add_path $HOME/.deno/bin
add_path $HOME/.bun/bin
add_path $HOME/.local/share/pnpm
add_path $HOME/.yarn/bin
add_path $HOME/.composer/vendor/bin
add_path $HOME/.local/bin
add_path $HOME/.local/scripts
add_path /usr/local/bin
add_path $HOME/bin
add_path /snap/bin
add_path /var/lib/flatpak/exports/bin
add_path $HOME/.npm-global/bin

set -g theme_nerd_fonts yes


# Configuración de historial
set -g history_size 10000
set -g fish_escape_delay_ms 10

# Configuración de autocompletado
set -g fish_autosuggestion_enabled 1
set -g fish_autosuggestion_highlight_color 555

# Aliases básicos
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate'

# Herramientas de desarrollo
alias lg='lazygit'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias top='btop'
alias y='yazi'
alias z='zoxide'
alias fz='fzf'

# Sistema
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias ports='netstat -tulanp'
alias meminfo='free -h | grep "Mem" | awk "{print \"Memoria: \" $3 \" / \" $2 \" (\" $3/$2*100.0 \"%)\"}"'
alias cpuinfo='top -bn1 | grep "Cpu(s)" | awk "{print \"CPU: \" $2 \"%\"}"'

# Configuración de aplicaciones
alias nv='nvim'
alias vim='nvim'
alias vi='nvim'
alias e='eww'
alias h='hyprctl'

# Nuevos aliases geniales
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
alias myip='curl -s https://ipinfo.io/ip'

# Función para backup rápido de dotfiles
function dotbackup
  cd ~/github/arch-dots
  git add .
  git commit -m "Backup: $(date '+%Y-%m-%d %H:%M:%S')"
  git push
  cd -
  echo "✅ Backup subido a GitHub!"
end

# Función para actualizar sistema
function update
  echo "🔄 Actualizando sistema..."
  sudo pacman -Syu
  echo "🧹 Limpiando caché..."
  sudo pacman -Sc
  echo "✅ Sistema actualizado!"
end

# Función para buscar paquetes
function search
  pacman -Ss $argv
end

# Función para instalar paquetes
function install
  sudo pacman -S $argv
end

# Función para desinstalar paquetes
function remove
  sudo pacman -R $argv
end

# Función para ver información del sistema
function sysinfo
  neofetch
end

# Función para ver el clima
function weather
  curl wttr.in/$argv
end

# Nuevas funciones geniales
function extract
  if test -f $argv[1]
    switch $argv[1]
      case "*.tar.gz" "*.tgz"
        tar -xzf $argv[1]
      case "*.tar.bz2" "*.tbz"
        tar -xjf $argv[1]
      case "*.tar.xz" "*.txz"
        tar -xJf $argv[1]
      case "*.zip"
        unzip $argv[1]
      case "*.rar"
        unrar x $argv[1]
      case "*.7z"
        7z x $argv[1]
      case "*"
        echo "Formato no soportado"
    end
  else
    echo "Archivo no encontrado"
  end
end

function mkcd
  mkdir -p $argv[1] && cd $argv[1]
end

function backup
  cp $argv[1] $argv[1].backup.(date +%Y%m%d_%H%M%S)
  echo "✅ Backup creado: $argv[1].backup.(date +%Y%m%d_%H%M%S)"
end

function serve
  python3 -m http.server $argv[1]
end

function cheat
  curl cheat.sh/$argv[1]
end

# Configuración de Oh My Fish
if not functions -q omf
  echo "🐟 Instalando Oh My Fish..."
  curl -L https://get.oh-my.fish | fish
end

# Instalar tema si no está instalado
if not omf theme | grep -q bobthefish
  omf install bobthefish
end

# Configuración del tema
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_default_branch yes
set -g theme_git_default_branches master main
set -g theme_git_worktree_support yes
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_vagrant yes
set -g theme_display_docker_machine yes
set -g theme_display_k8s_context yes
set -g theme_display_hg yes
set -g theme_display_virtualenv yes
set -g theme_display_nix yes
set -g theme_display_ruby yes
set -g theme_display_node yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_vi no
set -g theme_display_date no
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_display_jobs_verbose yes
set -g default_user your_normal_user
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 1
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '

# Configuración de fzf
set -g FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'
set -g FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

# Configuración de zoxide
zoxide init fish | source

# Configuración de atuin (historial mejorado)
if command -v atuin >/dev/null 2>&1
  atuin init fish | source
end

# Configuración de starship (prompt alternativo)
if command -v starship >/dev/null 2>&1
  starship init fish | source
end

# Configuración de direnv
if command -v direnv >/dev/null 2>&1
  direnv hook fish | source
end

# Configuración de asdf (version manager)
if command -v asdf >/dev/null 2>&1
  source ~/.asdf/asdf.fish
end

# Configuración de nvm
if command -v nvm >/dev/null 2>&1
  nvm use default >/dev/null 2>&1
end

# Configuración de pyenv
if command -v pyenv >/dev/null 2>&1
  pyenv init - | source
end

# Configuración de rbenv
if command -v rbenv >/dev/null 2>&1
  rbenv init - | source
end

# Completions útiles
for tool in kubectl docker helm terraform az
  if command -v $tool >/dev/null 2>&1
    switch $tool
      case kubectl
        kubectl completion fish | source
      case docker
        docker completion fish | source
      case helm
        helm completion fish | source
      case terraform
        terraform -install-autocomplete
      case az
        az completion fish | source
    end
  end
end

# PATH optimizado y rápido
function add_path --argument path
  if test -d $path
    if not contains $path $PATH
      set -gx PATH $path $PATH
    end
  end
end

add_path $HOME/.cargo/bin
add_path $HOME/go/bin
add_path $HOME/flutter/bin
add_path $HOME/.deno/bin
add_path $HOME/.bun/bin
add_path $HOME/.local/share/pnpm
add_path $HOME/.yarn/bin
add_path $HOME/.composer/vendor/bin
add_path $HOME/.local/bin
add_path $HOME/.local/scripts
add_path /usr/local/bin
add_path $HOME/bin
add_path /snap/bin
add_path /var/lib/flatpak/exports/bin
add_path $HOME/.npm-global/bin
