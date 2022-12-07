function Get-CfGameVersions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$gameId
    )

    process {
        $splat = @{
            "Method" = "GET"
            "Uri" = "https://api.curseforge.com/v1/games/$gameId/versions"
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
            }
        }
        $result = Invoke-RestMethod @splat
        $result.data
    }
}