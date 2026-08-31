[CmdletBinding()]
param(
    [ValidateSet('User','Project')][string]$Scope = 'User',
    [string]$ProjectRoot
)
. (Join-Path $PSScriptRoot 'common.ps1')
$paths = Get-StudioPaths $Scope $ProjectRoot
$candidates = @()
foreach ($name in $StudioSkills) {
    $dest = Get-SafeChild $paths.Skills $name
    if (-not (Test-Path -LiteralPath $dest)) { continue }
    Assert-NoLink $dest
    $markerPath = Join-Path $dest '.codex-game-studio.json'
    if (-not (Test-Path -LiteralPath $markerPath -PathType Leaf)) { throw "Unmarked Skill left untouched: $name. No Skills have been moved." }
    Assert-NoLink $markerPath
    $marker = Get-Content -LiteralPath $markerPath -Raw | ConvertFrom-Json
    if ($marker.package -ne 'codex-game-studio' -or $marker.skill -ne $name) { throw "Marker mismatch: $name" }
    $candidates += $name
}
if (-not $candidates.Count) { Write-Output 'No marked Skills to uninstall.'; return }
$backup = New-StudioBackup $paths.Backups
$moved = @()
try {
    foreach ($name in $candidates) {
        Move-Item -LiteralPath (Get-SafeChild $paths.Skills $name) -Destination (Get-SafeChild $backup $name)
        $moved += $name
    }
} catch {
    $failure = $_
    foreach ($name in $moved) {
        try { Move-Item -LiteralPath (Get-SafeChild $backup $name) -Destination (Get-SafeChild $paths.Skills $name) }
        catch { Write-Warning "Recovery failed for $name; inspect $backup" }
    }
    throw $failure
}
Write-Output "Uninstalled $($moved.Count) Skills by moving them to: $backup"
Write-Output 'No files were permanently deleted. Other Skills were left untouched.'
