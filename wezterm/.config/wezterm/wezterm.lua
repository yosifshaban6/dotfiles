-- Import WezTerm API
local wezterm = require 'wezterm'

-- #############################
-- # Utility Functions
-- #############################

-- Default opacity for window background
local window_background_opacity = 1

-- Function to toggle window background opacity
local function toggle_window_background_opacity(window)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = 0.95 -- Set semi-transparent
    else
        overrides.window_background_opacity = nil -- Reset to default
    end
    window:set_config_overrides(overrides)
end
wezterm.on("toggle-window-background-opacity", toggle_window_background_opacity)


-- Function to toggle ligatures dynamically
local function toggle_ligatures(window)
    local overrides = window:get_config_overrides() or {}

    if not overrides.harfbuzz_features then
        overrides.harfbuzz_features = { 'calt=0', 'liga=0', 'clig=0', 'dlig=0' }
    else
        overrides.harfbuzz_features = nil 
    end

    window:set_config_overrides(overrides)
end

-- local function toggle_ligatures(window)
--     local overrides = window:get_config_overrides() or {}
--     if not overrides.harfbuzz_features then
--         overrides.harfbuzz_features = { 'calt', 'liga', 'clig', 'dlig' } -- Enable ligatures
--     else
--         overrides.harfbuzz_features = {} -- Explicitly disable ligatures
--     end
--     window:set_config_overrides(overrides)
-- end
wezterm.on("toggle-ligatures", toggle_ligatures)

-- #############################
-- # Color Scheme Selection
-- #############################

-- Function to determine color scheme based on system theme
local function color_scheme_for_appearance(appearance)
    if appearance:find "Dark" then
        return "Catppuccin Mocha" -- Dark mode color scheme
    else
        return "Catppuccin Latte" -- Light mode color scheme
    end
end 

-- #############################
-- # Initialize Configuration
-- #############################

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- #############################
-- # Appearance Settings
-- #############################

config.font = wezterm.font("Fira Code", { weight = "Regular" }) -- Set font
config.font_size = 14.0 -- Set font size
config.color_scheme = color_scheme_for_appearance(wezterm.gui.get_appearance()) -- Apply color scheme
config.window_background_opacity = window_background_opacity -- Default opacity
config.window_decorations = "RESIZE" -- Allow resizing
config.hide_tab_bar_if_only_one_tab = true -- Hide tab bar if only one tab exists
config.use_fancy_tab_bar = false -- Disable fancy tab bar

-- #############################
-- # Keybindings
-- #############################

config.keys = {
    {
        key = 'A',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.QuickSelect, -- Activate QuickSelect (useful for selecting text)
    },
    {
        key = "O",
        mods = 'CTRL|SHIFT',
        action = wezterm.action.EmitEvent("toggle-window-background-opacity"), -- Toggle opacity
    },
    {
        key = "E",
        mods = 'CTRL|SHIFT',
        action = wezterm.action.EmitEvent("toggle-ligatures"), -- Toggle ligatures
    },
    {
        key = ',',
        mods = 'CTRL|ALT',
        action = wezterm.action.SpawnCommandInNewWindow({
            cwd = os.getenv 'WEZTERM_CONFIG_DIR',
            args = { os.getenv 'SHELL', '-c', 'vi ~/dotfiles/wezterm/.config/wezterm/wezterm.lua' },
        }), -- Open config file in Vi
    },
}

-- #############################
-- # Finalize and Return Config
-- #############################
return config