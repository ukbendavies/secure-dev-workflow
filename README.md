# Improve dev workflow & security as part of defense in-depth

How I set up my development environment to improve my workflow and enhance security posture as part of a defense in depth strategy.

The core obectives are to protect the ssh private key file (often used without a password) and protect source code at rest. Should laptop(s) go awry or an attacker gain access to the file system and get the ssh-key files then you have the best possibility of avoiding further losses.

This whole process takes approximately 30 minutes.

## Environment

- Windows 10 / 11
- Powershell (6 / 7++ / core)
- Git, Oh-My-Posh, Posh-Git and SSH

## What can I get from this?

- Improved security posture within your development workflow
- Improved ease of use for git and ssh when using password protected ssh-key files
- New tooling that works with the workflow to enhance productivity

### Security Enhancements

- Git and ssh workflows that make use of ssh private key file password security (be sure to set a strong unique password)
- Utilize Windows 10 / 11 ssh-agent components for native integration with powershell when using git with ssh (and ssh natively)
- Improve security on shared systems (e.g. virtual desktops) by working with source code in your profile (when used with disk encryption)

### Style and Usability Enhancements

- Windows Terminal enhancements with oh-my-posh
- Uses integrated Windows OpenSSH Agent so you _can work natively in Powershell_
- Enhanced PowerShell font readability with unicode support for a graphical prompt to show git context information
- Source code directory consistency and new functions to support this flow: e.g. ```cdc <tab-complete to change to the source directory>```

## Getting Started

1. Configure Microsoft Terminal for enhanced readability using unicode fonts and usage with Git workflows

    Read [Enhance Windows Terminal](/terminal/readme.md)
    
1. Add Windows OpenSSH capability to better integrate with PowerShell

   Read [Integrating OpenSSH with Powershell](/pwsh/readme.md)

1. Create the following directory to contain your source code securely in your profile. Be sure to enable disk encryption (or at least file system directory encryption for this directory) and if roaming profiles are used within your organisation understand whether your user profile is right for your security posture.

   ```text
    ~\src - path to source code in your user profile
   ```

### Creating SSH Keys with Passwords

GitHub has an article here to walk you through [setting up ssh keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

- Be sure to set a password (passphrase) for your ssh keys!
- You can add new ssh keys here: GitHub -> Profile -> Settings > [ssh keys](https://github.com/settings/keys))
- Remember to clone with ssh as part of this new workflow.
  
You are now ready to use git with password protected ssh private keys.
    
*Secure, Sync, Code, Enjoy!*
