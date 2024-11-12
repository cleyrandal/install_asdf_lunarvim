#!/bin/bash

# Function to install packages for Arch-based systems
install_arch() {
  echo "Installing packages for Arch-based systems..."
  sudo pacman -S --needed base-devel
  sudo pacman -S --needed openssl
  sudo pacman -S --needed zlib
  sudo pacman -S --needed xz
  sudo pacman -S --needed tk
  sudo pacman -S --needed python-pip
  sudo pacman -S --needed xclip
  sudo pacman -S --needed powerline-fonts
  sudo pacman -S --needed awesome-terminal-fonts
  sudo pacman -S --needed ttf-nerd-fonts-symbols
  sudo pacman -S --needed ranger
}

# Function to install packages for Ubuntu-based systems
install_ubuntu() {
  echo "Installing packages for Ubuntu-based systems..."
  sudo apt update
  sudo apt install -y build-essential
  sudo apt install -y libssl-dev zlib1g-dev xz-utils tk-dev python3-pip xclip
  sudo apt install -y fonts-powerline fonts-noto-color-emoji
  sudo apt install -y fonts-nerd-fonts-symbols
  sudo apt install -y ranger
}

install_others() {
  echo "Installing asdf with:"
  echo "- python"
  echo "- nodejs"
  echo "- rust"
  echo "- pipx"
  echo "- poetry"
  echo "- ripgrep"
  echo "- neovim"

  # Install asdf
  cd /tmp
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

  # Append asdf initialization to .bashrc
  {
    echo ''
    echo '# asdf-config['
    echo '. "$HOME/.asdf/asdf.sh"'
    echo '. "$HOME/.asdf/completions/asdf.bash"'
    echo '# asdf-config]'
  } >> ~/.bashrc
  source ~/.bashrc

  echo "asdf installed successfully."

  # python
  asdf plugin-add python
  asdf install python stable
  asdf global python system

  # nodejs
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf install nodejs latest
  asdf global nodejs latest
  npm i -g npm
  asdf reshim nodejs

  # rust
  asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
  asdf install rust stable
  asdf global rust stable

  # pipx
  asdf plugin add pipx https://github.com/yozachar/asdf-pipx.git
  asdf install pipx latest
  asdf global pipx latest

  # poetry
  asdf plugin-add poetry https://github.com/asdf-community/asdf-poetry.git
  asdf install poetry latest
  asdf global poetry latest

  # ripgrep
  asdf plugin add ripgrep
  asdf install ripgrep latest
  asdf global ripgrep latest

  # neovim
  asdf plugin add neovim
  asdf install neovim stable
  asdf global neovim stable

  # reshim (recreate shims)
  asdf reshim

  # Checking all the versions of the necessary dependencies.
  #git --version; make --version|grep Make; pip --version; python -V; npm --version; node --version; cargo --version; rg -V; nvim -v

  # LunarVim
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

  # From here, answer [y]es to all questions.

  # replace config.lua
  mv ~/.config/lvim/config.lua ~/.config/lvim/config.lua.bkp
  ln -vs "$(pwd)/config.lua" ~/.config/lvim/

  # Install Starship
  curl -sS https://starship.rs/install.sh | sh
  
  # Configure Starship in .bashrc
  {
    echo ''
    echo '# starship-config['
    echo 'eval "$(starship init bash)"'
    starship preset nerd-font-symbols -o ~/.config/starship.toml  # basic configuration
    echo '# starship-config]'
  } >> ~/.bashrc
  source ~/.bashrc
  
  echo "Starship installed successfully."
}

# Detect the OS and call the appropriate function based on ID_LIKE
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  if [[ "$ID_LIKE" == "ubuntu" ]]; then
      install_ubuntu
      install_others
  elif [[ "$ID_LIKE" == "arch" ]]; then
      install_arch
      install_others
  else
      echo "Unsupported Linux distribution: $ID_LIKE"
      exit 1
  fi
else
  echo "The /etc/os-release file does not exist."
  exit 1
fi

echo "Installation completed."
