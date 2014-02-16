import-module .\PSAL.psm1

Describe "Test-PSALStatus Tests" {
    It "True Test" {
        Mock "Get-PSAL" { return new-object PSOBject | select @{Name="IsAbstracting";Expression={$true}} }

        Test-PSALStatus | should be $true
    }
}
