<#
.SYNOPSIS
    This PowerShell script compresses directories and files within a specified source directory recursively.

.DESCRIPTION
    The script compresses directories and files within a specified source directory using the `compact` command. 
    It first compresses the sourceRoot if not compressed, then compresses directories recursively, and finally compresses 
    individual files within the source directory.

.PARAMETER $sourceRoot
    Specifies the root directory containing files and directories to be compressed.

.NOTES
    The script uses the `compact` command with the `/C` switch to compress files and directories.

.EXAMPLE
    .\CompressFiles.ps1 -sourceRoot "C:\backup\"
#>

$sourceRoot = "C:\backup\"

Write-Host "sourceRoot: "$sourceRoot
Write-Host ""

If(!(test-path -PathType container $sourceRoot)) {
    Write-Host $sourceRoot" not found. Exiting."
	exit
}

Read-Host -Prompt "Press any key to continue or CTRL + C to exit"

# SourceRoot

If(Get-Item -Path $sourceRoot |  where-object {$_.Attributes -notlike "*Compressed*"}){
	compact /C $sourceRoot
	Write-Host $sourceRoot": compressed"
}

# Directories

$directories = Get-ChildItem -Path $sourceRoot -Recurse -Directory  | where-object {$_.Attributes -notlike "*Compressed*"}

Foreach($directory in $directories) {
	compact /C $directory.FullName
	Write-Host $directory.name": compressed" 
}

# Files

$files = Get-ChildItem -Path $sourceRoot -Recurse  | where-object {$_.Attributes -notlike "*Compressed*"}

Foreach($file in $files) {
	compact /C $file.FullName
	Write-Host $file.name": compressed" 
}

Read-Host -Prompt "Press any key to continue"
