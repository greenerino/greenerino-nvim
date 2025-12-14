-- NOTE: These two need to be set up before any plugins are loaded.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true, remap = false })

-- disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.scrolloff = 10

vim.o.mouse = 'a'

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

-- Indent
-- vim.o.smarttab = true
vim.opt.cpoptions:append('I')
vim.o.expandtab = true
-- vim.o.smartindent = true
-- vim.o.autoindent = true
vim.o.tabstop = 4
-- vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Navigate splits
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-\\>', ':vsplit<CR>')

-- If we're running outside of Nix, then we need to handle plugin installation.
-- Not technically the right way to do this, since we may want to stub nixCats for non-nix usage and use the plugin's functionality.
-- But we aren't yet using that. So just do this for now.
-- See https://github.com/BirdeeHub/nixCats-nvim/blob/main/templates/example/lua/nixCatsUtils/catPacker.lua#L18
if not (pcall(require, 'nixCats')) then
    require('lazy-plugins/bootstrap')
end

-- Load plugin configuration
require("plugins")
