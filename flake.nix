{
  description = "Example Darwin system flake";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    resources = {
      url = "git+ssh://git@github.com/joefiorini/configs-private";
      flake = false;
    };
    nix.url = "https://flakehub.com/f/DeterminateSystems/nix/2.0";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.base16-helix.follows = "base16-helix";
    };
    nil.url = "github:oxalica/nil";
    # hyprland.url = "github:hyprwm/Hyprland";
    # ags.url = "github:Aylur/ags";
    #  launch Nix-installed apps using only your keyboard, using ⌘ space
    mac-app-util.url = "github:hraban/mac-app-util";
    base16-helix = {
      url = "github:joefiorini/base16-helix";
      flake = false;
    };
    helix.url = "github:helix-editor/helix/24.07";
    nix-std.url = "github:chessai/nix-std";
    jj.url = "github:bnjmnt4n/jj/ssh-openssh";
  };

  outputs = { self, resources, nix, nix-darwin, home-manager, stylix
    , mac-app-util, helix, jj, ... }@inputs:
    let
      configuration = { pkgs, ... }:
        let homeDir = "/Users/joefiorini";
        in {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [ pkgs.vim pkgs.coreutils ];
          environment.systemPath = [ "/opt/homebrew/bin" ];
          environment.loginShell = "${pkgs.fish}/bin/fish";
          environment.variables.SHELL = "${pkgs.fish}/bin/fish";
          environment.shells = [ pkgs.fish ];

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          # nix.package = pkgs.nix;

          # Necessary for using flakes on this system.
          # nix.settings.experimental-features = "nix-command flakes";

          # Create /etc/zshrc that loads the nix-darwin environment.
          # programs.zsh.enable = true; # default shell on catalina
          programs = {
            fish.enable = true;
            nix-index.enable = true;
          };

          homebrew = {
            enable = true;

            casks = [ "notion-enhanced" "notion-calendar" "notion" ];

          };

          imports = [
            (builtins.toPath "${stylix}/stylix/opacity.nix")
            ./modules/titan.nix
          ];
          fonts = {
            packages = with pkgs; [
              material-design-icons
              font-awesome
              source-sans
              source-serif
              # larabiefont
              # cartograph-cf
              # manifold-cf
              recursive-sans
            ];
          };

          stylix = {
            enable = true;
            image = "${resources}/8959459.jpg";
          };
          services = {
            yabai = {
              enable = false;
              package = pkgs.yabai;
              enableScriptingAddition = true;
              config = {
                focus_follows_mouse = "autofocus";
                mouse_follows_focus = "off";
                window_placement = "second_child";
                window_topmost = "off";
                window_opacity = "off";
                window_border = "off";

              };
              extraConfig = builtins.readFile ./programs/yabairc;
            };
            skhd = {
              enable = false;
              package = pkgs.skhd;
              skhdConfig = builtins.readFile ./programs/skhdrc;
            };
            sketchybar.enable = false;

            jankyborders = {
              enable = false;
              package = pkgs.jankyborders;
              width = 5.0;
              active_color =
                "gradient(top_left=0xffDDB6F2,bottom_right=0xff96CDFB)";
              inactive_color =
                "gradient(top_right=0x9992B3F5,bottom_left=0x9992B3F5)";
              hidpi = true;
              ax_focus = true;
            };
          };

          # custom log path for debugging
          launchd.user.agents.yabai.serviceConfig = {
            StandardErrorPath = "${homeDir}/Library/Logs/yabai.stderr.log";
            StandardOutPath = "${homeDir}/Library/Logs/yabai.stdout.log";
          };

          # custom log path for debugging
          launchd.user.agents.skhd.serviceConfig = {
            StandardErrorPath = "${homeDir}/Library/Logs/skhd.stderr.log";
            StandardOutPath = "${homeDir}/Library/Logs/skhd.stdout.log";
          };

          security.pam.enableSudoTouchIdAuth = true;

          system = {
            activationScripts.postUserActivation.text = ''
              # activateSettings -u will reload the settings from the database and apply them to the current session,
              # so we do not need to logout and login again to make the changes take effect.
              /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
              # restart dock
              killall Dock
            '';

            # Add ability to used TouchID for sudo authentication

            defaults = {
              menuExtraClock = { Show24Hour = true; };
              screencapture = { location = "/Users/joefiorini/Screenshots"; };
              spaces = { };
              dock = {
                autohide = true;
                show-recents = false;
                mru-spaces = false;
                # spans-displays = true;
                # expose-group-apps = true;
              };
              finder = {
                _FXShowPosixPathInTitle = true;
                AppleShowAllExtensions = true;
                FXEnableExtensionChangeWarning = false;
                QuitMenuItem = true;
                ShowPathbar = true;
                ShowStatusBar = true;
              };
              trackpad = {
                Clicking = true;
                Dragging = true;
                TrackpadRightClick = true;
              };
              NSGlobalDomain = {

                NSWindowShouldDragOnGesture = true;
                AppleKeyboardUIMode = 3;
                ApplePressAndHoldEnabled = false;
                InitialKeyRepeat = 15;
                KeyRepeat = 3;
                AppleInterfaceStyle = "Dark";
              };
              CustomUserPreferences = {
                "com.apple.finder" = {
                  AppleShowAllFiles = true;
                  ShowMountedServersOnDesktop = true;
                  FXDefaultSearchScope = "SCcf";
                };
                "com.apple.WindowManager" = {
                  EnableStandardClickToShowDesktop = 0;
                };
              };
            };
            keyboard = {
              enableKeyMapping = true;
              remapCapsLockToControl = true;
            };
          };

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 4;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
          users.users.joefiorini = {
            name = "joefiorini";
            shell = pkgs.fish;
            home = homeDir;
          };
        };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations.m3max-work = nix-darwin.lib.darwinSystem {
        modules = [
          (_: { imports = [ nix.darwinModules.default ]; })
          configuration
          (_: { imports = [ ./packages ]; })
          home-manager.darwinModules.home-manager
          stylix.darwinModules.stylix
          {
            home-manager = {
              sharedModules =
                [ (import ./packages) mac-app-util.homeManagerModules.default ];
              users.joefiorini = import ./home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.m3max-work.pkgs;
    };
}

/* {
     options = {
       root = "option";
       bar = {
         _api = {
           "tul" = "option";
         };
         baz = {
           qux = "qux";
           _api = {
             "qui" = "option";
           };
         };
       };
     };
     foo = "foo";

   }

   hostAttrs "_api" _"options"

   {
     options = {
       _api = {
         tul = "option";
         "qui" = "option";
       };
       bar = {...}
       baz = {...}
     }
   }
*/

/* hosts/family-laptop-2023.nix
    { presets, ... }: {
      presets = with presets; [ terminal-apps development ]
      users = [ "jerps" ]
    }

   hosts/oryp7-personal.nix
     presets = [ terminal-apps development wayland ]
   presets/terminal-apps.nix
         programs = {
           fish = {

          };
          bat = {

          };
          ripgrep = {

          };
          ...
         };

        presets/wayland.nix
        programs = {
          cliphist = {
          };
        };
        packages = with pkgs; [
          kdePackages.koko
          kooha
          rustdesk
          rustdesk-server
          wayvnc
          wev
        ]

      presets/development
     packages = with pkgs; [
       nodePackages.typescript-language-server
     ]

    presets/hyprland
*/
