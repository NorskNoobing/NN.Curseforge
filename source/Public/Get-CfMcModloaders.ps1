function Get-CfMcModloaders {
    [CmdletBinding(DefaultParameterSetName="List modloaders")]
    param (
        [Parameter(ParameterSetName="List modloaders")][string]$version,
        [Parameter(ParameterSetName="List modloaders")][bool]$includeAll = $true,
        [Parameter(Mandatory,ParameterSetName="Get specific modloader")][string]$modLoaderName
    )

    process {
        $Uri = "https://api.curseforge.com/v1/minecraft/modloader"

        switch ($PsCmdlet.ParameterSetName) {
            "List modloaders" {
                #Build request Uri
                $PSBoundParameters.Keys.ForEach({
                    [string]$Key = $_
                    [string]$Value = $PSBoundParameters.$key

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
            "Get specific modloader" {
                $Uri = "$Uri/$ModLoaderName"
            }
        }

        $splat = @{
            "Method"  = "GET"
            "Uri"     = $Uri
            "Headers" = @{
                "x-api-key" = Get-CfAccessToken
            }
        }
        $Result = Invoke-RestMethod @splat
        $Result.data
    }
}