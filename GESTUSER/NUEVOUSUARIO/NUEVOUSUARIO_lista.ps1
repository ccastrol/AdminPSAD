# Ruta al archivo CSV
$csvPath = ".\NuevoUser.csv"

# Importar el archivo CSV
$usuarios = Import-Csv -Path $csvPath

# Mostrar lista de usuarios a crear y confirmar
Write-Host "Se van a crear los siguientes usuarios:"
foreach ($usuario in $usuarios) {
    Write-Host "$($usuario.FirstName) $($usuario.LastName) - Username: $($usuario.UserName)"
}

# Solicitar confirmación
$confirmacion = Read-Host "¿Desea continuar con la creación de estos usuarios? (S/N)"
if ($confirmacion -ne 'S') {
    Write-Host "Operación cancelada por el usuario."
    exit
}

# Proceder con la creación de usuarios
foreach ($usuario in $usuarios) {
    # Convertir la contraseña en texto seguro
    $Password = ConvertTo-SecureString $usuario.Password -AsPlainText -Force

    # Convertir la fecha de vencimiento a formato DateTime
    $ExpirationDate = [datetime]::ParseExact($usuario.ExpirationDate, "yyyy-MM-dd", $null)

    # Crear el nombre completo del usuario
    $DisplayName = "$($usuario.FirstName) $($usuario.LastName)"

    # Preguntar si la contraseña será fija o temporal
    $tempPassword = Read-Host "¿La contraseña del usuario $($usuario.UserName) será fija o temporal? (Escriba 'T' para temporal o 'F' para fija)"

    # Definir si el usuario debe cambiar la contraseña al iniciar sesión
    $ChangePasswordAtLogon = if ($tempPassword -eq 'T') { $true } else { $false }

    # Parámetros del nuevo usuario en AD
    $userParams = @{
        Name                  = $DisplayName
        GivenName             = $usuario.FirstName
        Surname               = $usuario.LastName
        SamAccountName        = $usuario.UserName
        UserPrincipalName     = $usuario.Email
        EmailAddress          = $usuario.Email
        Path                  = $usuario.OU
        AccountPassword       = $Password
        Enabled               = $true
        ChangePasswordAtLogon = $ChangePasswordAtLogon
        DisplayName           = $DisplayName
        Description           = $usuario.Description
        Title                 = $usuario.JobTitle
        Department            = $usuario.Department
        Company               = $usuario.Company
        EmployeeNumber        = $usuario.EmployeeNumber
        EmployeeID            = $usuario.EmployeeID
        AccountExpirationDate = $ExpirationDate
    }

    # Intentar crear el usuario en AD
    try {
        New-ADUser @userParams -PassThru
        Write-Host "Usuario $($usuario.UserName) creado exitosamente en $($usuario.OU)"
    }
    catch {
        Write-Host "Error al crear el usuario $($usuario.UserName): $_"
    }
}
