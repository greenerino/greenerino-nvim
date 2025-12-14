-- nvim-tree
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
})

vim.keymap.set('n', '<C-n>', ":NvimTreeToggle<CR>")
vim.keymap.set('n', '<C-f>', ":NvimTreeFindFile<CR>")

-- Pywal colors, only for Nix right now
if (pcall(require, 'nixCats')) then
    require('pywal').setup()
end

-- Which-key
require('which-key').setup()
require('which-key').add {
    {
        "<leader>?",
            function()
                require("which-key").show({ global = true })
            end,
        desc = "Global Keymaps (which-key)",
    },
}
