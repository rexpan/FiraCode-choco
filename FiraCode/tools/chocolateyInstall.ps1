$ErrorActionPreference = 'Stop'

$fontUrl = 'https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip';
$checksumType = 'sha256';
$checksum = '521A72BE00DD22678D248E63F817C0C79C1B6F23A4FBD377EBA73D30CDCA5EFD';

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
