$files = Get-ChildItem -Recurse -Filter *.yaml | Where-Object {$_.Directory.Name -eq 'kube'}

foreach($file in $files) {
    kubectl apply -f $file.FullName
}
