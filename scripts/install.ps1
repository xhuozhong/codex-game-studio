[CmdletBinding()]
param(
    [ValidateSet('User','Project')][string]$Scope = 'User',
    [string]$ProjectRoot,
    [switch]$Force
)
. (Join-Path $PSScriptRoot 'common.ps1')
$repoRoot = Split-Path $PSScriptRoot -Parent
Test-StudioSource $repoRoot
$paths = Get-StudioPaths $Scope $ProjectRoot
$sourceRoot = Join-Path $repoRoot 'skills'
$destRoot = $paths.Skills
if ([IO.Path]::GetFullPath($sourceRoot) -eq [IO.Path]::GetFullPath($destRoot)) { throw 'Source and target must differ.' }

# Preflight all conflicts before changing any existing Skill.
foreach ($name in $StudioSkills) {
    $dest = Get-SafeChild $destRoot $name
    Assert-NoLink $dest
    if (Test-Path -LiteralPath $dest) {
        if (-not $Force) { throw "Already exists: $name. Review it, then use REPAIR_WINDOWS.cmd or -Force to back up and update." }
    }
}
New-Item -ItemType Directory -Path $destRoot -Force | Out-Null
$backup = New-StudioBackup $paths.Backups
$moved = [Collections.Generic.List[string]]::new()
$started = [Collections.Generic.List[string]]::new()
try {
    foreach ($name in $StudioSkills) {
        $dest = Get-SafeChild $destRoot $name
        if (Test-Path -LiteralPath $dest) {
            Move-Item -LiteralPath $dest -Destination (Get-SafeChild $backup $name)
            $moved.Add($name)
        }
        $started.Add($name)
        Copy-Item -LiteralPath (Get-SafeChild $sourceRoot $name) -Destination $dest -Recurse
        $marker = @{ package = 'codex-game-studio'; version = ([IO.File]::ReadAllText((Join-Path $repoRoot 'VERSION'))).Trim(); skill = $name }
        $marker | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $dest '.codex-game-studio.json') -Encoding UTF8
        foreach ($file in Get-ChildItem -LiteralPath (Join-Path $sourceRoot $name) -Recurse -File) {
            $relative = $file.FullName.Substring((Join-Path $sourceRoot $name).Length).TrimStart('\','/')
            if ((Get-FileHash -LiteralPath $file.FullName).Hash -ne (Get-FileHash -LiteralPath (Join-Path $dest $relative)).Hash) {
                throw "Copy verification failed: $name/$relative"
            }
        }
    }
} catch {
    $failure = $_
    foreach ($name in $started) {
        $dest = Get-SafeChild $destRoot $name
        try {
            if (Test-Path -LiteralPath $dest) { Move-Item -LiteralPath $dest -Destination (Get-SafeChild $backup ('failed-' + $name)) }
            if ($moved.Contains($name)) { Move-Item -LiteralPath (Get-SafeChild $backup $name) -Destination $dest }
        } catch { Write-Warning "Automatic recovery failed for $name. Inspect backup: $backup" }
    }
    throw $failure
}
Write-Output "Installed and verified 11 Skills: $destRoot"
Write-Output "Backup location (empty on a fresh install): $backup"
Write-Output 'If Skills do not appear, restart Codex. Invoke $game-studio-director in your game project.'
