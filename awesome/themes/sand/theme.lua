theme                               = {}

theme.confdir                       = os.getenv("HOME") .. "/.config/awesome/themes/sand"
theme.wallpaper                     = theme.confdir .. "/wall.png"

theme.font                          = "Source Code Pro Bold 8"
theme.bg_normal                     = "#1F1F1F"
theme.bg_focus                      = theme.bf_normal
theme.bg_urgent                     = theme.bf_normal
theme.fg_normal                     = "#C0B18B"
theme.fg_focus                      = "#BD925E"
theme.fg_urgent                     = "#855B66"
theme.fg_minimize                   = "#5E6969"
theme.border_width                  = "2"
theme.border_normal                 = "#303030"
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

theme.submenu_icon                  = theme.confdir .. "/icons/submenu.png"
theme.widget_temp                   = theme.confdir .. "/icons/temp.png"
theme.widget_uptime                 = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                    = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                = theme.confdir .. "/icons/dish.png"
theme.widget_fs                     = theme.confdir .. "/icons/fs.png"
theme.widget_mem                    = theme.confdir .. "/icons/mem.png"
theme.widget_fs                     = theme.confdir .. "/icons/fs.png"
theme.widget_note                   = theme.confdir .. "/icons/note.png"
theme.widget_note_on                = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown                = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                  = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                   = theme.confdir .. "/icons/mail.png"
theme.widget_batt                   = theme.confdir .. "/icons/bat.png"
theme.widget_clock                  = theme.confdir .. "/icons/clock.png"
theme.widget_vol                    = theme.confdir .. "/icons/spkr.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- lain related
theme.useless_gap_width             = 10

return theme
