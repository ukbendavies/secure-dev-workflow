# Improving my development environment workflow and security

My personal development environment configuration that improves development workflow and enhances security as part of a defense in depth strategy.

Environment

- Windows 10 / 11
- Powershell (6 / 7++ / core)
- Git, Oh-My-Posh, Posh-Git and SSH

What can I get from this?

- Improved security posture within your development workflow
- Improved ease of use for git and ssh when using passwords
- Tooling that works with the workflow to enhance productivity

Security Enhancements

- Improved git and ssh workflows that make use of ssh private key file password security (be sure to set a strong unique password)
- Utilize Windows 10 / 11 ssh-agent components for identity integration within powershell when using git with ssh (and with ssh itself)
- Improve security on shared systems by working with code in your profile and adding some tooling to better support this workflow

Style and usability enhancements

- Windows Terminal enhancements with oh-my-posh
- Enhanced PowerShell font readability with unicode support for graphical git prompts to support git context information

## Getting started

1. Install and configure Microsoft Terminal

    Read terminal [readme](/terminal/readme.md)
1. Add Windows OpenSSH capability to better integrate with PowerShell

   Read pwsh [readme](/pwsh/readme.md)

1. Create the following directory to contain your source code securely in your profile. Be sure to enable disk encryption (or at least file system directory encryption for this directory) and if roaming profiles are used within your organisation understand whether your user profile is right for your security posture.

   ```text
    ~\src - path to source code in your user profile
   ```

*Secure, Sync, Code, Enjoy!*
