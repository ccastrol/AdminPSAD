# Definir el umbral de días sin comunicación (45 días en este caso)
$daysThreshold = 45
$dateLimit = (Get-Date).AddDays(-$daysThreshold)

# Obtener equipos que no se han comunicado en más de 45 días
$inactiveComputers = Get-ADComputer -Filter {LastLogonDate -lt $dateLimit} -Properties Name, LastLogonDate

# Verificar si se encontraron equipos inactivos
if ($inactiveComputers.Count -gt 0) {
    Write-Host "Equipos que no se han comunicado en más de $daysThreshold días:" -ForegroundColor Green
    $inactiveComputers | Sort-Object LastLogonDate | Format-Table Name, LastLogonDate
} else {
    Write-Host "No se encontraron equipos inactivos en los últimos $daysThreshold días." -ForegroundColor Yellow
}
