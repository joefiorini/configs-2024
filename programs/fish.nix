{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellInit = ''
      fish_add_path --prepend /opt/homebrew/bin

      if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
      end

      if test -d (brew --prefix)"/share/fish/vendor_completions.d"
          set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
      end

      set -x DEVBOX_COREPACK_ENABLED 1
    '';
    plugins = with pkgs.fishPlugins; [
      {
        name = "nix-env.fish";
        src = pkgs.fetchFromGitHub {

          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
        };
      }
      {
        name = "foreign-env";
        src = foreign-env.src;
      }
      {
        name = "fzf";
        src = fzf-fish.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
      {
        name = "tide";
        src = tide.src;
      }
      {
        name = "sponge";
        src = sponge.src;
      }
      {
        name = "done";
        src = done.src;
      }
    ];
  };
}
