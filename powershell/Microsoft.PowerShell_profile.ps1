# PS > $PSVersionTable

Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PsReadlineOption -BellStyle None

# Setting console colors
# from cmd-color-solarlized

# Host Foreground
$Host.PrivateData.ErrorForegroundColor = 'Red'
$Host.PrivateData.WarningForegroundColor = 'Yellow'
$Host.PrivateData.DebugForegroundColor = 'Green'
$Host.PrivateData.VerboseForegroundColor = 'Blue'
$Host.PrivateData.ProgressForegroundColor = 'Gray'

# Host Gackground
$Host.PrivateData.ErrorBackgroundColor = 'White'
$Host.PrivateData.WarningBackgroundColor = 'White'
$Host.PrivateData.DebugBackgroundColor = 'White'
$Host.PrivateData.VerboseBackgroundColor = 'White'
$Host.PrivateData.ProgressBackgroundColor = 'Cyan'

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

# Alias
new-item alias:gvim -value "C:/opt/vim/vim8/gvim.exe" | Out-Null
new-alias which get-command
new-alias open invoke-item

# Functions
function Reset-Color {
  [Console]::ResetColor()
}

echo "profile loaded"
