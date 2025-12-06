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



-- AUTO-START NIX LSP
-- This tells Neovim: "If I open a .nix file, verify if 'nil' is installed and start it."
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function()
    local root_dir = vim.fs.dirname(vim.fs.find({ 'flake.nix', '.git' }, { upward = true })[1])
    vim.lsp.start({
      name = "nil",
      cmd = { "nil" },
      root_dir = root_dir,
      settings = {
        ['nil'] = {
          formatting = { command = { "nixfmt" } },
        },
      },
    })
  end,
})


-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.nix",
  callback = function()
    vim.lsp.buf.format()
  end,
})
