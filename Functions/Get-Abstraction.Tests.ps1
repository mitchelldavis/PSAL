$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Get-Abstraction.ps1)
. (Join-Path $here Add-Abstraction.ps1)

Describe "Get-Abstraction Tests" {
    $psalResult = new-object PSObject | Select-Object @{Name="IsAbstracting";Expression={$false}},@{Name="Abstractions";Expression={@()}}
    $command1 = Get-Command "Get-PSAL" | Select-Object -First 1
    $command2 = Get-Command "Add-Abstraction" | Select-Object -First 1
    Mock Get-PSAL { return $psalResult }
    Add-Abstraction "Test Name" $command1
    Add-Abstraction "Test Name Again" $command2

    It "Can We get the abstraction?" {
        (Get-Abstraction "Test Name") -eq $null | should be $false
    }

    It "Did we get the correct abstraction? (Name)" {
        (Get-Abstraction "Test Name").Name | should be "Test Name"
    }

    It "Did we get the correct abstraction? (Command)" {
        (Get-Abstraction "Test Name").AbstractedCommand -eq $null | should be $false
        (Get-Abstraction "Test Name").AbstractedCommand  | should be $command1
    }

    It "Did we get the correct abstraction? (Second Name)" {
        (Get-Abstraction "Test Name Again").Name | should be "Test Name Again"
    }

    It "Did we get the correct abstraction? (Second Command)" {
        (Get-Abstraction "Test Name Again").AbstractedCommand -eq $null | should be $false
        (Get-Abstraction "Test Name Again").AbstractedCommand  | should be $command2
    }
}
