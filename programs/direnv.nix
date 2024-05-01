_: {
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
    config = {
      load_dotenv = true;
      strict_env = true;
    };
  };
}
