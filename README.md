# Dotfiles

My personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

*Tested on macOS only.*

## Prerequisites

- **GNU Stow**: Install with `brew install stow`

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/lubieniebieski/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Install all packages:

   ```bash
   make install
   ```

3. Or install specific packages:

   ```bash
   make install nvim
   
   # Install multiple packages
   make install nvim zsh git
   ```

## Local Configuration

The zsh configuration supports a local config file for machine-specific settings:

- Create `~/.zshrc.local` for your personal/local configurations
- This file will be automatically sourced if it exists
- Keeps your dotfiles clean while allowing customization

## Usage

```bash
# Show help and available commands
make help

# List available packages
make list

# Install all packages
make install

# Install specific packages
make install nvim
make install nvim zsh git

# Uninstall all packages
make uninstall

# Uninstall specific packages
make uninstall nvim
make uninstall nvim zsh

# Clean up broken symlinks
make clean
```
