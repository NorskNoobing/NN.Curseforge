function Get-CfMcVersions {
    [CmdletBinding()]
    param (
        [bool]$sortDescending
    )

    process {
        $Uri = "https://api.curseforge.com/v1/minecraft/version"

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