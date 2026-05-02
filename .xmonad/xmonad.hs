{-# OPTIONS_GHC -Wno-deprecations #-}

-- Imports - core xmonad functionality and extensions
import XMonad
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce

-- Layouts - window layout definitions
myLayout = avoidStruts
  (spacingRaw True (Border 3 3 3 3) True (Border 3 3 3 3) True
    (tiled ||| Mirror tiled ||| Full ||| threeCol))
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1
    ratio    = 1/2
    delta    = 3/100

-- Managehook - special rules for certain windows
myManageHook = composeAll
  [ className =? "Gimp" --> doFloat
  , isDialog            --> doFloat
  ]

-- StartupHook - commands executed on xmonad startup
myStartupHook :: X ()
myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"
    spawnOnce "pkill polybar; polybar mybar --config='~/.config/polybar/config.ini'"
    spawnOnce "xset s off"
    spawnOnce "xset -dpms"
    spawnOnce "xset s 0 0"
    spawnOnce "xmodmap ~/.Xmodmap"

-- Configuration - main xmonad settings
myConfig = def
  { modMask            = mod4Mask
  , terminal           = "kitty"
  , layoutHook         = myLayout
  , manageHook         = myManageHook
  , startupHook        = myStartupHook
  , borderWidth        = 3
  , focusedBorderColor = "#00ffcc"
  , normalBorderColor  = "#ebdbb2"
  }

-- Main - xmonad entry point
main :: IO ()
main =
    xmonad
      $ docks
      $ ewmh
      $ myConfig
        `additionalKeysP`
        [ ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
        , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
        , ("<XF86AudioMute>",        spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
        
        --, ("M-C-s", unGrab *> spawn "scrot -s")
        , ("M-b",   sendMessage ToggleStruts)
        , ("M-o",   spawn "~/.config/rofi/launchers/type-4/launcher.sh")
        , ("M-w",   kill)
        
        , ("M-.",   spawn "gnome-characters")
        , ("M-,",   spawn "nautilus")
        , ("M-S-'", spawn "gnome-terminal")

        , ("M-f",   spawn "firefox")
        , ("M-S-g", spawn "chromium")

        , ("M-x",   spawn "emacs")
        , ("M-S-l", spawn "logseq")
        , ("M-S-c", spawn "code")
        , ("M-S-v", spawn "vnote")
        , ("M-S-n", spawn "flatpak run io.github.brunofin.Cohesion --disable-spellcheck")
        , ("C-A-k", spawn "xkill")
        ]
