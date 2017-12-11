function Get-ITGlueFlexibleAssetFields {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [Int]$flexible_asset_type_id,

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$page_number = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$id = $null
    )

    $resource_uri = "/flexible_asset_types/$flexible_asset_type_id/relationships/flexible_asset_fields/$id"

    if($PSCmdlet.ParameterSetName -eq "index") {
        if($page_number) {
            $body += @{"page[number]" = $page_number}
        }
        if($page_size) {
            $body += @{"page[size]" = $page_size}
        }
    }

    $ITGlue_Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"   
    $ITGlue_Headers.Add("Content-Type", 'application/vnd.api+json') 
    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "GET" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}

function New-ITGlueFlexibleAssetFields {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [Int]$flexible_asset_type_id,

        [Parameter(ParameterSetName="index")]
        [String]$data,

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$id = $null
    )

    $resource_uri = "/flexible_asset_types/$flexible_asset_type_id/relationships/flexible_asset_fields/$id"
    if ($id -eq $null) {
        $method = "POST"
    }
    else {
        $method = "PATCH"
    }

    $body = $data | ConvertTo-Json -Depth 10

    $ITGlue_Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"   
    $ITGlue_Headers.Add("Content-Type", 'application/vnd.api+json') 
    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method $method -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data

}

New-Alias -Name Update-ITGlueFlexibleAssetFields -Value New-ITGlueFlexibleAssetFields -ErrorAction SilentlyContinue