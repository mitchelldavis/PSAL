$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Get-PSAL.ps1)

function Set-AbstractionLayer
{
<#
.SYNOPSIS
    Turns the abstraction layer on or off.

.DESCRIPTION
    Given the value of the 'Enabled' parameter, the abstraction layer is either 
    turned off or on.

.PARAMETER Enabled
    A switch that turns the abstraction layer on if present and off otherwise.

.EXAMPLE
    Set-AbstractionLayer -Enabled

    Turns the abstraction layer on.

.EXAMPLE
    Set-AbstractionLayer

    Turns the abstraction layer off.

.LINK
    Describe
    about_PSAL
#>
    param([switch]$Enabled)
    (Get-PSAL).IsAbstracting = $Enabled
}
