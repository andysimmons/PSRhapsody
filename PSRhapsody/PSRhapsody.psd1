@{
	NestedModules = "PSRhapsody.psm1"
	ModuleVersion = "0.1.0"
	GUID = "16077f6b-5b6a-4f55-a9b1-f44b05159de8"
	Author = "Andy Simmons"
	Copyright = "(c) 2018. All rights reserved."
	Description = "Manage the Rhapsody interface engine from PowerShell"
	PowerShellVersion = "5.0.0.0"
	FunctionsToExport = @(
		'Connect-Rhapsody'
		'Disconnect-Rhapsody'
		'Get-CommPoint'
		'Restart-CommPoint'
		'Start-CommPoint'
		'Stop-CommPoint'
	)
	ScriptsToProcess = '.\helpers\PSClassDefinitions.ps1'

	PrivateData = @{
        PSData = @{
            Tags = "Rhapsody"
            LicenseUri = "https://github.com/andysimmons/PSRhapsody/blob/master/PSRhapsody/license"
            ProjectUri = "https://github.com/andysimmons/PSRhapsody"
            #ReleaseNotes = ""
        }
    }
}

