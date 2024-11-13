<#
Autor: Carlos Castro Leon
Script para habilitar usuarios que previamente fueron deshabilitado
#>
# Solicitar el nombre de usuario
$username = Read-Host "Ingrese el nombre de usuario (sAMAccountName)"

# Verificar si el usuario existe y está deshabilitado
$user = Get-ADUser -Identity $username -Properties Enabled

if ($user) {
    if ($user.Enabled -eq $false) {
        # Habilitar el usuario
        Enable-ADAccount -Identity $username
        Write-Host "La cuenta $username ha sido habilitada correctamente."
    } else {
        Write-Host "La cuenta $username ya estaba habilitada."
    }
} else {
    Write-Host "No se encontró ningún usuario con el nombre $username."
}
