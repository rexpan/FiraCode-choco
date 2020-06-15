function Get-CurrentDirectory
{
  $thisName = $MyInvocation.MyCommand.Name
  [IO.Path]::GetDirectoryName((Get-Content function:$thisName).File)
}

$fontHelpersPath = (Join-Path (Get-CurrentDirectory) 'FontHelpers.ps1')
. $fontHelpersPath

$fontUrl = 'https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip';
$checksumType = 'sha256';
$checksum = '521A72BE00DD22678D248E63F817C0C79C1B6F23A4FBD377EBA73D30CDCA5EFD';

$destination = Join-Path $Env:Temp 'FiraCode'

Install-ChocolateyZipPackage -PackageName 'FiraCode' -url $fontUrl -unzipLocation $destination -ChecksumType "$checksumType" -Checksum "$checksum"

$shell = New-Object -ComObject Shell.Application
$fontsFolder = $shell.Namespace(0x14)

$fontFiles = Get-ChildItem $destination -Recurse -Filter *.ttf

# unfortunately the font install process totally ignores shell flags :(
# http://social.technet.microsoft.com/Forums/en-IE/winserverpowershell/thread/fcc98ba5-6ce4-466b-a927-bb2cc3851b59
# so resort to a nasty hack of compiling some C#, and running as admin instead of just using CopyHere(file, options)
$commands = $fontFiles |
% { Join-Path $fontsFolder.Self.Path $_.Name } |
? { Test-Path $_ } |
% { "Remove-SingleFont '$_' -Force;" }

# http://blogs.technet.com/b/deploymentguys/archive/2010/12/04/adding-and-removing-fonts-with-windows-powershell.aspx
$fontFiles |
% { $commands += "Add-SingleFont '$($_.FullName)';" }

$toExecute = ". $fontHelpersPath;" + ($commands -join ';')
Start-ChocolateyProcessAsAdmin $toExecute

Remove-Item $destination -Recurse
