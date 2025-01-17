#SingleInstance, force
#NoTrayIcon
#NoEnv
#Persistent

SetBatchLines, -1
SetControlDelay, -1
SetMouseDelay, -1
SetKeyDelay, -1
SetWinDelay, -1

CurrentSection := ""
ypos := 100
global CheckboxIDs := {}
global SelectedPrograms := []
global ProgramUrls := {}

Programs =
( LTrim
    Browsers,Google Chrome,https://dl.google.com/chrome/install/latest/chrome_installer.exe
    Browsers,Mozilla Firefox,https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US
    Browsers,Opera,https://download3.operacdn.com/pub/opera/desktop/96.0.4693.50/win/OperaSetup.exe
    Browsers,Brave,https://laptop-updates.brave.com/download/BraveBrowserSetup.exe
    Browsers,Microsoft Edge,https://go.microsoft.com/fwlink/?linkid=2069324&Channel=Stable
    Browsers,Vivaldi,https://downloads.vivaldi.com/stable/Vivaldi.6.0.2979.15.x64.exe
    Browsers,Maxthon,https://dl.maxthon.com/mx5/maxthon5.3.8.2000.exe
    Browsers,Chromium,https://download-chromium.appspot.com/dl/Win?type=snapshots
    Browsers,SlimBrowser,https://www.slimbrowser.net/releases/sbsetup.exe
    Browsers,Avant Browser,https://www.avantbrowser.com/release/absetup.exe
    Browsers,UC Browser,https://res3.ubcdn.xyz/browser/en/UBrowser.exe
    Browsers,Waterfox,https://cdn.waterfox.net/releases/win64/installer/Waterfox-Classic-Setup.exe
    Browsers,Falkon,https://download.kde.org/stable/falkon/3.1.0/falkon-setup.exe
    Browsers,SRWare Iron,https://www.srware.net/downloads/IronSetup.exe
    Browsers,SeaMonkey,https://download.mozilla.org/?product=seamonkey-latest&os=win64
    Browsers,K-Meleon,https://kmeleonbrowser.org/files/K-Meleon76.4.5.exe
    Browsers,Midori,https://midori-browser.org/downloads/midori-for-windows/
    Browsers,Comodo Dragon,https://download.comodo.com/browser/dragon/DragonSetup.exe
    Browsers,Epiphany,https://ftp.gnome.org/pub/GNOME/sources/epiphany/3.38/epiphany-3.38.2.tar.xz

    Media,VLC Media Player,https://get.videolan.org/vlc/last/win64/vlc-setup.exe
    Media,Spotify,https://download.scdn.co/SpotifySetup.exe
    Media,Winamp,https://download.nullsoft.com/winamp/client/winamp596_full.exe
    Media,KMPlayer,https://cdn.kmplayer.com/KMP/KMPlayer.exe
    Media,Media Player Classic,https://github.com/clsid2/mpc-hc/releases/download/1.9.25/mpc-hc64.exe
    Media,Plex,https://downloads.plex.tv/plex-desktop/1.49.0.3015-a832ffba/Plex-1.49.0.3015-a832ffba-x64.exe
    Media,Audacity,https://www.fosshub.com/Audacity.html?dwl=audacity-win-3.3.2.exe
    Media,foobar2000,https://www.foobar2000.org/getfile/foobar2000_v1.6.15.exe
    Media,HandBrake,https://github.com/HandBrake/HandBrake/releases/download/1.6.1/HandBrake-1.6.1-x86_64-Win_GUI.exe
    Media,OBS Studio,https://cdn-fastly.obsproject.com/downloads/OBS-Studio-Installer.exe
    Media,PotPlayer,https://t1.daumcdn.net/potplayer/PotPlayer/Version/Daum.PotPlayerSetup.exe
    Media,Zoom Player,https://inmatrix.com/files/zoomplayermax_setup.exe
    Media,AIMP,https://aimp.ru/files/latest/aimp_4.70.2251.exe
    Media,Bandicam,https://dl.bandicam.com/bdcamsetup.exe
    Media,GOM Player,https://cdn2.gomlab.com/gretech/player/GOMPLAYERGLOBALSETUP.EXE
    Media,DAPlayer,https://daplayer.com/files/daplayer-setup.exe
    Media,MPlayer,https://mplayerhq.hu/design7/dload.html
    Media,RealPlayer,https://www.real.com/realplayer/download

    Utilities,WinRAR,https://www.rarlab.com/rar/winrar-x64-602.exe
    Utilities,7-Zip,https://www.7-zip.org/a/7z2201-x64.exe
    Utilities,CCleaner,https://download.ccleaner.com/ccsetup601.exe
    Utilities,Recuva,https://download.ccleaner.com/recuva/recuvasetup.exe
    Utilities,CPU-Z,https://download.cpuid.com/cpu-z/cpu-z_2.05-en.zip
    Utilities,Speccy,https://download.ccleaner.com/spsetup132.exe
    Utilities,Defraggler,https://download.ccleaner.com/dfsetup223.exe
    Utilities,TeraCopy,https://codesector.com/files/teracopy.exe
    Utilities,Everything,https://www.voidtools.com/Everything-1.4.1.1022.x64-Setup.exe
    Utilities,TreeSize Free,https://downloads.jam-software.com/treesize_free/TreeSizeFreeSetup.exe
    Utilities,UltraSearch,https://www.jam-software.com/ultrasearch_free/UltraSearchSetup.exe
    Utilities,IrfanView,https://www.irfanview.com/64bit/iview460_x64_setup.exe
    Utilities,SumatraPDF,https://kjkpubsfw.sfo2.digitaloceanspaces.com/SumatraPDF-3.4.6-64-install.exe
    Utilities,Snagit,https://download.techsmith.com/snagit/releases/Snagit.exe
    Utilities,TeamViewer,https://download.teamviewer.com/download/TeamViewer_Setup.exe
    Utilities,Glary Utilities,https://download.glarysoft.com/gusetup.exe
    Utilities,Notepad++,https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5/npp.8.5.Installer.x64.exe
    Utilities,HWMonitor,https://www.cpuid.com/downloads/hwmonitor/hwmonitor_1.47.exe

    Gaming,Steam,https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe
    Gaming,Epic Games Launcher,https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi
    Gaming,Origin,https://www.dm.origin.com/download
    Gaming,Uplay,https://uplay.ubi.com/
    Gaming,Battle.net,https://www.blizzard.com/download/confirmation?product=bnetdesk
    Gaming,GOG Galaxy,https://webinstallers.gog.com/GOG_Galaxy_2.0.exe
    Gaming,Razer Cortex,https://dl.razerzone.com/master-guides/CortexInstaller.exe
    Gaming,Discord,https://discordapp.com/api/download?platform=win
    Gaming,GeForce Experience,https://us.download.nvidia.com/GFE/GFEClient/3.26.0.154/GeForce_Experience_v3.26.0.154.exe
    Gaming,Xbox App,https://www.microsoft.com/en-us/download/details.aspx?id=48231
    Gaming,PlayStation App,https://www.playstation.com/en-us/support/hardware/playstation-app/
    Gaming,Twitch App,https://download.twitchapp.net
    Gaming,OBS Studio,https://cdn-fastly.obsproject.com/downloads/OBS-Studio-Installer.exe
    Gaming,MSI Afterburner,https://download.msi.com/utility/nb/MSIAfterburnerSetup.zip
    Gaming,EVGA Precision X1,https://www.evga.com/precisionx1/
    Gaming,RivaTuner,https://www.guru3d.com/files-details/rtss-rivatuner-statistics-server-download.html
    Gaming,XSplit Gamecaster,https://xsplit.com/gamecaster
    Gaming,BlueStacks,https://cdn3.bluestacks.com/downloads/windows/bgp64_nxt_installer_full.exe
    Gaming,AMD Adrenalin,https://drivers.amd.com/drivers/installer_Adrenalin.exe
    Gaming,GameMaker,https://www.yoyogames.com/download

    Productivity,LibreOffice,https://download.documentfoundation.org/libreoffice/stable/7.6.1/win/x86_64/LibreOffice_7.6.1_Win_x64.msi
    Productivity,Microsoft Office,https://www.microsoft.com/en-us/microsoft-365/free-office-online-for-the-web
    Productivity,Google Drive,https://dl.google.com/drive/InstallBackupAndSync.exe
    Productivity,Dropbox,https://www.dropbox.com/download?plat=win
    Productivity,OneDrive,https://go.microsoft.com/fwlink/p/?LinkId=248256
    Productivity,Evernote,https://evernote.com/download/get.php?file=EvernoteWindows
    Productivity,Trello,https://trello.com/desktop
    Productivity,Slack,https://slack.com/downloads/windows
    Productivity,Zoom,https://zoom.us/client/latest/ZoomInstaller.exe
    Productivity,Microsoft Teams,https://www.microsoft.com/en-us/microsoft-teams/download-app
    Productivity,Notion,https://notion.so/desktop
    Productivity,Miro,https://miro.com/apps/
    Productivity,Airtable,https://airtable.com/downloads
    Productivity,Monday.com,https://monday.com/downloads
    Productivity,Grammarly,https://www.grammarly.com/desktop
    Productivity,Hemingway Editor,https://www.hemingwayapp.com/desktop.html
    Productivity,Asana,https://app.asana.com/-/downloads/win32_installer.zip
    Productivity,ClickUp,https://clickup.com/download/windows
    Productivity,Time Doctor,https://app.timedoctor.com/download

    Developer Tools,Git,https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.1/Git-2.42.0-64-bit.exe
    Developer Tools,Node.js,https://nodejs.org/dist/v20.5.0/node-v20.5.0-x64.msi
    Developer Tools,Python,https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe
    Developer Tools,Java JDK,https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe
    Developer Tools,Visual Studio Code,https://update.code.visualstudio.com/latest/win32-x64-user/stable
    Developer Tools,IntelliJ IDEA,https://download.jetbrains.com/idea/ideaIC-2023.1.4.exe
    Developer Tools,Eclipse,https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2023-09/R/eclipse-inst-jre-win64.exe
    Developer Tools,NetBeans,https://netbeans.apache.org/download/nb19/nb19.exe
    Developer Tools,Android Studio,https://developer.android.com/studio/install
    Developer Tools,Xcode,https://apps.apple.com/us/app/xcode/id497799835?mt=12
    Developer Tools,Docker,https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe
    Developer Tools,Postman,https://dl.pstmn.io/download/latest/win64
    Developer Tools,MySQL Workbench,https://dev.mysql.com/downloads/file/?id=505287
    Developer Tools,SQLite,https://www.sqlite.org/download.html
    Developer Tools,MongoDB Compass,https://downloads.mongodb.com/compass/mongodb-compass-1.37.0-win32-x64.zip
    Developer Tools,PhpStorm,https://download.jetbrains.com/webide/PhpStorm-2023.1.3.exe
    Developer Tools,PyCharm,https://download.jetbrains.com/python/pycharm-community-2023.1.4.exe
    Developer Tools,Anaconda,https://repo.anaconda.com/archive/Anaconda3-2023.07-Windows-x86_64.exe
    Developer Tools,Flutter,https://flutter.dev/docs/get-started/install/windows
    Developer Tools,RubyMine,https://download.jetbrains.com/ruby/RubyMine-2023.1.2.exe
)

Gui, Font, s12, Segoe UI
Gui, Add, Text, xm, Select Programs to Install:
Gui, Font, s10, Segoe UI
Gui, add, tab, buttons, Browsers|Media|Utilities|Gaming|Productivity|Developer Tools


Loop, Parse, Programs, `n, `r
    {
        StringSplit, Program, A_LoopField, `,
        UniqueID := Program1 . "|" . Program2
        if (CheckboxIDs.HasKey(UniqueID))
            continue
        CheckboxIDs[UniqueID] := true
        if (CurrentSection != Program1) {
            CurrentSection := Program1
            Gui, Tab, %CurrentSection%
            ypos := 100
        }
        Gui, Add, Checkbox, x20 y%ypos% w380, % Program2
        ypos += 18
    }

Gui, tab
Gui, Font, s12 Bold, Segoe UI
Gui, Add, Button, xm gStartDownloads h40 w100, Start
Gui, Font, s10, Segoe UI
Gui, Add, Progress, xm w400 h20 cBlue vProgressBar
Gui, Show,, Download Manager
Return

GuiClose:
ExitApp

StartDownloads:
Gui, Submit, NoHide
SelectedPrograms := []
Loop, Parse, Programs, `n, `r
{
    StringSplit, Program, A_LoopField, `,
    ProgramName := Program2
    GuiControlGet, Checked, , %ProgramName%
    if (Checked) {
        SelectedPrograms.Push(A_LoopField)
    }
}

if (SelectedPrograms.Length() = 0) {
    MsgBox, 48, Warning, No programs selected for download.
    Return
}

DownloadStatus := {}
for Index, ProgramData in SelectedPrograms {
    StringSplit, Program, ProgramData, `,
    FilePath := A_ScriptDir "\" Program2 "_Installer.exe"
    ProgramName := Program2
    ProgramURL := Program3
    TempScript := "UrlDownloadToFile, " . ProgramURL . ", " . FilePath . "`n"
    TempScript .= "if (ErrorLevel)`n"
    TempScript .= "    FileAppend, Failed, " . FilePath . ".status`n"
    TempScript .= "else`n"
    TempScript .= "    FileAppend, Success, " . FilePath . ".status`n"
    TempFile := A_Temp "\" ProgramName "_Download.ahk"
    FileAppend, %TempScript%, %TempFile%
    Run, %TempFile%, , UseErrorLevel
    DownloadStatus[ProgramName] := FilePath ".status"
}

Loop {
    AllCompleted := true
    for ProgramName, StatusFile in DownloadStatus {
        if (FileExist(StatusFile)) {
            FileRead, Status, %StatusFile%
            if (Status = "Success") {
                FilePath := A_ScriptDir "\" ProgramName "_Installer.exe"
                RunWait, %FilePath%, , UseErrorLevel
                if (ErrorLevel != 0) {
                    MsgBox, 48, Error, Installation of %ProgramName% failed.
                }
                FileDelete, %FilePath%
                FileDelete, %StatusFile%
            } else if (Status = "Failed") {
                MsgBox, 48, Error, Download of %ProgramName% failed.
                FileDelete, %StatusFile%
            }
            DownloadStatus.Delete(ProgramName)
        } else {
            AllCompleted := false
        }
    }
    if (AllCompleted) {
        Break
    }
    Sleep, 500
}

MsgBox, 64, Info, All downloads and installations complete.
Return


DownloadFile(ProgramName, ProgramURL, FilePath, ThreadIndex, DownloadResults, ConcurrentDownloads) {
    DownloadResults[ProgramName] := "Pending"
    UrlDownloadToFile, %ProgramURL%, %FilePath%
    if (ErrorLevel) {
        DownloadResults[ProgramName] := "Failed"
    } else {
        DownloadResults[ProgramName] := "Success"
    }
    ConcurrentDownloads[ThreadIndex] := false
}

GetAvailableThread(ConcurrentDownloads) {
    for Index, IsBusy in ConcurrentDownloads {
        if (!IsBusy)
            Return Index
    }
    Return 0
}
