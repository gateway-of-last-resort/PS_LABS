param(
    [Parameter(Mandatory = $true)]
    [String]$waluta # kod waluty
)

try {
    # adres url do pobrania 5 ostatnich notowań z api.npb.pl
    $url = "https://api.nbp.pl/api/exchangerates/rates/A/${waluta}/last/5/"

    # pobranie danych i konwersja z formatu json
    $response = Invoke-WebRequest -Uri $url
    $data = $response.Content | ConvertFrom-Json

    # wyciąganie nazwy waluty i listy kursów
    $name = $data.currency
    $rates = $data.rates
    $rate_today = $rates[-1].mid
}
catch {
    # obsługa błędu
    Write-Host "Nieprawidlowy kod waluty"
    exit -1
}

# wyświetlanie nagłówków
Write-Host "Waluta: " $name
Write-Host "Kurs dzisiejszy: " $rate_today

Write-Host "Data`t`tKurs`t`tRóżnica"

$i = 1
foreach ($value in $rates) {
    if ($i -eq 1) {
        # pierwszy wpis nie ma poprzedniego do porównania
        Write-Host "$($value.effectiveDate)`t$($value.mid)`t`t---" 
    }
    else {
        # obliczanie różnicy i zaokrąglanie do 4 cyfr po przecinku
        $dif = [Math]::Round($value.mid - $prev.mid, 4)
        Write-Host "$($value.effectiveDate)`t$($value.mid)`t`t$($dif)" 
    }
    # przypisanie bieżącego kursu jako poprzedni do następnej iteracji
    $prev = $value
    $i++
}
