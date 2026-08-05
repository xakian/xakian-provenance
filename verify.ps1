param(
  [Parameter(Mandatory = $true)]
  [string]$RepositoryPath,

  [Parameter(Mandatory = $true)]
  [ValidatePattern('^[0-9a-fA-F]{40}$')]
  [string]$Commit,

  [Parameter(Mandatory = $true)]
  [ValidatePattern('^[0-9a-fA-F]{64}$')]
  [string]$ExpectedSha256
)

$ErrorActionPreference = 'Stop'
$repository = Get-Item -LiteralPath $RepositoryPath -ErrorAction Stop

if (-not $repository.PSIsContainer) {
  throw "RepositoryPath must be a directory."
}

git -C $repository.FullName cat-file -e "$Commit^{commit}"
if ($LASTEXITCODE -ne 0) {
  throw "Commit was not found in the repository."
}

$start = New-Object System.Diagnostics.ProcessStartInfo
$start.FileName = 'git'
$start.Arguments = "archive --format=tar $Commit"
$start.WorkingDirectory = $repository.FullName
$start.UseShellExecute = $false
$start.RedirectStandardOutput = $true
$start.RedirectStandardError = $true

$process = [System.Diagnostics.Process]::Start($start)
$sha = [System.Security.Cryptography.SHA256]::Create()

try {
  $hashBytes = $sha.ComputeHash($process.StandardOutput.BaseStream)
  $process.WaitForExit()
  $errors = $process.StandardError.ReadToEnd()

  if ($process.ExitCode -ne 0) {
    throw "git archive failed: $errors"
  }

  $actual = ([System.BitConverter]::ToString($hashBytes)).Replace('-', '').ToLowerInvariant()
} finally {
  $sha.Dispose()
  $process.Dispose()
}

$expected = $ExpectedSha256.ToLowerInvariant()
$matches = $actual -eq $expected

[pscustomobject]@{
  Commit = $Commit.ToLowerInvariant()
  ExpectedSha256 = $expected
  ActualSha256 = $actual
  Matches = $matches
}

if (-not $matches) {
  exit 1
}
