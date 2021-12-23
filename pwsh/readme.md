# Powershell readme

## Bootstrapping oh-my-posh

Update package management to use powershell gallery.

```powershell
powershell.exe -NoLogo -NoProfile -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery'
```

Install required modules for posh-git and oh-my-posh from the powershell gallery.

```powershell
Install-Module posh-git
Install-Module oh-my-posh
```

## Useful tips

- `refreshenv` - refreshes the working environment in powershell instead of having to reload the entire shell.

## Add Windows OpenSSH Capability

Add Microsoft openssh feature to Windows to enable better sshagent integration with PowerShell so that you can password protect the ssh keys. Requires path to ssh override as done in the profile.

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client
```
