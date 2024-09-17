try {
    # Check if Flyway is already installed
    & flyway --help > $null 2>&1
    Write-Host "Flyway CLI Detected - Continuing Without Install"
    exit 0
}
catch {
    Write-Host "Flyway Not Detected - Installing CLI"
    
    # Flyway Version to Use (Check for latest version: https://documentation.red-gate.com/fd/command-line-184127404.html)
    if ($null -ne ${env:FLYWAY_VERSION}) {
        # Environment Variables - Use these if set as a variable - Target Database Connection Details
        Write-Output "Using Environment Variables for Flyway CLI Version Number"
        $flywayVersion = "${env:FLYWAY_VERSION}"
        } else {
        Write-Output "Using Local Variables for Flyway CLI Version Number"
        # Local Variables - If Env Variables Not Set - Target Database Connection Details
        $flywayVersion = '10.17.3'
    }
    Write-Host "Using Flyway CLI version $flywayVersion"

    # URL and paths for download and extraction
    $Url = "https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/$flywayVersion/flyway-commandline-$flywayVersion-windows-x64.zip"
    $DownloadPath = "C:\FlywayCLI\"
    $DownloadZipFile = Join-Path $DownloadPath (Split-Path -Path $Url -Leaf)
    $ExtractPath = Join-Path $DownloadPath "flyway-$flywayVersion"

    # Create directory if it doesn't exist
    if (-not (Test-Path $DownloadPath)) {
        New-Item $DownloadPath -ItemType Directory | Out-Null
        Write-Host "Created directory: $DownloadPath"
    }

    # Download the CLI
    Write-Host "Downloading Flyway CLI..."
    Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile -UseBasicParsing

    # Extract the CLI
    Write-Host "Extracting Flyway CLI..."
    Add-Type -AssemblyName 'System.IO.Compression.FileSystem'
    [System.IO.Compression.ZipFile]::ExtractToDirectory($DownloadZipFile, $DownloadPath)

    # Update PATH Variable with Flyway CLI - Azure DevOps #

    Write-Host "Machine Environment Variable Being Set"
        #Write-Host "##vso[task.prependpath]C:\FlywayCLI\flyway-$flywayVersion"
    #Use the below logic to set the PATH variable on self-hosted machines
        [Environment]::SetEnvironmentVariable("PATH", $Env:PATH + ";${ExtractPath}flyway-$flywayVersion", [EnvironmentVariableTarget]::Machine)

    Write-Host "Flyway CLI setup complete!"
}
