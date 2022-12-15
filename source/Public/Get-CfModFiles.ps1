function Get-CfModFiles {
    [CmdletBinding(DefaultParameterSetName="List mod files")]
    param (
        [Parameter(Mandatory,ParameterSetName="List mod files")][int]$modId,
        [Parameter(ParameterSetName="List mod files")][string]$gameVersion,
        [Parameter(ParameterSetName="List mod files")][int]$modLoaderType,
        [Parameter(ParameterSetName="List mod files")][int]$gameVersionTypeId,
        [Parameter(ParameterSetName="List mod files")][int]$index,
        [Parameter(ParameterSetName="List mod files")][int]$pageSize,
        [Parameter(Mandatory,ParameterSetName="Get mod file")]
        [Parameter(Mandatory,ParameterSetName="Get mod file download url")]$fileId
    )

    process {
        $Uri = "https://api.curseforge.com/v1/mods/$ModId/files"

        switch ($PsCmdlet.ParameterSetName) {
            "List mod files" {
                #Parameters to exclude in Uri build
                $ParameterExclusion = @("ModId")

                #Build request Uri
                $PSBoundParameters.Keys.ForEach({
                    $Key = $_
                    $Value = $PSBoundParameters.$key

                    #Check if parameter is excluded
                    if ($ParameterExclusion -contains $Key) {
                        return
                    }

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
            "Get mod file" {
                $Uri = "$Uri/$FileId"
            }
            "Get mod file download url" {
                $Uri = "$Uri/$FileId/download-url"
            }
        }

        $splat = $BodySplat + @{
            "Method" = "GET"
            "Uri" = $Uri
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
                "Content-Type" = "application/json"
            }
        }
        $result = Invoke-RestMethod @splat
        $result.data
    }
}