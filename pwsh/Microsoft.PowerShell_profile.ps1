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

$env:GIT_SSH = $((Get-Command -Name ssh).Source)  # use windows openssh ssh-agent
$codeDir = (Resolve-Path '~/src').Path            # source code location 
$env:path += ';c:\local\bin'                      # approved custom local tools
$OhMyPoshTheme = 'paradox'                        # theme choice

# custom commands
function autocompletepath {
  param (
    [String] $dir,
    [String] $word
  )
  return Get-ChildItem -Path $dir -Recurse -Depth 2 
  | Select-Object  -ExpandProperty FullName
  | ForEach-Object { $_ -replace "$($dir -replace "\\", "\\")\\" } 
  | ForEach-Object { $_ -replace "\\", "/" }
  | Where-Object { $_ -like "${word}*" }
  | ForEach-Object { "$_/" }
}
  
function cdcode {
  param (
    [String] $Folder
  )
  Set-Location "${codeDir}/${Folder}/"
  code .
}
Register-ArgumentCompleter -CommandName cdc -ParameterName Folder -ScriptBlock {
  param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
  autocompletepath -dir $codeDir -word $wordToComplete
}
  
function cdc {
  param (
    [String] $Folder
  )
  Set-Location "${codeDir}/${Folder}/"
}
Register-ArgumentCompleter -CommandName cdc -ParameterName Folder -ScriptBlock {
  param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
  autocompletepath -dir $codeDir -word $wordToComplete
}
  
function cdg {
  param (
    [String] $Folder
  )
  Set-Location "${goDir}/${Folder}/"
}
Register-ArgumentCompleter -CommandName cdg -ParameterName Folder -ScriptBlock {
  param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
  autocompletepath -dir "$Env:GOPATH/src/" -word $wordToComplete
}
  
# custom shell prompts
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme $OhMyPoshTheme
