param([string]$selected)
$pathOnly = $selected -split '\|' | Select-Object -Index 1
$pathOnly.Trim() | clip
