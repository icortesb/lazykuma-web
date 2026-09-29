# Recording of the demo GIF on the landing page and in the docs.
#
#   demo/demo.sh
#
# Everything on screen belongs to the containers demo.sh starts: two
# throwaway Uptime Kuma instances and a shell with lazykuma in it. The
# machine doing the recording never appears in the frame.

Output landing/assets/demo.gif

Set Shell bash
Set FontSize 15
Set Width 1140
Set Height 560
Set Padding 22
Set Framerate 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 60ms

Hide
Type "podman exec -it --user ops -w /home/ops -e COLORTERM=truecolor lkdemo-shell bash" Enter
Sleep 2s
Type "PS1='$ '" Enter
Type "printf '\033[H\033[2J\033[3J'" Enter
Show

Type "lazykuma" Enter
Sleep 3s

# The menu: both instances answer. Open "home".
Enter
Sleep 2500ms

# Groups, with their worst monitor's state; the router is down.
Down
Sleep 2500ms
Down
Sleep 1500ms

# A monitor at full size: uptime, the ping chart over a day, 6 hours and
# the last hour, its beats and events.
Enter
Sleep 2s
Left
Sleep 1500ms
Left
Sleep 3s
Escape
Sleep 800ms

# Tags, and searching by them.
Type "t"
Sleep 2s
Escape
Sleep 500ms
Type "/"
Sleep 400ms
Type "lan"
Sleep 2s
Escape
Sleep 800ms

# Status pages, and the sections of one.
Type "S"
Sleep 2s
Down
Sleep 700ms
Type "s"
Sleep 2500ms
Escape
Sleep 500ms
Escape
Sleep 500ms

# Back to the menu, where background alerts are switched on and off.
Escape
Sleep 1s
Down
Sleep 400ms
Down
Sleep 400ms
Down
Sleep 2s

Type "q"
Sleep 800ms
