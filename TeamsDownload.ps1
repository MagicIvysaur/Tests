

function DownloadTeams {
#This function defines variables to to hold the download URL from Teams and the destination directory which is where the script is being run from.

    $global:source = 'https://go.microsoft.com/fwlink/p/?LinkID=869426&culture=en-us&country=WW&lm=deeplink&lmsrc=groupChatMarketingPageWeb&cmpid=directDownloadWin64'
    $global:destination = '.\Teams_Windows.exe'

}

function WebRequestExecute {
#This function invokes the WebRequest and adds the sources and destination variables

    Invoke-WebRequest -Uri $source -OutFile $destination
}

function RunDownload {
#This function executes the downloaded file automatically after it has been downloaded

    .\Teams_Windows.exe
}

function GetVersion {
#This functionchecks if there are Teams installation files by inspecting the Teams executable file in the %AppData%\Microsoft\Teams directory

    $TeamsExe = Get-Item (“${Env:LOCALAPPDATA}” + “\Microsoft\Teams\current\Teams.exe”)
    $TeamsVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($TeamsExe)
    $TeamsVersion
}


#This block of code executes all functions in order, the Try & Catch segment runs a check to validate if there is evidence of Teams being installed, and either stops or continues depending on the result.

$ErrorActionPreference = 'SilentlyContinue'
Try {&{GetVersion;Write-Output "Teams installation files found! Please remove all files and folders related to Teams and try again.";pause}} 

    catch {Write-Output "No Teams installation files found! Starting download please wait..."

    DownloadTeams
    WebRequestExecute
    RunDownload

    }

