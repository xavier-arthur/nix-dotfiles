{ config, pkgs, ... }:

let
    # unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

    unstable = import (builtins.fetchTarball {
       url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
    }) {
        config.allowUnfree = true;
    };

in {
    # pacotes
    environment.systemPackages = [
        # === fonts === In my experience some fonts need to be added to the
        # system packages as well as in fonts.packages, dunno why so I just add
        # them fonts here and in the aforementioned property
        pkgs.kode-mono
        pkgs.monaspace
        pkgs.departure-mono

        # === AI === #
        unstable.claude-code

        # === Development Tools ===
        pkgs.neovim
        pkgs.nodejs_24
        pkgs.deno
        pkgs.git
        pkgs.wine
        pkgs.gitui
        pkgs.gcc
        pkgs.appimage-run
        pkgs.usbmuxd
        pkgs.libimobiledevice
    	pkgs.gnumake
        pkgs.redisinsight
        pkgs.vscode-fhs
        pkgs.texliveMedium
        pkgs.openssl
        unstable.zed-editor-fhs

        # === Lua ===
        pkgs.luarocks
        pkgs.lua

        # === Python ===
        pkgs.python3
        pkgs.python313Packages.pip

        # # === Rust ===
         unstable.rustc
         unstable.cargo
         unstable.rust-analyzer
         # unstable.rustup

        # === PHP ===
        pkgs.php84
        pkgs.php84Packages.composer
        pkgs.intelephense

        # === Nix Language ===
        pkgs.nixd
        pkgs.nil

        # === Terminal/CLI Tools ===
        pkgs.typst
        pkgs.cloudflare-cli
        pkgs.cloudflared
        pkgs.fuse
        pkgs.sshuttle
        pkgs.just
        pkgs.macchina
        pkgs.btop
        pkgs.doctl
        pkgs.nix-output-monitor
        pkgs.tree
        pkgs.ncmpcpp
        pkgs.mpd
        pkgs.termusic
        pkgs.ncmpcpp
        pkgs.dust
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
    	pkgs.jq
        unstable.yt-dlp
        pkgs.ffmpeg
        pkgs.imagemagick
        pkgs.killall
        pkgs.cowsay
        pkgs.lolcat
        pkgs.wmctrl
        pkgs.libwebp

        # === Zsh ===
        pkgs.zsh
        pkgs.oh-my-zsh
        pkgs.zsh-autocomplete
        pkgs.zsh-autosuggestions

        # === GUI Apps ===
        pkgs.telegram-desktop
        pkgs.google-chrome
        pkgs.kdePackages.kdeconnect-kde
        pkgs.firefox
        pkgs.localsend
        pkgs.easyeffects
        pkgs.kdePackages.kdenlive
        pkgs.inkscape
        pkgs.resources
        pkgs.anydesk
        pkgs.filezilla
        pkgs.gimp3
        pkgs.brave
        pkgs.postman
        unstable.dbeaver-bin
        pkgs.obs-studio
        pkgs.discord
        pkgs.flameshot
        pkgs.qbittorrent
        pkgs.fontforge-gtk
        pkgs.vlc
        pkgs.cozy
        pkgs.onlyoffice-desktopeditors
        pkgs.footage
        pkgs.gpick

        # === Gaming ===
        pkgs.gamemode
        pkgs.lutris-unwrapped
        pkgs.steam
        pkgs.protonup-qt
        pkgs.prismlauncher

        # === System Appearance ===
        pkgs.gruvbox-gtk-theme
        pkgs.gnome-tweaks
        pkgs.gnomeExtensions.gsconnect
        pkgs.gnomeExtensions.rounded-corners
        pkgs.gnomeExtensions.blur-my-shell

        # === System Utilities ===
        pkgs.dconf
        pkgs.ctop
        pkgs.bash
        pkgs.freshfetch
        pkgs.pulseaudioFull

        # === Database ===
        pkgs.mariadb
        pkgs.mariadb-embedded

        # === Home Manager ===
        pkgs.home-manager
    ];
}
