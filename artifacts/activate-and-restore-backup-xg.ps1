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
$url="https://$storageaccount.blob.core.windows.net/xgbackup/xgbackup-payg-convert$sastoken"

$licenseblock = @"
opcode lic_doactivate -s nosync -t json -b '{"serialkey": "$byollicense"}'
"@
$u2dpatternblock = @"
opcode u2d_check_pt_updates -ds nosync -t json -b '{"opcodetype": [ "2" ]}'
"@
$restoreblock1 = @"
curl -k -o /tmp/xgbackup-payg-convert "$url"
"@
$restoreblock2 = @"
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
    $SSHStream.WriteLine("$licenseblock")
    Start-Sleep -s 10
    $SSHStream.WriteLine("$u2dpatternblock")
    Start-Sleep -s 300
    $SSHStream.WriteLine("$restoreblock1")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$u2dpatternblock")
    Start-Sleep -s 300
    $SSHStream.WriteLine("$restoreblock2")
    Start-Sleep -s 5
	$SSHStream.WriteLine("$rebootblock")
    Start-Sleep -s 5
    $SSHStream.Read()  
    Remove-SSHSession -SessionId $session.SessionId > $null
}
Else {
    "Could not connect to XG"
    Get-SSHSession | Remove-SSHSession > $null
}