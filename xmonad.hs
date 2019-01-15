-- minimal Ubuntu config file: ~/.xmonad/xmonad.hs
import XMonad
import XMonad.Hooks.DynamicLog

myBlue   = "#0080FF"
myRed    = "#FF4A36"

-- Define custom Pretty Printing option
myXmobarPP = xmobarPP
  { ppCurrent = xmobarColor myBlue "" . wrap "[" "]" -- currently focused workspace
  , ppTitle   = xmobarColor myRed ""                 -- title of currently focused program
  }

-- Function to create the keyboard shortcut to show and hide the bar.
xmobarToggle (XConfig {modMask = modKey}) = (modKey, xK_b)

myConfig = def
  { modMask     = mod4Mask         -- set 'Mod' to windows key
  , terminal    = "xfce4-terminal" -- for Mod + Shift + Enter
  }

-- https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/XMonad-Hooks-DynamicLog.html#v:statusBar
main = xmonad =<< statusBar "xmobar" myXmobarPP xmobarToggle myConfig
