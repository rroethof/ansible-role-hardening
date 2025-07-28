<#
.SYNOPSIS
    Renames and configures a new Ansible role from a template.
.DESCRIPTION
    This script prompts the user for details about the new role and then
    updates the necessary files by replacing placeholder values.
    It is the PowerShell equivalent of the rename.sh script.
#>

# Set location to the script's directory to ensure relative paths work correctly.
# This makes the script runnable from any working directory.
if ($PSScriptRoot) {
    Set-Location -Path $PSScriptRoot
}

# Prompt user for input
$YourName = Read-Host -Prompt "Your Name (e.g., John Doe)"
$YourEmail = Read-Host -Prompt "Your Email (e.g., john.doe@example.com)"
$Namespace = Read-Host -Prompt "Galaxy namespace (e.g., rroethof)"
$RoleName = Read-Host -Prompt "Galaxy role name (e.g., systemupdates)"
$Description = Read-Host -Prompt "Galaxy description (e.g., Ansible role to manage system updates)"

Write-Host ""
Write-Host "- Updating role information..."

# Define files for simple replacement of 'ansibletemplate'
$filesToUpdate = @(
    ".github/workflows/ci.yml",
    ".github/workflows/release.yml",
    "tasks/main.yml",
    "tests/test.yml",
    "vars/main.yml",
    "handlers/main.yml",
    "defaults/main.yml"
)

# Perform simple replacements
foreach ($file in $filesToUpdate) {
    if (Test-Path $file) {
        (Get-Content $file -Raw) -replace 'ansibletemplate', $RoleName | Set-Content $file
    }
    else {
        Write-Warning "File not found, skipping: $file"
    }
}

# Update meta/main.yml with multiple replacements
$metaPath = "meta/main.yml"
if (Test-Path $metaPath) {
    (Get-Content $metaPath -Raw) `
        -replace 'Ronny Roethof <ronny@roethof.net>', "$YourName <$YourEmail>" `
        -replace 'A template for creating new Ansible roles', $Description `
        -replace 'rroethof', $Namespace `
        -replace 'ansibletemplate', $RoleName `
        -replace 'template-ansible-role', "ansible-role-$RoleName" |
    Set-Content $metaPath
}
else {
    Write-Warning "File not found, skipping: $metaPath"
}

# Update README.md with multiple replacements
$readmePath = "README.md"
if (Test-Path $readmePath) {
    (Get-Content $readmePath -Raw) `
        -replace 'Template', "ansible-role-$RoleName" `
        -replace 'template-ansible-role', "ansible-role-$RoleName" `
        -replace 'ansibletemplate', $RoleName |
    Set-Content $readmePath
}
else {
    Write-Warning "File not found, skipping: $readmePath"
}

Write-Host ""
Write-Host "Note:"
Write-Host "This script does not replace specific information, so check the meta/main.yml and README.md for additional updates."
Write-Host "Done! Review the changes before committing."