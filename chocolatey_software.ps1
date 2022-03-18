param (
    [switch]$SkipVisualStudio = $False
 )

##### HELPERS #####

Function Verify-GitInstalled()
{
    try {
        Invoke-Expression 'git version'
    }
    catch {
        Write-Host "FATAL: git must be installed and accessible on the path.  Exiting..."
        exit
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

    Invoke-Expression 'cinst -y 7zip.install --no-progress'
    Invoke-Expression 'cinst -y beyondcompare --no-progress'
    Invoke-Expression 'cinst -y selenium-chrome-driver --no-progress'
    Invoke-Expression 'cinst -y selenium-gecko-driver --no-progress'
    Invoke-Expression 'cinst -y beyondcompare --no-progress'
    Invoke-Expression 'cinst -y resharper --no-progress'
    Invoke-Expression 'cinst -y servicebusexplorer --no-progress'
    Invoke-Expression 'cinst -y microsoftazurestorageexplorer --no-progress'
    Invoke-Expression 'cinst -y yarn --no-progress'
    Invoke-Expression 'cinst -y vscode --no-progress'
    Invoke-Expression 'cinst -y fiddler --no-progress'
    Invoke-Expression 'cinst -y chocolateygui --no-progress'
    Invoke-Expression 'cinst -y zoom --no-progress'
    Invoke-Expression 'cinst -y onedrive --no-progress'
    Invoke-Expression 'cinst -y notepadplusplus.install --no-progress'
    Invoke-Expression 'cinst -y lastpass --no-progress'
    Invoke-Expression 'cinst -y slack --no-progress'
    Invoke-Expression 'cinst -y office365business --no-progress'
    Invoke-Expression 'cinst -y autohotkey.install --no-progress'
    Invoke-Expression 'cinst -y sharpkeys --no-progress'
    Invoke-Expression 'cinst -y powertoys --no-progress'
    Invoke-Expression 'cinst -y dischord.install --no-progress'
    Invoke-Expression 'cinst -y kubernetes-cli --no-progress'
    Invoke-Expression 'cinst -y lens --no-progress'
    Invoke-Expression 'cinst -y putty --no-progress'
    Invoke-Expression 'cinst -y filezilla --no-progress'
	
    ## DO I NEED THIS?
    # $SeleniumPathLocations = '%systemdrive%\bin\selenium\;%systemdrive%\tools\selenium'
    # if (([Environment]::GetEnvironmentVariable("Path") | Out-String) -notmatch "$([RegEx]::Escape($SeleniumPathLocations))")
    # {
    #     Write-Host "Adding selenium driver install location to path"
    #     [Environment]::SetEnvironmentVariable("Path", $env:Path + ";%systemdrive%\bin\selenium\;%systemdrive%\tools\selenium", [EnvironmentVariableTarget]::Machine)
    # }
}

##### MAIN #####

Write-Host
Write-Host "Verifying git Is Installed"
Write-Host "=========================="
Verify-GitInstalled

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
