$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Set-AbstractionLayer.ps1)

function Disable-AbstractionLayer
{
<#
.SYNOPSIS
    Turns the abstraction layer off.

.LINK
    Describe
    about_PSAL
#>
    Set-AbstractionLayer -Enabled:$false
}
