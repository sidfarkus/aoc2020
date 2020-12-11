using namespace System.Collections.Immutable

$nums = [int[]] ((Get-Content "input") -split " " | % { $_ -as [int] } | Sort-Object)
$diffs = @(0, 1, 0, 1)
for ($i = 0; $i -lt $nums.Count - 1; $i += 1) {
    $diffs[$nums[$i + 1] - $nums[$i]] += 1
}

# part 1
Write-Output ($diffs[1] * $diffs[3])

$memo = @{}

function Valid-Combinations([int] $lastJolts, [ImmutableHashSet[int]] $jolts) {
    if ($jolts.Count -eq 1) {
        return 1
    }

    $sum = 0
    $candidates = $jolts | where { $_ - $lastJolts -le 3 }
    foreach ($candidate in $candidates) {
        if (-not $memo.ContainsKey($candidate)) {
            $joltsWithoutCandidate = $jolts.Remove($candidate)
            $memo[$candidate] = (Valid-Combinations $candidate $joltsWithoutCandidate)
        }
        $sum += $memo[$candidate]
    }
    return $sum
}

Write-Host (Valid-Combinations 0 ([ImmutableHashSet]::Create(@($nums))))