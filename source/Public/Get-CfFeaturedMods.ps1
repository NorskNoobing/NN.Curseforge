function Get-CfFeaturedMods {
    [CmdletBinding()]
    param (
        [int]$gameId,
        [array]$excludedModIds,
        [int]$gameVersionTypeId
    )

    process {
        $splat = @{
            "Uri" = "https://api.curseforge.com/v1/mods/featured"
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
            }
            "Body" = @{
                "gameId" = $gameId
                "excludedModIds" = $excludedModIds
                "gameVersionTypeId" = $gameVersionTypeId
            }
        }
        Invoke-RestMethod @splat
    }
}