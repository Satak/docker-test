$appName = 'samiapp'
$internalPort = 8080
$externalPort = 80

docker kill $appName
docker rm $appName
docker rmi $appName
docker build -t "$($appName):latest" .
docker run -it -d --name $appName -p "$($externalPort):$($internalPort)" $appName
