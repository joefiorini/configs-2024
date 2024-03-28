_: {
  polarity = "dark";
  image = ./wall0.png;
  opacity = { terminal = 0.85; };
  targets = {
    kde.enable = false;
    gnome.enable = false;
    dunst.enable = true;
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
}
