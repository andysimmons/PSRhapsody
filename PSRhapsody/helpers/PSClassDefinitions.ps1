using namespace Microsoft.PowerShell.Commands
using namespace System.Xml
using namespace System.Runtime.InteropServices

# communication point
[CmdletBinding()]
class CommPoint {

    # properties
    hidden [pscredential] $Credential
    hidden [Uri]          $BaseUri
    
    [int]      $Id
    [string]   $Name
    [string]   $FolderPath
    [string]   $Mode
    [string]   $State
    [string]   $CommPointType
    [timespan] $InputIdleTime
    [int]      $OutQueueSize
    [timespan] $OutputIdleTime
    [timespan] $Uptime
    [int]      $ConnectionCount
    [int]      $SentCount

    # constructors
    CommPoint ([Uri] $BaseUri, [int] $Id, [pscredential] $Credential) { 
        $this.Initialize($BaseUri, $Id, $Credential)
    }

    # methods

    # initialize a CommPoint object
    hidden [void] Initialize ([Uri] $BaseUri, [int] $Id, [pscredential] $Credential) {
        $this.BaseUri = $BaseUri
        $this.Id = $Id
        $this.Credential = $Credential

        try { $this.Refresh() }
        catch {
            Write-Error "Initialization failed."
            throw $_.Exception
        }
    }

    # start a comm point
    [CommPoint] Start () {
        $this.Refresh()
        if ($this.State -eq 'RUNNING') {
            Write-Warning "Communication point was already running."
            return $this
        }
        else { return $this.Invoke('Start') }
    }
    
    # stop a comm point
    [CommPoint] Stop () { 
        $this.Refresh()
        if ($this.State -eq 'STOPPED') {
            Write-Warning "Communication point was already stopped."
            return $this
        }
        return $this.Invoke('Stop') 
    }
    
    # restart a comm point
    [CommPoint] Restart () { return $this.Invoke('Restart') }

    # invokes an action (start, stop, restart) on a comm point
    hidden [CommPoint] Invoke ([CommPointAction] $Action) {
        $iwrParams = @{
            Uri         = $("{0}api/commpoint/{1}/state" -f $this.BaseUri, $this.Id)
            Method      = 'PUT'
            Body        = $Action
            ContentType = 'Text/Plain'
            Credential  = $this.Credential
            ErrorAction = 'Continue'
        }
        $response = Invoke-WebRequest @iwrParams

        # summarize the response as a string
        $summary = '[HTTP/{0} {1} {2}] {3} {4}' -f @(
            $response.BaseResponse.ProtocolVersion
            $response.BaseResponse.StatusCode -as [int]
            $response.BaseResponse.StatusDescription
            $response.BaseResponse.Method
            $response.BaseResponse.ResponseURI
        )

        switch ($response.BaseResponse.StatusCode -as [int]) {
            204 { 
                Write-Verbose $summary
                Write-Verbose "$Action request accepted."
                Start-Sleep -Seconds 1
            }
            500 { 
                Write-Error $summary
                throw [ExternalException] "State change failed!" }
            400 {
                Write-Error $summary
                Write-Error "Documented comm point actions: $([Enum]::GetNames([CommPointAction]) -join ', ')"
                throw [ArgumentOutOfRangeException] "Server doesn't know how to $Action a comm point."
            }
            default { throw "This wasn't in the docs. Not sure what happened. ($summary)" }
        }

        $this.Refresh()
        return $this
    }

    # refresh information about a comm point
    [void] Refresh () {
        try {
            $irmParams = @{
                Uri         = $("{0}api/commpoint/{1}" -f $this.BaseUri, $this.Id)
                Credential  = $this.Credential
                Method      = 'GET'
                ErrorAction = 'Stop'
            }
            $data = (Invoke-RestMethod @irmParams).Data
        }
        catch { throw $_.Exception }

        # assign properties that can be coerced as-is
        $usableProps = 'Name', 'FolderPath', 'Mode', 'State', 'CommPointType', 'OutQueueSize', 'ConnectionCount', 'SentCount'
        $usableProps.ForEach({$this.$_ = $data.$_})
 
        # deserialize non-null timespan properties
        $xmlTsProps = 'InputIdleTime', 'OutPutIdleTime', 'Uptime'
        foreach ($prop in $xmlTsProps) {
            try { $this.$prop = [XmlConvert]::ToTimeSpan($data.$prop) }
            catch { $this.$prop = 0 }
        }
    }

    # override ToString() 
    [string] ToString () {
        return '{0} (ID: {1})' -f $this.Name, $this.Id
    }
}

# valid communication point actions
enum CommPointAction {
    START
    STOP
    RESTART
}