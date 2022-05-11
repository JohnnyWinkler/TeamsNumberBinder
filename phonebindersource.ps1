# Change the folder directory to C:\Users\Username\Downloads
cd C:\Users\$env:username\Downloads\

# Create a new folder called "Input"
mkdir "Input"

# Wait 5 minutes until it continues with the script
timeout /t 300

# Connect to Microsoft Teams
Connect-MicrosoftTeams

# Bind the numbers
$contacts = Import-CSV .\importlist.csv
$contacts | ForEach {Set-CsUser $_.upn -Identity $_.upn -OnPremlineURI $_.phonenumber -EnterpriseVoiceEnabled $true -HostedVoicemail $true}
$contacts | ForEach {Grant-CsTeamsUpgradePolicy -Identity $_.upn -PolicyName UpgradeToTeams}

# Disconnect from Microsoft Teams
Disconnect-MicrosoftTeams

# Delete folder "Input" incl. content
Remove-Item C:\Users\$env:username\Downloads\Input -Recurse