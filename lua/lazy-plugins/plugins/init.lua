-- Non-nix list of plugins.
-- Should match what is in NixCats
return {
  {
    "nvim-tree/nvim-tree.lua",
    commit = "3fb91e18a727ecc0385637895ec397dea90be42a",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "folke/which-key.nvim",
    commit = "3aab2147e74890957785941f0c1ad87d0a44c15a",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "42fc28ba918343ebfd5565147a42a26580579482",
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
    commit = "8701bece920b38ea289b457f902e2ad184131a5d",
    lazy = false,
  },
  {
    "ibhagwan/fzf-lua",
    commit = "3170d98240266a68c2611fc63260c3ab431575aa",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvimdev/dashboard-nvim",
    commit = "0775e567b6c0be96d01a61795f7b64c1758262f6",
    lazy = false,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  {
    "windwp/nvim-autopairs",
    commit = "7a2c97cccd60abc559344042fefb1d5a85b3e33b",
    lazy = false
  },
  {
    "kylechui/nvim-surround",
    commit = "fcfa7e02323d57bfacc3a141f8a74498e1522064",
    lazy = false
  },
  {
    "lewis6991/gitsigns.nvim",
    commit = "cdafc320f03f2572c40ab93a4eecb733d4016d07",
    lazy = false
  },
  {
    "calops/hmts.nvim",
    commit = "a32cd413f7d0a69d7f3d279c631f20cb117c8d30",
    lazy = false
  },
  {
    "Bekaboo/deadcolumn.nvim",
    commit = "92c86f10bfba2717ca2280e2e759b047135d5288",
    lazy = false
  }
}
