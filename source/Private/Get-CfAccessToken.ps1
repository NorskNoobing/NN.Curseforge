function Get-CfAccessToken {
    [CmdletBinding()]
    param (
        [string]$AccessTokenPath = "$env:USERPROFILE\.creds\Curseforge\CurseforgeAccessToken.xml"
    )

    process {
        if (!(Test-Path $AccessTokenPath)) {
            New-CfAccessToken
        }
    
        Import-Clixml $AccessTokenPath | ConvertFrom-SecureString -AsPlainText
    }
}