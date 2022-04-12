# powershell profile
#
# features
#  - support ssh-agent for password protected keys using openssh on windows 10 / 11
#  - helper functions for efficient source code directory traversal
#  - theme for git requires oh-my-posh and font support see readme.md
#  - posh git extensions
#
# (c) ben davies

# environment
$promptTheme = 'paradox'                          # oh my posh theme choice
$codeDir = (Resolve-Path '~/src').Path            # your source code path, example is: "C:\Users\[your username]\src"
$env:path += ";$($env:SystemDrive)\local\bin"     # your approved custom local tools on the path here
$env:GIT_SSH = $((Get-Command -Name ssh).Source)  # use windows openssh ssh-agent

# custom commands
function autocompletepath {
  param (
    [String] $dir,
    [String] $word
  )
  return Get-ChildItem -Path $dir -Recurse -Depth 2 
  | Select-Object -ExpandProperty FullName
  | ForEach-Object { $_ -replace "$($dir -replace "\\", "\\")\\" } 
  | ForEach-Object { $_ -replace "\\", "/" }
  | Where-Object { $_ -like "${word}*" }
  | ForEach-Object { "$_/" }
}
  
function cdc {
  param (
    [String] $Folder
  )
  Set-Location "${codeDir}/${Folder}/"
}

Register-ArgumentCompleter -CommandName cdc -ParameterName Folder -ScriptBlock {
  param ($commandName, $parameterName, $wordToComplete)
  autocompletepath -dir $codeDir -word $wordToComplete
}
  
# custom shell prompts
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme $promptTheme
