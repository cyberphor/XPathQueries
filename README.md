## XPath Queries
These are XPath queries and Event Subscriptions I'm compiling to filter, collect, and parse Windows Event logs. Copy & paste the XPath queries into a Custom View in Event Viewer or PowerShell. Copy & paste the subscriptions into a file on your Windows Event Collector and run `wecutil` to publish it. For example, if the name of your subscription file is `AppLocker.xml` you would type `wecutil cs AppLocker.xml`. 

## Table of Contents
* [How to Enable Specific Event Logs](#how-to-enable-specific-event-logs)
  * [The Sexy Six](#the-sexy-six)
  * [Removable Media](#removable-media)
  * [PowerShell](#powershell)
  * [DNS](#dns)
* [Troubleshooting Windows Event Forwarding](#troubleshooting-windows-event-forwarding)
* [References](#references)

## How to Enable Specific Event Logs
### The Sexy Six
Event IDs: 4624, 4663, 4688, 5140, 5156, 7040, 7045
```cmd
auditpol /get /category:'*'
auditpol /set /subcategory:"Logon" /success:enable /failue:enable
auditpol /set /subcategory:"File System" /success:enable
auditpol /set /subcategory:"Process Creation" /success:enable
auditpol /set /subcategory:"File Share" /success:enable
auditpol /set /subcategory:"Registry" /success:enable
auditpol /set /subcategory:"Filtering Platform Connection" /success:enable
```

### Removable Media
Event IDs: 6416
```cmd
auditpol /get /subcategory:"Plug and Play Events"
auditpol /set /subcategory:"Plug and Play Events" /success:enable
```

### Powershell
Event IDs: 4103, 4104
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

### DNS
Event IDs: 3006
```pwsh
wevtutil sl Microsoft-Windows-DNS-Client/Operational /e:true
```

## Troubleshooting Windows Event Forwarding
Verify routing between the client and WEC (Windows Event Collection) server.
```pwsh
ping <WEC_server_IP_address> # from client
```

Verify the WEC server is listening on TCP port 5985.
```pwsh
netstat | findstr 5985 # from WEC server
Test-NetConnection -Port 5985 <WEC_server_IP_address> # from client
```

Verify the client can resolve the hostname of the WEC server.
```pwsh
nslookup <WEC_server_hostname> # from client
```

In your Windows Event Forwarding GPO, verify the “Subscription Manager” matches the WEC server’s hostname. For example, if the hostname of your WEC server is `razorcrest`, then your "Subscription Manager" should be configured like this: `Server=http://razorcrest:5985/wsman/SubscriptionManager/WEC`.

## References
* https://apps.nsa.gov/iad/library/reports/spotting-the-adversary-with-windows-event-log-monitoring.cfm
* https://conf.splunk.com/session/2015/conf2015_MGough_MalwareArchaelogy_SecurityCompliance_FindingAdvnacedAttacksAnd.pdf
* https://www.malwarearchaeology.com/s/Windows-Advanced-Logging-Cheat-Sheet_ver_Feb_2019_v12.pdf
* https://www.malwarearchaeology.com/s/Windows-ATTCK_Logging-Cheat-Sheet_ver_Sept_2018.pdf
* https://medium.com/palantir/windows-event-forwarding-for-network-defense-cb208d5ff86f
* https://petri.com/query-xml-event-log-data-using-xpath-in-windows-server-2012-r2
* https://blog.backslasher.net/filtering-windows-event-log-using-xpath.html
* https://devblogs.microsoft.com/scripting/understanding-xml-and-xpath/
