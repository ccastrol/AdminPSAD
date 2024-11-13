# Reemplaza 'username' con el nombre del usuario
$user = Read-Host "Ingrese el nombre de usuario que desea cambiar contraseña"

# Validar si el usuario existe en Active Directory
$userDetails = Get-ADUser -Identity $user -ErrorAction SilentlyContinue

if ($null -eq $userDetails) {
    Write-Host "Usuario ingresado no existe." -ForegroundColor Red
    exit
}

# Solicitar la nueva contraseña
$newPassword = Read-Host -AsSecureString "Introduce la nueva contraseña para el usuario $user"

# Preguntar si el usuario debe cambiar la contraseña al siguiente inicio de sesión
$changePasswordNextLogon = Read-Host "¿Deseas que el usuario deba cambiar la contraseña al siguiente inicio de sesión? (S/N)"

# Cambiar la contraseña del usuario
Set-ADAccountPassword -Identity $user -NewPassword $newPassword -Reset

# Configurar el cambio de contraseña en el próximo inicio de sesión si se selecciona 'Sí'
if ($changePasswordNextLogon -eq "S" -or $changePasswordNextLogon -eq "s") {
    Set-ADUser -Identity $user -ChangePasswordAtLogon $true
    Write-Host "El usuario $user deberá cambiar la contraseña en el próximo inicio de sesión."
} else {
    Write-Host "El usuario $user no tendrá que cambiar la contraseña en el próximo inicio de sesión."
}

Write-Host "La contraseña del usuario $user ha sido cambiada exitosamente."
