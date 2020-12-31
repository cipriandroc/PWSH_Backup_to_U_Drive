Import-Module '.\module_legacy.psm1', '.\ItemsRepository.ps1'
$date = (Get-Date).ToShortDateString() -replace ('/', '.')
$folderName = -join ('_backup', $date)
$sourceLocation = -join ('U:', '\', $folderName)

#checks/creates Default folder in Chrome appdata location, required for Bookmarks
if (Test-Path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default") {}
else { mkdir "$env:LOCALAPPDATA\Google\Chrome\User Data\Default" | Out-Null }

if (-not (Test-Path $sourceLocation)) {
    Write-Warning "$sourceLocation not found!"
}
else {
    foreach ($item in $items) {
        $copyitem = Copy-CDItem -sourceLocation $sourceLocation -item $item -itemFileName $ItemsRepository.$item.FileName -destination $ItemsRepository.$item.Location -verbose
        Write-CDOutputMessage -Object $copyitem -AskOnWarning
    }
}