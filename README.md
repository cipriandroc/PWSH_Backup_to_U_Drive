# PWSH_Backup_to_U_Drive

This script is compatible with Powershell 2.0 as it's grabbing files from older Win7 machines

ItemsRepository.ps1 consists of a hash table of all the items being copied. Each item has it's properties such as filename and location.
You can add other items in there and the script will copy them

Script is split between PRESCript.ps1 and POSTSCript.ps1 . 
Since PRE needs to be supported by PWSH2.0, I decided to split it because the new machines have Windows 10 so I can use newer methods for other things I'm doing after migrating the files.
Create a shortcut that runs powershell as remotesgined and launches the script and leave it on a shared network drive for the fastest 

The PRE script will create a folder named Backup that includes the run date in the U:\ location
POST script assumes the folder is already there, with the current run date, uses the same hash to copy the listed files to their origin location
I added an extra check for the Chrome folder to create a folder in appdata in case it's missing, I've noticed there's no 'Default' folder if Chrome hasn't been launched yet.

The Write-CDOutputMessage function takes input of a variable that's supposed to be the result of the copy function and outputs a success or fail message
