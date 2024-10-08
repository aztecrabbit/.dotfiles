import XMonad
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Control.Monad (liftM2, when)
import Data.Char (toUpper)
import Data.Foldable (find)
import Data.Maybe (fromJust)
import Data.Monoid
import Foreign.C (CInt)
import Foreign.C.Types (CLong)

import XMonad.Actions.CycleWS
import XMonad.Actions.EasyMotion (selectWindow, EasyMotionConfig(..), textSize)
import XMonad.Actions.Minimize

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat, isDialog, transience')
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WindowSwallowing

import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))
import XMonad.Layout.Fullscreen
import XMonad.Layout.Grid
import XMonad.Layout.IfMax
import XMonad.Layout.Minimize
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.WindowNavigation

import XMonad.Prompt
import XMonad.Prompt.Shell (prompt)

import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.EZConfig
import XMonad.Util.Font
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Actions.OnScreen

import XMonad.Layout.LayoutScreens
import XMonad.Layout.TwoPane


-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal :: String
myTerminal = "alacritty"


-- Scratchpads
--
scratchpadsTerminal :: String
scratchpadsTerminal = myTerminal ++ " --class scratchpad -e tmux new-session -A -s scratchpad"

scratchpadsTerminalGotop :: String
scratchpadsTerminalGotop = myTerminal ++ " --class scratchpad-gotop -e tmux new-session -A -s scratchpad-gotop gotop --nvidia"


-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Whether focus follows the mouse pointer, multi screen support
multiScreenFocusHook :: Event -> X All
multiScreenFocusHook MotionEvent { ev_x = x, ev_y = y } = do
  ms <- getScreenForPos x y
  case ms of
    Just cursorScreen -> do
      let cursorScreenID = W.screen cursorScreen
      focussedScreenID <- gets (W.screen . W.current . windowset)
      when (cursorScreenID /= focussedScreenID) (focusWS $ W.tag $ W.workspace cursorScreen)
      return (All True)
    _ -> return (All True)
  where getScreenForPos :: CInt -> CInt
            -> X (Maybe (W.Screen WorkspaceId (Layout Window) Window ScreenId ScreenDetail))
        getScreenForPos x y = do
          ws <- windowset <$> get
          let screens = W.current ws : W.visible ws
              inRects = map (inRect x y . screenRect . W.screenDetail) screens
          return $ fst <$> find snd (zip screens inRects)
        inRect :: CInt -> CInt -> Rectangle -> Bool
        inRect x y rect = let l = fromIntegral (rect_x rect)
                              r = l + fromIntegral (rect_width rect)
                              t = fromIntegral (rect_y rect)
                              b = t + fromIntegral (rect_height rect)
                           in x >= l && x < r && y >= t && y < b
        focusWS :: WorkspaceId -> X ()
        focusWS id = windows (W.view id)
multiScreenFocusHook _ = return (All True)


-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--

myModMask = mod1Mask


-- Workspaces
--

myWorkspaces = [" 1 "," 2 "," 3 "," 4 "," 5 "," 6 "," 7 "," 8 "," 9 "," 0"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces ([1..9] ++ [0])


-- Split Screen
--

mySplitScreen :: X ()
mySplitScreen = do
    rescreen
    windows $ viewOnScreen 1 " 7 "
    windows $ viewOnScreen 0 " 1 "
    rescreen
    windows $ W.view " 7 "
    layoutSplitScreen 2 (TwoPane 0.5 0.5)
    windows $ viewOnScreen 2 " 8 "
    windows $ viewOnScreen 0 " 1 "


-- Style
--

myFont = "xft:DejaVu Sans-8"
myFontSmall = "xft:DejaVu Sans-6"
myBgColor = "#101216"
myBgColorFocused = "#3f3f3f"
myFgColor = "#eaeaea"
myFgColorDisabled = "#343434"
myFgColorHidden = "#747474"
myFgColorVisible = "#cacaca"
myFgColorFocused = "#ffffff"

myBorderWidth = 2
myNormalBorderColor = "#191919"
myPreselectBorderColor = myNormalBorderColor
myFocusedBorderColor = "#353535"

myTabActiveColor = "#23272e"
myTabActiveTextColor = myFgColor
myTabInactiveColor = "#1a1e23"
myTabInactiveTextColor = "#aaaaaa"


-- XPConfig for Prompt
--

myXPConfig :: XPConfig
myXPConfig = def
    { font                = myFont
    , bgColor             = myBgColor
    , fgColor             = myFgColor
    , promptBorderWidth   = 0
    , position            = Top
    , height              = 22
    , showCompletionOnTab = False
    , defaultPrompter     = id $ map toUpper
    , alwaysHighlight     = False
    , maxComplRows        = Just 0
    }


-- EasyMotion
--

easymotionKillWindowConfig = def { txtCol="Red", cancelKey=xK_Escape, overlayF=textSize, emFont="xft: Dejavu Sans-16" }


-- ScratchPads
--

myScratchpads :: [NamedScratchpad]
myScratchpads =
    [ NS "terminal" scratchpadsTerminal fTerm mTerm
    , NS "terminal-gotop" scratchpadsTerminalGotop fTermGotop mTermGotop
    ]
    where
        fTerm = resource =? "scratchpad"
        mTerm = customFloating $ W.RationalRect l t w h
            where
                l = (1/20)
                t = (1/20)
                w = (9/10)
                h = (9/10)
        fTermGotop = resource =? "scratchpad-gotop"
        mTermGotop = customFloating $ W.RationalRect l t w h
            where
                l = (1/20)
                t = (1/20)
                w = (9/10)
                h = (9/10)


-- Ignore NSP Workspace
--

notNSP :: X (WindowSpace -> Bool)
notNSP = return $ ("NSP" /=) . W.tag

nextWS' :: X ()
nextWS' = moveTo Next $ hiddenWS :&: WSIs notNSP

prevWS' :: X ()
prevWS' = moveTo Prev $ hiddenWS :&: WSIs notNSP


-- Key bindings
--

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- Workspace
    --

    [ ((m .|. mod4Mask, k), windows $ f i) |
        (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0]),
        (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]

    {--
        -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
        -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
        --

        [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    --}


-- Key bindings P
--

myKeysP :: [(String, X ())]
myKeysP =
    -- System
    [ ("<Pause> <Pause>", spawn "systemctl poweroff")
    , ("M-S-<Pause>"    , spawn "notify-send -t 3000 'Restarting ...'; systemctl reboot")
    , ("M4-<Pause>"     , spawn "notify-send -t 3000 'Screen off ...'; sleep 1; xset dpms force off")

    -- XMonad
    , ("M-S-r"          , spawn "notify-send -t 2000 'Restarting XMonad ...'; xmonad --recompile; xmonad --restart")
    , ("M-S-<Escape>"   , io exitSuccess)

    -- XMobar
    , ("M-b"            , spawn "killall xmobar || xmonad --restart")

    -- Screen
    , ("M-/"            , mySplitScreen)
    , ("M-S-/"          , rescreen)

    -- Change workspace
    , ("M4-<Left>"      , prevWS')
    , ("M4-<Right>"     , nextWS')

    -- Toggle workspace
    , ("M4-<Tab>"       , toggleWS' ["NSP"])

    -- Change layout
    , ("M4-S-<Tab>"     , sendMessage NextLayout)

    -- Show Hide window
    , ("M4-<Up>"        , withLastMinimized maximizeWindowAndFocus)
    , ("M4-<Down>"      , withFocused minimizeWindow >> windows W.focusUp)

    -- Directional navigation of windows
    , ("M-l"            , sendMessage $ Go R)
    , ("M-h"            , sendMessage $ Go L)
    , ("M-k"            , sendMessage $ Go U)
    , ("M-j"            , sendMessage $ Go D)

    -- Shrink Expand master
    , ("M-S-h"          , sendMessage Shrink)
    , ("M-S-l"          , sendMessage Expand)

    -- Shrink Expand window
    , ("M-S-k"          , sendMessage MirrorExpand)
    , ("M-S-j"          , sendMessage MirrorShrink)

    -- Increment Deincrement the number of windows in the master area
    , ("M-,"            , sendMessage (IncMasterN 1))
    , ("M-."            , sendMessage (IncMasterN (-1)))

    -- Push window back into tiling
    , ("M-t"            , withFocused $ windows . W.sink)
    , ("M-f"            , sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)

    -- Move focus to the next previous window
    , ("M-S-<Tab>"      , windows W.focusUp)
    , ("M-<Tab>"        , windows W.focusDown)

    -- Directional navigation of windows
    , ("M-<Right>"      , sendMessage $ Go R)
    , ("M-<Left>"       , sendMessage $ Go L)
    , ("M-<Up>"         , sendMessage $ Go U)
    , ("M-<Down>"       , sendMessage $ Go D)

    -- Swap adjacent windows
    , ("M-S-<Right>"    , sendMessage $ Swap R)
    , ("M-S-<Left>"     , sendMessage $ Swap L)
    , ("M-S-<Up>"       , sendMessage $ Swap U)
    , ("M-S-<Down>"     , sendMessage $ Swap D)

    -- SubLayout
    , ("M-M4-S-<Left>"  , sendMessage $ pullGroup L)
    , ("M-M4-S-<Right>" , sendMessage $ pullGroup R)
    , ("M-M4-S-<Up>"    , sendMessage $ pullGroup U)
    , ("M-M4-S-<Down>"  , sendMessage $ pullGroup D)
    , ("M-M4-<Left>"    , onGroup W.focusUp')
    , ("M-M4-<Right>"   , onGroup W.focusDown')
    , ("M-M4-<Space>"   , withFocused (sendMessage . UnMerge))
    , ("M-M4-S-<Space>" , withFocused (sendMessage . UnMergeAll))

    -- Close focused window
    , ("M-q"            , kill)

    -- Resize viewed windows to the correct size
    -- , ("M-n"            , refresh)

    -- Prompt
    , ("M4-<Space>"     , prompt (myTerminal ++ " -e") myXPConfig)

    -- Terminal
    , ("M-<Return>"     , spawn myTerminal)

    -- Launcher
    , ("M-<Space>"      , spawn "rofi -show drun")

    -- DMenu
    , ("M-m m"          , spawn "~/.scripts/dmenu-mpd.sh")
    , ("M-m n"          , spawn "networkmanager_dmenu")

    -- Audio
    , ("M--"            , spawn "amixer set Master 1%-")
    , ("M-="            , spawn "amixer set Master 1%+")

    -- MPC MPD
    , ("M-p p"          , spawn "mpc toggle")
    , ("M-p s"          , spawn "mpc stop")
    , ("M-p S-s"        , spawn "~/.scripts/mpd-mpc-save-song.sh")
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

    -- ScratchPads
    , ("M4-<Return>"    , namedScratchpadAction myScratchpads "terminal")
    , ("M4-S-<Return>"  , namedScratchpadAction myScratchpads "terminal-gotop")

    -- Launch app
    , ("M4-a"           , spawn "~/.scripts/launch-app.sh 'android-studio-canary' 'Android Studio'")
    , ("M4-b"           , spawn "~/.scripts/launch-app.sh 'firefox-nightly' 'Firefox Nightly'")
    , ("M4-S-b"         , spawn "~/.scripts/launch-app.sh 'brave' 'Brave'")
    , ("M4-c"           , spawn "~/.scripts/launch-app.sh 'code' 'VS Code'")
    , ("M4-d"           , spawn "~/.scripts/launch-app.sh 'dbeaver' 'DBeaver'")
    , ("M4-f"           , spawn "~/.scripts/launch-app.sh 'thunar' 'Thunar'")
    , ("M4-j"           , spawn "~/.scripts/launch-app.sh 'jdownloader' 'JDownloader'")
    , ("M4-t"           , spawn "~/.scripts/launch-app.sh 'telegram-desktop' 'Telegram'")
    , ("M4-x"           , spawn "~/.scripts/launch-app.sh 'xdman' 'Xtream Download Manager'")

    -- EasyMotion
    , ("M4-q"           , selectWindow easymotionKillWindowConfig >>= (`whenJust` killWindow))
    ]


-- Mouse bindings: default actions bound to mouse events
--

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((mod4Mask, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ((mod4Mask, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((mod4Mask, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))

    -- Change workspace
    , ((mod4Mask, button4), (\_ -> prevWS'))
    , ((mod4Mask, button5), (\_ -> nextWS'))
    ]


---- Layouts:
--
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def
    { fontName              = myFontSmall
    , activeColor           = myTabActiveColor
    , activeBorderColor     = myTabActiveColor
    , activeTextColor       = myTabActiveTextColor
    , inactiveColor         = myTabInactiveColor
    , inactiveBorderColor   = myTabInactiveColor
    , inactiveTextColor     = myTabInactiveTextColor
    , urgentColor           = "#ffffff"
    , urgentBorderColor     = "#ffffff"
    , urgentTextColor       = "#000000"
    , decoHeight            = 12
    }

myLayout =
    avoidStruts
    $ fullscreenFull
    $ mkToggle (NBFULL ?? NOBORDERS ?? EOT)
    $ configurableNavigation (navigateColor myPreselectBorderColor)
    $ onWorkspaces [" 1 "] (terminal ||| terminalWide)
    $ onWorkspaces [" 2 "] (tall ||| wide ||| rwide ||| tabbed)
    $ onWorkspaces [" 3 "] (rwide ||| wide ||| tabbed ||| tall)
    $ onWorkspaces [" 4 "] (wide ||| rwide ||| tabbed ||| tall)
    $ onWorkspaces [" 5 "] (tall ||| vertical ||| horizontal ||| wide ||| rwide ||| grid)
    $ onWorkspaces [" 6 "] (vertical ||| tall ||| wide ||| rwide ||| grid)
    $ onWorkspaces [" 7 "] (horizontalRightZero)
    $ onWorkspaces [" 8 "] (horizontal)
    $ tall ||| vertical ||| horizontal ||| wide ||| rwide ||| tabbed ||| grid
        where
            tallModified nmaster ratio =
                addTabs shrinkText myTabTheme
                $ wrapper
                $ subLayout [] Simplest
                $ ResizableTall nmaster (2/100) ratio []
            tallModifiedRightZero nmaster ratio =
                addTabs shrinkText myTabTheme
                $ wrapperRightZero
                $ subLayout [] Simplest
                $ ResizableTall nmaster (2/100) ratio []
            tallMirrorModified nmaster ratio =
                addTabs shrinkText myTabTheme
                $ wrapperMirror
                $ subLayout [] Simplest
                $ Mirror
                $ ResizableTall nmaster (2/100) ratio []

            ratio = 50/100
            ratioWide = 70/100
            ratioRWide = 30/100

            terminal =
                renamed [Replace "Terminal"]
                $ grid
            terminalWide =
                renamed [Replace "Terminal Wide"]
                $ IfMax 3 (tallMirrorModified 1 ratio) grid
            tall =
                renamed [Replace "Tall"]
                $ IfMax 4 (tallModified 1 ratio) grid
            vertical =
                renamed [Replace "Vertical"]
                $ tallMirrorModified 3 ratio
            horizontal =
                renamed [Replace "Horizontal"]
                $ tallModified 0 ratioWide
            horizontalRightZero =
                renamed [Replace "Horizontal"]
                $ tallModifiedRightZero 0 ratioWide
            wide =
                renamed [Replace "Wide"]
                $ tallModified 1 ratioWide
            rwide =
                renamed [Replace "R Wide"]
                $ tallModified 1 ratioRWide
            grid =
                renamed [Replace "Grid"]
                $ IfMax 2 (tallModified 1 ratio) (
                    addTabs shrinkText myTabTheme
                    $ wrapper
                    $ subLayout [] Simplest
                    $ Grid
                )
            tabbed =
                renamed [Replace "Tabbed"]
                $ wrapperTabbed
                $ tabbedAlways shrinkText myTabTheme

            spacing a b = spacingRaw False (Border a a a a) True (Border b b b b) True
            wrapper a = spacing 1 1 $ minimize $ a
            wrapperRightZero a = spacingRaw False (Border 1 1 0 1) True (Border 1 1 1 1) True $ minimize $ a
            wrapperMirror a = spacing 1 1 $ minimize $ a
            wrapperTabbed a = spacing 2 0 $ minimize $ a


---- Window rules:
--
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

-- Helper to read a property
getProp :: Atom -> Window -> X (Maybe [CLong])
getProp a w = withDisplay $ \dpy -> io $ getWindowProperty32 dpy a w

--
-- checkDialog :: Query Bool
-- checkDialog =
--     ask >>= \w -> liftX $ do
--         a <- getAtom "_NET_WM_WINDOW_TYPE"
--         dialog <- getAtom "_NET_WM_WINDOW_TYPE_DIALOG"
--         mbr <- getProp a w
--         case mbr of
--             Just [r] -> return $ elem (fromIntegral r) [dialog]
--             _ -> return False

-- ManageHook
myManageHook = insertPosition End Newer
    <+> fullscreenManageHook
    <+> namedScratchpadManageHook myScratchpads
    <+> transience'
    <+> composeAll
        [ className =? "jetbrains-studio"       --> viewShift (myWorkspaces !! 1)
        , className =? "Code"                   --> viewShift (myWorkspaces !! 1)
        , className =? "firefox-nightly"        --> viewShift (myWorkspaces !! 2)
        , className =? "Tor Browser"            --> viewShift (myWorkspaces !! 2)
        , className =? "Thunar"                 --> viewShift (myWorkspaces !! 3)
        , className =? "feh"                    --> viewShift (myWorkspaces !! 4)
        , className =? "mpv"                    --> viewShift (myWorkspaces !! 4)
        , className =? "Atril"                  --> viewShift (myWorkspaces !! 5)
        , className =? "alacritty-on-workspace-1"                                                 --> doShift (myWorkspaces !! 0)
        , className =? "Thunar-on-workspace-4"                                                    --> doShift (myWorkspaces !! 3)
        , className =? "Thunar" <&&> title =? "File Operation Progress"                           --> doShift (myWorkspaces !! 6)
        , className =? "Engrampa" <&&> title =? "Extract archive"                                 --> doShift (myWorkspaces !! 6)
        , className =? "TelegramDesktop"                                                          --> doShift (myWorkspaces !! 7)
        , className =? "discord"                                                                  --> doShift (myWorkspaces !! 7)
        , className =? "xdman-Main" <&&> title =? "XDM 2020"                                      --> doShift (myWorkspaces !! 7)
        , className =? "org-jdownloader-update-launcher-JDLauncher" <&&> title =? "JDownloader 2" --> doShift (myWorkspaces !! 7)
        , className =? "thunar-cmd"                                                               --> doShift (myWorkspaces !! 7)
        , className =? "yt-dlp"                                                                   --> doShift (myWorkspaces !! 7)
        , className =? "alacritty-on-workspace-8"                                                 --> doShift (myWorkspaces !! 7)
        , className =? "DBeaver"                --> viewShift (myWorkspaces !! 8)
        , className =? "steam"                  --> viewShift (myWorkspaces !! 8)
        , className =? "dota2"                  --> viewShift (myWorkspaces !! 9)
        , className =? "RimWorldLinux"          --> viewShift (myWorkspaces !! 9)
        , className =? "Terraria.bin.x86_64"    --> viewShift (myWorkspaces !! 9)
        , className =? "dotnet"                 --> viewShift (myWorkspaces !! 9) -- tModLoader
        , floats                                --> do
            -- doF W.swapUp
            doFloat
        , floatsCenter                          --> doCenterFloat
        , isDialog                              --> ifM (className =? "firefox-nightly" <&&> appName =? "Navigator") (doShift (myWorkspaces !! 6)) doFloat
        ]
    where
        viewShift = doF . liftM2 (.) W.view W.shift
        floats = foldr1 (<||>)
            [ title =? "." <&&> ( className =? "" <||> appName =? "." )
            , title =? "win0" <&&> className =? "jetbrains-studio"
            , flip fmap title $ flip elem
                [ "Picture-in-Picture" ]
            , flip fmap className $ flip elem
                [ "GParted"
                , "Xdm-app"
                , "Xmessage"
                ]
            ]
        floatsCenter = foldr1 (<||>)
            [ flip fmap title $ flip elem
                [ "JDownloader"
                ]
            ]


---- Event handling
--
-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--

myEventHook = swallowEventHook (className =? "Alacritty" <||> className =? "Termite") (return True)


---- Status bars and logging
--
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--

-- Workspace actions
wsActions ws = "<action=`xdotool key super+Left` button=4><action=`xdotool key super+Right` button=5><action=xdotool key super+"++show i++">"++ws++"</action></action></action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

--
windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- LogHook
myLogHook xmproc0 xmproc1 = dynamicLogWithPP $ filterOutWsPP ["NSP"] $ xmobarPP
    { ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x
    , ppCurrent = xmobarColor myFgColorFocused "" . wsActions           -- Focused
    , ppVisible = xmobarColor myFgColorVisible "" . wsActions           -- Visible
    , ppHidden = xmobarColor myFgColorHidden "" . wsActions             -- Unfocused
    , ppHiddenNoWindows = xmobarColor myFgColorDisabled "" . wsActions  -- No windows
    , ppUrgent = xmobarColor "#C45500" "" . wrap "*" "" . wsActions     -- Urgent workspace
    , ppLayout = xmobarColor myFgColor "" . wrap "<action=`xdotool key super+Shift+Tab` button=1>" "</action>"
    , ppSep = "  :  "
    , ppWsSep = ""
    , ppExtras  = [windowCount]
    , ppOrder  = \(ws:l:t:e) -> [ws] ++ e ++ [l]
    }


---- Startup hook
--
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.

myStartupHook = do
    setDefaultCursor xC_left_ptr
    mySplitScreen
    spawnOnce "~/.fehbg"
    spawnOnce "dunst"
    spawnOnce "trayer --edge top --align center --widthtype request --height 22 --transparent true --alpha 0 --tint 0xff101216 --monitor 1"
    spawnOnce "mkdir -p ~/.local/share/mpd/playlists && mpd ~/.config/mpd/mpd.conf"
    spawnOnce "lxpolkit"
    spawnOnce "xdman -m"
    spawnOnce "kdeconnectd"
    spawnOnce "alacritty --class alacritty-on-workspace-1"
    spawnOnce "alacritty --class alacritty-on-workspace-8"
    spawnOnce "thunar --class Thunar-on-workspace-4"
    spawnOnce "firefox-nightly"
    setWMName "LG3D"


-- Main
--

main = do
    xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobarrc0"
    xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.config/xmobar/xmobarrc1"
    xmonad $ ewmh $ docks def {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        borderWidth        = myBorderWidth,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

        keys               = myKeys,
        mouseBindings      = myMouseBindings,

        layoutHook         = myLayout,
        manageHook         = myManageHook,
        rootMask           = rootMask def .|. pointerMotionMask,
        handleEventHook    = myEventHook <+> multiScreenFocusHook,
        logHook            = myLogHook xmproc0 xmproc1,
        startupHook        = myStartupHook
    } `additionalKeysP` myKeysP
