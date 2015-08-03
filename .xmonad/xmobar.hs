Config { font = "xft:Source Code Pro:size=9:bold:antialias=true"
       , bgColor = "#66023c"
       , fgColor = "#afd34d"
       , position = Top
       , lowerOnStart = True
       , commands = [ Run Com "/home/leroyce/.bin/wireless.sh" [] "wifi" 30
                    , Run Com "/home/leroyce/.bin/volume.sh" [] "vol" 10
                    , Run Cpu ["-t", " CPU: <total>%", "-L","3","-H","50","--normal","green","--high","red"] 10
                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Date "<fc=#a83d88>%a %b %_d %Y %H:%M</fc>" "date" 10
                    , Run DiskU [("/", "<freep>%")] [] 30
                    , Run BatteryP ["BAT0"] ["-t", "<acstatus> (<left>%)"] 60
                    , Run StdinReader
                    ]
       , sepChar = "$"
       , alignSep = "}{"
       , template = "$StdinReader$ }{ $cpu$ | $memory$ | $wifi$ | Root: $disku$ | $battery$ | $vol$ | $date$ "
       }
