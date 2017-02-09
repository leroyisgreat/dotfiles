-- {{

    -- Awesome WM Config Hodgepodge
    -- github.com/leroyisgreat with source from github.com/copycat-killer        

-- }}

-- {{{ Required libraries
    local gears         = require("gears")
    local awful         = require("awful")
    awful.rules         = require("awful.rules")
                          require("awful.autofocus")
    local wibox         = require("wibox")
    local beautiful     = require("beautiful")
    local naughty       = require("naughty")
    local drop          = require("scratchdrop")
    local lain          = require("lain")
-- }}}

-- {{{ Error handling
    if awesome.startup_errors then
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, there were errors during startup!",
                         text = awesome.startup_errors })
    end

    do
        local in_error = false
        awesome.connect_signal("debug::error", function (err)
            if in_error then return end
            in_error = true

            naughty.notify({ preset = naughty.config.presets.critical,
                             title = "Oops, an error happened!",
                             text = err })
            in_error = false
        end)
    end
-- }}}

-- {{{ Autostart applications
    function run_once(cmd)
      findme = cmd
      firstspace = cmd:find(" ")
      if firstspace then
         findme = cmd:sub(0, firstspace-1)
      end
      awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
    end

    run_once("compton -b")
    run_once("unclutter -root")
    --run_once("conky")
-- }}}

-- {{{ Variable definitions
    -- beautiful init
    beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/vapor1/theme.lua")

    -- common
    modkey     = "Mod4"
    altkey     = "Mod1"
    terminal   = "termite"
    editor     = os.getenv("EDITOR") or "vim"
    editor_cmd = terminal .. " -e " .. editor

    -- user defined
    browser    = "chromium --enable-dom-distiller"
    graphics   = "gimp"
    lock       = "xscreensaver-command -lock"

    local layouts = {
        awful.layout.suit.floating,
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.tile.top,
        awful.layout.suit.fair,
        awful.layout.suit.fair.horizontal,
        awful.layout.suit.spiral,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.max,
        -- 10
        lain.layout.termfair,
        lain.layout.cascade,
        lain.layout.cascadetile,
        lain.layout.uselessfair,
        lain.layout.uselesstile,
        -- 15
    }
-- }}}

-- {{{ Tags
tags = {
   --names = { "α", "β", "γ", "δ", "ε", "ζ", "η", "θ" },
   names = { "☹", "☹", "☹", "☹", "☹", "☹", "☹", "☹" },
   layout = { layouts[3], layouts[3], layouts[3], layouts[3], 
              layouts[3], layouts[3], layouts[3], layouts[3] }
}
for s = 1, screen.count() do
-- Each screen has its own tag table.
   tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Wallpaper
    if beautiful.wallpaper then
        for s = 1, screen.count() do
            gears.wallpaper.maximized(beautiful.wallpaper, s, true)
        end
    end
-- }}}

-- {{{ Freedesktop Menu
    --mymainmenu = awful.menu.new({ args = freedesktop.menu.build() })
-- }}}

-- {{{ Wibox
    markup      = lain.util.markup

    -- Textclock
    mytextclock = lain.widgets.abase({
        timeout  = 60,
        cmd      = "date +'%a %d %b %R'",
        settings = function()
            local t_output = ""
            local o_it = string.gmatch(output, "%S+")

            t_output = o_it(1)
            for i=2,3 do t_output = t_output .. " " .. o_it(i) end

            widget:set_markup(t_output .. " " .. o_it(1) .. " ")
        end
    })

    -- Calendar
    lain.widgets.calendar:attach(mytextclock, { font_size = 10 })

    -- root fs
    fswidget = lain.widgets.fs({
        settings  = function()
            widget:set_markup("🖫 " .. fs_now.used .. "%")
        end
    })

    -- CPU
    cpuwidget = lain.widgets.cpu({
        settings = function()
            widget:set_markup(cpu_now.usage .. "%")
        end
    })

    -- Coretemp
    tempwidget = lain.widgets.temp({
        settings = function()
            widget:set_markup(coretemp_now .. "°C")
        end
    })

    -- Battery
    batwidget = lain.widgets.bat({
        settings = function()
            if bat_now.perc == "N/A" then
                perc = "🔌 AC"
            else
                perc = "🔋 " .. bat_now.perc .. "%"
            end
            widget:set_markup(perc)
        end
    })

    -- ALSA volume
    volumewidget = lain.widgets.alsa({
        settings = function()
            if volume_now.status == "off" then
                volume_now.level = volume_now.level .. "M"
            end

            widget:set_markup("🔊 " .. volume_now.level .. "%")
        end
    })

    -- Net
    netinfo = lain.widgets.net({
        settings = function()
            --widget:set_markup(net_now.sent .. "/" .. net_now.received)
            widget:set_markup(net_now.ssid)
        end
    })

    -- MEM
    memwidget = lain.widgets.mem({
        settings = function()
            widget:set_markup("🐏 " .. mem_now.used .. "M")
        end
    })

    -- Spacer
    spacer = wibox.widget.textbox(" ")
    div = wibox.widget.textbox(" | ")
-- }}}

-- {{{ Layout
    -- Create a wibox for each screen and add it
    mywibox = {}
    mypromptbox = {}
    mytaglist = {}
    mytaglist.buttons = awful.util.table.join(
                        awful.button({ }, 1, awful.tag.viewonly),
                        awful.button({ modkey }, 1, awful.client.movetotag),
                        awful.button({ }, 3, awful.tag.viewtoggle),
                        awful.button({ modkey }, 3, awful.client.toggletag),
                        awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                        awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                        )
    mytasklist = {}
    mytasklist.buttons = awful.util.table.join(
                         awful.button({ }, 1, function (c)
                                                  if c == client.focus then
                                                      c.minimized = true
                                                  else
                                                      -- Without this, the following
                                                      -- :isvisible() makes no sense
                                                      c.minimized = false
                                                      if not c:isvisible() then
                                                          awful.tag.viewonly(c:tags()[1])
                                                      end
                                                      -- This will also un-minimize
                                                      -- the client, if needed
                                                      client.focus = c
                                                      c:raise()
                                                  end
                                              end),
                         awful.button({ }, 3, function ()
                                                  if instance then
                                                      instance:hide()
                                                      instance = nil
                                                  else
                                                      instance = awful.menu.clients({ width=250 })
                                                  end
                                              end),
                         awful.button({ }, 4, function ()
                                                  awful.client.focus.byidx(1)
                                                  if client.focus then client.focus:raise() end
                                              end),
                         awful.button({ }, 5, function ()
                                                  awful.client.focus.byidx(-1)
                                                  if client.focus then client.focus:raise() end
                                              end))

    for s = 1, screen.count() do

        -- Create a promptbox for each screen
        mypromptbox[s] = awful.widget.prompt()

        -- Create a taglist widget
        mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

        -- Create a tasklist widget
        mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

        -- Create the upper wibox
        mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = beautiful.border_width })

        -- Widgets that are aligned to the upper left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(mytaglist[s])
        left_layout:add(mypromptbox[s])

        -- Widgets that are aligned to the upper right
        local right_layout = wibox.layout.fixed.horizontal()
        if s == 1 then right_layout:add(wibox.widget.systray()) end
        right_layout:add(netinfo)
        right_layout:add(div)
        right_layout:add(volumewidget)
        right_layout:add(div)
        right_layout:add(memwidget)
        right_layout:add(div)
        right_layout:add(cpuwidget)
        right_layout:add(div)
        right_layout:add(fswidget)
        right_layout:add(div)
        right_layout:add(tempwidget)
        right_layout:add(div)
        right_layout:add(batwidget)
        right_layout:add(div)
        right_layout:add(mytextclock)

        -- Now bring it all together (with the tasklist in the middle)
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_middle(mytasklist[s])
        layout:set_right(right_layout)

        mywibox[s]:set_widget(layout)

        -- Widgets that are aligned to the bottom right
        --bottom_right_layout = wibox.layout.fixed.horizontal()
        --bottom_right_layout:add(mylayoutbox[s])

        -- Now bring it all together (with the tasklist in the middle)
        bottom_layout = wibox.layout.align.horizontal()
        bottom_layout:set_left(bottom_left_layout)
        bottom_layout:set_middle(mytasklist[s])
        bottom_layout:set_right(bottom_right_layout)
    end
-- }}}

-- {{{ Mouse Bindings
    root.buttons(awful.util.table.join(
        --awful.button({ }, 3, function () mymainmenu:toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
    ))
-- }}}

-- {{{ Key bindings
    globalkeys = awful.util.table.join(
        -- Take a screenshot
        -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
        awful.key({ modkey }, "Print", function() 
                os.execute("screenshot")
                naughty.notify({ text = "screenshot taken", timeout = 3 })
            end),

        -- Tag browsing
        awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
        awful.key({ modkey }, "Right",  awful.tag.viewnext       ),
        awful.key({ modkey }, "Escape", awful.tag.history.restore),

        -- Non-empty tag browsing
        awful.key({ modkey, altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
        awful.key({ modkey, altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

        -- Default client focus
        awful.key({ altkey }, "k",
            function ()
                awful.client.focus.byidx( 1)
                if client.focus then client.focus:raise() end
            end),
        awful.key({ altkey }, "j",
            function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
            end),

        -- By direction client focus
        awful.key({ modkey }, "j",
            function()
                awful.client.focus.bydirection("down")
                if client.focus then client.focus:raise() end
            end),
        awful.key({ modkey }, "k",
            function()
                awful.client.focus.bydirection("up")
                if client.focus then client.focus:raise() end
            end),
        awful.key({ modkey }, "h",
            function()
                awful.client.focus.bydirection("left")
                if client.focus then client.focus:raise() end
            end),
        awful.key({ modkey }, "l",
            function()
                awful.client.focus.bydirection("right")
                if client.focus then client.focus:raise() end
            end),

        -- Show Menu
        awful.key({ modkey }, "w",
            function ()
                --mymainmenu:show({ keygrabber = true })
            end),

        -- Show/Hide Wibox
        awful.key({ modkey }, "b", function ()
            mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
            mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
        end),

        -- Layout manipulation
        awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
        awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
        awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
        awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
        awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
        awful.key({ modkey,           }, "Tab",
            function ()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end),
        awful.key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 0.05)     end),
        awful.key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-0.05)     end),
        awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
        awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
        awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
        awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
        awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
        awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
        awful.key({ modkey, "Control" }, "n",      awful.client.restore),

        -- Standard program
        awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
        awful.key({ modkey, "Control" }, "r",      awesome.restart),
        -- I hardly ever want to quit Awesome, I usually just want to shutdown or reboot.
        awful.key({ modkey, "Control", "Shift"   }, "q",      awesome.quit),

        -- Dropdown terminal
        awful.key({ modkey,	          }, "z",      function () drop(terminal, "top", "center", .7) end),

        -- Widgets popups
        awful.key({ altkey,           }, "c",      function () lain.widgets.calendar:show(7) end),
        awful.key({ altkey,           }, "h",      function () fswidget.show(7) end),

        -- ALSA volume control
        awful.key({ }, "XF86AudioRaiseVolume",
            function () 
                awful.util.spawn("amixer set Master 5%+") 
                volumewidget.update()
            end),
        awful.key({ }, "XF86AudioLowerVolume",
            function () 
                awful.util.spawn("amixer set Master 5%-") 
                volumewidget.update()
            end),
    awful.key({ }, "XF86AudioMute",
        function ()
            awful.util.spawn("amixer sset Master toggle")
            volumewidget.update()
        end),

        -- Copy to clipboard
        awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),

        -- User programs
        awful.key({ modkey }, "q", function () awful.util.spawn(browser) end),
        awful.key({ modkey }, "g", function () awful.util.spawn(graphics) end),

        -- Screen lock
        awful.key({ modkey, "Control" }, "l", function () awful.util.spawn(lock) end),

        -- Brightness
        awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 15") end),
        awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 15") end),

        -- Prompt
        awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
        awful.key({ modkey }, "x",
                  function ()
                      awful.prompt.run({ prompt = "Run Lua code: " },
                      mypromptbox[mouse.screen].widget,
                      awful.util.eval, nil,
                      awful.util.getdir("cache") .. "/history_eval")
                  end)
    )

    clientkeys = awful.util.table.join(
        awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
        awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
        awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
        awful.key({ modkey,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end),
        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c.maximized_vertical   = not c.maximized_vertical
            end)
    )

    -- Bind all key numbers to tags.
    -- be careful: we use keycodes to make it works on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    for i = 1, 9 do
        globalkeys = awful.util.table.join(globalkeys,
            -- View tag only.
            awful.key({ modkey }, "#" .. i + 9,
                      function ()
                            local screen = mouse.screen
                            local tag = awful.tag.gettags(screen)[i]
                            if tag then
                               awful.tag.viewonly(tag)
                            end
                      end),
            -- Toggle tag.
            awful.key({ modkey, "Control" }, "#" .. i + 9,
                      function ()
                          local screen = mouse.screen
                          local tag = awful.tag.gettags(screen)[i]
                          if tag then
                             awful.tag.viewtoggle(tag)
                          end
                      end),
            -- Move client to tag.
            awful.key({ modkey, "Shift" }, "#" .. i + 9,
                      function ()
                          if client.focus then
                              local tag = awful.tag.gettags(client.focus.screen)[i]
                              if tag then
                                  awful.client.movetotag(tag)
                              end
                         end
                      end),
            -- Toggle tag.
            awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                      function ()
                          if client.focus then
                              local tag = awful.tag.gettags(client.focus.screen)[i]
                              if tag then
                                  awful.client.toggletag(tag)
                              end
                          end
                      end))
    end

    clientbuttons = awful.util.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize))

    -- Set keys
    root.keys(globalkeys)
-- }}}

-- {{{ Rules
    awful.rules.rules = {
        -- All clients will match this rule.
        { rule = { },
          properties = { border_width = beautiful.border_width,
                         border_color = beautiful.border_normal,
                         focus = awful.client.focus.filter,
                         keys = clientkeys,
                         buttons = clientbuttons,
                           size_hints_honor = false } },

        { rule = { class = "Termite" },
            properties = { opacity = 1 } },

        { rule = { class = browser },
            properties = { tag = tags[1][1] } },

        { rule = { instance = "plugin-container" },
            properties = { tag = tags[1][1] } },

        { rule = { class = graphics },
            properties = { tag = tags[1][4] } },
    }
-- }}}

-- {{{ Signals
    -- signal function to execute when a new client appears.
    local sloppyfocus_last = {c=nil}
    client.connect_signal("manage", function (c, startup)
        -- Enable sloppy focus
        client.connect_signal("mouse::enter", function(c)
             if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                and awful.client.focus.filter(c) then
                 -- Skip focusing the client if the mouse wasn't moved.
                 if c ~= sloppyfocus_last.c then
                     client.focus = c
                     sloppyfocus_last.c = c
                 end
             end
         end)

        local titlebars_enabled = false
        if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
            -- buttons for the titlebar
            local buttons = awful.util.table.join(
                    awful.button({ }, 1, function()
                        client.focus = c
                        c:raise()
                        awful.mouse.client.move(c)
                    end),
                    awful.button({ }, 3, function()
                        client.focus = c
                        c:raise()
                        awful.mouse.client.resize(c)
                    end)
                    )

            -- widgets that are aligned to the right
            local right_layout = wibox.layout.fixed.horizontal()
            right_layout:add(awful.titlebar.widget.floatingbutton(c))
            right_layout:add(awful.titlebar.widget.maximizedbutton(c))
            right_layout:add(awful.titlebar.widget.stickybutton(c))
            right_layout:add(awful.titlebar.widget.ontopbutton(c))
            right_layout:add(awful.titlebar.widget.closebutton(c))

            -- the title goes in the middle
            local middle_layout = wibox.layout.flex.horizontal()
            local title = awful.titlebar.widget.titlewidget(c)
            title:set_align("center")
            middle_layout:add(title)
            middle_layout:buttons(buttons)

            -- now bring it all together
            local layout = wibox.layout.align.horizontal()
            layout:set_right(right_layout)
            layout:set_middle(middle_layout)

            awful.titlebar(c,{size=16}):set_widget(layout)
        end
    end)

    -- Focus & Transparency
    client.connect_signal("focus", function(c)
        c.border_color = beautiful.border_focus
        --c.opacity = 1
    end)
    client.connect_signal("unfocus", function(c)
        c.border_color = beautiful.border_normal
        --c.opacity = 0.95
    end)
-- }}}

-- {{{ Arrange signal handler
    for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
            local clients = awful.client.visible(s)
            local layout  = awful.layout.getname(awful.layout.get(s))

            if #clients > 0 then -- Fine grained borders and floaters control
                for _, c in pairs(clients) do -- Floaters always have borders
                    -- No borders with only one humanly visible client
                    if layout == "max" then
                        c.border_width = 0
                    elseif awful.client.floating.get(c) or layout == "floating" then
                        c.border_width = beautiful.border_width
                    elseif #clients == 1 then
                        clients[1].border_width = 0
                        if layout ~= "max" then
                            awful.client.moveresize(0, 0, 2, 0, clients[1])
                        end
                    else
                        c.border_width = beautiful.border_width
                    end
                end
            end
          end)
    end
-- }}}

-- Finishing Touches {{{
    naughty.notify({ position = "bottom_right",
                     text = "強くなりたい", 
                     timeout = 10 })
-- }}}
