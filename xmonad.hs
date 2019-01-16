import XMonad
import XMonad.Hooks.DynamicLog (ppCurrent, ppTitle, ppSep, statusBar, wrap, xmobarColor, xmobarPP)

-- Define custom Pretty Printing option
myXmobarPP = xmobarPP
  { ppCurrent = xmobarColor active "" . wrap "[" "]" -- currently focused workspace
  , ppTitle   = xmobarColor active ""                -- title of currently focused program
  , ppSep     = xmobarColor magenta "" "  :  "       -- Separators in xmobar
  }

-- Function to create the keyboard shortcut to show and hide the bar.
xmobarToggle (XConfig {modMask = modKey}) = (modKey, xK_b)

myConfig = def
  { normalBorderColor  = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , modMask            = mod4Mask         -- set 'Mod' to windows key
  , terminal           = "xfce4-terminal" -- for Mod + Shift + Enter
  }

myStatusBar = "xmobar /home/iquabius/.xmonad/xmobar.conf"

-- https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/XMonad-Hooks-DynamicLog.html#v:statusBar
main = xmonad =<< statusBar myStatusBar myXmobarPP xmobarToggle myConfig

--------------------------------------------------------------------------------
-- Theme
--------------------------------------------------------------------------------

-- colors

-- base03  = "#002b36"
-- base02  = "#073642"
-- base01  = "#586e75"
-- base00  = "#657b83"
-- base0   = "#839496"
-- base1   = "#93a1a1"
-- base2   = "#eee8d5"
-- base3   = "#fdf6e3"
-- yellow  = "#b58900"
-- orange  = "#cb4b16"
-- red     = "#dc322f"
magenta = "#d33682"
-- violet  = "#6c71c4"
blue    = "#268bd2"
-- cyan    = "#2aa198"
-- green   = "#859900"

myNormalBorderColor     = "#000000"
myFocusedBorderColor    = active

active      = blue
-- activeWarn  = red
-- inactive    = base02
-- focusColor  = blue
-- unfocusColor = base02

