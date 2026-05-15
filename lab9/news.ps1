param(
    [Parameter(Mandatory = $true)]
    [String]$topic # temat wyszukiwania
)

try {
    $apiKey = "..." # klucz api
    # adres url do pobrania 15 pierwszych wyników wyszukiwania
    $url = "https://newsapi.org/v2/everything?q=${topic}&pageSize=15&apiKey=${apiKey}"

    # pobranie danych i konwersja z formatu json
    $response = Invoke-WebRequest -Uri $url
    $data = $response | ConvertFrom-Json

    # całkowita liczba znalezionych artykułów
    Write-Host "Wyników:" $data.totalResults

    # iteracja przez listę i wyświetlanie szczegółów
    foreach ($item in $data.articles) {
        Write-Host $item.author         # autor
        Write-Host $item.title          # tytuł
        Write-Host $item.description    # opis
        Write-Host $item.url "`n`n"     # link do artykuła
    }
}
catch {
    # obsługa błędu
    Write-Host "Błąd zapytania API"
}
