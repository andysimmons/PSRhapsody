$ProjectPath = Split-Path $PSScriptRoot

if ($env:APPVEYOR) {
    $ModuleName = $env:Appveyor_Project_Name
}
else {
    $ModuleName = Split-Path $ProjectPath -Leaf
}

$ModulePath = Join-Path $ProjectPath $ModuleName

InModuleScope -ModuleName $ModuleName {
    # Hard to mock much in here without making a bunch of useless tests. This module primarily
    # deals with external system states.
    Context 'Public Functions' {
        Describe 'Get-CommPoint' {
            It 'Requires a connection' {
                { Get-CommPoint -Id 6223 } | Should -Throw "Run 'Connect-Rhapsody' first."
            }
        }
        Describe 'Connect-Rhapsody' {
            $crParams = @{
                BaseUri              = 'https://bogus.rhapsody.uri:8444'
                Credential           = [pscredential]::new('user', [securestring]::new())
                SkipCertificateCheck = $true
                WarningAction        = 'SilentlyContinue'
                ErrorAction          = 'Stop'
            }
            It 'Validates API connectivity before configuring connection' {
                { Connect-Rhapsody @crParams } | Should -Throw
            }
            It 'Configures API connection' {
                $crParams['Force'] = $true
                Connect-Rhapsody @crParams | Out-Null

                $Global:RhapsodyConnection.BaseUri | Should Be ($crParams.BaseUri -as [uri])
                $Global:RhapsodyConnection.SkipCertificateCheck | Should Be $crParams.SkipCertificateCheck
            }
        }

        Describe 'Disconnect-Rhapsody' {
            $dummyConnection = [pscustomobject] @{ 
                SkipCertificateCheck = $true
                PrevMaxIdleTime      = 100000
            }
            $Global:RhapsodyConnection = $dummyConnection

            Disconnect-Rhapsody -WarningAction 'SilentlyContinue'
            it 'Removes connection configuration from memory' {
                { Get-Variable -Scope 'Global' -Name 'RhapsodyConnection' -ErrorAction 'Stop' } | Should -Throw
            }
            it 'Restores previous Service Point Manager configuration' {
                [Net.ServicePointManager]::MaxServicePointIdleTime | Should Be $dummyConnection.PrevMaxIdleTime
            }
        }
    }
        
    Context 'Private Functions' {
        Describe 'Disable-CertificateValidation' { 
            Disable-CertificateValidation -WarningAction 'SilentlyContinue'
            $spCallback = [Net.ServicePointManager]::ServerCertificateValidationCallback
            $spTimeout = [Net.ServicePointManager]::MaxServicePointIdleTime
            
            It 'Disables SSL certificate validation' {
                $spCallback.Method[0].Name | Should Be 'ReturnTrue'
            }
            It "Disables service point caching" {
                $spTimeout | Should Be 1
            }
        }
        
        Describe 'Enable-CertificateValidation' { 
            Enable-CertificateValidation -WarningAction 'SilentlyContinue'
            $spCallback = [Net.ServicePointManager]::ServerCertificateValidationCallback
            $spTimeout = [Net.ServicePointManager]::MaxServicePointIdleTime
            
            It 'Enforces SSL certificate validation' {
                $spCallback | Should BeNullOrEmpty
            }
            It "Enables service point caching" {
                { $spTimeout -gt 1 } | Should Be $true
            }
        }
    }
}
