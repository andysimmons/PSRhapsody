<#
.SYNOPSIS
    Stops a communication point.

.PARAMETER CommunicationPoint
    CommPoint object to be stopped.

.EXAMPLE
    Get-CommPoint -Id 6223 | Stop-CommPoint

    Retrieves the commpoint object with ID 6223 and stops it.
#>
function Stop-CommPoint {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param ( 
        [Parameter(
            Mandatory, 
            ValueFromPipeline, 
            ValueFromPipelineByPropertyName, 
            Position = 0
        )]
        [CommPoint[]]
        $CommunicationPoint
    )

    begin { Confirm-RhapsodyConnection -ErrorAction 'Stop' }

    process {
        foreach ($cp in $CommunicationPoint) {
            if ($PSCmdlet.ShouldProcess($cp, 'STOP')) { 
                $cp.Stop() 
            }
        }
    }
}