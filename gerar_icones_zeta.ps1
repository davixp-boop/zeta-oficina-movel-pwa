Add-Type -AssemblyName System.Drawing

$sourcePath = ".\assets\assets\images\logo_zetaloc.png"

if (-not (Test-Path $sourcePath)) {
    throw "Logo da Zetaloc não encontrado em: $sourcePath"
}

function New-ZetaIcon {
    param(
        [int]$Size,
        [string]$OutputPath
    )

    $source = [System.Drawing.Image]::FromFile($sourcePath)
    $bitmap = New-Object System.Drawing.Bitmap($Size, $Size)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)

    $graphics.Clear([System.Drawing.Color]::White)
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    $maxWidth = $Size * 0.82
    $maxHeight = $Size * 0.82

    $scaleX = $maxWidth / $source.Width
    $scaleY = $maxHeight / $source.Height
    $scale = [Math]::Min($scaleX, $scaleY)

    $newWidth = [int]($source.Width * $scale)
    $newHeight = [int]($source.Height * $scale)

    $x = [int](($Size - $newWidth) / 2)
    $y = [int](($Size - $newHeight) / 2)

    $graphics.DrawImage($source, $x, $y, $newWidth, $newHeight)

    $bitmap.Save(
        $OutputPath,
        [System.Drawing.Imaging.ImageFormat]::Png
    )

    $graphics.Dispose()
    $bitmap.Dispose()
    $source.Dispose()

    Write-Host "Criado: $OutputPath"
}

New-ZetaIcon -Size 180 -OutputPath ".\apple-touch-icon-v2.png"
New-ZetaIcon -Size 192 -OutputPath ".\icons\Icon-192-v2.png"
New-ZetaIcon -Size 512 -OutputPath ".\icons\Icon-512-v2.png"
New-ZetaIcon -Size 192 -OutputPath ".\icons\Icon-maskable-192-v2.png"
New-ZetaIcon -Size 512 -OutputPath ".\icons\Icon-maskable-512-v2.png"
New-ZetaIcon -Size 64 -OutputPath ".\favicon-v2.png"
