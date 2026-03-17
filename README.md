# wezterm_config

```
~/.config/wezterm/wezterm.lua  (Linux / macOS)
%USERPROFILE%\.config\wezterm\wezterm.lua  (Windows)
```

# PS1

PS1='\[\033[0;32m\]\u\[\033[0;36m\] @ \h \w\[\033[0;32m\]$(\_\_git_ps1)\n└─ ▶\[\033[0m\] '

# lancer un cmd en admin

`win + X` -> terminal administrateur

# créer le répertoire `%USERPROFILE%\.config\wezterm\`

# créer le lien symbolique vers le repo

```
cd %USERPROFILE%\.config\wezterm\
mklink wezterm.lua C:\path\to\wezterm_config\wezterm.lua
```

# créer un lien symbolique de l'ensemble du répertoire

> doit se faire avec .config supprimé

```
New-Item -ItemType Junction -Path "C:\Users\BCH\.config\wezterm" -Target "D:\repositories\wezterm_config"
```

# relancer wezterm
