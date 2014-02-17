$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Disable-AbstractionLayer.ps1)

Describe "Disable-AbstractionLayer Tests" {
    Mock Set-AbstractionLayer -Verifiable -ParameterFilter { $Enabled -eq $false }

    Disable-AbstractionLayer

    It "Are the mocks called?" {
        Assert-VerifiableMocks
    }
}
