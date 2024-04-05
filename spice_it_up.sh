#!/bin/bash

SCRIPT_DIR=$(pwd)

copy_files_and_create_dirs () {
  cat <<EOF

###################################################
###                                             ###
###       COPYING FILES AND CREATING DIRS       ###
###                                             ###
###################################################

EOF

  mkdir -p $HOME/chamber_of_magic/{junk,test}

  mkdir -p $HOME/Downloads/{Music,Documents,Compressed}

  export GNUPGHOME="$HOME/.local/share/gnupg"
  mkdir -p $GNUPGHOME

  mkdir -p $HOME/.local/share/zsh
  touch $HOME/.local/share/zsh/history

  mkdir -p $HOME/.config/

  cp -r $SCRIPT_DIR/.config/fontconfig $SCRIPT_DIR/.config/git $SCRIPT_DIR/.config/gtk-2.0 $SCRIPT_DIR/.config/gtk-3.0 $SCRIPT_DIR/.config/gtk-4.0 $HOME/.config/
  cp -r $SCRIPT_DIR/.scripts $SCRIPT_DIR/.themes $HOME/
}

install_build_utils () {
  cat <<EOF

###################################################
###                                             ###
###            INSTALLING BUILD UTILS           ###
###                                             ###
###################################################

EOF

  sudo pacman -Syu git git-delta base-devel make qt5-tools qt5-base gcc wget clang
}

install_yay () {
  cat <<EOF

###################################################
###                                             ###
###               INSTALLING YAY                ###
###                                             ###
###################################################

EOF

  sudo git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
  sudo chown -R $(whoami):$(whoami) /opt/yay-git
  cd /opt/yay-git
  makepkg -si
  cd $SCRIPT_DIR
}

install_nodejs () {
  cat <<EOF

###################################################
###                                             ###
###              INSTALLING NODEJS              ###
###                                             ###
###################################################

EOF

  sudo pacman -S nodejs

  sudo corepack enable

  yarn config set init-license GPL-3.0-only -g
  yarn config set init-author-name PlankCipher -g

  yarn global add eslint-cli create-react-app
}

install_misc_dev_stuff () {
  cat <<EOF

###################################################
###                                             ###
###          INSTALLING MISC DEV STUFF          ###
###                                             ###
###################################################

EOF

  sudo pacman -S man-pages man-db

  yay -S python python-pip

  sudo pacman -S docker
  sudo systemctl enable docker

  yay -S insomnia-bin

  sudo pacman -S php composer
  yay -S phpactor
  composer global require friendsofphp/php-cs-fixer
}

install_neovim () {
  cat <<EOF

###################################################
###                                             ###
###              INSTALLING NEOVIM              ###
###                                             ###
###################################################

EOF

  yay -S fzf ripgrep the_silver_searcher fd
  sudo pacman -S aspell aspell-en

  yarn global add vscode-langservers-extracted typescript typescript-language-server emmet-ls prettier @fsouza/prettierd pyright
  sudo pacman -S yapf rustup
  rustup toolchain install stable nightly
  rustup default stable
  rustup component add rust-src
  rustup +nightly component add rust-src
  rustup component add rust-analyzer
  rustup +nightly component add rust-analyzer

  sudo mkdir -p /usr/share/fonts/{OTF,TTF}
  sudo mv $SCRIPT_DIR/font/*.ttf /usr/share/fonts/TTF/

  yay -S neovim-git

  cp -r $SCRIPT_DIR/.config/nvim $HOME/.config/
}

install_et () {
  cat <<EOF

###################################################
###                                             ###
###                INSTALLING ET                ###
###                                             ###
###################################################

EOF

  sudo pacman -S tre sox

  git clone https://github.com/PlankCipher/et.git $HOME/Downloads/et
  cd $HOME/Downloads/et
  ./install.sh
  cd $SCRIPT_DIR
  rm -rf $HOME/Downloads/et
}

install_kabmat () {
  cat <<EOF

###################################################
###                                             ###
###              INSTALLING KABMAT              ###
###                                             ###
###################################################

EOF

  git clone https://github.com/PlankCipher/kabmat.git $HOME/Downloads/kabmat
  cd $HOME/Downloads/kabmat
  make
  sudo make install
  cd $SCRIPT_DIR
  rm -rf $HOME/Downloads/kabmat
}

install_ranger () {
  cat <<EOF

###################################################
###                                             ###
###              INSTALLING RANGER              ###
###                                             ###
###################################################

EOF

  yay -S ranger

  # Install dragon
  git clone https://github.com/mwh/dragon.git $HOME/Downloads/dragon
  cd $HOME/Downloads/dragon/
  sudo make install
  sudo chmod +x dragon
  sudo mv dragon /sbin/dragon
  cd $SCRIPT_DIR
  rm -rf $HOME/Downloads/dragon

  cp -r $SCRIPT_DIR/.config/ranger $HOME/.config/

  # Install ranger_devicons plugin
  git clone https://github.com/alexanderjeurissen/ranger_devicons $HOME/.config/ranger/plugins/ranger_devicons
}

install_mpd () {
  cat <<EOF

###################################################
###                                             ###
###                INSTALLING MPD               ###
###                                             ###
###################################################

EOF

  yay -S mpd mpc

  # Add mpd to required groups
  sudo gpasswd -a mpd $(whoami)
  chmod 710 $HOME/
  sudo gpasswd -a mpd audio

  cp -r $SCRIPT_DIR/.config/mpd $HOME/.config/
}

install_zsh_and_ohmyzsh () {
  cat <<EOF

###################################################
###                                             ###
###         INSTALLING ZSH AND OHMYZSH          ###
###                                             ###
###################################################

EOF

  yay -S zsh

  # Change default shell to ZSH
  chsh -s /usr/bin/zsh

  cp -r $SCRIPT_DIR/.config/zsh $HOME/.config/
  cp $SCRIPT_DIR/zsh/.zprofile $HOME/

  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

  cp $SCRIPT_DIR/zsh/steeef.zsh-theme $HOME/.oh-my-zsh/themes/steeef.zsh-theme

  # Install zsh-autosuggestions plugin
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  # Install zsh-syntax-highlighting plugin
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  # Install colorscripts
  yay -S shell-color-scripts
  xargs -a $SCRIPT_DIR/zsh/blacklisted_colorscripts.txt -I {} sh -c 'colorscript --blacklist {}'
}

install_rofi () {
  cat <<EOF

###################################################
###                                             ###
###               INSTALLING ROFI               ###
###                                             ###
###################################################

EOF

  yay -S rofi-lbonn-wayland-git
  cp -r $SCRIPT_DIR/.config/rofi $HOME/.config/
}

install_hyprland () {
  cat <<EOF

###################################################
###                                             ###
###             INSTALLING HYPRLAND             ###
###                                             ###
###################################################

EOF

  sudo pacman -S pipewire pipewire-pulse wireplumber grim slurp
  systemctl --user enable pipewire pipewire-pulse wireplumber

  yay -S hyprlang hyprland-git xdg-desktop-portal-hyprland-git swaylock-effects swaybg wl-clipboard brightnessctl lxsession-gtk3 xf86-video-amdgpu dunst libnotify qt5-wayland qt6-wayland gnome-themes-extra bibata-cursor-theme swayidle wlrctl-git

  cp -r $SCRIPT_DIR/.config/hypr $SCRIPT_DIR/.config/wallpapers $SCRIPT_DIR/.config/dunst $SCRIPT_DIR/.config/electron-flags.conf $HOME/.config/

  mkdir -p $HOME/.local/share/icons/default
  cp $SCRIPT_DIR/index.theme $HOME/.local/share/icons/default/
  sudo cp $SCRIPT_DIR/index.theme /usr/share/icons/default/

  sudo pacman -S go xdg-utils
  go install go.senan.xyz/cliphist@latest
}

install_eww () {
  cat <<EOF

###################################################
###                                             ###
###                INSTALLING EWW               ###
###                                             ###
###################################################

EOF

  sudo pacman -S gtk3 gtk-layer-shell pango gdk-pixbuf2 cairo glib2 gcc-libs glibc

  git clone https://github.com/elkowar/eww.git $HOME/Downloads/eww
  cd $HOME/Downloads/eww
  cargo build --release --no-default-features --features=wayland
  chmod +x target/release/eww
  sudo cp target/release/eww /sbin/
  cd $SCRIPT_DIR
  rm -rf $HOME/Downloads/eww

  yay -S otf-font-awesome ttf-unifont noto-fonts-emoji sysstat libqalculate bc
  sudo pacman -S vnstat socat jo jq
  sudo systemctl enable vnstat

  cp -r $SCRIPT_DIR/.config/eww $HOME/.config/
}

install_wezterm () {
  cat <<EOF

###################################################
###                                             ###
###              INSTALLING WEZTERM             ###
###                                             ###
###################################################

EOF

  yay -S wezterm-git
  cp -r $SCRIPT_DIR/.config/wezterm $HOME/.config/

  tempfile=$(mktemp)
  curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
  tic -x -o $HOME/.terminfo $tempfile
  rm $tempfile
}

install_other_programs () {
  cat <<EOF

###################################################
###                                             ###
###          INSTALLING OTHER PROGRAMS          ###
###                                             ###
###################################################

EOF

  yay -S pavucontrol mpv zathura zathura-pdf-mupdf brave-bin zip unzip bat freetube-bin imagemagick dell-g5se-fanctl iw imv

  cp -r $SCRIPT_DIR/.config/bat $SCRIPT_DIR/.config/zathura $HOME/.config/
  bat cache --build

  sudo pacman -S thunderbird
}

copy_files_and_create_dirs
install_build_utils
install_yay
install_nodejs
install_misc_dev_stuff
install_neovim
install_et
install_kabmat
install_ranger
install_mpd
install_zsh_and_ohmyzsh
install_rofi
install_hyprland
install_eww
install_wezterm
install_other_programs

cat << EOF
__        __   _                               _                          _
\ \      / /__| | ___ ___  _ __ ___   ___     | |__   ___  _ __ ___   ___| |
 \ \ /\ / / _ \ |/ __/ _ \| '_ \` _ \ / _ \    | '_ \ / _ \| '_ \` _ \ / _ \ |
  \ V  V /  __/ | (_| (_) | | | | | |  __/    | | | | (_) | | | | | |  __/_|
   \_/\_/ \___|_|\___\___/|_| |_| |_|\___|    |_| |_|\___/|_| |_| |_|\___(_)
EOF

exit 0
