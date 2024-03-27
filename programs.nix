{ pkgs }: {
  fish = import ./programs/fish.nix {pkgs = pkgs;};
  helix = import ./programs/helix.nix {};
  kitty.enable = true; bat.enable =true; eza.enable = true; thefuck.enable = true; git.enable = true; zoxide.enable = true;
  waybar.enable = true;
} 
