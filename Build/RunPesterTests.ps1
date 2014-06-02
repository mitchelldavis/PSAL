$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)

Import-Module (Join-Path $here "..\packages\pester\tools\pester.psm1")
Invoke-Pester -relative_path (Join-Path $here "..\Functions")