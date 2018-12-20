Param
(
  [Parameter (Mandatory= $true)]
  [String] $paygxgip,
  [Parameter (Mandatory= $true)]
  [String] $paygxgpassword,
  [Parameter (Mandatory= $true)]
  [String] $paygxgsshport,
  [Parameter (Mandatory= $true)]
  [String] $storageaccount,
  [Parameter (Mandatory= $true)]
  [String] $sastoken
)
$secpassword = ConvertTo-SecureString $paygxgpassword -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ("admin", $secpassword)
$session = New-SSHSession -ComputerName $paygxgip -Credential $creds -AcceptKey -Port $paygxgsshport
$SSHStream = New-SSHShellStream -SessionId $session.SessionId
$url="https://$storageaccount.blob.core.windows.net/xgbackup/xgbackup-payg-convert.tar$sastoken"
$xmsdate = Get-Date
$xmsdate = $xmsdate.ToUniversalTime()
$xmsdate = $xmsdate.toString('R')

$backupblock1 = @"
opcode apiExport -s nosync -t json -b '{"FullExport":"true"}'
"@
$backupblock2 = @"
curl -k -X PUT -T /tmp/xgbackup-payg-convert.tar -H "x-ms-date: $xmsdate" -H "x-ms-blob-type: BlockBlob" "$url"
"@
If ($session.Connected) {
    Start-Sleep -s 10
	$SSHStream.WriteLine("5")
    Start-Sleep -s 5
    $SSHStream.WriteLine("3")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$backupblock1")
    Start-Sleep -s 200
    $SSHStream.WriteLine("cp /sdisk/*.tar /tmp/xgbackup-payg-convert.tar")
    Start-Sleep -s 5
	$SSHStream.WriteLine("$backupblock2")
    Start-Sleep -s 5
    $SSHStream.Read()  
    Remove-SSHSession -SessionId $session.SessionId > $null
}
Else {
    "Could not connect to XG"
    Get-SSHSession | Remove-SSHSession > $null
}