function Enable-PSTranscription 
{  
    [CmdletBinding()]  
    param
    (  
        [Parameter(Mandatory=$false)]
        [string]$OutputDirectory,  
        
        [Switch]$IncludeInvocationHeader  
    )  
 
    ## Ensure the base path exists  
    $basePath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\Transcription" 
    if(-not (Test-Path $basePath))  
    {
        Write-Verbose -Message "Creating Base Registry Path"  
        $null = New-Item $basePath –Force  
    }

    ## Enable transcription  
    Set-ItemProperty $basePath -Name EnableTranscripting -Value 1
 

    ## Set the output directory  
    if($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("OutputDirectory"))  
    {  
        Write-Verbose -Message "Setting Output Directory to [$($OutputDirectory)]"
        Set-ItemProperty $basePath -Name OutputDirectory -Value $OutputDirectory  
    }
 

    ## Set the invocation header  
    if ($IncludeInvocationHeader)  
    {
        Write-Verbose -Message "Enabling Invovation Header"
        Set-ItemProperty $basePath -Name EnableInvocationHeader -Value 1  
    } 
}

function Enable-PSScriptBlockLogging 
{  
    $basePath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"  
 
    if(-not (Test-Path $basePath))  
    {  
        $null = New-Item $basePath –Force  
    }
   
    Set-ItemProperty $basePath -Name EnableScriptBlockLogging -Value "1" 
}
 

function Disable-PSTranscription 
{  
    Remove-Item HKLM:\Software\Policies\Microsoft\Windows\PowerShell\Transcription -Force –Recurse 
}

function Disable-PSScriptBlockLogging 
{  
    Remove-Item HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -Force –Recurse 
}
 

function Enable-PSScriptBlockInvocationLogging 
{
    $basePath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"  
 
    if(-not (Test-Path $basePath))  
    {  
        $null = New-Item $basePath –Force  
    }  
 
    Set-ItemProperty $basePath -Name EnableScriptBlockInvocationLogging -Value "1" 
}

function Enable-PSModuleLogging 
{
    $basePath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging"  
 
    if(-not (Test-Path $basePath))  
    {  
        $null = New-Item $basePath –Force  
    }  
 
    Set-ItemProperty $basePath -Name EnableModuleLogging -Value "1" 
}