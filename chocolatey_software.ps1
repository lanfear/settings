# RUN POWERSHELL AS ADMIN, execute this command before the script itself
# Set-ExecutionPolicy Unrestricted

param (
    [switch]$SkipVisualStudio = $False,
    [switch]$InstallWorkSoftware = $True
 )

##### HELPERS #####

Function Verify-GitInstalled()
{
    try {
        Invoke-Expression 'git version'
        Write-Host "git installed, skipping install"
    }
    catch {
        # may want to do this in advance yourself to customize the install opts
        Write-Host "git not found... Installing git with default settings..."
        Invoke-Expression 'choco install  -y git --no-progress'
    }
}

Function Install-Software()
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	
	Invoke-Expression 'choco feature enable -n=useRememberedArgumentsForUpgrades'

    if (-not $SkipVisualStudio)
    {
        Invoke-Expression 'choco install  -y visualstudio2026enterprise --no-progress'
        Invoke-Expression 'choco install  -y visualstudio2026-workload-azure --no-progress'
        Invoke-Expression 'choco install  -y visualstudio2026-workload-netweb --no-progress'
        Invoke-Expression 'choco install  -y visualstudio2026-workload-webbuildtools --no-progress'
    }

    if ($InstallWorkSoftware)
    {
        Invoke-Expression 'choco install  -y selenium-chrome-driver --no-progress'
        Invoke-Expression 'choco install  -y selenium-gecko-driver --no-progress'
        #Invoke-Expression 'choco install  -y resharper --no-progress'
        Invoke-Expression 'choco install  -y servicebusexplorer --no-progress'
        Invoke-Expression 'choco install  -y microsoftazurestorageexplorer --no-progress'
        Invoke-Expression 'choco install  -y kubernetes-cli --no-progress'
        Invoke-Expression 'choco install  -y openlens --params="/ALLUSERS" --no-progress'
        # for home if you have o365 sub you probably want the 'professional' (or whatever non-business) suite instead?
        Invoke-Expression 'choco install  -y office365business --no-progress'
        Invoke-Expression 'choco install  -y git-lfs --no-progress'
        # not sure if you need both of these to get localdb, i tried to test but didnt test right when installing sequentially, 
        # db-server is at (localdb)\MSSqlLocalDb with integrated security after installation is complete 
        Invoke-Expression 'choco install  -y sql-server-express --no-progress'
        Invoke-Expression 'choco install  -y sqllocaldb --no-progress'
		Invoke-Expression 'choco install  -y rancher-desktop --no-progress'
    }

    Verify-GitInstalled
    
    Invoke-Expression 'choco install  -y chocolateygui --no-progress'
    Invoke-Expression 'choco install  -y powershell-core --install-arguments=''"ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 REGISTER_MANIFEST=1 ENABLE_PSREMOTING=1"'' --no-progress'
    # this may be nice someday as a replacement for git bash, but the autoinstall currently fails in cases due to environment, this should be handled better
    #Invoke-Expression 'choco install  -y wsl2 --no-progress'
    Invoke-Expression 'choco install  -y az.powershell --params="/core /desktop" --no-progress'
    Invoke-Expression 'choco install  -y azure-cli --no-progress'
    Invoke-Expression 'choco install  -y 7zip --no-progress'
    Invoke-Expression 'choco install  -y nvm --no-progress'
    Invoke-Expression 'choco install  -y beyondcompare --no-progress'
    Invoke-Expression 'choco install  -y vscode --no-progress'
    Invoke-Expression 'choco install  -y fiddler --no-progress'
    Invoke-Expression 'choco install  -y zoom --no-progress'
    Invoke-Expression 'choco install  -y notepadplusplus --no-progress'
    Invoke-Expression 'choco install  -y 1password --no-progress'
    Invoke-Expression 'choco install  -y vlc -no-progress'
    Invoke-Expression 'choco install  -y mediainfo -no-progress'
    Invoke-Expression 'choco install  -y slack --no-progress'
    Invoke-Expression 'choco install  -y powertoys --no-progress'
    Invoke-Expression 'choco install  -y discord --no-progress'
    Invoke-Expression 'choco install  -y putty --no-progress'
    Invoke-Expression 'choco install  -y filezilla --no-progress'
    Invoke-Expression 'choco install  -y steam-client --no-progress'
    Invoke-Expression 'choco install  -y ngrok --no-progress'
    Invoke-Expression 'choco install  -y insomnia-rest-api-client --no-progress'
    Invoke-Expression 'choco install  -y windirstat --no-progress'	
    
    # optional, for my push-to-talk script setup
    Invoke-Expression 'choco install  -y autohotkey --no-progress'
    Invoke-Expression 'choco install  -y sharpkeys --no-progress'
}

##### MAIN #####

Write-Host
Write-Host "Installing Software"
Write-Host "==================="
Install-Software

Write-Host
Write-Host "vvvvvvvvvvvvvvvvvvvvv"
Write-Host "Setup script complete"
Write-Host "^^^^^^^^^^^^^^^^^^^^^"
Write-Host

Read-Host -Prompt "Press Enter to close"
