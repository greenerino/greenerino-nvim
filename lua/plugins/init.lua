-- nvim-tree
require('nvim-tree').setup({
  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
})

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<C-f>', ':NvimTreeFindFile<CR>')

local nvim_tree_ensure_state = function()
  local api = require('nvim-tree.api')

  -- Fix issue where nvim tree is blank after session restore.
  -- Just open it every time. Helps ground you when switching.
  api.tree.open()

  -- Ensure the root matches in case we switch our session
  local global_cwd = vim.fn.getcwd(-1, -1)
  api.tree.change_root(global_cwd)
end
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree*',
  callback = nvim_tree_ensure_state,
})
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'PersistenceLoadPost',
  callback = nvim_tree_ensure_state
})

-- Colors
require('catppuccin').setup({
  auto_integrations = true

})
vim.cmd('colorscheme catppuccin-frappe')

-- Which-key
local wk = require('which-key')
wk.setup()
wk.add {
  {
    '<leader>?',
    function()
      require('which-key').show({ global = true })
    end,
    desc = 'Global Keymaps (which-key)',
  },
}


-- Treesitter
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ['<leader>sw'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>sb'] = '@parameter.inner',
      },
    },
  },
}
vim.api.nvim_create_autocmd({ 'FileType' }, {
  callback = function()
    vim.schedule(function()
      if require('nvim-treesitter.parsers').has_parser() then
        vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
        vim.opt.foldmethod = 'expr'
      else
        vim.opt.foldmethod = 'syntax'
      end
      vim.opt.foldlevel = 99
    end)
  end,
})

-- vim-notify
vim.notify = require('notify')
vim.notify.setup({
  render = 'wrapped-default',
  max_width = 50
})

-- fzf
local fzflua = require('fzf-lua')
vim.keymap.set('n', '<C-p>', function()
  local in_git = not not string.find(vim.fn.system { 'git', 'rev-parse', '--is-inside-work-tree' }, 'true')
  if in_git then
    fzflua.git_files({ resume = true })
  else
    fzflua.files({ resume = true })
  end
end, { desc = 'Fzf Files' })
vim.keymap.set('n', '<C-u>', ':FzfLua live_grep resume=true<CR><C-g>', { desc = 'Live Grep Project' })

vim.keymap.set('v', '<C-u>', function()
  local mode = vim.api.nvim_get_mode().mode
  local start_pos = vim.fn.getpos('v')
  local end_pos = vim.fn.getpos('.')
  local text = table.concat(vim.fn.getregion(start_pos, end_pos, { type = mode }))
  fzflua.live_grep({ search = text })
end, { desc = 'Live Grep Selection' })

-- nvim-autopairs
require('nvim-autopairs').setup({})

-- nvim-surround
require('nvim-surround').setup()

-- gitsigns
local function find_buf_by_pattern(pattern)
  local bufs = vim.api.nvim_list_bufs()

  for _, buf_id in ipairs(bufs) do
    local buf_name = vim.api.nvim_buf_get_name(buf_id)

    if buf_name:find(pattern) then
      return buf_id
    end
  end

  return nil
end

local function toggle_git_blame()
  local blame_buf = find_buf_by_pattern('^gitsigns%-blame')
  if blame_buf then
    vim.api.nvim_buf_delete(blame_buf, { force = false })
  else
    vim.cmd('Gitsigns blame')
  end
end

vim.keymap.set('n', ']c', ':Gitsigns nav_hunk next<CR>', { desc = 'Go to next Git hunk' })
vim.keymap.set('n', '[c', ':Gitsigns nav_hunk prev<CR>', { desc = 'Go to previous Git hunk' })
vim.keymap.set('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Restore current Git hunk' })
vim.keymap.set('n', 'gb', toggle_git_blame, { desc = 'Git blame' })
vim.keymap.set('n', 'gB', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle inline Git blame' })

-- LSPs

vim.diagnostic.config({
  virtual_text = true
})

vim.lsp.enable({
  -- General
  'luals',
  'godot',
  'yaml',

  -- Work related
  'clojure',
  'ruby',
  'python',
})

-- Nix Only
if (pcall(require, 'nixCats')) then
  vim.lsp.enable({
    'nixd',
    'hyprls',
  })
end

-- blink.cmp
require('blink.cmp').setup({
  keymap = {
    preset = 'none',
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<S-Esc>'] = { 'hide', 'fallback' },
    ['<Tab>'] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      'select_and_accept',
      'fallback' },

    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  completion = {
    list = {
      selection = {
        preselect = true,
        auto_insert = false
      }
    }
  },
  cmdline = {
    enabled = true,
    completion = {
      menu = {
        auto_show = true,
      },
    },
  },
  fuzzy = {
    sorts = {
      'exact',
      -- defaults
      'score',
      'sort_text',
    },
  },
  signature = {
    enabled = true,
    window = {
      show_documentation = true,
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    providers = {}
  }
})

-- auto format
local fmt_group = vim.api.nvim_create_augroup('autoformat_cmds', { clear = true })

local function setup_autoformat(event)
  local id = vim.tbl_get(event, 'data', 'client_id')
  local client = id and vim.lsp.get_client_by_id(id)
  if client == nil then
    return
  end

  vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = event.buf })

  local buf_format = function(e)
    vim.lsp.buf.format({
      bufnr = e.buf,
      async = false,
      timeout_ms = 10000,
    })
  end

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = event.buf,
    group = fmt_group,
    desc = 'Format current buffer',
    callback = buf_format,
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Setup format on save',
  callback = setup_autoformat,
})

-- Comments
require('Comment').setup()

-- Conjure
vim.g['conjure#mapping#doc_word'] = 'gk'

-- Galaxyline
require('plugins/user/galaxyline')

-- Persistence
require('persistence').setup()
vim.keymap.set('n', '<leader>qs', function()
  -- Be sure to save the current session in case we switch.
  -- This allows us to switch back.
  local p = require('persistence')
  if p.active() then
    p.save()
  end
  p.select()
end, { desc = 'Open Session Menu' })


-- snacks.dashboard
require('plugins.user.snacks.dashboard')

-- noice
require('noice').setup({
  presets = {
    command_palette = false,
    bottom_search = true,
    lsp_doc_border = true
  },
  cmdline = {
    format = {
      vert_help = {
        title = 'Help (Vertical)',
        pattern = '^:vert belowright h%s+',
        icon = ''
      },
      filter = {
        title = 'Terminal Command',
        pattern = '^:%s*!',
        icon = '$',
        lang = 'bash'
      }
    },
  },
  routes = {
    {
      view = 'notify',
      filter = {
        event = 'msg_show',
        kind = { '', 'echo', 'echomsg', 'lua_print', 'list_cmd', 'shell_out', 'shell_err', 'shell_ret' }
      }
    }
  }
})

--Twilight
require('twilight').setup({
  treesitter = true,
  context = 15
})
vim.keymap.set('n', 'zT', ':Twilight<CR>', { desc = 'Toggle Twilight' })
