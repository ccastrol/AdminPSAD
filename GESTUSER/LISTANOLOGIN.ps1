<#
Autor: Carlos Castro Leon
Script para obtener lista de usuarios que nunca se logearon en el sistema (Lastlogondate esta en blanco)
#>
# Obtener la fecha actual en formato YYYY-MM-DD
$currentDate = Get-Date -Format "yyyy-MM-dd"

# Define la ruta y nombre del archivo CSV de salida
$outputFile = ".\listaNoLogin-$currentDate.csv"

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

# Opciones para la ruta de la Unidad Organizativa (OU), puedes incluir mas de una.
$OUOptions = @(
    "OU=USUARIOS,DC=ccastrol,DC=com"
)
$OU = Select-Option "Seleccione la OU para el usuario" $OUOptions

# Obtén los usuarios que nunca han iniciado sesión y exporta la salida a un archivo CSV
Get-ADUser -Filter {(lastlogondate -notlike "*") -and (enabled -eq $true)} -SearchBase $OU | 
Select samaccountname, DistinguishedName, lastLogonDate | 
Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

# Muestra un mensaje confirmando la exportación
Write-Host "La lista de usuarios que nunca han iniciado sesión de la $OU se ha exportado a $outputFile"
