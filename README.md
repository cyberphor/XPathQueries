## XPath Queries
These are XPath queries I'm collecting and using to parse Windows Event logs. Copy & paste them into a Custom View in Event Viewer. 

## How to Enable Specific Event Logs
### The Sexy Six (Event IDs 4688, 7045, 4624, 4663, 5156, 7040, 5140)
```cmd
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

## References
* https://petri.com/query-xml-event-log-data-using-xpath-in-windows-server-2012-r2
* https://blog.backslasher.net/filtering-windows-event-log-using-xpath.html
* https://devblogs.microsoft.com/scripting/understanding-xml-and-xpath/
* https://www.malwarearchaeology.com/s/Windows-Advanced-Logging-Cheat-Sheet_ver_Feb_2019_v12.pdf
* https://www.malwarearchaeology.com/s/Windows-ATTCK_Logging-Cheat-Sheet_ver_Sept_2018.pdf
