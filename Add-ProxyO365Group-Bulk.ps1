# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName Admin@DOMAIN -ShowProgress $true

# Define the additional domain alias you want to add
$additionalDomainAlias = "domain.com"

# Get all distribution lists, Office 365 groups, and security groups
$groups = Get-UnifiedGroup -ResultSize Unlimited

# Iterate through each group and add the additional alias
foreach ($group in $groups) {
    $groupDisplayName = $group.DisplayName
    $groupPrimarySmtp = $group.PrimarySmtpAddress

    $newAlias = $group.Alias + "@$additionalDomainAlias"
    $group.EmailAddresses += $newAlias
        Set-UnifiedGroup -Identity $groupPrimarySmtp -EmailAddresses $group.EmailAddresses
        Write-Host "Added $newAlias to $groupDisplayName" -ForegroundColor Green    
}

# Disconnect from Exchange Online session
Disconnect-ExchangeOnline -Confirm:$false
