# Fish config - Dracula, rápido y genial

# Tema Dracula para Fish (requiere Oh My Fish)
if not omf theme | grep -q dracula
  omf install dracula
end

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
alias ports='ss -tulanp'
alias meminfo='free -h | grep "Mem" | awk "{print \"Memoria: \" \$3 \" / \" \$2 \" (\" \$3/\$2*100.0 \"%)\"}"'
alias cpuinfo='top -bn1 | grep "Cpu(s)" | awk "{print \"CPU: \" \$2 \"%\"}"'

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
  git commit -m "Backup: (date '+%Y-%m-%d %H:%M:%S')"
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

# Plugins útiles con OMF
for plugin in fzf z nvm pyenv
  if not omf list | grep -q $plugin
    omf install $plugin
  end
end

# Configuración de fzf con colores Dracula
set -g FZF_DEFAULT_OPTS '--color=bg:#282a36,fg:#f8f8f2,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#ff79c6,info:#8be9fd,prompt:#50fa7b,pointer:#ff79c6,marker:#bd93f9,spinner:#ffb86c,header:#6272a4 --height 40% --layout=reverse --border'
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

# Mensaje de bienvenida con color
set_color --bold magenta
echo "🐟 Fish configurado con Dracula y turbo! 🚀"
set_color