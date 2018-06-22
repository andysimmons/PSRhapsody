function Confirm-RhapsodyConnection {
    [CmdletBinding()]
    param ()

    if ($Global:RhapsodyConnection) {
        Write-Verbose "Using Rhapsody URI: $($Global:RhapsodyConnection.BaseUri)"
    }
    else {
        throw [InvalidOperationException] "Run 'Connect-Rhapsody' first."
    }
}