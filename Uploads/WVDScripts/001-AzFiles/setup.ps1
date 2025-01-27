
<#
.SYNOPSIS
Enables Azure Files for a native AD environment, executing the domain join of the storage account using the AzFilesHybrid module.
Parameter names have been abbreviated to shorten the 'PSExec' command, which has a limited number of allowed characters.

.PARAMETER RG
Resource group of the profiles storage account

.PARAMETER S
Name of the profiles storage account

.PARAMETER U
Azure admin UPN

.PARAMETER P
Azure admin password

.PARAMETER D
Azure admin password

#>

param(    


    [Parameter(Mandatory = $true)]
    [string] $RG,

    [Parameter(Mandatory = $true)]
    [string] $S,

    [Parameter(Mandatory = $true)]
    [string] $U,

    [Parameter(Mandatory = $true)]
    [string] $P,

    [Parameter(Mandatory = $true)]
    [string] $D

)

# Set execution policy    
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force

Set-Location $PSScriptroot

# Import required modules
.\CopyToPSPath.ps1
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name PowershellGet -MinimumVersion 2.2.4.1 -Force

$rsat = Get-WindowsCapability -Name RSAT.activedirectory* -Online
Add-WindowsCapability -Name $rsat.Name -Online

Install-Module -Name Az -Force -Verbose

Import-Module -Name AzFilesHybrid -Force -Verbose
Import-Module -Name activedirectory -Force -Verbose

# Find existing OU or create new one. Get path for OU from domain by splitting the domain name, to format DC=fabrikam,DC=com
<#$domain = $U.split('@')[1]
$DC = $D.split('.')
foreach($name in $DC) {
    $path = $path + ',DC=' + $name
}
$path = $path.substring(1)
$ou = Get-ADOrganizationalUnit -Filter 'Name -like "Profiles Storage"'
if ($ou -eq $null) {
    New-ADOrganizationalUnit -name 'Profiles Storage' -path $path
}#>

# Connect to Azure
$Credential = New-Object System.Management.Automation.PsCredential($U, (ConvertTo-SecureString $P -AsPlainText -Force))
Connect-AzAccount -Credential $Credential
$context = Get-AzContext
Select-AzSubscription -SubscriptionId $context.Subscription.Id

Join-AzStorageAccountForAuth -ResourceGroupName $RG -StorageAccountName $S -DomainAccountType 'ComputerAccount' -OverwriteExistingADObject

Remove-WindowsCapability -Name $rsat.Name -Online
