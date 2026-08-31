$ErrorActionPreference='Continue'
Write-Host '=== Codex Game Studio diagnostics ===' -ForegroundColor Cyan
Write-Host "User HOME : $HOME"
Write-Host "User skills: $(Join-Path $HOME '.agents\skills')"
Write-Host "Legacy skills: $(Join-Path $HOME '.codex\skills')"
foreach($root in @((Join-Path $HOME '.agents\skills'),(Join-Path $HOME '.codex\skills'))){
  if(Test-Path $root){Write-Host "`n[$root]" -ForegroundColor Yellow; Get-ChildItem $root -Directory | Where-Object Name -match 'game|higgs|rivet|develop' | Select-Object -ExpandProperty Name}
}
Write-Host "`nPowerShell: $($PSVersionTable.PSVersion)"
Write-Host "Python: $(python --version 2>&1)"
Write-Host "Git: $(git --version 2>&1)"
Write-Host '=== end ==='
