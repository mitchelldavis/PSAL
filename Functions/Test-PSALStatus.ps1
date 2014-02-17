$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Get-PSAL.ps1)

function Test-PSALStatus
{
<#
.SYNOPSIS
    Returns the status of the abstraction layer.

.DESCRIPTION
    If the abstraction layer is on, this function returns true.
    If the abstraction layer is off, this function returns false.

.LINK
    Describe
    about_PSAL
#>
    return (Get-PSAL).IsAbstracting
}
