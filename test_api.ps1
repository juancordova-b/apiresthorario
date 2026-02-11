$baseUrl = "http://localhost:8080/schedules"

# 1. Create a Schedule
Write-Host "1. Creating Schedule..."
$body = @{
    nombre = "Vitamina C"
    dosis = "500mg"
    hora = "08:00"
    frecuencia = "Diario"
    notas = "Tomar con agua"
    activo = $true
} | ConvertTo-Json

$response = Invoke-RestMethod -Uri $baseUrl -Method Post -Body $body -ContentType "application/json"
Write-Host "Created: $($response.id) - $($response.nombre)"
$id = $response.id

# 2. Get All Schedules
Write-Host "`n2. Listing Schedules..."
$schedules = Invoke-RestMethod -Uri $baseUrl -Method Get
Write-Host "Count: $($schedules.Count)"
$schedules | Format-Table id, nombre, dosis, hora

# 3. Get Schedule by ID
Write-Host "`n3. Getting Schedule $id..."
$schedule = Invoke-RestMethod -Uri "$baseUrl/$id" -Method Get
Write-Host "Got: $($schedule.nombre)"

# 4. Update Schedule
Write-Host "`n4. Updating Schedule $id..."
$updateBody = @{
    nombre = "Vitamina C (Updated)"
    dosis = "1000mg"
    hora = "09:00"
    frecuencia = "Diario"
    notas = "Tomar con mucha agua"
    activo = $true
} | ConvertTo-Json

$updated = Invoke-RestMethod -Uri "$baseUrl/$id" -Method Put -Body $updateBody -ContentType "application/json"
Write-Host "Updated: $($updated.nombre) - $($updated.dosis)"

# 5. Delete Schedule
Write-Host "`n5. Deleting Schedule $id..."
Invoke-RestMethod -Uri "$baseUrl/$id" -Method Delete
Write-Host "Deleted."

# Verify Deletion
Write-Host "`n6. Verifying Deletion..."
try {
    Invoke-RestMethod -Uri "$baseUrl/$id" -Method Get
    Write-Host "Error: Schedule still exists!"
} catch {
    Write-Host "Success: Schedule not found (404)."
}
