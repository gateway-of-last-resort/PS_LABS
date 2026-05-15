param(
    [Parameter(Mandatory = $true)]
    [String]$waluta
)

try {
    $url = "https://api.nbp.pl/api/exchangerates/rates/A/${waluta}/last/5/"

    $response = Invoke-WebRequest -Uri $url
    $data = $response.Content | ConvertFrom-Json

    $name = $data.currency
    $rates = $data.rates
    $rate_today = $rates[-1].mid
}
catch {
    Write-Host "Nieprawidlowy kod waluty"
    exit -1
}

Write-Host "Waluta: " $name
Write-Host "Kurs dzisiejszy: " $rate_today

Write-Host "Data`t`tKurs`t`tRóżnica"

$i = 1
foreach ($value in $rates) {
    #Write-Host $value
    if ($i -eq 1) {
        Write-Host "$($value.effectiveDate)`t$($value.mid)`t`t---" 
    }
    else {
        $dif = [Math]::Round($value.mid - $prev.mid, 4)
        Write-Host "$($value.effectiveDate)`t$($value.mid)`t`t$($dif)" 
    }
    
    $prev = $value
    $i++
}
