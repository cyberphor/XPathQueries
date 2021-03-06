$Query = "
    *[System[(EventID=4624)]] and
    *[EventData[
        (Data[@Name='LogonType'] = '2' or Data[@Name='LogonType'] = '3') and
        Data[@Name='TargetUserSid'] != 'S-1-5-18' ]]
"

Get-WinEvent -LogName 'Security' -FilterXPath $Query
