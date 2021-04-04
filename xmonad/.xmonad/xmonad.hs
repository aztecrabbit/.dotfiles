import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Control.Monad (liftM2)

import XMonad.Actions.CycleWS
import XMonad.Actions.Minimize
import XMonad.Actions.Navigation2D
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Grid
import XMonad.Layout.Minimize
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal :: String
myTerminal = "~/.scripts/st.sh"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod1Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces = ["1","2","3","4","5","6","7","8","9","0"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#191919"
myFocusedBorderColor = "#353535"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- Super Key
    , ((mod4Mask,               xK_Tab ), sendMessage NextLayout)
    , ((mod4Mask .|. shiftMask, xK_Tab ), setLayout $ XMonad.layoutHook conf)
    ]
    ++

    -- Workspace
    --

    [((m .|. mod4Mask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


    {--
        -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
        -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
        --

        [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    --}


myCustomKeys :: [(String, X ())]
myCustomKeys =
    -- System
    [ ("<Pause> <Pause>", spawn "systemctl poweroff")
    , ("M-S-<Pause>"    , spawn "systemctl reboot")

    -- Xmonad
    , ("M-S-r"          , spawn "notify-send -t 3000 'Restarting Xmonad ...'; xmonad --recompile; xmonad --restart")
    , ("M-S-<Escape>"   , io (exitWith ExitSuccess))

    -- Change workspace
    , ("M4-<Left>"      , prevWS)
    , ("M4-<Right>"     , nextWS)

    -- Show Hide window
    , ("M4-<Up>"        , withLastMinimized maximizeWindowAndFocus)
    , ("M4-<Down>"      , withFocused minimizeWindow >> windows W.focusUp)

    -- Increment Deincrement the number of windows in the master area
    , ("M-,"            , sendMessage (IncMasterN 1))
    , ("M-."            , sendMessage (IncMasterN (-1)))

    -- Shrink Expand the master area
    , ("M-h"            , sendMessage Shrink)
    , ("M-l"            , sendMessage Expand)

    -- Push window back into tiling
    , ("M-t"            , withFocused $ windows . W.sink)

    -- Move and Swap focus to the master window
    , ("M-m"            , windows W.focusMaster)
    , ("M-S-<Return>"   , windows W.swapMaster)

    -- Move focus to the next previous window
    , ("M-<Tab>"        , windows W.focusDown)
    , ("M-S-<Tab>"      , windows W.focusUp  )

    -- Directional navigation of windows
    , ("M-<Right>"      , windowGo R False)
    , ("M-<Left>"       , windowGo L False)
    , ("M-<Up>"         , windowGo U False)
    , ("M-<Down>"       , windowGo D False)

    -- Swap adjacent windows
    , ("M-S-<Right>"    , windowSwap R False)
    , ("M-S-<Left>"     , windowSwap L False)
    , ("M-S-<Up>"       , windowSwap U False)
    , ("M-S-<Down>"     , windowSwap D False)

    -- Close focused window
    , ("M-q"            , kill)

    -- Resize viewed windows to the correct size
    -- , ("M-n"            , refresh)

    -- Toggle the status bar gap
    -- , ("M-b"            , sendMessage ToggleStruts)

    -- Launcher
    , ("M-<Space>"      , spawn "~/.scripts/dmenu_run.sh")
    , ("M-S-<Space>"    , spawn "rofi -show drun")

    -- MPC MPD
    , ("M-p p"          , spawn "mpc toggle")
    , ("M-p s"          , spawn "mpc stop")
    , ("M-p -"          , spawn "mpc vol -5")
    , ("M-p ="          , spawn "mpc vol +5")
    , ("M-p +"          , spawn "mpc vol +5")
    , ("M-p S-,"        , spawn "mpc prev")
    , ("M-p S-."        , spawn "mpc next")
    , ("M-S-p"          , spawn "mpc next")
    , ("M-p m"          , spawn "mpc clear && mpc load music && mpc random on && mpc play")
    , ("M-p r"          , spawn "mpc clear && mpc load radio && mpc random on && mpc play")
    , ("M-p S-m"        , spawn "~/.scripts/mpd-refresh-music.sh")
    , ("M-p S-r"        , spawn "~/.scripts/mpd-refresh-radio.sh")

    -- Screenshot
    , ("<Print>"        , spawn "~/.scripts/screenshot.sh")
    , ("S-<Print>"      , spawn "~/.scripts/screenshot.sh select")
    , ("C-<Print>"      , spawn "~/.scripts/screenshot.sh freeze")
    , ("C-S-<Print>"    , spawn "~/.scripts/screenshot.sh freeze-now")

    -- Launch app
    , ("M4-S-b"         , spawn "~/.scripts/launch-app.sh 'falkon' 'Falkon'")
    , ("M4-c"           , spawn "~/.scripts/launch-app.sh 'code' 'VS Code'")
    , ("M4-f"           , spawn "~/.scripts/launch-app.sh 'thunar' 'Thunar'")
    , ("M4-s"           , spawn "~/.scripts/launch-app.sh 'subl' 'Sublime Text'")
    , ("M4-t"           , spawn "~/.scripts/launch-app.sh 'telegram-desktop' 'Telegram'")
    , ("M4-x"           , spawn "~/.scripts/launch-app.sh 'xdman' 'Xtream Download Manager'")
    , ("M4-y"           , spawn "~/.scripts/launch-app.sh 'gtk-youtube-viewer' 'YouTube Viewer'")
    ]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((mod4Mask, button1), (\w -> focus w >> mouseMoveWindow w))
    , ((mod4Mask, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((mod4Mask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- Change workspace
    , ((mod4Mask, button4), (\_ -> prevWS))
    , ((mod4Mask, button5), (\_ -> nextWS))
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts $ spacingRaw False (Border 1 224 1 664) True (Border 2 2 2 2) True
    $ onWorkspaces ["1"] (tiled ||| grid)
    $ onWorkspaces ["2","3","4","5"] (masterTiled ||| grid)
    $ onWorkspaces ["0"] (grid ||| tiled)
    $ tiled ||| masterTiled ||| grid
    where
        masterTiled = minimize $ Tall 1 (2/100) (65/100)
        tiled = minimize $ Tall 1 (2/100) (35/100)
        grid = minimize $ Grid

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = insertPosition End Newer <+> composeAll
    [ className =? "Code"            --> viewShift (myWorkspaces !! 1)
    , className =? "Subl"            --> viewShift (myWorkspaces !! 1)
    , className =? "Chromium"        --> viewShift (myWorkspaces !! 2)
    , className =? "Falkon"          --> viewShift (myWorkspaces !! 2)
    , className =? "Thunar"          --> viewShift (myWorkspaces !! 3)
    , className =? "mpv"             --> viewShift (myWorkspaces !! 4)
    , className =? "TelegramDesktop" --> viewShift (myWorkspaces !! 5)
    , className =? "GParted"         --> doFloat
    , className =? "xdman-Main"      --> doFloat
    ]
    where
        viewShift = doF . liftM2 (.) W.greedyView W.shift

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myLogHook xmproc = dynamicLogWithPP $ xmobarPP
    { ppOutput = hPutStrLn xmproc
    , ppCurrent = xmobarColor "#eaeaea" ""
    , ppVisible = xmobarColor "#dadada" ""                 -- Visible but not current workspace
    , ppHidden = xmobarColor "#898989" ""                  -- Hidden workspaces
    , ppHiddenNoWindows = xmobarColor "#444444" ""         -- Hidden workspaces (no windows)
    , ppUrgent = xmobarColor "#C45500" "" . wrap "*" ""    -- Urgent workspace
    , ppLayout = xmobarColor "#eaeaea" ""
    , ppTitle = xmobarColor "#eaeaea" "" . shorten 64      -- Title of active window
    , ppSep = "  :  "
    , ppWsSep = "  "
    , ppExtras  = [windowCount]
    , ppOrder  = \(ws:l:t:e) -> [ws] ++ e ++ [l]
    }

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = spawn "~/.xmonad/autostart"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ withNavigation2DConfig def $ docks def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook xmproc,
        startupHook        = myStartupHook
    } `additionalKeysP` myCustomKeys
