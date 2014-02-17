$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Add-Abstraction.ps1)

Describe "Add-Abstraction Tests" {
    $psalResult = new-object PSObject | Select-Object @{Name="IsAbstracting";Expression={$false}},@{Name="Abstractions";Expression={@()}}
    $command1 = Get-Command "Get-PSAL" | Select-Object -First 1
    $command2 = Get-Command "Add-Abstraction" | Select-Object -First 1
    Mock Get-PSAL { return $psalResult }
    Add-Abstraction "Test Name" $command1

    It "Was the abstraction added?" {
        $psalResult.Abstractions.Count | should be 1
    }

    It "Is the name correct?" {
        $psalResult.Abstractions[0].Name | should be "Test Name"
    }

    It "Is the command correct?" {
        $psalResult.Abstractions[0].AbstractedCommand | should be $command1
    }

    Add-Abstraction "Some Other Test Name" $command2

    It "Are there now two abstractions?" {
        $psalResult.Abstractions.Count | should be 2
    }
    
    It "Is the secont name correct?" {
        $psalResult.Abstractions[1].Name | should be "Some Other Test Name"
    }

    It "Is the second command correct?" {
        $psalResult.Abstractions[1].AbstractedCommand | should be $command2
    }
}
