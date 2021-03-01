## XPath Queries
These are XPath queries I'm collecting and using to parse Windows Event logs. Copy & paste them into a Custom View in Event Viewer. 

## How to Enable Specific Event Logs
### The Sexy Six (Event IDs 4688, 7045, 4624, 4663, 5156, 7040, 5140)
```cmd
auditpol /get /category:'*'
auditpol /set /subcategory:"Process Creation" /success:enable
auditpol /set /subcategory:"Logon" /success:enable /failue:enable
auditpol /set /subcategory:"File System" /success:enable
auditpol /set /subcategory:"Registry" /success:enable
auditpol /set /subcategory:"Filtering Platform Connection" /success:enable
auditpol /set /subcategory:"File Share" /success:enable
```

### Removable Media (Event ID 6416)
```cmd
auditpol /get /subcategory:"Plug and Play Events"
auditpol /set /subcategory:"Plug and Play Events" /success:enable
```

### Powershell (Event ID 4103, 4104)
```pwsh
$BlockLogging = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging' 
New-Item $BlockLogging
New-ItemProperty $BlockLogging -Name 'EnableBlockLogging' -PropertyType Dword
Set-ItemProperty $BlockLogging -Name 'EnableBlockLogging' -Value '1'

$ModuleLogging = 'HKLM:\Software\WOW6432Node\Policies\Microsoft\Windows\PowerShell\ModuleLogging'
New-Item $ModuleLogging
New-ItemProperty $ModuleLogging -Name 'EnableModuleLogging' -PropertyType Dword
Set-ItemProperty $ModuleLogging -Name 'EnableModuleLogging' -Value '1'
```

## References
* https://petri.com/query-xml-event-log-data-using-xpath-in-windows-server-2012-r2
* https://blog.backslasher.net/filtering-windows-event-log-using-xpath.html
* https://devblogs.microsoft.com/scripting/understanding-xml-and-xpath/
* https://www.malwarearchaeology.com/s/Windows-Advanced-Logging-Cheat-Sheet_ver_Feb_2019_v12.pdf
* https://www.malwarearchaeology.com/s/Windows-ATTCK_Logging-Cheat-Sheet_ver_Sept_2018.pdf
