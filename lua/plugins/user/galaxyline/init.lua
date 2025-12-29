local present1, gl = pcall(require, 'galaxyline')
if not present1 then
  vim.notify('galaxyline not found')
  return
end

-- Makes galaxyline disappear for nvim-tree
gl.short_line_list = { 'NvimTree' }

local gls = gl.section

local function insert_left(element)
  table.insert(gls.left, element)
end

local function insert_right(element)
  table.insert(gls.right, element)
end

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then return true end
  return false
end

local in_git_repo = function()
  local vcs = require('galaxyline.providers.vcs')
  local branch_name = vcs.get_git_branch()

  return branch_name ~= nil
end

local colors = (function()
  -- Grab colors based on current colorscheme

  local get_color = function(hl_name, field)
    return '#' .. string.format('%x', vim.api.nvim_get_hl(0, { name = hl_name })[field])
  end

  local dark_bg = get_color('StatusLine', 'bg')
  local mid_bg = get_color('Normal', 'bg')
  local light_bg = get_color('Visual', 'bg')
  local fg = get_color('Normal', 'fg')
  local normal = get_color('Special', 'fg')
  local insert = get_color('Keyword', 'fg')
  local visual = get_color('Constant', 'fg')
  local terminal = get_color('PreProc', 'fg')
  local command = get_color('Identifier', 'fg')
  local replace = get_color('Identifier', 'fg')
  local git_add = get_color('diffAdded', 'fg')
  local git_remove = get_color('diffRemoved', 'fg')
  local git_change = get_color('diffChanged', 'fg')
  return {
    dark_bg = dark_bg,
    mid_bg = mid_bg,
    light_bg = light_bg,
    fg = fg,
    modes = {
      n = normal,
      i = insert,
      v = visual,
      V = visual,
      t = terminal,
      c = command,
      R = replace
    },
    git = {
      add = git_add,
      change = git_change,
      delete = git_remove
    }
  }
end)()

insert_left {
  Start = {
    provider = function() return '   ' end,
    highlight = { colors.dark_bg, colors.dark_bg }
  }
}

insert_left {
  Space1 = {
    provider = function() return ' ' end,
    condition = in_git_repo,
    highlight = { colors.dark_bg, colors.dark_bg }
  }
}

insert_left {
  ViMode = {
    provider = function()
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        V = 'VISUAL LINE',
        v = 'VISUAL',
        t = 'TERMINAL',
        c = 'COMMAND',
        R = 'REPLACE'
      }

      local vim_mode = vim.fn.mode()
      local color = colors.modes[vim_mode]
      if color then
        vim.api.nvim_command('hi GalaxyViMode guifg=' .. color)
      end
      return alias[vim_mode] or vim_mode
    end,
    highlight = { colors.dark_bg, colors.dark_bg }
  },
}

insert_left {
  Space2a = {
    provider = function() return ' ' end,
    highlight = { colors.dark_bg, colors.dark_bg }
  }
}

insert_left {
  Sep1a = {
    provider = function() return ' ' end,
    highlight = { colors.dark_bg, colors.light_bg }
  }
}

insert_left {
  GitIcon = {
    provider = function() return ' ' end,
    condition = in_git_repo,
    highlight = { colors.fg, colors.light_bg }
  },
}

insert_left {
  GitBranch = {
    provider = 'GitBranch',
    condition = in_git_repo,
    highlight = { colors.fg, colors.light_bg }
  },
}

insert_left {
  Space3 = {
    provider = function() return '  ' end,
    condition = in_git_repo,
    highlight = { colors.light_bg, colors.light_bg }
  }
}

insert_left {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = in_git_repo,
    icon = '+',
    highlight = { colors.git.add, colors.light_bg }
  },
}

insert_left {
  DiffModified = {
    provider = 'DiffModified',
    condition = in_git_repo,
    icon = '~',
    highlight = { colors.git.change, colors.light_bg }
  },
}

insert_left {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = in_git_repo,
    icon = '-',
    highlight = { colors.git.delete, colors.light_bg }
  },
}

insert_left {
  Sep2 = {
    provider = function() return ' ' end,
    highlight = { colors.light_bg, colors.mid_bg }
  }
}

insert_left {
  LspClient = {
    provider = require('plugins.user.galaxyline.providers.lsp'),
    icon = ' ',
    highlight = { colors.fg, colors.mid_bg }
  },
}


insert_left {
  Space4 = {
    provider = function() return '  ' end,
    condition = in_git_repo,
    highlight = { colors.mid_bg, colors.mid_bg }
  }
}

insert_left {
  Sep3 = {
    provider = function() return '' end,
    highlight = { colors.mid_bg, colors.dark_bg }
  }
}

insert_left {
  SpaceMid = {
    provider = function() return ' ' end,
    highlight = { colors.dark_bg, colors.dark_bg }
  }
}

insert_right {
  SepR2 = {
    provider = function() return '' end,
    condition = buffer_not_empty,
    highlight = { colors.mid_bg, colors.dark_bg }
  }
}

insert_right {
  SpaceR3 = {
    provider = function() return '  ' end,
    condition = buffer_not_empty,
    highlight = { colors.mid_bg, colors.mid_bg }
  }
}

insert_right {
  LineInfo = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {
      require('galaxyline.providers.fileinfo').get_file_icon_color,
      colors.mid_bg
    }
  },
}

insert_right {
  SpaceR2 = {
    provider = function() return '  ' end,
    condition = buffer_not_empty,
    highlight = { colors.mid_bg, colors.mid_bg }
  }
}

insert_right {
  FileName = {
    provider = 'FileName',
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.mid_bg }
  },
}
insert_right {
  FileSize = {
    provider = 'FileSize',
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.mid_bg }
  }
}
insert_right {
  SepR1a = {
    provider = function() return '' end,
    condition = function() return not buffer_not_empty() end,
    highlight = { colors.light_bg, colors.mid_bg }
  }
}


insert_right {
  SepR1b = {
    provider = function() return '' end,
    condition = buffer_not_empty,
    highlight = { colors.light_bg, colors.mid_bg }
  }
}

insert_right {
  SpaceR1 = {
    provider = function() return '  ' end,
    highlight = { colors.light_bg, colors.light_bg }
  }
}

insert_right {
  Column = {
    provider = 'LineColumn',
    highlight = { colors.fg, colors.light_bg }
  },
}

insert_right {
  ColumnPercent = {
    provider = 'LinePercent',
    highlight = { colors.fg, colors.light_bg }
  }
}

insert_right {
  SpaceR = {
    provider = function() return '  ' end,
    highlight = { colors.light_bg, colors.light_bg }
  }
}

insert_right {
  End = {
    provider = function() return '  ' end,
    highlight = { colors.light_bg, colors.light_bg }
  }
}
