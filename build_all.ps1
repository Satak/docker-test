param(
    [string]$RootFolder = './services',
    [string]$Version = 'latest',
    [string]$DockerHubUser = 'satak'
)

$srvFolders = Get-ChildItem -Path $RootFolder -Directory

foreach($folder in $srvFolders) {
    $tag = "$($DockerHubUser)/$($folder.Name):$($Version)"
    docker kill $folder.Name
    docker rm $folder.Name
    docker rmi $folder.Name
    docker build -t $tag $Folder
    docker push $tag
}
