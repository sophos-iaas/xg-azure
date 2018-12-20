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
$url="https://$storageaccount.blob.core.windows.net/xgbackup/xgbackup-payg-convert.tar$sastoken"

$licenseblock = @"
opcode lic_doactivate -s nosync -t json -b '{"serialkey": "$byollicense"}'
"@
$u2dpatternblock = @"
opcode u2d_check_pt_updates -ds nosync -t json -b '{"opcodetype": [ "2" ]}'
"@
$restoreblock1 = @"
curl -k -o /tmp/xgbackup-payg-convert.tar "$url"
"@
$restoreblock2 = @"
opcode upload_text_import_file -s nosync -t json -b '{"importtype":"2","importfile":"/tmp/xgbackup-payg-convert.tar"}'
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
    $SSHStream.WriteLine("$restoreblock1")
    Start-Sleep -s 5
    $SSHStream.WriteLine("$restoreblock2")
    Start-Sleep -s 500
    Start-Sleep -s 500
    $SSHStream.Read()  
    Remove-SSHSession -SessionId $session.SessionId > $null
}
Else {
    "Could not connect to XG"
    Get-SSHSession | Remove-SSHSession > $null
}