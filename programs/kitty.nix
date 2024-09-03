{ lib, ... }:
let
  modes = {
    "kitty_mod+w" = "mw";
    "kitty_mod+m" = "md";
  };
  modal-mappings = {
    "mw" = {
      "c" = "neighboring_window left";
      "e" = "neighboring_window right";
      "y" = "neighboring_window up";
      "i" = "neighboring_window down";
      "n" = "new_window";
      "p" = "new_os_window";
      "shift+c" = "move_window left";
      "shift+e" = "move_window right";
      "shift+y" = "move_window up";
      "shift+i" = "move_window down";
    };
    "md" = {
      "d" = "detach_window";
      "t" = "detach_window new-tab";
    };
  };
  mode-strings = lib.foldlAttrs (acc: prefix: val: ''
    ${acc}
    map --new-mode ${val} ${prefix}

    ${mappings val modal-mappings.${val}}

    map --mode ${val} esc pop_keyboard_mode
  '') "" modes;
  mappings = mode: ms:
    lib.foldlAttrs (acc: key: action: ''
      ${acc}
      map --mode ${mode} ${key} combine : ${action} : pop_keyboard_mode
    '') "" ms;
in {
  programs = {
    kitty = {
      enable = true;
      extraConfig = mode-strings;
      settings = {
        allow_remote_control = true;
        kitty_mod = "ctrl+alt+shift";
        focus_follows_mouse = true;
        macos_option_as_alt = true;
        background_blur = 32;
        text_fg_override_threshold = "0.25";
        scrollback_lines = 50000;
        scrollback_pager_history_size = 4096;
        scrollback_fill_enlarged_window = true;
        copy_on_select = "a1";
        strip_trailing_spaces = "smart";
        enabled_layouts = "fat,grid,splits,stack,tall";
      };
      keybindings = {
        "cmd+shift+v" = "paste_from_buffer a1";

        "kitty_mod+a" = "neighboring_window left";
        "kitty_mod+e" = "neighboring_window right";
        "kitty_mod+," = "neighboring_window up";
        "kitty_mod+o" = "neighboring_window down";
      };
    };
  };
}
