{ config, ... }:
let cfg = config.roles.titan;
in {
  options.roles.titan = {
    enable = mkEnableOption "important dependencies for titan development";
  };

  config = mkIf cfg.enable {
    homebrew = {
      enable = true;
      taps = [{
        name = "microsoft/mssql-release";
        clone_target = "https://github.com/Microsoft/homebrew-mssql-release";
      }];

      brews = [
        "curl"
        "mssql-tools"
        "msodbcsql17"
        "mono-libgdiplus"
        "p7zip"
        "podman"
        "podman-compose"
      ];
    };
  };
}
