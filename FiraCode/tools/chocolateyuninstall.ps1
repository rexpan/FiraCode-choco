$ErrorActionPreference = 'Stop'

$FontFileNames = @(
    'FiraCode-Bold.ttf'
    'FiraCode-Light.ttf'
    'FiraCode-Medium.ttf'
    'FiraCode-Regular.ttf'
    'FiraCode-Retina.ttf'
    'FiraCode-SemiBold.ttf'
    'FiraCode-VF.ttf'
)

$Removed = Remove-Font $FontFileNames -Multiple

if ($Removed -eq 0) {
    Throw 'All font removal attempts failed!'
} elseif ($Removed -lt $FontFileNames.count) {
    Write-Host "$Removed fonts were uninstalled." -ForegroundColor Cyan
    Write-Warning "$($FontFileNames.count - $Removed) fonts in package failed to uninstall."
    Write-Warning 'They may have failed to install or may have been removed by other means.'
} else {
    Write-Host "$Removed fonts were uninstalled."
}
