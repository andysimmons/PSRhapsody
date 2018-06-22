<#
.SYNOPSIS
    Starts a communication point.

.PARAMETER CommunicationPoint
    CommPoint object to be started.

.EXAMPLE
    Get-CommPoint -Id 6223 | Start-CommPoint

    Retrieves the commpoint object with ID 6223 and starts it.
#>
function Start-CommPoint {
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
            if ($PSCmdlet.ShouldProcess($cp, 'START')) { 
                $cp.Start() 
            }
        }
    }
}