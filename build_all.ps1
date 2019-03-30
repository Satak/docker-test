param(
    [string]$RootFolder = './services'
)
Import-Module powershell-yaml

$globalValuesContent = Get-Content -Path './kube/values.yaml' 
$globalValues = ConvertFrom-Yaml -Yaml $globalValuesContent
$globalValues.GetEnumerator() | ForEach-Object {Set-Variable -Name $_.Name -Value $_.Value}

$srvFolders = Get-ChildItem -Path $RootFolder -Directory

foreach($folder in $srvFolders) {
    Remove-Variable appName
    $dockerfilePath = Join-Path -Path $folder.FullName -ChildPath 'Dockerfile'
    if(Test-Path -Path $dockerfilePath -eq $false) {
        continue
    }
    $valuesPath = Join-Path -Path $folder.FullName -ChildPath '/kube/values.yaml'
    if(Test-Path $valuesPath -eq $false) {
        continue
    }
    $valuesContent = Get-Content -Path $valuesPath
    $values = ConvertFrom-Yaml -Yaml $valuesContent
    $values.GetEnumerator() | ForEach-Object {Set-Variable -Name $_.key -Value $_.Value}

    # docker
    if($appName) {
        $tag = "$($repository)/$($appName):$($version)"
        docker kill $appName
        docker rm $appName
        docker rmi $appName
        docker build -t $tag $Folder
        docker push $tag
    }

    # kubernetes

}
