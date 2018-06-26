using namespace System.Net
using namespace System.Runtime.InteropServices
<#
.SYNOPSIS
    Connects to a Rhapsody server.

.PARAMETER Credential
    Credentials used for authentication.

.PARAMETER BaseUri
    Base URI of the Rhapsody REST API.

.PARAMETER SkipCertificateCheck
    Bypass SSL certificate validation (e.g. if the server's certificate
    is self-signed)

.PARAMETER Force
    Forces an update to the connection configuration used by other cmdlets in this
    module, even if the connection attempt fails and/or another connection configuration
    is still in memory.

.EXAMPLE
    Connect-Rhapsody -BaseUri 'https://your.rhapsody.server:8444'

    Connects to the Rhapsody server via HTTPS on port 8444, prompting for credentials.
#>
function Connect-Rhapsody {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [pscredential]
        $Credential,

        [Parameter(Mandatory)]
        [uri]
        $BaseUri,

        [switch]
        $SkipCertificateCheck,

        [switch]
        $Force
    )

    $newConnection = [pscustomobject] [ordered] @{
        BaseUri              = $BaseUri
        Credential           = $Credential
        SkipCertificateCheck = $SkipCertificateCheck
        PrevMaxIdleTime      = [ServicePointManager]::MaxServicePointIdleTime
    }

    if ($Global:RhapsodyConnection -and !$Force) {
        if ($newConnection -ne $Global:RhapsodyConnection) {
            throw [InvalidOperationException] "Already connected with different params. Run 'Disconnect-Rhapsody' first or use -Force to override."
        }
        else {
            Write-Verbose "Already connected. Nothing to do."
            $Global:RhapsodyConnection
        }
    }
    else {
        try {
            if ($SkipCertificateCheck) { 
                Disable-CertificateValidation -ErrorAction 'Stop'
            }
            else { 
                Enable-CertificateValidation -ErrorAction 'Stop' 
            }

            $iwrParams = @{
                Credential  = $Credential
                Uri         = $BaseUri
                Method      = 'Get'
                ErrorAction = 'Stop'
            }
            $response = Invoke-WebRequest @iwrParams
            $summary = Get-ResponseSummary $response
            
            if ($response.BaseResponse.StatusDescription -eq 'OK') {
                Write-Verbose $summary 
                $Global:RhapsodyConnection = $newConnection
                $Global:RhapsodyConnection
            }
            else {
                if ($SkipCertificateCheck) { Enable-CertificateValidation }
                throw [ExternalException] $summary
            }
        }
        catch {
            if ($Force) {
                if ($summary) { Write-Warning $summary }
                Write-Warning "Rhapsody API connection failed! Forcing new connection settings anyway. Good luck."
                $Global:RhapsodyConnection = $newConnection
                $Global:RhapsodyConnection
            }
            else {
                if ($summary) { Write-Error $summary }
                Write-Error "Rhapsody API connection failed!"
                if ($SkipCertificateCheck) { Enable-CertificateValidation }
                throw $_.Exception
            }
        }
    }
}