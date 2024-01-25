$dateBefore      = '31/01/2022' # DD/MM/YYYY !!!test first
$sourceRoot      = "C:\source\"
$destinationRoot = 'C:\destination\'

$date = $dateBefore -as [datetime]

Write-Host "sourceRoot     : "$sourceRoot
Write-Host "destinationRoot: "$destinationRoot
Write-Host "date           : "$date
Write-Host ""

Read-Host -Prompt "Press any key to continue or CTRL + C to exit"

If(!(test-path -PathType container $destinationRoot)) {
    New-Item -Path $destinationRoot -ItemType Directory
}

$files = Get-ChildItem -Path $sourceRoot -Recurse

Foreach($file in $files) {
    If($file.LastWriteTime -lt $date.date)
    {
        If(Test-Path -Path $file.fullname -PathType Leaf){
            $sourceFile = $file.fullname
            $destinationFile = $sourceFile.replace($sourceRoot, $destinationRoot);

            $destinationDirPath = $destinationFile.replace($file.name, '')
            
            If(!(test-path -PathType container $destinationDirPath)) {
                New-Item -Path $destinationDirPath -ItemType Directory
            }

            Move-Item -Path $sourceFile -Destination $destinationFile -Force
			
			Write-Host $file.name": "$sourceRoot" > "$destinationRoot
        }
    }
}

Read-Host -Prompt "Press any key to continue"
