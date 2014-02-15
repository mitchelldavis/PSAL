function Set-Abstraction
{
	param(
        [Parameter(Mandatory=$true)]
        [string]
        $commandName)

    $origCommand = get-command $commandName | Select-Object -First 1

    if($origCommand -eq $null)
    {
        throw new-object System.ArgumentException("{0} is not a recognized command or function." -f $commandName)
    }

    $newCommandName = ("{0}Wrapper" -f $origCommand.Name)

    if(Test-Path Function:\$newCommandName)
    {
        return
    }

    $metadata = New-Object System.Management.Automation.CommandMetaData $origCommand
    $metadata.Parameters.Remove("Verbose") | out-null
    $metadata.Parameters.Remove("Debug") | out-null
    $metadata.Parameters.Remove("ErrorAction") | out-null
    $metadata.Parameters.Remove("WarningAction") | out-null
    $metadata.Parameters.Remove("ErrorVariable") | out-null
    $metadata.Parameters.Remove("WarningVariable") | out-null
    $metadata.Parameters.Remove("OutVariable") | out-null
    $metadata.Parameters.Remove("OutBuffer") | out-null

    $cmdLetBinding = [Management.Automation.ProxyCommand]::GetCmdletBindingAttribute($metadata)
    $params = [Management.Automation.ProxyCommand]::GetParamBlock($metadata)
    $newContent=Microsoft.PowerShell.Management\Get-Content function:\AbstractionPrototype

    Microsoft.PowerShell.Management\Set-Item Function:\script:$newCommandName -value "$cmdLetBinding `r`n param ( $params )Process{ `r`n$newContent}"
}

function AbstractionPrototype 
{
    Write-Host ("Mock Prototype: {0}" -f $MyInvocation.MyCommand.Name) -ForegroundColor DarkCyan
}
