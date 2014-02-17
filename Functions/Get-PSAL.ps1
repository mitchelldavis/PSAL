function Get-PSAL
{
    if($script:PSAL -eq $null)
    {
        $script:PSAL = new-object PSObject | Select-Object @{Name="IsAbstracting";Expression={$false}},@{Name="Abstractions";Expression={@()}}
    }
    return $script:PSAL
}
