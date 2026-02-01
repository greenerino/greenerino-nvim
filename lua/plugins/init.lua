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

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
vim.keymap.set('n', '<C-f>', ':NvimTreeFindFile<CR>', { desc = 'Find File in NvimTree' })

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
vim.keymap.set('n', ']c', ':Gitsigns nav_hunk next<CR>', { desc = 'Go to next Git hunk' })
vim.keymap.set('n', '[c', ':Gitsigns nav_hunk prev<CR>', { desc = 'Go to previous Git hunk' })
vim.keymap.set('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Restore current Git hunk' })
vim.keymap.set('n', 'gB', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle inline Git blame' })

-- fugitive. specifically used for blame and browse functionality
vim.keymap.set('n', 'gb', function()
  vim.cmd('Git blame')
end, { desc = 'Git blame' })

-- Add a Gitea provider for Fugitive's :GBrowse
-- I couldn't figure out how to correctly append to the existing list of
-- handlers. Pulling to a local table, adding to it, and re-setting the variable
-- would break the existing Rhubarb handler.
-- If I manually re-add the Rhubarb handler, it seems to work.
local handlers = {}
--[[ if vim.g.fugitive_browse_handlers ~= nil then
  handlers = vim.g.fugitive_browse_handlers
end ]]
table.insert(handlers, function(opts)
  print('handler called')
  local remote_pattern = 'ssh://git@greene.nas:2222/'
  local gitea_root = 'http://greene.nas:7978/'
  if string.find(opts.remote, remote_pattern) then
    -- Lua doesn't use Regex. I don't feel like diving into using vim.regex,
    -- so just hardcode a string.sub for the repo name
    local root = gitea_root .. string.sub(opts.remote, #remote_pattern + 1, (#'.git' * -1) - 1)
    local path = opts.path

    if string.find(path, '/') == 1 then
      path = string.sub(path, 2) -- Chop off leading /
    end

    if string.find(path, '.git/refs/heads/') == 1 then
      return root .. '/commits/' .. string.sub(path, 17)
    elseif string.find(path, '.git/refs/tags/') then
      return root .. '/src/' .. string.sub(path, 16)
    elseif string.find(path, '.git>') then
      return root
    elseif opts.type == 'blob' then
      local url = root .. '/src/' .. opts.commit .. '/' .. path
      if opts.line1 ~= 0 then
        url = url .. '#L' .. opts.line1
        if opts.line2 ~= 0 then
          url = url .. '-L' .. opts.line2
        end
      end
      return url
    else
      -- Open just a commit
      return root .. '/commit/' .. opts.commit
    end
  end
end)
vim.g.fugitive_browse_handlers = handlers
vim.cmd [[call insert(g:fugitive_browse_handlers, function('rhubarb#FugitiveUrl'))]]

-- LSPs

vim.diagnostic.config({
  virtual_text = true
})

vim.lsp.enable({
  -- General
  'luals',
  'godot',
  'yaml',
  'typst',
  'bash',

  -- Work related
  'clojure',
  'java',
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

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

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
    keymap = { preset = 'inherit' },
    completion = { menu = { auto_show = true } },
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

-- conform
require('conform').setup({
  formatters_by_ft = {
    clojure = { 'cljstyle' }
  },
  format_on_save = {
    lsp_format = 'fallback',
    timeout_ms = 500
  }
})

-- Comments
require('Comment').setup({
  toggler = {
    block = 'gpc'
  },
  opleader = {
    block = 'gp'
  }
})

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

-- auto-indent
-- Simple plugin that indents you to the correct level when pressing tab toward
-- the beginning of a line
require('auto-indent').setup({
  lightmode = true,
  indentexpr = function(lnum)
    return require('nvim-treesitter.indent').get_indent(lnum)
  end
})
