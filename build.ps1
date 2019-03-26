param(
    [switch]$Push,
    [switch]$Run,
    [string]$Version = 'latest',
    [string]$AppName = 'samiapp',
    [string]$DockerHubUser = 'satak',
    [string]$Folder = '.'
)

$tag = "$($DockerHubUser)/$($AppName):$($Version)"
$internalPort = 8080
$externalPort = 80

docker kill $AppName
docker rm $AppName
docker rmi $AppName
docker build -t $tag $Folder

if($Push) {
    docker push $tag
}

if($Run) {
    docker run -it -d --name $appName -p "$($externalPort):$($internalPort)" $tag
}
