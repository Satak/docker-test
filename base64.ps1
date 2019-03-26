function ConvertFrom-Base64 {
    [alias("fb64")]
    [CmdletBinding()]
    param(
        [Parameter(
        Position=0, 
        Mandatory=$true, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)
        ]
        [string]$Value
    )
    return [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Value))
}

function ConvertTo-Base64 {
    [alias("tb64")]
    [CmdletBinding()]
    param(
        [Parameter(
        Position=0, 
        Mandatory=$true, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)
        ]
        [string]$Value
    )
    return [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Value))
}