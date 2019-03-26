param(
    [string]$DeploymentName = 'samiapp',
    [int]$Replicas = 1,
    [switch]$JustScale
)
if(!$JustScale) {
    kubectl scale deployment $DeploymentName --replicas=0
}
kubectl scale deployment $DeploymentName --replicas=$Replicas
kubectl get pods