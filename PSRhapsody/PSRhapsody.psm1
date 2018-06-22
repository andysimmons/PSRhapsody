#requires -Module TunableSSLValidator

$FunctionsPath = Join-Path $PSScriptRoot "functions"
$HelpersPath = Join-Path $PSScriptRoot "helpers"
$ClassesPath = Join-Path $PSScriptRoot "classes"
$Scripts = Get-ChildItem -Path $FunctionsPath,$HelpersPath,$ClassesPath -Filter "*.ps1" -file -Recurse

foreach ($Script in $Scripts)
{
	. $Script.FullName
}

#Disconnect-Rhapsody -ErrorAction 'SilentlyContinue'