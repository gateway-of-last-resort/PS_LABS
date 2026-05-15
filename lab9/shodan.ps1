param(
    [Parameter(Mandatory = $true)]
    [String]$ip # adres ip do sprawdzenia
)

try {
    $apiKey = "..." # klucz api do api.shodan.io
    # adres url do pobrania informacji o celu
    $url = "https://api.shodan.io/shodan/host/${ip}?key=${apiKey}"

    # pobranie danych i konwersja z formatu json
    $response = Invoke-WebRequest -Uri $url
    $data = $response | ConvertFrom-Json

    # wyświetlanie podstawowych danych
    Write-Host "Organizacja`t: " $data.org
    Write-Host "Numer ASN`t: " $data.asn
    Write-Host "Kraj`t`t: " $data.country_name
    Write-Host "Kod kraju`t: " $data.country_code

    # oddzielna pętla foreach do wyświetlania nazw hostów oddzielonych przecinkiem
    Write-Host "Host`t`t: " -NoNewline
    $notFirst = $false
    foreach ($hostname in $data.hostnames) {
        Write-Host ("," * $notFirst) $hostname -NoNewline
        # to zapewni, że tylko przed pierwszą nazwą hosta nie będzie przecinka
        $notFirst = $true
    }
    Write-Host ""

    # oddzielna pętla foreach do wyświetlania otwartych portów oddzielonych przecinkiem
    Write-Host "Otwarte porty`t: " -NoNewline
    $notFirst = $false
    foreach ($port in $data.ports) {
        Write-Host ("," * $notFirst) $port -NoNewline
        # to samo co i w poprzedniej pętli (line 26)
        $notFirst = $true
    }
    Write-Host ""
}
catch {
    # obsługa błędu
    Write-Host "Błąd zapytania API"
}
