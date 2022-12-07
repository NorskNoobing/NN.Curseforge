function Get-CfGames {
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName="List games")][int]$index,
        [Parameter(ParameterSetName="List games")][int]$pageSize,
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
            "Method" = "GET"
            "Uri" = $uri
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
            }
        }
        $result = Invoke-RestMethod @splat
        $result.data
    }
}