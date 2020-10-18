# ****************************************************
# D. Mohrmann, S&L Firmengruppe, Twitter: @mohrpheus78
# 10/18/2020 Initial release
# ****************************************************

<#
    .SYNOPSIS
        Shows a message to a user in the notification area, if FSLogix Office container is almost full
		
    .Description
        Gets information about the users FSLogix office container (size and remaining size) and calculates the free space in percent
		
    .EXAMPLE
	.FSLogix Office container Size Warning.ps1
	    
    .NOTES
	This script must be run on a machine where the user is currently logged on.
        Should be run as a powershell login script via GPO.
#>

# Wait 10 sec. till showing the message
Start-Sleep 10

# Get the relevant informations from the FSLogix profile
$FSLOContainerSize = Get-Volume -FileSystemLabel *O365-$ENV:USERNAME* | Where-Object { $_.DriveType -eq 'Fixed'}

# Calculate the free space in percent
$PercentFree = [Math]::round((($FSLOContainerSize.SizeRemaining/$FSLOContainerSize.size) * 100))

# If free space is less then 10 %, show message to user
IF ($PercentFree -le 10) {wlrmdr -s 20 -f 2 -t FSLogix Profile -m Attention! Your Office container contingent is almost exhausted, please inform the IT service!}
