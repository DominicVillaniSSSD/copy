# PowerShell script to sync files between two directories

param(
    [Parameter(Mandatory=$true)]
    [string]$SourceDir,
    
    [Parameter(Mandatory=$true)]
    [string]$DestinationDir
)

# Ensure both directories exist
if (-not (Test-Path $SourceDir)) {
    Write-Error "Source directory does not exist: $SourceDir"
    exit 1
}

if (-not (Test-Path $DestinationDir)) {
    Write-Error "Destination directory does not exist: $DestinationDir"
    exit 1
}

# Use Robocopy to sync the directories
$robocopyArgs = @(
    $SourceDir,
    $DestinationDir,
    "/MIR",
    "/FFT",
    "/Z",
    "/XA:H",
    "/W:5"
)

Write-Host "Syncing files from $SourceDir to $DestinationDir"
robocopy @robocopyArgs

if ($LASTEXITCODE -ge 8) {
    Write-Error "Robocopy encountered errors during synchronization"
    exit $LASTEXITCODE
} else {
    Write-Host "Synchronization completed successfully"
}
