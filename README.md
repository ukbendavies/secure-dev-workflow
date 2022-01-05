# Improving my development environment workflow and security

How I set up my development environment to improve development workflow and enhance security posture as part of a defense in depth strategy. The idea is to protect both the ssh-key files (often used without passwords) and protect your source code at rest. Should your laptop go awry or an attacker gain access to your ssh-key files then you have the best possibility of avoiding further losses.

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
- Utilize Windows 10 / 11 ssh-agent components for identity integration within powershell when using git with ssh (and with ssh itself)
- Improve security on shared systems (e.g. virtual desktops) by working with source code in your profile

### Style and usability enhancements

- Windows Terminal enhancements with oh-my-posh
- Uses integrated Windows OpenSSH Agent so you _can work natively in Powershell_
- Enhanced PowerShell font readability with unicode support for graphical git prompts to support git context information
- Source code directory consistency and new functions to support this flow: e.g. cdc <tab-complete to change to the source directory>

## Getting started

1. Install and configure Microsoft Terminal

    Read terminal [readme](/terminal/readme.md)
1. Add Windows OpenSSH capability to better integrate with PowerShell

   Read pwsh [readme](/pwsh/readme.md)

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
