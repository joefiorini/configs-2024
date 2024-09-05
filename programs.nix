{ lib, pkgs, ... }: {
  imports = [
    ./programs/fish.nix
    ./programs/helix.nix
    ./programs/direnv.nix
    ./programs/kitty.nix
    ./programs/git.nix
    ./programs/aerospace.nix
    ./programs/jj.nix
  ];
  programs = {
    bat.enable = true;
    # eza.enable = true;
    thefuck.enable = true;
    git.enable = true;
    dircolors.enable = true;
    dircolors.extraConfig = lib.readFile ./dracula.dircolors;
    gh.enable = true;
    gh.extensions = with pkgs; [ gh-copilot gh-poi ];
    lsd.enable = true;
    lsd.enableAliases = true;
    zoxide.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    # waybar.enable = true;
  };
}
