<#
.SYNOPSIS
    Restarts a communication point.

.PARAMETER CommunicationPoint
    CommPoint object to be restarted.

.EXAMPLE
    Get-CommPoint -Id 6223 | Restart-CommPoint

    Retrieves the commpoint object with ID 6223 and restarts it.
#>
function Restart-CommPoint {
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
            if ($PSCmdlet.ShouldProcess($cp, 'RESTART')) { 
                $cp.Restart() 
            }
        }
    }
}