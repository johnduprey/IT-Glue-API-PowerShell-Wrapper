function Get-ITGlueFlexibleAssetTypes {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [String]$filter_name = "",

        [Parameter(ParameterSetName="index")]
        [String]$filter_icon = "",

        [Parameter(ParameterSetName="index")]
        [String]$filter_enabled = "",

        [Parameter(ParameterSetName="index")]
        [ValidateSet( "name",  "id", `
                     "-name", "-id")]
        [String]$sort = "",

        [Parameter(ParameterSetName="index")]
        [Nullable[Int]]$page_number = $null,

        [Parameter(ParameterSetName="index")]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName="show")]
        [Nullable[Int]]$id = $null
    )

    $resource_uri = "/flexible_asset_types/${id}"

    if($PSCmdlet.ParameterSetName -eq "index") {
        $body = @{
                "sort" = $sort
        }
        if($filter_name) {
            $body += @{"filter[name]" = $filter_name}
        }
 
        if($filter_organization_id) {
            $body += @{"filter[icon]" = $filter_icon}
        }
        if($filter_enabled) {
            $body += @{"filter[enabled]" = $enabled}
        }
        if($page_number) {
            $body += @{"page[number]" = $page_number}
        }
        if($page_size) {
            $body += @{"page[size]" = $page_size}
        }
    }

    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "GET" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}

function New-ITGlueFlexibleAssetTypes {
    [CmdletBinding(DefaultParameterSetName="index")]
    Param (
        [Parameter(ParameterSetName="index")]
        [Int]$organization_id,

        [Parameter(ParameterSetName="index")]
        [Int]$flexible_asset_type_id,

        [Parameter(ParameterSetName="index")]
        [String]$traits
    )

    $resource_uri = "/flexible_assets"

    $post = @{
        data = @{
            "type" = "flexible-assets"
            "attributes" = @{    
                "flexible-asset-type-id" = $flexible_asset_type_id
                "organization-id" = $organization_id
                "traits" = $traits | ConvertFrom-Json
            }
        }
    }
    $body = $post | ConvertTo-Json -Depth 10
    $ITGlue_Headers.Add("x-api-key", (New-Object System.Management.Automation.PSCredential 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method "POST" -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
                                     -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data

}