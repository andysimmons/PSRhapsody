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