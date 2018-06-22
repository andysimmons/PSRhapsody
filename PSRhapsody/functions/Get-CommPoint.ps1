<#
.SYNOPSIS
    Retrieves one or more communication points from Rhapsody.

.PARAMETER Id
    Specifies the communication point ID.

.EXAMPLE
    Get-CommPoint -Id (6223..6226)

    Retrieves communication points with IDs of 6223, 6224, 6225, 6226.
#>
function Get-CommPoint {
    [CmdletBinding()]
    param ( 
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, Position = 0)]
        [int[]]
        $Id 
    )

    begin { Confirm-RhapsodyConnection -ErrorAction 'Stop' }

    process {
        $uri = $Global:RhapsodyConnection.BaseUri
        $creds = $Global:RhapsodyConnection.Credential
        $skipCertificateCheck = $Global:RhapsodyConnection.SkipCertificateCheck
        $Id.ForEach({[CommPoint]::new($uri, $_, $creds, $skipCertificateCheck)})
    }
}