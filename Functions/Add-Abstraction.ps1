$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Get-PSAL.ps1)

function Add-Abstraction {
    param(  [Parameter(Mandatory=$true)]
            [string]$Name,
            [Parameter(Mandatory=$true)]
            [System.Management.Automation.CommandInfo]$command)
    
    $psal = Get-PSAL

    if($psal.Abstractions -eq $null)
    {
        $psal.Abstractions = @(New-Object PSObject | Select-Object @{Name="Name";Expression={$Name}},@{Name="AbstractedCommand";Expression={$command}})
    }
    else
    {
        $psal.Abstractions += (New-Object PSObject | Select-Object @{Name="Name";Expression={$Name}},@{Name="AbstractedCommand";Expression={$command}})
    }
}

