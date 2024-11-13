<#
Autor: Carlos Castro Leon
Este script busca un fichero CSV para luego modificar o agregar el campo e-mail por cada usuario en la lista.
#>
# Ruta del archivo CSV con la lista de usuarios y sus nuevos correos
$csvPath = "C:\Users\Administrador\SCRIPTS\masivo_mail.csv"

# Leer el archivo CSV (debe contener dos columnas: SamAccountName y Mail)
$usuarios = Import-Csv -Path $csvPath

# Iterar sobre cada usuario en el archivo CSV
foreach ($usuario in $usuarios) {
    # Obtener el usuario por su SamAccountName
    $adUser = Get-ADUser -Identity $usuario.SamAccountName
    
    # Verificar si se encuentra el usuario
    if ($adUser) {
        # Modificar el campo Mail
        Set-ADUser -Identity $adUser.SamAccountName -EmailAddress $usuario.Mail
        Write-Host "El usuario $($adUser.SamAccountName) ha sido actualizado con el nuevo correo: $($usuario.Mail)"
    } else {
        Write-Host "No se encontró el usuario $($usuario.SamAccountName)."
    }
}
