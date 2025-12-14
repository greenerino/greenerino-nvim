-- Non-nix list of plugins.
-- Should match what is in NixCats
return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "1.14.0",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "folke/which-key.nvim",
        version = "3.17.0",
        lazy = false,
    }
}
