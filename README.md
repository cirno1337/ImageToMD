# ImageToMD

A Windows 11 right-click menu add-on: right-click an image, choose
**Convert to .md binary**, and a ready-to-paste Markdown image is copied to
your clipboard:

```markdown
![photo](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA...)
```

The image data is embedded directly in the text, so the `.md` file needs no
separate image file — paste it and the image shows up in the preview.

## Install

1. Download or clone this repository.
2. Open PowerShell in the folder and run:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\install.ps1
   ```

No administrator rights are needed; it installs for your user only.

## Use

Right-click any image (PNG, JPG, GIF, BMP, WebP, SVG, ICO, TIFF, AVIF) →
**Show more options** → **Convert to .md binary**, then paste into your
`.md` file.

> Windows 11 hides classic menu entries under **Show more options**.
> **Shift + Right-click** opens that full menu directly.

## Uninstall

```powershell
powershell -ExecutionPolicy Bypass -File .\uninstall.ps1
```

## Notes

- Works in VS Code, Obsidian, Typora and most Markdown previewers.
  **GitHub does not render `data:` images**, so for README files on GitHub
  use a regular image file instead.
- Base64 makes the text about 33% larger than the image, so large photos
  produce very long lines. Screenshots and small images work best.
- If several images are selected, only the last one processed ends up on the
  clipboard.
