using namespace System.Net
<#
.SYNOPSIS
    Disables server certificate validation.

.DESCRIPTION
    Disables server certificate validation, to allow connections to servers using
    untrusted (e.g. self-signed) certificates.

.EXAMPLE
    Disable-CertificateValidation

    Disables certificate checks for the rest of the PowerShell session.
#>
function Disable-CertificateValidation {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    if ($PSCmdlet.ShouldProcess('Certificate Validation', 'DISABLE')) {
        # create a dummy SPM with a delegate that validates everything
        if (!('ServicePointManagerDummy' -as [type])) {
            $dummyCallback = Get-Content -Path "${PSScriptRoot}\ServicePointManagerDummy.cs" -Raw
            Add-Type -TypeDefinition $dummyCallback
        }

        # shorten the service point lifetime to 1 ms - don't want these SPs sticking around
        [ServicePointManager]::MaxServicePointIdleTime = 1

        # accept certs willy nilly
        [ServicePointManager]::ServerCertificateValidationCallback = [ServicePointManagerDummy]::GetDelegate()
        Write-Warning 'SSL certificate validation DISABLED.'
    }
}