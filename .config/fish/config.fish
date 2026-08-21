# Location of config file: ~/.config/fish/config.fish

# Random theme each session (optional)

# Initialize Oh My Posh with that theme
##oh-my-posh init fish --config $random_theme | source

# Suppress the welcome message
set -U fish_greeting ""

# ==========================================
# FILE OPERATIONS & NAVIGATION (Native Fish Abbreviations)
# ==========================================
abbr -a cp 'cp -i'
abbr -a mv 'mv -i'
abbr -a rm 'rm -i'
abbr -a mkdir 'mkdir -p'
abbr -a tree 'tree -CAhF --dirsfirst'

# Proton VPN Shorthands
abbr -a vpn-on 'protonvpn connect'
abbr -a vpn-off 'protonvpn disconnect'
abbr -a vpn-stat 'protonvpn status'

# ==========================================
# UTILITIES & CLEANUP
# ==========================================
abbr -a openports 'sudo ss -tulpn'

# Translated docker-clean from Bash
function docker-clean --description 'Clean unused Docker resources'
    docker container prune -f
    docker image prune -f
    docker network prune -f
    docker volume prune -f
end

# ==========================================
# GIT ABBREVIATIONS
# ==========================================
abbr -a g git
abbr -a gs 'git status'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gcm 'git commit -m'
abbr -a gps 'git push'
abbr -a gpl 'git pull'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gd 'git diff'

# Check if the shell is interactive (prevents running in scripts)
if status is-interactive
    # Run Fastfetch with your custom config
    #fastfetch --config ~/.config/fastfetch/config-pokemon.jsonc
    #fastfetch
    #fm6000
    #citch
    #paleofetch
    #nerdfetch
    #pokemon-colorscripts -r
    #pokemon-colorscripts -r --no-title
    #pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -
    #fortune | cowsay | lolcat
    #figlet "Hello, Anmol" | lolcat
    #fortune | cowsay -f tux | lolcat
    #toilet "Hello Anmol" | lolcat
    #afetch
    #pfetch
    #colorscript -e ghosts
    #colorscript -e elfman
    #colorscript -r
    #zs
end

# Lazy Load Conda
function conda --description 'Lazy load Conda'
    # Remove this fake function
    functions --erase conda

    # Run the real Conda initialization
    if test -f /home/anmol/miniconda3/bin/conda
        eval /home/anmol/miniconda3/bin/conda "shell.fish" hook $argv | source
    else
        if test -f "/home/anmol/miniconda3/etc/fish/conf.d/conda.fish"
            . "/home/anmol/miniconda3/etc/fish/conf.d/conda.fish"
        else
            set -x PATH /home/anmol/miniconda3/bin $PATH
        end
    end

    # Execute the command you originally typed
    conda $argv
end

# Enable starship prompt
starship init fish | source

# Enable zoxide utility
zoxide init fish | source

fish_add_path ~/.cargo/bin
fish_add_path $HOME/.local/share/go/bin

# Added by Antigravity CLI installer
set -gx PATH "/home/anmol/.local/bin" $PATH

abbr -a antigravity-cli agy

set -gx PGHOST 127.0.0.1
set -gx PGUSER postgres
set -gx PGPASSWORD P8x_mK9_vQ2L_zW5nJ7rT3aF6bY4cE1u
