# Dotfiles

My personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

*Tested on macOS only.*

## Prerequisites

- **GNU Stow**: Install with `brew install stow`

## Installation

1. Clone the repository:

   ```bash
   git clone --recurse-submodules https://github.com/lubieniebieski/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. List available packages:

   ```bash
   make list
   ```

3. Install specific packages (recommended):

   ```bash
   make install nvim
   make install zsh
   make install tmux
   # Or install multiple at once
   make install nvim zsh tmux
   ```

## Local Configuration

The zsh configuration supports a local config file for machine-specific settings:

- Create `~/.zshrc.local` for your personal/local configurations
- This file will be automatically sourced if it exists
- Keeps your dotfiles clean while allowing customization

## Tmux Plugin Manager

After installing the tmux package, install tmux plugins:

```bash
# Open tmux and install plugins
tmux
# Press prefix (Ctrl-s) + I to install plugins
```

## Usage

```bash
# Show help and available commands
make help

# List available packages
make list

# Install specific packages (recommended)
make install nvim
make install zsh
make install tmux

# Uninstall specific packages
make uninstall nvim
make uninstall zsh
make uninstall tmux

# Clean up broken symlinks
make clean
```

> **Note:** It's recommended to install only the packages you need (e.g. `make install nvim zsh tmux`). Avoid using `make install` for all packages unless you know you want everything. Use `make list` to see available packages and pick the ones you want.
