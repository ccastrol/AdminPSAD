 <#
Autor: Carlos Castro Leon
Este script ejecuta cese de usuario. Uno a la vez.
#>
Importar el módulo de Active Directory
#Import-Module ActiveDirectory -SkipEditionCheck

# Solicitar el nombre de usuario a deshabilitar
$UserName = Read-Host "Ingrese el nombre de usuario que desea deshabilitar"

# Buscar el usuario en Active Directory
try {
    $User = Get-ADUser -Identity $UserName -ErrorAction Stop
} catch {
    Write-Host "No se encontró un usuario con el nombre '$UserName' en Active Directory." -ForegroundColor Red
    exit
}

# Mostrar la información del usuario encontrado
Write-Host "Usuario encontrado:" -ForegroundColor Green
Write-Host "Nombre completo: $($User.Name)"
Write-Host "Nombre de usuario (SamAccountName): $($User.SamAccountName)"
Write-Host "Estado de la cuenta: $($User.Enabled -replace 'True','Habilitada' -replace 'False','Deshabilitada')"
Write-Host "Ubicación actual: $($User.DistinguishedName)"
Write-Host ""

# Solicitar confirmación para proceder
$confirmation = Read-Host "¿Desea deshabilitar y mover este usuario a la OU de 'Usuarios Cesados'? (S/N)"

if ($confirmation.ToUpper() -eq 'S') {
    try {
        # Deshabilitar el usuario
        Disable-ADAccount -Identity $User
        Write-Host "El usuario '$UserName' ha sido deshabilitado." -ForegroundColor Yellow

        # Definir la OU de destino
        $TargetOU = "OU=USUARIOS-CESADOS,DC=ccastrol,DC=com"

        # Mover el usuario a la OU de usuarios cesados
        Move-ADObject -Identity $User.DistinguishedName -TargetPath $TargetOU
        Write-Host "El usuario '$UserName' ha sido movido a la OU 'Usuarios Cesados'." -ForegroundColor Yellow

    } catch {
        Write-Host "Ocurrió un error durante la operación: $_" -ForegroundColor Red
    }
} elseif ($confirmation.ToUpper() -eq 'N') {
    Write-Host "Operación cancelada por el usuario." -ForegroundColor Cyan
} else {
    Write-Host "Entrada no válida. Por favor, ejecute el script nuevamente y responda con 'S' o 'N'." -ForegroundColor Red
}
