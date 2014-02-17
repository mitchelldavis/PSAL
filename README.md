**PSAL**
*PowerShell Abstraction Layer*

Using the abstraction layer is easy.  Once the module is imported, you can begin to create abstracted commands and functions.

For Example:
    Import-Module PSAL

    New-Abstraction "Invoke-Command"

    Invoke-CommandAbstraction -ComputerName "TestServer" -FilePath .\SomeScript.ps1

Immediatly the abstraction layer is turned off, so the above script will do nothing on the "TestServer" machine.  To turn on the abstraction layer simply call the `Enable-AbstractionLayer` function.

    Enable-AbstractionLayer

You can also call the `Set-AbstractionLayer` with the `-Enable` switch.

    Set-AbstractionLayer -Enable

To turn the abstraction layer back off, you can call the `Disable-AbstractionLayer` function.

    Disable-AbstractionLayer

You can also call the `Set-AbstractionLayer` without the `-Enable` switch.

    Set-AbstractionLayer

If you're ever curious if the abstraction layer is on or off, you can call the `Test-PSALStatus` function.  it returns true if the abstraction layer is active and false otherwise.

It's that simple to abstract critical cmdlets and functions within your scripts.
