return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml' },
  settings = {
    yaml = {
      format = {
        enable = true
      },
      validate = true,
      hover = true,
      completion = true,
    }
  }
}
