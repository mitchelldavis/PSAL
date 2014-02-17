$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here New-Abstraction.ps1)

Describe "New-Abstraction Tests" {
    Context "If Command not found, An ArgumentException is thrown" {
        $exceptionThrown = $false

        try
        {
            New-Abstraction ("{0}" -f [Guid]::NewGuid())
        }
        catch [System.ArgumentException] { $exceptionThrown = $true }

        It "Was the exception thrown?" {
            $exceptionThrown | should be $true
        }
    }

    Context "If the abstraction was already created, do not do anything." {
        $commandName = "Get-PSALAbstraction"
        Mock Test-Path { return $true }
        Mock Add-Abstraction -verifiable
        Mock Set-Item

        New-Abstraction "Get-PSAL"

        It "Were the mocks called?" {
            Assert-MockCalled "Add-Abstraction" -Times 0
        }
    }

    Context "Was the abstraction created?" {
        New-Abstraction "Get-PSAL"

        It "Does the new function exist?" {
            Test-Path Function:\Get-PSALAbstraction | should be $true
        }
    }
}
