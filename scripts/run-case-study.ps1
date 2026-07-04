param(
    [string]$ProjectsRoot
)

$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
if (-not $ProjectsRoot) {
    $ProjectsRoot = (Resolve-Path (Join-Path $RepoRoot "..")).Path
}

function Invoke-BoundaryTool {
    param(
        [string]$Name,
        [string]$RepoName,
        [string]$Module,
        [string[]]$Arguments,
        [int[]]$ExpectedExitCodes
    )

    $repoPath = Join-Path $ProjectsRoot $RepoName
    if (-not (Test-Path -LiteralPath $repoPath)) {
        throw "$Name requires sibling repository not found: $repoPath"
    }

    $oldPythonPath = $env:PYTHONPATH
    $env:PYTHONPATH = $repoPath

    Write-Host ""
    Write-Host "== $Name =="
    Write-Host "python -m $Module $($Arguments -join ' ')"
    & python -m $Module @Arguments
    $exitCode = $LASTEXITCODE

    if ($null -eq $oldPythonPath) {
        Remove-Item Env:\PYTHONPATH -ErrorAction SilentlyContinue
    } else {
        $env:PYTHONPATH = $oldPythonPath
    }

    if ($ExpectedExitCodes -notcontains $exitCode) {
        throw "$Name returned exit code $exitCode; expected one of: $($ExpectedExitCodes -join ', ')"
    }

    Write-Host "accepted exit code: $exitCode"
}

Invoke-BoundaryTool `
    -Name "handoff pass" `
    -RepoName "handoff-lint" `
    -Module "handoff_lint.cli" `
    -Arguments @("check", (Join-Path $RepoRoot "fixtures/handoff/strong.md")) `
    -ExpectedExitCodes @(0)

Invoke-BoundaryTool `
    -Name "handoff expected finding" `
    -RepoName "handoff-lint" `
    -Module "handoff_lint.cli" `
    -Arguments @("check", (Join-Path $RepoRoot "fixtures/handoff/weak.md")) `
    -ExpectedExitCodes @(1)

Invoke-BoundaryTool `
    -Name "policy allow" `
    -RepoName "policy-lint" `
    -Module "policy_lint.cli" `
    -Arguments @("classify", "--policy", (Join-Path $RepoRoot "fixtures/policy/policy.json"), "git status --short") `
    -ExpectedExitCodes @(0)

Invoke-BoundaryTool `
    -Name "policy owner gate" `
    -RepoName "policy-lint" `
    -Module "policy_lint.cli" `
    -Arguments @("classify", "--policy", (Join-Path $RepoRoot "fixtures/policy/policy.json"), "python -m pip install requests") `
    -ExpectedExitCodes @(1)

Invoke-BoundaryTool `
    -Name "contract pass" `
    -RepoName "contract-lint" `
    -Module "contract_lint.cli" `
    -Arguments @("verify", "--contract", (Join-Path $RepoRoot "fixtures/contract/contract.json"), "--result", (Join-Path $RepoRoot "fixtures/contract/result-pass.json"), "--base-dir", (Join-Path $RepoRoot "fixtures/contract")) `
    -ExpectedExitCodes @(0)

Invoke-BoundaryTool `
    -Name "contract expected finding" `
    -RepoName "contract-lint" `
    -Module "contract_lint.cli" `
    -Arguments @("verify", "--contract", (Join-Path $RepoRoot "fixtures/contract/contract.json"), "--result", (Join-Path $RepoRoot "fixtures/contract/result-fail.json"), "--base-dir", (Join-Path $RepoRoot "fixtures/contract")) `
    -ExpectedExitCodes @(1)

Invoke-BoundaryTool `
    -Name "claims pass" `
    -RepoName "claim-lint" `
    -Module "claim_lint.cli" `
    -Arguments @("scan", (Join-Path $RepoRoot "fixtures/claims/public-copy-pass.md"), "--config", (Join-Path $RepoRoot "fixtures/claims/.claimlintrc.json")) `
    -ExpectedExitCodes @(0)

Invoke-BoundaryTool `
    -Name "claims expected finding" `
    -RepoName "claim-lint" `
    -Module "claim_lint.cli" `
    -Arguments @("scan", (Join-Path $RepoRoot "fixtures/claims/public-copy-fail.md"), "--config", (Join-Path $RepoRoot "fixtures/claims/.claimlintrc.json")) `
    -ExpectedExitCodes @(1)

Write-Host ""
Write-Host "Boundary case study completed."
