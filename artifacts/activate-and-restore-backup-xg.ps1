Param
(
  [Parameter (Mandatory= $true)]
  [String] $byolxghostname,
  [Parameter (Mandatory= $true)]
  [String] $byolxgpassword,
  [Parameter (Mandatory= $true)]
  [String] $byolxgsshport,
  [Parameter (Mandatory= $true)]
  [String] $byollicense,
  [Parameter (Mandatory= $true)]
  [String] $storageaccount,
  [Parameter (Mandatory= $true)]
  [String] $sastoken
)
$secpassword = ConvertTo-SecureString $byolxgpassword -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ("admin", $secpassword)
$session = New-SSHSession -ComputerName $byolxghostname -Credential $creds -AcceptKey -Port $byolxgsshport
$SSHStream = New-SSHShellStream -SessionId $session.SessionId
$restoreblock1 = @"
xgbackupname="xgbackup-payg-convert"
"@
$restoreblock2 = @"
blobstorename="$storageaccount"
"@
$restoreblock3 = @"
containername="xgbackup"
"@
$restoreblock4 = @"
sastoken="$sastoken"
"@
$restoreblock5 = @"
url="https://${blobstorename}.blob.core.windows.net/${containername}/${xgbackupname}?${sastoken}"
"@
$restoreblock6 = @"
curl -k -o /tmp/${xgbackupname} $url
"@
$restoreblock7 = @"
opcode upload_restorefile -ds nosync -t json -b '{"restorebackupfile":"/tmp/xgbackup-payg-convert"}'
"@
$rebootblock = @"
opcode soft_reboot -ds nosync
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
    $SSHStream.WriteLine("$restoreblock1")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$restoreblock2")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$restoreblock3")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$restoreblock4")
    Start-Sleep -s 5
	$SSHStream.WriteLine("$restoreblock5")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$restoreblock6")
    Start-Sleep -s 3
	$SSHStream.WriteLine("$restoreblock7")
    Start-Sleep -s 3
	$SSHStream.WriteLine("$rebootblock")
    Start-Sleep -s 5
    $SSHStream.Read()  
    Remove-SSHSession -SessionId $session.SessionId > $null
}
Else {
    "Could not connect to XG"
    Get-SSHSession | Remove-SSHSession > $null
}