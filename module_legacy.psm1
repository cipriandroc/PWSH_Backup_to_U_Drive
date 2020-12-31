function Write-CDOutputMessage {
	Param(
		[Parameter(Mandatory = $true)]
		[psobject]$Object,
		[switch]$AskOnWarning
	)
    
	if ($Object.CompleteCode -eq '0') { Write-Host $object.message -ForegroundColor White -BackgroundColor DarkGreen }
	elseif ($Object.CompleteCode -eq '1') {
		Write-Warning $Object.message
		if (-not $AskOnWarning) { exit }
		if ($AskOnWarning) {
			while ($confirmation -ne 'yes' -or 'no') {
				Write-Host "Do you want to continue? (yes/no)" -ForegroundColor Yellow -BackgroundColor Black
				$confirmation = Read-Host
			
				if ($confirmation -eq 'yes') {
					Write-Host "[Continuing Script]"
					return
				}
				elseif ($confirmation -eq 'no') {
					Write-Warning "[Stopping Script]"
					exit
				}
			}
		}
	}
}
function Copy-CDItem {
    [CmdletBinding()]
    Param(
        $sourceLocation,
        $item,
        $itemFileName,
        $destination
    )

    $outputProps = @{
        "Message"      = $null;
        "CompleteCode" = '1'
    }

    if (Test-Path ( -join ($sourceLocation, '\', $itemFileName))) {
        Write-Verbose -Message "Found [ $item ], copying to [ $destination ]" 
        $copy = Copy-Item -Path ( -join ($sourceLocation, '\', $itemFileName)) -Destination $destination -Recurse -PassThru -Force
        if ($copy) {
            $outputProps.Message = "Succesffully copied $item"
            $outputProps.CompleteCode = 0
            return New-Object psobject -Property $outputProps
        }
        else { 
            $outputProps.Message = "Could not copy $item, check manually"
            return New-Object psobject -Property $outputProps
        } 
    }
    else {
        $outputProps.Message = "Could not find $item, check manually"
        return New-Object psobject -Property $outputProps
    }
}