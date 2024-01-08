# Bindings from official PSreadline https://github.com/PowerShell/PSReadLine
# Provided on default profile : https://github.com/PowerShell/PSReadLine
# The next four key handlers are designed to make entering matched quotes
# parens, and braces a nicer experience.  I'd like to include functions
# in the module that do this, but this implementation still isn't as smart
# as ReSharper, so I'm just providing it as a sample.
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

# BUG: autopair with paste is brokena
# Attempt to correct didnt work
#
# Set-PSReadLineKeyHandler -Key '"',"'" `
#   -BriefDescription SmartInsertQuote `
#   -LongDescription "Insert paired quotes if not already on a quote" `
#   -ScriptBlock {
#   param($key, $arg)
#
#   $quote = $key.KeyChar
#   if ([Microsoft.PowerShell.PSConsoleReadLine]::IsLastCommandPaste())
#   {
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert($key.KeyChar)
#     return
#   }
#
#   $selectionStart = $null
#   $selectionLength = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)
#
#   $line = $null
#   $cursor = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
#
#   # If text is selected, just quote it without any smarts
#   if ($selectionStart -ne -1)
#   {
#     [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $quote + $line.SubString($selectionStart, $selectionLength) + $quote)
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
#     return
#   }
#
#   $ast = $null
#   $tokens = $null
#   $parseErrors = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$parseErrors, [ref]$null)
#
#   function FindToken
#   {
#     param($tokens, $cursor)
#
#     foreach ($token in $tokens)
#     {
#       if ($cursor -lt $token.Extent.StartOffset)
#       { continue 
#       }
#       if ($cursor -lt $token.Extent.EndOffset)
#       {
#         $result = $token
#         $token = $token -as [StringExpandableToken]
#         if ($token)
#         {
#           $nested = FindToken $token.NestedTokens $cursor
#           if ($nested)
#           { $result = $nested 
#           }
#         }
#
#         return $result
#       }
#     }
#     return $null
#   }
#
#   $token = FindToken $tokens $cursor
#
#   # If we're on or inside a **quoted** string token (so not generic), we need to be smarter
#   if ($token -is [StringToken] -and $token.Kind -ne [TokenKind]::Generic)
#   {
#     # If we're at the start of the string, assume we're inserting a new string
#     if ($token.Extent.StartOffset -eq $cursor)
#     {
#       [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote ")
#       [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
#       return
#     }
#
#     # If we're at the end of the string, move over the closing quote if present.
#     if ($token.Extent.EndOffset -eq ($cursor + 1) -and $line[$cursor] -eq $quote)
#     {
#       [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
#       return
#     }
#   }
#
#   if ($null -eq $token -or
#     $token.Kind -eq [TokenKind]::RParen -or $token.Kind -eq [TokenKind]::RCurly -or $token.Kind -eq [TokenKind]::RBracket)
#   {
#     if ($line[0..$cursor].Where{$_ -eq $quote}.Count % 2 -eq 1)
#     {
#       # Odd number of quotes before the cursor, insert a single quote
#       [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
#     } else
#     {
#       # Insert matching quotes, move cursor to be in between the quotes
#       [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote")
#       [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
#     }
#     return
#   }
#
#   # If cursor is at the start of a token, enclose it in quotes.
#   if ($token.Extent.StartOffset -eq $cursor)
#   {
#     if ($token.Kind -eq [TokenKind]::Generic -or $token.Kind -eq [TokenKind]::Identifier -or 
#       $token.Kind -eq [TokenKind]::Variable -or $token.TokenFlags.hasFlag([TokenFlags]::Keyword))
#     {
#       $end = $token.Extent.EndOffset
#       $len = $end - $cursor
#       [Microsoft.PowerShell.PSConsoleReadLine]::Replace($cursor, $len, $quote + $line.SubString($cursor, $len) + $quote)
#       [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($end + 2)
#       return
#     }
#   }
#
#   # We failed to be smart, so just insert a single quote
#   [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
# }

# Set-PSReadLineKeyHandler -Key '(','{','[' `
#   -BriefDescription InsertPairedBraces `
#   -LongDescription "Insert matching braces" `
#   -ScriptBlock {
#   param($key, $arg)
#
#   $closeChar = switch ($key.KeyChar)
#   {
#     <#case#> '('
#     { [char]')'; break 
#     }
#     <#case#> '{'
#     { [char]'}'; break 
#     }
#     <#case#> '['
#     { [char]']'; break 
#     }
#   }
#
#   if ([Microsoft.PowerShell.PSConsoleReadLine]::IsLastCommandPaste()) {
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert($key.KeyChar)
#     return
#   }
#   $selectionStart = $null
#   $selectionLength = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)
#
#   $line = $null
#   $cursor = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
#     
#   if ($selectionStart -ne -1)
#   {
#     # Text is selected, wrap it in brackets
#     [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $key.KeyChar + $line.SubString($selectionStart, $selectionLength) + $closeChar)
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
#   } else
#   {
#     # No text is selected, insert a pair
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)$closeChar")
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
#   }
# }

# Set-PSReadLineKeyHandler -Key ')',']','}' `
#   -BriefDescription SmartCloseBraces `
#   -LongDescription "Insert closing brace or skip" `
#   -ScriptBlock {
#   param($key, $arg)
#
#   $line = $null
#   $cursor = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
#
#   if ($line[$cursor] -eq $key.KeyChar)
#   {
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
#   } else
#   {
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)")
#   }
# }
#
# Set-PSReadLineKeyHandler -Key Backspace `
#   -BriefDescription SmartBackspace `
#   -LongDescription "Delete previous character or matching quotes/parens/braces" `
#   -ScriptBlock {
#   param($key, $arg)
#
#   $line = $null
#   $cursor = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
#
#   if ($cursor -gt 0)
#   {
#     $toMatch = $null
#     if ($cursor -lt $line.Length)
#     {
#       switch ($line[$cursor])
#       {
#         <#case#> '"'
#         { $toMatch = '"'; break 
#         }
#         <#case#> "'"
#         { $toMatch = "'"; break 
#         }
#         <#case#> ')'
#         { $toMatch = '('; break 
#         }
#         <#case#> ']'
#         { $toMatch = '['; break 
#         }
#         <#case#> '}'
#         { $toMatch = '{'; break 
#         }
#       }
#     }
#
#     if ($toMatch -ne $null -and $line[$cursor-1] -eq $toMatch)
#     {
#       [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor - 1, 2)
#     } else
#     {
#       [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteChar($key, $arg)
#     }
#   }
# }
#
# for ` as string and not escape sequence
# Set-PSReadLineKeyHandler -Chord "Ctrl+``" `
#   -BriefDescription ToggleQuoteArgument `
#   -LongDescription "Toggle quotes on the argument under the cursor" `
#   -ScriptBlock {
#   param($key, $arg)
#
#   $ast = $null
#   $tokens = $null
#   $errors = $null
#   $cursor = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)
#
#   $tokenToChange = $null
#   foreach ($token in $tokens)
#   {
#     $extent = $token.Extent
#     if ($extent.StartOffset -le $cursor -and $extent.EndOffset -ge $cursor)
#     {
#       $tokenToChange = $token
#
#       # If the cursor is at the end (it's really 1 past the end) of the previous token,
#       # we only want to change the previous token if there is no token under the cursor
#       if ($extent.EndOffset -eq $cursor -and $foreach.MoveNext())
#       {
#         $nextToken = $foreach.Current
#         if ($nextToken.Extent.StartOffset -eq $cursor)
#         {
#           $tokenToChange = $nextToken
#         }
#       }
#       break
#     }
#   }
#
#   if ($tokenToChange -ne $null)
#   {
#     $extent = $tokenToChange.Extent
#     $tokenText = $extent.Text
#     if ($tokenText[0] -eq '"' -and $tokenText[-1] -eq '"')
#     {
#       # Switch to no quotes
#       $replacement = $tokenText.Substring(1, $tokenText.Length - 2)
#     } elseif ($tokenText[0] -eq "'" -and $tokenText[-1] -eq "'")
#     {
#       # Switch to double quotes
#       $replacement = '"' + $tokenText.Substring(1, $tokenText.Length - 2) + '"'
#     } else
#     {
#       # Add single quotes
#       $replacement = "'" + $tokenText + "'"
#     }
#
#     [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
#       $extent.StartOffset,
#       $tokenText.Length,
#       $replacement)
#   }
# }
#
# NOTE: Modified from docs to follow vim bindings for mnemonics
$global:PSReadLineMarks = @{}

# Set a mark with 'm' followed by a key
Set-PSReadLineKeyHandler -Key 'Ctrl+M' `
  -BriefDescription MarkDirectory `
  -LongDescription "Mark the current directory" `
  -ScriptBlock {
  param($key, $arg)

  $key = [Console]::ReadKey($true)
  $global:PSReadLineMarks[$key.KeyChar] = $pwd
}

# Go to a mark with '`' followed by a key
Set-PSReadLineKeyHandler -Key 'Ctrl+m' `
  -BriefDescription JumpDirectory `
  -LongDescription "Go to the marked directory" `
  -ScriptBlock {
  param($key, $arg)

  $key = [Console]::ReadKey($true)
  $dir = $global:PSReadLineMarks[$key.KeyChar]
  if ($dir)
  {
    Set-Location -Path $dir
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  }
}
#TODO: maybe create a bindings with M for global mark that are stored in a file as key pair 

#NOTE: Done to check and navigate to created marks
function Get-Marks
{
  # Convert marks to a list of strings
  $markList = $global:PSReadLineMarks.GetEnumerator() | ForEach-Object { "$($_.Key): $($_.Value)" }

  # Use fzf to select a mark
  $selectedMark = $markList | fzf

  # Extract the key from the selected mark
  if ($selectedMark)
  {
    $selectedKey = $selectedMark[0]
    $dir = $global:PSReadLineMarks[$selectedKey]
    if ($dir)
    {
      Set-Location -Path $dir
      [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    }
  }
}
# ctrl shift ` trigger fzf marks.. 
Set-PSReadLineKeyHandler -Key "CTRL+~" -ScriptBlock { Get-Marks }
# Default behavior from example + custom if to where and select that are used on nearly every command
# TODO : add more case to this ( maybe switch when more are added)
# Or even an object that contain match + replacement that can handle missspelling too ? dictionnary ?
Set-PSReadLineKeyHandler -Key "Ctrl+%" `
  -BriefDescription CustomExpandAndReplace `
  -LongDescription "Expand aliases and apply custom replacements" `
  -ScriptBlock {
  param($key, $arg)

  $ast = $null
  $tokens = $null
  $errors = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

  # Expand aliases
  $startAdjustment = 0
  foreach ($token in $tokens)
  {
    if ($token.TokenFlags -band [TokenFlags]::CommandName)
    {
      $alias = $ExecutionContext.InvokeCommand.GetCommand($token.Extent.Text, 'Alias')
      if ($alias -ne $null)
      {
        $resolvedCommand = $alias.ResolvedCommandName
        if ($resolvedCommand -ne $null)
        {
          $extent = $token.Extent
          $length = $extent.EndOffset - $extent.StartOffset
          [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
            $extent.StartOffset + $startAdjustment,
            $length,
            $resolvedCommand)

          # Adjust for the difference in length
          $startAdjustment += ($resolvedCommand.Length - $length)
        }
      }
    }
  }

  # Apply custom replacements
  foreach ($token in $tokens)
  {
    $word = $token.Extent.Text
    switch ($word)
    {
      "where"
      {
        # Constructing '$_' from its parts to avoid variable expansion
        $dollarSign = '$'
        $underscore = '_'
        $replacement = " { " + $dollarSign + $underscore + " }"
        # Calculate the cursor position to be right inside '$_'
        $cursorPositionAdjustment = $token.Extent.EndOffset + $replacement.Length - 2 + $startAdjustment
        # Insert the replacement string after 'where'
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($replacement)
        # Set the cursor position
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursorPositionAdjustment)
      }
      "select"
      {
        $replacement = " -"
        $cursorPositionAdjustment = $token.Extent.EndOffset + $startAdjustment + $replacement.Length
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($replacement)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursorPositionAdjustment)
      }
      "block"
      {
        $replacement = "ScriptBlock { }"
        $cursorPositionAdjustment = $token.Extent.StartOffset + $replacement.Length - 2 + $startAdjustment
        [Microsoft.PowerShell.PSConsoleReadLine]::Replace($token.Extent.StartOffset + $startAdjustment, $token.Extent.Text.Length, $replacement)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursorPositionAdjustment)
      }
    }
  }
}
