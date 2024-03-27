_: {
enable = true;
  settings = {
  editor  = {
    auto-save = true;
    bufferline = "multiple";
    
    cursor-shape = {
      normal = "block";
insert = "bar";
select = "underline";
    };

    indent-guides = {
      render = true;
    };
     lsp = {
display-messages = true;
display-inlay-hints = true;
      
    };

statusline = {
left = ["mode" "spinner" "diagnostics"];
center = ["file-modification-indicator" "read-only-indicator" "file-name"];
right = ["workspace-diagnostics" "version-control" "position" "file-type"];
mode.normal = "N";
mode.insert = "I";
mode.select = "S";
  };
  } ;

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
M = ["select_mode" "match_brackets" "normal_mode" ];
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
}
