# Removes the "Convert to .md binary" context menu entry.

$targets = @('image', '.svg', '.webp', '.avif')

foreach ($target in $targets) {
    $key = "HKCU:\Software\Classes\SystemFileAssociations\$target\shell\ConvertToMdBinary"
    if (Test-Path $key) {
        Remove-Item -Recurse -Force -Path $key
    }
}

$installDir = Join-Path $env:LOCALAPPDATA 'ImageToMD'
if (Test-Path $installDir) {
    Remove-Item -Recurse -Force -Path $installDir
}

Write-Host 'Uninstalled.'
