#~/dotfiles/.config/fish/conf.d/rejin.fish

# My Aliases
alias hm="nvim ~/nixos-flake/home/rejin.nix"
alias sm="nvim ~/nixos-flake/hosts/default.nix"
alias fishc="nvim ~/dotfiles/.config/fish/conf.d/rejin.fish"
alias starshipc="nvim ~/dotfiles/.config/starship.toml"

# My Settings
set -g fish_greeting ""
fish_vi_key_bindings
starship init fish | source


# 1. Set Cursor Shapes
# Normal Mode = Block █
set fish_cursor_default block
# Insert Mode = Line |
set fish_cursor_insert line
# Replace Mode = Underscore _
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# 2. Disable the [I] / [N] text indicator
# (We don't need it because the cursor shape tells us the mode now)
function fish_mode_prompt
  # Intentionally empty
end 


# Run Fastfetch only in interactive mode
#if status is-interactive
#  fastfetch
    #end

# ... existing aliases ...





