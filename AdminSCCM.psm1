#requires -version 3
<#
.SYNOPSIS
  Administration System Center 
.DESCRIPTION
    Connexion/DÃ©connexion Site
.NOTES
    Version: 1.0.0.0
    Author:  OBY
    Creation Date: 19/06/2018
    Purpose/Change : Script Initial
.Version    1.0.0.0
#>
#Function Connected Site System
Function Connect-SiteTo{
param(
[mandatory=true][string]$Site,
[mandatory=true][string]$NameMachine,
[mandatory=false][string]$PathSCCM = "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1"
)
  If(Test-Path $PathSCCM){
    import-module $PathSCCM
    If((Get-Module ConfigurationManager) -ne $null){
      If((Get-PSDrive -Name $Site -PSProvider CMSite -ErrorAction SilentlyContinue) -eq $null) {
        New-PSDrive -Name $Site -PSProvider CMSite -Root $NameMachine       
        Write-Host "Mount Drive[$Site]  : OK"   
        Set-Location "$($Site):\"   
        If((Get-CMSite) -ne $null{Write-Host "Connect to Site[$Site] : OK"}Else{Write-Host "Connect to Site[$Site] : KO"}
      }
    }Else{Write-Host "Module[ConfigurationManager] not imported"}
  }Else{Write-Host "File [ConfigurationManager.psd1] not found"}
}
#Function Connected Site System
Function Disconnect-SiteTo{
param(
[mandatory=true][string]$Site,
[mandatory=true][string]$NameMachine
)
  If((Get-PSDrive -Name $Site -PSProvider CMSite -ErrorAction SilentlyContinue) -ne $null) {
    Remove-PSDrive -Name $Site
    Write-Host "Disconnect to Site[$Site] : OK"
  }Else{ Write-Host "Disconnect to Site[$Site] : KO , erreur Drive[$Site] not exist!"}
}
#Export des fonctions
Export-ModuleMember -Function 'Connect-SiteTo'
Export-ModuleMember -Function 'Disconnect-SiteTo'
