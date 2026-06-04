return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { '.git', 'go.mod' },
  settings = {
    gopls = {
      semanticTokens = true
    }
  }
}
