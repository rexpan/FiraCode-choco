$ErrorActionPreference = 'Stop'

$fontUrl = 'https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip';
$checksumType = 'sha256';
$checksum = '0949915BA8EB24D89FD93D10A7FF623F42830D7C5FFC3ECBF960E4ECAD3E3E79';

$destination = Join-Path $Env:Temp 'FiraCode'

Install-ChocolateyZipPackage -PackageName 'FiraCode' -url $fontUrl -unzipLocation $destination -ChecksumType "$checksumType" -Checksum "$checksum"

$FontFiles = Get-ChildItem $destination -Include '*.ttf' -Recurse |
                  Select-Object -ExpandProperty FullName

$Installed = Add-Font $FontFiles -Multiple

If ($Installed -eq 0) {
   Throw 'All font installation attempts failed!'
} elseif ($Installed -lt $FontFiles.count) {
   Write-Host "$Installed fonts were installed." -ForegroundColor Cyan
   Write-Warning "$($FontFiles.count - $Installed) submitted font paths failed to install."
} else {
   Write-Host "$Installed fonts were installed."
}

Remove-Item $destination -Recurse
