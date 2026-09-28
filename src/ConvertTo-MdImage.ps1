# Converts an image file into a Markdown image with the data embedded as a
# base64 data URI, and copies the result to the clipboard.
param(
    [Parameter(Mandatory = $true)]
    [string]$Path
)

$ErrorActionPreference = 'Stop'

$mimeTypes = @{
    '.png'  = 'image/png'
    '.jpg'  = 'image/jpeg'
    '.jpeg' = 'image/jpeg'
    '.jfif' = 'image/jpeg'
    '.gif'  = 'image/gif'
    '.bmp'  = 'image/bmp'
    '.webp' = 'image/webp'
    '.svg'  = 'image/svg+xml'
    '.ico'  = 'image/x-icon'
    '.tif'  = 'image/tiff'
    '.tiff' = 'image/tiff'
    '.avif' = 'image/avif'
}

try {
    $file = Get-Item -LiteralPath $Path
    $mime = $mimeTypes[$file.Extension.ToLowerInvariant()]
    if (-not $mime) {
        throw "Unsupported file type: $($file.Extension)"
    }

    $base64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($file.FullName))
    # Brackets would break the Markdown alt text.
    $alt = $file.BaseName -replace '[\[\]]', ''

    Set-Clipboard -Value "![$alt](data:$mime;base64,$base64)"
}
catch {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show(
        "Could not convert image:`n$($_.Exception.Message)",
        'Convert to .md binary',
        'OK',
        'Error'
    ) | Out-Null
    exit 1
}
