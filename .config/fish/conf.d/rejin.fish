#~/dotfiles/.config/fish/conf.d/rejin.fish

# My Aliases
alias hm="nvim ~/nixos-flake/home/rejin.nix"
alias sm="nvim ~/nixos-flake/hosts/default.nix"
alias fishc="nvim ~/dotfiles/.config/fish/conf.d/rejin.fish"
alias starshipc="nvim ~/dotfiles/.config/starship.toml"
alias hmr="home-manager switch --flake ~/nixos-flake/.#rejin"
alias smr="sudo nixos-rebuild switch --flake ~/nixos-flake/.#rejin-nixos"
alias nfu="nix flake update --flake ~/nixos-flake"

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
set -gx EDITOR nvim

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


# Function: Add -> Commit -> Push in one go
function gcp
    # 1. Check if message was provided
    if test (count $argv) -eq 0
        echo "Error: Missing commit message."
        echo "Usage: gcp \"Updated niri config and fixed shell aliases\""
        return 1
    end

    # 2. Add all changes (both new and modified files)
    git add .

    # 3. Commit with the message provided in arguments
    git commit -m "$argv"

    # 4. Push to the current branch
    git push
end





