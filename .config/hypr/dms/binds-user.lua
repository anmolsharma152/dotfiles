-- DMS user keybind overrides (edit via Control Center or dms; do not remove this header)

-- === Universal Clipboard Helpers ===
local function send_shortcut_once(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

local function active_window_is_terminal()
  local window = hl.get_active_window()
  if not window then
    return false
  end

  for _, tag in ipairs(window.tags or {}) do
    if tag:gsub("%*$", "") == "terminal" then
      return true
    end
  end

  local class = (window.class or ""):lower()
  local initial_class = (window.initialClass or ""):lower()
  if class:find("alacritty") or class:find("kitty") or class:find("ghostty") or class:find("wezterm") or class:find("terminal")
     or initial_class:find("alacritty") or initial_class:find("kitty") or initial_class:find("ghostty") or initial_class:find("wezterm") then
    return true
  end

  return false
end

local function universal_clipboard_shortcut(default_mods, default_key, terminal_mods, terminal_key)
  return function()
    if active_window_is_terminal() then
      send_shortcut_once(terminal_mods, terminal_key)()
    else
      send_shortcut_once(default_mods, default_key)()
    end
  end
end

-- === Universal Clipboard (Super + C / Super + V / Super + X) ===
hl.unbind("SUPER + C")
hl.bind("SUPER + C", universal_clipboard_shortcut("CTRL", "C", "CTRL", "Insert"), { description = "Universal Copy" })

hl.unbind("SUPER + V")
hl.bind("SUPER + V", universal_clipboard_shortcut("CTRL", "V", "SHIFT", "Insert"), { description = "Universal Paste" })

hl.unbind("SUPER + X")
hl.bind("SUPER + X", send_shortcut_once("CTRL", "X"), { description = "Universal Cut" })

hl.unbind("SUPER + CTRL + V")
hl.bind("SUPER + CTRL + V", hl.dsp.exec_cmd("dms ipc call clipboard toggle"), { description = "Clipboard Manager: Toggle" })

-- === Default Applications & Shell Menus ===
hl.unbind("SUPER + B")
hl.bind("SUPER + B", hl.dsp.exec_cmd("dms ipc call defaultApp browser"), { description = "Default Web Browser: Open" })

-- Super + Shift + C toggles Control Center
hl.unbind("SUPER + SHIFT + C")
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("dms ipc call control-center toggle"), { description = "Control Center: Toggle" })

-- Super + D toggles Spotlight Bar; Super + Shift + D toggles Dashboard
hl.unbind("SUPER + D")
hl.bind("SUPER + D", hl.dsp.exec_cmd("dms ipc call spotlight-bar toggle"), { description = "Spotlight Bar: Toggle" })
hl.unbind("SUPER + SHIFT + D")
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("dms ipc call dash toggle \"\""), { description = "Dashboard: Toggle" })

-- Super + S unbound
hl.unbind("SUPER + S")

hl.unbind("SUPER + E")
hl.bind("SUPER + E", hl.dsp.exec_cmd("dms ipc call defaultApp fileManager"), { description = "Default File Manager: Open" })

hl.unbind("SUPER + P")
hl.bind("SUPER + P", hl.dsp.exec_cmd("dms ipc call powermenu toggle"), { description = "Power Menu: Toggle" })

hl.unbind("SUPER + space")
hl.bind("SUPER + space", hl.dsp.exec_cmd("dms ipc call spotlight-bar toggle"), { description = "Spotlight Bar: Toggle" })

hl.unbind("SUPER + SHIFT + J")
hl.bind("SUPER + SHIFT + J", hl.dsp.exec_cmd("dms ipc call window-rules toggle"), { description = "Window Rules: Toggle" })

hl.unbind("SUPER + W")
hl.bind("SUPER + W", hl.dsp.exec_cmd("dms ipc call wallpaper next"), { description = "Wallpaper: Next" })
hl.unbind("SUPER + SHIFT + W")
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("dms ipc call wallpaper prev"), { description = "Wallpaper: Previous" })

-- === Extra Terminals & Volume ===
hl.unbind("SUPER + G")
hl.bind("SUPER + G", hl.dsp.exec_cmd("ghostty"), { description = "Launch Ghostty" })

hl.unbind("SUPER + K")
hl.bind("SUPER + K", hl.dsp.exec_cmd("kitty"), { description = "Launch Kitty" })

hl.unbind("SUPER + M")
hl.bind("SUPER + M", hl.dsp.exec_cmd("pavucontrol"), { description = "Audio Control (Pavucontrol)" })

-- === Terminal (Super + Return) ===
hl.unbind("SUPER + Return")
hl.bind("SUPER + Return", hl.dsp.exec_cmd("alacritty"), { description = "Launch Alacritty" })

-- === GUI AI Apps (Super + A / Super + Shift + A / Super + Ctrl + A) ===
hl.unbind("SUPER + A")
hl.bind("SUPER + A", hl.dsp.exec_cmd("antigravity"), { description = "Launch Antigravity" })

hl.unbind("SUPER + SHIFT + A")
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd("chatgpt"), { description = "Launch ChatGPT" })

hl.unbind("SUPER + CTRL + A")
hl.bind("SUPER + CTRL + A", hl.dsp.exec_cmd("opencode-desktop"), { description = "Launch OpenCode GUI" })

-- === TUI AI Agents (Super + T / Super + Shift + T / Super + Ctrl + T) ===
hl.unbind("SUPER + T")
hl.bind("SUPER + T", hl.dsp.exec_cmd("launch-agent agy"), { description = "Launch Antigravity CLI (agy)" })

hl.unbind("SUPER + SHIFT + T")
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("launch-agent codex"), { description = "Launch Codex CLI" })

hl.unbind("SUPER + CTRL + T")
hl.bind("SUPER + CTRL + T", hl.dsp.exec_cmd("launch-agent opencode"), { description = "Launch OpenCode TUI" })

-- === Keybindings Menu Trigger (Super + /) ===
hl.unbind("SUPER + SHIFT + Slash")
hl.unbind("SUPER + slash")
hl.bind("SUPER + slash", hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"), { description = "Keybindings: Toggle" })

-- === Workspace Navigation & Window Movement (Omarchy cycle & span) ===
hl.unbind("SUPER + Page_Down")
hl.unbind("SUPER + Next")
hl.bind("SUPER + Page_Down", hl.dsp.exec_cmd("workspace-cycle next"), { description = "Next active workspace" })
hl.bind("SUPER + Next", hl.dsp.exec_cmd("workspace-cycle next"), { description = "Next active workspace" })

hl.unbind("SUPER + Page_Up")
hl.unbind("SUPER + Prior")
hl.bind("SUPER + Page_Up", hl.dsp.exec_cmd("workspace-cycle prev"), { description = "Previous active workspace" })
hl.bind("SUPER + Prior", hl.dsp.exec_cmd("workspace-cycle prev"), { description = "Previous active workspace" })

hl.unbind("SUPER + SHIFT + Page_Down")
hl.unbind("SUPER + SHIFT + Next")
hl.bind("SUPER + SHIFT + Page_Down", hl.dsp.exec_cmd("workspace-cycle next --move-window"), { description = "Move window to next workspace" })
hl.bind("SUPER + SHIFT + Next", hl.dsp.exec_cmd("workspace-cycle next --move-window"), { description = "Move window to next workspace" })

hl.unbind("SUPER + SHIFT + Page_Up")
hl.unbind("SUPER + SHIFT + Prior")
hl.bind("SUPER + SHIFT + Page_Up", hl.dsp.exec_cmd("workspace-cycle prev --move-window"), { description = "Move window to previous workspace" })
hl.bind("SUPER + SHIFT + Prior", hl.dsp.exec_cmd("workspace-cycle prev --move-window"), { description = "Move window to previous workspace" })

hl.unbind("SUPER + Home")
hl.bind("SUPER + Home", hl.dsp.exec_cmd("workspace-cycle first"), { description = "First active workspace" })
hl.unbind("SUPER + End")
hl.bind("SUPER + End", hl.dsp.exec_cmd("workspace-cycle last"), { description = "Last active workspace" })

hl.unbind("SUPER + SHIFT + Home")
hl.bind("SUPER + SHIFT + Home", hl.dsp.exec_cmd("workspace-cycle first --move-window"), { description = "Move window to first workspace" })
hl.unbind("SUPER + SHIFT + End")
hl.bind("SUPER + SHIFT + End", hl.dsp.exec_cmd("workspace-cycle last --move-window"), { description = "Move window to last workspace" })

-- === Window, Split & Group Management ===
hl.unbind("ALT + space")
hl.unbind("CTRL + space")
hl.unbind("SUPER + H")
hl.unbind("SUPER + L")
hl.unbind("SUPER + SHIFT + E")
hl.unbind("SUPER + SHIFT + Q")
hl.unbind("SUPER + Z")
hl.bind("SUPER + Z", hl.dsp.window.float({ action = "toggle" }), { description = "Float/unfloat window" })

-- Super + J toggles window split direction (matching Omarchy)
hl.unbind("SUPER + J")
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"), { description = "Toggle window split" })

-- Super + Shift + G toggles window grouping
hl.unbind("SUPER + SHIFT + G")
hl.bind("SUPER + SHIFT + G", hl.dsp.group.toggle(), { description = "Toggle window group" })

-- Unbind U and I from workspace switching (Page Up / Page Down remain active)
hl.unbind("SUPER + U")
hl.unbind("SUPER + SHIFT + U")
hl.unbind("SUPER + CTRL + U")
hl.unbind("SUPER + I")
hl.unbind("SUPER + SHIFT + I")
hl.unbind("SUPER + CTRL + I")

-- === Wayvibes Keyboard Sound Controls ===
hl.bind("SUPER + SHIFT + U", hl.dsp.exec_cmd("wayvibes-ctl toggle"), { description = "Toggle keyboard sounds (mute/unmute)" })
hl.bind("SUPER + U", hl.dsp.exec_cmd("wayvibes-ctl cycle"), { description = "Cycle keyboard soundpack" })
