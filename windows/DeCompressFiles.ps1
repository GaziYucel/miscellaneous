<#
.SYNOPSIS
    This PowerShell script decompresses directories and files within a specified source directory recursively.

.DESCRIPTION
    The script decompresses directories and files within a specified source directory using the `compact` command. 
    It first decompresses directories recursively, then the source directory itself, and finally decompresses 
    individual files within the source directory.

.PARAMETER $sourceRoot
    Specifies the root directory containing compressed files and directories to be decompressed.

.NOTES
    The script uses the `compact` command with the `/U` switch to decompress files and directories.

.EXAMPLE
    .\DecompressFiles.ps1 -sourceRoot "C:\backup\"
#>

$sourceRoot = "C:\backup\"

Write-Host "sourceRoot: "$sourceRoot
Write-Host ""

If(!(test-path -PathType container $sourceRoot)) {
    Write-Host $sourceRoot" not found. Exiting."
	exit
}

Read-Host -Prompt "Press any key to continue or CTRL + C to exit"

# Decompress directories recursively

$directories = Get-ChildItem -Path $sourceRoot -Recurse -Directory | where-object {$_.Attributes -like "*Compressed*"}

Foreach($directory in $directories) {
	compact /U $directory.FullName
	Write-Host $directory.name": decompressed" 
}

# Decompress sourceRoot

compact /U $sourceRoot

# Decompress files recursively

$files = Get-ChildItem -Path $sourceRoot -Recurse | where-object {$_.Attributes -like "*Compressed*"}

Foreach($file in $files) {
	compact /U $file.FullName
	Write-Host $file.name": decompressed" 
}

Read-Host -Prompt "Press any key to continue"
