# This compiles a list of all users enabled and that have at least one SMTP proxy address already. 
$users = Get-ADUser -Filter * -Properties ProxyAddresses | Where-Object{($_.Enabled -eq "True") -and ($_.ProxyAddresses -ne $null)} 
# Change this domain to whatever the new Proxy Address will use. 
$domain = "corp.com" 
foreach ($user in $users) {
# Perform Concatenation of the username and the domain name
$concat = $user.SamAccountName+"@$domain" 
Set-ADUser $user -add @{ProxyAddresses="smtp:$concat" -split ","}} 
