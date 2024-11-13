<#
Autor: Carlos Castro Leon
Este script busca usuarios cuyo departamento coincide con la busqueda.
#>
# Solicitar el nombre del departamento
$department = Read-Host "Ingrese el nombre del departamento que desea consultar"

# Buscar usuarios cuyo campo 'Department' coincida con el valor ingresado
$usuarios = Get-ADUser -Filter "Department -eq '$department'" -Properties SamAccountName, GivenName, Surname, Department

# Verificar si se encontraron usuarios
if ($usuarios.Count -gt 0) {
    Write-Host "Se encontraron los siguientes usuarios en el departamento '$department':"
    
    # Mostrar la lista de usuarios en formato tabla
    $usuarios | Select-Object SamAccountName, GivenName, Surname, Department | Format-Table -AutoSize
} else {
    Write-Host "No se encontraron usuarios en el departamento '$department'."
}
