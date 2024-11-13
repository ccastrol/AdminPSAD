$compu=Get-Content C:\Users\Administrador\SCRIPTS\pc_desactivar.txt
  
ForEach ($compu in $compu)  
  
{  
  
Set-ADComputer -Identity $compu -Enabled $false
Get-ADComputer -Identity "$compu" | Move-ADObject -TargetPath “OU=Disabled-Computers,DC=chimuasa,DC=com”
  
write-host "compu $($compu) has been disabled"  
  
}