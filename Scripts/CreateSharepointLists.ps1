function Start-Sleep($seconds) {
    $doneDT = (Get-Date).AddSeconds($seconds)
    while($doneDT -gt (Get-Date)) {
        $secondsLeft = $doneDT.Subtract((Get-Date)).TotalSeconds
        $percent = ($seconds - $secondsLeft) / $seconds * 100
        Write-Progress -Activity "Sleeping" -Status "Sleeping..." -SecondsRemaining $secondsLeft -PercentComplete $percent
        [System.Threading.Thread]::Sleep(500)
    }
    Write-Progress -Activity "Sleeping" -Status "Sleeping..." -SecondsRemaining 0 -Completed
}

#Install dependancies
write-host "Info: Install dependancies" -foregroundcolor magenta
If (-not(Get-InstalledModule Microsoft.Online.SharePoint.PowerShell)) {
    Write-Host "Module Microsoft.Online.SharePoint.PowerShell does not exist, installing." -foregroundcolor magenta
    Install-Module -Name Microsoft.Online.SharePoint.PowerShell
	} else {
	write-host "Info: Module Microsoft.Online.SharePoint.PowerShell already Installed" -foregroundcolor magenta
}

If (-not(Get-InstalledModule PnP.PowerShell)) {
    Write-Host "Module PnP.PowerShell does not exist, installing." -foregroundcolor magenta
    Install-Module -Name PnP.PowerShell
	} else {
	write-host "Info: Module PnP.PowerShell already Installed" -foregroundcolor magenta
}

If (-not(Get-InstalledModule AzureAD)) {
    Write-Host "Module AzureAD does not exist, installing." -foregroundcolor magenta
    Install-Module -Name AzureAD
	} else {
	write-host "Info: Module AzureAD already Installed" -foregroundcolor magenta
}


If(!(Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Name,Version)){
    Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser
}



write-host "Info: Updating modules to latest versions" -foregroundcolor magenta
Update-Module -Name Microsoft.Online.SharePoint.PowerShell
Update-Module -Name PnP.PowerShell
Update-Module -Name AzureAD

Write-Host "Please input your Tenant Name (You can find it in your Sharepoint URL before .sharepoint.com  https://contoso.sharepoint.com): "
$TenantName = Read-Host
Write-Host "Please input a name for your Site: "
$SiteName = Read-Host

$TenantAdminURL = "https://" + $TenantName + "-admin.sharepoint.com"
$TenantClientURL = "https://" + $TenantName + ".sharepoint.com"
$SiteURL = $TenantClientURL + "/sites/" + $SiteName
$SiteDescription = "Site for the " + $SiteName + " app"

write-host "Info: Login to Sharepoint Administration" -foregroundcolor magenta
Connect-PnPOnline -Interactive -Url $TenantAdminURL -ForceAuthentication


#verify if site already exists in SharePoint Online
write-host "Info: Checking if site already exists" -foregroundcolor magenta
$siteExists = Get-PnPTenantSite | where{$_.url -eq $SiteURL}

#verify if site already exists in the recycle bin
write-host "Info: Checking if site already exists in the recycle bin" -foregroundcolor magenta
$siteExistsInRecycleBin = Get-PnPTenantDeletedSite | where{$_.url -eq $SiteURL}

#create site if it doesn't exists
if (($siteExists -eq $null) -and ($siteExistsInRecycleBin -eq $null)) {
    write-host "Info: Creating $($SiteName)" -foregroundcolor magenta
    #Create a new site with the Doc Centre template BDR#0
    New-PnPSite  -Type TeamSite -Title $SiteName -Description $SiteDescription -Alias $SiteName -IsPublic 
	write-host "Info: Site $($SiteName) Created" -foregroundcolor magenta
}
elseif ($siteExists -ne $null){
    write-host "Site $($SiteURL) is already created, moving on" -foregroundcolor red
    
}
else{
    write-host "Error: $($SiteURL) still exists in the Recyclebin, please remove it from the recycle bin and run the script again so it can be recreated" -foregroundcolor red
    exit
}

write-host "Info: Waiting for provisioning to finish" -foregroundcolor magenta
Start-Sleep($seconds)
# Connect to the destination site and create the necessary lists
write-host "Info: Login the newly created site" -foregroundcolor magenta
Connect-PnPOnline -Url $SiteURL -Interactive -ForceAuthentication

Invoke-PnPSiteTemplate -Path SharepointLists.xml
