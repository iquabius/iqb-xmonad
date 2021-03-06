import XMonad
import XMonad.Actions.DynamicProjects
  ( Project(..)
  , dynamicProjects
  , lookupProject
  , shiftToProjectPrompt
  , switchProject
  , switchProjectPrompt
  )
import XMonad.Actions.SpawnOn (spawnOn)
import XMonad.Hooks.DynamicLog (ppCurrent, ppTitle, ppSep, statusBar, wrap, xmobarColor, xmobarPP)
import XMonad.Prompt
import XMonad.Util.EZConfig (additionalKeysP)

myTerminal = "xfce4-terminal"
myLauncher = "rofi -matching fuzzy -modi combi -show combi -combi-modi drun,run"

----------------------------------------------------------------------------------------------
---KEYBINDINGS
----------------------------------------------------------------------------------------------
myKeys =
  [ ("M-q",               spawn "xmonad --restart")                       -- Restart XMonad
  , ("M-C-q",             spawn "xmonad --recompile && xmonad --restart") -- Rebuild & restart XMonad
  , ("M-C-<Tab>"        , sendMessage NextLayout)

  -- Apps
  , ("M-<Return>"       , spawn myTerminal)
  , ("M-<Space>"        , spawn myLauncher)

  -- Workspaces & Projects
  , ("M-w"              , switchProjectPrompt coolPromptTheme)
  , ("M-S-w"            , shiftToProjectPrompt coolPromptTheme)
  , ("M-o"              , switchProject olimatProject)
  ]

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
  , modMask            = mod4Mask         -- set 'Mod' to super/windows key
  , terminal           = myTerminal       -- for Mod + Shift + Enter
  , workspaces         = myWorkspaces
  } `additionalKeysP` myKeys

myStatusBar = "xmobar /home/iquabius/.xmonad/xmobar.conf"

----------------------------------------------------------------------------------------------
-- Workspaces
----------------------------------------------------------------------------------------------

wsDev   = "dev"
wsWww   = "www"
wsEmacs = "emacs"
wsMedia = "media"
wsChat  = "chat"

-- myWorkspaces = map show [1..9]
myWorkspaces :: [String]
myWorkspaces = [wsDev, wsWww, wsEmacs, wsMedia, wsChat]

olimatProjectName = "OliMAT"
olimatProject =
  Project
    { projectName = olimatProjectName
    , projectDirectory = "~/Code/Unemat/olimat"
    , projectStartHook =
        Just $ do spawnOn olimatProjectName (myTerminal ++ " -x byobu new -s OliMAT")
                  -- spawn "code ~/Code/Unemat/olimat"
    }

projects :: [Project]
projects = [olimatProject]

-- https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/XMonad-Hooks-DynamicLog.html#v:statusBar
main = xmonad =<< (statusBar myStatusBar myXmobarPP xmobarToggle
                   $ dynamicProjects projects myConfig
                  )

--------------------------------------------------------------------------------
-- Theme
--------------------------------------------------------------------------------

-- colors

base03  = "#002b36"
-- base02  = "#073642"
-- base01  = "#586e75"
-- base00  = "#657b83"
-- base0   = "#839496"
-- base1   = "#93a1a1"
-- base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
-- orange  = "#cb4b16"
-- red     = "#dc322f"
magenta = "#d33682"
-- violet  = "#6c71c4"
blue    = "#268bd2"
-- cyan    = "#2aa198"
-- green   = "#859900"
solarGreen = "#7c7526"          -- variations: #7c7526 #2d7a01 #7c7526

-- sizes
prompt      = 20

myNormalBorderColor     = "#000000"
myFocusedBorderColor    = active

active      = blue
-- activeWarn  = red
-- inactive    = base02
-- focusColor  = blue
-- unfocusColor = base02

-- run 'xfontsel' to check this format
-- run 'xlsfonts' to list all fonts
-- apt install -y xfonts-terminus xfonts-terminus-oblique
myFont = "-*-terminus-medium-*-*-*-17-*-*-*-*-*-*-*"
-- myFont = "-*-bitstream charter-*-r-*-*-17-*-*-*-*-*-*-*"

-- from XMonad.Prompt
myPromptTheme = def
    { font                  = myFont
    , bgColor               = base03
    , fgColor               = active
    , fgHLight              = base3
    , bgHLight              = active
    , borderColor           = base03
    , promptBorderWidth     = 0
    , height                = prompt
    , position              = Top
    }

coolPromptTheme = myPromptTheme
    { bgColor               = solarGreen
    , fgColor               = base3
    , position              = Top
    }

warmPromptTheme = myPromptTheme
    { bgColor               = yellow
    , fgColor               = base03
    , position              = Top
    }
