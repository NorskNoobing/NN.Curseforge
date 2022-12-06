function Get-CfModDescription {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$modId
    )

    process {
        $splat = @{
            "Uri" = "https://api.curseforge.com/v1/mods/$modId/description"
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
            }
        }
        Invoke-RestMethod @splat
    }
}