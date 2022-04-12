# Integrating OpenSSH with PowerShell

## Bootstrapping oh-my-posh

Update package management to use PowerShell gallery.

```powershell
powershell.exe -NoLogo -NoProfile -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery'
```

Install required modules for posh-git and oh-my-posh from the PowerShell gallery.

```powershell
Install-Module posh-git
Install-Module oh-my-posh
```

## Configure Windows 10 / 11 ssh agent service

The following commands install the Microsoft OpenSSH variant for better Windows PowerShell integrations and bring the following benefits

1. Enables ssh-agent service at Windows startup for hassle free continuous use
1. Can add your ssh keys using ssh-add
1. Can *password protect the ssh private key files* without having to enter your password every time ssh makes a server side connection, e.g. when using Git via SSH!

### Add Windows OpenSSH Capability

Add Microsoft OpenSSH feature to Windows to enable better ssh-agent integration with PowerShell so that you can password protect the ssh keys. Requires path to ssh override as done in the profile.

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client
```

### Set the service to AutomaticDelayedStart

Once installed the ssh-agent service is disabled by default and you need to enable and start the service in order to work with the agent in the background.

```powershell
Get-Service -Name ssh-agent | Set-Service -StartupType AutomaticDelayedStart
```

### Add SSH Keys

Add ssh private keys and use password protected identities without having to enter your password for every server command git issues.

Note: you will be prompted for a password for the private key in order to add the identity.

```ssh-add <path_to_your_private_ssh_key>```

List the current managed identities using
```ssh-add -l```

Once configured you can now issue git commands such as ```git pull``` without a password re-prompt!
