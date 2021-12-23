# powershell profile
#
# features
#  - support ssh-agent for password protected keys using openssh on windows 10 / 11
#  - helper functions for efficient source code directory traversal
#  - powershell git extensions
#  - theme for git
#
# (c) ben davies

## source location
$codeDir = (Resolve-Path '~/src').Path

## approved custom local tools
$env:path += ';c:\local\bin'

# environment
# - fix: use windows openssh ssh-agent (req: openssh client component)
$env:GIT_SSH = $((Get-Command -Name ssh).Source)

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

# helper functions
function ConvertFrom-Base64 ([string] $EncodedText) {
  $DecodedText = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($EncodedText))
  write-output $DecodedText
}
  
# custom shell
## - enhanced git prompt
## - requires: om-my-posh v3 and the following imports
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox
