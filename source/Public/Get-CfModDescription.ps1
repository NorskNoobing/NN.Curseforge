function Get-CfModDescription {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$modId
    )

    process {
        $splat = @{
            "Method" = "GET"
            "Uri" = "https://api.curseforge.com/v1/mods/$modId/description"
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
            }
        }
        Invoke-RestMethod @splat
    }
}