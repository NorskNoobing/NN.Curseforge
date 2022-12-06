function Get-CfGames {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ParameterSetName="List games")][int]$index,
        [Parameter(Mandatory,ParameterSetName="List games")][int]$pageSize,
        [Parameter(Mandatory,ParameterSetName="Get game by id")][int]$gameId
    )

    process {
        $uri = "https://api.curseforge.com/v1/games"

        switch ($PsCmdlet.ParameterSetName) {
            "List games" {
                $PSBoundParameters.Keys.ForEach({
                    $key = $_
                    $value = $PSBoundParameters.$key
    
                    if (([array]$PSBoundParameters.Keys)[0] -eq $key) {
                        $delimiter = "?"
                    } else {
                        $delimiter = "&"
                    }
    
                    $uri = "$uri$delimiter$key=$value"
                })
            }
            "Get game by id" {
                $uri = "$uri/$gameId"
            }
        }

        $splat = @{
            "Uri" = $uri
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
            }
        }
        Invoke-RestMethod @splat
    }
}