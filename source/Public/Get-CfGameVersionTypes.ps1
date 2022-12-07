function Get-CfGameVersionTypes {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$gameId
    )

    process {
        $splat = @{
            "Method" = "GET"
            "Uri" = "https://api.curseforge.com/v1/games/$gameId/version-types"
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
            }
        }
        $result = Invoke-RestMethod @splat
        $result.data
    }
}