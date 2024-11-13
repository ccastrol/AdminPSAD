<#
Autor: Carlos Castro Leon
Menú interactivo para realizar administración sobre el AD
#>
# Ruta del archivo TXT que contiene los SamAccountNames
$filePath = ".\bloqueo_usuarios.txt"

# Leer el archivo de texto:
$usuarios = Get-Content -Path $filePath

foreach ($user in $usuarios) {
    # Verificar si el usuario existe en AD
    $adUser = Get-ADUser -Identity $user -Properties * -ErrorAction SilentlyContinue
    
    if ($adUser) {
        # Confirmación antes de desactivar al usuario
        $confirmation = Read-Host "¿Deseas desactivar al usuario $($adUser.SamAccountName)? (S/N)"
        
        if ($confirmation -eq "S") {
            # Desactivar el usuario
            Disable-ADAccount -Identity $adUser.SamAccountName
            
            # Mover al usuario a la OU de desactivados
            Move-ADObject -Identity $adUser.DistinguishedName -TargetPath "OU=USUARIOS-INACTIVOS,DC=ccastrol,DC=com"
            
            # Agregar comentario de inactividad
            Set-ADUser -Identity $adUser.SamAccountName -Description "Desactivado por inactividad"

            # Notificación en la consola
            Write-Host "El usuario $($adUser.SamAccountName) ha sido desactivado y movido a USUARIOS-INACTIVOS."
        } else {
            Write-Host "El usuario $($adUser.SamAccountName) no fue desactivado."
        }
    } else {
        Write-Host "El usuario $user no fue encontrado en Active Directory."
    }
}
