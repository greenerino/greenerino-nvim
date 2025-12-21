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
local wk = require('which-key')
wk.setup()
wk.add {
  {
    "<leader>?",
    function()
      require("which-key").show({ global = true })
    end,
    desc = "Global Keymaps (which-key)",
  },
}


-- Treesitter
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sw"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>sb"] = "@parameter.inner",
      },
    },
  },
}
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    vim.schedule(function()
      if require("nvim-treesitter.parsers").has_parser() then
        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldmethod = "expr"
      else
        vim.opt.foldmethod = "syntax"
      end
      vim.opt.foldlevel = 99
    end)
  end,
})

-- vim-notify
vim.notify = require('notify')

-- fzf
require('fzf-lua')
vim.keymap.set('n', '<C-p>', function()
  local in_git = not not string.find(vim.fn.system { 'git', 'rev-parse', '--is-inside-work-tree' }, 'true')
  if in_git then
    FzfLua.git_files({ resume = true })
  else
    FzfLua.files({ resume = true })
  end
end, { desc = 'Fzf Files' })
vim.keymap.set('n', '<C-u>', ":FzfLua live_grep resume=true<CR>", { desc = 'Live Grep Project' })
