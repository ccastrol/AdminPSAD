<#
Autor: Carlos Castro Leon
Este script permite modificar datos de usuarios en AD.
#>
# Solicitar el nombre de usuario (sAMAccountName)
$username = Read-Host "Ingrese el nombre de usuario (sAMAccountName) que desea modificar"

# Obtener el usuario de AD con las propiedades necesarias
$user = Get-ADUser -Identity $username -Properties Department, MemberOf, EmailAddress, EmployeeID, EmployeeNumber

if ($user) {
    # Mostrar información actual del usuario
    Write-Host "Usuario: $($user.SamAccountName)"
    Write-Host "Departamento actual: $($user.Department)"
    Write-Host "Grupos actuales: $($user.MemberOf -join ', ')"
    Write-Host "Email actual: $($user.EmailAddress)"
    Write-Host "EmployeeID actual: $($user.EmployeeID)"
    Write-Host "EmployeeNumber actual: $($user.EmployeeNumber)"

    # Modificar el departamento
    $modificarDepartment = Read-Host "¿Desea modificar el departamento? (S/N)"
    if ($modificarDepartment -eq 'S') {
        $newDepartment = Read-Host "Ingrese el nuevo departamento"
        Set-ADUser -Identity $user.SamAccountName -Department $newDepartment
        Write-Host "Departamento actualizado a: $newDepartment"
    }

    # Modificar los grupos
    $modificarGrupo = Read-Host "¿Desea agregar o eliminar al usuario de un grupo? (S/N)"
    if ($modificarGrupo -eq 'S') {
        $accionGrupo = Read-Host "¿Desea agregar o eliminar? (escriba 'agregar' o 'eliminar')"
        $grupo = Read-Host "Ingrese el nombre del grupo"

        if ($accionGrupo -eq 'agregar') {
            Add-ADGroupMember -Identity $grupo -Members $user.SamAccountName
            Write-Host "Usuario $username agregado al grupo $grupo"
        }
        elseif ($accionGrupo -eq 'eliminar') {
            Remove-ADGroupMember -Identity $grupo -Members $user.SamAccountName -Confirm:$false
            Write-Host "Usuario $username eliminado del grupo $grupo"
        } else {
            Write-Host "Acción no válida. Por favor ingrese 'agregar' o 'eliminar'."
        }
    }

    # Modificar el email
    $modificarEmail = Read-Host "¿Desea modificar el email? (S/N)"
    if ($modificarEmail -eq 'S') {
        $newEmail = Read-Host "Ingrese el nuevo email"
        Set-ADUser -Identity $user.SamAccountName -EmailAddress $newEmail
        Write-Host "Email actualizado a: $newEmail"
    }

    # Modificar el EmployeeID
    $modificarEmployeeID = Read-Host "¿Desea modificar el EmployeeID? (S/N)"
    if ($modificarEmployeeID -eq 'S') {
        $newEmployeeID = Read-Host "Ingrese el nuevo EmployeeID"
        Set-ADUser -Identity $user.SamAccountName -EmployeeID $newEmployeeID
        Write-Host "EmployeeID actualizado a: $newEmployeeID"
    }

    # Modificar el EmployeeNumber
    $modificarEmployeeNumber = Read-Host "¿Desea modificar el EmployeeNumber? (S/N)"
    if ($modificarEmployeeNumber -eq 'S') {
        $newEmployeeNumber = Read-Host "Ingrese el nuevo EmployeeNumber"
        Set-ADUser -Identity $user.SamAccountName -EmployeeNumber $newEmployeeNumber
        Write-Host "EmployeeNumber actualizado a: $newEmployeeNumber"
    }

} else {
    Write-Host "Usuario no encontrado."
}
