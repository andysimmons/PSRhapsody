using namespace Microsoft.PowerShell.Commands
function Get-ResponseSummary {
    [OutputType([string])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, Position = 0)]
        [HtmlWebResponseObject[]]
        $Response
    )

    process {    
        foreach ($r in $Response) {
            $blanks = @(
                $r.BaseResponse.ProtocolVersion
                $r.BaseResponse.StatusCode -as [int]
                $r.BaseResponse.StatusDescription
                $r.BaseResponse.Method
                $r.BaseResponse.ResponseURI
            )

            '[HTTP/{0} {1} {2}] {3} {4}' -f $blanks
        }
    }
}