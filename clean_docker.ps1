docker ps --format '{{json .ID}}' | ConvertFrom-Json | % {docker kill $_}
docker ps -a --format '{{json .ID}}' | ConvertFrom-Json | % {docker rm $_}
docker images --format '{{json .ID}}' | ConvertFrom-Json | % {docker rmi $_}
docker images --format '{{json .}}' | ConvertFrom-Json | Where-Object {$_.Tag -eq '<none>'} | % {docker rmi $_.ID}
