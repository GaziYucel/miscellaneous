# path

$sourceRoot = "B:\backup\ArchivedLogs\"

Write-Host "sourceRoot: "$sourceRoot
Write-Host ""

If(!(test-path -PathType container $sourceRoot)) {
    Write-Host $sourceRoot" not found. Exiting."
	exit
}

Read-Host -Prompt "Press any key to continue or CTRL + C to exit"

# Compress directories recursively

$directories = Get-ChildItem -Path $sourceRoot -Recurse -Directory  | where-object {$_.Attributes -notlike "*Compressed*"}

Foreach($directory in $directories) {
	compact /C $directory.FullName
	Write-Host $directory.name": compressed" 
}

# Compress sourceRoot

compact /C $sourceRoot

# Compress files recursively

$files = Get-ChildItem -Path $sourceRoot -Recurse  | where-object {$_.Attributes -notlike "*Compressed*"}

Foreach($file in $files) {
	compact /C $file.FullName
	Write-Host $file.name": compressed" 
}

Read-Host -Prompt "Press any key to continue"
