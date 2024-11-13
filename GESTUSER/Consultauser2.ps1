<#
Autor: Carlos Castro Leon
Script para obtener lista de usuarios que coincidan con la busqueda por apellido.
#>
# Solicitar el apellido del usuario a buscar
$apellido = Read-Host "Ingrese el apellido del usuario que desea consultar"

# Buscar usuarios cuyo apellido (Surname) coincida con el valor ingresado
$usuarios = Get-ADUser -Filter "sn -like '*$apellido*'" -Properties SamAccountName, Surname, GivenName, Department

# Verificar si se encontraron usuarios
if ($usuarios.Count -gt 0) {
    Write-Host "Se encontraron los siguientes usuarios con el apellido '$apellido':"
    
    # Mostrar la lista de usuarios en formato de tabla
    $usuarios | Select-Object GivenName, Surname, SamAccountName, Department | Format-Table -AutoSize
} else {
    Write-Host "No se encontraron usuarios con el apellido '$apellido'."
}

