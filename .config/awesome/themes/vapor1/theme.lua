theme                               = {}

theme.confdir                       = os.getenv("HOME") .. "/.config/awesome/themes/vapor1"
theme.wallpaper                     = theme.confdir .. "/wall.png"

theme.font                          = "Source Code Pro Bold 8"

theme.bg_normal                     = "#2F1E2E"
theme.bg_focus                      = theme.bg_normal
theme.bg_urgent                     = theme.bg_normal
theme.fg_normal                     = "#A39E9B"
theme.fg_focus                      = "#FEC418"
theme.fg_urgent                     = "#EF6155"
theme.fg_minimize                   = "#48B685"

theme.border_width                  = "1"
theme.border_normal                 = theme.fg_normal
theme.border_focus                  = theme.fg_focus
theme.border_marked                 = theme.fg_urgent

theme.menu_width                    = "110"
theme.menu_border_width             = theme.border_width
theme.menu_border_color             = theme.border_normal
theme.menu_fg_normal                = theme.fg_normal
theme.menu_fg_focus                 = theme.fg_focus
theme.menu_bg_normal                = theme.bg_normal
theme.menu_bg_focus                 = theme.bg_focus

theme.taglist_fg_focus              = theme.fg_focus
theme.taglist_fg_urgent             = theme.fg_urgent
theme.taglist_fg_occupied           = theme.fg_minimize
theme.taglist_fg_empty              = theme.fg_normal

theme.notify_fg                     = theme.fg_normal
theme.notify_bg                     = theme.bg_normal
theme.notify_border                 = theme.border_focus

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- {{{ Layout icons
theme.layout_tile       = theme.confdir .. "/icons/layouts/tile.png"
theme.layout_tileleft   = theme.confdir .. "/icons/layouts/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/icons/layouts/tilebottom.png"
theme.layout_tiletop    = theme.confdir .. "/icons/layouts/tiletop.png"
theme.layout_fairv      = theme.confdir .. "/icons/layouts/fairv.png"
theme.layout_fairh      = theme.confdir .. "/icons/layouts/fairh.png"
theme.layout_spiral     = theme.confdir .. "/icons/layouts/spiral.png"
theme.layout_dwindle    = theme.confdir .. "/icons/layouts/dwindle.png"
theme.layout_max        = theme.confdir .. "/icons/layouts/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/layouts/fullscreen.png"
theme.layout_magnifier  = theme.confdir .. "/icons/layouts/magnifier.png"
theme.layout_floating   = theme.confdir .. "/icons/layouts/floating.png"
-- }}}

return theme
