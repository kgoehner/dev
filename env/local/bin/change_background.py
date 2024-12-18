import os
import toml

# This is a python script to change the background for Alacritty, tmux, and NeoVim from light to dark.

HOME: str | None = os.getenv("HOME")

def update_alacritty():
    conifg = toml.load(os.path.join(HOME, ".config", "alacritty", "alacritty.toml"))
