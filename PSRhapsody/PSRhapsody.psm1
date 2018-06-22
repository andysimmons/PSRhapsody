if (!(Get-Module TunableSSLValidator)) {
	Install-Module -Name TunableSSLValidator -Scope CurrentUser -Force -AllowClobber -ErrorAction 'Stop'
}
Import-Module -Name TunableSSLValidator -AllowClobber -Force

$FunctionsPath = Join-Path $PSScriptRoot "functions"
$HelpersPath = Join-Path $PSScriptRoot "helpers"

$Scripts = Get-ChildItem -Path $FunctionsPath,$HelpersPath -Filter "*.ps1" -file -Recurse

foreach ($Script in $Scripts)
{
	. $Script.FullName
} 
#Disconnect-Rhapsody -ErrorAction 'SilentlyContinue'