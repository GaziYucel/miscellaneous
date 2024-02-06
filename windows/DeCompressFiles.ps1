# path

$sourceRoot = "B:\backup\ArchivedLogs\"

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
