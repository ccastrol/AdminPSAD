<#
Autor: Carlos Castro Leon
Script para obtener lista de usuarios inactivos por un periodo de tiempo de 45 días.
#>
# Obtener la fecha actual en formato YYYY-MM-DD
$currentDate = Get-Date -Format "yyyy-MM-dd"

# Define la ruta y nombre del archivo CSV de salida
$outputFile = ".\listaInactivoUser-$currentDate.csv"

# Función para seleccionar una opción de una lista
function Select-Option ($prompt, $options) {
    $counter = 1
    foreach ($option in $options) {
        Write-Host "$counter. $option"
        $counter++
    }
    $selection = Read-Host $prompt
    return $options[$selection - 1]
}

# Opciones para la ruta de la Unidad Organizativa (OU), puedes incluir mas de una solo coloca una coma.
$OUOptions = @(
    "OU=USUARIOS,DC=ccastrol,DC=com",
)
$OU = Select-Option "Seleccione la OU para el usuario" $OUOptions

#Definir el periodo de tiempo desde que no inicia sesión.
$When = ((Get-Date).AddDays(-45)).Date

# Obtén los usuarios que no han iniciado sesión en un periodo de tiempo y exporta la salida a un archivo CSV
Get-ADUser -Filter {(LastLogonDate -lt $When) -and (enabled -eq $true)} -SearchBase $OU -Properties * | 
select-object samaccountname,Department,givenname,surname,Enabled,LastLogonDate | export-csv -path $outputFile -NoTypeInformation -Encoding UTF8

# Muestra un mensaje confirmando la exportación
Write-Host "La lista de usuarios que no han iniciado sesión en $when días de la $OU se ha exportado a $outputFile"
