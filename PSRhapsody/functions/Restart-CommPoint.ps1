function Restart-CommPoint {
    [CmdletBinding(SupportsShouldProcess)]
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
            if ($PSCmdlet.ShouldProcess('RESTART', $cp)) { 
                $cp.Restart() 
            }
        }
    }
}