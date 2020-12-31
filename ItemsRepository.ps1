#code compatible with PWSH2

$ItemsRepository = @{
    'OutlookSignatures'     = @{
        'FileName' = 'Signatures';
        'Location' = "$env:APPDATA\microsoft"
    };
    'ChromeBookmarks'       = @{
        'FileName' = 'Bookmarks';
        'Location' = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"
    };
    'ChromeBookmarksBackup' = @{
        'FileName' = 'Bookmarks.bak';
        'Location' = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"
    };
    'IExploreBookmarks'     = @{
        'FileName' = 'Favorites';
        'Location' = "$env:USERPROFILE"
    }
}
$ItemsRepository = New-Object PSCustomObject -Property $ItemsRepository
$items = $ItemsRepository | Get-Member | Where-Object { $_.membertype -eq 'NoteProperty' } | Select-Object -ExpandProperty Name | Sort-Object -Descending