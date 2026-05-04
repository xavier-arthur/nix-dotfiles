# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
    dotfiles = "/home/arthurx/.config/dotfiles/nix";
    # linkDotfiles = pkgs.writeShellScriptBin "link-dotfiles" (builtins.readFile ./nix/activation_scripts/link_dotfiles.sh);
    unstable = import (builtins.fetchTarball {
       url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
    }) {
        config.allowUnfree = true;
    };
in {
    imports = [
        /etc/nixos/hardware-configuration.nix
        ./packages.nix
        <home-manager/nixos>
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    networking.hostName = "nixos"; # Define your hostname.

    nix.settings.trusted-substituters = [ "https://cache.nixos.org/" ];

    boot.tmp.cleanOnBoot = true;

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "pt_BR.UTF-8";
        LC_IDENTIFICATION = "pt_BR.UTF-8";
        LC_MEASUREMENT = "pt_BR.UTF-8";
        LC_MONETARY = "pt_BR.UTF-8";
        LC_NAME = "pt_BR.UTF-8";
        LC_NUMERIC = "pt_BR.UTF-8";
        LC_PAPER = "pt_BR.UTF-8";
        LC_TELEPHONE = "pt_BR.UTF-8";
        LC_TIME = "pt_BR.UTF-8";
    };

    services.timesyncd.enable = true;

    services.atd.enable = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
        # layout = "us";
        layout = "us,br,ru";
        variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.arthurx = {
        isNormalUser = true;
        description = "Arthur Xavier";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        shell = pkgs.zsh;

        # packages = with pkgs; [
        #  thunderbird
        # ];
    };

    # docker!!!
    virtualisation.docker = {
        enable = true;

        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };

    programs.steam = {
        enable = true;
        extraCompatPackages = [
            # unstable.pkgs.pro
            unstable.proton-ge-bin
        ];
    };

    programs.gamemode = {
        enable = true;
    };

    programs.nix-ld.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;

        autosuggestions = {
            enable = true;
            highlightStyle = "fg=#d79921,bg=#1d2021,bold,underline";
            strategy = ["history"];
        };


        syntaxHighlighting = {
            enable = true;
        };

        enableLsColors = true;

        ohMyZsh = {
            enable = true;
            # theme = "afowler";
        };
    };

    programs.tmux = {
        package = pkgs.tmux;
        enable = true;

        plugins = [
            pkgs.tmuxPlugins.gruvbox
        ];
    };

    security.sudo.wheelNeedsPassword = false;

    environment.pathsToLink = [ "/share/zsh" ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    fonts.packages = [
        pkgs.ibm-plex
        pkgs.departure-mono
        pkgs.kode-mono
        pkgs.victor-mono
        pkgs.monaspace
        pkgs.pixel-code
    ];

    home-manager.users.arthurx = {config, pkgs, ...}: {
        nixpkgs.config.allowUnfree = true;

        home.username = "arthurx";
        home.homeDirectory = "/home/arthurx";

        programs.zsh.enable = true;
        programs.bash.enable = true;
        targets.genericLinux.enable = true;

        programs.git = {
            enable = true;
            userEmail = "garok102@gmail.com";
            userName = "Arthur Xavier";

            extraConfig = {
                credential.helper = "";
            };
        };

        programs.starship = {
            enable = true;
            enableZshIntegration = true;
        };

        programs.rofi = {
            enable = true;

            terminal = "${pkgs.alacritty}/bin/alacritty";
            location = "center";

            theme = "${dotfiles}/rofi/gruvbox-material.rasi";

            modes = [
                "window"
                "run"
                "ssh"
                "drun"
                "combi"
                "keys"
                "filebrowser"
                "calc"
                "emoji"
            ];

            plugins = [
                pkgs.rofi-calc
                pkgs.rofi-emoji
            ];

            font = "${pkgs.pixel-code}/otf/PixelCode.otf";
        };

        # os pacotes instalados aqui nao parecem ter uma boa integracao com
        # gnome, nesse momento estou preferindo instalar como root
        home.packages = [ ];

        home.file = {
            # zsh
            ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${toString dotfiles}/zsh/zshrc";
            ".zsh_aliases".source = config.lib.file.mkOutOfStoreSymlink "${toString dotfiles}/zsh/zsh_aliases";

            # wallpaper gnome
            ".config/background".source = config.lib.file.mkOutOfStoreSymlink "${toString dotfiles}/background";

            # zed
            ".config/zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${toString dotfiles}/zed/settings.json";
            ".config/zed/keymap.json".source = config.lib.file.mkOutOfStoreSymlink "${toString dotfiles}/zed/keymap.json";

            # fontes
            ".local/share/fonts/PixelCodeLigatureLessRegular.otf".source = config.lib.file.mkOutOfStoreSymlink "${toString dotfiles}/fonts/PixelCodeLigatureLess-Regular.otf";
            ".local/share/fonts/PixelCodeLigatureLessRegularItalic.otf".source = config.lib.file.mkOutOfStoreSymlink "${toString dotfiles}/fonts/PixelCodeLigatureLess-RegularItalic.otf";

            # alacritty
            ".config/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "${toString dotfiles}/alacritty/alacritty.toml";

            # starship
            ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${toString dotfiles}/starship/starship.toml";

            # tmux
            "${config.home.homeDirectory}/.tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/nix/tmux/tmux.conf";

            # ~/settings
            "settings".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles";
        };

        dconf.settings = {
            "org/gnome/desktop/wm/keybindings" = {
                "show-desktop" = ["<Super>D"];
                "move-to-monitor-left" = ["<Super><Shift>H"];
                "move-to-monitor-right" = ["<Super><Shift>L"];
            };

            "org/gnome/settings-daemon/plugins/media-keys" = {
                custom-keybindings = [
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
                ];
            };

            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
                name = "flameshot";
                command = "flameshot gui";
                binding = "<Shift><Super>S";
            };

            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
                name = "alacritty";
                command = "${config.home.homeDirectory}/.config/dotfiles/nix/scripts/alacritty_focus_or_launch.sh";
                binding = "<Super>T";
            };

            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
                name = "emoji";
                command = "rofi -show emoji";
                binding = "<Super>N";
            };

            "org/gnome/desktop/background" = {
                picture-uri = "file:///home/arthurx/.config/background";
                picture-uri-dark = "file:///home/arthurx/.config/background";
                # picture-options = "zoom";  # optional: how to scale the wallpaper
            };

        };

        home.sessionVariables = {
        };

        ## DO NOT CHANGE DO NOT CHANGE
        home.stateVersion = "24.11"; # Please read the comment before changing.
    };

    environment.etc."mariadb".source = "${pkgs.mariadb}/bin";

    # coloca um link simbolico do bash em /bin/bash
    system.activationScripts.text = ''
        ln -sf ${pkgs.bash}/bin/bash /bin/bash
        ln -sf ${pkgs.bash}/bin/bash /usr/bin/bash

        ln -sf ${pkgs.rust-analyzer}/bin/rust-analyzer /bin/rust-analyzer
        ln -sf ${pkgs.rust-analyzer}/bin/rust-analyzer /usr/bin/rust-analyzer
    '';


    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
    services.usbmuxd.enable =  true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?
}
