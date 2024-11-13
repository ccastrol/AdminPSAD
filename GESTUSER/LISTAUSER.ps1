<#
Autor: Carlos Castro Leon
Script para obtener lista de usuarios del AD.
#>
# Obtener la fecha actual en formato YYYY-MM-DD
$currentDate = Get-Date -Format "yyyy-MM-dd"

# Definir la ruta del archivo incluyendo la fecha
$filePath = ".\listaAD-$currentDate.csv"

# Exportar la lista de usuarios de AD al archivo CSV
Get-ADUser -Filter * -Properties * | Export-Csv -Path $filePath -NoTypeInformation

Write-Host "El archivo CSV se ha generado en: $filePath"
