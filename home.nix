{ pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "joefiorini";
  home.homeDirectory = "/Users/joefiorini";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    # btrfs-assistant
    # btrfs-heatmap
    # btrfs-progs
    # btrfs-snap
    # cliphist
    # devbox
    cachix
    fd
    fzf
    # gamescope
    fastfetch
    obsidian
    spotify
    # hyprland-autoname-workspaces
    # kdePackages.koko
    # kooha
    inputs.jj.packages.${pkgs.system}.default
    just
    # oculante
    ripgrep-all
    # rustdesk
    # rustdesk-server
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    # ".config/helix/config.toml".source = helix/config.toml;
    # ".config/helix/languages.toml".source = helix/languages.toml;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/joe/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "hx"; # Helix
  };

  home.sessionPath = [ "/opt/homebrew/bin" ];

  home.shellAliases = { ssh = "kitten ssh"; };
  imports = [ ./stylix.nix ./programs.nix ];

  # stylix = import ./stylix.nix { pkgs = pkgs; };
  #  wayland.windowManager.hyprland =
  #    import ./programs/hyprland.nix { pkgs = pkgs; };

  nixpkgs.config.allowUnfreePredicate = _: true;

  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
  #             "libsciter-4.4.8.23-bis"
  #           ];
}
