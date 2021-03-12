$Computers = 'T800','EVILCORP-PC1'
$Query = ([xml](Get-Content .\LogonFailures.xml))

Invoke-Command -ComputerName $Computers -ArgumentList $Query -ScriptBlock {
    Get-WinEvent -FilterXml $args[0]
}
