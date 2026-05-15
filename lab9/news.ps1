param(
    [Parameter(Mandatory = $true)]
    [String]$topic
)

try {
    $apiKey = "..."
    $url = "https://newsapi.org/v2/everything?q=${topic}&pageSize=15&apiKey=${apiKey}"

    $response = Invoke-WebRequest -Uri $url
    $data = $response | ConvertFrom-Json

    Write-Host "Wyników:" $data.totalResults

    foreach ($item in $data.articles) {
        Write-Host $item.author
        Write-Host $item.title
        Write-Host $item.description 
        Write-Host $item.url "`n`n"
    }
}
catch {
    Write-Host "Błąd zapytania API"
}
