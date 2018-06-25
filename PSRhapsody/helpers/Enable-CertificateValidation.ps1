using namespace System.Net
<#
.SYNOPSIS
    Enables server certificate validation.

.DESCRIPTION
    Enables server certificate validation, to prevent connections to servers using
    untrusted (e.g. self-signed) certificates.

    This is already the default behavior in PowerShell. This cmdlet is just here to
    revert changes made by Disable-CertificateValidation. 

.EXAMPLE
    Enable-CertificateValidation

    (Re-)enables certificate checks for the rest of the PowerShell session.
#>
function Enable-CertificateValidation {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    if ($PSCmdlet.ShouldProcess('Certificate Validation', 'Enable')) {
        # enable validation
        [ServicePointManager]::ServerCertificateValidationCallback = $null

        # revert the max SP lifetime to the previous value (or the default of 100 sec)
        if ($Global:RhapsodyConnection.PrevMaxIdleTime -gt 1) {
            $maxIdleTime = $Global:RhapsodyConnection.PrevMaxIdleTime
        }
        else { $maxIdleTime = 100000 }
        [ServicePointManager]::MaxServicePointIdleTime = $maxIdleTime

        Write-Warning "SSL certificate validation ENABLED."
    }
}