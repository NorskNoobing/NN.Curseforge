function Get-CfGameVersions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$gameId
    )

    process {
        $splat = @{
            "Uri" = "https://api.curseforge.com/v1/games/$gameId/versions"
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
            }
        }
        Invoke-RestMethod @splat
    }
}