Import-Module '.\module_legacy.psm1', '.\ItemsRepository.ps1'
$destination = -join ('U:', '\')
$date = (Get-Date).ToShortDateString() -replace ('/', '.')
$folderName = -join ('_backup', $date)

if (Test-Path -Path ( -join ($destination, $folderName)) ) { $backupFolder = -join ($destination, $folderName) }
else { $backupFolder = New-Item -Path $destination -Name $folderName -ItemType 'Directory' }

foreach ($item in $items) {
    $copyitem = Copy-CDItem -sourceLocation $ItemsRepository.$item.Location -item $item -itemFileName $ItemsRepository.$item.FileName -destination $backupFolder -verbose
    Write-CDOutputMessage -Object $copyitem -AskOnWarning
}