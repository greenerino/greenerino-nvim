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
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = "0.10.0",
    lazy = false,
    build = ':TSInstall bash clojure comment csv dockerfile fish gdscript gdshader git_config git_rebase gitattributes gitcommit gitignore graphql hcl helm html java json just make markdown markdown_inline mermaid nix python ruby rust sql ssh_config terraform toml yaml | TSUpdate'
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "5ca4aaa6efdcc59be46b95a3e876300cfead05ef",
    lazy = false,
  },
  {
    "rcarriga/nvim-notify",
    version = "3.15.0",
    lazy = false,
  },
  {
    "ibhagwan/fzf-lua",
    commit = "9d579feab4d3035627150e5e9b6e8fbf5e814ef6",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  }
}
