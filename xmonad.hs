import XMonad
import XMonad.Hooks.DynamicLog

myGreen = "#859900"

-- Define custom Pretty Printing option
myXmobarPP = xmobarPP
  { ppCurrent = xmobarColor myGreen "" . wrap "[" "]" -- currently focused workspace
  , ppTitle   = xmobarColor myGreen ""                -- title of currently focused program
  , ppSep =  "<fc=#839496> : </fc>"                   -- Separators in xmobar
  }

-- Function to create the keyboard shortcut to show and hide the bar.
xmobarToggle (XConfig {modMask = modKey}) = (modKey, xK_b)

myConfig = def
  { modMask     = mod4Mask         -- set 'Mod' to windows key
  , terminal    = "xfce4-terminal" -- for Mod + Shift + Enter
  }

myStatusBar = "xmobar /home/iquabius/.xmonad/xmobar.conf"

-- https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/XMonad-Hooks-DynamicLog.html#v:statusBar
main = xmonad =<< statusBar myStatusBar myXmobarPP xmobarToggle myConfig
