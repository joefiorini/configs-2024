{ pkgs, inputs, ... }: {
  stylix = {
    enable = true;
    autoEnable = true;
    image = builtins.toPath "${inputs.resources}/8959459.jpg";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/paraiso.yaml";
    base16Scheme = ./dracula.yaml;
    cursor.package = pkgs.catppuccin-cursors;
    polarity = "dark";
    opacity = { terminal = 0.85; };
    fonts = {
      monospace = with pkgs; {
        name = "Rec Mono Duotone";
        package = recursive-sans;
      };
      sansSerif = with pkgs; {
        name = "Manifold CF";
        package = manifold-cf;
      };
      sizes = {
        applications = 14;
        terminal = 14;
        popups = 12;
      };
    };
    targets = {
      bat.enable = true;
      fzf.enable = true;
      kde.enable = false;
      gnome.enable = false;
      dunst.enable = true;
      kitty.enable = true;
      fish.enable = true;
      hyprland.enable = true;
      rofi.enable = true;
      waybar = {
        enable = true;
        enableLeftBackColors = true;
        enableRightBackColors = true;
        enableCenterBackColors = true;

      };
      helix = { enable = true; };
    };
  };
}
