<#
Autor: Carlos Castro Leon
Menú interactivo para realizar administración sobre el AD
#>
# Menú de Aplicación en PowerShell
function Show-Menu {
    Clear-Host
    Write-Host "=============================="
    Write-Host "        MENÚ PRINCIPAL         "
    Write-Host "=============================="
    
    # Definir opciones para Gestión de Usuarios
    $userOptions = @"
    1. Crear un nuevo usuario                   9. Lista de usuarios AD
    2. Deshabilitar y mover usuario cesado     10. Lista de usuarios no logeados
    3. Purgar usuarios cesados                 11. Lista de usuarios inactivos
    4. Cambio de Contraseña de usuario         12. Programar vacaciones por usuario
    5. Consulta estado usuario                 13. Deshabilitar usuarios por lotes
    6. Habilitar Usuario                       14. Consulta usuario por apellido
    7. Modificar usuario                       15. Listar usuario por CECOS
    8. Modificar CECOS por usuario masivo

"@

    # Definir opciones para Gestión de Equipos
    $deviceOptions = @"
    21. Listar equipos inactivos               23. Lista equipos por departamento
    22. Modificar información masiva equipos   24. Desactivar equipos inactivos
"@

    # Imprimir ambas columnas
    Write-Host "GESTIÓN DE USUARIOS" -ForegroundColor Yellow
    Write-Host $userOptions

    Write-Host "GESTIÓN DE EQUIPOS" -ForegroundColor Yellow
    Write-Host $deviceOptions

    Write-Host "30. Salir" -ForegroundColor Cyan
    Write-Host "=============================="
}

function Run-Option1 {
    Write-Host "Ejecutando la opción 1: Crear un nuevo usuario"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\NUEVOUSUARIO\NUEVOUSUARIO_lista.ps1
    Pause
}

function Run-Option2 {
    Write-Host "Ejecutando la opción 2: Deshabilitar y mover usuario cesado"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\CESADOS.ps1
    Pause
}

function Run-Option3 {
    Write-Host "Ejecutando la opción 3: Purgar usuarios cesados"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\CESADOS\PURGACESADOS.ps1
    Pause
}

function Run-Option4 {
    Write-Host "Ejecutando la opción 4: Cambio de Contraseña de usuario"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\CAMBIOPASSWD.ps1
    Pause
}

function Run-Option5 {
    Write-Host "Ejecutando la opción 5: Consulta estado usuario"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\CONSULTAUSER.ps1
    Pause
}

function Run-Option6 {
    Write-Host "Ejecutando la opción 6: Habilitar Usuario"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\HABILITARUSER.ps1
    Pause
}

function Run-Option7 {
    Write-Host "Ejecutando la opción 7: Modificar usuario"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\MODIFICARUSER.ps1
    Pause
}

function Run-Option8 {
    Write-Host "Ejecutando la opción 15: Modificar CECOS usuarios masivo"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\MASIVODEPARTAMENTO.ps1
    Pause
}

function Run-Option9 {
    Write-Host "Ejecutando la opción 9: Lista de usuarios AD"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\LISTAUSER.ps1
    Pause
}

function Run-Option10 {
    Write-Host "Ejecutando la opción 10: Lista de usuarios no logeados"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\LISTANOLOGIN.ps1
    Pause
}

function Run-Option11 {
    Write-Host "Ejecutando la opción 11: Lista de usuarios inactivos"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\LISTAUSERINACTIVO.ps1
    Pause
}

function Run-Option12 {
    Write-Host "Ejecutando la opción 12: Programar vacaciones por usuario"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\VACACIONES.ps1
    Pause
}
function Run-Option13 {
    Write-Host "Ejecutando la opción 13: Deshabilitar usuarios por lotes"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\bloqueo_usuarios.ps1
    Pause
}
function Run-Option14 {
    Write-Host "Ejecutando la opción 14: Consultar usuario por apellido"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\consultauser2.ps1
    Pause
}
function Run-Option15 {
    Write-Host "Ejecutando la opción 15:  Listar usuarios por CECOS"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTUSER\USUARIOSCECOS.ps1
    Pause
}
function Run-Option21 {
    Write-Host "Ejecutando la opción 21:  Listar de equipos inactivos"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTEQUIPOS\EQUIPOSINACTIVOS.ps1
    Pause
}
function Run-Option24 {
    Write-Host "Ejecutando la opción 24:  Desactivar equipos inactivos"
    # Coloca aquí el código del script o invoca un archivo .ps1 con el script.
    .\GESTEQUIPOS\Disable_computerslist.ps1
    Pause
}



function Main {
    do {
        Show-Menu
        $choice = Read-Host "Seleccione una opción"

        switch ($choice) {
            1 { Run-Option1 }
            2 { Run-Option2 }
            3 { Run-Option3 }
            4 { Run-Option4 }
            5 { Run-Option5 }
            6 { Run-Option6 }
            7 { Run-Option7 }
            8 { Run-Option8 }
            9 { Run-Option9 }
            10 { Run-Option10 }
            11 { Run-Option11 }
            12 { Run-Option12 }
            13 { Run-Option13 }
            14 { Run-Option14 }
            15 { Run-Option15 }
	    16 { Run-Option16 }
	    17 { Run-Option17 }
	    18 { Run-Option18 }
	    19 { Run-Option19 }
	    30 { Write-Host "Saliendo..."; exit }
            default { Write-Host "Opción no válida, intente de nuevo." -ForegroundColor Red }
        }
    } while ($choice -ne 30)
}

# Ejecutar la función principal
Main
