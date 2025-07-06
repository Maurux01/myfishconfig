# Fish config - Enhanced version
set -g theme_nerd_fonts yes
set -g fish_greeting "🐟 Welcome to your awesome Arch setup!"

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

# Configuración de aplicaciones
alias nv='nvim'
alias vim='nvim'
alias vi='nvim'
alias e='eww'
alias h='hyprctl'

# Nuevos aliases geniales
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
alias myip='curl -s https://ipinfo.io/ip'
alias ports='ss -tulanp'
alias meminfo='free -h | grep "Mem" | awk "{print \"Memoria: \" \$3 \" / \" \$2 \" (\" \$3/\$2*100.0 \"%)\"}"'
alias cpuinfo='top -bn1 | grep "Cpu(s)" | awk "{print \"CPU: \" \$2 \"%\"}"'

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
  cp $argv[1] $argv[1].backup.$(date +%Y%m%d_%H%M%S)
  echo "✅ Backup creado: $argv[1].backup.$(date +%Y%m%d_%H%M%S)"
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

# Instalar plugins geniales
if not omf list | grep -q fzf
  omf install fzf
end

if not omf list | grep -q z
  omf install z
end

if not omf list | grep -q nvm
  omf install nvm
end

if not omf list | grep -q pyenv
  omf install pyenv
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

# Configuración de kubectl
if command -v kubectl >/dev/null 2>&1
  kubectl completion fish | source
end

# Configuración de docker
if command -v docker >/dev/null 2>&1
  docker completion fish | source
end

# Configuración de helm
if command -v helm >/dev/null 2>&1
  helm completion fish | source
end

# Configuración de terraform
if command -v terraform >/dev/null 2>&1
  terraform -install-autocomplete
end

# Configuración de aws cli
if command -v aws >/dev/null 2>&1
  aws configure list-profiles | grep -q default && aws configure list
end

# Configuración de gcloud
if command -v gcloud >/dev/null 2>&1
  gcloud config list
end

# Configuración de azure cli
if command -v az >/dev/null 2>&1
  az completion fish | source
end

# Configuración de rust
if command -v rustc >/dev/null 2>&1
  set -gx PATH $HOME/.cargo/bin $PATH
end

# Configuración de go
if command -v go >/dev/null 2>&1
  set -gx GOPATH $HOME/go
  set -gx PATH $GOPATH/bin $PATH
end

# Configuración de flutter
if command -v flutter >/dev/null 2>&1
  set -gx PATH $HOME/flutter/bin $PATH
end

# Configuración de deno
if command -v deno >/dev/null 2>&1
  set -gx DENO_INSTALL $HOME/.deno
  set -gx PATH $DENO_INSTALL/bin $PATH
end

# Configuración de bun
if command -v bun >/dev/null 2>&1
  set -gx BUN_INSTALL $HOME/.bun
  set -gx PATH $BUN_INSTALL/bin $PATH
end

# Configuración de pnpm
if command -v pnpm >/dev/null 2>&1
  set -gx PNPM_HOME $HOME/.local/share/pnpm
  set -gx PATH $PNPM_HOME $PATH
end

# Configuración de yarn
if command -v yarn >/dev/null 2>&1
  set -gx PATH $HOME/.yarn/bin $PATH
end

# Configuración de composer
if command -v composer >/dev/null 2>&1
  set -gx PATH $HOME/.composer/vendor/bin $PATH
end

# Configuración de pip
if command -v pip >/dev/null 2>&1
  set -gx PATH $HOME/.local/bin $PATH
end

# Configuración de gem
if command -v gem >/dev/null 2>&1
  set -gx PATH $HOME/.gem/ruby/*/bin $PATH
end

# Configuración de npm
if command -v npm >/dev/null 2>&1
  set -gx PATH $HOME/.npm-global/bin $PATH
end

# Configuración de snap
if command -v snap >/dev/null 2>&1
  set -gx PATH /snap/bin $PATH
end

# Configuración de flatpak
if command -v flatpak >/dev/null 2>&1
  set -gx PATH /var/lib/flatpak/exports/bin $PATH
end

# Configuración de appimage
if test -d $HOME/.local/bin
  set -gx PATH $HOME/.local/bin $PATH
end

# Configuración de scripts locales
if test -d $HOME/.local/scripts
  set -gx PATH $HOME/.local/scripts $PATH
end

# Configuración de binarios locales
if test -d $HOME/.local/bin
  set -gx PATH $HOME/.local/bin $PATH
end

# Configuración de binarios del sistema
if test -d /usr/local/bin
  set -gx PATH /usr/local/bin $PATH
end

# Configuración de binarios del usuario
if test -d $HOME/bin
  set -gx PATH $HOME/bin $PATH
end

# Configuración de binarios de snap
if test -d /snap/bin
  set -gx PATH /snap/bin $PATH
end

# Configuración de binarios de flatpak
if test -d /var/lib/flatpak/exports/bin
  set -gx PATH /var/lib/flatpak/exports/bin $PATH
end

# Configuración de binarios de appimage
if test -d $HOME/.local/bin
  set -gx PATH $HOME/.local/bin $PATH
end

# Configuración de binarios de scripts
if test -d $HOME/.local/scripts
  set -gx PATH $HOME/.local/scripts $PATH
end

# Configuración de binarios de cargo
if test -d $HOME/.cargo/bin
  set -gx PATH $HOME/.cargo/bin $PATH
end

# Configuración de binarios de go
if test -d $HOME/go/bin
  set -gx PATH $HOME/go/bin $PATH
end

# Configuración de binarios de flutter
if test -d $HOME/flutter/bin
  set -gx PATH $HOME/flutter/bin $PATH
end

# Configuración de binarios de deno
if test -d $HOME/.deno/bin
  set -gx PATH $HOME/.deno/bin $PATH
end

# Configuración de binarios de bun
if test -d $HOME/.bun/bin
  set -gx PATH $HOME/.bun/bin $PATH
end

# Configuración de binarios de pnpm
if test -d $HOME/.local/share/pnpm
  set -gx PATH $HOME/.local/share/pnpm $PATH
end

# Configuración de binarios de yarn
if test -d $HOME/.yarn/bin
  set -gx PATH $HOME/.yarn/bin $PATH
end

# Configuración de binarios de composer
if test -d $HOME/.composer/vendor/bin
  set -gx PATH $HOME/.composer/vendor/bin $PATH
end

# Configuración de binarios de pip
if test -d $HOME/.local/bin
  set -gx PATH $HOME/.local/bin $PATH
end

# Configuración de binarios de gem
if test -d $HOME/.gem/ruby/*/bin
  set -gx PATH $HOME/.gem/ruby/*/bin $PATH
end

# Configuración de binarios de npm
if test -d $HOME/.npm-global/bin
  set -gx PATH $HOME/.npm-global/bin $PATH
end

echo "🐟 Fish configurado con éxito! 🚀" 