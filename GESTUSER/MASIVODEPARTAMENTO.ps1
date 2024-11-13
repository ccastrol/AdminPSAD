<#
Autor: Carlos Castro Leon
Este script busca un fichero CSV para luego modificar o agregar un departamente por cada usuario en la lista.
#>
# Ruta del archivo CSV con la lista de usuarios y sus nuevos departamentos
$csvPath = "C:\Users\Administrador\SCRIPTS\usuarios_departamentos.csv"

# Leer el archivo CSV (debe contener dos columnas: SamAccountName y Department)
$usuarios = Import-Csv -Path $csvPath

# Iterar sobre cada usuario en el archivo CSV
foreach ($usuario in $usuarios) {
    # Obtener el usuario por su SamAccountName
    $adUser = Get-ADUser -Identity $usuario.SamAccountName
    
    # Verificar si se encuentra el usuario
    if ($adUser) {
        # Modificar el campo Department
        Set-ADUser -Identity $adUser.SamAccountName -Department $usuario.Department
        Write-Host "El usuario $($adUser.SamAccountName) ha sido actualizado con el nuevo departamento: $($usuario.Department)"
    } else {
        Write-Host "No se encontró el usuario $($usuario.SamAccountName)."
    }
}
