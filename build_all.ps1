param(
    [string]$RootFolder = './services'
)
Import-Module powershell-yaml

$globalValues = Get-Content -Path './kube/values.yaml' | ConvertFrom-Yaml
$srvFolders = Get-ChildItem -Path $RootFolder -Directory

foreach($folder in $srvFolders) {
    Write-Output $folder.name
    if($appName) {
        Remove-Variable appName
    }
    if($version) {
        Remove-Variable version
    }
    if($repository) {
        Remove-Variable repository
    }
    # set/reset global values for each folder iteration
    # list of hashtables
    $globalValues | ForEach-Object {$_.getEnumerator() | ForEach-Object {Set-Variable -Name $_.Name -Value $_.Value}}
    
    $dockerfilePath = Join-Path -Path $folder.FullName -ChildPath 'Dockerfile'
    $dockerFileFound = Test-Path -Path $dockerfilePath

    $valuesPath = Join-Path -Path $folder.FullName -ChildPath '/kube/values.yaml'
    if((Test-Path $valuesPath) -eq $false) {
        continue
    }
    $variableValues = Get-Content -Path $valuesPath | ConvertFrom-Yaml
    # list of hashtables
    $variableValues | ForEach-Object {$_.getEnumerator() | ForEach-Object {Set-Variable -Name $_.Name -Value $_.Value}}

    # docker, note that $repository, $appName and $version variables must be set before
    if($appName -and $version -and $repository -and $dockerFileFound) {
        Write-Output "Start building Docker image"
        $tag = "$($repository)/$($appName):$($version)"
        docker kill $appName
        docker rm $appName
        docker rmi $appName
        docker build -t $tag $Folder
        docker push $tag
    } elseif (!$dockerFileFound) {
        Write-Output "Skipping Docker actions for folder $($folder.name) since no Dockerfile found"
    } else {
        Write-Warning "Can't build Docker image. Not all variables are set. appName: $appName version: $version repository: $repository"
    }

    # kubernetes
    $kubernetesFolder = Join-Path -Path $folder.FullName -ChildPath '/kube'
    $kubernetesFiles = Get-ChildItem $kubernetesFolder -Filter *.yaml | Where-Object {$_.name.ToLower() -ne 'values.yaml'}
    foreach($file in $kubernetesFiles) {
        Write-Output "Applying Kubernetes for file $($file.name)"
        $template = Get-Content -Path $file.FullName -Raw
        $ExecutionContext.InvokeCommand.ExpandString($template) | kubectl apply -f -
    }

    # clear variables
    $variableValues | ForEach-Object {$_.getEnumerator() | ForEach-Object {Remove-Variable -Name $_.Name}}

}
