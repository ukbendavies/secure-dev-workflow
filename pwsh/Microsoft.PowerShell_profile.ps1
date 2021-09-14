# powershell profile
#
# features
#  - support ssh-agent using openssh on windows 10
#  - powershell git extensions
#  - theme for git
#
# (c) ben davies

# use openssh on windows 10 (requires openssh optional component)
$Env:GIT_SSH=$((Get-Command -Name ssh).Source)

# extension to enhnce the prompt for git
# Requires: om-my-posh v3 and the following imports
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox
