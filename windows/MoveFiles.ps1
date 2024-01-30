<#
.SYNOPSIS
    This PowerShell script moves files from a source directory to a 
    destination directory based on their last write time.

.DESCRIPTION
    The script takes a specified date and moves files from the source directory (and its subdirectories) 
    that were last modified before the specified date to the destination directory. It also creates 
    the necessary directory structure in the destination directory.

.PARAMETER $dateBefore
    Specifies the date before which files will be moved. Format: DD/MM/YYYY.

.PARAMETER $sourceRoot
    Specifies the root directory containing the source files to be moved.

.PARAMETER $destinationRoot
    Specifies the root directory where files will be moved.

.NOTES
    File moves are logged to the console, indicating the source and destination paths.

.EXAMPLE
    .\MoveFiles.ps1 -dateBefore '31/01/2022' -sourceRoot "C:\source\" -destinationRoot 'C:\destination\'
#>

$dateBefore      = '31/01/2022' # DD/MM/YYYY !!!test first
$sourceRoot      = "C:\source\"
$destinationRoot = 'C:\destination\'

$date = $dateBefore -as [datetime]

Write-Host "sourceRoot     : "$sourceRoot
Write-Host "destinationRoot: "$destinationRoot
Write-Host "date           : "$date
Write-Host ""

If(!(test-path -PathType container $sourceRoot)) {
    Write-Host $sourceRoot" not found. Exiting."
    Write-Host ""
	exit
}

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
