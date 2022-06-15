local wezterm = require 'wezterm';
local initial_config = {
    background = {
        {
            source = {File = "C:\\Users\\ryo\\Pictures\\CG_AO03_0201.png"},
            hsb = {brightness = 0.05},
            repeat_x = "NoRepeat",
            repeat_y = "NoRepeat",
            vertical_align = "Middle",
            horizontal_align = "Center",
            width = 1280,
            height = 720,
        }
    },
}

function recompute_background_image(window)
    local window_dims = window:get_dimensions();
    local overrides = window:get_config_overrides() or {};
    local aspect_ratio_viewpoint = window_dims.pixel_width / window_dims.pixel_height;
    local aspect_ratio_image = 16 / 9

    if next(overrides) ~= nil then
        if aspect_ratio_viewpoint < aspect_ratio_image then
            overrides.background[1].height = window_dims.pixel_height
            overrides.background[1].width = window_dims.pixel_height * aspect_ratio_image
        else
            overrides.background[1].height = window_dims.pixel_width / aspect_ratio_image
            overrides.background[1].width = window_dims.pixel_width
        end
    else
        overrides = initial_config
    end
    window:set_config_overrides(overrides)
end

wezterm.on("window-resized", function(window, pane)
    recompute_background_image(window)
  end);

wezterm.on("window-config-reloaded", function(window)
    recompute_background_image(window)
end);

return {
    default_prog = {"C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-l"},
    font = wezterm.font("SauceCodePro NF", {weight = "DemiBold"}),
    font_size = 11.0,
    default_cursor_style = "SteadyBar",
    initial_rows = 32,
    initial_cols = 130,
    colors = {
        foreground = "#d9d9d9",
        background = "#0e1019",
        cursor_bg = "#d4d4d4",
        cursor_border = "#d4d4d4",
        cursor_fg = "#d4d4d4",
        selection_bg = "#d4d4d4",
        selection_fg = "#000000",
        ansi = {"#0C0C0C","#C50F1F","#13A10E","#C19C00","#0037DA","#881798","#3A96DD","#CCCCCC"},
        brights = {"#767676","#E74856","#16C60C","#F9F1A5","#3B78FF","#B4009E","#61D6D6","#F2F2F2"}
    },
    mouse_bindings = {
        -- Right click sends "woot" to the terminal
        {
          event={Up={streak=1, button="Right"}},
          mods="NONE",
          action=wezterm.action{PasteFrom="Clipboard"}
        },
    }
}