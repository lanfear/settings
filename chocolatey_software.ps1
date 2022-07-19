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
        Invoke-Expression 'cinst -y git --no-progress'
    }
}

Function Install-Software()
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    if (-not $SkipVisualStudio)
    {
        Invoke-Expression 'cinst -y visualstudio2022enterprise --no-progress'
        Invoke-Expression 'cinst -y visualstudio2022-workload-azure --no-progress'
        Invoke-Expression 'cinst -y visualstudio2022-workload-netweb --no-progress'
        Invoke-Expression 'cinst -y visualstudio2022-workload-webbuildtools --no-progress'
    }

    if ($InstallWorkSoftware)
    {
        Invoke-Expression 'cinst -y selenium-chrome-driver --no-progress'
        Invoke-Expression 'cinst -y selenium-gecko-driver --no-progress'
        Invoke-Expression 'cinst -y resharper --no-progress'
        Invoke-Expression 'cinst -y servicebusexplorer --no-progress'
        Invoke-Expression 'cinst -y microsoftazurestorageexplorer --no-progress'
        Invoke-Expression 'cinst -y kubernetes-cli --no-progress'
        Invoke-Expression 'cinst -y lens --no-progress'
        # for home if you have o365 sub you probably want the 'professional' (or whatever non-business) suite instead?
        Invoke-Expression 'cinst -y office365business --no-progress'
        Invoke-Expression 'cinst -y git-lfs --no-progress'
    }

    Verify-GitInstalled
    
    Invoke-Expression 'cinst -y chocolateygui --no-progress'
    Invoke-Expression 'cinst -y powershell-core --install-arguments=''"ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 REGISTER_MANIFEST=1 ENABLE_PSREMOTING=1"'' --no-progress'
    Invoke-Expression 'cinst -y az.powershell --params="/core /desktop" --no-progress'
    Invoke-Expression 'cinst -y azure-cli --no-progress'
    Invoke-Expression 'cinst -y 7zip --no-progress'
    Invoke-Expression 'cinst -y nvm --no-progress'
    Invoke-Expression 'cinst -y beyondcompare --no-progress'
    Invoke-Expression 'cinst -y yarn --no-progress'
    Invoke-Expression 'cinst -y vscode --no-progress'
    Invoke-Expression 'cinst -y fiddler --no-progress'
    Invoke-Expression 'cinst -y zoom --no-progress'
    Invoke-Expression 'cinst -y notepadplusplus --no-progress'
    Invoke-Expression 'cinst -y lastpass --no-progress'
    Invoke-Expression 'cinst -y slack --no-progress'
    Invoke-Expression 'cinst -y powertoys --no-progress'
    Invoke-Expression 'cinst -y discord --no-progress'
    Invoke-Expression 'cinst -y putty --no-progress'
    Invoke-Expression 'cinst -y filezilla --no-progress'
    Invoke-Expression 'cinst -y steam-client --no-progress'
    Invoke-Expression 'cinst -y ngrok --no-progress'
    
    # optional, for my push-to-talk script setup
    Invoke-Expression 'cinst -y autohotkey --no-progress'
    Invoke-Expression 'cinst -y sharpkeys --no-progress'
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
