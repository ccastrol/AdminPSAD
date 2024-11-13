$compu=Get-Content .\pc_desactivar.txt
  
ForEach ($compu in $compu)  
  
{  
  
Set-ADComputer -Identity $compu -Enabled $false
Get-ADComputer -Identity "$compu" | Move-ADObject -TargetPath “OU=Disabled-Computers,DC=ccastrol,DC=com”
  
write-host "compu $($compu) has been disabled"  
  
}
