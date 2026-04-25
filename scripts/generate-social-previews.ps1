$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$outputRoot = Join-Path $root "public\social"

Add-Type -AssemblyName System.Drawing

function New-RoundedPath {
    param(
        [float]$X,
        [float]$Y,
        [float]$Width,
        [float]$Height,
        [float]$Radius
    )

    $diameter = $Radius * 2
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddArc($X, $Y, $diameter, $diameter, 180, 90)
    $path.AddArc($X + $Width - $diameter, $Y, $diameter, $diameter, 270, 90)
    $path.AddArc($X + $Width - $diameter, $Y + $Height - $diameter, $diameter, $diameter, 0, 90)
    $path.AddArc($X, $Y + $Height - $diameter, $diameter, $diameter, 90, 90)
    $path.CloseFigure()
    return $path
}

function New-CardImage {
    param(
        [string]$OutputPath,
        [string]$Eyebrow,
        [string]$Title,
        [string]$Description,
        [string]$PanelLabel
    )

    $width = 1200
    $height = 630
    $bitmap = New-Object System.Drawing.Bitmap $width, $height
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    $background = New-Object System.Drawing.Rectangle 0, 0, $width, $height
    $gradient = New-Object System.Drawing.Drawing2D.LinearGradientBrush (
        $background,
        [System.Drawing.Color]::FromArgb(247, 251, 255),
        [System.Drawing.Color]::FromArgb(231, 239, 255),
        90
    )
    $graphics.FillRectangle($gradient, $background)

    $cardBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(250, 255, 255, 255))
    $borderPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(36, 52, 86, 143), 2)
    $accentBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(15, 139, 141))
    $inkBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(22, 35, 59))
    $mutedBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(93, 109, 137))
    $whiteBrush = [System.Drawing.Brushes]::White

    $cardRect = New-Object System.Drawing.RectangleF 50, 48, 1100, 534
    $cardPath = New-RoundedPath $cardRect.X $cardRect.Y $cardRect.Width $cardRect.Height 28
    $graphics.FillPath($cardBrush, $cardPath)
    $graphics.DrawPath($borderPen, $cardPath)

    $logoRect = New-Object System.Drawing.RectangleF 88, 86, 74, 74
    $logoGradient = New-Object System.Drawing.Drawing2D.LinearGradientBrush (
        ([System.Drawing.Rectangle]::Round($logoRect)),
        [System.Drawing.Color]::FromArgb(15, 139, 141),
        [System.Drawing.Color]::FromArgb(255, 122, 89),
        35
    )
    $logoPath = New-RoundedPath $logoRect.X $logoRect.Y $logoRect.Width $logoRect.Height 18
    $graphics.FillPath($logoGradient, $logoPath)

    $logoFont = New-Object System.Drawing.Font("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
    $brandFont = New-Object System.Drawing.Font("Georgia", 28, [System.Drawing.FontStyle]::Bold)
    $eyebrowFont = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
    $titleFont = New-Object System.Drawing.Font("Georgia", 40, [System.Drawing.FontStyle]::Bold)
    $copyFont = New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Regular)
    $panelTitleFont = New-Object System.Drawing.Font("Georgia", 32, [System.Drawing.FontStyle]::Bold)
    $pillFont = New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)

    $graphics.DrawString("GT", $logoFont, $whiteBrush, 103, 101)
    $graphics.DrawString("Grade Toolkit", $brandFont, $inkBrush, 184, 98)
    $graphics.DrawString($Eyebrow.ToUpperInvariant(), $eyebrowFont, $accentBrush, 92, 207)

    $titleRect = New-Object System.Drawing.RectangleF 90, 246, 560, 188
    $titleFormat = New-Object System.Drawing.StringFormat
    $titleFormat.Trimming = [System.Drawing.StringTrimming]::EllipsisWord
    $graphics.DrawString($Title, $titleFont, $inkBrush, $titleRect, $titleFormat)

    $copyRect = New-Object System.Drawing.RectangleF 90, 456, 560, 82
    $copyFormat = New-Object System.Drawing.StringFormat
    $copyFormat.Trimming = [System.Drawing.StringTrimming]::EllipsisWord
    $graphics.DrawString($Description, $copyFont, $mutedBrush, $copyRect, $copyFormat)

    $panelRect = New-Object System.Drawing.RectangleF 720, 182, 360, 270
    $panelBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(242, 248, 255))
    $panelPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(46, 15, 139, 141), 2)
    $panelPath = New-RoundedPath $panelRect.X $panelRect.Y $panelRect.Width $panelRect.Height 26
    $graphics.FillPath($panelBrush, $panelPath)
    $graphics.DrawPath($panelPen, $panelPath)

    $graphics.DrawString("Built for students", $eyebrowFont, $accentBrush, 754, 218)
    $graphics.DrawString($PanelLabel, $panelTitleFont, $inkBrush, 752, 258)
    $graphics.DrawString("Clear grade answers", $copyFont, $mutedBrush, 754, 324)
    $graphics.DrawString("Plan finals and GPA", $copyFont, $mutedBrush, 754, 362)
    $graphics.DrawString("Use the right calculator fast", $copyFont, $mutedBrush, 754, 400)

    $pillRect = New-Object System.Drawing.RectangleF 722, 494, 238, 44
    $pillBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(18, 15, 139, 141))
    $pillPath = New-RoundedPath $pillRect.X $pillRect.Y $pillRect.Width $pillRect.Height 20
    $graphics.FillPath($pillBrush, $pillPath)
    $graphics.DrawString("gradetoolkit.com", $pillFont, $whiteBrush, 760, 506)

    [System.IO.Directory]::CreateDirectory((Split-Path -Parent $OutputPath)) | Out-Null
    $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)

    $graphics.Dispose()
    $bitmap.Dispose()
    $cardPath.Dispose()
    $logoPath.Dispose()
    $panelPath.Dispose()
    $pillPath.Dispose()
    $gradient.Dispose()
    $cardBrush.Dispose()
    $borderPen.Dispose()
    $accentBrush.Dispose()
    $inkBrush.Dispose()
    $mutedBrush.Dispose()
    $logoGradient.Dispose()
    $panelBrush.Dispose()
    $panelPen.Dispose()
    $pillBrush.Dispose()
    $logoFont.Dispose()
    $brandFont.Dispose()
    $eyebrowFont.Dispose()
    $titleFont.Dispose()
    $copyFont.Dispose()
    $panelTitleFont.Dispose()
    $pillFont.Dispose()
}

$entries = @(
    @{ Output = "home.png"; Eyebrow = "Grade calculators and study guides"; Title = "Grade, GPA, finals, weighted grades, and passing targets."; Description = "Free student-friendly tools and plain-English guides to help you understand your grades fast."; PanelLabel = "Fast and clear" },
    @{ Output = "tools/grade-calculator.png"; Eyebrow = "Student calculator"; Title = "Grade Calculator"; Description = "Calculate your class average from assignment scores and total points possible."; PanelLabel = "Check your grade" },
    @{ Output = "tools/final-exam-calculator.png"; Eyebrow = "Student calculator"; Title = "Final Exam Calculator"; Description = "Find the score you need on your final exam to hit your target grade."; PanelLabel = "Plan your final" },
    @{ Output = "tools/weighted-grade-calculator.png"; Eyebrow = "Student calculator"; Title = "Weighted Grade Calculator"; Description = "Use category weights like homework, quizzes, and tests to find your class average."; PanelLabel = "Use weighted grades" },
    @{ Output = "tools/gpa-calculator.png"; Eyebrow = "Student calculator"; Title = "GPA Calculator"; Description = "Estimate unweighted and weighted GPA with credits, plus-minus grades, honors, and AP."; PanelLabel = "Track your GPA" },
    @{ Output = "tools/what-grade-do-i-need-calculator.png"; Eyebrow = "Student calculator"; Title = "What Grade Do I Need Calculator"; Description = "Work backward from your target grade to see the average you need on remaining coursework."; PanelLabel = "Set your target" },
    @{ Output = "guides/how-to-calculate-your-grade.png"; Eyebrow = "Student guide"; Title = "How to Calculate Your Grade"; Description = "Learn the basic formulas for simple averages, weighted grades, finals, and GPA."; PanelLabel = "Learn the math" },
    @{ Output = "guides/what-grade-do-i-need-to-pass-a-class.png"; Eyebrow = "Student guide"; Title = "What Grade Do I Need to Pass a Class?"; Description = "See how to estimate the score you need to pass before the term ends."; PanelLabel = "Plan to pass" },
    @{ Output = "guides/how-finals-affect-your-grade.png"; Eyebrow = "Student guide"; Title = "How Finals Affect Your Grade"; Description = "Understand how final exam weight changes your overall class average."; PanelLabel = "See the impact" },
    @{ Output = "guides/what-is-a-good-gpa.png"; Eyebrow = "Student guide"; Title = "What Is a Good GPA?"; Description = "Compare GPA ranges and see what different numbers usually mean."; PanelLabel = "Understand GPA" },
    @{ Output = "guides/is-a-70-a-passing-grade.png"; Eyebrow = "Student guide"; Title = "Is a 70 a Passing Grade?"; Description = "Learn what a 70 percent usually means and how to raise it."; PanelLabel = "Know where you stand" },
    @{ Output = "guides/do-colleges-look-at-weighted-or-unweighted-gpa.png"; Eyebrow = "Student guide"; Title = "Weighted or Unweighted GPA?"; Description = "Learn how colleges usually read GPA and course rigor together."; PanelLabel = "Prep for admissions" }
)

foreach ($entry in $entries) {
    New-CardImage `
        -OutputPath (Join-Path $outputRoot $entry.Output) `
        -Eyebrow $entry.Eyebrow `
        -Title $entry.Title `
        -Description $entry.Description `
        -PanelLabel $entry.PanelLabel
}
