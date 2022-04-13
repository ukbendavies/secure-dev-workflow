# powershell profile
#
# features
#  - support ssh-agent for password protected keys using openssh on windows 10 / 11
#  - helper functions for efficient source code directory traversal
#  - powershell git prompt and theme, oh-my-posh, required: 2.0.492+
#    and optionally unicode font support, see terminal/readme.md
#    oh-my-posh, required: 2.0.492+
#  - posh-git, required: 0.7.3+
#  - PSReadLine command line prediction and history management
#
# (c) ben davies

# environment
$promptTheme = 'paradox'                          # oh my posh theme choice
$SourcePath = (Resolve-Path '~/src').Path         # your source code path, example is: "C:\Users\[your username]\src"
$env:path += ";$($env:SystemDrive)\local\bin"     # your approved custom local tools to include on the path here
$env:GIT_SSH = $((Get-Command -Name ssh).Source)  # use windows openssh ssh-agent
$predictionViewStyle = 'ListView'                 # InlineView might feel more natural at first!
$predictionSource = 'History'                     # All commands History

# custom commands
function autocompletepath {
  param (
    [String] $Path,
    [String] $Pattern
  )
  return Get-ChildItem -Path $Path -Recurse -Depth 2 |
  Select-Object -ExpandProperty FullName |
  ForEach-Object { $_ -replace "$($Path -replace "\\", "\\")\\" } |
  ForEach-Object { $_ -replace "\\", "/" } |
  Where-Object { $_ -like "${Pattern}*" } |
  ForEach-Object { "$_/" }
}

function cdc {
  #.SYNOPSIS
  # Start typing to auto complete a directory in SourcePath when TAB is pressed.
  # Tab to rotate through the list or fully complete a discovered directory name.
  # Enter changes directory to the current selection.
  #.EXAMPLE
  #   cdc
  #   - changes to your preconfigured SourcePath
  #.EXAMPLE
  #   cdc github/*-dev
  #   - press TAB > autocomplete algorithm finds 'github/secure-dev-workflow'
  #.EXAMPLE
  #   cdc g*/*/pw*
  #   - press TAB > autocomplete algorithm finds 'github/secure-dev-workflow/pwsh'
  param (
    # Directory to autocomplete within SourcePath
    [String] $Folder
  )
  Set-Location "${SourcePath}/${Folder}/"
}

Register-ArgumentCompleter -CommandName cdc -ParameterName Folder -ScriptBlock {
  param ($CommandName, $ParameterName, $Pattern)
  autocompletepath -Path $SourcePath -Pattern $Pattern
}

# Enabled Features

## comment out or remove features you didn't want / haven't installed

### posh-git: git intergrations
Import-Module posh-git

### oh-my-posh: prompt themes
Import-Module oh-my-posh
Set-Theme $promptTheme

### psreadline: history based autocomplete
Set-PSReadLineOption -PredictionViewStyle $predictionViewStyle -PredictionSource $predictionSource
