-- Non-nix list of plugins.
-- Should match what is in NixCats
return {
  {
    'nvim-tree/nvim-tree.lua',
    commit = '07f541fcaa4a5ae019598240362449ab7e9812b3',
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
    ':TSInstall stable | TSUpdate'
  },
  {
    'rcarriga/nvim-notify',
    commit = '8701bece920b38ea289b457f902e2ad184131a5d',
    lazy = false,
  },
  {
    'ibhagwan/fzf-lua',
    commit = '23f71140754b9162551dc8ccc1d6346e4275ecc2',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'windwp/nvim-autopairs',
    commit = '7b9923abad60b903ece7c52940e1321d39eccc79',
    lazy = false
  },
  {
    'kylechui/nvim-surround',
    commit = '2e93e154de9ff326def6480a4358bfc149d5da2c',
    lazy = false
  },
  {
    'lewis6991/gitsigns.nvim',
    commit = 'a462f416e2ce4744531c6256252dee99a7d34a83',
    lazy = false
  },
  {
    'calops/hmts.nvim',
    tag = 'v1.3.0',
    lazy = false
  },
  {
    'Bekaboo/deadcolumn.nvim',
    commit = '92c86f10bfba2717ca2280e2e759b047135d5288',
    lazy = false
  },
  {
    'saghen/blink.cmp',
    version = '1.10.2',
    lazy = false
  },
  {
    'numToStr/Comment.nvim',
    commit = 'e30b7f2008e52442154b66f7c519bfd2f1e32acb',
    lazy = false
  },
  {
    'catppuccin/nvim',
    tag = 'v2.0.0',
    lazy = false
  },
  {
    'NTBBloodbath/galaxyline.nvim',
    commit = '4d4f5fc8e20a10824117e5beea7ec6e445466a8f',
    lazy = false
  },
  {
    'folke/snacks.nvim',
    commit = 'ad9ede6a9cddf16cedbd31b8932d6dcdee9b716e',
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
    commit = '1bf50921308f0188d1c1ecf8a712cc72ab2775e5',
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
    commit = '87db18b8d19c8b0eed399f52e4c527ce5afe4817',
    lazy = false
  },
  {
    'stevearc/conform.nvim',
    commit = '18aeab3d63d350dcf44d64c462cc489a3412af40',
    lazy = false
  },
  {
    'tpope/vim-fugitive',
    commit = '3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0',
    lazy = false
  },
  {
    'tpope/vim-rhubarb',
    commit = '5496d7c94581c4c9ad7430357449bb57fc59f501',
    lazy = false
  },
  {
    'saghen/blink.indent',
    tag = 'v2.1.2',
    lazy = false
  },
  {
    'VidocqH/auto-indent.nvim',
    commit = '46801cf8857d42a20a73c40b0a5d3dfe8b2b6192',
    lazy = false
  },
  {
    'iamcco/markdown-preview.nvim',
    commit = 'a923f5fc5ba36a3b17e289dc35dc17f66d0548ee',
    build = function() vim.fn['mkdp#util#install']() end,
    lazy = false
  },
  {
    'catgoose/nvim-colorizer.lua',
    commit = '5cfe7fffbd01e17b3c1e14af85d5febdef88bd8c',
    lazy = false
  },
  {
    'folke/zen-mode.nvim',
    tag = 'v1.4.1',
    lazy = false
  },


  -- Work Plugins
  -- It's ok for these versions to drift from Nix
  {
    'Olical/conjure',
    version = '4.60.0',
    lazy = false

  }
}
