-- Non-nix list of plugins.
-- Should match what is in NixCats
return {
  {
    'nvim-tree/nvim-tree.lua',
    commit = '3fb91e18a727ecc0385637895ec397dea90be42a',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'folke/which-key.nvim',
    commit = '3aab2147e74890957785941f0c1ad87d0a44c15a',
    lazy = false,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    commit = '42fc28ba918343ebfd5565147a42a26580579482',
    lazy = false,
    build =
    ':TSInstall bash clojure comment csv dockerfile fish gdscript gdshader git_config git_rebase gitattributes gitcommit gitignore graphql hcl helm html java json just make markdown markdown_inline mermaid nix python ruby rust sql ssh_config terraform toml yaml | TSUpdate'
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    commit = '5ca4aaa6efdcc59be46b95a3e876300cfead05ef',
    lazy = false,
  },
  {
    'rcarriga/nvim-notify',
    commit = '8701bece920b38ea289b457f902e2ad184131a5d',
    lazy = false,
  },
  {
    'ibhagwan/fzf-lua',
    commit = '3170d98240266a68c2611fc63260c3ab431575aa',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'windwp/nvim-autopairs',
    commit = '7a2c97cccd60abc559344042fefb1d5a85b3e33b',
    lazy = false
  },
  {
    'kylechui/nvim-surround',
    commit = 'fcfa7e02323d57bfacc3a141f8a74498e1522064',
    lazy = false
  },
  {
    'lewis6991/gitsigns.nvim',
    commit = 'cdafc320f03f2572c40ab93a4eecb733d4016d07',
    lazy = false
  },
  {
    'calops/hmts.nvim',
    commit = 'a32cd413f7d0a69d7f3d279c631f20cb117c8d30',
    lazy = false
  },
  {
    'Bekaboo/deadcolumn.nvim',
    commit = '92c86f10bfba2717ca2280e2e759b047135d5288',
    lazy = false
  },
  {
    'saghen/blink.cmp',
    version = '1.8.0',
    lazy = false
  },
  {
    'numToStr/Comment.nvim',
    commit = 'e30b7f2008e52442154b66f7c519bfd2f1e32acb',
    lazy = false
  },
  {
    'catppuccin/nvim',
    commit = 'da33755d00e09bff2473978910168ff9ea5dc453',
    lazy = false
  },
  {
    'NTBBloodbath/galaxyline.nvim',
    commit = '4d4f5fc8e20a10824117e5beea7ec6e445466a8f',
    lazy = false
  },
  {
    'folke/snacks.nvim',
    commit = 'fe7cfe9800a182274d0f868a74b7263b8c0c020b',
    lazy = false
  },
  {
    'folke/persistence.nvim',
    commit = 'b20b2a7887bd39c1a356980b45e03250f3dce49c',
    lazy = false
  },
  {
    'MunifTanjim/nui.nvim',
    version = '0.4.0',
    lazy = false
  },
  {
    'folke/noice.nvim',
    commit = '7bfd942445fb63089b59f97ca487d605e715f155',
    lazy = false
  },
  {
    'guns/vim-sexp',
    commit = 'd8df22690b146ce07fdaf49940e3214def76a69c',
    lazy = false
  },
  {
    'tpope/vim-sexp-mappings-for-regular-people',
    commit = '4debb74b0a3e530f1b18e5b7dff98a40b2ad26f1',
    lazy = false
  },
  {
    'folke/twilight.nvim',
    commit = '664e752f4a219801265cc3fc18782b457b58c1e1',
    lazy = false
  },
  {
    'chomosuke/typst-preview.nvim',
    commit = '64469f832c4d214683c12e0fceba98055cb1ce3b',
    lazy = false
  },
  {
    'stevearc/conform.nvim',
    commit = '1bf8b5b9caee51507aa51eaed3da5b0f2595c6b9',
    lazy = false
  },
  {
    'tpope/vim-fugitive',
    commit = '61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4',
    lazy = false
  },
  {
    'tpope/vim-rhubarb',
    commit = '5496d7c94581c4c9ad7430357449bb57fc59f501',
    lazy = false
  },


  -- Work Plugins
  -- It's ok for these versions to drift from Nix
  {
    'Olical/conjure',
    version = '4.58.0',
    lazy = false
  }
}
