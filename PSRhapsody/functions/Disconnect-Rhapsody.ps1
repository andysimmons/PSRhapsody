<#
.SYNOPSIS
    "Disconnect" from the current Rhapsody instance.

.DESCRIPTION
    Technically this just removes the connection configuration from memory, so other
    cmdlets can't run. I may add session support down the road, but there's not actually
    a persistent connection.

.EXAMPLE
    Disconnect-Rhapsody

    Removes any Rhapsody connection information from memory.
#>
function Disconnect-Rhapsody {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    if ($Global:RhapsodyConnection) {
        if ($PSCmdlet.ShouldProcess($Global:RhapsodyConnection.BaseUri, 'DISCONNECT')) {
            try { Remove-Variable -Name RhapsodyConnection -Scope Global -Force -ErrorAction Stop }
            catch { 
                Write-Error "Error disconnecting from $($Global:RhapsodyConnection.BaseUri)"
                throw $_.Exception
            }
        }
    }
    else { Write-Verbose "No connections found. Nothing to do." }
}