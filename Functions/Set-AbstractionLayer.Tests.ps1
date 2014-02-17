$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Set-AbstractionLayer.ps1)

Describe "Set-AbstractionLayer Tests" {
    $psalResult = new-object PSObject | Select-Object @{Name="IsAbstracting";Expression={$false}}
    Mock Get-PSAL { return $psalResult }

    Set-AbstractionLayer -Enabled

    It "IsAbstracting being set? (True)" {
        $psalResult.IsAbstracting | should be $true
    }

    Set-AbstractionLayer -Enabled:$false

    It "IsAbstracting being set? (False)" {
        $psalResult.IsAbstracting | should be $false
    }
}
