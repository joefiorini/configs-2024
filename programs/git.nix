_: {
  programs.git = {
    enable = true;
    userEmail = "joe@joefiorini.com";
    userName = "Joe Fiorini";
    delta = {
      enable = true;
      options = {
        navigate = true;
        features = "line-numbers decorations";
        zero-style = "dim syntax";
        dark = true;
      };
    };
    aliases = {
      list-conflicts = "diff --name-only --diff-filter=U --relative";
      recommit = "commit -C HEAD --amend";
      ra =
        "log --format='%C(yellow)%h%Creset%Cgreen%d%Creset, %s %Cblue%ar by %an%Creset' --graph -15";
      root = "rev-parse --show-toplevel";
      rcm = "commit --amend -m";
      dc = "diff --cached";
    };
    extraConfig = {
      rebase.autostash = true;
      pull.rebase = true;
      push = { autoSetupRemote = true; };
      init.defaultBranch = "main";
      gpg = {
        "ssh" = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        };
        format = "ssh";
      };
    };
    signing = {
      key =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJeonU8OgZwcNSyqTJIgKK+u91A3Hddf6Fv4JjxsVSRp";
      signByDefault = true;
    };
  };
}
