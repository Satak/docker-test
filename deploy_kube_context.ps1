Import-Module powershell-yaml

$files = Get-ChildItem -Recurse -Filter *.yaml | Where-Object {$_.Directory.Name -eq 'kube' -and $_.name.ToLower() -ne 'values.yaml'}

foreach($file in $files) {
    $values = $null
    $template = Get-Content -Path $file.FullName -Raw
    $valuesPath = Join-Path -Path $file.Directory -ChildPath 'values.yaml'
    if(Test-Path $valuesPath) {
        $valuesContent = Get-Content -Path $valuesPath -ErrorAction SilentlyContinue
        $values = ConvertFrom-Yaml -Yaml $valuesContent
        $values.GetEnumerator() | ForEach-Object {Set-Variable -Name $_.key -Value $_.Value}
    }

    # $ExecutionContext.InvokeCommand.ExpandString($template)
    # | kubectl apply -f -
}
