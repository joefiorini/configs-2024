{ inputs, ... }:
let
  std = inputs.nix-std.lib;
  move-to-workspace = ws: app: {
    "if" = { app-id = app; };
    run = "move-node-to-workspace ${ws}";
  };
  floatingApps = builtins.map (app: ({
    "if" = { app-id = app; };
    run = "layout floating";
  }));
  config = {
    start-at-login = true;
    mode.main.binding = {
      "alt-slash" = "layout tiles horizontal vertical";
      "alt-shift-backslash" = "layout accordion horizontal vertical";
    };
    workspace-to-monitor-force-assignment = {
      C = "WQHD";
      S = "WQHD";
      W = "Ultra";
      A = "built-in";
      R = "Ultra";
      "3" = "Ultra";
    };
    on-window-detected = builtins.concatLists [
      (floatingApps [
        "com.apple.systempreferences"
        "com.apple.finder"
        "com.apple.freeform"
        "com.apple.QuickTimePlayerX"
        "com.1password.1password"
        "com.apple.calculator"
        "com.apple.iCal"
        "com.hegenberg.BetterTouchTool"
      ])
      [
        (move-to-workspace "S" "com.apple.MobileSMS")
        (move-to-workspace "S" "com.spotify.client")
        (move-to-workspace "C" "com.apple.mail")
        (move-to-workspace "C" "com.tinyspeck.slackmacgap")
        (move-to-workspace "R" "md.obsidian")
        (move-to-workspace "3" "com.softfever3d.orca-slicer")
      ]
    ];
  };
in {
  xdg.configFile."aerospace/aerospace.toml" = {
    enable = true;
    text = std.serde.toTOML config;
  };
}
