function Get-CfMods {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ParameterSetName="Search mods")]$gameId,
        [Parameter(ParameterSetName="Search mods")]$classId,
        [Parameter(ParameterSetName="Search mods")]$categoryId,
        [Parameter(ParameterSetName="Search mods")]$gameVersion,
        [Parameter(ParameterSetName="Search mods")]$searchFilter,
        [Parameter(ParameterSetName="Search mods")]$sortField,
        [Parameter(ParameterSetName="Search mods")][ValidateSet("asc","desc")]$sortOrder,
        [Parameter(ParameterSetName="Search mods")][ValidateScript({
            #todo: get all modloader types
        })][string]$modLoaderType,
        [Parameter(ParameterSetName="Search mods")][int]$gameVersionTypeId,
        [Parameter(ParameterSetName="Search mods")][string]$slug,
        [Parameter(ParameterSetName="Search mods")][int]$index,
        [Parameter(ParameterSetName="Search mods")][int]$pageSize,
        [Parameter(Mandatory,ParameterSetName="Get mod by id")]$modId,
        [Parameter(Mandatory,ParameterSetName="Get a list of mods")][array]$modIds
    )

    process {
        $uri = "https://api.curseforge.com/v1/mods"

        switch ($PsCmdlet.ParameterSetName) {
            "Search mods" {
                $uri = "$uri/search"
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
            "Get mod by id" {
                $uri = "$uri/$modId"
            }
            "Get a list of mods" {
                $splat = @{
                    "Body" = @{
                        "modIds" = $modIds
                    } | ConvertTo-Json
                }
            }
        }

        $splat = $splat + @{
            "Uri" = $uri
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
            }
        }
        $result = Invoke-RestMethod @splat
        $result.data
    }
}