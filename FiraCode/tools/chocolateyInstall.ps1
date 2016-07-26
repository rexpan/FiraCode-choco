$package = 'FiraCode'

$fontUrl = 'https://github.com/tonsky/FiraCode/releases/download/1.200/FiraCode_1.200.zip'
$destination = Join-Path $Env:Temp 'FiraCode'

Install-ChocolateyZipPackage -PackageNam $package -url $fontUrl -unzipLocation $destination

$shell = New-Object -ComObject Shell.Application
$fontsFolder = $shell.Namespace(0x14)

$fontFiles = Get-ChildItem $destination -Recurse -Filter *.otf

$fontFiles |
    ForEach-Object { $fontsFolder.CopyHere($_.FullName) }

Remove-Item $destination -Recurse
