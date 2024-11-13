<#
Autor: Carlos Castro Leon
Este script programa vacaciones de usuario usando el task manager de windows
#>
#Import-Module ScheduledTasks -SkipEditionCheck
# Solicitar el nombre de usuario
$username = Read-Host "Ingrese el nombre de usuario (sAMAccountName)"

# Solicitar la fecha de inicio y finalización de las vacaciones
$startDate = Read-Host "Ingrese la fecha de inicio de las vacaciones (dd/MM/yyyy)"
$endDate = Read-Host "Ingrese la fecha de finalización de las vacaciones (dd/MM/yyyy)"

# Convertir las fechas a formato [datetime]
$startDate = [datetime]::ParseExact($startDate, 'dd/MM/yyyy', $null)
$endDate = [datetime]::ParseExact($endDate, 'dd/MM/yyyy', $null)

# Definir la acción para deshabilitar la cuenta
$disableAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-command `"Disable-ADAccount -Identity $username; Write-Host 'La cuenta $username ha sido deshabilitada.'`""

# Crear la tarea programada para deshabilitar la cuenta en la fecha de inicio
Register-ScheduledTask -Action $disableAction -Trigger (New-ScheduledTaskTrigger -Once -At $startDate) -TaskName "DisableAccount-$username" -Description "Deshabilitar cuenta de $username por vacaciones"

# Definir la acción para habilitar la cuenta
$enableAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-command `"Enable-ADAccount -Identity $username; Write-Host 'La cuenta $username ha sido habilitada.'`""

# Crear la tarea programada para habilitar la cuenta un día después de la fecha de finalización
Register-ScheduledTask -Action $enableAction -Trigger (New-ScheduledTaskTrigger -Once -At $endDate.AddDays(1)) -TaskName "EnableAccount-$username" -Description "Habilitar cuenta de $username después de las vacaciones"
