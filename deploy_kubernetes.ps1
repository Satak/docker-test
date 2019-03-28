$files = Get-ChildItem -Recurse -Filter *.yaml | Where-Object {$_.Directory.Name -eq 'kube'}

foreach($file in $files) {
    (Get-Content $file.FullName -Raw) -replace '{{appName}}', $file.Directory.Parent.Name | kubectl apply -f -
}
