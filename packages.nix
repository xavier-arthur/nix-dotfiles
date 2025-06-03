{ config, pkgs, ... }:
{
    # pacotes
    environment.systemPackages = [
        # === Development Tools ===
        pkgs.neovim
        pkgs.nodejs_24
        pkgs.git
        pkgs.gitui
        pkgs.gcc
        pkgs.zed-editor

        # === Python ===
        pkgs.python3
        pkgs.python313Packages.pip

        # === Rust ===
        pkgs.rustc
        pkgs.cargo
        pkgs.rust-analyzer

        # === PHP ===
        pkgs.php84
        pkgs.php84Packages.composer
        pkgs.intelephense

        # === Nix Language ===
        pkgs.nixd
        pkgs.nil

        # === Terminal Tools ===
        pkgs.alacritty
        pkgs.eza
        pkgs.fzf
        pkgs.ripgrep
        pkgs.bat
        pkgs.fd
        pkgs.pv
        pkgs.curl
        pkgs.wget
        pkgs.rsync
        pkgs.tmux
        pkgs.xclip
        pkgs.file

        # === Zsh ===
        pkgs.zsh
        pkgs.oh-my-zsh
        pkgs.zsh-autocomplete
        pkgs.zsh-autosuggestions

        # === GUI Apps ===
        pkgs.gimp3
        pkgs.brave
        pkgs.postman
        pkgs.dbeaver-bin
        pkgs.obs-studio
        pkgs.discord
        pkgs.flameshot
        pkgs.qbittorrent
        pkgs.megasync
        pkgs.fontforge-gtk

        # === Gaming ===
        pkgs.lutris-unwrapped
        pkgs.steam
        pkgs.prismlauncher

        # === System Appearance ===
        pkgs.gruvbox-gtk-theme
        pkgs.gnome-tweaks
        pkgs.gnomeExtensions.rounded-corners
        pkgs.gnomeExtensions.blur-my-shell

        # === System Utilities ===
        pkgs.dconf
        pkgs.ctop
        pkgs.bash
        pkgs.freshfetch

        # === Database ===
        pkgs.mariadb

        # === Home Manager ===
        pkgs.home-manager
    ];
}
