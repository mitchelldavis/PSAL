$script:PSAL = New-Object PSObject | Select-Object @{Name="IsAbstracting";Expression={$false}},@{Name="Abstractions";Expression={@()}}

$here = Split-Path -Parent $MyInvocation.MyCommand.Path

@("$PSScriptRoot\Functions\*.ps1") | Resolve-Path |
  ? { -not ($_.ProviderPath.Contains(".Tests.")) } |
  % { . $_.ProviderPath }


Export-ModuleMember "New-Abstraction","Enable-AbstractionLayer","Disable-AbstractionLayer","Set-AbstractionLayer","Test-PSALStatus"
