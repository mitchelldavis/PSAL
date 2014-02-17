$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $here Get-PSAL.ps1)
. (Join-Path $here Add-Abstraction.ps1)

function New-Abstraction
{
<#
.SYNOPSIS
    Creates a new function that can be used as an abstraction of the original.

.DESCRIPTION
    Given an existing command, a new function is generated with the postfix "Abstraction".
    
    This new function can be used instead of the original command in order to abstract execution of
    the original command.

    If the abstraction layer is active, then the new function will simply call the original command.
    Otherwise, it will do no processing.

.PARAMETER commandName
    The name of the command to abstract.

.EXAMPLE
    New-Abstraction "Invoke-Command"
    Invoke-CommandAbstraction "TestServer" SomeScript.ps1

    This example outlines how to abstract a critical cmdlet called Invoke-Command.  While abstracted,
    the cmdlet is not invoked, leaving the remote machines untouched.

.LINK
    about_PSAL
#>
	param(
        [Parameter(Mandatory=$true)]
        [string]
        $commandName)

    $origCommand = get-command $commandName -ErrorAction SilentlyContinue | Select-Object -First 1

    if($origCommand -eq $null)
    {
        throw New-Object System.ArgumentException("{0} is not a recognized command or function." -f $commandName)
    }

    $newCommandName = ("{0}Abstraction" -f $origCommand.Name)

    if(Test-Path Function:\$newCommandName)
    {
        return
    }

    $metadata = New-Object System.Management.Automation.CommandMetaData $origCommand

    $cmdLetBinding = [Management.Automation.ProxyCommand]::GetCmdletBindingAttribute($metadata)
    $params = [Management.Automation.ProxyCommand]::GetParamBlock($metadata)
    $newContent=Microsoft.PowerShell.Management\Get-Content function:\AbstractionPrototype

    $al = Get-PSAL

    Microsoft.PowerShell.Management\Set-Item Function:\global:$newCommandName -value "$cmdLetBinding `r`n param ( $params )Process{ `r`n$newContent}"

    Add-Abstraction $newCommandName $origCommand
}

function AbstractionPrototype
{
    $cmdName = $MyInvocation.MyCommand.Name
    if(Test-PSALStatus) 
    { 
        $abstraction = Get-Abstraction $cmdName
        &($abstraction.AbstractedCommand.Name) @PSBoundParameters
    }
    else
    {
        Write-Host ("`t{0} called:" -f $cmdName) -ForegroundColor DarkCyan 
        $PSBoundParameters.Keys | foreach { Write-Host ("`t`t{0}: {1}" -f $_,$PSBoundParameters[$_]) -ForegroundColor DarkGray }
    }
}
