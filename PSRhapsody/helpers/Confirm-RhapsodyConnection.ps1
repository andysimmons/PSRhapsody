<#
.SYNOPSIS
    Throws an error unless the Rhapsody connection hasn't been set up.
#>
function Confirm-RhapsodyConnection {
    [CmdletBinding()]
    param ()

    if ($Global:RhapsodyConnection) {
        Write-Verbose "Rhapsody URI: $($Global:RhapsodyConnection.BaseUri)"
    }
    else {
        throw [InvalidOperationException] "Run 'Connect-Rhapsody' first."
    }
}