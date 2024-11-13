<#
Autor: Carlos Castro Leon
Este script elimina usuarios previamente cesado
#>
Import-Module ActiveDirectory
#Import-Module -SkipEditionCheck

# Definir la ruta de la OU
$ouPath = "OU=USUARIOS-CESADOS,DC=ccastrol,DC=com"

# Obtener todos los usuarios en la OU
$users = Get-ADUser -Filter * -SearchBase $ouPath -Properties Enabled, Department, Name

# Variables para almacenar usuarios deshabilitados y habilitados
$disabledUsers = @()
$enabledUsers = @()

# Verificar si los usuarios están deshabilitados o habilitados
foreach ($user in $users) {
    if ($user.Enabled -eq $false) {
        $disabledUsers += $user
    } else {
        $enabledUsers += $user
    }
}

# Si hay usuarios habilitados, cancelar el proceso y mostrar los detalles
if ($enabledUsers.Count -gt 0) {
    Write-Host "No se puede continuar. Se encontraron usuarios activos en la OU:" -ForegroundColor Red
    foreach ($user in $enabledUsers) {
        Write-Host "Usuario habilitado: $($user.Name)"
    }
    exit
}

# Confirmación antes de proceder con la eliminación
$confirmation = Read-Host "Todos los usuarios en la OU están deshabilitados. ¿Desea continuar con la eliminación? (S/N)"
if ($confirmation -ne "S" -and $confirmation -ne "s") {
    Write-Host "Operación cancelada por el administrador." -ForegroundColor Yellow
    exit
}

# Si se confirma, proceder con la eliminación
$outputFile = ".\Cesados_Eliminados.txt"
foreach ($user in $disabledUsers) {
    $line = "$($user.Name), $($user.Department)"
    Add-Content -Path $outputFile -Value $line
    Remove-ADUser -Identity $user.SamAccountName -Confirm:$false
    Write-Host "$($user.Name) eliminado."
}

Write-Host "Proceso completado. Se eliminaron todos los usuarios deshabilitados en la OU."
