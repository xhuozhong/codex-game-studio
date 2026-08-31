Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$StudioSkills = @(
    'game-studio-director', 'higgsfield-game-generation', 'game-engine',
    'multiplayer-game', 'game-developer', 'game-ui-design', 'game-design-theory',
    'game-feel', 'game-ui-ux', 'threejs-game-ui-designer', 'develop-web-game'
)

function Assert-NoLink([string]$Path) {
    if (Test-Path -LiteralPath $Path) {
        if ((Get-Item -LiteralPath $Path -Force).Attributes -band [IO.FileAttributes]::ReparsePoint) {
            throw "Symbolic links/junctions are not supported: $Path"
        }
    }
}

function Get-SafeChild([string]$Root, [string]$Relative) {
    $basePath = [IO.Path]::GetFullPath($Root).TrimEnd([IO.Path]::DirectorySeparatorChar)
    $childPath = [IO.Path]::GetFullPath((Join-Path $basePath $Relative))
    if (-not $childPath.StartsWith($basePath + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Path escapes its allowed root: $Relative"
    }
    return $childPath
}

function Get-StudioPaths([string]$Scope, [string]$ProjectRoot) {
    if ($Scope -eq 'Project') {
        if (-not $ProjectRoot -or -not (Test-Path -LiteralPath $ProjectRoot -PathType Container)) {
            throw 'Project scope requires an existing -ProjectRoot directory.'
        }
        $basePath = (Resolve-Path -LiteralPath $ProjectRoot).ProviderPath
    } else {
        $basePath = [Environment]::GetFolderPath('UserProfile')
        if (-not $basePath) { throw 'Cannot determine the user profile directory.' }
    }
    Assert-NoLink $basePath
    $agentsPath = Get-SafeChild $basePath '.agents'
    $skillsPath = Get-SafeChild $agentsPath 'skills'
    $backupsPath = Get-SafeChild $agentsPath 'skill-backups'
    $studioBackupPath = Get-SafeChild $backupsPath 'codex-game-studio'
    foreach ($p in @($agentsPath, $skillsPath, $backupsPath, $studioBackupPath)) { Assert-NoLink $p }
    return @{ Skills = $skillsPath; Backups = $studioBackupPath }
}

function Test-StudioSource([string]$RepoRoot) {
    $sourceRoot = Get-SafeChild $RepoRoot 'skills'
    Assert-NoLink $sourceRoot
    $dirs = @(Get-ChildItem -LiteralPath $sourceRoot -Directory -Force)
    if ($dirs.Count -ne 11) { throw "Expected exactly 11 Skill folders; found $($dirs.Count)." }
    foreach ($name in $StudioSkills) {
        $folder = Get-SafeChild $sourceRoot $name
        Assert-NoLink $folder
        foreach ($item in @(Get-ChildItem -LiteralPath $folder -Recurse -Force)) { Assert-NoLink $item.FullName }
        $skillFile = Join-Path $folder 'SKILL.md'
        $content = [IO.File]::ReadAllText($skillFile)
        if ($content -notmatch '(?s)\A---\r?\n(.*?)\r?\n---\r?\n') { throw "Invalid frontmatter: $name" }
        $header = $Matches[1]
        if ($header -notmatch ('(?m)^name: ' + [regex]::Escape($name) + '\r?$')) { throw "Name mismatch: $name" }
        if ($header -notmatch '(?m)^description: \S.+\r?$') { throw "Missing description: $name" }
        $metadata = [IO.File]::ReadAllText((Join-Path $folder 'agents\openai.yaml'))
        if ($metadata -notmatch '(?m)^interface:\r?$' -or $metadata -notmatch '(?m)^  short_description: ".+"\r?$') {
            throw "Invalid UI metadata: $name"
        }
    }
}

function New-StudioBackup([string]$BackupRoot) {
    $id = (Get-Date -Format 'yyyyMMdd-HHmmss-fff') + '-' + [Guid]::NewGuid().ToString('N').Substring(0,8)
    $backup = Get-SafeChild $BackupRoot $id
    New-Item -ItemType Directory -Path $backup -Force | Out-Null
    return $backup
}
