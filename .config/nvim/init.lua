-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation (2 spaces)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- UI Settings
vim.opt.termguicolors = true
vim.opt.scrolloff = 8       -- Keep 8 lines above/below cursor
vim.opt.signcolumn = "yes"  -- Always show gutter

-- Clipboard (Use system clipboard)
vim.opt.clipboard = "unnamedplus"

-- Map Leader Key to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick Save/Quit
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
