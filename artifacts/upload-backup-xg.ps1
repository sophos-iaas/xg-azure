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
$backupblock1 = @"
opcode system_backup_now -ds nosync -t json -b '{"mailloginterval": "-1", "sendtype": "7", "prefix": "current_PAYG_Backup"}'
"@
$backupblock2 = @"
xgbackup=$(ls /sdisk/conf/backupdata/ | grep Backup)
"@
$backupblock3 = @"
cp /sdisk/conf/backupdata/${xgbackup} /tmp/xgbackup-payg-convert
"@
$backupblock4 = @"
xgbackupname="xgbackup-payg-convert"
"@
$backupblock5 = @"
blobstorename="$storageaccount"
"@
$backupblock6 = @"
containername="xgbackup"
"@
$backupblock7 = @"
sastoken="$sastoken"
"@
$backupblock8 = @"
url="https://${blobstorename}.blob.core.windows.net/${containername}/${xgbackupname}?${sastoken}"
"@
$backupblock9 = @"
curl -k -X PUT -T /sdisk/conf/backupdata/$xgbackup -H "x-ms-date: $(date -u)" -H "x-ms-blob-type: BlockBlob" $url
"@
If ($session.Connected) {
    Start-Sleep -s 10
	$SSHStream.WriteLine("a")
    Start-Sleep -s 5
	$SSHStream.WriteLine(" ")
	$SSHStream.WriteLine(" ")
	Start-Sleep -s 5
	$SSHStream.WriteLine("5")
    Start-Sleep -s 5
    $SSHStream.WriteLine("3")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$backupblock1")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$backupblock2")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$backupblock3")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$backupblock4")
    Start-Sleep -s 5
	$SSHStream.WriteLine("$backupblock5")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$backupblock6")
    Start-Sleep -s 3
	$SSHStream.WriteLine("$backupblock7")
    Start-Sleep -s 3
	$SSHStream.WriteLine("$backupblock8")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$backupblock9")
    Start-Sleep -s 2
    $SSHStream.Read()  
    Remove-SSHSession -SessionId $session.SessionId > $null
}
Else {
    "Could not connect to XG"
    Get-SSHSession | Remove-SSHSession > $null
}