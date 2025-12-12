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


if (pcall(require, 'nixCats')) then
    require('pywal').setup()
end
