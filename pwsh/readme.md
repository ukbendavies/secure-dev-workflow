# Integrating OpenSSH with PowerShell

At the end of this section you will have installed all required features for working with Git and OpenSSH in PowerShell with password protected SSH Keys and no password re-prompts!

There are a couple of optional extras that also beautify the prompt (in a useful way) and extend the command line history capabilities (also a massively useful if you spend a lot of time in the shell).

This document is split into sections that act as a work flow from top to bottom. The required features are, well, required! Everything else is optional but comes highly recommended.

If you follow through from top to bottom then you will end up with everything in working order at the end.

## Adding PowerShell features

### Microsoft PowerShell Gallery

If you haven't already got PowerShell Package Management installed then you will need to run the following command to use Microsoft PowerShell gallery. Or one of many other methods, Chocolatey, WinGet, and so on.

Remember you will need an Administrative PowerShell for all installations.

```powershell
powershell.exe -NoLogo -NoProfile -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery'
```

### Note about Versions

The included PowerShell profile and all scripts have been tested and will all work correctly with the specified versions.

It is always advisable to move to latest release versions if available, however from time to time there have been breaking changes e.g. oh-my-posh changed the name of the theme commandlet recently.

### Required Features

The only required feature is posh-git as this enables better git support within PowerShell and we don't want to reinvent the wheel.

```powershell
Install-Module posh-git -RequiredVersion 0.7.3
```

### Optional Features

These features optionally improve working with PowerShell.

#### oh-my-posh

A prompt theme engine for any shell. This isn't essential, however you will gain information about the status of git and get generally useful visual cues on the prompt.

See [oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh) on github.

```powershell
Install-Module oh-my-posh -RequiredVersion 2.0.492
```

#### PSReadLine

PSReadLine is a recommended command line history management tooling.

If you use `ctrl-r` to back-reference previous commands then you will love PSReadLine.

PSReadLine takes history to a whole new level with Predictive IntelliSense in PowerShell.

I recommend reading [PSReadLine Introduction](https://devblogs.microsoft.com/powershell/announcing-psreadline-2-1-with-predictive-intellisense/).

```powershell
Install-Module PSReadLine -RequiredVersion 2.2.2
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

First tell Git to use the Windows OpenSSH Agent

```powershell
# *** DONT'T SKIP THIS!!! *** #
$env:GIT_SSH = $((Get-Command -Name ssh).Source)
# *** DONT'T SKIP THIS!!! *** #
```

Next add your private key to the agent key ring.

```powershell
ssh-add <path_to_your_private_ssh_key>
```

List set of managed identities, you should see the identity you just added.

```powershell
ssh-add -l
```

Once configured you can now issue git commands such as ```git pull``` without a password re-prompt!

### Customizing PowerShell $Profile

If you want these changes every time you start a new PowerShell session you can modify your `$Profile`.

You can either create your own or just take mine: copy the file or its contents: [Microsoft.PowerShell_profile.ps1](Microsoft.PowerShell_profile.ps1) into your `$profile`.

There are a couple of settings in the top section labeled `# environment`

```powershell
$promptTheme = 'paradox'                          # oh my posh theme choice
$codeDir = (Resolve-Path '~/src').Path            # your source code path, example is: "C:\Users\[your username]\src"
$env:path += ";$($env:SystemDrive)\local\bin"     # your approved custom local tools to include on the path here
$env:GIT_SSH = $((Get-Command -Name ssh).Source)  # use windows openssh ssh-agent
$predictionViewStyle = 'ListView'                 # InlineView might feel more natural at first!
$predictionSource = 'History'                     # All commands History
```

`$promptTheme` defaults to my choice `paradox` but there are plenty of oh-my-posh choices if you'd prefer something else just update this here.

`$codeDir` should be updated to your git source location. Or use my preferred path: `~/src` in your user profile. Just make a directory here if you don't have one and use this to house your source. This has the added benefit of encapsulation within your user space in Windows for added directory permissions.

`c:\local\bin` - I usually put any command line exe tools like system internals etc. here so that they are automatically on the path. If you don't want this just remove it.

`$env:GIT_SSH` - if you decide to get rid of everything else from your `$profile` ***just remember this essential line of code that instructs Git to use Windows OpenSSH and not any other version!***

`$predictionViewStyle` this is the history view mode. InlineView looks like a standard prompt with a ghosted closest match from history you can auto complete with right arrow key. The ListView shows a selection of closest matches and you can scroll through the list up/down arrow keys.

`$predictionSource` this is a sensible default that builds history as you type it. Other options enable a pre-determined set of options etc. best read the instructions.

## You made it

If you made it this far, well done, you now have a much more functional experience within PowerShell.
