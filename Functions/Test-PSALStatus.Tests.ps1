$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Test-PSALStatus.ps1)

Describe "Test-PSALStatus Tests" {
    $actualValue = $true
    Mock Get-PSAL { return new-object PSObject | select @{Name="IsAbstracting";Expression={$actualValue}}}

    It "True Test" {
        Test-PSALStatus | should be $actualValue 
    }

    $actualValue = $false

    It "False Test" {
        Test-PSALStatus | should be $actualValue
    }
}
