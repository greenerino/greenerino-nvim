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

-- Treesitter
require('nvim-treesitter.configs').setup {
    highlight = { enable = true }
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
