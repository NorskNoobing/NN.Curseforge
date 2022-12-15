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
        [Parameter(ParameterSetName="Search mods")][int]$modLoaderType,
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
                $Method = "GET"
                $uri = "$uri/search"
                #Build request Uri
                $PSBoundParameters.Keys.ForEach({
                    $Key = $_
                    $Value = $PSBoundParameters.$key

                    #Check for "?" in Uri and set delimiter
                    if (!($Uri -replace "[^?]+")) {
                        $Delimiter = "?"
                    }
                    else {
                        $Delimiter = "&"
                    }

                    $Uri = "$Uri$Delimiter$Key=$Value"
                })
            }
            "Get mod by id" {
                $Method = "GET"
                $uri = "$uri/$modId"
            }
            "Get a list of mods" {
                $Method = "POST"
                $BodySplat = @{
                    "Body" = @{
                        "modIds" = $modIds
                    } | ConvertTo-Json
                }
            }
        }

        $splat = $BodySplat + @{
            "Method" = $Method
            "Uri" = $uri
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
                "Content-Type" = "application/json"
            }
        }
        $result = Invoke-RestMethod @splat
        $result.data
    }
}