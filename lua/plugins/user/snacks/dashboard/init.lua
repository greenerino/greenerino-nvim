---@class snacks.dashboard.Config
---@field enabled? boolean
---@field sections snacks.dashboard.Section
---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
local opts = {
  enabled = true,
  width = 60,
  row = nil,                                                               -- dashboard position. nil for center
  col = nil,                                                               -- dashboard position. nil for center
  pane_gap = 4,                                                            -- empty columns between vertical panes
  autokeys = '1234567890abcdefgimnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence
  -- These settings are used by some built-in sections
  preset = {
    -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
    ---@type fun(cmd:string, opts:table)|nil
    pick = nil,
    -- Used by the `keys` section to show keymaps.
    -- Set your custom keymaps here.
    -- When using a function, the `items` argument are the default keymaps.
    ---@type snacks.dashboard.Item[]
    keys = {
      { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
      { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
      { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
      { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
      { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
  },
  -- item field formatters
  formats = {
    icon = function(item)
      if item.file and item.icon == 'file' or item.icon == 'directory' then
        return Snacks.dashboard.icon(item.file, item.icon)
      end
      return { item.icon, width = 2, hl = 'icon' }
    end,
    footer = { '%s', align = 'center' },
    header = { '%s', align = 'center' },
    file = function(item, ctx)
      local fname = vim.fn.fnamemodify(item.file, ':~')
      fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
      if #fname > ctx.width then
        local dir = vim.fn.fnamemodify(fname, ':h')
        local file = vim.fn.fnamemodify(fname, ':t')
        if dir and file then
          file = file:sub(-(ctx.width - #dir - 2))
          fname = dir .. '/…' .. file
        end
      end
      local dir, file = fname:match('^(.*)/(.+)$')
      return dir and { { dir .. '/', hl = 'dir' }, { file, hl = 'file' } } or { { fname, hl = 'file' } }
    end,
  },
  sections = {
    { section = 'header' },
    { title = 'Get Right Into It', section = 'keys',         indent = 2, padding = 1 },
    { title = 'Projects',          section = 'projects',     indent = 2, padding = 1 },
    { title = 'Recent Files',      section = 'recent_files', indent = 2, padding = 1 },
    {
      title = 'Git Status',
      section = 'terminal',
      enabled = function()
        return Snacks.git.get_root() ~= nil
      end,
      cmd = 'git status --short --branch --untracked-files=all',
      height = 10,
      padding = 1,
      ttl = 5 * 60,
      indent = 2
    },
    {
      section = 'startup',
      enabled = function()
        return not not pcall(require, 'lazy.stats')
      end
    },
  },
}

-- Load Snacks and ensure the Global `Snacks` variable is available
require('snacks')

-- Monkeypatch the built in function that is only compatible with lazy.nvim.
-- This allows session restoration to work.
-- No need to implement for real. Just tell it to use persistence.nvim.
-- https://github.com/folke/snacks.nvim/blob/e440df387d448a2ec332442a0eca6ece685f2b4d/lua/snacks/dashboard.lua#L841
require('snacks.dashboard').have_plugin = function(name)
  return name == 'persistence.nvim'
end

require('snacks').setup({
  dashboard = opts
})
