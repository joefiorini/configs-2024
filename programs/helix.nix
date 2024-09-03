{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.bash-language-server # Bash
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.vscode-langservers-extracted
emmet-language-server
    nil
    nodePackages.pyright # Python
    nodePackages.stylelint
    nodePackages.pyright # Python
    nodePackages.stylelint
    pkgs.dotnet-sdk
    pkgs.omnisharp-roslyn # .NET
    pkgs.msbuild
    marksman # Markdown
    nixfmt
    ltex-ls
    jsonnet-language-server
  ];
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.default;
    settings = {
      editor = {
        auto-save = true;
        auto-format = true;
        bufferline = "multiple";

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        indent-guides = { render = true; };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };

        statusline = {
          left = [ "mode" "spinner" "diagnostics" ];
          center =
            [ "file-modification-indicator" "read-only-indicator" "file-name" ];
          right = [
            "workspace-diagnostics"
            "version-control"
            "position"
            "file-type"
          ];
          mode.normal = "N";
          mode.insert = "I";
          mode.select = "S";
        };
      };

      keys.normal = {
        S-left = "extend_char_left";
        S-right = "extend_char_right";
        S-up = "extend_line_up";
        S-down = "extend_line_down";
        C-C = "no_op";
        A-p = "paste_primary_clipboard_after";
        "A-P" = "paste_primary_clipboard_before";
        A-r = "replace_selections_with_primary_clipboard";
        A-y = "yank_to_primary_clipboard";
        "left" = "goto_previous_buffer";
        "right" = "goto_next_buffer";

        # Kakoune keys;
        H = "extend_char_left";
        J = "extend_line_down";
        K = "extend_line_up";
        L = "extend_char_right";
        W = "extend_next_word_start";
        B = "extend_prev_word_start";
        E = "extend_next_word_end";
        A-j = "join_selections";
        A-k = "keep_selections";
        M = [ "select_mode" "match_brackets" "normal_mode" ];
        "#" = "toggle_comments";
        A-h = "extend_to_line_start";
        A-l = "extend_to_line_end";

      };

      keys.insert = {
        C-f = "move_char_left";
        C-b = "move_char_right";
        C-a = "goto_line_start";
        C-e = "goto_line_end";
        A-f = "move_next_word_end";
        A-b = "move_prev_word_start";
        C-n = "move_visual_line_down";
        C-p = "move_visual_line_up";
        "C-[" = "normal_mode";
      };

      keys.normal.space = {
        "." = "file_picker_in_current_buffer_directory";
        "b" = {
          l = "buffer_picker";
          n = ":buffer-next";
          p = ":buffer-previous";
          c = ":buffer-close";
          o = ":buffer-close-others";
          w = ":write-buffer-close";
        };
      };
    };
    languages = with pkgs; {
      language = let
        jsTsWebLanguageServers = [
          {
            name = "typescript-language-server";
            except-features = [ "format" ];
          }
          "eslint"
          {
            name = "efm-lsp-prettier";
            only-features = [ "format" ];
          }
        ];
      in [
        {
          name = "bash";
          auto-format = true;
          file-types = [ "sh" "bash" ];
          formatter = {
            command = "${pkgs.shfmt}/bin/shfmt";
            # Indent with 2 spaces, simplify the code, indent switch cases, add space after redirection
            args = [ "-i" "4" "-s" "-ci" "-sr" ];
          };
        }
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nil" ];
        }
        {
          name = "c-sharp";
          language-servers = [ "omnisharp" ];
        }
        {
          name = "typescript";
          auto-format = true;
          language-servers = jsTsWebLanguageServers;
        }
        {
          name = "javascript";
          auto-format = true;
          language-servers = jsTsWebLanguageServers;
        }
        {
          name = "jsx";
          auto-format = true;
          language-servers = jsTsWebLanguageServers;
        }
        {
          name = "tsx";
          auto-format = true;
          language-servers = jsTsWebLanguageServers;
        }
        {
          name = "json";
          auto-format = true;
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = [ "format" ];
            }
            "efm-lsp-prettier"
          ];
        }
        {
          name = "markdown";
          auto-format = true;
          language-servers = [
            {
              name = "marksman";
              except-features = [ "format" ];
            }
            "ltex-ls"
            "efm-lsp-prettier"
          ];
        }

        {
          name = "xml";
          auto-format = true;
          file-types = [ "xml" ];
          formatter = {
            command = "${pkgs.yq-go}/bin/yq";
            args =
              [ "--input-format" "xml" "--output-format" "xml" "--indent" "2" ];
          };
        }
      ];
      language-server = {
        omnisharp = {
          command = "OmniSharp";
          args = [ "-l" "Error" "--languageserver" "-z" ];
          timeout = 60;
        };
        nil = {
          config = {
            formatting = { command = [ "nixfmt" ]; };
            flake = {
              autoEvalInputs = true;
              nixpkgsInputName = "pkgs";
            };
          };
        };
        efm-lsp-prettier = {
          command = "${efm-langserver}/bin/efm-langserver";
          config = {
            documentFormatting = true;
            languages = lib.genAttrs [
              "typescript"
              "javascript"
              "typescriptreact"
              "javascriptreact"
              "vue"
              "json"
              "markdown"
              "css"
              "less"
              "sass"
              "scss"
            ] (_: [{
              formatCommand =
                "${nodePackages.prettier}/bin/prettier --stdin-filepath \${INPUT}";
              formatStdin = true;
            }]);
          };
        };
        eslint = {
          command = "vscode-eslint-language-server";
          args = [ "--stdio" ];
          config = {
            validate = "on";
            packageManager = "npm";
            useESLintClass = false;
            # codeActionOnSave.mode = "all";
            codeActionsOnSave = { mode = "all"; "source.fixAll.eslint" = true; };
            format = true;
            quiet = false;
            onIgnoredFiles = "off";
            rulesCustomizations = [ ];
            run = "onType";
            # nodePath configures the directory in which the eslint server should start its node_modules resolution.
            # This path is relative to the workspace folder (root dir) of the server instance.
            nodePath = "";
            # use the workspace folder location or the file location (if no workspace folder is open) as the working directory

            workingDirectory.mode = "auto";
            experimental = { };
            problems.shortenToSingleLine = false;
            codeAction = {
              disableRuleComment = {
                enable = true;
                location = "separateLine";
              };
              showDocumentation.enable = true;
            };
          };
        };
        typescript-language-server = {
          command =
            "${nodePackages.typescript-language-server}/bin/typescript-language-server";
          args = [
            "--stdio"
          ];
          config.documentFormatting = false;
        };
        ltex-ls.command = "ltex-ls";

      };
    };
  };
}
