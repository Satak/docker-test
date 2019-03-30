$template = Get-Content -Path ./kube/configMap.yaml -Raw
$name = 'Bob'
$version = 'latest'
$ExecutionContext.InvokeCommand.ExpandString($template) | kubectl apply -f -
