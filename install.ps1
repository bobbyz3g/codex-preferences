#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$DestinationDirectory
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($DestinationDirectory)) {
    $DestinationDirectory = if (-not [string]::IsNullOrWhiteSpace($env:CODEX_HOME)) {
        $env:CODEX_HOME
    } else {
        Join-Path $env:USERPROFILE '.codex'
    }
}

$DestinationDirectory = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($DestinationDirectory)
$source = Join-Path $PSScriptRoot 'AGENTS.md'
$target = Join-Path $DestinationDirectory 'AGENTS.md'
$override = Join-Path $DestinationDirectory 'AGENTS.override.md'

if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
    throw "Shared instructions not found: $source"
}
if ([string]::IsNullOrWhiteSpace([IO.File]::ReadAllText($source))) {
    throw 'Shared AGENTS.md must not be empty.'
}
if (Test-Path -LiteralPath $override) {
    Write-Warning "An override exists at $override. Codex may load it instead of AGENTS.md. Review it manually."
}
if (Test-Path -LiteralPath $target) {
    $existing = Get-Item -LiteralPath $target -Force
    if ($existing.PSIsContainer -or ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
        throw "Destination must be a regular file, not a directory or link: $target"
    }
    if ((Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash -eq
        (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash) {
        Write-Output "Already up to date: $target"
        return
    }
}

if ($PSCmdlet.ShouldProcess($target, 'Back up existing instructions and install shared AGENTS.md')) {
    [IO.Directory]::CreateDirectory($DestinationDirectory) | Out-Null
    if (Test-Path -LiteralPath $target) {
        $backupDirectory = Join-Path $DestinationDirectory 'agents-backups'
        [IO.Directory]::CreateDirectory($backupDirectory) | Out-Null
        $backup = Join-Path $backupDirectory ('AGENTS.{0}.{1}.md' -f (Get-Date -Format 'yyyyMMdd-HHmmss'), [guid]::NewGuid().ToString('N'))
        [IO.File]::Copy($target, $backup, $false)
        Write-Output "Backup saved: $backup"
    }
    [IO.File]::Copy($source, $target, $true)
    if ((Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash -ne
        (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash) {
        throw "Installed file verification failed: $target"
    }
    Write-Output "Installed and verified: $target"
    Write-Output 'Start a new Codex session to load the updated instructions.'
}
