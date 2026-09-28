# Adds "Convert to .md binary" to the right-click menu of image files.
# Per-user install: no administrator rights needed.

$ErrorActionPreference = 'Stop'

$installDir = Join-Path $env:LOCALAPPDATA 'ImageToMD'
$script = Join-Path $installDir 'ConvertTo-MdImage.ps1'

New-Item -ItemType Directory -Force -Path $installDir | Out-Null
Copy-Item -Force -LiteralPath (Join-Path $PSScriptRoot 'src\ConvertTo-MdImage.ps1') -Destination $script

# conhost --headless runs PowerShell without flashing a console window.
$command = "conhost.exe --headless powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$script`" `"%1`""

# "image" covers every file Windows perceives as an image; SVG and WebP are
# not always in that group, so they are registered explicitly.
$targets = @('image', '.svg', '.webp', '.avif')

foreach ($target in $targets) {
    $key = "HKCU:\Software\Classes\SystemFileAssociations\$target\shell\ConvertToMdBinary"
    New-Item -Force -Path "$key\command" | Out-Null
    Set-ItemProperty -Path $key -Name '(default)' -Value 'Convert to .md binary'
    Set-ItemProperty -Path "$key\command" -Name '(default)' -Value $command
}

Write-Host "Installed. Right-click an image and choose 'Convert to .md binary'."
Write-Host "On Windows 11 it is under 'Show more options' (or Shift+Right-click)."
