$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Get-PSAL.ps1)

Describe "Get-PSAL Tests" {

    $script:PSAL = 1

    It "Is the result correct?" {
        Get-PSAL | should be 1
    }
}
