param(
    [Parameter(Mandatory = $true)]
    [String]$ip
)

try {
    $apiKey = "..."
    $url = "https://api.shodan.io/shodan/host/${ip}?key=${apiKey}"

    $response = Invoke-WebRequest -Uri $url
    $data = $response | ConvertFrom-Json

    Write-Host "Organizacja`t: " $data.org
    Write-Host "Numer ASN`t: " $data.asn
    Write-Host "Kraj`t`t: " $data.country_name
    Write-Host "Kod kraju`t: " $data.country_code

    Write-Host "Host`t`t: " -NoNewline
    $notFirst = $false
    foreach ($hostname in $data.hostnames) {
        Write-Host ("," * $notFirst) $hostname -NoNewline
        $notFirst = $true
    }
    Write-Host ""

    Write-Host "Otwarte porty`t: " -NoNewline
    $notFirst = $false
    foreach ($port in $data.ports) {
        Write-Host ("," * $notFirst) $port -NoNewline
        $notFirst = $true
    }
    Write-Host ""
}
catch {
    Write-Host "Błąd zapytania API"
}
