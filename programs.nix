_: {
  imports = [ ./programs/fish.nix ./programs/helix.nix ./programs/ags.nix ];
  programs = {
    kitty.enable = true;
    bat.enable = true;
    eza.enable = true;
    thefuck.enable = true;
    git.enable = true;
    zoxide.enable = true;
    waybar.enable = true;
  };
}
