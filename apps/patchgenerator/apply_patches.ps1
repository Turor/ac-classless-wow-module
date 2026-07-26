<#
.SYNOPSIS
    Applies the required SQL patches for mod-classless.
.DESCRIPTION
    This script applies SQL patches in the order specified by the user.
    It uses the sqlite3 client to execute the SQL files.
#>

param (
    [string]$SqliteDb = "./wow_dbc/wrath_dbcs.sqlite"
)

$DmlsDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BaseDir = $DmlsDir

function Apply-SqlFile {
    param ([string]$FilePath)
    if (Test-Path $FilePath) {
        Write-Host "Applying $FilePath..." -ForegroundColor Cyan
        # Note: Since files are commented out, this script might need to uncomment them on the fly
        # or it is intended to run them as is (which will do nothing) or after they are manually uncommented.
        # Based on the user request, I'll just execute them.
        Get-Content $FilePath | sqlite3 $SqliteDb
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed to apply $FilePath"
        }
    } else {
        Write-Warning "File not found: $FilePath"
    }
}

function Apply-SqlDir {
    param ([string]$DirName)
    $TargetDir = Join-Path $BaseDir $DirName
    if (Test-Path $TargetDir) {
        Write-Host "Applying all SQL files in $TargetDir..." -ForegroundColor Green
        Get-ChildItem -Path $TargetDir -Filter *.sql | ForEach-Object {
            Apply-SqlFile $_.FullName
        }
    } else {
        Write-Warning "Directory not found: $TargetDir"
    }
}

# 1. required patches
Apply-SqlDir "required"

# 2. spellchangeguides
Apply-SqlDir "spellchangeguides"

# 3. statfilemodifications
Apply-SqlDir "statfilemodifications"

# 4. talentchangeguides (non-recursive to separate from customtalents if needed)
$TalentDir = Join-Path $BaseDir "talentchangeguides"
if (Test-Path $TalentDir) {
    Write-Host "Applying SQL files in $TalentDir..." -ForegroundColor Green
    Get-ChildItem -Path $TalentDir -Filter *.sql | ForEach-Object {
        Apply-SqlFile $_.FullName
    }
}

# 5. customtalents
Apply-SqlDir "talentchangeguides/CustomTalents"

# 6. TalentTabTweaks.sql
Apply-SqlFile (Join-Path $BaseDir "TalentTabTweaks.sql")

# 7. SkillRaceClassInfoUpdateGuide.sql
Apply-SqlFile (Join-Path $BaseDir "SkillRaceClassInfoUpdateGuide.sql")

Write-Host "Finished applying patches." -ForegroundColor Yellow
