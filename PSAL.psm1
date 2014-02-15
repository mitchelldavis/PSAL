$script:PSAL = New-Object PSObject | Select-Object @{Name="IsAbstracting";Expression={$false}},@{Name="Abstractions";Expression={@()}}

function New-Abstraction
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

    Microsoft.PowerShell.Management\Set-Item Function:\script:$newCommandName -value "$cmdLetBinding `r`n param ( $params )Process{ `r`n$newContent}"

    $al.Abstractions += @(New-Object PSObject | Select-Object @{Name="Name";Expression={$newCommandName}},@{Name="AbstractedCommand";Expression={$origCommand}})
}

function Enable-AbstractionLayer
{
    Set-AbstractionLayer -Enabled:$true
}

function Disable-AbstractionLayer
{
    Set-AbstractionLayer -Enabled:$false
}

function Set-AbstractionLayer
{
    param([switch]$Enabled)
    (Get-PSAL).IsAbstracting = $Enabled
}

function Add-Abstraction {
    param(  [Parameters(Mandatory=$true)]
            [string]$Name,
            [Parameter(Mandatory=$true)]
            [System.Management.Automation.CommandInfo]$command)

    (Get-PSAL).Abstractions += (New-Object PSObject | Select-Object @{Name="Name";Expression={$Name},@{Name="AbstractedCommand";Expression={$command}}})
}

function Get-Abstraction {
    param(  [Parameters(mandatory=$true)]
            [string]$abstractionName)

    (Get-PSAL).Abstractions | where { $_.Name -eq $cmdName } | Select-Object -First 1
}

function Get-PSAL {
    return $script:PSAL
}

function Test-PSAL {
    return Get-PSAL -ne $null
}

function Test-PSALStatus {
    return (Get-PSAL).IsAbstracting
}

function AbstractionPrototype 
{ 
    if(-Not (Test-PSAL))
    { 
        $cmdName = $MyInvocation.MyCommand.Name 
        if(Test-PSALStatus -eq $true) 
        { 
            Write-Host ("`t{0} called:" -f $cmdName) -ForegroundColor DarkCyan 
            $PSBoundParameters.Keys | foreach { Write-Host ("`t`t{0}: {1}" -f $_,$PSBoundParameters[$_]) -ForegroundColor DarkGray }
        }
        else
        {
            $abstraction = Get-Abstraction $cmdName
            &($abstraction.AbstractedCommand.Name) @PSBoundParameters
        }
    }
}

Export-ModuleMember "New-Abstraction","Enable-AbstractionLayer","Disable-AbstractionLayer","Set-AbstractionLayer","Test-PSALStatus" -Variable PSAL
