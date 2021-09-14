# powershell profile
#
# features
#  - powershell git extensions
#  - theme for git
#
# (c) ben davies

# extension to enhnce the prompt for git
# Requires: om-my-posh v3 and the following imports
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox
