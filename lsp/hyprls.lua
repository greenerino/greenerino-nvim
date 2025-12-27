return {
  cmd = { 'hyprls' },
  filetypes = { 'hyprlang' },
  root_markers = { '.git' },
  settings = {
    hyprls = {
      preferIgnoreFile = false,
      ignore = { 'hyprlock.conf', 'hypridle.conf' }
    }
  }
}
