#requires -version 3
<#
.SYNOPSIS
  Gestion Administration System Center 
.DESCRIPTION
    Connexion/Déconnexion Site
.NOTES
    Version: 1.0.0.0
    Author:  OBY
    Creation Date: 24/04/2018
    Purpose/Change : Script Initial
.Version    1.0.0.0
#>
#Function Connected Site System
Function Connect-SiteTo($Site,$NameMachine){
  $PathSCCM = "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1"
  If(Test-Path $PathSCCM){
    import-module $PathSCCM
    If((Get-Module ConfigurationManager) -ne $null){
      If(Get-PSDrive -Name $Site -PSProvider CMSite -ErrorAction SilentlyContinue) -eq $null) {
        New-PSDrive -Name $Site -PSProvider CMSite -Root $NameMachine
        Set-Location "$($Site):\"
      }
    }Else{Write-Host "Module[ConfigurationManager] not imported"}
  }Else{Write-Host "File [ConfigurationManager.psd1] not found"}
}

#Export des fonctions
Export-ModuleMember -Function 'Connect-SiteTo'
