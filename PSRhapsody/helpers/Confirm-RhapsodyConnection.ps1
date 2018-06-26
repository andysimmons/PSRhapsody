<#
.SYNOPSIS
    Throws an error if the Rhapsody connection hasn't been configured..
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