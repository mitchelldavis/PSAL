$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Set-AbstractionLayer.ps1)

function Enable-AbstractionLayer
{
<#
.SYNOPSIS
    Turns the abstraction layer on.

.LINK
    Describe
    about_PSAL
#>
    Set-AbstractionLayer -Enabled:$true
}
