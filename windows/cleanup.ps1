$dateBefore      = '31/12/2022' # DD/MM/YYYY !!!test first
$sourceRoot      = "B:\backup\ArchivedLogs\ctrl-app-cntrl\Script\"
$destinationRoot = 'B:\backup\ArchivedLogs\ctrl-app-cntrl\Script_moved\'

$date = $dateBefore -as [datetime]

Write-Host "sourceRoot: "$sourceRoot
Write-Host "destinationRoot: "$destinationRoot
Write-Host $date
Write-Host ""

Read-Host -Prompt "Press any key to continue or CTRL + C to exit"

If(!(test-path -PathType container $destinationRoot)) {
    New-Item -Path $destinationRoot -ItemType Directory
}

Foreach($file in (Get-ChildItem -Path $sourceRoot -Recurse)) {
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
			
			Write-Host $sourceFile" > "$destinationFile
        }
    }
}

Read-Host -Prompt "Press any key to continue"
