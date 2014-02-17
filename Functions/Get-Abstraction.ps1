$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Get-PSAL.ps1)

function Get-Abstraction {
    param(  [Parameter(mandatory=$true)]
            [string]$abstractionName)

    (Get-PSAL).Abstractions | where { $_.Name -eq $abstractionName } | Select-Object -First 1
}
