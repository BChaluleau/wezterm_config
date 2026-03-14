-- ~/.config/wezterm/wezterm.lua  (Linux / macOS)
-- %USERPROFILE%\.config\wezterm\wezterm.lua  (Windows)
 
local wezterm = require 'wezterm'
local config  = wezterm.config_builder()
 
-- ─────────────────────────────────────────────────────────────
-- Police
-- JetBrains Mono est incluse dans WezTerm : rien à installer.
-- Active les ligatures (=> != -> etc.) et une taille confortable.
-- ─────────────────────────────────────────────────────────────
config.font = wezterm.font('JetBrains Mono', { weight = 'Regular' })
config.font_size = 12.0
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' } -- ligatures on
 
-- ─────────────────────────────────────────────────────────────
-- Thème : Catppuccin Mocha
-- Dark, contrastes doux, couleurs pastel modernes.
-- Inclus dans WezTerm (pas de plugin à installer).
-- ─────────────────────────────────────────────────────────────
config.color_scheme = 'Catppuccin Mocha'
 
-- ─────────────────────────────────────────────────────────────
-- Fenêtre
-- ─────────────────────────────────────────────────────────────
config.initial_cols = 120
config.initial_rows = 32
 
-- Légère transparence (0 = invisible, 1 = opaque)
config.window_background_opacity = 0.95
 
-- Marges intérieures pour respirer
config.window_padding = {
  left   = 12,
  right  = 12,
  top    = 8,
  bottom = 8,
}
 
-- ─────────────────────────────────────────────────────────────
-- Barre d'onglets
-- ─────────────────────────────────────────────────────────────
config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.use_fancy_tab_bar      = true 
config.tab_bar_at_bottom      = false
config.hide_tab_bar_if_only_one_tab = false  -- toujours visible pour le style

-- Couleurs de la tab bar (assortie à Catppuccin Mocha)
config.colors = {
  tab_bar = {
    background = '#1e1e2e',
    active_tab = {
      bg_color  = '#cba6f7',  -- mauve Catppuccin
      fg_color  = '#1e1e2e',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#313244',
      fg_color = '#a6adc8',
    },
    inactive_tab_hover = {
      bg_color = '#45475a',
      fg_color = '#cdd6f4',
    },
    new_tab = {
      bg_color = '#1e1e2e',
      fg_color = '#585b70',
    },
    new_tab_hover = {
      bg_color = '#313244',
      fg_color = '#cdd6f4',
    },
  },
}
 
-- ─────────────────────────────────────────────────────────────
-- Curseur
-- ─────────────────────────────────────────────────────────────
config.default_cursor_style   = 'BlinkingBar'
config.cursor_blink_rate      = 500  -- ms
 
-- ─────────────────────────────────────────────────────────────
-- Comportement
-- ─────────────────────────────────────────────────────────────
config.scrollback_lines       = 10000
config.enable_scroll_bar      = true
config.audible_bell           = 'Disabled'
 
-- ─────────────────────────────────────────────────────────────
-- Shells disponibles (adapter les noms de distro WSL si besoin)
-- ─────────────────────────────────────────────────────────────
local is_windows = wezterm.target_triple:find('windows') ~= nil
 
if is_windows then
  -- Shell par défaut sur Windows : WSL (distro par défaut)
  config.default_prog = { 'wsl.exe', '--cd', '~'  }
 
  config.launch_menu = {
    { label = '  WSL (défaut)',  args = { 'wsl.exe', '--cd', '~'  } },
    { label = '  Ubuntu',        args = { 'wsl.exe', '-d', 'Ubuntu' } },
    { label = '  PowerShell',    args = { 'pwsh.exe', '-NoLogo' } },
    { label = '  CMD',           args = { 'cmd.exe' } },
  }
  config.window_background_opacity = 0.95
  config.window_decorations = "RESIZE"
else
  -- commenter si problème sous linux
  config.window_background_opacity = 0.95
end
 
-- ─────────────────────────────────────────────────────────────
-- Raccourcis utiles
-- ─────────────────────────────────────────────────────────────
local act = wezterm.action
 
config.keys = {
  -- Nouvel onglet
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  -- Fermer l'onglet
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = false } },
  -- Naviguer entre onglets
  { key = 'Tab',       mods = 'CTRL',       action = act.ActivateTabRelative(1)  },
  { key = 'Tab',       mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
  -- Diviser le panneau horizontalement / verticalement
  { key = 'd', mods = 'CTRL|SHIFT', action = act.SplitHorizontal  { domain = 'CurrentPaneDomain' } },
  { key = 'e', mods = 'CTRL|SHIFT', action = act.SplitVertical    { domain = 'CurrentPaneDomain' } },
  -- Naviguer entre panneaux
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left'  },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Up'    },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Down'  },
  -- Zoom panneau courant
  { key = 'z', mods = 'CTRL', action = act.TogglePaneZoomState },
  -- Copier / coller
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo  'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  -- Augmenter / diminuer la taille de police
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize    },

  { key = 'n', mods = 'CTRL|SHIFT', action = act.ShowLauncherArgs { flags = 'LAUNCH_MENU_ITEMS' } },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay },

}
 
return config