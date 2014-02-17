$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Enable-AbstractionLayer.ps1)

Describe "Enable-AbstractionLayer Tests" {
    Mock Set-AbstractionLayer -Verifiable -ParameterFilter { $Enabled -eq $true }

    Enable-AbstractionLayer

    It "Are the mocks called?" {
        Assert-VerifiableMocks
    }
}

