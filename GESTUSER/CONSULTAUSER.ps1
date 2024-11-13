<#
Autor: Carlos Castro Leon
Script para obtener detalles de un usuario buscando por su nombre de usuario.
#>
# Solicitar el nombre de usuario que deseas verificar
$user = Read-Host "Ingrese el nombre de usuario que desea consultar"

# Obtener los detalles del usuario, incluyendo los intentos fallidos y el departamento
$userDetails = Get-ADUser -Identity $user -Properties BadPwdCount, Department, Company, mail

# Mostrar la cantidad de intentos fallidos y el departamento del usuario
Write-Host "El usuario $user tiene $($userDetails.BadPwdCount) intentos fallidos de inicio de sesión."
Write-Host "El usuario $user pertenece al departamento: $($userDetails.Department)"
Write-Host "El usuario $user pertenece a la empresa: $($userDetails.Company)"
Write-Host "El usuario $user con e-mail: $($userDetails.mail)"

# Usar el comando Net User para mostrar más detalles del usuario
Net user $user
