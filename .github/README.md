# 💻 Anmol's Arch Linux Dotfiles

My personal dotfiles for **Arch Linux**, featuring a dual desktop environment (**GNOME** and **Hyprland** with **Dank Material Shell**), modern terminal emulators, dynamic Matugen/Base16 wallpaper theming, and an opinionated **LazyVim** configuration.

---

## 🎨 System Overview

- **Operating System**: Arch Linux (Linux Zen Kernel)
- **Window Management**: Hyprland (Wayland) & GNOME (Wayland)
- **Desktop Shell & Widgets**: Dank Material Shell (QuickShell) & Libadwaita
- **Editor**: Neovim (LazyVim distribution with hot-reloading dynamic themes)
- **Shells**: Fish (Primary), Zsh, Bash + Starship Prompt & Zoxide
- **Terminals**: Kitty, Ghostty, WezTerm, Alacritty

---

## 📂 Repository Structure

```text
~/.config/
├── hypr/               # Hyprland window rules, monitors, and DMS keybindings
├── nvim/               # LazyVim setup with Base16 dynamic palette watcher
├── kitty/              # Kitty terminal configuration & themes
├── ghostty/            # Ghostty modern GPU-accelerated terminal config
├── wezterm/            # WezTerm Lua configuration & color profiles
├── alacritty/          # Alacritty configuration
├── fish/               # Fish shell aliases, abbreviations, and functions
└── gtk-3.0/, gtk-4.0/  # GTK theme overrides and styling
~/.bashrc, ~/.zshrc     # Secondary shell environments
~/.local/bin/           # Custom synchronization and maintenance scripts
```

---

## ⚙️ Installation & Management

These dotfiles are managed using the **Bare Git Repository** method:

### 1. Clone on a Fresh Machine
```bash
git clone --bare git@github.com:anmolsharma152/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

### 2. Daily Workflow
```bash
# Check status
dotfiles status

# Add and commit changes
dotfiles add ~/.config/kitty/kitty.conf
dotfiles commit -m "style(kitty): update font and padding"
dotfiles push
```
