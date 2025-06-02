{ config, pkgs, ... }:

let
    dotfiles = /home/arthurx/.config/home-manager/nix-dotfiles;
in {
    nixpkgs.config.allowUnfree = true;

    home.username = "arthurx";
    home.homeDirectory = "/home/arthurx";

    programs.git = {
        enable = true;
        userEmail = "garok102gmail.com";
        userName = "Arthur Xavier";
    };

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = [
        pkgs.freshfetch
        pkgs.git
        pkgs.nixd
        pkgs.nil
        pkgs.intelephense
        pkgs.dconf

        pkgs.rustc
        pkgs.intelephense
        pkgs.cargo
        pkgs.rust-analyzer
        pkgs.zed-editor


        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
    ];

    home.file = {
        # zsh
        ".zshrc".source = "${dotfiles}/zsh/zshrc";
        ".zsh_aliases".source = "${dotfiles}/zsh/zsh_aliases";

        # wallpaper gnome
        ".config/background".source = "${dotfiles}/background";

        ".config/zed/settings.json".source = "${dotfiles}/zed/settings.json";
        ".config/zed/keymap.json".source = "${dotfiles}/zed/keymap.json";

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
    };

    dconf.settings = {
        "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            ];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
            name = "terminal";
            command = "alacritty";
            binding = "<Super>T";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
            name = "flameshot";
            command = "flameshot gui";
            binding = "<Shift><Super>S";
        };

        "org/gnome/desktop/background" = {
            picture-uri = "file:///home/arthurx/.config/background";
            picture-uri-dark = "file:///home/arthurx/.config/background";
            # picture-options = "zoom";  # optional: how to scale the wallpaper
        };
    };

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    ## DO NOT CHANGE DO NOT CHANGE
    home.stateVersion = "24.11"; # Please read the comment before changing.
}
