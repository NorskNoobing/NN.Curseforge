function New-CfAccessToken {
    [CmdletBinding()]
    param (
        [string]$AccessTokenPath = "$env:USERPROFILE\.creds\Curseforge\CurseforgeAccessToken.xml"
    )

    process {
        $ApiKey = Read-Host "Enter Curseforge API key" -AsSecureString
    
        #Create parent folders of the access token file
        $AccessTokenDir = $AccessTokenPath.Substring(0, $AccessTokenPath.lastIndexOf('\'))
        if (!(Test-Path $AccessTokenDir)) {
            $null = New-Item -ItemType Directory $AccessTokenDir
        }
    
        #Create access token file
        $ApiKey | Export-Clixml $AccessTokenPath
    }
}