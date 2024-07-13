# JSON data embedded directly into the script
$jsonData = @'
{
  ".devcontainer": {
    "devcontainer.json": "",
    "Dockerfile": ""
  },
  "data": {
    "raw": {},
    "processed": {}
  },
  "notebooks": {
    "example_notebook.ipynb": ""
  },
  "scripts": {
    "download_data.py": "",
    "load_health_data.py": "",
    "load_geo_data.py": ""
  },
  "dockerfile": "",
  "docker-compose.yml": "",
  "requirements.txt": "",
  "README.md": ""
}
'@

# Convert JSON data from the variable
try {
    $projectStructure = $jsonData | ConvertFrom-Json
    Write-Host "Successfully parsed JSON data."
}
catch {
    Write-Error "Failed to parse the JSON data. Please check the JSON content."
    exit
}

# Function to create directories and files recursively
function Create-Structure {
    param (
        [string]$rootPath,
        [psobject]$structure
    )

    foreach ($key in $structure.PSObject.Properties.Name) {
        $subPath = Join-Path -Path $rootPath -ChildPath $key
        if ($structure.$key -is [PSCustomObject]) {
            Write-Host "Creating directory: $subPath"
            if (-Not (Test-Path -Path $subPath -PathType Container)) {
                New-Item -Path $subPath -ItemType Directory -Force | Out-Null
            }
            Create-Structure -rootPath $subPath -structure $structure.$key
        }
        else {
            Write-Host "Creating file: $subPath"
            if (-Not (Test-Path -Path $subPath -PathType Leaf)) {
                New-Item -Path $subPath -ItemType File -Force | Out-Null
            }
        }
    }
}

# Get the current script directory
$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Write-Host "Script Directory: $scriptDirectory"

# Use the script directory as the root directory for the project
$rootDirectory = $scriptDirectory
Write-Host "Root Directory: $rootDirectory"

# Create project directories and files
Create-Structure -rootPath $rootDirectory -structure $projectStructure

Write-Host "Project structure created successfully."
