# PS > $PSVersionTable

Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PsReadlineOption -BellStyle None

# PS > [Enum]::GetValues([ConsoleColor])
if (Get-Module -ListAvailable -Name "PSReadline") {
  $options = Get-PSReadlineOption

  $options.CommandColor = 'Yellow'
  $options.CommentColor = 'DarkGray'
  $options.ContinuationPromptColor = 'Cyan'
  $options.DefaultTokenColor = 'Cyan'
  $options.EmphasisColor = 'Magenta'
  $options.ErrorColor = 'Red'
  $options.KeywordColor = 'Green'
  $options.MemberColor = 'Green'
  $options.NumberColor = 'Green'
  $options.OperatorColor = 'Cyan'
  $options.ParameterColor = 'Cyan'
  $options.StringColor = 'Blue'
  $options.TypeColor = 'Blue'
  $options.VariableColor = 'Green'

  Clear-Variable -name "options"
}

if ($PSStyle) {
  $PSStyle.FileInfo.Directory = "`e[38;2;0;128;128m"
  #$PSStyle.FileInfo.Executable =
  #$PSStyle.FileInfo.SymbolicLink  = ""
  #$PSStyle.FileInfo.Extension.Clear()
  #$PSStyle.Formatting.TableHeader = ""
  #$PSStyle.Formatting.FormatAccent = ""
}

# Alias
if (Test-Path -Path "C:/opt/vim/gvim.exe" -PathType Leaf) {
  new-item alias:gvim -value "C:/opt/vim//gvim.exe" | Out-Null
}
if (Test-Path -Path "C:/opt/vim/vim.exe" -PathType Leaf) {
  new-item alias:vi -value "C:/opt/vim//vim.exe" | Out-Null
}
new-alias which get-command
new-alias open invoke-item

# Functions
function Reset-Color {
  [Console]::ResetColor()
}

if (Test-Path -Path "$PSScriptRoot\Microsoft.PowerShell_profile.local.ps1" -PathType Leaf) {
  echo "loading local"
  . "$PSScriptRoot\Microsoft.PowerShell_profile.local.ps1"
}

echo "profile loaded"
